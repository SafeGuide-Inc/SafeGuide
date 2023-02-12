/*
  Warnings:

  - You are about to drop the column `email` on the `user` table. All the data in the column will be lost.
  - Added the required column `device_token` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `organization_id` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `status` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `user` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Status" AS ENUM ('Expired', 'Active', 'Invited');

-- AlterTable
ALTER TABLE "user" DROP COLUMN "email",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "device_token" TEXT NOT NULL,
ADD COLUMN     "organization_id" TEXT NOT NULL,
ADD COLUMN     "status" "Status" NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "user_id" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "devices" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "deviceToken" TEXT NOT NULL,
    "os" TEXT NOT NULL,

    CONSTRAINT "devices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "userSettings" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,

    CONSTRAINT "userSettings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "organization" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "lat" DOUBLE PRECISION NOT NULL,
    "long" DOUBLE PRECISION NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "zipcode" INTEGER NOT NULL,
    "status" "Status" NOT NULL,
    "email_domain" TEXT NOT NULL,

    CONSTRAINT "organization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "incidence" (
    "id" TEXT NOT NULL,
    "lat" TEXT NOT NULL,
    "long" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "incidence_type_id" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "incidence_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "incidenceType" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "incidenceType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "userReports" (
    "id" TEXT NOT NULL,
    "reportingUserId" TEXT NOT NULL,
    "incidenceId" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "reason" TEXT NOT NULL,

    CONSTRAINT "userReports_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "devices" ADD CONSTRAINT "devices_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "userSettings" ADD CONSTRAINT "userSettings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "incidence" ADD CONSTRAINT "incidence_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "incidence" ADD CONSTRAINT "incidence_incidence_type_id_fkey" FOREIGN KEY ("incidence_type_id") REFERENCES "incidenceType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "userReports" ADD CONSTRAINT "userReports_reportingUserId_fkey" FOREIGN KEY ("reportingUserId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
