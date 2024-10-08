import * as dotenv from 'dotenv';
dotenv.config();

import { BootstrapConsole } from 'nestjs-console';
import { AppModules } from 'src/app.module';
import * as config from 'config';
import { SchedulerRegistry } from '@nestjs/schedule';

const bootstrap = new BootstrapConsole({
  module: AppModules,
  useDecorators: true,
  contextOptions: {
    logger: true,
  },
});
bootstrap.init().then(async (app) => {
  try {
    await app.init();
    if (!config.get<boolean>('cron.enable')) {
      // disable when cron enable is false
      const schedulerRegistry = app.get(SchedulerRegistry);
      const jobs = schedulerRegistry.getCronJobs();
      jobs.forEach((_, jobId) => {
        schedulerRegistry.deleteCronJob(jobId);
      });
    }
    await bootstrap.boot();
    await app.close();
    process.exit(0);
  } catch (e) {
    console.error(e);
    await app.close();
    process.exit(1);
  }
});
