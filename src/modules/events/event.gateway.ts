import { WebSocketGateway, WebSocketServer, OnGatewayConnection, OnGatewayDisconnect } from '@nestjs/websockets';
import { Logger } from '@nestjs/common';
import { Socket, Server } from 'socket.io';
import { verify } from 'jsonwebtoken';
import { jwtConstants } from 'src/modules/auth/constants';

@WebSocketGateway()
export class EventsGateway implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer() server: Server;
  private logger: Logger = new Logger('AppGateway');

  async handleDisconnect(client: Socket): Promise<void> {
    this.logger.log(`Client disconnected: ${client.id}`);
  }

  async handleConnection(client: Socket): Promise<void> {
    const token = client.handshake.query?.authorization;
    if (token) {
      try {
        const payload = verify(token, jwtConstants.accessTokenSecret) as { sub: number };
        client.join(payload.sub);
        this.logger.log(`User ${payload.sub} connected: ${client.id}`);
      } catch (e) {
        this.logger.log(`Failed to decode access token for client ${client.id}`);
      }
    } else {
      this.logger.log(`Guest connected: ${client.id}`);
    }
  }
}
