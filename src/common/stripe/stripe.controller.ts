import { Controller, Post, Body, Get, Query, Res } from '@nestjs/common'
import { CreateStripeDto } from './dto/create-stripe-session.dto'
import StripeService from './stripe.service'
import { PrismaService } from 'src/common/prisma/prisma.service'
import { CreateOrderInput } from 'prisma/seed/generated/graphql'
import { Response } from 'express'
import { OrdersService } from 'src/models/orders/orders.service'
import { OrderStatus } from '@prisma/client'

@Controller('stripe')
export class StripeController {
  constructor(
    private readonly stripeService: StripeService,
    private readonly prisma: PrismaService,
    private readonly ordersService: OrdersService,
  ) {}

  @Post()
  create(@Body() createStripeDto: CreateStripeDto) {
    return this.stripeService.createStripeSession(createStripeDto)
  }

  @Get('success')
  async handleStripeSuccess(
    @Query('session_id') sessionId: string,
    @Res() res: Response,
  ) {
    const session = await this.stripeService.stripe.checkout.sessions.retrieve(
      sessionId,
    )
    const { uid, items } = session.metadata
    const purchasedItems: CreateOrderInput[] = JSON.parse(items)
    for (let i = 0; i < purchasedItems.length; i++) {
      const newPurchase = await this.ordersService.create({
        status: OrderStatus.ORDER_RECEIVED,
        ...purchasedItems[i],
      })
    }

    res.redirect(process.env.BOOKINGS_REDIRECT_URL)
  }
}
