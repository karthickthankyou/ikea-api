import { Module } from '@nestjs/common'

import { StripeController } from './stripe.controller'
import StripeService from './stripe.service'

import { OrdersService } from 'src/models/orders/orders.service'

@Module({
  controllers: [StripeController],
  providers: [StripeService, OrdersService],
})
export class StripeModule {}
