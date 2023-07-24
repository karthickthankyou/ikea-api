import { Field, ObjectType } from '@nestjs/graphql'
import { User as UserType } from '@prisma/client'

@ObjectType()
export class User implements UserType {
  createdAt: Date

  updatedAt: Date

  uid: string

  displayName: string
  @Field({ nullable: true })
  address: string
  @Field({ nullable: true })
  about: string
}
