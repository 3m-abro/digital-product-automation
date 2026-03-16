# 🏗️ DIGITAL PRODUCT EMPIRE — Complete Setup Guide
## n8n Agentic Workflow System v1.0

---

## 📋 OVERVIEW OF WORKFLOWS

| File | Workflow | Trigger | Purpose |
|------|----------|---------|---------|
| `workflows/01_research_agent.json` | Research Agent | Every Monday 6AM | Scrapes trends, Ollama analyzes, writes to Sheets |
| `workflows/02_creation_agent.json` | Creation Agent | Every 6 hours | Reads your approvals, creates full product packages |
| `workflows/03_publishing_agent.json` | Publishing Agent | Every 4 hours | Publishes to Gumroad, Etsy, Payhip |
| `workflows/04_social_agent.json` | Social Agent | Webhook (auto-triggered) | Posts to FB, IG, TikTok, Pinterest, YouTube |

---

## 🗂️ GOOGLE SHEETS STRUCTURE

Create ONE Google Sheet with these 6 tabs:

### Tab 1: `Research_Opportunities`
| Column | Type | Notes |
|--------|------|-------|
| Week | Text | Auto-filled |
| Rank | Number | 1-8 |
| Product_Name | Text | Auto-filled |
| Category | Text | Auto-filled |
| Trend_Score | Number | 0-100 |
| Recreatability_Score | Number | 0-10 |
| Price_Min | Number | USD |
| Price_Max | Number | USD |
| Creation_Tool | Text | Auto-filled |
| Creation_Hours | Number | Auto-filled |
| Target_Keyword | Text | Auto-filled |
| Description | Text | Auto-filled |
| Creation_Steps | Text | Auto-filled (pipe separated) |
| Market_Insights | Text | Auto-filled |
| **APPROVED** | Text | **YOU FILL THIS: YES or NO** |
| Notes | Text | Your personal notes |
| Date_Added | DateTime | Auto-filled |
| Status | Text | Auto-filled |

### Tab 2: `Products_Ready`
| Column | Notes |
|--------|-------|
| Product_ID | Auto-generated slug |
| Title | SEO listing title |
| Category | Product category |
| Price | USD price |
| Short_Description | 2-3 sentence description |
| Tags | Comma-separated tags |
| Image_Prompt_Mockup | Use in Leonardo.ai free |
| Image_Prompt_Thumbnail | Use in Leonardo.ai free |
| Image_Prompt_Social | Use in Canva/Leonardo.ai |
| IG_Caption | Full Instagram caption |
| FB_Post | Facebook post text |
| TikTok_Script | 15-second TikTok script |
| Pinterest_Description | Pinterest pin description |
| YouTube_Title | YouTube Shorts title |
| Creation_Guide | JSON (full creation steps) |
| Status | Auto-updated |
| Created_At | DateTime |
| Published_Etsy | YES/NO/FAILED |
| Published_Gumroad | YES/NO/FAILED |
| Published_Payhip | YES/NO/FAILED |
| Published_Social | YES/NO |
| Gumroad_URL | Auto-filled after publish |
| Etsy_URL | Auto-filled after publish |
| Payhip_URL | Auto-filled after publish |

### Tab 3: `Published_Products`
Permanent record of all published products with sales tracking.

### Tab 4: `Social_Posts_Log`
All social media posting results with post IDs.

### Tab 5: `Weekly_Dashboard`
High-level weekly activity log.

### Tab 6: `Error_Log`
(Optional) Log workflow errors here.

---

## 🔑 CREDENTIALS YOU NEED

### Ollama (Local - No API Key)
- Install: `curl -fsSL https://ollama.com/install.sh | sh`
- Pull models:
  ```bash
  ollama pull llama3
  ollama pull mistral
  ollama pull phi3
  ```
- n8n credential: Add Ollama credential → Base URL: `http://localhost:11434`

