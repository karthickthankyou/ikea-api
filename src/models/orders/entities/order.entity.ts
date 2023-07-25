import { Field, ObjectType } from '@nestjs/graphql'
import { OrderStatus, Order as OrderType } from '@prisma/client'

@ObjectType()
export class Order implements OrderType {
  id: number
  createdAt: Date
  updatedAt: Date
  pid: number
  uid: string
  @Field(() => OrderStatus)
  status: OrderStatus
  // Todo fill all properties
}
