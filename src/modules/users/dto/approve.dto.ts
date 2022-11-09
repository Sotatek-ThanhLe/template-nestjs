import { ApiProperty } from '@nestjs/swagger';

export class ApproveDto {
  @ApiProperty({
    required: true,
  })
  userId: number;
}
