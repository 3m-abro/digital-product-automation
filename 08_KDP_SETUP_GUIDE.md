# 📚 KDP & BOOK PUBLISHING SETUP GUIDE
## Workflows 08A + 08B — Complete Configuration

---

## 🏗️ WHAT WAS BUILT

### Workflow 08A — KDP Book Factory
Generates all 5 book types from a single approved product:

| Book Type | AI Model | Output | KDP Format |
|-----------|----------|--------|------------|
| Kindle eBook | llama3 | Full manuscript + EPUB3 | Kindle + Paperback |
| Low Content (planner/journal) | llama3 | 120-page interior PDF | Paperback only |
| Coloring Book | phi3 | 40 SD prompts + PDF | Paperback only |
| Activity Book | llama3 | 60 activity pages PDF | Paperback only |
| Puzzle Book | llama3 | 80 puzzle pages PDF | Paperback only |

### Workflow 08B — Book Publisher
| Platform | Method | Stores Reached | Cost |
|----------|--------|---------------|------|
| Amazon KDP | Manual (5 min, guided) | Amazon worldwide | Free |
| Draft2Digital | ✅ Fully automated | 40+ stores | 10% royalty |
| PublishDrive | ✅ Fully automated | 400+ stores | Monthly fee |

---

## 📊 NEW GOOGLE SHEETS TABS NEEDED

### Tab: `KDP_Queue`
You populate this manually from Research_Opportunities.
| Column | Description |
|--------|-------------|
| Product_ID | Auto or manual |
| Product_Name | Book concept |
| Category | Determines book type |
| Target_Keyword | Main KDP keyword |
| Description | Product description |
| KDP_Type | ebook / low_content / coloring / activity / puzzle |
| Status | Set to: `Approved_For_KDP` to trigger 08A |
| KDP_Files_Ready | Auto-set by workflow |
| Brand_ID | clearstack |

### Tab: `KDP_Upload_Queue`
Auto-populated by 08A. Your master tracking sheet.
| Column | Description |
|--------|-------------|
| Product_ID | |
| Book_Type | |
| Title | Pre-filled |
| Subtitle | Pre-filled |
| Keywords | Pre-filled (7 keywords) |
| Categories | Pre-filled |
| Price_USD | Pre-filled |
| Page_Count | Auto |
| Interior_PDF | File path |
| EPUB_File | File path |
| Cover_Image_URL | URL to download |
| PDF_Ready | Auto |
| Cover_Ready | Auto |
| Ready_For_Upload | Auto (TRUE when all files ready) |
| **KDP_Upload_Status** | You update: PENDING → UPLOADED |
| **D2D_Upload_Status** | Auto-updated |
| **PublishDrive_Status** | Auto-updated |
| **ASIN** | You fill after KDP goes live |
| KDP_Live_URL | You fill after live |

### Tab: `KDP_Manual_Upload_Guide`
Auto-populated by 08B. Your copy-paste cheat sheet.
One row per book = all fields pre-filled for KDP dashboard.

---

## 🔑 CREDENTIALS NEEDED

### Draft2Digital (Free)
1. Sign up at draft2digital.com (free account)
2. Profile → API Access → Generate Token
3. Replace `YOUR_DRAFT2DIGITAL_API_TOKEN`
4. Connect stores: Apple Books, B&N, Kobo in D2D dashboard
5. Set up payment (PayPal recommended)

### PublishDrive
1. Sign up at publishdrive.com
2. Plans start at ~$9.99/month (unlimited books)
3. API → Generate token
4. Replace `YOUR_PUBLISHDRIVE_API_TOKEN`
5. Worth it once you have 10+ books

### Amazon KDP (No API)
1. Sign up at kdp.amazon.com (free)
2. Add bank account for royalty payments
3. Complete tax interview
4. No API key needed — manual upload only

### Replicate (Already configured in 08A)
- Same token as Workflow 02B
- Cover images generated at KDP spec: 1600x2560px

---

## 📦 VPS REQUIREMENTS FOR 08A

### Additional packages needed:
```bash
# Install pandoc for EPUB generation
sudo apt-get install -y pandoc

# Install pdfinfo for page count
sudo apt-get install -y poppler-utils

# Verify
pandoc --version
pdfinfo --version
wkhtmltopdf --version
```

---

## 💡 KDP STRATEGY FOR CLEARSTACK STUDIO

