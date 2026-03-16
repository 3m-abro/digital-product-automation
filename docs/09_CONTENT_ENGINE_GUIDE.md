# 🎬 CONTENT ENGINE SETUP GUIDE
## Workflows 09A + 09B + 09C

---

## 📦 WHAT WAS BUILT

### 09A — Content Engine (runs first, triggers B and C)
Runs 4 AI agents in parallel per product:

| Agent | Model | Output |
|-------|-------|--------|
| Carousel Writer | llama3 | 3 complete carousel series (21 slides total) |
| Video Script Writer | mistral | 4 platform-specific video scripts |
| SEO Blog Writer | llama3 | Full 1500-word blog post + 3 Pinterest pin variations |
| FFmpeg Generator | phi3 | Precise video render commands |

Then renders all carousel slides to 1080x1080 JPGs and uploads to Drive.

### 09B — Video Renderer
| Video | Duration | Method | Platform |
|-------|----------|--------|----------|
| Product zoom/pan | 8s | FFmpeg | Stories, Ads |
| TikTok text-overlay | 15s | FFmpeg | TikTok |
| Instagram Reels | 30s | FFmpeg | IG Reels |
| YouTube Shorts | 45s | FFmpeg | YouTube |
| UGC Avatar (optional) | 30s | HeyGen API | All platforms |

### 09C — Blog Publisher
- Converts blog to WordPress Gutenberg blocks OR Ghost HTML
- Generates featured image (1200x628) via Replicate
- Publishes post with full SEO meta (Yoast/RankMath compatible)
- Posts 3 Pinterest pins all linking to the blog post
- Humanizes meta description via Workflow 05
- Pings sitemap for faster Google indexing

---

## 🗺️ COMPLETE CONTENT FUNNEL

```
PRODUCT PUBLISHED (Workflow 03)
          │
          ▼
    09A Content Engine
    ┌─────────────────────────────────────┐
    │  llama3: 3 carousel series          │
    │  mistral: 4 video scripts           │
    │  llama3: SEO blog post              │
    │  phi3: FFmpeg commands              │
    └─────────────────────────────────────┘
          │                    │
          ▼                    ▼
    09B Video Renderer    09C Blog Publisher
    ┌───────────────┐    ┌──────────────────┐
    │ FFmpeg renders│    │ WordPress/Ghost   │
    │ TikTok 15s    │    │ Featured image    │
    │ Reels 30s     │    │ 3 Pinterest pins  │
    │ Shorts 45s    │    │ SEO meta          │
    │ Zoom 8s       │    │ Sitemap ping      │
    │ [HeyGen opt.] │    └──────────────────┘
    └───────────────┘
          │                    │
          ▼                    ▼
    Google Drive          Blog goes live
    Video Library         Pinterest indexed
          │                    │
          └─────────┬──────────┘
                    ▼
             Workflow 04
         (Social Posting Agent)
         Posts everything to all
         platforms with real URLs


TRAFFIC FLOW RESULT:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Google Search → Blog Post → Store
Pinterest → Blog Post → Store
TikTok/IG/YT → Bio Link → Store
Pinterest → Carousel → Store
```

---

## 🔑 NEW CREDENTIALS NEEDED

### WordPress (Choose ONE of these options)

**Option A — WordPress.com Free**
- Sign up at wordpress.com (free tier available)
- Install Yoast SEO or RankMath plugin (free)
- Admin → Users → Profile → Application Passwords → Add New
- Replace `YOUR_WORDPRESS_SITE_URL` and use Basic Auth

**Option B — Self-hosted on your VPS (recommended)**
```bash
# Install on your VPS
apt-get install apache2 mysql-server php php-mysql
wget https://wordpress.org/latest.tar.gz
# Follow standard WordPress install
# Then install WP REST API is built-in (no extra setup)
```
- Add domain: Get free domain via Freenom or cheap at Namecheap
- Install RankMath SEO (free, better than Yoast)
- Install WP Application Password plugin if WP < 5.6

