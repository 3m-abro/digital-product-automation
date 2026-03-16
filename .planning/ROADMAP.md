# Project Roadmap — Agentic Digital Product Empire (Abro Digital LLC)

**Scope:** Current state → ClearStack launched and scaling.  
**Reference docs:** `docs/GAP_AUDIT_STATUS.md`, `docs/ARCHITECTURE_V2.md`, `docs/CURRENT_WORKFLOWS.md`, `.planning/research/PROJECT_ANALYSIS.md`.

---

## Phases

- [x] **Phase 0: Doc + Launch-Blocker Readiness** — Onboarding, single source of truth (02B/09B/Sheets), legal placeholders, cookie checklist, credentials audit, versioning doc, WF03 addendum. *Complete.*
- [x] **Phase 0.5: Reorg + Improvements** — workflows/, docs/, scripts/; path updates; Phase 0 complete checklist; versioning baseline note; 03_ADDENDUM status. *Complete.*
- [ ] **Phase 1: Ops + Observability + First Product Live** — Close remaining launch blockers; unified dashboard; Telegram /status; Etsy auto-responder; performance→WF01; win-back; Umami; seasonal calendar; workflow versioning baseline tag.
- [ ] **Phase 2: Growth & Resilience** — Workflow versioning practice; SSL/Docker health (10B); rate limits; Ollama context guards; listing freshness; repurposing (Reddit/Quora); competitor monitoring.
- [ ] **Phase 3: Optimization & Control** — PAUSE ALL; DECISIONS.md; Open WebUI; Portainer; underperforming product retirement; review tracking.
- [ ] **Phase 4: Scale & Multi-Channel** — WooCommerce, ManyChat (milestone-triggered); multi-brand (NurturePrint, PixelAura).

---

## Phase Details

### Phase 0: Doc + Launch-Blocker Readiness ✅

**Goal:** Onboard anyone from the repo, remove doc ambiguities, and address launch blockers so the first ClearStack product can go live without legal or platform risk.

**Status:** Complete. See `.planning/PHASE_0_COMPLETE.md` and `docs/03_ADDENDUM.md`.

**Delivered:** README, CLAUDE, CURRENT_WORKFLOWS (02B active, 02 legacy), 09B canonical doc, SHEETS_MASTER_LIST, fix_n8n_connections, LEGAL_PACK placeholders, COOKIE_CONSENT_CHECKLIST, CREDENTIALS_AUDIT, WORKFLOW_VERSIONING doc, WF03 Etsy/Notion documented as manual/spec.

**Success Criteria (verified):**
1. New reader can open README and know what the repo is and where to go next.
2. CLAUDE directs to GAP_AUDIT_STATUS and ARCHITECTURE_V2 before changing pipelines.
3. CURRENT_WORKFLOWS states 02B active, 02 legacy; Sheets master list exists.
4. Legal pack placeholders and cookie checklist exist; WF03 throttle/Notion documented.

---

### Phase 0.5: Reorg + Improvements ✅

**Goal:** Improve repo navigation and lock in post–Phase 0 state (paths, baseline, status headers).

**Status:** Complete. See `.planning/PHASE_0.5_OR_IMPROVEMENTS_PLAN.md` and `.planning/phases/00.5-reorg/00.5-SUMMARY.md`.

**Delivered:** All workflow JSONs in `workflows/`, guides in `docs/`, `scripts/` with fix_n8n_connections.js; README/CLAUDE path updates; PHASE_0_COMPLETE.md; credentials “done line” and versioning baseline note in docs; 03_ADDENDUM status header (Etsy/Notion = MANUAL/SPEC ONLY).

**Success Criteria (verified):**
1. n8n imports point at `workflows/`; docs reference `docs/` and `scripts/`.
2. Phase 0 complete checklist and reorg summary exist.

---

### Phase 1: Ops + Observability + First Product Live

