import { Strategy } from 'passport-local';
import { PassportStrategy } from '@nestjs/passport';
import { Injectable, UnauthorizedException, Request } from '@nestjs/common';
import { Request as ReqExpress } from 'express';
import { AuthService } from 'src/modules/auth/auth.service';
import { UserEntity } from 'src/models/entities/users.entity';

@Injectable()
export class LocalStrategy extends PassportStrategy(Strategy) {
  constructor(private authService: AuthService) {
    super({ passReqToCallback: true });
  }

  async validate(@Request() req: ReqExpress, address: string, password: string): Promise<Partial<UserEntity>> {
    const { message } = req.body;
    const user = await this.authService.validateUser(address, password, message);
    if (!user) {
      throw new UnauthorizedException();
    }
    return user;
  }
}
