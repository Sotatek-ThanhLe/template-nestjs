import { Logger, MiddlewareConsumer, Module } from '@nestjs/common';

import Modules from 'src/modules';

import { EXCLUDE_LOG_PATHS } from 'src/shares/constants/constant';
import { LoggerMiddleware } from 'src/shares/middlewares/logger.middleware';

@Module({
  imports: [...Modules],
  controllers: [],
  providers: [Logger],
})
export class AppModules {
  configure(consumer: MiddlewareConsumer): void {
    consumer
      .apply(LoggerMiddleware)
      .exclude(...EXCLUDE_LOG_PATHS)
      .forRoutes('/');
  }
}
