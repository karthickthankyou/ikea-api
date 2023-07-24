-- AlterTable
ALTER TABLE "Product" ALTER COLUMN "subCategory" DROP NOT NULL;

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "address" DROP NOT NULL,
ALTER COLUMN "about" DROP NOT NULL;
