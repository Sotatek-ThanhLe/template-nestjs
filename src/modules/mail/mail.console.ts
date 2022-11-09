import { MailerService } from '@nestjs-modules/mailer';
import { Injectable, Logger } from '@nestjs/common';
import * as config from 'config';
import { Command, Console } from 'nestjs-console';
import { MailService } from 'src/modules/mail/mail.service';

const mailFrom = config.get<number>('mail.from');

@Console()
@Injectable()
export class MailConsole {
  constructor(
    private mailerService: MailerService,
    private readonly mailService: MailService,
    private readonly logger: Logger,
  ) {
    this.logger.setContext(MailConsole.name);
  }

  @Command({
    command: 'send-mail <email>',
    description: 'Send test email',
  })
  async sendMail(email: string): Promise<void> {
    console.log(mailFrom, 'mailFrom');
    await this.mailerService.sendMail({
      from: `"No Reply" <${mailFrom}>`,
      to: email,
      subject: 'Notification',
      template: 'src/modules/mail/templates/notification.hbs',
      context: {
        // email,
        // title: subject,
        // message: body,
      },
    });
  }

  @Command({
    command: 'send-mail-via-queue <email> <subject> <body>',
    description: 'Send test email via queue',
  })
  async sendMailViaQueue(email: string, subject: string, body: string): Promise<void> {
    await this.mailService.sendTestEmailJob(email, subject, body);
  }
}
