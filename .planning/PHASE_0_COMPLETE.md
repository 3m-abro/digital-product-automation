# Phase 0 complete — checklist

Phase 0 (Doc + Launch-Blocker Readiness) delivered the following. Use this as the single checklist for “what’s done” vs “consciously deferred.”

## Delivered

- [x] **README.md** and **CLAUDE.md** at repo root; PROJECT_ANALYSIS linked as reference.
- [x] **CURRENT_WORKFLOWS.md** (in docs/) — 02B active, 02 legacy; core vs extended; workflow paths under `workflows/`.
- [x] **09B_SETUP_GUIDE.md** (in docs/) — canonical file: `09B_video_engine.json`; alternate: `09B_video_renderer.json`.
- [x] **SHEETS_MASTER_LIST.md** (in docs/) — all tabs and required columns.
- [x] **fix_n8n_connections.js** — implemented (post-clone webhook base URL); in `scripts/`. Empty `.py` removed.
- [x] **LEGAL_PACK.md** (in docs/) — placeholders for Privacy, ToS, Refund, Digital Product License.
- [x] **docs/COOKIE_CONSENT_CHECKLIST.md** — WordPress cookie consent + GDPR checklist.
- [x] **CREDENTIALS_AUDIT.md** (in docs/) — in-JSON vs n8n by workflow; migration status line at bottom.
- [x] **WORKFLOW_VERSIONING.md** (in docs/) — export from n8n, Git, tag strategy; baseline placeholder.
- [x] **03_ADDENDUM.md** (in docs/) — Etsy velocity throttle and Notion Template Gallery as manual/spec; status header added.

## Consciously deferred (not in Phase 0 scope)

- **Legal text:** LEGAL_PACK sections are placeholders; real drafts and deployment on WordPress/store footers are later.
- **Cookie consent live:** Checklist exists; no “plugin X on domain Y, tested DATE” record yet.
- **WF03 credentials:** Still in JSON (YOUR_*); migration to n8n and re-export when using real keys.
- **Etsy throttle + Notion Gallery in JSON:** Documented in 03_ADDENDUM only; not yet implemented in `workflows/03_publishing_agent.json`.
- **Workflow versioning in practice:** Policy doc and baseline placeholder exist; first tag and cadence TBD.

See **.planning/PHASE_0_PLAN.md** for full task list and **.planning/PHASE_0.5_OR_IMPROVEMENTS_PLAN.md** for remaining gaps and Phase 1 focus.
