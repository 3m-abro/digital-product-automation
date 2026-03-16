---
phase: 00-doc-launch-blocker
plan: 0.5
type: execute
wave: 1
depends_on: []
files_modified: []
autonomous: true
requirements:
  - GAP-AUDIT-CLEANUP
  - PHASE-1-READY
must_haves:
  truths:
    - Remaining gaps after Phase 0 are captured in a single doc with priorities.
    - Improvement ideas for repo usability and maintainability are listed and grounded in actual files.
    - There is a clear recommendation on repo structure and Phase 1 focus.
  artifacts:
    - path: ".planning/PHASE_0.5_OR_IMPROVEMENTS_PLAN.md"
      provides: "Central plan for post-Phase-0 gaps, improvements, optional reorg, and Phase 1 focus."
      min_lines: 40
  key_links: []
---

## A. Remaining gaps (after Phase 0)

- **Legal text still placeholder (P0)**: `LEGAL_PACK.md` sections are all `[To be filled — consult legal advisor.]`. Need at least v1 drafts + confirmation they are deployed on WordPress + store footers.
- **Cookie consent not confirmed live (P0)**: `docs/COOKIE_CONSENT_CHECKLIST.md` exists but there is no “plugin X installed on domain Y, tested on DATE” record.
- **Store credentials still “in JSON if you ever paste real keys” (P0)**: `CREDENTIALS_AUDIT.md` flags WF03 Gumroad/Etsy/Payhip as “In JSON (YOUR_*)”; migrate to n8n credentials and re‑export before using real keys.
- **Etsy velocity throttle + Notion Template Gallery still spec-only (P0/P1)**: `03_ADDENDUM.md` documents intent and manual approach, but `03_publishing_agent.json` is not confirmed to contain either yet.
- **Workflow versioning is policy-only (P2)**: `WORKFLOW_VERSIONING.md` describes the Git/tag strategy; no evidence of an actual tag baseline or practice.
- **Unified dashboard + Telegram /status (P1)**: `GAP_AUDIT_STATUS.md` still lists both as OPEN; nothing in JSONs.
- **Etsy auto-responder (P1)**: still OPEN in `GAP_AUDIT_STATUS.md`, no dedicated workflow JSON.
- **Win‑back sequence + performance feedback loop (P2)**: called out in `GAP_AUDIT_STATUS.md` and email/SEO guides, but not wired end‑to‑end.

## B. Repo improvement opportunities

1. **Tighten “start here” path (P0/P1)**  
   - `README.md` and `CLAUDE.md` are good; add a short “Onboarding path” list: (1) `README.md` → (2) `SETUP_GUIDE.md` for high‑level 4‑WF mental model → (3) `ARCHITECTURE_V2.md` for 7‑WF brand/halal pipeline → (4) `.planning/research/PROJECT_ANALYSIS.md` + this file for gaps.

2. **Explicit “Phase 0 is done” checklist (P1)**  
   - In `.planning/PHASE_0_PLAN.md` or a tiny `.planning/PHASE_0_COMPLETE.md`, copy the goal‑backward checklist results (what’s truly done vs consciously deferred) so you never have to reverse‑engineer from narrative.

3. **Credential migration “done line” (P1)**  
   - At the bottom of `CREDENTIALS_AUDIT.md` add a dated line like: “As of YYYY‑MM‑DD: all real secrets in n8n; JSONs contain only placeholders/IDs” once true.

4. **Workflow versioning baseline (P2)**  
   - Once you tag the first “Phase 0 baseline”, record it in `WORKFLOW_VERSIONING.md` (e.g. “First export/tag: workflows‑YYYY‑MM‑DD”) so future phases can refer to “pre‑Phase‑1 baseline”.

5. **Clarify manual vs automated for addenda (P2)**  
   - `03_ADDENDUM.md` is excellent spec; add a 2‑line status header: “Etsy throttle: MANUAL ONLY / IMPLEMENTED IN JSON” and same for Notion Template Gallery, to avoid ambiguity.

## C. Optional repo reorg recommendation

Current structure is basically flat: JSONs + brand/config JSONs + many Markdown guides at root, with `docs/` and `.planning/` already present. A light reorg would help navigation without breaking paths.

