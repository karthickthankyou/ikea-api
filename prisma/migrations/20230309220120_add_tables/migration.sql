-- CreateEnum
CREATE TYPE "Category" AS ENUM ('Furniture', 'KitchenAndAppliances', 'BedsAndMattresses', 'StorageAndOrganisation', 'WorkingFromHome', 'Textiles', 'Decoration', 'BathroomProducts', 'OutdoorProducts', 'Lighting', 'CarpetsMatsAndFlooring', 'BabyAndChildren', 'PotsAndPlants', 'KitchenwareAndTableware', 'HomeElectronics', 'LaundryAndCleaning', 'HomeSmart', 'VinterCollections', 'HomeImprovement', 'FoodAndBeverages');

-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('ORDER_RECEIVED', 'DELIVERED', 'DISPATCHED');

-- CreateEnum
CREATE TYPE "Room" AS ENUM ('Bedroom', 'LivingRoom', 'ChildrensRoom', 'HomeOffice', 'Kitchen', 'DiningRoom', 'Bathroom', 'Outdoor', 'Hallway', 'BusinessPlace');

-- CreateEnum
CREATE TYPE "UserProductStatus" AS ENUM ('REMOVED_FROM_WISHLIST', 'WISHLISTED', 'IN_CART', 'SAVED_FOR_LATER');

-- CreateTable
CREATE TABLE "User" (
    "uid" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "displayName" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "about" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("uid")
);

-- CreateTable
CREATE TABLE "Seller" (
    "uid" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Seller_pkey" PRIMARY KEY ("uid")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "url" TEXT,
    "price" DOUBLE PRECISION NOT NULL,
    "category" "Category" NOT NULL,
    "sub_category" TEXT NOT NULL,
    "out_of_stock" BOOLEAN,
    "reviews" INTEGER DEFAULT 0,
    "rating" DOUBLE PRECISION,
    "discount" INTEGER,
    "old_price" DOUBLE PRECISION,
    "tags" TEXT[],
    "description" TEXT,
    "sellerId" TEXT NOT NULL,
    "images" TEXT[],
    "measurements" TEXT,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserProduct" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "pid" INTEGER NOT NULL,
    "uid" TEXT NOT NULL,
    "status" "UserProductStatus" NOT NULL,

    CONSTRAINT "UserProduct_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Order" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "pid" INTEGER NOT NULL,
    "uid" TEXT NOT NULL,
    "status" "OrderStatus" NOT NULL,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OrderLog" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "orderId" INTEGER NOT NULL,
    "status" "OrderStatus" NOT NULL,

    CONSTRAINT "OrderLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "View" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "pid" INTEGER NOT NULL,
    "uid" TEXT NOT NULL,

    CONSTRAINT "View_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Support" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "uid" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "message" TEXT NOT NULL,

    CONSTRAINT "Support_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "UserProduct_uid_pid_key" ON "UserProduct"("uid", "pid");

-- AddForeignKey
ALTER TABLE "Product" ADD CONSTRAINT "Product_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES "Seller"("uid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserProduct" ADD CONSTRAINT "UserProduct_pid_fkey" FOREIGN KEY ("pid") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserProduct" ADD CONSTRAINT "UserProduct_uid_fkey" FOREIGN KEY ("uid") REFERENCES "User"("uid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_pid_fkey" FOREIGN KEY ("pid") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_uid_fkey" FOREIGN KEY ("uid") REFERENCES "User"("uid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderLog" ADD CONSTRAINT "OrderLog_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "View" ADD CONSTRAINT "View_pid_fkey" FOREIGN KEY ("pid") REFERENCES "Product"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "View" ADD CONSTRAINT "View_uid_fkey" FOREIGN KEY ("uid") REFERENCES "User"("uid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Support" ADD CONSTRAINT "Support_uid_fkey" FOREIGN KEY ("uid") REFERENCES "User"("uid") ON DELETE RESTRICT ON UPDATE CASCADE;
