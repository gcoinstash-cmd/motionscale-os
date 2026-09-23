-- ==============================================================================
-- MOTIONSCALE OS — SEED DATA (v1.0.0)
-- ==============================================================================

-- 1. Insert Client Review Portals
INSERT INTO public.client_portals (id, client_name, portal_slug, access_passcode_hash, nda_signed, watermark_text, status) VALUES
('b1111111-1111-1111-1111-111111111111', 'Aetherius Capital', 'aetherius-capital', 'hash_sha256_mock_aeth', true, 'AETHERIUS CAPITAL // CONFIDENTIAL', 'Active'),
('b2222222-2222-2222-2222-222222222222', 'Sterling Luxury Estates', 'sterling-estates', 'hash_sha256_mock_ster', true, 'STERLING ESTATES // EMBARGOED', 'Active'),
('b3333333-3333-3333-3333-333333333333', 'Elysium Cybernetics', 'elysium-group', 'hash_sha256_mock_elys', true, 'ELYSIUM GROUP // PRIVATE REVIEW', 'Active');

-- 2. Insert Projects & Production Pipelines
INSERT INTO public.projects (id, project_code, name, client_name, lead_animator, status, budget, progress_pct, delivery_date, predictive_delay_risk, render_time_estimate) VALUES
('c1111111-1111-1111-1111-111111111111', 'PROJ-MS-001', 'Aetherius Brand Campaign: Chronos', 'Aetherius Capital', 'Diana Prince', 'Rendering', 85000.00, 75, CURRENT_DATE + INTERVAL '12 days', 'Low', '14 hrs'),
('c2222222-2222-2222-2222-222222222222', 'PROJ-MS-002', 'Sterling Estates: Hyper-Realistic Walkthrough', 'Sterling Luxury Estates', 'Tony Stark', 'Asset Generation', 120000.00, 40, CURRENT_DATE + INTERVAL '28 days', 'Medium', '48 hrs'),
('c3333333-3333-3333-3333-333333333333', 'PROJ-MS-003', 'Elysium Cybernetic Character Short', 'Elysium Cybernetics', 'Ada Lovelace', 'Revision', 45000.00, 90, CURRENT_DATE + INTERVAL '5 days', 'High', '8 hrs'),
('c4444444-4444-4444-4444-444444444444', 'PROJ-MS-004', 'Vance Agency Luxury Logo Reveal', 'Vance Agency Ltd', 'Bruce Wayne', 'Scripting', 15000.00, 15, CURRENT_DATE + INTERVAL '45 days', 'Low', '4 hrs');

-- 3. Insert Creative Assets
INSERT INTO public.creative_assets (project_id, asset_name, version, resolution, status, cloud_storage_url, frame_count) VALUES
('c1111111-1111-1111-1111-111111111111', 'Chronos_Hero_Shot_Pass04', 'v1.4.0', '4K ProRes 4444 XQ', 'Approved', 'https://s3.motionscale.com/assets/chronos_v14.mov', 1440),
('c2222222-2222-2222-2222-222222222222', 'Sterling_Infinity_Pool_Dusk', 'v0.9.2', '8K EXR Multi-Layer', 'Pending Review', 'https://s3.motionscale.com/assets/sterling_pool_v09.exr', 960),
('c3333333-3333-3333-3333-333333333333', 'Elysium_Cyborg_Eye_Refraction', 'v2.1.0', '4K ProRes 4444', 'Pending Review', 'https://s3.motionscale.com/assets/elysium_eye_v21.mov', 480);

-- 4. Insert Financial Invoices
INSERT INTO public.financial_invoices (invoice_number, project_id, client_name, amount, milestone_type, status, due_date, paid_at) VALUES
('MS-2026-801', 'c1111111-1111-1111-1111-111111111111', 'Aetherius Capital', 42500.00, '50% Upfront Retainer', 'Paid', CURRENT_DATE - INTERVAL '15 days', CURRENT_DATE - INTERVAL '14 days'),
('MS-2026-802', 'c2222222-2222-2222-2222-222222222222', 'Sterling Luxury Estates', 60000.00, '50% Upfront Retainer', 'Paid', CURRENT_DATE - INTERVAL '10 days', CURRENT_DATE - INTERVAL '9 days'),
('MS-2026-803', 'c1111111-1111-1111-1111-111111111111', 'Aetherius Capital', 42500.00, 'Final Delivery Release', 'Draft', CURRENT_DATE + INTERVAL '12 days', NULL),
('MS-2026-804', 'c3333333-3333-3333-3333-333333333333', 'Elysium Cybernetics', 22500.00, 'Milestone 2 - 3D Draft', 'Pending Payment', CURRENT_DATE + INTERVAL '5 days', NULL);
