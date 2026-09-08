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
  leaking_workflows TEXT NOT NULL,
  biggest_bottleneck TEXT,
  owner_admin_hours TEXT NOT NULL,
  review_count TEXT NOT NULL,
  marketing_spend TEXT NOT NULL,
  urgency TEXT NOT NULL,
  budget TEXT NOT NULL,
  constraint_id TEXT,
  qualified BOOLEAN DEFAULT true
);

-- Idempotent migration for existing installs: apply.html posts these fields
-- (previously missing from the DDL, so PostgREST rejected every insert —
-- 100% of Deploy leads were silently dropped).
ALTER TABLE public.intake_submissions
  ADD COLUMN IF NOT EXISTS leaking_workflows TEXT,
  ADD COLUMN IF NOT EXISTS biggest_bottleneck TEXT,
  ADD COLUMN IF NOT EXISTS urgency TEXT,
  ADD COLUMN IF NOT EXISTS budget TEXT,
  ADD COLUMN IF NOT EXISTS constraint_id TEXT;

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
