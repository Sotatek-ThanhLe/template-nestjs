import { EntityRepository, Repository } from 'typeorm';
import { LoginHistoriesEntity } from 'src/models/entities/login-histories.entity';

@EntityRepository(LoginHistoriesEntity)
export class LoginHistoryRepository extends Repository<LoginHistoriesEntity> {
}
