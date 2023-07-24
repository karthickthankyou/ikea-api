/*
  Warnings:

  - Added the required column `support` to the `Support` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Support" ADD COLUMN     "support" TEXT NOT NULL;
