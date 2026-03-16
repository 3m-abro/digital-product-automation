# Phase 0: Doc + Launch-Blocker Readiness

**Phase goal:** Onboard anyone (human or agent) from the repo, remove doc ambiguities (02/02B, 09B, Sheets), and address launch blockers so the first ClearStack product can go live without legal or platform risk.

**Success criteria (goal-backward):**
- README.md and CLAUDE.md exist at repo root; PROJECT_ANALYSIS is linked as the reference for "what this project is."
- Single source of truth for current workflows (02B active, 02 legacy) and for 09B canonical file.
- One authoritative "Sheets master list" (all tabs and required columns).
- Legal pack: placeholders or one doc with sections for Privacy, ToS, Refund, Digital Product License.
- Cookie consent: checklist for WordPress so GDPR risk is addressed.
- WF03: Etsy listing velocity throttle implemented or explicitly documented as manual.
- WF03: Notion Template Gallery publish path added or documented as manual.
- Credentials: audit doc listing what is still in JSON vs n8n (per SECURITY_CREDENTIALS_FIX.md).
- Workflow versioning: approach documented (Git export + tag strategy).

---

## Task breakdown (ordered with dependencies)

| ID | Task | Depends on | Files created/updated |
|----|------|------------|------------------------|
| T1 | Add README.md — one paragraph (Abro Digital LLC agentic system: n8n + Sheets + Ollama), link to .planning/research/PROJECT_ANALYSIS.md, "Start with SETUP_GUIDE and ARCHITECTURE_V2." | — | `README.md` |
| T2 | Add CLAUDE.md — project context, stack (n8n, Ollama, Sheets, stores), where workflows live (root JSONs), "Read GAP_AUDIT_STATUS and ARCHITECTURE_V2 before changing pipelines." | — | `CLAUDE.md` |
| T3 | Create CURRENT_WORKFLOWS.md — state 02B is the active creation workflow, 02 is legacy/deprecated; list core (01, 02B, 03, 04, 05, 06, 07) vs extended (08x, 09x, 10x, 11x, 12x, 13); reference SETUP_GUIDE vs ARCHITECTURE_V2 for which flow is current. | T1 | `CURRENT_WORKFLOWS.md` |
| T4 | Document 09B duality — in 09B_SETUP_GUIDE.md add a "Which file?" section: state whether 09B_video_renderer.json or 09B_video_engine.json is canonical and what the other file is for (backup, deprecated, alternate). | — | `09B_SETUP_GUIDE.md` |
| T5 | Create Sheets master list — one doc (e.g. SHEETS_MASTER_LIST.md) listing every tab (Research_Opportunities, Products_Ready, Published_Products, Social_Posts_Log, Weekly_Dashboard, Error_Log, Brand_Config_Log, Halal_Review_Log, Halal_Human_Review_Queue, KDP_Queue, etc.) and required columns; source from SETUP_GUIDE, ARCHITECTURE_V2, 02B_SETUP_ADDENDUM, 08_KDP_SETUP_GUIDE, 09 guides. | — | `SHEETS_MASTER_LIST.md` |
| T6 | fix_n8n_connections — either implement a minimal script that documents intent (e.g. fix webhook base URL or credential refs after clone) or add a one-line comment in each file and remove the empty file for the other language (keep one). | — | `fix_n8n_connections.js` or `fix_n8n_connections.py`, or delete one + comment in the other |
| T7 | Legal pack — create docs/legal/ with placeholder files or a single LEGAL_PACK.md with sections: Privacy Policy, Terms of Service, Refund Policy, Digital Product License Terms. Content can be "[To be filled — consult legal advisor]" plus 1–2 sentence scope each. | — | `docs/legal/*.md` or `LEGAL_PACK.md` |
| T8 | Cookie consent checklist — create docs/COOKIE_CONSENT_CHECKLIST.md (or COOKIE_CONSENT_WORDPRESS.md) with steps to add a cookie consent banner on WordPress (plugin options or manual), GDPR-relevant items, link to legal pack. | — | `docs/COOKIE_CONSENT_CHECKLIST.md` or `COOKIE_CONSENT_WORDPRESS.md` |
| T9 | Credentials audit — create CREDENTIALS_AUDIT.md listing each workflow/feature and whether credentials live in JSON (insecure) or n8n credential store; follow SECURITY_CREDENTIALS_FIX.md; add "Next: migrate remaining to n8n" if any still in JSON. | T5 or T7 | `CREDENTIALS_AUDIT.md` |
| T10 | Workflow versioning doc — add WORKFLOW_VERSIONING.md (or section in SETUP_GUIDE) describing: export from n8n, private Git repo, tag strategy (e.g. tag JSONs with date or version), so future work can implement it. | — | `WORKFLOW_VERSIONING.md` or `SETUP_GUIDE.md` |
| T11 | WF03 Etsy velocity throttle — add rate limiting to 03_publishing_agent.json for Etsy API calls (e.g. max 10 req/sec or per Etsy’s documented limit); document in 03 or in a short 03_ADDENDUM if logic is in Code node. | — | `03_publishing_agent.json` (+ optional `03_ADDENDUM.md`) |
| T12 | WF03 Notion Template Gallery — add Notion Template Gallery publish path to 03_publishing_agent.json (branch or step that publishes to Notion’s template gallery when product type is Notion); or document in 03_ADDENDUM as manual step until implemented. | T11 (same file) | `03_publishing_agent.json` (or `03_ADDENDUM.md`) |

