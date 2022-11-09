import { CACHE_MANAGER, HttpException, HttpStatus, Inject, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectConnection, InjectRepository } from '@nestjs/typeorm';
import * as bcrypt from 'bcrypt';
import { hash } from 'bcrypt';
import { Cache } from 'cache-manager';
import { plainToClass } from 'class-transformer';
import { UserEntity } from 'src/models/entities/users.entity';
import { UserRepository } from 'src/models/repositories/user.repository';
import { jwtConstants } from 'src/modules/auth/constants';
import { MailService } from 'src/modules/mail/mail.service';
import { Role } from 'src/modules/roles/enums/role.enum';
import { ChangePassDto } from 'src/modules/users/dto/change-pass.dto';
import { CreateUserDto } from 'src/modules/users/dto/create-user.dto';
import { UserLockStatus, UserStatus } from 'src/modules/users/enums/user-status.enum';
import { VerifyAddress } from 'src/modules/users/helper/verify-address';
import { FORBIDDEN } from 'src/shares/constants/httpExceptionSubCode.constant';
import { genRandomSixDigit } from 'src/shares/helpers/utils';
import { Connection, UpdateResult } from 'typeorm';
// eslint-disable-next-line @typescript-eslint/no-var-requires
const requestIp = require('request-ip');

const verifyEmailTokenConfig = {
  expiresIn: jwtConstants.verifyEmailTokenExpiry,
  secret: jwtConstants.verifyEmailTokenSecret,
};

@Injectable()
export class UsersService {
  private ACTIVE_TOKEN_TTL = 60 * 15;
  private EXPIRE_RESET_PASS_TOKEN_SECONDS = 60 * 30;

  constructor(
    @InjectRepository(UserRepository, 'master')
    private usersRepository: UserRepository,
    @InjectRepository(UserRepository, 'report')
    private usersRepositoryReport: UserRepository,
    @Inject(CACHE_MANAGER) private cacheService: Cache,
    @InjectConnection('master')
    private connection: Connection,
    private jwtService: JwtService,
    private readonly mailService: MailService,
  ) {}

  async findOne(id: { id: string | number }): Promise<UserEntity> {
    // const rs = await this.usersRepositoryReport.findOne(id);
    const rs = await this.usersRepositoryReport
      .createQueryBuilder('users')
      .select('*')
      .where('users.id = :id', id)
      .getRawOne();
    if (!rs) {
      throw new HttpException({ key: 'user.NOT_EXISTS' }, HttpStatus.BAD_REQUEST);
    }

    return {
      ...rs,
      locked: rs.isLocked,
    };
  }

  findUserByEmail(email: string): Promise<UserEntity> {
    return this.usersRepositoryReport.findOne({
      where: {
        email: email,
      },
    });
  }

  async findUserByEmailOptions(options: {
    status?: UserStatus;
    email: string;
    isLocked?: UserLockStatus;
  }): Promise<UserEntity> {
    if (!options.status) options.status = UserStatus.Active;
    if (!options.isLocked) options.isLocked = UserLockStatus.Unlocked;

    const user = await this.usersRepositoryReport.findOne({
      where: {
        email: options.email,
      },
    });

    if (!user || user.status === UserStatus.Deactive) {
      throw new HttpException({ key: 'user.NOT_EXISTS', code: FORBIDDEN.WRONG_EMAIL }, HttpStatus.FORBIDDEN);
    }

    if (user.status === options.status && user.locked === options.isLocked) return user;

    // Not as expected stats
    if (options.status === UserStatus.Submit) {
      throw new HttpException({ key: 'user.USER_EMAIL_VERIFIED' }, HttpStatus.NOT_ACCEPTABLE);
    }

    if (user.status === UserStatus.Submit) {
      throw new HttpException(
        { key: 'user.USER_EMAIL_NOT_VERIFIED', code: FORBIDDEN.USER_EMAIL_NOT_VERIFIED },
        HttpStatus.FORBIDDEN,
      );
    }

    if (user.status === UserStatus.PendingActive) {
      throw new HttpException({ key: 'user.USER_NOT_ACTIVE', code: FORBIDDEN.USER_NOT_ACTIVE }, HttpStatus.FORBIDDEN);
    }

    //
    if (user.locked == UserLockStatus.Locked) {
      throw new HttpException({ key: 'user.USER_DEACTIVE', code: FORBIDDEN.USER_DEACTIVE }, HttpStatus.FORBIDDEN);
    }
  }

