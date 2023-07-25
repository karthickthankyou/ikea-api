export class CreateStripeDto {
  uid: string
  items: {
    id: number
    name: string
    description: string
    image: string
    price: number
  }[]
}
