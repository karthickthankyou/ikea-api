import { Field, ObjectType } from '@nestjs/graphql'
import { Support as SupportType } from '@prisma/client'

@ObjectType()
export class Support implements SupportType {
  @Field(() => Number)
  id: number
  createdAt: Date
  updatedAt: Date
  @Field(() => String)
  uid: string
  title: string
  message: string
  @Field({ nullable: true })
  location: string
  @Field({ nullable: true })
  category: string
}
