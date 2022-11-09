import { IsNotEmpty } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class LoginUserDto {
  @ApiProperty({
    required: true,
    default: '0x1168271df29afa411ab84f3086ed24389a5bb4a8',
  })
  @IsNotEmpty()
  readonly address: string;

  @ApiProperty({
    required: true,
    default: 'this is message login',
  })
  @IsNotEmpty()
  readonly password: string;

  @ApiProperty({
    required: true,
    default: 'Hello123',
  })
  @IsNotEmpty()
  readonly message: string;
}
