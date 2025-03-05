import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';

@Controller('orders')
export class OrdersController {
    @MessagePattern('create-order')
    createOrder(order:any) {
        console.log({ message: 'Order received on de Order microservice: ', order });
        return {
            message: 'Order created',
            order
        }
    }
}