**Goal:** Ship a minimal first ClearStack product with legal/cookie/credentials risk closed, and establish ops visibility (dashboard, Telegram /status, win-back, performance feedback, versioning baseline).

**Depends on:** Phase 0, Phase 0.5.

**Requirements / Gaps closed (from GAP_AUDIT_STATUS):**
- **Launch blockers:** Legal v1 drafts + deployed (Privacy, ToS, Refund, License); cookie consent confirmed live on WordPress (plugin + domain + test date); store credentials migrated to n8n; Etsy listing velocity throttle in WF03 or explicitly manual; Notion Template Gallery in WF03 or explicitly manual.
- **Month 1:** Unified dashboard; Telegram /status command; Etsy auto-responder (e.g. WF14); product performance → WF01 feedback loop; win-back email sequence (finish WF11A); self-hosted Umami on VPS; seasonal campaign calendar in WF01.
- **Versioning:** First workflow export baseline tag (e.g. `workflows-YYYY-MM-DD`) recorded in `docs/WORKFLOW_VERSIONING.md`.

**Success Criteria (what must be TRUE when Phase 1 completes):**
1. At least one ClearStack product is live on Etsy/Gumroad/Payhip with legal policies and cookie consent in place and credentials in n8n.
2. Owner can open a single dashboard (or Telegram /status) and see pipeline health, recent runs, and key metrics.
3. Owner can trigger or receive Telegram /status and get a concise system status.
4. Win-back sequence is wired in WF11A and sendable; product performance data feeds back into research (WF01) in some form.
5. Umami (or equivalent) is installed and receiving traffic from store/blog.
6. WF01 uses a seasonal campaign calendar (or documented manual calendar) for Etsy.
7. Workflow versioning has a first baseline tag and is documented; future phases can refer to “pre–Phase 1 baseline.”

**Main Deliverables:**
- Legal v1 text in `docs/legal/` or LEGAL_PACK + deployment checklist (WordPress + store footers).
- Cookie consent: plugin + domain + test date recorded (e.g. in COOKIE_CONSENT_CHECKLIST or CREDENTIALS_AUDIT).
- CREDENTIALS_AUDIT updated with “As of DATE: all real secrets in n8n” when done.
- WF03: Etsy throttle and/or Notion Gallery implemented in `workflows/03_publishing_agent.json`, or 03_ADDENDUM updated to “MANUAL ONLY” with date.
- Unified dashboard (e.g. Sheets-based or simple web view) and/or Telegram bot with /status.
- Etsy auto-responder workflow (e.g. `workflows/14_etsy_auto_responder.json` or equivalent).
- WF11A win-back prompt and automation; WF01 performance feedback (e.g. new tab or columns + logic).
- Umami (or Plausible) on VPS; docs updated.
- Seasonal calendar in WF01 or doc (e.g. `docs/SEASONAL_CAMPAIGN_CALENDAR.md`).
- First versioning baseline tag and note in WORKFLOW_VERSIONING.md.

**Plans:** TBD (use `/gsd:plan-phase 1` or equivalent).

---

### Phase 2: Growth & Resilience

**Goal:** Harden the pipeline (versioning practice, health checks, rate limits, context safety) and add growth levers (listing freshness, repurposing, competitor input).

**Depends on:** Phase 1.

**Requirements / Gaps closed:**
- Workflow versioning in practice (Git export + private repo + monthly tag cadence).
- SSL expiry monitoring and Docker container health in WF10B.
- Rate limit protection across API calls (Etsy and others).
- Ollama context length guards before AI calls.
- Listing freshness workflow (e.g. 30-day refresh for Etsy).
- Content repurposing to Reddit/Quora (workflow or documented process).
- Competitor monitoring in WF01 (or separate workflow feeding research).