### Google Sheets
1. Google Cloud Console → New Project
2. Enable Google Sheets API + Google Drive API
3. Create Service Account → Download JSON key
4. Share your Google Sheet with the service account email
5. Add credential in n8n: Google Sheets OAuth2

### Gumroad
1. Go to gumroad.com → Settings → Advanced
2. Generate Access Token
3. Replace `YOUR_GUMROAD_ACCESS_TOKEN` in Workflow 3

### Etsy (Most Complex)
1. Register at etsy.com/developers
2. Create an app → Get API Key
3. Complete OAuth2 flow to get user token
4. Get your Shop ID from etsy.com/shop/YOUR_SHOP_NAME/about
5. Replace `YOUR_ETSY_API_KEY`, `YOUR_ETSY_OAUTH_TOKEN`, `YOUR_SHOP_ID` in Workflow 3

### Payhip
1. Login to payhip.com → Account → API
2. Generate API key
3. Replace `YOUR_PAYHIP_API_KEY` in Workflow 3

### Meta (Facebook + Instagram)
1. Go to developers.facebook.com → Create App
2. Add Facebook Login + Instagram Graph API products
3. Get Page Access Token (long-lived) with permissions:
   - `pages_manage_posts`
   - `pages_read_engagement`  
   - `instagram_content_publish`
   - `instagram_basic`
4. Get your Facebook Page ID (from Page About section)
5. Get your Instagram User ID via Graph API
6. Replace all `YOUR_FACEBOOK_*` and `YOUR_IG_*` values in Workflow 4

### TikTok
1. Apply at developers.tiktok.com (requires business account)
2. Content Posting API needs approval (~1-2 weeks)
3. Get access token after approval
4. NOTE: Video file required - create with CapCut free or similar
5. Replace `YOUR_TIKTOK_ACCESS_TOKEN` in Workflow 4

### Pinterest
1. Go to developers.pinterest.com → Create App
2. Request `pins:write` and `boards:read` permission scopes
3. Complete OAuth flow
4. Get your board ID from Pinterest URL: pinterest.com/username/board-name/
5. Replace `YOUR_PINTEREST_ACCESS_TOKEN` and `YOUR_PINTEREST_BOARD_ID`

### YouTube
1. Google Cloud Console → YouTube Data API v3
2. Create OAuth2 credentials (Web Application type)
3. Add `https://your-n8n-domain.com/rest/oauth2-credential/callback` as redirect URI
4. Scopes needed: `youtube.upload`
5. NOTE: YouTube Shorts require a vertical video file (9:16 ratio)

---

## 🚀 RECOMMENDED FREE STOREFRONTS (START HERE)

| Store | Fee | Recommended For | Setup Time |
|-------|-----|----------------|------------|
| **Payhip** | 5% per sale | All digital products | 10 min |
| **Gumroad** | 10% per sale | eBooks, templates | 15 min |
| **Etsy** | $0.20/listing + 6.5% | High volume, printables | 30 min |
| **Ko-fi** | 0% (free plan) | Art, donations, products | 10 min |
| **Lemon Squeezy** | 5% + $0.50 | SaaS, templates | 20 min |

**Start with Payhip + Gumroad** — easiest APIs, free tiers, quick setup.

---

## 🤖 FREE AI TOOLS FOR PRODUCT CREATION

| Tool | Use For | Link |
|------|---------|------|
| **Canva Free** | Templates, printables, social graphics | canva.com |
| **Leonardo.ai Free** | AI art, product mockups (150 images/day) | leonardo.ai |
| **Gamma.app Free** | eBooks, guides, presentations | gamma.app |
| **Notion Free** | Notion templates | notion.so |
| **Adobe Express Free** | Quick designs | express.adobe.com |
| **Stable Diffusion** | Local AI image generation (free) | via Automatic1111 |
| **ChatGPT Free** | DALL-E images, copywriting | chat.openai.com |
| **Ollama (local)** | Text generation, content writing | ollama.com |

