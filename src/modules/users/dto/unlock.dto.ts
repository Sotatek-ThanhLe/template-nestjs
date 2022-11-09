import { ApiProperty } from '@nestjs/swagger';

export class UnlockAccountDto {
  @ApiProperty({
    required: true,
  })
  userId: number;
}
