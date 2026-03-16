# Project context for AI agents

## What this is

Config-and-docs repo for **Abro Digital LLC**'s agentic digital product business: n8n workflow JSONs, brand/config JSONs, and markdown guides. No application codebase (no package.json/requirements.txt app). Orchestration = n8n; AI = Ollama (local) + Replicate/HuggingFace; data hub = Google Sheets; stores = Etsy, Gumroad, Payhip; content = WordPress, FFmpeg, Brevo, social APIs.

## Stack

- **n8n** — all workflows (triggers, HTTP, Code, Google Sheets, webhooks)
- **Ollama** — llama3, mistral, phi3 (research, creation, humanization, halal)
- **Google Sheets** — Research_Opportunities, Products_Ready, Published_Products, KDP_Queue, Brand_Config_Log, Halal_Review_Log, etc.
- **Stores** — Etsy, Gumroad, Payhip (WooCommerce Phase 2)
- **Content** — WordPress/Ghost, 09A/B/C (blog, video, carousel), Brevo, Ayrshare

## Where things live

- **Workflows:** All workflow and brand JSONs in `workflows/` (e.g. `workflows/01_research_agent.json`, `workflows/02B_product_creation_factory.json`, `workflows/06_brand_config.json`, `workflows/BRAND_VOICE_CLEARSTACK.json`).
- **Guides:** Setup and runbook docs in `docs/` (SETUP_GUIDE, ARCHITECTURE_V2, CURRENT_WORKFLOWS, etc.).
- **Scripts:** `scripts/` (e.g. `fix_n8n_connections.js`). n8n imports: point at `workflows/` when loading JSONs.

## Before changing pipelines

1. **Read [docs/GAP_AUDIT_STATUS.md](docs/GAP_AUDIT_STATUS.md)** — fixes, documented manual steps, open gaps, launch blockers.
2. **Read [docs/ARCHITECTURE_V2.md](docs/ARCHITECTURE_V2.md)** — brand-aware + halal flow, 7 core workflows, integration patches, Sheets structure.

Use [docs/CURRENT_WORKFLOWS.md](docs/CURRENT_WORKFLOWS.md) for which workflow is active (02B) vs legacy (02) and core vs extended set.
