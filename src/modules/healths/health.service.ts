import { Injectable } from '@nestjs/common';
import { Connection } from 'typeorm';
import { InjectConnection } from '@nestjs/typeorm';
import { createClient } from 'redis';
import { redisConfig } from 'src/configs/redis.config';

@Injectable()
export class HealthService {
  constructor(
    @InjectConnection('report')
    private reportConnection: Connection,
    @InjectConnection('master')
    private masterConnection: Connection,
  ) {}

  async getHealth(): Promise<Record<string, string>> {
    const redisClient = createClient(redisConfig.port, redisConfig.host);

    const check = (): Promise<string> => {
      return new Promise<string>((resolve, reject) => {
        redisClient.set('health', `${new Date().getTime()}`, (err, data) => {
          if (err) {
            resolve('Failed check health redis');
          } else if (data) {
            resolve('Success check health redis');
          } else {
            reject('Failed on check health redis');
          }
        });
      });
    };

    const redis = await check();

    const query = 'SELECT 1';
    let mysql: string;
    try {
      Promise.all([this.masterConnection.query(query), this.reportConnection.query(query)]);
      mysql = 'Success check health mysql';
    } catch (e) {
      console.log(e);
      mysql = 'Failed check health mysql';
    }
    return {
      mysql,
      redis,
    };
  }
}
