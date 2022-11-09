import { UserEntity } from 'src/models/entities/users.entity';
import { UserStatus } from 'src/modules/users/enums/user-status.enum';
import { EntityRepository, getConnection, LessThanOrEqual, Repository } from 'typeorm';

@EntityRepository(UserEntity)
export class UserRepository extends Repository<UserEntity> {
  async getListUserActive(): Promise<Partial<UserEntity>[]> {
    return this.find({
      select: ['id'],
      where: {
        status: UserStatus.Active,
      },
    });
  }

  async getListUserFunCurrencies(userId: number): Promise<{ id: string; symbol: string; currency_id: string }[]> {
    return await this.createQueryBuilder('users')
      .select([
        'users.id',
        'functional_currencies.currency',
        'functional_currencies.symbol',
        'functional_currencies.iso_code',
        'functional_currencies.id',
        'functional_currency_users.isActive',
      ])
      .innerJoin(
        'functional_currency_users',
        'functional_currency_users',
        'functional_currency_users.userId = users.id',
      )
      .innerJoin(
        'functional_currencies',
        'functional_currencies',
        'functional_currencies.id = functional_currency_users.currency_id',
      )
      .where({ id: userId })
      .getRawMany();
  }
  async deleteLastlistUserFunCurrencies(userId: number): Promise<void> {
    await getConnection()
      .createQueryBuilder()
      .delete()
      .from('functional_currency_users')
      .where({ userId: userId })
      .execute();
  }
  async getLastLogin(userId: number): Promise<{ last_login: Date }> {
    return await this.createQueryBuilder('users')
      .select('login_histories.createdAt', 'last_login')
      .innerJoin('login_histories', 'login_histories', 'login_histories.userId = users.id')
      .where({ id: userId })
      .orderBy('login_histories.createdAt', 'DESC')
      .getRawOne();
  }

  async listUserNotVerifyAfter24Hours(): Promise<UserEntity[]> {
    const dateTime24hAgo = new Date(new Date().getTime() - 24 * 60 * 60 * 1000);
    return this.find({
      where: {
        status: UserStatus.Submit,
        createdAt: LessThanOrEqual(dateTime24hAgo),
      },
      select: ['id'],
    });
  }
}
