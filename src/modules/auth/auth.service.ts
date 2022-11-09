// eslint-disable-next-line @typescript-eslint/no-var-requires
const requestIp = require('request-ip');
// eslint-disable-next-line @typescript-eslint/no-var-requires
const FormData = require('form-data');
// eslint-disable-next-line @typescript-eslint/no-var-requires
const axios = require('axios');
import { CACHE_MANAGER, HttpException, HttpStatus, Inject, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from 'src/modules/users/users.service';
import { UserLockStatus, UserStatus } from 'src/modules/users/enums/user-status.enum';
import { Cache } from 'cache-manager';
import { jwtConstants } from 'src/modules/auth/constants';
import { InjectRepository } from '@nestjs/typeorm';
import { ResponseUserDto } from 'src/modules/auth/dto/response-user.dto';
import { UserEntity } from 'src/models/entities/users.entity';
import { UserRepository } from 'src/models/repositories/user.repository';
import { FORBIDDEN } from 'src/shares/constants/httpExceptionSubCode.constant';
import { getConfig } from 'src/configs';
import { LoginHistoryRepository } from 'src/models/repositories/login-history.repository';

const refreshTokenConfig = {
  expiresIn: jwtConstants.refreshTokenExpires,
  secret: jwtConstants.refreshTokenSecret,
};

@Injectable()
export class AuthService {
  private INCORRECT_TIMES = 4;
  private INCORRECT_TIMES_TTL = 60 * 10;

  constructor(
    private usersService: UsersService,
    @InjectRepository(UserRepository, 'master')
    private usersRepository: UserRepository,
    @InjectRepository(UserRepository, 'report')
    private usersRepositoryReport: UserRepository,
    @InjectRepository(LoginHistoryRepository, 'master')
    private loginHistoriesRepo: LoginHistoryRepository,
    private jwtService: JwtService,
    @Inject(CACHE_MANAGER) private cache: Cache,
  ) {}

  async validateUser(address: string, password: string, message: string): Promise<Partial<UserEntity>> {
    // try {
    //   const sameAddress = await VerifyAddress.checkRecoverSameAddress(address, password, message);
    //   if (!sameAddress) {
    //     throw new HttpException({ key: 'user-wallet.WRONG_SIGNATURE' }, HttpStatus.BAD_REQUEST);
    //   }
    // } catch (err) {
    //   throw new HttpException({ key: 'user-wallet.WRONG_SIGNATURE' }, HttpStatus.BAD_REQUEST);
    // }

    let user = await this.usersService.getUserByWalletAccount(address);

    if (!user?.id) {
      await this.usersService.createUser(
        {
          address: address,
          password: password,
          message: message,
        },
        true,
      );
      user = await this.usersService.getUserByWalletAccount(address);
    }
    if (!user) return null;
    return {
      id: user.id,
      email: user.email,
      isFirstLogin: user.isFirstLogin,
      company: user.company,
      fullname: user.fullname,
      phone: user.phone,
      role: user.role,
      address: address,
      createdAt: user.createdAt,
    };
  }

  async verifyEmail(verify_email_token: string): Promise<void> {
    const verifyEmailTokenDecode = await this.usersService.decodeJWTVerifyToken(verify_email_token);

    const userId = verifyEmailTokenDecode.sub;
    const user = await this.usersService.findUserById(userId);

    if (!user) throw new HttpException({ key: 'user.NOT_EXISTS' }, HttpStatus.NOT_FOUND);

    if (user.locked == UserLockStatus.Locked) {
      throw new HttpException({ key: 'user.ACCOUNT_LOCKED', code: FORBIDDEN.ACCOUNT_LOCKED }, HttpStatus.FORBIDDEN);
    }

    if (user.status !== UserStatus.Submit)
      throw new HttpException({ key: 'user.USER_EMAIL_VERIFIED' }, HttpStatus.NOT_ACCEPTABLE);

    user.status = UserStatus.PendingActive;

    await this.usersRepository.save(user);
  }

  async validateGoogleCaptcha(response: string): Promise<boolean> {
    const secret = getConfig().get<string>('google_recaptcha_secret');
    const verifyUrl = getConfig().get<string>('google_verify_captcha_url');
    const bodyFormData = new FormData();
    bodyFormData.append('secret', secret);
    bodyFormData.append('response', response);
    const data = await axios.post(verifyUrl, bodyFormData, {
      headers: bodyFormData.getHeaders(),
    });
    return data.data.success;
  }

  // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types
  async login(req): Promise<ResponseUserDto> {
    const user = req.user;
    console.log(req.user, 'req.user');
    // const isAdmin = [Role.Admin, Role.SuperAdmin].includes(user.role);

    // // If is admin or superAdmin
    // if (isAdmin && user.isFirstLogin) {
    //   throw new HttpException(
    //     { key: 'admin.ADMIN_NOT_CHANGED_DEFAULT_PASSWORD', code: FORBIDDEN.ADMIN_NOT_CHANGED_DEFAULT_PASSWORD },
    //     HttpStatus.FORBIDDEN,
    //   );
    // }

    const payload = { sub: user.id, role: user.role };
    const refreshTokenPayload = { sub: user.id };
    const ip = requestIp.getClientIp(req);
    const last_login = await this.usersRepositoryReport.getLastLogin(user.id);

    const response = {
      access_token: this.jwtService.sign(payload),
      refresh_token: this.jwtService.sign(refreshTokenPayload, refreshTokenConfig),
      id: user.id,
      email: user.email,
      company: user.company,
      fullname: user.fullname,
      phone: user.phone,
      role: user.role,
      createdAt: user.createdAt,
      IP: ip,
      last_login: last_login?.last_login ? last_login?.last_login : user.createdAt,
    };

    const loginHistories = { userId: user.id, ip: ip };
    await this.loginHistoriesRepo.save(loginHistories);

    return response;
  }

  async getAccessToken(refreshToken: string): Promise<{ access_token: string }> {
    let refreshTokenDecode;
    try {
      refreshTokenDecode = await this.jwtService.verify(refreshToken, refreshTokenConfig);
    } catch (e) {
      throw new HttpException({ key: 'user.INVALID_TOKEN' }, HttpStatus.UNAUTHORIZED);
    }

    const userId = refreshTokenDecode.sub;
    const payload = { sub: userId };

    return {
      access_token: this.jwtService.sign(payload),
    };
  }
}
