import {
  Body,
  CACHE_MANAGER,
  Controller,
  Get,
  HttpCode,
  HttpException,
  HttpStatus,
  Inject,
  Param,
  Post,
  Put,
  Query,
  Request,
  UseGuards,
} from '@nestjs/common';
import { ApiBearerAuth, ApiBody, ApiOperation, ApiTags } from '@nestjs/swagger';
import { Cache } from 'cache-manager';
import { I18nService } from 'nestjs-i18n';
import { getConfig } from 'src/configs';
import { UserEntity } from 'src/models/entities/users.entity';
import { JwtAuthGuard } from 'src/modules/auth/guards/jwt-auth.guard';
import { MailService } from 'src/modules/mail/mail.service';
import { RolesGuard } from 'src/modules/roles/roles.guard';
import { ChangePassDto } from 'src/modules/users/dto/change-pass.dto';
import { CheckResetPassTokenDto } from 'src/modules/users/dto/check-reset-pass-token.dto';
import { CreateUserDto } from 'src/modules/users/dto/create-user.dto';
import { EmailDto } from 'src/modules/users/dto/email.dto';
import { ForgotPassForm } from 'src/modules/users/dto/forgot-pass.dto';
import { ResetPasswordDto } from 'src/modules/users/dto/reset-password.dto';
import { UpdateUserDto } from 'src/modules/users/dto/update-user.dto';
import { UserActiveToken } from 'src/modules/users/dto/user-active.dto';
import { UserStatus } from 'src/modules/users/enums/user-status.enum';
import { UsersService } from 'src/modules/users/users.service';
import { UserID } from 'src/shares/decorators/get-user-id.decorator';
import { JwtService } from '@nestjs/jwt';
@Controller('users')
@ApiBearerAuth()
@ApiTags('User')
export class UsersController {
  private FCX_PAGE = getConfig().get<string>('fcx.page');

  constructor(
    private userService: UsersService,
    private mailService: MailService,
    private jwtService: JwtService,
    @Inject(CACHE_MANAGER) private cache: Cache,
    private i18n: I18nService,
  ) {}

  @ApiOperation({
    operationId: 'createUser',
    summary: 'Create User',
    description: 'Create User',
  })
  @Post()
  async create(@Body() userDto: CreateUserDto): Promise<UserEntity> {
    const { address } = userDto;

    // check if the user exists in the db
    const userInDb = await this.userService.getUserByWalletAccount(address);

    if (userInDb) {
      throw new HttpException({ key: 'user.EXISTS' }, HttpStatus.BAD_REQUEST);
    }
    await this.userService.createUser(userDto);

    return this.i18n.translate('user.CREATE_SUCCESS', {});
  }

  @ApiOperation({
    operationId: 'resendVerifyEmail',
    summary: 'Resend Verify Email',
    description: 'Resend Verify Email',
  })
  @Post('/resend-verify-email/:email')
  async resendVerifyEmail(@Param('email') email: string): Promise<string> {
    const verifyEmailToken = await this.userService.getVerifyEmailToken(email);

    const verifyEmailUrl = `${this.FCX_PAGE}/verify-email?token=${verifyEmailToken}`;

    await this.mailService.sendVerifyEmailJob(email, verifyEmailUrl);

    return this.i18n.translate('user.RESEND_VERIFY_EMAIL_SUCCESS', {});
  }

  @ApiOperation({
    operationId: 'updateFunCurrencies',
    summary: 'Update funtion currencies',
    description: 'Update funtion currencies',
  })
  @Post('update-list-fun-currencies')
  @ApiBody({
    type: UpdateUserDto,
  })
  @UseGuards(JwtAuthGuard, RolesGuard)
  async updatelistUserFunCurrencies(@Body() userDto: UpdateUserDto, @UserID() userId: number): Promise<UserEntity> {
    userDto.userId = userId;
    return this.i18n.translate('user.UPDATE_SUCCESS', {});
  }

