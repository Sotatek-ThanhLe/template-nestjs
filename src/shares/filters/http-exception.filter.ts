import { ArgumentsHost, Catch, ExceptionFilter, HttpException } from '@nestjs/common';
import { Request, Response } from 'express';
import { ErrorCode } from 'src/shares/constants/errors.constant';

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  async catch(exception: HttpException, host: ArgumentsHost): Promise<void> {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();
    const status = exception.getStatus();
    // eslint-disable-next-line
    const exceptionResponse: any = exception.getResponse();

    response.status(status).json({
      code: exceptionResponse?.code || ErrorCode.Default,
      status_code: status,
      message: exceptionResponse?.message || 'Unknown',
      path: request.url,
    });
  }
}