**Success Criteria:**
1. Workflows are exported to Git on a defined cadence; tags exist for “Phase 1 baseline” and at least one later export.
2. WF10B (or equivalent) reports SSL expiry and Docker/container health; alerts (e.g. Telegram) on failure.
3. Etsy (and other high-risk APIs) are rate-limited in code or workflow.
4. Ollama calls check input length (or truncate) to avoid context overflow.
5. Listings older than 30 days can be refreshed (workflow or manual checklist).
6. Blog/content repurposing to Reddit/Quora is implemented or documented with clear steps.
7. Competitor or market signals feed into research (WF01 or linked process).

**Main Deliverables:**
- WORKFLOW_VERSIONING.md updated with cadence and tag history.
- WF10B (or new node) with SSL + Docker health checks; docs updated.
- Rate limiting in WF03 and any other workflows calling Etsy/API.
- Ollama context guard (Code node or wrapper) in 01, 02B, 05, 07 as needed.
- Listing freshness workflow or doc (e.g. `workflows/15_listing_freshness.json` or doc).
- Reddit/Quora repurposing workflow or `docs/CONTENT_REPURPOSING.md`.
- Competitor/market input to WF01 (new node or Sheet column + logic).

**Plans:** TBD.

---

### Phase 3: Optimization & Control

**Goal:** Give the owner control (PAUSE ALL, DECISIONS log) and optimization tools (retirement, reviews, local testing).

**Depends on:** Phase 2.

**Requirements / Gaps closed:**
- PAUSE ALL mechanism (single switch or workflow to stop scheduled/triggered runs).
- DECISIONS.md created and linked (manual log for key product/ops decisions).
- Open WebUI for Ollama (local prompt testing).
- Portainer for Docker management (optional, low priority).
- Underperforming product retirement workflow (e.g. 90-day zero-sales check).
- Review tracking system (post-purchase review collection and tracking).

**Success Criteria:**
1. Owner can pause all non-manual workflow execution from one place (variable, env, or “pause” workflow).
2. DECISIONS.md exists and is referenced in README or CLAUDE for major decisions.
3. Open WebUI (or equivalent) is available for Ollama prompt testing.
4. Underperforming products are identified (e.g. by 90-day rule) and retirement process is documented or automated.
5. Reviews are collected and visible (e.g. Sheet tab or dashboard).

**Main Deliverables:**
- PAUSE ALL: global variable or workflow + doc (e.g. `docs/PAUSE_ALL.md`).
- `.planning/DECISIONS.md` or `docs/DECISIONS.md` with template.
- Open WebUI (and optionally Portainer) setup in docs.
- Retirement workflow or `docs/UNDERPERFORMING_PRODUCT_RETIREMENT.md`.
- Review tracking (Sheet + optional workflow or integration).

**Plans:** TBD.

---

### Phase 4: Scale & Multi-Channel

**Goal:** Add WooCommerce, ManyChat, and second/third brands when milestones are hit; ClearStack scaling.

**Depends on:** Phase 3 (and milestone triggers per guides).

**Requirements / Gaps closed:**
- WooCommerce: when 20+ sales and 200+ subscribers (per `docs/WOOCOMMERCE_PHASE2_GUIDE.md`); WF06 WooCommerce config; storefront on WordPress.
- ManyChat: when 50+ IG followers (per `docs/MANYCHAT_PHASE2_BLUEPRINT.md`); comment-to-DM flows.
- Multi-brand: NurturePrint, PixelAura activated in WF06; credentials and routing; no new workflows, only config.

**Success Criteria:**
1. WooCommerce store is live and connected to WF06 (or equivalent) when milestones are met.
2. ManyChat (or equivalent) is active for Instagram when follower milestone is met.
3. A second brand (NurturePrint or PixelAura) can be switched to ACTIVE in WF06 and pipeline routes to it without new workflow JSONs.

**Main Deliverables:**
- WooCommerce setup and WF06 (or new) integration; docs updated.
- ManyChat flows and doc update.
- WF06 brand registry updated with second/third brand; credential fill and status flip; ARCHITECTURE_V2 “5-minute add” verified.

