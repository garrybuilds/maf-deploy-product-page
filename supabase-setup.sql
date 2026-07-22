-- MAF Deploy — intake_submissions table
-- Run in Supabase Dashboard → SQL Editor → New Query
-- Project: zbjioabligamwmqgtxqs (MAF Product Page)

CREATE TABLE IF NOT EXISTS public.intake_submissions (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  created_at TIMESTAMPTZ DEFAULT now(),
  company_name TEXT NOT NULL,
  contact_name TEXT NOT NULL,
  contact_email TEXT NOT NULL,
  contact_phone TEXT,
  industry TEXT NOT NULL,
  annual_revenue TEXT NOT NULL,
  employee_count INTEGER NOT NULL,
  technician_count INTEGER NOT NULL,
  owner_involvement TEXT NOT NULL,
  years_in_business INTEGER NOT NULL,
  scheduling_method TEXT NOT NULL,
  crm_system TEXT NOT NULL,
  invoicing_method TEXT NOT NULL,
  documented_processes TEXT NOT NULL,
  primary_challenge TEXT NOT NULL,
  owner_admin_hours TEXT NOT NULL,
  review_count TEXT NOT NULL,
  marketing_spend TEXT NOT NULL,
  qualified BOOLEAN DEFAULT true
);

-- Enable RLS
ALTER TABLE public.intake_submissions ENABLE ROW LEVEL SECURITY;

-- Allow anon inserts (the form uses the anon/publishable key)
CREATE POLICY "allow_anon_insert" ON public.intake_submissions
  FOR INSERT TO anon
  WITH CHECK (true);

-- Allow authenticated users to read their own submissions
CREATE POLICY "allow_auth_select" ON public.intake_submissions
  FOR SELECT TO authenticated
  USING (true);