  @ApiOperation({
    operationId: 'checkValidEmail',
    summary: 'Check valid Email',
    description: 'Check valid Email',
  })
  @Post('check-valid-email')
  @ApiBody({
    type: EmailDto,
  })
  @ApiOperation({
    description: `Api check mail có thể dùng được hay không`,
  })
  async checkEmailCanUse(@Body('email') email: string): Promise<string> {
    const userInDb = await this.userService.findUserByEmail(email);
    if (userInDb) {
      throw new HttpException({ key: 'user.EMAIL_CANNOT_USE' }, HttpStatus.NOT_ACCEPTABLE);
    }

    return this.i18n.translate('user.EMAIL_CAN_USE', {});
  }

  @Get('/confirm')
  @HttpCode(200)
  async active(@Query('token') token: string): Promise<string> {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    let tokenDecoded: UserActiveToken | any;
    try {
      tokenDecoded = await this.cache.get(token);
      if (!tokenDecoded) throw 'Error';
    } catch (e) {
      // logger
      return this.i18n.translate('user.INVALID_TOKEN', {});
    }

    // token validated
    try {
      await this.cache.del(token);
      await this.userService.changeUserStatus(tokenDecoded.userId, UserStatus.Active);
    } catch (e) {
      // logger
      throw new HttpException({ key: 'user.INTERNAL_SERVER_ERROR' }, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    return this.i18n.translate('user.ACCOUNT_ACTIVATED', {});
  }

  @ApiOperation({
    operationId: 'forgotPassword',
    summary: 'Forgot password',
    description: 'Forgot password',
  })
  @Post('forgot-password')
  @ApiBody({
    type: ForgotPassForm,
  })
  async forgotPassword(@Body('email') email: string): Promise<string> {
    const token = await this.userService.generateResetPasswordToken(email);

    await this.mailService.sendForgotPasswordEmailJob(email, token);
    return this.i18n.translate('user.FORGOT_PASS_TOKEN_SENT', {});
  }

  @ApiOperation({
    operationId: 'checkPassToken',
    summary: 'Check token',
    description: 'Check token',
  })
  @Post('check-pass-token')
  @HttpCode(200)
  @ApiBody({
    type: CheckResetPassTokenDto,
  })
  async checkPassToken(@Body('token') token: string, @Body('email') email: string): Promise<boolean> {
    const isValid = await this.userService.checkPassToken(email, token);
    if (!isValid) throw new HttpException('user.INVALID_TOKEN', HttpStatus.NOT_ACCEPTABLE);
    return isValid;
  }

  @ApiOperation({
    operationId: 'resetPassword',
    summary: 'Reset password',
    description: 'Reset password',
  })
  @Put('reset-password')
  async resetPassword(@Body() resetPasswordDto: ResetPasswordDto): Promise<string> {
    const { email, password, token } = resetPasswordDto;

    const isValid = await this.userService.checkPassToken(email, token);
    if (!isValid) throw new HttpException('user.INVALID_TOKEN', HttpStatus.NOT_ACCEPTABLE);

    const success = await this.userService.updatePassword(email, password);

    if (!success) throw new HttpException('user.INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);

    await this.mailService.sendPasswordChangedEmailJob(email);
    return this.i18n.translate('user.RESET_PASSWORD_SUCCEED', {});
  }

  @Put('change-password')
  @ApiBody({
    type: ChangePassDto,
  })
  @UseGuards(JwtAuthGuard, RolesGuard)
  async changePassword(@Body() changePassDto: ChangePassDto, @UserID() userId: number): Promise<string> {
    const success = await this.userService.changePassword(changePassDto, userId);

    if (!success) throw new HttpException('user.INTERNAL_SERVER_ERROR', HttpStatus.INTERNAL_SERVER_ERROR);
    return this.i18n.translate('user.CHANGE_PASSWORD_SUCCEED', {});
  }

  @ApiOperation({
    operationId: 'getMe',
    summary: 'Get user login profile',
    description: 'Get user login profile',
  })
  @Get('me')
  @ApiOperation({
    description: 'get profile',
  })
  @UseGuards(JwtAuthGuard, RolesGuard)
  async getProfile(@Request() req: unknown, @UserID() userId: number): Promise<unknown> {
    return this.userService.getProfile(req, userId);
  }
}
