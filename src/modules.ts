import { BullModule } from '@nestjs/bull';
import { CacheModule, Logger } from '@nestjs/common';
import { ScheduleModule } from '@nestjs/schedule';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConsoleModule } from 'nestjs-console';
import { HeaderResolver, I18nJsonParser, I18nModule } from 'nestjs-i18n';
import * as path from 'path';
import { defaultConfig, masterConfig, reportConfig } from 'src/configs/database.config';
import { redisConfig } from 'src/configs/redis.config';
import { AuthModule } from 'src/modules/auth/auth.module';
import { EventsModule } from 'src/modules/events/events.module';
import { HealthModule } from 'src/modules/healths/health.module';
import { MailModule } from 'src/modules/mail/mail.module';
import { UsersModule } from 'src/modules/users/users.module';
import { GlobalsModule } from 'src/shares/globals/globals.module';

const Modules = [
  Logger,
  ScheduleModule.forRoot(),
  TypeOrmModule.forRoot(defaultConfig),
  TypeOrmModule.forRoot(masterConfig),
  TypeOrmModule.forRoot(reportConfig),
  BullModule.forRoot({
    redis: redisConfig,
  }),
  I18nModule.forRoot({
    fallbackLanguage: 'en',
    parser: I18nJsonParser,
    parserOptions: {
      path: path.join(__dirname, '/i18n/'),
    },
    resolvers: [new HeaderResolver(['x-custom-lang'])],
  }),
  CacheModule.registerAsync({
    useFactory: () => redisConfig,
  }),
  EventsModule,
  AuthModule,
  HealthModule,
  UsersModule,
  GlobalsModule,
  ConsoleModule,
  MailModule,
];

export default Modules;
