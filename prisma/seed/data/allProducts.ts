import { PrismaClient } from '@prisma/client'
import { CreateProductInput } from '../generated/graphql'
import { products } from './products'

const prisma = new PrismaClient()

export const createProductDocuments = async () => {
  const cleanProducts: CreateProductInput[] = products
    .slice(0, 100)
    .map(
      ({
        id,
        discount,
        oldPrice,
        outOfStock,
        price,
        rating,
        reviews,
        createdAt,
        updatedAt,
        sellerId,
        ...rest
      }) => ({
        id: Number(id),
        discount: Number(discount),
        oldPrice: Number(oldPrice),
        outOfStock: Boolean(outOfStock),
        price: Number(price),
        rating: Number(rating),
        reviews: Number(reviews),
        createdAt: new Date(createdAt),
        updatedAt: new Date(updatedAt),
        sellerId: 'kdzlcSXqefg1ae3uwTQjJbSQId02',
        ...rest,
      }),
    )
  await prisma.product.createMany({ data: cleanProducts })
}
