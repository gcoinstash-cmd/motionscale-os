-- ==============================================================================
-- MOTIONSCALE OS — SUPABASE DATABASE SCHEMA (v1.0.0)
-- High-Ticket 3D Motion Design, CGI VFX Pipeline & Client Escrow OS
-- ==============================================================================

-- 1. Enable UUID Extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 2. Projects & Production Pipelines Table
CREATE TABLE IF NOT EXISTS public.projects (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_code VARCHAR(32) NOT NULL UNIQUE, -- e.g. 'PROJ-MS-001'
    name VARCHAR(255) NOT NULL,
    client_name VARCHAR(255) NOT NULL,
    lead_animator VARCHAR(128) NOT NULL,
    status VARCHAR(64) NOT NULL DEFAULT 'Scripting', -- 'Scripting', 'Asset Generation', 'Rendering', 'Revision', 'Completed'
    budget NUMERIC(12, 2) NOT NULL DEFAULT 50000.00,
    progress_pct INTEGER NOT NULL DEFAULT 0 CHECK (progress_pct >= 0 AND progress_pct <= 100),
    delivery_date DATE NOT NULL,
    predictive_delay_risk VARCHAR(32) NOT NULL DEFAULT 'Low', -- 'Low', 'Medium', 'High'
    render_time_estimate VARCHAR(64) NOT NULL DEFAULT '12 hrs',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Creative Assets & Review Versioning Table
CREATE TABLE IF NOT EXISTS public.creative_assets (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    project_id UUID REFERENCES public.projects(id) ON DELETE CASCADE,
    asset_name VARCHAR(255) NOT NULL,
    version VARCHAR(32) NOT NULL DEFAULT 'v1.0.0',
    resolution VARCHAR(32) NOT NULL DEFAULT '4K ProRes 4444',
    status VARCHAR(64) NOT NULL DEFAULT 'Pending Review', -- 'Drafting', 'Pending Review', 'Approved', 'Locked'
    cloud_storage_url TEXT NOT NULL,
    frame_count INTEGER NOT NULL DEFAULT 720,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 4. Client Review Portals Table
CREATE TABLE IF NOT EXISTS public.client_portals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    client_name VARCHAR(255) NOT NULL,
    portal_slug VARCHAR(64) NOT NULL UNIQUE,
    access_passcode_hash VARCHAR(255) NOT NULL,
    nda_signed BOOLEAN NOT NULL DEFAULT true,
    watermark_text VARCHAR(128) NOT NULL DEFAULT 'CONFIDENTIAL // PRE-RELEASE',
    status VARCHAR(32) NOT NULL DEFAULT 'Active',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. Financial Ledger & Milestone Invoices Table
CREATE TABLE IF NOT EXISTS public.financial_invoices (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    invoice_number VARCHAR(32) NOT NULL UNIQUE, -- e.g. 'MS-2026-801'
    project_id UUID REFERENCES public.projects(id) ON DELETE SET NULL,
    client_name VARCHAR(255) NOT NULL,
    amount NUMERIC(12, 2) NOT NULL,
    milestone_type VARCHAR(64) NOT NULL DEFAULT '50% Upfront Retainer', -- '50% Upfront Retainer', 'Milestone 2 - 3D Draft', 'Final Delivery Release'
    status VARCHAR(32) NOT NULL DEFAULT 'Draft', -- 'Draft', 'Pending Payment', 'Paid'
    due_date DATE NOT NULL,
    paid_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 6. Enable Row Level Security (RLS)
ALTER TABLE public.projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.creative_assets ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.client_portals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.financial_invoices ENABLE ROW LEVEL SECURITY;

-- 7. Public Read & Access Policies
CREATE POLICY "Allow public read access to active projects summary" 
    ON public.projects FOR SELECT USING (true);

CREATE POLICY "Allow authenticated read to creative assets" 
    ON public.creative_assets FOR SELECT USING (true);

CREATE POLICY "Allow public read access to client portals" 
    ON public.client_portals FOR SELECT USING (true);

CREATE POLICY "Allow authenticated insert to financial invoices" 
    ON public.financial_invoices FOR INSERT WITH CHECK (true);
