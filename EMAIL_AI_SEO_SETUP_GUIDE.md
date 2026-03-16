# 📧 EMAIL + 🤖 AI SEO SETUP GUIDE
## Workflows 11A/B/C (Brevo Email) + 12A/B/C (AI SEO)

---

## QUICK REFERENCE — NEW WORKFLOWS

| Workflow | What It Does | Trigger |
|----------|-------------|---------|
| 11A | llama3 writes email sequences | Webhook |
| 11B | Creates Brevo automations + sends | Called by 11A |
| 11C | Thursday newsletter scheduler | Every Thursday 9 AM |
| 12A | Injects schema markup into posts | WF09A + daily 3 AM |
| 12B | Generates programmatic SEO pages | Manual batches |
| 12C | Optimizes posts for AI citations | WF09A + weekly |

---

## BREVO SETUP (20 minutes)

### Step 1 — Create Account
1. brevo.com → Sign up free
2. Verify email
3. Fill sender profile with clearstackstudio.com domain

### Step 2 — Verify Your Domain (Important for deliverability)
```
Brevo → Settings → Senders & IP → Domains → Add Domain
Enter: clearstackstudio.com

Add these DNS records to your domain registrar:
  TXT record: brevo-code:xxxxxxxx  (they provide this)
  DKIM CNAME: mail._domainkey.clearstackstudio.com
  
After adding, click Verify. Takes 5-30 minutes.
```

### Step 3 — Create 4 Contact Lists
```
Brevo → Contacts → Lists → New List

List 1: "Welcome Sequence"       → Note the ID (e.g. 2)
List 2: "Buyers"                 → Note the ID (e.g. 3)
List 3: "Leads — Lead Magnet"    → Note the ID (e.g. 4)
List 4: "Newsletter Subscribers" → Note the ID (e.g. 5)
```

### Step 4 — Get API Key
```
Brevo → Settings → API Keys → Generate New API Key
Name: n8n Automation
Copy key: xkeysib-xxxxxxxxxxxxxxxxxx
```

### Step 5 — Update WF11B
Replace all instances of `YOUR_BREVO_API_KEY` and list IDs.

---

## EMAIL SEQUENCE INITIALIZATION (Run Once)

After Brevo is set up, run these 3 webhooks manually to
create the automations in Brevo. After that, they run forever.

### Initialize Welcome Series:
```bash
curl -X POST YOUR_N8N_BASE_URL/webhook/write-email-sequence \
  -H "Content-Type: application/json" \
  -d '{
    "sequence_type": "welcome",
    "lead_magnet_name": "Free Productivity Starter Kit",
    "lead_magnet_url": "https://clearstackstudio.com/free"
  }'
```

### Initialize Lead Magnet Sequence:
```bash
curl -X POST YOUR_N8N_BASE_URL/webhook/write-email-sequence \
  -H "Content-Type: application/json" \
  -d '{
    "sequence_type": "lead_magnet",
    "lead_magnet_name": "Free Productivity Starter Kit",
    "lead_magnet_url": "https://clearstackstudio.com/free"
  }'
```

### Post-Purchase sequences:
These are triggered automatically by WF03 after each sale.
No manual initialization needed — WF03 passes product data.

### Newsletter:
Runs automatically every Thursday at 9 AM.
No manual initialization needed.

---

## WF03 PATCH — Trigger Email After Purchase

Add this node to WF03 after "📊 Update Sheet — Published Status":

```
Node Name: 🔌 Trigger Post-Purchase Email (WF11A)
Type: HTTP Request
Method: POST
URL: YOUR_N8N_BASE_URL/webhook/write-email-sequence
Body:
{
  "sequence_type": "post_purchase",
  "contact_email": "{{ $json.buyer_email || '' }}",
  "contact_name": "{{ $json.buyer_name || '' }}",
  "product_name": "{{ $json.title }}",
  "product_url": "{{ $json.etsy_url || $json.gumroad_url }}",
  "product_price": "{{ $json.price }}"
}
```

Note: Etsy doesn't share buyer emails via API (privacy policy).
Gumroad and Payhip do. For Etsy buyers, the post-purchase
sequence fires without a contact_email — it creates the
automation in Brevo but doesn't add a contact.

---

## WF09A PATCH — Trigger SEO Workflows After New Post

Add these 3 nodes at the END of WF09A (after blog post is published):

### Node 1 — Trigger Schema Injection:
```
Name: 🔌 Inject Schema (WF12A)
Type: HTTP Request  
URL: YOUR_N8N_BASE_URL/webhook/inject-schema
Body: { "post_id": "{{ $('WordPress — Create Draft Post').first().json.id }}" }
```

### Node 2 — Trigger AI Citation Optimization:
```
Name: 🔌 Optimize for AI (WF12C)
Type: HTTP Request
URL: YOUR_N8N_BASE_URL/webhook/optimize-for-ai
Body: { "post_id": "{{ $('WordPress — Create Draft Post').first().json.id }}" }
```

