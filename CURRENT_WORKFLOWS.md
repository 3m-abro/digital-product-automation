# Current workflows — single source of truth

## Active vs legacy

- **02B** (`02B_product_creation_factory.json`) is the **active** product creation workflow. Use it for new setups and for the brand-aware + halal pipeline described in ARCHITECTURE_V2.
- **02** (`02_creation_agent.json`) is **legacy/deprecated**. SETUP_GUIDE originally described 02; the current flow is documented in **02B_SETUP_ADDENDUM.md** and **ARCHITECTURE_V2.md**.

For "which flow is current," use **SETUP_GUIDE** for initial 4-workflow orientation and **ARCHITECTURE_V2** (and this file) for the actual pipeline (01 → 02B → 03 → 04 + 05, 06, 07).

---

## Core workflows

| ID  | File | Role |
|-----|------|------|
| 01  | `01_research_agent.json` | Weekly trend research → Sheets |
| 02B | `02B_product_creation_factory.json` | Product creation (AI art, eBook, printable, Notion) → ZIP → Drive |
| 03  | `03_publishing_agent.json` | Publish to Etsy, Gumroad, Payhip |
| 04  | `04_social_agent.json` | Post to FB, IG, TikTok, Pinterest, YouTube |
| 05  | `05_humanization_agent.json` | Humanize copy (webhook from 02B, 04) |
| 06  | `06_brand_config.json` | Brand registry + genre routing (webhook) |
| 07  | `07_halal_guardian.json` | Halal pre-screen + review queue (webhook) |

Supporting: `02C_pdf_generation_pipeline.json` (PDF from 02B), `13_mockup_generator.json` (mockups).

---

## Extended workflows

| Group | Files | Purpose |
|-------|--------|---------|
| 08x | `08A_kdp_book_factory.json`, `08B_book_publisher.json` | KDP + D2D/PublishDrive |
| 09x | `09A_content_engine.json`, `09B_*`, `09C_blog_publisher.json` | Content engine, video, blog |
| 10x | `10A_internal_linking_agent.json`, `10B_wp_health_monitor.json` | WP internal linking, health/uptime |
| 11x | `11A_email_sequence_writer.json`, `11B_brevo_automation_builder.json`, `11C_newsletter_scheduler.json` | Email sequences, Brevo, newsletter |
| 12x | `12A_schema_injector.json`, `12B_programmatic_seo.json`, `12C_ai_overview_optimizer.json` | Schema, programmatic SEO, AI overview |
| 13  | `13_mockup_generator.json` | Product mockups |

See **SETUP_GUIDE** vs **ARCHITECTURE_V2** for which flow is current; 09/08/11/12 guides describe each extended set.
