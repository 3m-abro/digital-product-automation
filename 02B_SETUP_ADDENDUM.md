# 🏭 WORKFLOW 02B — Product Creation Factory
## Addendum to Main Setup Guide

---

## 🗺️ COMPLETE SYSTEM MAP (Updated)

```
MONDAY 6AM
    │
    ▼
01_research_agent.json
    • mistral analyzes trends
    • 8 opportunities → Google Sheets
    │
    ▼  ← YOU APPROVE (set APPROVED = YES)
    │
02B_product_creation_factory.json   ← NEW: REPLACES 02
    │
    ├── AI ART PATH
    │   phi3 → 12 SD prompts
    │       → Replicate API (primary)
    │       → HuggingFace (fallback)
    │       → 12 PNG images generated
    │
    ├── eBOOK PATH
    │   llama3 → full chapters written
    │          → styled HTML built
    │          → Freepik cover image
    │          → wkhtmltopdf → PDF
    │
    ├── PRINTABLE PATH
    │   llama3 → 3 template variants
    │          → HTML/CSS per variant
    │          → wkhtmltopdf → 3 PDFs
    │
    └── NOTION PATH
        llama3 → template structure
               → Notion API creates page
               → shareable link generated
    │
    ▼
📦 ZIP PACKAGER
    All files → /tmp/product_package.zip
    │
    ▼
☁️ GOOGLE DRIVE
    ZIP uploaded → public link generated
    │
    ▼
03_publishing_agent.json
    Gumroad + Etsy + Payhip
    │
    ▼
04_social_agent.json
    FB + IG + TikTok + Pinterest + YouTube
```

---

## 🔑 NEW CREDENTIALS NEEDED FOR 02B

### Replicate.com (Primary Image Gen)
1. Sign up at replicate.com
2. Go to Account → API Tokens
3. Create token
4. Free tier: **$5 credit included** (~500 SDXL images)
5. Very affordable after: ~$0.0046 per image
6. Replace `YOUR_REPLICATE_API_TOKEN` in workflow

### HuggingFace (Fallback Image Gen)
1. Sign up at huggingface.co
2. Settings → Access Tokens → New Token (read)
3. Free tier: Generous, rate-limited
4. Replace `YOUR_HUGGINGFACE_API_TOKEN` in workflow

### Freepik API (eBook Covers + Art)
1. Sign up at freepik.com
2. Go to freepik.com/api → Get API Key
3. Free tier: **100 AI generations/day**
4. Also gives access to their stock asset library
5. Replace `YOUR_FREEPIK_API_KEY` in workflow

### Notion Integration (For Notion templates only)
1. Go to notion.so/my-integrations
2. New Integration → Give it a name
3. Copy the Internal Integration Token
4. In Notion: open your workspace page → Share → Invite your integration
5. Copy the page ID from the URL (32-char hex after last /)
6. Replace `YOUR_NOTION_INTEGRATION_TOKEN` and `YOUR_NOTION_PARENT_PAGE_ID`

### Google Drive (Same OAuth as Sheets)
- Uses the same Google credential you set up for Sheets
- Just add Google Drive node + authorize
- Create a folder in Drive called "Digital Products"
- Get folder ID from URL: drive.google.com/drive/folders/[THIS_IS_THE_ID]
- Replace `YOUR_GOOGLE_DRIVE_FOLDER_ID`

---

## 🖥️ VPS REQUIREMENTS

### Minimum Specs for CPU-only VPS:
| Resource | Minimum | Recommended |
|----------|---------|-------------|
| RAM | 8GB | 16GB |
| CPU | 4 cores | 8 cores |
| Storage | 50GB | 100GB |
| OS | Ubuntu 20.04+ | Ubuntu 22.04 |

### Why RAM matters:
- llama3 needs ~5GB RAM
- mistral needs ~4GB RAM  
- phi3 needs ~2GB RAM
- Running all 3 = ~11GB minimum
- **Recommendation**: Run one model at a time (workflow already does this)

### n8n Timeout Setting (CRITICAL):
```
n8n Settings → Workflows → Execution Timeout
Set to: 3600 (1 hour)
```
llama3 writing a full ebook on CPU can take 15-45 minutes.
Without this setting, n8n will kill the job.

---

## ⚡ IMAGE GENERATION API COMPARISON

| API | Speed | Quality | Free Tier | Cost After |
|-----|-------|---------|-----------|------------|
| Replicate SDXL | Fast (20s) | ⭐⭐⭐⭐⭐ | $5 credit | $0.0046/img |
| HuggingFace | Medium (45s) | ⭐⭐⭐⭐ | Rate limited | Free |
| Freepik AI | Fast (15s) | ⭐⭐⭐⭐ | 100/day | Paid plans |

**Strategy used in workflow:**
1. Try Replicate first (best quality)
2. If fails/quota → HuggingFace fallback
3. Freepik used specifically for covers/marketing

---

## 📦 WHAT GETS CREATED PER PRODUCT TYPE

### AI Art Pack
- 12 high-res PNG images (1024x1024)
- 1 cover/mockup image
- README.txt with usage rights
- All packaged in ZIP

### eBook / Guide
- Full styled PDF (25-40 pages)
- Cover image (from Freepik)
- Professional typography and layout
- Table of contents, chapters, callouts

### Printable Template
- 3 design variants as separate PDFs
- A4 and US Letter sizes
- Usage instructions included
- Mockup image for listing

### Notion Template
- Live Notion page created
- Shareable duplicate link
- Complete with databases and content
- PDF guide included in ZIP

---

## 🐛 COMMON ISSUES & FIXES

| Issue | Cause | Fix |
|-------|-------|-----|
| `wkhtmltopdf: error` | Headless server | Use `/usr/local/bin/wkhtmltopdf-headless` path |
| Ollama timeout | CPU too slow | Increase n8n timeout to 3600s, or split into smaller prompts |
| HuggingFace 503 | Model loading | Add another Wait node (60s) and retry |
| Drive upload fails | File not found | Check wkhtmltopdf actually created the PDF first |
| Replicate pending | Job still running | Increase Wait node to 60s for complex prompts |
| llama3 bad JSON | Model hallucination | The Code parser handles this — check `error` field in output |

---

## 💡 PRO TIPS FOR CPU VPS

1. **Stagger your products**: Don't approve 8 products at once. Do 2-3 max per cycle. llama3 will queue them.

2. **Pre-warm Ollama**: Run a dummy request to Ollama before the workflow starts. Add an HTTP node that pings `http://localhost:11434/api/tags` first.

3. **Monitor RAM**: Install `htop` and watch memory during first runs. If it crashes, your VPS needs more RAM.

4. **Cloudflare tunnel** (optional): If you want to access your n8n from outside without exposing ports: `cloudflared tunnel --url http://localhost:5678`

5. **Product file cleanup**: Add a final Execute Command node: `rm -f /tmp/*.html /tmp/*.pdf` to clean up temp files after Drive upload.
