import { Column, CreateDateColumn, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({
  name: 'login_histories',
})
export class LoginHistoriesEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({
    name: 'userId',
  })
  userId: number;

  @Column({
    name: 'ip',
  })
  ip: string;

  @Column({
    name: 'device',
  })
  device: string;

  @CreateDateColumn()
  createdAt: Date;
}
