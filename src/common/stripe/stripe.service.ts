import { Injectable } from '@nestjs/common'
import Stripe from 'stripe'
import { CreateStripeDto } from './dto/create-stripe-session.dto'

@Injectable()
export default class StripeService {
  public stripe: Stripe

  constructor() {
    this.stripe = new Stripe(process.env.STRIPE_SECRET_KEY, {
      apiVersion: '2022-11-15',
    })
  }

  async createStripeSession({ items, uid }: CreateStripeDto) {
    console.log('totalPriceObj,bookingData ', items, uid)
    const session = await this.stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: items
        .filter(({ price }) => price > 0)
        .map(({ name, price, image }) => ({
          quantity: 1,
          price_data: {
            product_data: {
              name,
              images: [image],
            },
            currency: 'inr',
            unit_amount: price,
          },
        })),
      mode: 'payment',
      success_url: process.env.STRIPE_SUCCESS_URL,
      cancel_url: process.env.STRIPE_CANCEL_URL,
      metadata: {
        uid,
        items: JSON.stringify(items),
      },
    })

    return { sessionId: session.id }
  }
}
