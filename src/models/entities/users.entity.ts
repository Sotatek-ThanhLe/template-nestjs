import { Entity, PrimaryGeneratedColumn, Column, BeforeInsert, CreateDateColumn, UpdateDateColumn } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { jwtConstants } from 'src/modules/auth/constants';
import { Expose } from 'class-transformer';

@Entity({
  name: 'users',
})
export class UserEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  @Expose()
  title: string;

  @Column()
  @Expose()
  email: string;

  @Column()
  @Expose()
  address: string;

  @Column()
  @Expose()
  company: string;

  @Column()
  @Expose()
  position: string;

  @Column()
  @Expose()
  fullname: string;

  @Column()
  @Expose()
  password: string;

  @Column()
  @Expose()
  phone: string;

  // @Column({
  //   name: 'velo_account',
  // })
  // @Expose()
  // velo_account: string;

  @Column({
    name: 'role',
  })
  role: number;

  @Column({
    name: 'status',
  })
  @Expose()
  status: number;

  @Column({
    name: 'isLocked',
  })
  @Expose()
  locked: number;

  @Column({
    name: 'isFirstLogin',
  })
  @Expose()
  isFirstLogin: boolean;

  @Column({
    name: 'userType',
  })
  @Expose()
  userType: number;

  @Column({
    name: 'tokenResetPassword',
  })
  @Expose()
  tokenResetPassword: number;

  @Column()
  @Expose()
  expire: Date;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @BeforeInsert()
  async actionBeforeInsert(): Promise<void> {
    this.password = await bcrypt.hash(this.password, jwtConstants.saltRound);
  }
}
