# 🛒 WOOCOMMERCE PHASE 2 ACTIVATION GUIDE
## Everything you need to flip the switch when ready

---

## WHEN TO ACTIVATE

Activate WooCommerce when you hit **ANY** of these milestones:
- [ ] 20+ sales on Etsy/Gumroad (proven products)
- [ ] 200+ email subscribers (audience to sell to)
- [ ] 500+ monthly blog visitors (organic traffic)
- [ ] Etsy fees exceed $50/month (math makes sense)

Until then: keep running Phase 1. The system is already
preparing every product payload — it just isn't publishing yet.

---

## WHAT'S ALREADY DONE (prepared in Phase 1)

Every product published to Etsy/Gumroad/Payhip also:
- ✅ Has a WooCommerce payload prepared and logged
- ✅ Has a WordPress blog post (your domain authority building)
- ✅ Has Pinterest pins linking to YOUR domain
- ✅ Has SEO keywords mapped and ready

When you activate WooCommerce, all future products
auto-publish there. Past products can be bulk imported.

---

## ACTIVATION CHECKLIST — 8 STEPS

### STEP 1 — Install WooCommerce (15 min)

```bash
# On your VPS via WP-CLI
wp plugin install woocommerce --activate

# Configure basic settings
wp option update woocommerce_default_country "US"
wp option update woocommerce_currency "USD"
wp option update woocommerce_sell_in_your_country "yes"

# Set up digital product defaults
wp option update woocommerce_downloads_require_login "no"
wp option update woocommerce_downloads_grant_access_after_payment "yes"
```

Then in WP Admin:
- WooCommerce → Settings → General → Store Address (fill in)
- WooCommerce → Settings → Products → Downloads → set "File Download Method" to Force Downloads
- WooCommerce → Settings → Accounts → enable "Allow customers to create accounts"

---

### STEP 2 — Install Required Plugins (10 min)

```bash
# Free plugins
wp plugin install mailchimp-for-woocommerce --activate
wp plugin install woocommerce-pdf-invoices-packing-slips --activate
wp plugin install yith-woocommerce-wishlist --activate

# Payment gateway (Stripe recommended — halal: no riba)
wp plugin install woocommerce-gateway-stripe --activate
```

**Stripe setup** (takes 10-15 min):
1. stripe.com → Create account
2. WP Admin → WooCommerce → Settings → Payments → Stripe → Configure
3. Enter publishable key + secret key
4. Enable "Stripe" and save

**PayPal (backup)**:
- WP Admin → WooCommerce → Settings → Payments → PayPal → Configure

**HALAL NOTE**: Both Stripe and PayPal charge flat transaction fees — not interest. This is permissible. Do NOT enable "buy now pay later" (Klarna, Afterpay) as these involve interest.

---

### STEP 3 — Generate WooCommerce API Credentials (5 min)

1. WP Admin → WooCommerce → Settings → Advanced → REST API
2. Click "Add Key"
3. Description: "n8n Automation"
4. User: your admin user
5. Permissions: Read/Write
6. Click "Generate API Key"
7. **Copy both keys NOW** (shown only once)

```bash
# Base64 encode for n8n HTTP headers
echo -n "ck_your_consumer_key:cs_your_consumer_secret" | base64
# Example output: Y2tfeW91cl9jb25zdW1lcl9rZXk6Y3NfeW91cl9jb25zdW1lcl9zZWNyZXQ=
```

---

### STEP 4 — Create Product Categories in WooCommerce (5 min)

```
WP Admin → Products → Categories → Add New:

Category Name          Slug
─────────────────────────────────────────
Productivity           productivity
Business Templates     business-templates
Planners & Journals    planners-journals
Creative Templates     creative-templates
Seasonal               seasonal

After creating: note each category's ID number
(shown in URL when you edit: ?tag_ID=XX)
```

---

### STEP 5 — Update WF06 Brand Config (2 min)

Open Workflow 06 → `⚙️ Brand Registry + Genre Router` node.

Find the `woocommerce` section and update:

```javascript
woocommerce: {
  enabled: true,                        // ← CHANGE FALSE TO TRUE
  url: 'https://clearstackstudio.com',
  consumer_key: 'ck_your_key_here',    // ← PASTE YOUR KEY
  consumer_secret: 'cs_your_secret_here', // ← PASTE YOUR SECRET
  
  store_settings: {
    email_capture_enabled: true,
    email_provider: 'mailchimp',
    email_api_key: 'YOUR_MAILCHIMP_KEY', // ← ADD MAILCHIMP KEY
    email_list_id: 'YOUR_LIST_ID',
    email_tag_on_purchase: 'clearstack-buyer'
  },
  
  category_ids: {
    productivity: 5,    // ← REPLACE WITH YOUR ACTUAL IDs
    business: 6,
    templates: 7,
    planners: 8,
    seasonal: 9
  }
}
```