**Plans:** TBD.

---

## Requirement Mapping (GAP_AUDIT → Phases)

| GAP_AUDIT item | Phase | Notes |
|----------------|-------|--------|
| Legal (Privacy, ToS, Refund, License) | 1 | v1 drafts + deployed |
| Cookie consent live | 1 | Plugin + domain + test date |
| Store credentials in n8n | 1 | Migrate; update CREDENTIALS_AUDIT |
| Etsy listing velocity throttle | 1 | In WF03 or documented manual |
| Notion Template Gallery | 1 | In WF03 or documented manual |
| Unified dashboard | 1 | |
| Telegram /status | 1 | |
| Etsy auto-responder | 1 | e.g. WF14 |
| Product performance → WF01 | 1 | |
| Win-back email sequence | 1 | WF11A |
| Umami analytics | 1 | |
| Seasonal campaign calendar | 1 | WF01 or doc |
| Workflow versioning (baseline tag) | 1 | First tag + doc |
| Workflow versioning (practice) | 2 | Git + cadence |
| SSL + Docker health (10B) | 2 | |
| Rate limit protection | 2 | |
| Ollama context guards | 2 | |
| Listing freshness (30-day) | 2 | |
| Content repurposing (Reddit/Quora) | 2 | |
| Competitor monitoring | 2 | |
| PAUSE ALL | 3 | |
| DECISIONS.md | 3 | |
| Open WebUI (Ollama) | 3 | |
| Portainer | 3 | Optional |
| Underperforming product retirement | 3 | |
| Review tracking | 3 | |
| WooCommerce | 4 | Milestone-triggered |
| ManyChat | 4 | Milestone-triggered |
| Multi-brand (NurturePrint, PixelAura) | 4 | WF06 status + credentials |

*Gaps already FIXED or DOCUMENTED in GAP_AUDIT (e.g. VPS backup, /tmp cleanup, R2, mockups, brand voice, credentials doc) are not re-listed; they remain as-is.*

---

## Progress Table

| Phase | Key Deliverables | Status | Completed |
|-------|------------------|--------|-----------|
| 0. Doc + Launch-Blocker | README, CLAUDE, CURRENT_WORKFLOWS, Sheets list, legal placeholders, cookie checklist, credentials audit, versioning doc, 03_ADDENDUM | Done | — |
| 0.5. Reorg + Improvements | workflows/, docs/, scripts/; path updates; Phase 0 checklist; versioning baseline note | Done | — |
| 1. Ops + First Product Live | Legal v1, cookie live, credentials in n8n, dashboard, /status, Etsy responder, performance→WF01, win-back, Umami, seasonal, versioning tag | Not started | — |
| 2. Growth & Resilience | Versioning practice, 10B health, rate limits, Ollama guards, listing freshness, repurposing, competitor input | Not started | — |
| 3. Optimization & Control | PAUSE ALL, DECISIONS.md, Open WebUI, retirement, review tracking | Not started | — |
| 4. Scale & Multi-Channel | WooCommerce, ManyChat, multi-brand | Not started | — |

---

## References

- **Current workflows:** `docs/CURRENT_WORKFLOWS.md` (02B active, 02 legacy; core vs extended).
- **Architecture:** `docs/ARCHITECTURE_V2.md` (7 core workflows, brand/halal, Sheets, patches).
- **Gaps:** `docs/GAP_AUDIT_STATUS.md` (53 gaps: fixed, documented, open, skipped; launch blockers, Month 1–3+).
- **Project context:** `.planning/research/PROJECT_ANALYSIS.md`.
- **Phase 0 plan:** `.planning/PHASE_0_PLAN.md`; completion: `.planning/PHASE_0_COMPLETE.md`.
- **Phase 0.5 plan:** `.planning/PHASE_0.5_OR_IMPROVEMENTS_PLAN.md`; reorg summary: `.planning/phases/00.5-reorg/00.5-SUMMARY.md`.
