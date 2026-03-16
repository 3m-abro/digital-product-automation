# 🔌 INTEGRATION GUIDE — How to Wire Workflow 05 into 02B and 04

## Overview
Workflow 05 is a **centralized service** — a reusable webhook agent that
both 02B and 04 call at specific points. Here's exactly where to add the 
HTTP Request calls in each workflow.

---

## 📍 WORKFLOW 02B — Where to Add Humanization Calls

Add 3 new HTTP Request nodes + 3 parse nodes at these exact points:

---

### INSERTION POINT 1: After eBook HTML is built
**After node:** `🖥️ Build Styled eBook HTML`
**Before node:** `🎨 Freepik — Generate eBook Cover`

Add this HTTP Request node:

```
Node Name: 🔌 Humanize eBook Content
Type: HTTP Request
Method: POST
URL: YOUR_N8N_WEBHOOK_URL/webhook/humanize-and-engineer
Body (JSON):
{
  "content_type": "ebook",
  "product_name": "{{ $json._product.Product_Name }}",
  "product_category": "{{ $json._product.Category }}",
  "raw_content": "{{ $json.chapters | map(c => c.title + '\n' + c.content) | join('\n\n') }}"
}
```

Then add a Code node after it:
```javascript
// Replace ebook chapters with humanized content
const humanized = $input.first().json;
const originalEbook = $('🖥️ Build Styled eBook HTML').first().json;

if (humanized.humanized_content && !humanized.parse_error) {
  // Split humanized content back into chapters by double newline
  const humanizedChapters = humanized.humanized_content
    .split('\n\n')
    .filter(c => c.trim().length > 50);
  
  // Replace chapter content while keeping structure
  const updatedChapters = originalEbook.chapters.map((ch, i) => ({
    ...ch,
    content: humanizedChapters[i] || ch.content
  }));
  
  return [{ json: { 
    ...originalEbook, 
    chapters: updatedChapters,
    _humanized: true,
    _quality_score: humanized.quality_score
  }}];
}

// Fallback: pass through original if humanization failed
return [{ json: { ...originalEbook, _humanized: false } }];
```

---

### INSERTION POINT 2: After llama3 Creator Agent (Listing copy)
**After node:** `⚙️ Parse Product Package` (in original Workflow 02)
**Before node:** `📊 Write to Products_Ready Sheet`

Add this HTTP Request node:

```
Node Name: 🔌 Humanize Product Listing
Type: HTTP Request
Method: POST
URL: YOUR_N8N_WEBHOOK_URL/webhook/humanize-and-engineer
Body (JSON):
{
  "content_type": "listing",
  "product_name": "{{ $json.listing.title }}",
  "product_category": "{{ $json.category }}",
  "raw_content": "{{ JSON.stringify($json.listing) }}"
}
```

Then add a Code node after it:
```javascript
// Merge humanized listing back into product package
const humanized = $input.first().json;
const productPackage = $('⚙️ Parse Product Package').first().json;

if (!humanized.parse_error && humanized.humanized_title) {
  return [{ json: {
    ...productPackage,
    listing: {
      ...productPackage.listing,
      title: humanized.humanized_title,
      description_short: humanized.humanized_description_short,
      description_long: humanized.humanized_description_long,
      tags: humanized.humanized_tags || productPackage.listing.tags,
      _humanized: true,
      _quality_score: humanized.quality_score
    }
  }}];
}

return [{ json: productPackage }]; // fallback
```

---

### INSERTION POINT 3: After phi3 Art Prompts are parsed
**After node:** `⚙️ Parse & Split Art Prompts`
**Before node:** `🎨 Replicate — Generate Image`

Add this HTTP Request node:

```
Node Name: 🔌 Engineer SD Prompt
Type: HTTP Request
Method: POST
URL: YOUR_N8N_WEBHOOK_URL/webhook/humanize-and-engineer
Body (JSON):
{
  "content_type": "sd_prompt",
  "product_name": "{{ $json.pack_name }}",
  "product_category": "{{ $json.original_product.Category }}",
  "raw_content": "{{ $json.prompt }}"
}
```

Then add a Code node after it:
```javascript
// Replace basic prompt with engineered prompt
const engineered = $input.first().json;
const originalPromptData = $('⚙️ Parse & Split Art Prompts').first().json;

if (engineered.engineered_prompt && !engineered.parse_error) {
  return [{ json: {
    ...originalPromptData,
    // Overwrite prompt with engineered version
    prompt: engineered.engineered_prompt,
    negative_prompt: engineered.negative_prompt || originalPromptData.negative_prompt,
    cfg_scale: engineered.cfg_scale || 7,
    steps: engineered.steps || 30,
    _prompt_engineered: true,
    _variant_used: engineered.recommended_variant,
    _all_variants: engineered.all_variants
  }}];
}

return [{ json: originalPromptData }]; // fallback
```

---

## 📍 WORKFLOW 04 — Where to Add Social Humanization