### Priority Book Types (in order):
1. **Low Content Books** (planners, journals) — Fastest to market, low content = fast to generate, consistent sellers
2. **Puzzle Books** — Evergreen, no content obsolescence, multiple themes
3. **Activity Books** — Seasonal spikes (back to school), educational niche
4. **Kindle eBooks** — Highest royalty per sale (70%), builds author authority
5. **Coloring Books** — Competitive market but AI art gives you unlimited designs

### KDP vs D2D Strategy:
```
EBOOKS:
  KDP Select = 35-70% royalty BUT 90-day Amazon exclusivity
               (can't publish on D2D/PublishDrive during this period)
  
  KDP Non-Select = 35% royalty BUT can publish everywhere
  
  RECOMMENDATION: Start with KDP Non-Select + D2D + PublishDrive
  Maximize reach while building reviews.
  Once a book gets 10+ reviews, re-evaluate KDP Select
  for the Kindle Unlimited income.

PRINT BOOKS (Low Content, Coloring, Activity, Puzzle):
  KDP for print — they handle all printing and shipping
  D2D/PublishDrive for ebook companion versions only
  IngramSpark (optional) for bookstore distribution
```

### Recommended Additional Platforms:
- **IngramSpark** — Gets your print books into physical bookstores worldwide. $49/title setup fee but massive reach.
- **Lulu.com** — Free setup, good for premium print quality, global distribution
- **Google Play Books** — Via PublishDrive (already included)
- **Apple Books** — Via Draft2Digital (already included)
- **Scribd** — Via both D2D and PublishDrive (subscription revenue)
- **OverDrive/Libby** — Library distribution via D2D (surprising royalties)

### Halal-Compliant KDP Niches (HIGH OPPORTUNITY):
```
PRODUCTIVITY:
  ✅ "The Muslim Professional's Planner 2025"
  ✅ "Ramadan Productivity Planner"
  ✅ "Halal Business Planning Workbook"
  ✅ "Islamic Finance Budget Planner"

EDUCATION:
  ✅ "Arabic Learning Activity Book"
  ✅ "Muslim Kids Activity Book"
  ✅ "Islamic History Quiz Book"
  ✅ "Quran Vocabulary Puzzle Book"

WELLNESS:
  ✅ "Morning Mindfulness Journal"
  ✅ "Gratitude & Reflection Journal"
  ✅ "Habit Tracker for a Balanced Life"

COLORING:
  ✅ "Islamic Geometric Patterns Coloring Book"
  ✅ "Masjid Architecture Coloring Book"
  ✅ "Calligraphy-Inspired Coloring Book"
```

---

## 🔄 HOW KDP FITS THE FULL SYSTEM

```
EXISTING WORKFLOW:
Research → Create → Publish (Etsy/Gumroad/Payhip) → Social

NEW PARALLEL PATH:
Research → [You mark KDP_Type in sheet]
              ↓
         08A KDP Book Factory
         (generates KDP-spec files)
              ↓
         08B Publisher
         ├── Auto: Draft2Digital → 40+ stores
         ├── Auto: PublishDrive → 400+ stores
         └── Guide: KDP_Manual_Upload_Guide sheet
                    (you spend 5 min on KDP)
              ↓
         Book listed on Amazon + 440+ stores
              ↓
         Same social promotion (Workflow 04)
         with "Available on Amazon" added to captions
```

---

## ⏱️ TIME INVESTMENT PER BOOK

| Task | Who | Time |
|------|-----|------|
| Mark product as KDP_Type in sheet | You | 1 min |
| 08A generates all files | Automated | 20-45 min (background) |
| 08B publishes to D2D + PublishDrive | Automated | 2 min |
| KDP manual upload (with guide) | You | 5 min |
| **Total your time** | **You** | **~6 minutes** |

---

## 🐛 TROUBLESHOOTING

| Issue | Fix |
|-------|-----|
| EPUB fails to convert | Install pandoc: `apt-get install pandoc` |
| Cover too small for KDP | Replicate generates 1600x2560 — should be fine. KDP min: 2560x1600 (landscape) OR 1600x2560 (portrait). We use portrait. |
| D2D API 401 error | Token expired — regenerate at d2d dashboard |
| PublishDrive book rejected | Usually EPUB formatting — check with EPUBCheck tool |
| PDF pages wrong size | Verify wkhtmltopdf version supports --page-width/height flags |
| KDP interior rejected | PDF must be exact trim size ± 0.125in. Our 8.5x11 is correct. |
