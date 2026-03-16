# Project Analysis: Agentic Digital Product Empire — Abro Digital LLC

**Analyzed:** 2025-03-16  
**Scope:** Codebase structure, workflows, documentation, config, scripts, and planning artifacts.

---

## 1. What the Project Is

### Product / Vision

- **Legal entity:** Abro Digital LLC (Wyoming single-member LLC). Owner: Maqsood Muhammad Mujtaba Abro (Seri Kembangan, Malaysia).
- **Product:** An *agentic* digital product business: AI-driven research → creation → publishing → distribution across multiple storefronts and social channels, with brand-aware and halal-compliant content.
- **Brands (DBAs under one LLC):**
  - **ClearStack Studio** — ACTIVE first launch. Productivity, organization, business, templates, planners (Notion, Canva, printables). Navy + gold aesthetic, professional-warm voice.
  - **NurturePrint** — Phase 2. Wellness, mindfulness, finance, education.
  - **PixelAura** — Phase 2. AI art, aesthetics, design, seasonal.

### Tech Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Orchestration** | n8n | All workflows (triggers, HTTP, Code, Google Sheets, webhooks). |
| **AI (local)** | Ollama | llama3, mistral, phi3 — research, creation, humanization, halal screening. |
| **AI (cloud)** | Replicate, HuggingFace | Image generation (fallback). Freepik API for covers. |
| **Data hub** | Google Sheets | Research_Opportunities, Products_Ready, Published_Products, KDP_Queue, Brand_Config_Log, Halal_Review_Log, etc. |
| **Stores** | Etsy, Gumroad, Payhip | Primary storefronts. WooCommerce (Phase 2) on WordPress. |
| **Books** | Amazon KDP, Draft2Digital, PublishDrive | eBook + low-content/coloring/activity/puzzle. |
| **Content** | WordPress (or Ghost) | Blog (09C). SEO: schema (12A), programmatic pages (12B), AI overview (12C). |
| **Email** | Brevo | Sequences (11A/B), newsletter (11C). |
| **Social** | Meta (FB/IG), TikTok, Pinterest, YouTube, Ayrshare | Posting via WF04 and content engine outputs. |
| **Media** | FFmpeg, ElevenLabs, D-ID (optional), Cloudflare R2 | Video render (09B), TTS/avatar; R2 for video storage. |
| **Infra** | Ubuntu/Debian VPS | Ollama, wkhtmltopdf, Python (mockups WF13, PDF WF02C), cron (backup, /tmp cleanup). |

There is **no application codebase** (no `package.json`, `requirements.txt`, or app repo). This repo is **config + docs**: n8n workflow JSONs, brand/config JSONs, and markdown guides.

### Main Deliverables

- **25 n8n workflow JSONs** (see Section 2).
- **Brand config:** `06_brand_config.json` (master registry + genre routing), `BRAND_VOICE_CLEARSTACK.json`, `07_halal_guardian.json` (content screening).
- **Setup/runbooks:** SETUP_GUIDE.md, ARCHITECTURE_V2.md, KDP, Content Engine, Email/SEO, ManyChat, WooCommerce, Security, LLC formation.
- **One-off scripts:** `vps_setup.sh` (Ollama, wkhtmltopdf, dirs). `fix_n8n_connections.js` / `fix_n8n_connections.py` exist but are **empty**.

---

## 2. What Is Happening (Current State)

### Implemented Workflows (by file)

