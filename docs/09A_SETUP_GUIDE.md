# 📰 WORKFLOW 09A — BLOG + CAROUSEL SETUP GUIDE

---

## WHAT THIS WORKFLOW PRODUCES PER PRODUCT

```
1 product published → 09A triggers → generates:

📝 BLOG PIPELINE (runs in parallel)
  ├── 1 × SEO blog post (1800-2200 words)
  │     llama3 writes → WF05 humanizes
  │     → WordPress draft (you review + publish)
  │     → Yoast/RankMath SEO meta auto-filled
  │     → Pinterest pin created linking to blog
  │     → Google sitemap pinged
  │
🎠 CAROUSEL PIPELINE (runs in parallel)
  ├── Carousel 1: Educational (5 ways to use)
  ├── Carousel 2: Problem → Solution
  ├── Carousel 3: Before → After
  │     Each = 6-8 slides @ 1080×1080px
  │     Rendered as PNG via wkhtmltoimage
  │     Posted to Instagram, Facebook, Pinterest
  │
TOTAL: 7 pieces of content per product
TOTAL YOUR TIME: ~3 minutes (review blog draft)
```

---

## STEP 1 — INSTALL WORDPRESS ON YOUR VPS

```bash
# Ubuntu/Debian — simplest method
sudo apt-get update
sudo apt-get install -y wordpress php php-mysql mysql-server nginx

# OR use the automated script (recommended)
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

# Create database
sudo mysql -e "CREATE DATABASE clearstack_blog;"
sudo mysql -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'YOUR_STRONG_PASSWORD';"
sudo mysql -e "GRANT ALL PRIVILEGES ON clearstack_blog.* TO 'wpuser'@'localhost';"

# Install WordPress
mkdir -p /var/www/clearstackstudio.com
cd /var/www/clearstackstudio.com
wp core download
wp config create \
  --dbname=clearstack_blog \
  --dbuser=wpuser \
  --dbpass=YOUR_STRONG_PASSWORD \
  --dbhost=localhost
wp core install \
  --url=https://clearstackstudio.com \
  --title="ClearStack Studio" \
  --admin_user=clearstack_admin \
  --admin_password=YOUR_ADMIN_PASSWORD \
  --admin_email=hello@clearstackstudio.com

# Install Yoast SEO (for meta tags)
wp plugin install wordpress-seo --activate

# Enable pretty permalinks
wp rewrite structure '/%postname%/'
wp rewrite flush
```

### Set up WordPress Application Password for API:
1. WP Admin → Users → Profile
2. Scroll to "Application Passwords"
3. Name: "n8n Automation"
4. Click Generate
5. Copy the password (shown only once)
6. Base64 encode: `echo -n "admin_username:app_password" | base64`
7. Replace `YOUR_WP_BASE64_AUTH` in Workflow 09A node

---

## STEP 2 — VERIFY wkhtmltoimage IS INSTALLED

```bash
# Should already be installed from vps_setup.sh
# Verify:
wkhtmltoimage --version

# If missing:
sudo apt-get install -y wkhtmltopdf
# wkhtmltoimage is included in the wkhtmltopdf package

# Test it works:
echo '<html><body style="width:1080px;height:1080px;background:navy;color:white;display:flex;align-items:center;justify-content:center;font-size:48px;">TEST</body></html>' > /tmp/test_slide.html
wkhtmltoimage --width 1080 --height 1080 /tmp/test_slide.html /tmp/test_slide.png
ls -la /tmp/test_slide.png
# Should show a ~50-200KB PNG file
```

---

## STEP 3 — CONFIGURE WORKFLOW 09A

Replace these placeholders in the workflow:

| Placeholder | Replace With |
|-------------|-------------|
| `YOUR_N8N_BASE_URL` | Your n8n URL e.g. `http://localhost:5678` |
| `YOUR_WP_BASE64_AUTH` | Base64 of `username:app_password` |
| `YOUR_GOOGLE_SHEET_ID_HERE` | Your Google Sheet ID |
| `YOUR_CLEARSTACK_PINTEREST_TOKEN` | Pinterest OAuth token |
| `YOUR_CLEARSTACK_PRODUCTIVITY_BOARD_ID` | Pinterest board ID |

---

## STEP 4 — WIRE 09A INTO WORKFLOW 03 (Publishing Agent)

Add this HTTP Request node at the **END of Workflow 03**, after all stores are published:

```
Node Name: 🔌 Trigger Content Engine (WF09A)
Type: HTTP Request
Method: POST
URL: YOUR_N8N_BASE_URL/webhook/content-engine
Body:
{
  "product_id": "{{ $json.product_id }}",
  "title": "{{ $json.title }}",
  "description": "{{ $json.description_long || $json.description }}",
  "category": "{{ $json.category }}",
  "brand_id": "clearstack",
  "keywords": {{ JSON.stringify($json.tags || $json.keywords || []) }},
  "price": {{ $json.price }},
  "etsy_url": "{{ $json.etsy_url || '' }}",
  "gumroad_url": "{{ $json.gumroad_url || '' }}",
  "payhip_url": "{{ $json.payhip_url || '' }}",
  "cover_image": "{{ $json.cover_image_url || '' }}"
}
```

This fires automatically every time a product goes live on your stores.

---

## STEP 5 — NEW GOOGLE SHEETS TABS

### Tab: `Content_Calendar`
Tracks every piece of content generated.

