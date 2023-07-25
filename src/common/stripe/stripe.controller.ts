import { Controller, Post, Body, Get, Query, Res } from '@nestjs/common'
import { CreateStripeDto } from './dto/create-stripe-session.dto'
import StripeService from './stripe.service'
import { PrismaService } from 'src/common/prisma/prisma.service'
import { Response } from 'express'
import { OrdersService } from 'src/models/orders/orders.service'
import { OrderStatus, UserProductStatus } from '@prisma/client'

@Controller('stripe')
export class StripeController {
  constructor(
    private readonly stripeService: StripeService,
    private readonly prisma: PrismaService,
    private readonly ordersService: OrdersService,
  ) {}

  @Post()
  create(@Body() createStripeDto: CreateStripeDto) {
    console.log('createStripeDto ', createStripeDto)
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
    const purchasedItems: CreateStripeDto['items'] = JSON.parse(items)
    await this.prisma.order.createMany({
      data: purchasedItems.map((item) => ({
        pid: item.id,
        status: OrderStatus.ORDER_RECEIVED,
        uid,
      })),
    })

    await this.prisma.userProduct.updateMany({
      data: { status: UserProductStatus.PURCHASED },
      where: { uid, status: UserProductStatus.IN_CART },
    })

    res.redirect(process.env.ORDERS_REDIRECT_URL)
  }
}
