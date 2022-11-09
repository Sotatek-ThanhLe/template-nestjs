import { Controller, Post, UseGuards, Request, Body, HttpException, HttpStatus, Query } from '@nestjs/common';
import { ApiBearerAuth, ApiBody, ApiTags } from '@nestjs/swagger';
import { LoginUserDto } from 'src/modules/users/dto/login-user.dto';
import { AuthService } from 'src/modules/auth/auth.service';
import { LocalAuthGuard } from 'src/modules/auth/guards/local-auth.guard';
import { GetAccessTokenForm } from 'src/modules/auth/dto/get-access-token.dto';
import { ResponseUserDto } from 'src/modules/auth/dto/response-user.dto';
import { Request as ReqExpress } from 'express';
import { UserDto } from 'src/modules/users/dto/user.dto';
import { Role } from 'src/modules/roles/enums/role.enum';
import { FORBIDDEN } from 'src/shares/constants/httpExceptionSubCode.constant';
import { UsersService } from 'src/modules/users/users.service';

@Controller('auth')
@ApiTags('Auth')
export class AuthController {
  constructor(private readonly authService: AuthService, private readonly userService: UsersService) {}

  @Post('/verify-email')
  async verifyEmail(@Query('token') token: string): Promise<string> {
    await this.authService.verifyEmail(token);

    return 'OK';
  }

  // @UseGuards(LocalAuthGuard)
  @ApiBody({
    type: LoginUserDto,
  })
  @Post('login')
  login(@Request() req: ReqExpress): Promise<Partial<ResponseUserDto>> {
    console.log('req: ', req);
    return this.authService.login(req);
  }

  @Post('access-token')
  @ApiBody({
    type: GetAccessTokenForm,
  })
  async getAccessToken(@Body('refreshToken') refreshToken: string): Promise<Partial<ResponseUserDto>> {
    return this.authService.getAccessToken(refreshToken);
  }

  @UseGuards(LocalAuthGuard)
  @ApiBody({
    type: LoginUserDto,
  })
  @Post('admin/login')
  @ApiBearerAuth()
  async loginAmin(@Request() req: ReqExpress & { user: UserDto }): Promise<Partial<ResponseUserDto>> {
    if (![Role.Admin, Role.SuperAdmin].includes(req.user.role))
      throw new HttpException({ key: 'user.NOT_ADMIN', code: FORBIDDEN.WRONG_EMAIL }, HttpStatus.FORBIDDEN);

    return this.authService.login(req);
  }
}