| ID | File | Role | Trigger / Caller |
|----|------|------|------------------|
| 01 | `01_research_agent.json` | Weekly trend research (Etsy/Gumroad scrape, Ollama), write to Sheets | Schedule: Monday 6AM |
| 02 | `02_creation_agent.json` | Legacy creation agent | Every 6h (per SETUP_GUIDE) |
| 02B | `02B_product_creation_factory.json` | **Current** creation: AI art, eBook, printable, Notion paths → ZIP → Drive | Approval from Sheets |
| 02C | `02C_pdf_generation_pipeline.json` | PDF generation (wkhtmltopdf) | Called from 02B |
| 03 | `03_publishing_agent.json` | Publish to Etsy, Gumroad, Payhip (and trigger social) | Every 4h / after products ready |
| 04 | `04_social_agent.json` | Post to FB, IG, TikTok, Pinterest, YouTube | Webhook (from 03) |
| 05 | `05_humanization_agent.json` | Humanize copy (ebook, listing, captions) + prompt engineering | Webhook (02B, 04) |
| 06 | `06_brand_config.json` | **Brand registry** + genre→brand routing; webhook returns config | Webhook (all workflows) |
| 07 | `07_halal_guardian.json` | Halal pre-screen + Ollama review; approve/reject/flag | Webhook (02B, 04) |
| 08A | `08A_kdp_book_factory.json` | KDP book factory (eBook, low-content, coloring, activity, puzzle) | KDP_Queue status |
| 08B | `08B_book_publisher.json` | KDP manual guide + D2D/PublishDrive automation | After 08A |
| 09A | `09A_content_engine.json` | Carousel + video scripts + SEO blog + FFmpeg commands | After product publish |
| 09B | `09B_video_renderer.json` / `09B_video_engine.json` | Video render (FFmpeg; optional HeyGen/D-ID) | 09A |
| 09C | `09C_blog_publisher.json` | WordPress/Ghost post + featured image + Pinterest pins | 09A |
| 10A | `10A_internal_linking_agent.json` | Internal linking (WordPress) | 09A + schedule |
| 10B | `10B_wp_health_monitor.json` | WP health / uptime (Telegram alerts) | Schedule |
| 11A | `11A_email_sequence_writer.json` | Write email sequences (welcome, lead magnet, etc.) | Webhook |
| 11B | `11B_brevo_automation_builder.json` | Create Brevo automations + send | 11A |
| 11C | `11C_newsletter_scheduler.json` | Thursday newsletter | Thursday 9AM |
| 12A | `12A_schema_injector.json` | Schema markup injection | 09A + daily 3AM |
| 12B | `12B_programmatic_seo.json` | Programmatic SEO pages | Manual/batch |
| 12C | `12C_ai_overview_optimizer.json` | Optimize for AI citations | 09A + weekly |
| 13 | `13_mockup_generator.json` | Product mockups (Python Pillow, 5–6 images) | Creation path |

### How Pieces Connect

- **Core pipeline:** 01 (research) → human approval in Sheets → 02B (creation; calls 06, 07, 05; uses 02C for PDF, 13 for mockups) → 03 (publish) → 04 (social). 09A/B/C and 10A/12A/B/C extend published products into blog, video, carousel, and SEO.
- **Central services:** 06 (brand config) and 07 (halal check) are webhooks called by 02B, 04, and (per ARCHITECTURE_V2 patches) should be called by 01, 03, 05.
- **Google Sheets** are the shared state: research approvals, products ready, KDP queues, brand/halal logs, social logs, errors.
- **No CI/CD in repo:** Execution is inside n8n (and cron on VPS for backup/cleanup). No GitHub Actions or other CI; workflow versioning is an **open gap** (GAP_AUDIT_STATUS).

### Documentation and Runbooks

