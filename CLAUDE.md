# Project context for AI agents

## What this is

Config-and-docs repo for **Abro Digital LLC**'s agentic digital product business: n8n workflow JSONs, brand/config JSONs, and markdown guides. No application codebase (no package.json/requirements.txt app). Orchestration = n8n; AI = Ollama (local) + Replicate/HuggingFace; data hub = Google Sheets; stores = Etsy, Gumroad, Payhip; content = WordPress, FFmpeg, Brevo, social APIs.

## Stack

- **n8n** — all workflows (triggers, HTTP, Code, Google Sheets, webhooks)
- **Ollama** — llama3, mistral, phi3 (research, creation, humanization, halal)
- **Google Sheets** — Research_Opportunities, Products_Ready, Published_Products, KDP_Queue, Brand_Config_Log, Halal_Review_Log, etc.
- **Stores** — Etsy, Gumroad, Payhip (WooCommerce Phase 2)
- **Content** — WordPress/Ghost, 09A/B/C (blog, video, carousel), Brevo, Ayrshare

## Where workflows live

Workflow JSONs are at **repo root** (e.g. `01_research_agent.json`, `02B_product_creation_factory.json`, `03_publishing_agent.json`). Brand/config: `06_brand_config.json`, `BRAND_VOICE_CLEARSTACK.json`, `07_halal_guardian.json`.

## Before changing pipelines

1. **Read [GAP_AUDIT_STATUS.md](GAP_AUDIT_STATUS.md)** — fixes, documented manual steps, open gaps, launch blockers.
2. **Read [ARCHITECTURE_V2.md](ARCHITECTURE_V2.md)** — brand-aware + halal flow, 7 core workflows, integration patches, Sheets structure.

Use [CURRENT_WORKFLOWS.md](CURRENT_WORKFLOWS.md) for which workflow is active (02B) vs legacy (02) and core vs extended set.
