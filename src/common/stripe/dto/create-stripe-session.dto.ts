export class CreateStripeDto {
  uid: string
  items: {
    id: number
    name: string
    image: string
    price: number
  }[]
}