---

## Dependency graph

```
Wave 1 (parallel):
  T1 ──┬──► T3
  T2   │
  T4   │
  T5 ──┼──► T9
  T6   │
  T7 ──┘
  T8
  T10

Wave 2 (after Wave 1):
  T9 (after T5 or T7)

Wave 3 (sequential, same file):
  T11 (Etsy throttle) ──► T12 (Notion Gallery)
```

- **Parallel:** T1, T2, T4, T5, T6, T7, T8, T10 can all run in parallel. T3 after T1. T9 after T5 or T7 (or after T1 if no doc structure dependency).
- **Sequential:** T12 (Notion in WF03) should run after T11 (Etsy throttle in WF03) to avoid merge conflicts on `03_publishing_agent.json`; if one executor does both, they can be one combined task.

---

## Goal-backward verification checklist

Use this to verify the phase goal is met before marking Phase 0 complete.

- [ ] **Onboarding:** A new reader can open README.md and know what the repo is and where to go next (PROJECT_ANALYSIS, SETUP_GUIDE, ARCHITECTURE_V2).
- [ ] **Agent onboarding:** CLAUDE.md exists and directs to GAP_AUDIT_STATUS and ARCHITECTURE_V2 before changing pipelines.
- [ ] **02 vs 02B:** CURRENT_WORKFLOWS.md states 02B is active, 02 is legacy; SETUP_GUIDE or CURRENT_WORKFLOWS references which doc describes current flow.
- [ ] **09B:** 09B_SETUP_GUIDE.md (or equivalent) states which of 09B_video_renderer.json vs 09B_video_engine.json is canonical.
- [ ] **Sheets:** One doc lists all tabs and required columns with no conflicting specs across SETUP_GUIDE / ARCHITECTURE_V2 / 08 / 09.
- [ ] **fix_n8n_connections:** Either implemented with clear intent or one file removed and the other commented; no empty dual files.
- [ ] **Legal:** Placeholder or single Legal Pack doc exists with Privacy, ToS, Refund, License sections.
- [ ] **Cookie consent:** Checklist exists for WordPress cookie consent (GDPR).
- [ ] **Credentials:** CREDENTIALS_AUDIT.md exists and lists in-JSON vs n8n per SECURITY_CREDENTIALS_FIX.
- [ ] **Versioning:** WORKFLOW_VERSIONING.md or SETUP_GUIDE section describes Git export + tag strategy.
- [ ] **Etsy throttle:** WF03 has Etsy listing velocity throttle implemented or explicitly documented as manual in 03 or addendum.
- [ ] **Notion Gallery:** WF03 has Notion Template Gallery path or it is documented as manual in 03 or addendum.

---

## Execution notes

- **Atomic tasks:** Each task above is one deliverable (e.g. "Add README.md with one paragraph and link to PROJECT_ANALYSIS" — not "improve docs").
- **Actual filenames:** README.md, CLAUDE.md, CURRENT_WORKFLOWS.md, 09B_SETUP_GUIDE.md, SHEETS_MASTER_LIST.md, fix_n8n_connections.js/.py, docs/legal/ or LEGAL_PACK.md, docs/COOKIE_CONSENT_CHECKLIST.md, CREDENTIALS_AUDIT.md, WORKFLOW_VERSIONING.md, 03_publishing_agent.json, optional 03_ADDENDUM.md.
- **References:** All references (PROJECT_ANALYSIS, GAP_AUDIT_STATUS, ARCHITECTURE_V2, SETUP_GUIDE, SECURITY_CREDENTIALS_FIX, GAP_AUDIT launch blockers) point to existing files in the repo or this plan.
- **WF03 changes:** T11 and T12 modify `03_publishing_agent.json`; run T11 then T12, or combine into one task that does both Etsy throttle and Notion path.

---

## Output

**Phase 0 complete.** README and CLAUDE added; CURRENT_WORKFLOWS (02B active, 02 legacy, core vs extended); 09B_SETUP_GUIDE "Which file?" section (09B_video_engine.json canonical); SHEETS_MASTER_LIST with all tabs and required columns; fix_n8n_connections resolved via single fix_n8n_connections.js with documented intent (webhook base URL after clone); legal pack placeholders in LEGAL_PACK.md (Privacy, ToS, Refund, Digital Product License); cookie checklist in docs/COOKIE_CONSENT_CHECKLIST.md; CREDENTIALS_AUDIT per SECURITY_CREDENTIALS_FIX; WORKFLOW_VERSIONING (Git export + tag strategy); WF03 Etsy velocity throttle and Notion Template Gallery documented as manual/spec in 03_ADDENDUM.md until implemented in n8n. Goal-backward verification checklist satisfied.