| Column | Auto/Manual |
|--------|-------------|
| Date | Auto |
| Product_ID | Auto |
| Product_Title | Auto |
| Brand | Auto |
| Blog_Post_ID | Auto |
| Blog_Status | Auto |
| Carousels_Generated | Auto |
| Pinterest_Blog_Pin | Auto |
| IG_Posted | Auto |
| FB_Posted | Auto |
| Pinterest_Carousel | Auto |
| Total_Content_Pieces | Auto |
| Status | Auto |
| Notes | Auto |

### Tab: `Content_Blocked_Log`
Products blocked by halal check before content generation.

| Column | Description |
|--------|-------------|
| Timestamp | When blocked |
| Product | Product name |
| Reason | Why blocked |
| Flags | Specific flags found |

---

## WORDPRESS SEO SETUP (Do Once)

### Install and configure Yoast SEO:
1. WP Admin → Plugins → Add New → Search "Yoast SEO" → Install + Activate
2. SEO → General → Features → Enable "REST API: Head endpoint" (allows n8n to set meta)
3. SEO → Search Appearance → Set site name and tagline

### Install Yoast REST API meta endpoint:
The workflow writes `_yoast_wpseo_*` meta fields directly via REST API.
For this to work, Yoast must be installed AND you need this snippet in functions.php:

```php
// Add to wp-content/themes/YOUR_THEME/functions.php
// Allows Yoast SEO meta to be set via REST API
add_filter( 'wpseo_accessible_post_types', function( $post_types ) {
    return $post_types;
});

// Register Yoast meta fields for REST API
add_action('rest_api_init', function() {
    register_rest_field('post', '_yoast_wpseo_focuskw', [
        'get_callback' => function($post) { return get_post_meta($post['id'], '_yoast_wpseo_focuskw', true); },
        'update_callback' => function($value, $post) { update_post_meta($post->ID, '_yoast_wpseo_focuskw', $value); },
        'schema' => ['type' => 'string']
    ]);
    register_rest_field('post', '_yoast_wpseo_metadesc', [
        'get_callback' => function($post) { return get_post_meta($post['id'], '_yoast_wpseo_metadesc', true); },
        'update_callback' => function($value, $post) { update_post_meta($post->ID, '_yoast_wpseo_metadesc', $value); },
        'schema' => ['type' => 'string']
    ]);
    register_rest_field('post', '_yoast_wpseo_title', [
        'get_callback' => function($post) { return get_post_meta($post['id'], '_yoast_wpseo_title', true); },
        'update_callback' => function($value, $post) { update_post_meta($post->ID, '_yoast_wpseo_title', $value); },
        'schema' => ['type' => 'string']
    ]);
});
```

---

## BLOG CONTENT STRATEGY FOR CLEARSTACK

### Blog post types to generate per product category:

| Product Type | Blog Angle | Example Title |
|-------------|-----------|---------------|
| Notion template | How-to guide | "How to Build a Content Calendar in Notion (Free Template)" |
| Planner printable | Productivity tip | "The Weekly Review System That Actually Sticks" |
| Business template | Problem/solution | "Stop Losing Clients: The Onboarding Template Every Freelancer Needs" |
| Canva template | Tutorial | "How to Create a Professional Media Kit in 20 Minutes" |
| Content calendar | Strategy | "The 90-Day Content Strategy for Solopreneurs (With Free Template)" |

### Pinterest → Blog → Store loop:
```
Pinterest user sees pin
    ↓
Clicks to blog post (your domain)
    ↓
Reads valuable content
    ↓
Sees 2 product CTAs in the post
    ↓
Clicks to Etsy/Gumroad
    ↓
Buys product
```
Each blog post is an evergreen sales funnel.

### Google SEO timeline expectations:
- Week 1-2: Google indexes new posts
- Month 1-2: Posts appear in search, low rankings
- Month 3-4: Rankings climb as domain authority builds
- Month 6+: Consistent organic traffic, compounding

### Submit to Google Search Console (do once):
1. search.google.com/search-console
2. Add property → URL prefix → https://clearstackstudio.com
3. Verify via HTML file upload to WordPress
4. Sitemaps → Submit → https://clearstackstudio.com/sitemap_index.xml

---

## CAROUSEL STRATEGY

### The 3 carousel types explained:

**Educational** ("5 ways to use this"):
- Slide 1: "5 ways [product] will change how you work"
- Slides 2-6: One tip per slide, specific and actionable
- Slide 7: CTA
Best for: Building trust, saving for later, educational saves

**Problem/Solution**:
- Slide 1: The specific pain ("Still using a messy spreadsheet to track clients?")
- Slides 2-4: The problem illustrated
- Slides 5-6: Your product as the solution
- Slide 7: CTA with price
Best for: Conversion, reaching people actively frustrated by the problem

**Before/After**:
- Slide 1: "Before: chaos. After: clarity." hook
- Slides 2-4: Before state (messy, overwhelming, disorganized)
- Slides 5-6: After state (with your product)
- Slide 7: CTA
Best for: Aspirational audiences, high save rates on Pinterest

### Post scheduling (recommended):
- Post each carousel type on different days (not all at once)
- Educational: Monday (people plan their week)
- Problem/Solution: Wednesday
- Before/After: Friday (aspirational end-of-week mood)

---

## TROUBLESHOOTING

| Issue | Fix |
|-------|-----|
| WordPress REST API returns 401 | Re-generate Application Password in WP Admin |
| wkhtmltoimage produces blank PNGs | Add --enable-local-file-access flag |
| Blog post missing Yoast meta | Add functions.php snippet from Step 5 |
| Pinterest pin not created | Verify board ID — copy from Pinterest URL |
| Carousel slides cut off | Ensure HTML body is exactly 1080x1080, no overflow |
| llama3 blog times out | Increase n8n execution timeout to 1800s |