- **SETUP_GUIDE.md** — Original 4-workflow setup (01, 02, 03, 04), credentials, Sheets tabs, weekly timeline. Still references `02_creation_agent.json`.
- **ARCHITECTURE_V2.md** — Brand-aware + halal flow; 7 workflows (01, 02B, 03, 04, 05, 06, 07); integration patches for 01/02B/03/04/05; new Sheets tabs (Brand_Config_Log, Halal_Review_Log, Halal_Human_Review_Queue); ClearStack launch checklist.
- **02B_SETUP_ADDENDUM.md** — 02B replaces 02; paths (AI art, eBook, printable, Notion), ZIP, Drive; credentials.
- **05_INTEGRATION_GUIDE.md** — Where to call WF05 humanization in 02B and 04.
- **08_KDP_SETUP_GUIDE.md** — 08A/08B, Sheets (KDP_Queue, KDP_Upload_Queue), D2D/PublishDrive.
- **09_CONTENT_ENGINE_GUIDE.md** — 09A/B/C funnel, credentials (WordPress/Ghost, Replicate, etc.).
- **09A_SETUP_GUIDE.md**, **09B_SETUP_GUIDE.md** — Content engine and video setup.
- **EMAIL_AI_SEO_SETUP_GUIDE.md** — 11A/B/C (Brevo), 12A/B/C (schema, programmatic, AI overview).
- **SECURITY_CREDENTIALS_FIX.md** — Move credentials to n8n credential store; VPS backup + /tmp cleanup cron; SSH/UFW.
- **ABRO_DIGITAL_LLC_FORMATION.md** — LLC formation, EIN, Mercury, Airwallex, PayPal, tax (CPA, 1120/5472).
- **MANYCHAT_PHASE2_BLUEPRINT.md** — When to activate (e.g. 50+ IG followers), comment-to-DM flows.
- **WOOCOMMERCE_PHASE2_GUIDE.md** — When to activate (e.g. 20+ sales, 200+ subscribers), WooCommerce + plugins, WF06 WooCommerce config.
- **GAP_AUDIT_STATUS.md** — 53 gaps: 11 fixed, 7 documented (manual), 22 open, 13 skipped; prioritized list (launch blockers, Month 1–3+).

---

## 3. End Goal

### Stated or Inferred Objectives

- **Launch ClearStack Studio first:** Etsy, Gumroad, Payhip, blog, social (IG, FB, TikTok, Pinterest, YouTube), halal-compliant, brand-consistent content.
- **Scale via automation:** Research → approve → create → publish → social + content engine with minimal manual steps; human in the loop at approval and halal review queue.
- **Add brands later:** NurturePrint and PixelAura by flipping status in 06 and filling credentials (no new workflows).
- **Phase 2:** WooCommerce, ManyChat when milestones hit (documents describe when).
- **Compliance and ops:** LLC formation, banking (Mercury, Airwallex), tax filings; halal screening on all publishable content; credentials in n8n; VPS backup and /tmp cleanup.

### Roadmap (from docs and GAP_AUDIT)

- **Pre-launch:** Legal (Privacy, ToS, Refund, License, cookie consent), Etsy velocity throttle, Notion Template Gallery in 03, credentials secured.
- **Month 1:** Dashboard + Telegram /status, Etsy auto-responder, product performance → research feedback, win-back email, Umami, seasonal campaign in 01.
- **Month 2:** Workflow versioning (Git), SSL + Docker health (10B), rate limits, Ollama context guards, listing freshness, repurposing (Reddit/Quora), competitor monitoring.
- **Month 3+:** PAUSE ALL, DECISIONS.md, Open WebUI for Ollama, Portainer, underperforming product retirement, review tracking.

### Success Criteria / Target Users

- **Outcomes:** Products live on storefronts; blog and Pinterest driving search/social traffic; email sequences and newsletter running; no haram content published; multi-brand ready.
- **Target users:** Solopreneurs/freelancers/small business (ClearStack); later wellness/education (NurturePrint) and AI-art buyers (PixelAura). Owner operates and approves; no end-customer app in this repo.

---

## 4. Gaps and Ambiguities

### Missing or Weak Docs

