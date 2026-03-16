# 🏗️ COMPLETE SYSTEM ARCHITECTURE v2.0
## Digital Product Empire — Brand-Aware + Halal-Compliant

---

## 📦 COMPLETE FILE LIST (All 7 Workflows)

| File | Workflow | Status | Change |
|------|----------|--------|--------|
| `01_research_agent.json` | Weekly Trend Researcher | ✅ Existing | Add brand config call |
| `02B_product_creation_factory.json` | Product Creator | ✅ Existing | Add brand styling + halal check |
| `03_publishing_agent.json` | Store Publisher | ✅ Existing | Add brand credential routing |
| `04_social_agent.json` | Social Promoter | ✅ Existing | Add brand social account routing |
| `05_humanization_agent.json` | Humanizer + Prompt Engineer | ✅ Existing | Add brand voice injection |
| `06_brand_config.json` | **Brand Config System** | 🆕 NEW | Master brand registry |
| `07_halal_guardian.json` | **Halal Guardian Agent** | 🆕 NEW | Content compliance screening |

---

## 🔄 UPDATED FLOW (Brand-Aware + Halal)

```
MONDAY 6AM
    │
    ▼
01 Research Agent
    │ calls 06 → gets ClearStack config
    │ Research tagged with brand_id: 'clearstack'
    │ Keywords pulled from brand.seo.etsy_primary_keywords
    │ Halal guardrails applied to research scope
    ▼
[YOU APPROVE in Google Sheets — set APPROVED = YES]
    │
    ▼
02B Creation Factory
    │ calls 06 → gets brand colors, fonts, voice
    │ PDF/HTML styled with navy #1B2A4A + gold #C9A84C
    │ calls 07 → halal check on ALL generated content
    │   ├── Hard blocked → discarded, logged
    │   ├── Approved → continues
    │   └── Ambiguous → queued for YOUR review
    │ calls 05 → humanized with ClearStack voice
    ▼
03 Publishing Agent
    │ calls 06 → gets ClearStack store credentials
    │ Publishes to:
    │   ├── Etsy: clearstackstudio shop
    │   ├── Gumroad: clearstackstudio.gumroad.com
    │   └── Payhip: payhip.com/clearstackstudio
    ▼
04 Social Agent
    │ calls 06 → gets ClearStack social account IDs
    │ calls 07 → halal check on ALL captions
    │ calls 05 → humanize captions with brand voice
    │ Posts to:
    │   ├── Instagram: @clearstackstudio
    │   ├── Facebook: ClearStack Studio page
    │   ├── TikTok: @clearstackstudio
    │   ├── Pinterest: clearstackstudio boards
    │   └── YouTube: ClearStack Studio channel
    ▼
Google Sheets Dashboard updated
```

---

## 🔌 INTEGRATION PATCHES FOR EXISTING WORKFLOWS

### Patch 01_research_agent.json

Add this HTTP Request node as the **FIRST node after the trigger**:

```
Node: 🔌 Get Brand Config
Type: HTTP Request
Method: POST
URL: YOUR_N8N_BASE_URL/webhook/get-brand-config
Body:
{
  "genre": "productivity",
  "product_category": "Productivity & Organization",
  "brand_id": null
}
```

Then in the Ollama Research Agent prompt, inject:
```
Brand: {{$('🔌 Get Brand Config').first().json.brand.brand_name}}
Focus keywords: {{$('🔌 Get Brand Config').first().json.brand.seo.etsy_primary_keywords.slice(0,5).join(', ')}}
Excluded topics (halal): {{$('🔌 Get Brand Config').first().json.brand.halal.prohibited_content.join(', ')}}
```

Also add `brand_id: 'clearstack'` to every row written to Google Sheets.

---

### Patch 02B_product_creation_factory.json

**Step 1** — Add after Schedule Trigger, before reading Sheets:
```
Node: 🔌 Get Brand Config
HTTP POST → /webhook/get-brand-config
Body: { "brand_id": "clearstack" }
```