- **Recommendation (P2, optional “Phase 0.5: Reorg”):**
  - Keep root as the “catalog” but introduce three subdirs and move files there while leaving high‑value entrypoints at root.
  - Suggested layout:
    - `workflows/`: all `*.json` workflow exports (`01_research_agent.json`, `02B_product_creation_factory.json`, …, `13_mockup_generator.json`).
    - `docs/`: all human‑facing guides (`SETUP_GUIDE.md`, `ARCHITECTURE_V2.md`, `*_SETUP_GUIDE.md`, `*_GUIDE.md`, `GAP_AUDIT_STATUS.md`, `LEGAL_PACK.md`, etc.), keeping `README.md`, `CLAUDE.md`, `CURRENT_WORKFLOWS.md` at root.
    - `scripts/`: helper scripts like `vps_setup.sh`, `fix_n8n_connections.js`.

- **Pros:**
  - Much faster mental model: “JSONs live in `workflows/`, narrative in `docs/`, glue in `scripts/`.”
  - Easier to automate future checks (e.g. “scan workflows/*.json for secrets”, “grep docs/*.md for TODOs”).
  - Keeps root readable while still being backwards‑compatible for a while via symlinks or updated docs.

- **Cons:**
  - n8n imports/exports and older docs currently assume JSONs at root; moving them requires updating instructions in `SETUP_GUIDE.md`, `ARCHITECTURE_V2.md`, `PROJECT_ANALYSIS.md`, maybe screenshots.
  - Some external references (blog posts, notes) may mention old paths.

**If you do the reorg, treat it as a small “Phase 0.5” with tasks like:**
- Move `*.json` to `workflows/` and update `README.md`, `CLAUDE.md`, `CURRENT_WORKFLOWS.md` to say “workflows/…”.
- Move non‑entrypoint guides into `docs/` and adjust internal links (using relative paths).
- Move `vps_setup.sh` and `fix_n8n_connections.js` into `scripts/` and update mentions in `WORKFLOW_VERSIONING.md`.

## D. Suggested Phase 1 focus

Given `GAP_AUDIT_STATUS.md` and the architecture, a clean Phase 1 theme would be:

- **Phase 1: “Ops + observability for ClearStack”**  
  - Ship a minimal but real first product under ClearStack (with legal + cookie + credentials risk handled as in A).  
  - Build the **Unified dashboard + Telegram `/status`** and a simple win‑back + performance feedback loop so you can *see* how the system behaves and adapt quickly.  
  - Lock in **workflow versioning practice** (first baseline tag + a monthly tag cadence) so future architectural phases (WooCommerce, ManyChat, additional brands) can build on a stable foundation.

---

## Execution summary (Phase 0.5 reorg)

**Verified on 2025-03-16.** All items complete.

**Done (in-session):**

- **Reorg:** All `*.json` moved to **`workflows/`** (25 files). All guide markdown (except README, CLAUDE) moved to **`docs/`**. **`scripts/`** created; **`fix_n8n_connections.js`** moved there. (`vps_setup.sh` was not present in repo.)
- **Path/link updates:** README and CLAUDE updated with layout (workflows/, docs/, scripts/) and onboarding path. CURRENT_WORKFLOWS.md and WORKFLOW_VERSIONING.md updated to use `workflows/` and `scripts/` paths.
- **Improvements:** Onboarding path in README; Phase 0 complete checklist in `.planning/PHASE_0_COMPLETE.md`; credentials “done line” and baseline note in CREDENTIALS_AUDIT and WORKFLOW_VERSIONING; status header in 03_ADDENDUM (Etsy throttle + Notion Gallery = MANUAL/SPEC ONLY).

**Verification pass (2025-03-16):** Reorg and improvement artifacts confirmed. Applied path consistency: added `workflows/` prefix for workflow filenames in 02B_SETUP_ADDENDUM, 05_INTEGRATION_GUIDE, SETUP_GUIDE, ARCHITECTURE_V2, 09B_SETUP_GUIDE, CREDENTIALS_AUDIT, 03_ADDENDUM, GAP_AUDIT_STATUS. Short summary: `.planning/phases/00.5-reorg/00.5-SUMMARY.md`.

**Paths:** Guides now live under `docs/` (e.g. `docs/SETUP_GUIDE.md`, `docs/ARCHITECTURE_V2.md`, `docs/GAP_AUDIT_STATUS.md`). n8n: point imports at `workflows/` when loading JSONs.

