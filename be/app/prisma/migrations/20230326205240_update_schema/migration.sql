-- AlterTable
ALTER TABLE "device" RENAME CONSTRAINT "devices_pkey" TO "device_pkey";

-- AlterTable
ALTER TABLE "user_reports" RENAME CONSTRAINT "userReports_pkey" TO "user_reports_pkey";

-- AlterTable
ALTER TABLE "user_settings" RENAME CONSTRAINT "userSettings_pkey" TO "user_settings_pkey";

-- RenameForeignKey
ALTER TABLE "user_reports" RENAME CONSTRAINT "userReports_reportingUserId_fkey" TO "user_reports_reportingUserId_fkey";

-- RenameForeignKey
ALTER TABLE "user_settings" RENAME CONSTRAINT "userSettings_user_id_fkey" TO "user_settings_user_id_fkey";