**Step 2** — In `🖥️ Build Styled eBook HTML` node, replace hardcoded colors:
```javascript
// Replace:
const coverColor = ebook.cover_color || '#2D3748';
const accentColor = ebook.accent_color || '#4299E1';

// With:
const brandConfig = $('🔌 Get Brand Config').first().json.brand;
const coverColor = brandConfig.colors.primary;    // #1B2A4A navy
const accentColor = brandConfig.colors.accent;    // #C9A84C gold
const bodyFont = brandConfig.fonts.body;          // Open Sans
const headingFont = brandConfig.fonts.heading;    // Inter
```

**Step 3** — Add after `⚙️ Parse Product Package`, before PDF conversion:
```
Node: 🔌 Halal Check — Product Content
HTTP POST → /webhook/halal-check
Body:
{
  "content": "{{ $json.listing.description_long + ' ' + $json.listing.title }}",
  "content_type": "listing",
  "product_name": "{{ $json.listing.title }}",
  "brand_id": "clearstack"
}
```

Then add IF node: if `approved == false` → stop workflow, log rejection.

**Step 4** — Add to SD prompt node suffix:
```javascript
// Append brand style to every SD prompt
const brandStyle = $('🔌 Get Brand Config').first().json.brand.creation.sd_style_suffix;
prompt = prompt + brandStyle;
// Result: prompt + ", clean minimal design, navy and gold color scheme, ..."
```

---

### Patch 03_publishing_agent.json

Replace all hardcoded credentials with dynamic brand config lookups:

```javascript
// Add at start of publishing node:
const brandConfig = $('🔌 Get Brand Config').first().json.brand;

// Then use:
const etsyApiKey = brandConfig.stores.etsy.api_key;
const etsyOauthToken = brandConfig.stores.etsy.oauth_token;
const etsyShopId = brandConfig.stores.etsy.shop_id;
const gumroadToken = brandConfig.stores.gumroad.access_token;
const payhipKey = brandConfig.stores.payhip.api_key;

// Check which stores are enabled before publishing:
const enabledStores = $('🔌 Get Brand Config').first().json.enabled_stores;
// ['etsy', 'gumroad', 'payhip'] — only publish to configured stores
```

---

### Patch 04_social_agent.json

Replace hardcoded social IDs with brand config:

```javascript
const brandConfig = $('🔌 Get Brand Config').first().json.brand;

const igUserId = brandConfig.social.instagram.user_id;
const igToken = brandConfig.social.instagram.access_token;
const fbPageId = brandConfig.social.facebook.page_id;
const fbToken = brandConfig.social.facebook.access_token;
const ttToken = brandConfig.social.tiktok.access_token;
const pinToken = brandConfig.social.pinterest.access_token;
// Pinterest board by genre:
const pinBoardId = brandConfig.social.pinterest.board_ids[product_genre] 
                   || brandConfig.social.pinterest.board_ids.productivity;
const ytToken = brandConfig.social.youtube.oauth_token;
```

Add halal check before posting:
```
Node: 🔌 Halal Check — Social Captions
HTTP POST → /webhook/halal-check
Body: { "content": all captions combined, "content_type": "social", ... }
```

---

### Patch 05_humanization_agent.json

Inject brand voice into ALL system prompts dynamically:

In `⚙️ Validate + Detect Tone by Product` — replace static tone detection with:
```javascript
// Call brand config first, then use brand voice instead of category detection
// Add to the top of the node:
const brandConfig = $input.first().json.brand_config;
if (brandConfig) {
  detectedTone = brandConfig.voice.tone;
  toneDescription = brandConfig.voice.description;
  forbiddenPhrases = brandConfig.voice.forbidden_phrases;
  signaturePhrases = brandConfig.voice.signature_phrases;
}
```

---

## 🗂️ UPDATED GOOGLE SHEETS STRUCTURE

Add these new tabs to your existing sheet:

### NEW Tab: `Brand_Config_Log`
| Timestamp | Brand_Resolved | Genre_Requested | Enabled_Stores | Enabled_Social | Config_Issues | Ready |

### NEW Tab: `Halal_Review_Log`
| Timestamp | Product_Name | Verdict | Verdict_Source | Confidence | Approved | Flags | Needs_Human_Review | Action_Required | Reviewer_Note | Edits_Suggested |

