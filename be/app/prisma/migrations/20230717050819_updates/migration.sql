-- DropForeignKey
ALTER TABLE "device" DROP CONSTRAINT "device_userId_fkey";

-- DropForeignKey
ALTER TABLE "incidence" DROP CONSTRAINT "incidence_userId_fkey";

-- DropForeignKey
ALTER TABLE "user_reports" DROP CONSTRAINT "user_reports_reportingUserId_fkey";

-- DropForeignKey
ALTER TABLE "user_settings" DROP CONSTRAINT "user_settings_user_id_fkey";

-- AddForeignKey
ALTER TABLE "device" ADD CONSTRAINT "device_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_settings" ADD CONSTRAINT "user_settings_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "incidence" ADD CONSTRAINT "incidence_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_reports" ADD CONSTRAINT "user_reports_reportingUserId_fkey" FOREIGN KEY ("reportingUserId") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;