---

### STEP 6 — Update WF03 Publishing Agent (1 min)

Open Workflow 03 → `⚙️ Prep WooCommerce Payload` node.

Find this line and change it:
```javascript
// BEFORE:
const wcEnabledGlobal = false;

// AFTER:
const wcEnabledGlobal = true;
```

Also update the `🛒 Publish to WooCommerce` node header:
- Replace `YOUR_WC_BASE64_CREDENTIALS` with your Base64 string from Step 3.

---

### STEP 7 — Update Blog CTAs to Point to WooCommerce (ongoing)

In Workflow 09A (Content Engine), the blog post CTA URLs currently
point to Etsy/Gumroad. After WC activation, update the primary URL:

In `⚙️ Parse Blog → WordPress Payload` node:
```javascript
// BEFORE (Phase 1):
const primaryUrl = product.store_urls.etsy || product.store_urls.gumroad || '#';

// AFTER (Phase 2):
const primaryUrl = product.store_urls.woocommerce 
  || product.store_urls.etsy 
  || product.store_urls.gumroad || '#';
```

This means:
- Blog readers → land on YOUR store → you capture email + keep 100%
- Etsy → still runs as discovery channel → new customers find you
- Gumroad → kept as fallback and for affiliate sales

---

### STEP 8 — Set Up Email Capture (30 min — highest ROI task)

Every WooCommerce buyer should join your email list automatically.

**Mailchimp setup (free up to 500 contacts)**:
1. mailchimp.com → Create account
2. Audience → Create Audience → "ClearStack Buyers"
3. Settings → API Keys → Create Key
4. WP Admin → Mailchimp for WooCommerce → Connect → paste API key
5. Map "Subscribed" to your audience
6. Enable "Subscribe customers on checkout"

**What to send (automated email sequence)**:
```
Day 0:  Purchase confirmation + download link (WooCommerce auto)
Day 1:  "How to get the most from [product]" tips email
Day 3:  Related product recommendation (your other products)
Day 7:  "Exclusive subscriber discount" — 15% off next purchase
Day 14: New product announcement
Day 30: Monthly bundle deal email
```

This sequence alone can 2-3x your revenue from existing buyers.

---

## STRATEGY: HOW ETSY + WOOCOMMERCE WORK TOGETHER

```
DON'T think of it as Etsy vs WooCommerce.
Think of it as a funnel:

ETSY                          WOOCOMMERCE
─────────────────────────────────────────────────
Discovery phase               Retention phase
Cold audience                 Warm/hot audience
Etsy brings them              YOU bring them (blog/social)
6.5% fee                      0% fee (just hosting)
Etsy owns the email           YOU own the email
One-time buyer likely         Email → repeat buyer
Etsy's trust = lower risk     Your site = more credibility needed

COMBINED STRATEGY:
  Etsy buyer → email follow-up → 
  "Next time, shop directly + save 10%" → 
  Moves to WooCommerce for future purchases
  
  Blog reader → direct to WooCommerce →
  Buys + joins email list →
  Receives sequence → buys again
  
  Result: Etsy = customer acquisition
          WooCommerce = customer retention + lifetime value
```

---

## WOOCOMMERCE FEATURES TO ADD OVER TIME

| Feature | Plugin | When |
|---------|--------|------|
| Product bundles | WooCommerce Product Bundles ($49) | Month 4+ |
| Subscriptions (template membership) | WooCommerce Subscriptions ($199/yr) | Month 6+ |
| Affiliate program | AffiliateWP ($149/yr) | Month 6+ |
| Advanced coupons | Advanced Coupons (free) | Phase 2 start |
| Wishlist | YITH Wishlist (free) | Phase 2 start |
| Reviews | WooCommerce built-in | Phase 2 start |

---

## PUBLISHED_PRODUCTS SHEET — NEW COLUMNS TO ADD

Add these columns to your Google Sheet now (they'll fill in Phase 2):

| Column | Description |
|--------|-------------|
| WC_Status | PHASE_2_PENDING → PUBLISHED |
| WC_Product_ID | WooCommerce internal product ID |
| WC_Product_URL | Full URL on your store |
| WC_SKU | Product SKU (auto-generated: CSP-xxxx) |
| WC_Enabled | YES/NO per-product override |

---

## ONE-LINE PHASE 2 SUMMARY

When you're ready: update 2 lines of code in n8n (wcEnabledGlobal + credentials),
add WC credentials to WF06, and every future product auto-publishes to your
WooCommerce store with full email capture, zero transaction fees, and 100%
brand ownership. The system is already prepared and waiting.