### NEW Tab: `Halal_Human_Review_Queue`
⚠️ **YOU ACT ON THIS TAB**
| Timestamp | Product_Name | Flags | Issues_Detail | Suggested_Edits | Original_Content_Preview | Cleaned_Content_Preview | **YOUR_DECISION** | Notes | Reviewer_Note |

→ Set YOUR_DECISION to `APPROVED` or `REJECTED`
→ A separate polling workflow (add to 02B) checks this tab and continues the pipeline

### UPDATED: `Research_Opportunities` — Add columns:
- `Brand_ID` — auto-set to 'clearstack'
- `Halal_Status` — auto-set after screening
- `Genre_Tag` — auto-detected genre

### UPDATED: `Products_Ready` — Add columns:
- `Brand_ID`
- `Halal_Approved`
- `Halal_Verdict_Source`

---

## 🚀 ADDING BRANDS 2 & 3 LATER (5-Minute Process)

When you're ready to activate NurturePrint or PixelAura:

1. Open Workflow 06 → `⚙️ Brand Registry + Genre Router` node
2. Change `status: 'COMING_SOON'` to `status: 'ACTIVE'`
3. Fill in all `YOUR_*` credential placeholders for that brand
4. The entire system automatically starts routing to that brand
5. No other workflow changes needed

That's the power of the centralized config system.

---

## 📊 CLEARSTACK STUDIO LAUNCH CHECKLIST

### Accounts to Create (All Free):
- [ ] Etsy seller account → shop name: ClearStackStudio
- [ ] Gumroad account → username: clearstackstudio  
- [ ] Payhip account → username: clearstackstudio
- [ ] Instagram Business: @clearstackstudio
- [ ] Facebook Page: ClearStack Studio
- [ ] TikTok Business: @clearstackstudio
- [ ] Pinterest Business: clearstackstudio
- [ ] YouTube Channel: ClearStack Studio
- [ ] Google Drive folder: "ClearStack Products"

### Branding Assets to Create (Canva Free):
- [ ] Logo (navy + gold, minimal geometric)
- [ ] Profile photo (same logo, circle crop)
- [ ] Instagram bio graphic
- [ ] Pinterest cover
- [ ] YouTube channel art
- [ ] Etsy shop banner (2000x500px)
- [ ] Etsy shop icon (500x500px)

### n8n Config:
- [ ] Import Workflow 06 → activate
- [ ] Import Workflow 07 → activate
- [ ] Copy Workflow 06 webhook URL → save it
- [ ] Copy Workflow 07 webhook URL → save it
- [ ] Add both URLs to all other workflows
- [ ] Fill all YOUR_* values in Workflow 06
- [ ] Set n8n execution timeout → 3600s
- [ ] Add Halal_Review_Log, Halal_Human_Review_Queue, Brand_Config_Log tabs to Sheet

### First Product Test:
- [ ] Run Workflow 01 manually (test button)
- [ ] Check Research_Opportunities sheet
- [ ] Approve 1 product (APPROVED = YES)
- [ ] Run Workflow 02B manually
- [ ] Check Halal_Review_Log
- [ ] Check Products_Ready sheet
- [ ] Run Workflow 03 manually
- [ ] Verify product appears on Etsy/Gumroad/Payhip
- [ ] Run Workflow 04 manually
- [ ] Check all social posts
- [ ] Celebrate 🎉

---

## 💡 CLEARSTACK CONTENT STRATEGY

### Pinterest (Your #1 Channel for Traffic)
- Post 5-10 pins/day (repurpose each product 5 different ways)
- Boards to create:
  - "Notion Templates for Freelancers"
  - "Business Planner Printables"  
  - "Productivity Tools & Templates"
  - "Content Creator Resources"
  - "Seasonal Planners & Organizers"

### TikTok (Your #1 Channel for Discovery)
- Template walkthrough videos perform best
- "POV: you finally have a system that works" style
- Before/after organization content
- "Things in my Notion" style videos

### Instagram (Trust + Community Building)
- Carousel posts showing template pages perform 3x better than single images
- Stories: polls ("which template style do you prefer?")
- Reels: same content as TikTok

### Etsy SEO Priority Keywords for ClearStack:
1. notion template bundle
2. digital planner 2025
3. business planner printable
4. content calendar canva template
5. weekly planner notion
6. client tracker template
7. social media planner printable
8. freelancer invoice template