- **No README.md or CLAUDE.md** at repo root — no one-line “what this repo is” or agent onboarding.
- **No single “start here” map** — SETUP_GUIDE (original 4 WFs) vs ARCHITECTURE_V2 (7 WFs + patches) vs 02B addendum; a new reader must reconcile which flow is current.
- **No `.planning` or `docs/`** structure beyond this analysis (`.planning/research/` created for this file).
- **.cursor/** — Not present or empty; no cursor-specific rules or project memory in repo.

### Unclear or Inconsistent Workflows

- **02 vs 02B:** Repo contains both `02_creation_agent.json` and `02B_product_creation_factory.json`. SETUP_GUIDE refers to 02; ARCHITECTURE_V2 and 02B_SETUP_ADDENDUM say 02B replaces 02. Unclear whether 02 is deprecated or still used in some environments.
- **09B:** Two files — `09B_video_renderer.json` and `09B_video_engine.json` — purpose and which is canonical is not documented in the guides sampled.
- **Patch status:** ARCHITECTURE_V2 describes *patches* (add Get Brand Config, Halal Check, etc.) to 01, 02B, 03, 04, 05. It’s not obvious from the repo whether the imported JSONs already include these patches or they must be applied manually.
- **fix_n8n_connections.js / fix_n8n_connections.py** — Both files are empty; intent (e.g. fix webhook URLs or credentials after clone) is unknown.

### Contradictions or Ambiguities

- **Workflow count:** SETUP_GUIDE says “4 workflows”; ARCHITECTURE_V2 “7 workflows”; repo has 25 JSONs. “Core” vs “extended” (09x, 10x, 11x, 12x, 13) is only clear by reading multiple docs.
- **Google Sheet tabs:** SETUP_GUIDE lists 6 tabs; ARCHITECTURE_V2 adds Brand_Config_Log, Halal_Review_Log, Halal_Human_Review_Queue and new columns; 08 and 09 guides add KDP and content tabs. No single authoritative “master list” of tabs and columns.
- **Credentials:** SECURITY_CREDENTIALS_FIX says move all to n8n; GAP_AUDIT still marks “API credentials insecure” as “documented — manual work needed.” So current state is likely still mixed (some in JSON, some in n8n).

### Open Gaps (from GAP_AUDIT_STATUS)

- **Launch blockers:** Legal policies, cookie consent, Etsy listing velocity throttle, Notion Template Gallery in 03.
- **High-value open:** Unified dashboard, Telegram /status, Etsy auto-responder, product performance → WF01 feedback, win-back sequence, Umami, seasonal calendar.
- **Technical:** Workflow versioning (Git), rate limits, SSL/Docker health, Ollama context guards, listing freshness.
- **Operational:** PAUSE ALL, DECISIONS.md, review tracking, underperforming product retirement.

### Repo Structure Summary

- **Flat root:** All workflow JSONs, brand JSONs, and markdown at root (plus `.planning/research/` now). No `workflows/`, `docs/`, `scripts/` grouping.
- **No version control metadata** in the analysis (user_info says “Is directory a git repo: No”). If Git is introduced later, tagging which JSONs match which n8n instance would help.

---

## 5. Recommendations for Future Agents and Users

1. **Add a root README.md** — One paragraph: “Abro Digital LLC agentic digital product system: n8n workflows + Google Sheets + Ollama. Start with SETUP_GUIDE and ARCHITECTURE_V2; see .planning/research/PROJECT_ANALYSIS.md for full analysis.”
2. **Add CLAUDE.md** — Short project context, stack, where workflows live, and “read GAP_AUDIT_STATUS and ARCHITECTURE_V2 before changing pipelines.”
3. **Clarify 02 vs 02B** — In SETUP_GUIDE or a single “CURRENT_WORKFLOWS.md”: state that 02B is the active creation workflow and 02 is legacy, or remove/deprecate 02 from docs.
4. **Single “Sheets master list”** — One doc or section listing every tab and required columns (research, products, KDP, brand, halal, social, errors) to avoid conflicting specs.
5. **Document 09B duality** — Which of `09B_video_renderer.json` vs `09B_video_engine.json` is in use and what the other file is for.
6. **Either implement or remove fix_n8n_connections** — If the scripts are for post-import URL/credential fixes, add a short comment or implementation; otherwise delete to avoid confusion.
7. **Use this file** — `.planning/research/PROJECT_ANALYSIS.md` as the reference for “what this project is, what’s implemented, what’s missing, and where the docs live.”

---

*End of project analysis.*
