import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';

@Controller('users')
export class UsersController {
    @MessagePattern('get-user')
    getUser(id:number) {
        return {
            id,
            name: 'Marcinho',
            email: 'marcio.sistemas@gmail.com'
        }
    }
}
