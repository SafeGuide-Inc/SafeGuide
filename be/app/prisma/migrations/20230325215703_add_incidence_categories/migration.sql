/*
  Warnings:

  - Added the required column `category` to the `incidence_type` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "Category" AS ENUM ('Theft', 'Violence', 'ThreateningPerson', 'SuspiciousActivity', 'Hazard', 'Search', 'EmergencyResponder', 'GeneralIncident', 'Other');

-- AlterTable
ALTER TABLE "incidence_type" ADD COLUMN     "category" "Category" NOT NULL;