  async remove(id: string): Promise<void> {
    await this.usersRepository.delete(id);
  }

  create(userDto: CreateUserDto): Promise<UserEntity> {
    // in transaction
    const userEntity = plainToClass(UserEntity, userDto);
    userEntity.status = UserStatus.PendingActive;
    const user = this.usersRepository.create(userEntity);
    return this.usersRepository.save(user);
  }

  async changeUserStatus(userIds: number[], status: number): Promise<UpdateResult> {
    return this.usersRepository
      .createQueryBuilder('users')
      .update(UserEntity)
      .set({ status: status })
      .whereInIds({ id: userIds })
      .execute();
  }

  async changeUserType(userIds: number[], type: number): Promise<UpdateResult> {
    return this.usersRepository
      .createQueryBuilder('users')
      .update(UserEntity)
      .set({ userType: type })
      .whereInIds({ id: userIds })
      .execute();
  }

  async generateActiveToken(userId: number): Promise<string> {
    const payload = { userId };
    const token = await hash(JSON.stringify(payload), 1);
    // save to redis
    await this.cacheService.set(token.toString(), payload, { ttl: this.ACTIVE_TOKEN_TTL });
    return token;
  }

  async generateResetPasswordToken(email: string): Promise<number> {
    const token = genRandomSixDigit();
    const user = await this.findUserByEmailOptions({ email });

    const isAdmin = [Role.Admin, Role.SuperAdmin].includes(user.role);
    if (isAdmin && user.isFirstLogin) {
      throw new HttpException(
        { key: 'admin.ADMIN_NOT_CHANGED_DEFAULT_PASSWORD', code: FORBIDDEN.ADMIN_NOT_CHANGED_DEFAULT_PASSWORD },
        HttpStatus.FORBIDDEN,
      );
    }

    user.tokenResetPassword = token;
    user.expire = new Date();
    user.expire.setSeconds(user.expire.getSeconds() + this.EXPIRE_RESET_PASS_TOKEN_SECONDS);

    await this.usersRepository.save({
      id: user.id,
      expire: user.expire,
      tokenResetPassword: user.tokenResetPassword,
    });
    return token;
  }

  async checkPassToken(email: string, tokenResetPassword: string): Promise<boolean> {
    if (!tokenResetPassword) {
      throw new HttpException({ key: 'user.INVALID_tokenResetPassword' }, HttpStatus.BAD_REQUEST);
    }

    const user = await this.findUserByEmailOptions({ email });

    const isExpired = user.expire.getTime() < new Date().getTime();

    return !isExpired && Number(tokenResetPassword) === Number(user.tokenResetPassword);
  }

  async updatePassword(email: string, password: string): Promise<boolean> {
    try {
      const user = await this.findUserByEmailOptions({ email });

      user.password = await bcrypt.hash(password, jwtConstants.saltRound);
      user.tokenResetPassword = null;
      await this.usersRepository.save(user);
    } catch (err) {
      if (err.status === 400) throw err;
      return false;
    }
    return true;
  }

  async setFirstLogin(id: number, isFirstLogin: boolean): Promise<void> {
    await this.usersRepository.update(id, {
      isFirstLogin,
    });
  }

  async changePassword(changePassDto: ChangePassDto, userId: number): Promise<boolean> {
    const user = await this.findOne({ id: userId });
    const correctPass = await bcrypt.compare(changePassDto.currentPassword, user.password);
    if (!correctPass) {
      throw new HttpException({ key: 'user.INVALID_PASSWORD' }, HttpStatus.NOT_ACCEPTABLE);
    }

    user.password = await bcrypt.hash(changePassDto.newPassword, jwtConstants.saltRound);
    user.tokenResetPassword = null;
    await this.usersRepository.save(user);

    return true;
  }
  async findUserById(id: number): Promise<UserEntity> {
    return this.usersRepositoryReport.findOne(id);
  }

  async getUserByWalletAccount(address: string): Promise<UserEntity> {
    return this.usersRepositoryReport.findOne({
      select: ['id'],
      where: {
        address: address,
      },
    });
  }

