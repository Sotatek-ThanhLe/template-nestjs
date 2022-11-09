import { ApiProperty } from '@nestjs/swagger';

export class NotificationSettingDto {
  @ApiProperty({
    required: true,
  })
  enable: number;
}
