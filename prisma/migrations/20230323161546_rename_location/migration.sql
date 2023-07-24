/*
  Warnings:

  - You are about to drop the column `support` on the `Support` table. All the data in the column will be lost.
  - Added the required column `location` to the `Support` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Support" DROP COLUMN "support",
ADD COLUMN     "location" TEXT NOT NULL;
