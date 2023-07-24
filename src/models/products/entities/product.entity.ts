import { Field, Float, Int, ObjectType } from '@nestjs/graphql'
import { Product as ProductType } from '@prisma/client'

@ObjectType()
export class Product implements ProductType {
  @Field(() => Number)
  id: number
  createdAt: Date
  updatedAt: Date
  name: string
  @Field({ nullable: true })
  url: string
  @Field(() => Float)
  price: number
  category: string
  @Field({ nullable: true })
  subCategory: string
  @Field({ nullable: true })
  outOfStock: boolean
  @Field({ nullable: true })
  reviews: number
  @Field({ nullable: true })
  rating: number
  @Field({ nullable: true })
  discount: number
  @Field({ nullable: true })
  oldPrice: number
  tags: string[]
  @Field({ nullable: true })
  description: string
  sellerId: string
  @Field(() => [String])
  images: string[]
  @Field({ nullable: true })
  measurements: string
}
