import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';

async function bootstrap() {
  const servicePort:number = parseInt(process.env.PORT || '4002');
  const app = await NestFactory.createMicroservice<MicroserviceOptions>(AppModule, {
    transport: Transport.TCP,
    options: {
      port: servicePort,
    }
  });  
  await app.listen();
  console.log(`Products microservice is running on port ${servicePort}`);
}
bootstrap();