---

## 📅 WEEKLY WORKFLOW TIMELINE

```
MONDAY 6:00 AM  → 01_research_agent fires
                 → Scrapes Etsy, Gumroad, Creative Fabrica
                 → Mistral analyzes trends
                 → 8 opportunities written to Google Sheets

MONDAY - FRIDAY → YOU review Research_Opportunities tab
                 → Change APPROVED = YES for products you like
                 → (Aim for 2-3 per week to start)

EVERY 6 HOURS   → workflows/02_creation_agent checks for approvals
                 → llama3 creates complete product package
                 → phi3 generates image prompts
                 → Written to Products_Ready tab
                 → YOU create the actual product files using the guide

EVERY 4 HOURS   → 03_publishing_agent checks Products_Ready
                 → Publishes to all 3 stores simultaneously
                 → Triggers social media workflow

IMMEDIATELY     → 04_social_agent posts to all platforms
                 → Facebook, Instagram, TikTok, Pinterest, YouTube
                 → Results logged to Sheets
```

---

## 🛠️ IMPORT INSTRUCTIONS

1. Open n8n → Go to Workflows
2. Click **"Import from File"** (or use the + menu)
3. Import in this order (from repo `workflows/` folder):
   - `workflows/01_research_agent.json`
   - `workflows/02_creation_agent.json`
   - `workflows/03_publishing_agent.json`
   - `workflows/04_social_agent.json`
4. For Workflow 4: Copy the Webhook URL after import
5. Paste Webhook URL into Workflow 3 → "Trigger Social Media Workflow" node
6. Set up all credentials (see above)
7. Replace all `YOUR_*` placeholder values
8. Replace `YOUR_GOOGLE_SHEET_ID_HERE` — found in your Sheet URL:
   `https://docs.google.com/spreadsheets/d/[THIS_IS_YOUR_ID]/edit`
9. Activate all 4 workflows (toggle to ON)
10. Test Workflow 1 manually first!

---

## ⚡ QUICK START (Minimum Setup - 1 Hour)

Want to get running fast? Start with just these:

1. ✅ Ollama with llama3 + mistral + phi3
2. ✅ Google Sheets with credentials
3. ✅ Gumroad account + API token
4. ✅ Payhip account + API key
5. ✅ Facebook Page + Instagram (Meta Business)

Skip Etsy, TikTok, YouTube for week 1. Add them once the core loop is working.

---

## 💡 PRO TIPS

1. **Image Hosting**: Use Cloudinary free tier (25GB) to host product images publicly. Required for Pinterest and Instagram APIs.

2. **Product Files**: When Workflow 2 creates a product package and gives you creation steps + AI prompts, run them through Leonardo.ai, Canva, or Gamma.app to create the actual files. Upload to Gumroad/Payhip manually first, then automate with file upload APIs later.

3. **TikTok Videos**: Create a simple 15-second video in CapCut Free using the TikTok script from the product package. Host on Cloudinary for the API.

4. **Rate Limits**: Instagram allows 25 API posts per day. Pinterest: 1000 pins/day. Facebook: 200 posts/day. You're safe.

5. **Error Handling**: Add a final "Error Trigger" workflow node to catch failures and log them to your Error_Log sheet.

---

## 🔧 TROUBLESHOOTING

| Issue | Fix |
|-------|-----|
| Ollama not responding | Check `ollama serve` is running. n8n URL: `http://localhost:11434` |
| Google Sheets auth error | Re-authorize OAuth or check service account has sheet access |
| Etsy 403 error | Token expired - Etsy tokens last 3600 seconds, implement refresh |
| Instagram error | Image URL must be publicly accessible (use Cloudinary) |
| TikTok pending approval | Use Buffer or Later as manual fallback while waiting |
| Gumroad price error | Price must be in cents (multiply USD by 100) |
