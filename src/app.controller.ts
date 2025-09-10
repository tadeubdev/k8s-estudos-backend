import { Controller, Get } from '@nestjs/common';

@Controller('api')
export class AppController {
  constructor() {}

  @Get()
  getHello(): { message: string } {
    return { message: 'Olá Mundo!' };
  }
}
