/*
  Warnings:

  - You are about to drop the column `text` on the `Option` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[email]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `number` to the `Question` table without a default value. This is not possible if the table is not empty.
  - Added the required column `total` to the `Result` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "OTP" ADD COLUMN     "used" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "Option" DROP COLUMN "text";

-- AlterTable
ALTER TABLE "Question" ADD COLUMN     "deleted" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "image" TEXT,
ADD COLUMN     "number" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "QuestionTranslation" ADD COLUMN     "explanation" TEXT;

-- AlterTable
ALTER TABLE "Result" ADD COLUMN     "total" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "Test" ADD COLUMN     "duration" INTEGER;

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "lastLogin" TIMESTAMP(3);

-- CreateTable
CREATE TABLE "OptionTranslation" (
    "id" SERIAL NOT NULL,
    "language" "Language" NOT NULL,
    "text" TEXT NOT NULL,
    "optionId" INTEGER NOT NULL,

    CONSTRAINT "OptionTranslation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserAnswer" (
    "id" SERIAL NOT NULL,
    "resultId" INTEGER NOT NULL,
    "questionId" INTEGER NOT NULL,
    "optionId" INTEGER NOT NULL,

    CONSTRAINT "UserAnswer_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "OptionTranslation" ADD CONSTRAINT "OptionTranslation_optionId_fkey" FOREIGN KEY ("optionId") REFERENCES "Option"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAnswer" ADD CONSTRAINT "UserAnswer_resultId_fkey" FOREIGN KEY ("resultId") REFERENCES "Result"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserAnswer" ADD CONSTRAINT "UserAnswer_questionId_fkey" FOREIGN KEY ("questionId") REFERENCES "Question"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
