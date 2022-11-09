import { MailerService } from '@nestjs-modules/mailer';
import { Injectable } from '@nestjs/common';
import { InjectQueue } from '@nestjs/bull';
import Bull, { Queue } from 'bull';
import { UserEntity } from 'src/models/entities/users.entity';
import { getConfig } from 'src/configs';
import * as config from 'config';

const mailFrom = config.get<string>('mail.from');
const supportEmail = 'fcxadmin@velo.org';

const FCX_PAGE = getConfig().get<string>('fcx.page');
const signInLink = `${FCX_PAGE}/sign-in`;
const FCX_ADMIN = getConfig().get<string>('fcx.admin');
const signInAdminLink = `${FCX_ADMIN}/sign-in`;

@Injectable()
export class MailService {
  constructor(private mailerService: MailerService, @InjectQueue('mail') private readonly queue: Queue) {}

  sendConfirmationEmail<T>(user: UserEntity, token: string): Promise<Bull.Job<T>> {
    return this.queue.add('sendUserConfirmation', { user, token });
  }

  async sendUserConfirmation(user: UserEntity, token: string): Promise<void> {
    const url = `${getConfig().get<string>('fcx.admin')}/api/v1/users/confirm?token=${token}`;

    await this.mailerService.sendMail({
      to: user.email,
      // from: `"Support Team" <${mailFrom}>`, // override default from
      subject: 'Confirm your Email',
      template: 'src/modules/mail/templates/confirmation.hbs', // `.hbs` extension is appended automatically
      context: {
        name: user.fullname,
        url,
      },
    });
  }

  sendVerifyEmailJob<T>(email: string, verifyEmailUrl: string): Promise<Bull.Job<T>> {
    return this.queue.add('sendVerifyEmail', {
      email,
      verifyEmailUrl,
    });
  }

  async sendVerifyEmail(email: string, verifyEmailUrl: string): Promise<void> {
    await this.mailerService.sendMail({
      to: email,
      from: `"Support Team" <${mailFrom}>`, // override default from
      subject: 'FCX - Confirm your registration',
      template: 'src/modules/mail/templates/verify-email.hbs', // `.hbs` extension is appended automatically
      context: {
        email,
        verifyEmailUrl,
        publicLink: FCX_PAGE,
      },
    });
  }

  sendForgotPasswordEmailJob<T>(email: string, token: number): Promise<Bull.Job<T>> {
    return this.queue.add('sendForgotPasswordEmail', {
      email,
      token,
    });
  }

  async sendForgotPasswordEmail(email: string, token: number): Promise<void> {
    let tokenStr = token.toString();
    tokenStr = `${tokenStr.slice(0, 3)}-${tokenStr.slice(3, tokenStr.length)}`;

    await this.mailerService.sendMail({
      to: email,
      from: `"Support Team" <${mailFrom}>`, // override default from
      subject: 'FCX - Reset password',
      template: 'src/modules/mail/templates/forgot-password.hbs', // `.hbs` extension is appended automatically
      context: {
        email,
        token: tokenStr,
        supportEmail,
        publicLink: FCX_PAGE,
      },
    });
  }

  sendPasswordChangedEmailJob<T>(email: string): Promise<Bull.Job<T>> {
    return this.queue.add('sendPasswordChangedEmail', {
      email,
    });
  }

  async sendPasswordChangedEmail(email: string): Promise<void> {
    await this.mailerService.sendMail({
      to: email,
      from: `"Support Team" <${mailFrom}>`, // override default from
      subject: 'FCX - Password changed',
      template: 'src/modules/mail/templates/password-changed.hbs', // `.hbs` extension is appended automatically
      context: {
        email,
        supportEmail,
        publicLink: FCX_PAGE,
      },
    });
  }

  async sendPasswordAdminQueue<T>(email: string, password: string): Promise<Bull.Job<T>> {
    return await this.queue.add('sendPasswordAdminEmail', { email, password });
  }

  async sendPasswordAdminEmail(email: string, password: string): Promise<void> {
    await this.mailerService.sendMail({
      to: email,
      from: `"Support Team" <${mailFrom}>`, // override default from
      subject: 'FCX - Your admin account has been created',
      template: 'src/modules/mail/templates/send-password-admin.hbs', // `.hbs` extension is appended automatically
      context: {
        email,
        password,
        signInAdminLink,
        publicLink: FCX_PAGE,
      },
    });
  }

  async sendMailDisableAccountJob<T>(email: string): Promise<Bull.Job<T>> {
    return await this.queue.add('sendMailDisableAccount', { email });
  }

  async sendMailDisableAccount(email: string): Promise<void> {
    await this.mailerService.sendMail({
      to: email,
      from: `"Support Team" <${mailFrom}>`, // override default from
      subject: 'FCX - Your account has been disabled',
      template: 'src/modules/mail/templates/disable-account.hbs',
      context: {
        email,
        supportEmail,
        publicLink: FCX_PAGE,
      },
    });
  }

  async sendMailEnableAccountJob<T>(email: string): Promise<Bull.Job<T>> {
    return await this.queue.add('sendMailEnableAccount', { email });
  }

  async sendMailEnableAccount(email: string): Promise<void> {
    await this.mailerService.sendMail({
      to: email,
      from: `"Support Team" <${mailFrom}>`, // override default from
      subject: 'FCX - Your account has been reactivated',
      template: 'src/modules/mail/templates/enable-account.hbs',
      context: {
        email,
        signInLink,
        publicLink: FCX_PAGE,
      },
    });
  }

  sendApproveUserEmailJob<T>(email: string): Promise<Bull.Job<T>> {
    return this.queue.add('sendApproveUserEmail', {
      email,
    });
  }

  async sendApproveUserEmail(email: string): Promise<void> {
    await this.mailerService.sendMail({
      to: email,
      from: `"Support Team" <${mailFrom}>`, // override default from
      subject: 'FCX - Your registration has been approved',
      template: 'src/modules/mail/templates/approve-user.hbs', // `.hbs` extension is appended automatically
      context: {
        email,
        signInLink,
        supportEmail,
        publicLink: FCX_PAGE,
      },
    });
  }

  sendRejectUserEmailJob<T>(email: string): Promise<Bull.Job<T>> {
    return this.queue.add('sendRejectUserEmail', {
      email,
    });
  }

  async sendRejectUserEmail(email: string): Promise<void> {
    await this.mailerService.sendMail({
      to: email,
      from: `"Support Team" <${mailFrom}>`, // override default from
      subject: 'FCX - Your registration has been rejected',
      template: 'src/modules/mail/templates/reject-user.hbs', // `.hbs` extension is appended automatically
      context: {
        email,
        supportEmail,
        publicLink: FCX_PAGE,
      },
    });
  }

  sendTestEmailJob<T>(email: string, subject: string, body: string): Promise<Bull.Job<T>> {
    return this.queue.add('sendTestEmail', {
      email,
      subject,
      body,
    });
  }

  async sendTestEmail(email: string, subject: string, body: string): Promise<void> {
    await this.mailerService.sendMail({
      from: `"No Reply" <${mailFrom}>`,
      to: email,
      subject: 'FCX - Notification',
      template: 'src/modules/mail/templates/notification.hbs',
      context: {
        email,
        title: subject,
        message: body,
        publicLink: FCX_PAGE,
        userSettingPage: `${FCX_PAGE}/user/account/setting`,
      },
    });
  }
}
