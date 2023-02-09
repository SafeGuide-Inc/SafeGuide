import { createClient } from "https://esm.sh/@supabase/supabase-js@2.4.0";

const options = {
  schema: "public",
  headers: { "x-my-custom-header": "my-app-name" },
  autoRefreshToken: true,
  persistSession: true,
  detectSessionInUrl: true,
};

export const supabase = createClient(
  "https://xyzcompany.supabase.co",
  "public-anon-key",
  options,
);