### Node 3 — Trigger Internal Linking (WF10A):
```
Name: 🔌 Internal Links (WF10A)
Type: HTTP Request
URL: YOUR_N8N_BASE_URL/webhook/trigger-internal-links
Body: { "post_id": "{{ $('WordPress — Create Draft Post').first().json.id }}" }
```

Wire: Log to Content_Calendar → all 3 HTTP nodes (parallel)

---

## PROGRAMMATIC SEO PAGES — BATCH PLAN

Run these in order over ~2 weeks. Each batch = 5 pages.
Total: 20 batches = 100 pages.

```bash
# Batch 1-5: best_for_audience template
for i in 0 5 10 15 20 25 30 35 40 45; do
  curl -X POST YOUR_N8N_BASE_URL/webhook/generate-seo-pages \
    -H "Content-Type: application/json" \
    -d "{
      \"template_type\": \"best_for_audience\",
      \"batch_size\": 5,
      \"batch_offset\": $i
    }"
  sleep 300  # 5 minute gap between batches (VPS load)
done

# Batch 6-10: audience_tools template
for i in 0 5 10 15 20; do
  curl -X POST YOUR_N8N_BASE_URL/webhook/generate-seo-pages \
    -H "Content-Type: application/json" \
    -d "{
      \"template_type\": \"audience_tools\",
      \"batch_size\": 5,
      \"batch_offset\": $i
    }"
  sleep 300
done
```

IMPORTANT: After generating pages, do NOT run all 100 at once.
Google may flag rapid content generation. Recommended:
- Week 1: 25 pages
- Week 2: 25 pages
- Week 3: 25 pages
- Week 4: 25 pages

---

## NEW GOOGLE SHEETS TABS TO CREATE

Add these tabs to your main tracking sheet:

| Tab Name | Purpose |
|----------|---------|
| Email_Sequences_Log | Tracks all sequences written + Brevo automation IDs |
| Newsletter_Log | Thursday newsletter history |
| Schema_Injection_Log | Posts with schema + types injected |
| Programmatic_SEO_Pages | All 100 programmatic pages + URLs |
| AI_SEO_Optimization_Log | Posts optimized for AI citations + score improvement |

---

## QUICK-WIN CSS — Add to WordPress Theme

Add this to your theme's CSS for the Quick Answer and
Key Takeaways boxes that WF12C injects:

```css
/* Quick Answer box — highest AI citation signal */
.quick-answer {
  background: #F0F4FF;
  border-left: 4px solid #1B2A4A;
  padding: 16px 20px;
  margin: 20px 0;
  border-radius: 0 8px 8px 0;
  font-size: 15px;
  line-height: 1.6;
}
.quick-answer strong {
  color: #1B2A4A;
  display: block;
  margin-bottom: 6px;
  font-size: 13px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* Key Takeaways */
.key-takeaways {
  background: #FFFBF0;
  border: 1px solid #C9A84C;
  padding: 16px 20px 16px 36px;
  border-radius: 8px;
  margin: 20px 0;
}
.key-takeaways li {
  margin: 8px 0;
  font-size: 14px;
  color: #333;
}
```

Add to: WP Admin → Appearance → Customize → Additional CSS

---

## EXPECTED TIMELINE + RESULTS

```
Week 1-2:
  Email sequences live in Brevo ✅
  Schema injected into all existing posts ✅
  First 25 programmatic SEO pages published ✅
  
Month 1:
  Newsletter subscribers start growing (blog → capture form)
  Schema posts appear in Google featured snippets (5-15 posts)
  AI systems start citing FAQ sections
  
Month 2:
  Email list: 50-200 subscribers (from blog + ManyChat)
  Programmatic pages indexing (25-50 pages)
  Internal linking score improving
  
Month 3:
  Email list: 200-500 subscribers
  Weekly newsletter = consistent revenue touchpoint
  Programmatic pages driving 200-500 extra organic visits/month
  Posts appearing in ChatGPT/Perplexity responses (measure via manual testing)
  
Month 6:
  Email list: 1,000+ subscribers
  Email revenue: $500-2,000/month (from sequences alone)
  100 programmatic pages indexed
  Organic SEO traffic: 2,000-5,000 visits/month
```

---

## HALAL COMPLIANCE — EMAIL

✅ All sequences are permissible:
- No deceptive subject lines (avoid misleading teaser bait)
- Unsubscribe is always present (Brevo handles this automatically)
- No pressure selling tactics — sequences are helpful-first
- No interest/riba involved in any email monetization
- Lead magnets must deliver genuine value (not bait-and-switch)
- Disclose automation: "This email was sent automatically" in footer (optional but recommended)

The weekly newsletter must maintain quality — if llama3 produces
a weak newsletter, review before it goes out. The Thursday schedule
gives you Friday morning to check Brevo drafts if needed.
