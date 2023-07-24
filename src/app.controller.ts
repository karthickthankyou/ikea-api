import { Controller, Get } from '@nestjs/common'
import { AppService } from './app.service'

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return `
      <!DOCTYPE html>
      <html>
      <head>
        <title>IKEA Clone API</title>
        <style>
          body {
            background-color: #f5f5f5;
            text-align: center;
            padding: 50px;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
          }
          a {
            color: #333;
            text-decoration: none;
          }
        </style>
      </head>
      <body>
        <h1>Welcome to the IKEA Clone API</h1>
        <p>This is a GraphQL API for the IKEA Clone.</p>
        <p>Click <a href="/graphql">here</a> to access the GraphQL playground.</p>
        <p>Click <a href="https://ikea.iamkarthick.com">here</a> to see the beautiful project. ;)</p>
      </body>
      </html>
    `
  }
}
