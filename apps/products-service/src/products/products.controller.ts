import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';

@Controller('products')
export class ProductsController {
    @MessagePattern('get-product')
    getProduct(id:number) {
        return {
            id,
            name: 'Notebook',
            price: 1000
        }
    }
}
