# WF03 addendum — Etsy velocity throttle and Notion Template Gallery

**Status:** Etsy velocity throttle: **MANUAL / SPEC ONLY** (not yet in `workflows/03_publishing_agent.json`). Notion Template Gallery: **MANUAL / SPEC ONLY** (not yet in workflow JSON).

Addendum to **workflows/03_publishing_agent.json**. Until these are implemented in the workflow, follow the manual/spec steps below.

---

## 1. Etsy listing velocity throttle

**Intent:** Etsy enforces rate limits (see [Etsy API docs](https://developers.etsy.com/documentation/reference#operation/getShopReceipts)); exceeding them can cause throttling or errors. A safe approach is to cap Etsy API calls (e.g. max 10 requests per second or per Etsy’s documented limit for the endpoints you use).

**Current state:** WF03 has no rate limiting in the JSON. Bulk publishing many products in one run can hit Etsy limits.

**Options:**

- **Manual (for now):** Publish in small batches (e.g. a few products per run) or space out 03 runs so you don’t burst many Etsy requests at once.
- **In n8n (when implementing):** Add a Code node before the Etsy publish node that:
  - Queues listing creations and sends them at a capped rate (e.g. 1 listing every 1–2 seconds, or 10/sec if within Etsy’s limit), **or**
  - Uses a simple delay between items (e.g. `await new Promise(r => setTimeout(r, 1500))` per listing).
- **Documented limit:** Check Etsy’s current “Rate limits” section for your app; design the throttle to stay under that.

**Status:** Documented here as manual/spec until implemented in workflows/03_publishing_agent.json (or in a Code node referenced by it).

---

## 2. Notion Template Gallery publish path

**Intent:** When the product type is a Notion template, publish it to Notion’s Template Gallery (free distribution, ~30M users) in addition to (or instead of) storefronts, as appropriate.

**Current state:** WF03 publishes to Etsy, Gumroad, and Payhip only. There is no branch or step that submits to Notion’s Template Gallery.

**Options:**

- **Manual (for now):** For each Notion template product, manually submit to the Notion Template Gallery (Notion’s site / template submission flow).
- **In n8n (when implementing):** Add a branch or step in 03 that:
  - Detects product type “Notion” (from 02B or Products_Ready),
  - Calls Notion API / template gallery submission flow (per Notion’s current docs),
  - Runs after or in parallel to storefront publish, and logs result to Sheets if needed.
- **Spec:** Notion Template Gallery path = “when product type is Notion → submit to Notion Template Gallery (API or manual); document URL in Products_Ready or Published_Products.”

**Status:** Documented here as manual step and spec until implemented in workflows/03_publishing_agent.json or a linked sub-workflow.

---

**When implementing in n8n:** Re-export workflows/03_publishing_agent.json after changes and update this addendum if the behavior is fully in the JSON; otherwise keep this file as the spec for throttle and Notion path.