**Option C — Ghost (cleaner, faster SEO)**
- ghost.org → Start free (14-day trial, then $9/month)
- OR self-host: `npm install -g ghost-cli && ghost install`
- Admin → Settings → Integrations → Add Custom Integration
- Copy Admin API Key → Replace `YOUR_GHOST_ADMIN_API_KEY`

**My recommendation:** Self-hosted WordPress on your existing VPS.
You already have the VPS — add WordPress and it costs $0 extra.
```bash
# Quick WordPress on Ubuntu VPS
sudo apt install apache2 mysql-server php php-mysql php-curl php-gd
sudo mysql -e "CREATE DATABASE clearstack_blog; CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'YOUR_PASSWORD'; GRANT ALL ON clearstack_blog.* TO 'wpuser'@'localhost';"
wget https://wordpress.org/latest.tar.gz -O /var/www/html/wp.tar.gz
cd /var/www/html && tar -xzf wp.tar.gz
```

### HeyGen (Optional - Avatar Videos)
- Sign up at heygen.com
- Settings → API → Generate API Key
- Choose avatar: Settings → Avatars → Browse (pick modest, professional)
- Copy Avatar ID and Voice ID
- Free tier: 1 min/month (enough for testing)
- Paid: $29/month for 15 min
- Replace `YOUR_HEYGEN_API_KEY`, `YOUR_HEYGEN_AVATAR_ID`, `YOUR_HEYGEN_VOICE_ID`

### FFmpeg (Already on VPS from setup script, verify):
```bash
ffmpeg -version
# If missing:
sudo apt-get install -y ffmpeg fonts-open-sans fonts-liberation
```

---

## 📊 NEW GOOGLE SHEETS TABS NEEDED

### Tab: `Content_Library`
| Column | Description |
|--------|-------------|
| Product_ID | |
| Product_Name | |
| Content_Type | |
| Carousel_Count | Auto |
| Video_Count | Auto |
| Blog_Ready | Auto |
| Blog_Keyword | Auto |
| Blog_Title | Auto |
| Blog_Slug | Auto |
| Pinterest_Pins | Auto |
| FFmpeg_Commands | Auto |
| Content_Calendar | Auto |
| Status | Auto |
| Created_At | Auto |

### Tab: `Video_Library`
| Column | Description |
|--------|-------------|
| Product_ID | |
| Total_Videos | Auto |
| Has_Avatar | Auto |
| Videos_Summary | Platform breakdown |
| Drive_Folder | Link to videos |
| Status | Auto |
| Completed_At | Auto |

### Tab: `Blog_Library`
⭐ **Most important for long-term tracking**
| Column | Description |
|--------|-------------|
| Product_ID | |
| Blog_URL | Live URL |
| Platform | wordpress/ghost |
| Post_ID | |
| Primary_Keyword | What you're trying to rank for |
| Meta_Title | |
| Featured_Image | Image URL |
| Pinterest_Pins_Posted | Count |
| Ranking_Timeline | Expected timeframe |
| Check_Rankings_After | Days |
| Status | Published |
| Published_At | Date |
| **Google_Search_Console** | SUBMIT MANUALLY |
| **Current_Ranking** | You update monthly |
| **Monthly_Traffic** | You update monthly |

---

## 📅 CONTENT CALENDAR (Auto-Generated Per Product)

Each product generates a 4-week content calendar:

```
WEEK 1 (Launch Week)
  Tuesday:  Instagram — Carousel 1 (Problem/Solution)
  Wednesday: Facebook — Carousel 1 (longer caption)
  Thursday:  Blog goes live (auto)
  Thursday:  Pinterest pins 1+2+3 posted (auto)
  Friday:    TikTok — 15s text overlay video

WEEK 2
  Monday:   Instagram Reels — 30s tips video
  Tuesday:  Pinterest — Carousel 2 slides repurposed as pins
  Thursday: Instagram — Carousel 2 (Tips/Listicle)
  Friday:   YouTube Shorts — 45s walkthrough

WEEK 3
  Tuesday:  Instagram — Carousel 3 (Before/After)
  Wednesday: TikTok — Repurpose carousel as video
  Thursday: Facebook — Blog post share
  Friday:   Pinterest — More pins from blog images

WEEK 4 (if avatar enabled)
  Tuesday:  TikTok — UGC Avatar video
  Wednesday: Instagram Reels — UGC Avatar
  Thursday: YouTube — UGC Avatar as regular video
```

---

## 🎯 AVATAR DECISION GUIDE

**Start WITHOUT avatar if:**
- Budget is tight (save the $29/month)
- You have fewer than 10 products live
- You're still testing what converts

**Add avatar when:**
- Making consistent sales (cover the cost)
- Ready to scale TikTok aggressively
- Text videos have proven your messaging

**When you enable avatar:**
1. Open Workflow 09B
2. Find the `⚙️ Prep Video Jobs` node
3. Change the has_avatar condition to check brand config
4. Add `heygen_enabled: true` to your brand in Workflow 06
5. All new products will automatically get avatar videos

---

## 🔧 ADDITIONAL VPS SETUP

```bash
# FFmpeg with all needed codecs
sudo apt-get install -y ffmpeg

# Fonts for text overlay videos
sudo apt-get install -y fonts-open-sans fonts-liberation fonts-lato

# Verify fonts are available to FFmpeg
fc-list | grep -i open
fc-list | grep -i lato

# Test video generation
ffmpeg -f lavfi -i color=c=0x1B2A4A:size=1080x1920:rate=30 \
  -vf "drawtext=text='ClearStack Studio':fontsize=72:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2" \
  -t 3 /tmp/test_video.mp4

# Check output
ls -lh /tmp/test_video.mp4
```

---

## 🌐 BLOG SEO STRATEGY FOR CLEARSTACK

### Target Keyword Clusters:
```
CLUSTER 1: Notion Templates
  Primary: "notion template for freelancers"
  Supporting: "free notion template", "notion planner template",
              "notion business template", "notion weekly planner"

CLUSTER 2: Productivity Printables  
  Primary: "printable weekly planner"
  Supporting: "free printable planner", "daily planner printable",
              "productivity planner pdf", "habit tracker printable"

CLUSTER 3: Business Templates
  Primary: "small business templates"
  Supporting: "invoice template word", "business plan template",
              "client onboarding template", "project tracker template"

CLUSTER 4: Content Creator Tools
  Primary: "content calendar template"
  Supporting: "social media planner", "content creator tools",
              "instagram content planner", "youtube video planner"
```

### Pinterest → Blog → Store Funnel Performance:
```
EXPECTED TIMELINE:
Month 1: Blog posts indexed, Pinterest pins gaining impressions
Month 2: First blog posts ranking on page 2-3 Google
Month 3: Top posts reaching page 1 for long-tail keywords
Month 6: 500-2000 monthly organic visits per active keyword
Month 12: 2000-10000 monthly organic visits compound effect

CONVERSION EXPECTATION:
2-3% of blog visitors click through to store
1-2% of store visitors purchase
At $9.99 avg price: 1000 visits → 20-30 clicks → $200-300/month
This is per blog post. At 50 posts → $10,000-15,000/month potential
```

### Recommended Blog Platform Stack:
```
Option A (Free, your VPS):
  WordPress + RankMath (free) + Cloudflare (free CDN)
  Cost: $0 extra (use existing VPS)
  
Option B (Easiest):
  Ghost Pro ($9/month) — built-in SEO, fast, clean
  
Option C (Most powerful):
  WordPress + RankMath Pro ($59/year) + WP Rocket ($49/year)
  Best SEO control, plugin ecosystem
```