  async getProfile(req, userId: number): Promise<unknown> {
    const user = await this.findUserById(userId);
    const ip = requestIp.getClientIp(req);
    const last_login = await this.usersRepositoryReport.getLastLogin(user.id);

    return {
      id: user.id,
      email: user.email,
      company: user.company,
      fullname: user.fullname,
      phone: user.phone,
      // velo_account: user.velo_account,
      role: user.role,
      createdAt: user.createdAt,
      IP: ip,
      last_login: last_login?.last_login ? last_login?.last_login : user.createdAt,
      address: user.address,
    };
  }

  async createUser(userDto: CreateUserDto, validate = true): Promise<void> {
    const { message, address, password } = userDto;
    if (!validate) {
      try {
        const sameAddress = await VerifyAddress.checkRecoverSameAddress(address, password, message);
        if (!sameAddress) {
          throw new HttpException({ key: 'user-wallet.WRONG_SIGNATURE' }, HttpStatus.BAD_REQUEST);
        }
      } catch (err) {
        throw new HttpException({ key: 'user-wallet.WRONG_SIGNATURE' }, HttpStatus.BAD_REQUEST);
      }
    }

    const userEntity = plainToClass(UserEntity, userDto, { excludeExtraneousValues: true });
    userEntity.status = UserStatus.Active;
    userEntity.role = Role.User;
    await this.usersRepository.save(userEntity);
  }

  private async validateUserWallets(wallets: string[]): Promise<void> {
    wallets;
  }

  async unlock(userId: number): Promise<boolean> {
    const user = await this.usersRepositoryReport.findOne({
      select: ['locked'],
      where: {
        id: userId,
      },
    });
    if (user.locked == UserLockStatus.Unlocked) return true;

    try {
      await this.usersRepository
        .createQueryBuilder()
        .update()
        .set({ locked: UserLockStatus.Unlocked })
        .where('id = :id', { id: userId })
        .execute();
    } catch {
      return false;
    }

    return true;
  }

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  async decodeJWTVerifyToken(token: string): Promise<any> {
    let verifyEmailTokenDecode;
    try {
      verifyEmailTokenDecode = await this.jwtService.verify(token, verifyEmailTokenConfig);
    } catch (e) {
      if (e.name === 'TokenExpiredError') {
        throw new HttpException(
          { key: 'user.EMAIL_VERIFY_EXPIRE', code: FORBIDDEN.EMAIL_VERIFY_EXPIRE },
          HttpStatus.FORBIDDEN,
        );
      } else {
        throw new HttpException(
          { key: 'user.INVALID_TOKEN', code: FORBIDDEN.EMAIL_VERIFY_FAILD },
          HttpStatus.FORBIDDEN,
        );
      }
    }

    return verifyEmailTokenDecode;
  }

  async getVerifyEmailToken(email: string): Promise<string> {
    const user = await this.findUserByEmailOptions({ status: UserStatus.Submit, email });

    const payload = { sub: user.id };
    return this.jwtService.sign(payload, verifyEmailTokenConfig);
  }

  async lock(userId: number): Promise<boolean> {
    const user = await this.usersRepositoryReport.findOne(userId);
    if (user.locked == UserLockStatus.Locked) return true;

    try {
      await this.usersRepository
        .createQueryBuilder()
        .update()
        .set({ locked: UserLockStatus.Locked })
        .where('id = :id', { id: userId })
        .execute();
    } catch {
      return false;
    }

    return true;
  }

  async checkUserId(usersId: number[]): Promise<UserEntity[]> {
    const rs = await this.usersRepositoryReport.findByIds(usersId);
    if (rs.length !== usersId.length) {
      throw new HttpException({ key: 'user.NOT_EXISTS' }, HttpStatus.BAD_REQUEST);
    }
    return rs;
  }

  // update status user registration
  async updateStatusUserRegistration({
    usersId,
    status,
  }: {
    usersId: number[];
    status: number;
  }): Promise<Partial<UserEntity[]>> {
    const users: UserEntity[] = await this.checkUserId(usersId);
    users.forEach((user: UserEntity) => {
      if (status === UserStatus.Active) this.mailService.sendApproveUserEmailJob(user.email);
      if (status === UserStatus.Deactive) this.mailService.sendRejectUserEmailJob(user.email);
    });
    await this.usersRepository
      .createQueryBuilder()
      .update(UserEntity)
      .set({ status })
      .where('users.id IN (:...usersId)', { usersId })
      .execute();
    return this.checkUserId(usersId);
  }
}