**After node:** `⚙️ Enrich Social Content with URLs`
**Before node:** All the social posting nodes (FB, IG, TikTok, etc.)

Add this HTTP Request node:

```
Node Name: 🔌 Humanize Social Content
Type: HTTP Request
Method: POST
URL: YOUR_N8N_WEBHOOK_URL/webhook/humanize-and-engineer
Body (JSON):
{
  "content_type": "social",
  "product_name": "{{ $json.product_title }}",
  "product_category": "digital product",
  "store_url": "{{ $json.primary_url }}",
  "raw_content": "{{ JSON.stringify({ instagram_caption: $json.instagram_caption, facebook_post: $json.facebook_post, tiktok_script: $json.tiktok_script, pinterest_description: $json.pinterest_description, youtube_title: $json.youtube_title }) }}"
}
```

Then add a Code node that merges the humanized captions back:
```javascript
const humanized = $input.first().json;
const original = $('⚙️ Enrich Social Content with URLs').first().json;

if (!humanized.parse_error && humanized.instagram) {
  return [{ json: {
    ...original,
    // Replace with humanized versions
    instagram_caption: humanized.instagram?.caption + '\n\n' + humanized.instagram?.hashtags,
    facebook_post: humanized.facebook?.post + '\n\n' + (humanized.facebook?.engagement_question || ''),
    tiktok_script: humanized.tiktok?.script,
    tiktok_caption: humanized.tiktok?.caption,
    pinterest_description: humanized.pinterest?.description,
    youtube_title: humanized.youtube_shorts?.title,
    youtube_description: humanized.youtube_shorts?.description,
    _social_humanized: true,
    _quality_score: humanized.quality_score
  }}];
}

return [{ json: original }]; // fallback to original if humanization fails
```

---

## 🗺️ UPDATED FULL SYSTEM FLOW

```
01_research_agent.json          (no changes needed)
         │
         ▼ [you approve in Sheets]
         │
02B_product_creation_factory.json
    ├── Art Path: phi3 prompts
    │       ↓
    │   🔌 [CALL 05] Prompt Engineer (mistral)
    │       ↓ engineered prompts
    │   Replicate API → better images
    │
    ├── eBook Path: llama3 writes content
    │       ↓
    │   🔌 [CALL 05] eBook Humanizer (llama3)
    │       ↓ humanized chapters
    │   HTML Builder → wkhtmltopdf → PDF
    │
    ├── Listing copy: llama3 creates listing
    │       ↓
    │   🔌 [CALL 05] Listing Humanizer (llama3)
    │       ↓ conversion-optimized copy
    │   Products_Ready sheet
    │
03_publishing_agent.json        (no changes needed)
         │
         ▼
04_social_agent.json
    ↓
🔌 [CALL 05] Social Humanizer (mistral)
    ↓ platform-native captions
FB + IG + TikTok + Pinterest + YouTube
```

---

## 📊 Add This Tab to Google Sheets

### Tab: `Humanization_Log`
| Column | Description |
|--------|-------------|
| Timestamp | When processed |
| Product | Product name |
| Category | Product category |
| Content_Type | ebook / listing / social / sd_prompt |
| Tone_Applied | Which tone profile was used |
| Quality_Score | excellent / good / fair / poor |
| AI_Phrases_Remaining | Count of remaining AI phrases |
| Retried | Whether a retry pass was needed |
| Status | Complete |

**Use this tab to monitor quality over time.** If you see consistent 
"fair" scores for a category, you can tune the system prompt for that 
category's humanization agent.

---

## 🎛️ TONE PROFILES — Auto-Detection Logic

| Category Keywords | Tone Profile | Voice Description |
|-------------------|-------------|-------------------|
| productivity, notion, planner | `professional_warm` | Smart friend who has their life together |
| ai art, watercolor, illustration, art pack | `creative_expressive` | Passionate artist, evocative language |
| ebook, guide, how to, tips | `mentor_casual` | Knowledgeable friend teaching over coffee |
| printable, template, canva | `cheerful_helpful` | Creative friend who loves sharing finds |
| budget, finance, money | `trustworthy_empathetic` | Non-judgmental, clear, reassuring |
| fitness, wellness, health | `motivational_real` | Coach who actually gets it |
| (everything else) | `friendly_relatable` | Real person, not a brand |

**To add a custom tone**: Edit the `⚙️ Validate + Detect Tone by Product` 
Code node in Workflow 05 and add your category → tone mapping.

---

## ⚡ PERFORMANCE NOTES (CPU VPS)

Each humanization call adds:
- eBook: ~3-8 min (per chapter, llama3 on CPU)
- Listing: ~1-2 min (shorter content, llama3)  
- Social: ~2-4 min (5 platform rewrites, mistral)
- SD Prompt: ~1-2 min (mistral, shorter output)

**Recommendation**: Run humanization overnight.
Set your approval check trigger to fire at 11PM so by morning
everything is humanized and ready.

Total weekly time estimate for 3 products:
~2-3 hours of background processing (fully automated, no input from you)
