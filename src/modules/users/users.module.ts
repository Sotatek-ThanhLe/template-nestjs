import { DatabaseCommonModule } from 'src/models/database-common';
import { Logger, Module } from '@nestjs/common';
import { UsersController } from 'src/modules/users/users.controller';
import { UsersService } from 'src/modules/users/users.service';
import { JwtModule } from '@nestjs/jwt';
import { jwtConstants } from 'src/modules/auth/constants';
import { MailModule } from 'src/modules/mail/mail.module';

@Module({
  imports: [
    DatabaseCommonModule,
    Logger,
    MailModule,
    JwtModule.register({
      secret: jwtConstants.accessTokenSecret,
      signOptions: { expiresIn: jwtConstants.accessTokenExpiry },
    }),
  ],
  providers: [UsersService, Logger],
  exports: [UsersService],
  controllers: [UsersController],
})
export class UsersModule {}
