# Workflow versioning — Git export and tag strategy

n8n workflows in this repo are stored as JSON files at the repo root. This doc describes how to version them so future work can implement a repeatable process.

---

## Current state

- Workflow definitions live as **exported JSON** (e.g. `01_research_agent.json`, `03_publishing_agent.json`).
- There is **no automated sync** between n8n and this repo; exports are manual.
- GAP_AUDIT_STATUS marks “No workflow versioning (Git)” as OPEN.

---

## Recommended approach

### 1. Export from n8n

- In n8n: Workflow → menu (⋮) → **Download** (or Export).
- Save to repo root with the existing naming (e.g. `03_publishing_agent.json`).
- **Do not commit secrets:** Use n8n credential references; no API keys in JSON (see SECURITY_CREDENTIALS_FIX.md and CREDENTIALS_AUDIT.md).

### 2. Private Git repo

- Keep this repo **private** (or a dedicated private repo for workflow JSONs).
- Commit exported JSONs so changes are tracked and recoverable.

### 3. Tag strategy

- **Option A — Date-based:** Tag releases with date, e.g. `workflows-2025-03-16`. Easy to match “what was running on this day.”
- **Option B — Version:** Tag with semantic-ish version, e.g. `v0.3.1`, and keep a CHANGELOG or commit messages that describe what changed.
- **Option C — Both:** Branch `main` (or `workflows`) for latest export; tags for releases (date or version).

Example:

```bash
git tag workflows-2025-03-16
git push origin workflows-2025-03-16
```

### 4. Import into a new n8n instance

- Clone repo → import each JSON via n8n “Import from File.”
- Recreate credentials in n8n (no keys in JSON).
- If webhook base URL differs, run or adapt `fix_n8n_connections.js` (see repo root).

---

## Future implementation

- **Automation:** Optional script or cron to export from n8n API (if available) and commit to repo.
- **CI:** Optional check that JSON is valid and that no known secret patterns appear in diffs.
- **Single source of truth:** Decide whether “source” is n8n UI (export → commit) or this repo (import into n8n after edit). Today the plan is **n8n as source**, export → commit → tag.

This document can be extended with concrete commands once a tagging schedule is chosen. See also CURRENT_WORKFLOWS.md for which workflows are active.
