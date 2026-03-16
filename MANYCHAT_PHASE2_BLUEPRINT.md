# 💬 MANYCHAT PHASE 2 BLUEPRINT
## ClearStack Studio — Instagram & Facebook DM Automation

---

## WHEN TO ACTIVATE
Activate ManyChat when you hit ANY of these:
- [ ] 50+ Instagram followers
- [ ] First post gets 10+ comments
- [ ] Any post gets organic reach without paid ads
- [ ] You have a lead magnet ready (free template/checklist)

Until then: this blueprint is ready. Nothing to build yet.

---

## WHAT MANYCHAT DOES FOR YOUR SYSTEM

```
WITHOUT MANYCHAT:
  Post → some likes → maybe profile visit → maybe link in bio click
  Conversion rate: ~1-3%

WITH MANYCHAT:
  Post → "Comment TEMPLATE" → auto-DM with link
  → email captured in DM flow → added to Mailchimp
  → email sequence sells products
  Conversion rate: 15-30% of commenters become leads

WHY IT WORKS:
  Instagram algorithm rewards comments + DM activity
  Comment triggers = 10x more reach than link-in-bio
  DMs have 80%+ open rate vs 20% for email
  Feels personal even when automated
```

---

## SETUP (15 minutes when ready)

1. manychat.com → Sign up free
2. Connect Instagram Business account
3. Connect Facebook Page
4. Free tier: up to 1,000 contacts
5. Pro tier: $15/month (unlimited contacts + advanced flows)

---

## FLOW 1 — "COMMENT FOR THE LINK" (Most Important)

**Trigger:** Comment contains keyword → auto-DM with product link

### How to use it:
In your carousel/video caption, write:
> *"Comment TEMPLATE below and I'll DM you the direct link 👇"*

### ManyChat Setup:
```
Trigger Type: Instagram Comment Contains Keyword
Keywords: TEMPLATE, template, link, LINK, send it, yes, interested

Actions:
1. Like their comment (optional — shows you saw it)
2. Reply to comment: "Check your DMs! 📩"
3. Send DM Flow →

DM Flow:
  Message 1:
  "Hey! Here's the link you asked for 👇
  
  [Product Name] — $[Price]
  👉 [STORE_URL]
  
  It's the [one-line value prop].
  
  Any questions? Just reply here 😊"

  Wait 2 hours, then:
  
  Message 2 (if no purchase):
  "Did the link work okay? 
  Just checking in — happy to answer any questions!"

  Wait 24 hours, then:
  
  Message 3 (email capture):
  "Want me to send you a free [related freebie]?
  Just drop your email and I'll send it right over 📧"
  
  [EMAIL INPUT BUTTON] → captured to Mailchimp
```

### Variants per product type:
| Product | Trigger Word | DM Hook |
|---------|-------------|---------|
| Notion template | NOTION | "Here's the Notion template that runs my whole business →" |
| Planner | PLANNER | "Here's the planner — it works in your notes app too →" |
| Business template | TOOLKIT | "Your business template toolkit is ready →" |
| Free resource | FREE | "Here's your free [resource] — no strings attached →" |

---

## FLOW 2 — STORY REPLY AUTOMATION

**Trigger:** Someone replies to your Instagram Story

### Story types that trigger this:
- "Link in bio" story → auto-DM the direct link
- Product demo story → "Want this?" DM flow
- "DM me for the freebie" story → auto-send freebie

### ManyChat Setup:
```
Trigger: Story Reply (any reply OR keyword reply)

DM Flow:
  Message 1:
  "Thanks for replying! 🙌
  
  Here's what you asked about:
  👉 [STORE_URL]
  
  [Product Name] — $[Price]
  
  Questions? I'm right here."
```

---

## FLOW 3 — WELCOME NEW FOLLOWERS

**Trigger:** New follower (Pro tier only)

```
Wait 30 minutes (feels natural, not instant-bot)

DM Flow:
  "Hey [First Name]! Welcome to ClearStack Studio 👋

  I create productivity templates and tools for
  entrepreneurs and freelancers.

  Quick question — what's your biggest productivity
  challenge right now?
  
  [Tap to reply: Planning] [Tap to reply: Client Work]
  [Tap to reply: Content] [Tap to reply: Just browsing]"

Branch based on reply:
  Planning → send productivity template link
  Client Work → send client management template link
  Content → send content calendar template link
  Just browsing → "No worries! Here's my free starter pack:" → email capture
```

---

## FLOW 4 — LEAD MAGNET DELIVERY

**Purpose:** Give away a free resource in exchange for email

**What to offer (create these):**
```
Option A: "Free Weekly Planner Template" (1 page PDF)
Option B: "Free Content Calendar Template" (Notion or Google Sheets)
Option C: "Free Business Checklist" (PDF)

These become your list-building engine.
Cost to create: 30 minutes using WF02B (creation factory)
```

### Caption to use:
> *"Want my free weekly planner? Comment FREE below 👇"*

### ManyChat Flow:
```
Trigger: Comment contains FREE

DM Flow:
  Message 1:
  "Your free planner is almost ready!
  
  Drop your email below and I'll send it
  straight to your inbox 📧"
  
  [Email input]
  
  → Captured email goes to Mailchimp
  → Tagged: 'manychat-lead' + 'freebie-planner'
  → Triggers email sequence (see below)
  
  Message 2 (after email captured):
  "Perfect! Check your inbox in the next few minutes 🎉
  
  P.S. — I also just added you to my list where I share
  free templates every week. You can unsubscribe anytime."
  
  → Deliver download link or Mailchimp sends it
```

---

## EMAIL SEQUENCE AFTER MANYCHAT CAPTURE
(Set up in Mailchimp — not ManyChat)

```
Tag: manychat-lead

Day 0:  Freebie delivery + welcome
        Subject: "Your free [resource] is here 🎉"
        Body: Download link + "Here's how to use it"

Day 2:  Value email — no selling
        Subject: "3 things I wish I knew when I started"
        Body: Genuine tips, no CTA to buy

Day 4:  Social proof
        Subject: "What happened when I started using systems"
        Body: Story + soft mention of paid product

Day 7:  First product offer
        Subject: "The template that saved me 5 hours/week"
        Body: Product pitch + link + discount code WELCOME15

Day 14: Second product
        Subject: "[Name], have you seen this?"
        Body: Different product, different pain point

Day 21: Bundle offer
        Subject: "Get everything for 30% off (this week only)"
        Body: Bundle deal — creates urgency

Ongoing: Weekly newsletter
        Subject: "This week's tip + what's new at ClearStack"
        Body: 1 tip + 1 product + 1 community post
```

---

## N8N INTEGRATION (Phase 2 — Wire When Ready)

When ManyChat is active, connect it to your n8n system:

### ManyChat → Mailchimp (via ManyChat native integration):
- Built into ManyChat: Integrations → Mailchimp → map email field
- Tag captured leads automatically

### ManyChat → Google Sheets (via ManyChat Webhook):
```
ManyChat Settings → Integrations → External Request
URL: YOUR_N8N_BASE_URL/webhook/manychat-lead
Method: POST
Body:
{
  "subscriber_id": "{{id}}",
  "first_name": "{{first name}}",
  "last_name": "{{last name}}",
  "email": "{{email}}",
  "phone": "{{phone}}",
  "trigger_flow": "{{flow name}}",
  "product_interest": "{{custom field: product_interest}}",
  "timestamp": "{{current datetime}}"
}
```

### n8n receives ManyChat leads (add to WF06 when building):
```
Webhook receives lead →
  Write to Leads_Sheet tab →
  Add to Mailchimp sequence →
  Log product interest for research →
  If email = existing customer → tag as 'engaged'
```

---

## WF06 BRAND CONFIG — MANYCHAT PLACEHOLDER
(Already has stub — fill in when activating)

```javascript
// In WF06 Brand Registry → clearstack brand:
manychat: {
  enabled: false,               // ← SET true IN PHASE 2
  access_token: 'YOUR_MANYCHAT_PAGE_TOKEN',
  ig_page_id: 'YOUR_IG_PAGE_ID',
  fb_page_id: 'YOUR_FB_PAGE_ID',
  
  trigger_keywords: {
    product_link: ['TEMPLATE', 'LINK', 'SEND IT', 'YES', 'INTERESTED'],
    lead_magnet: ['FREE', 'FREEBIE', 'CHECKLIST', 'PLANNER'],
    welcome: ['HI', 'HELLO', 'HEY']
  },
  
  flows: {
    comment_to_link: 'FLOW_ID_FROM_MANYCHAT',
    story_reply: 'FLOW_ID_FROM_MANYCHAT',
    welcome_new_follower: 'FLOW_ID_FROM_MANYCHAT',
    lead_magnet_delivery: 'FLOW_ID_FROM_MANYCHAT'
  },
  
  lead_magnet_url: 'https://clearstackstudio.com/free',
  
  // Analytics
  monthly_contact_limit: 1000,  // Free tier
  plan: 'free'                  // 'free' | 'pro'
}
```

---

## WF04 INTEGRATION (Update Social Agent When Ready)

When ManyChat is active, WF04 should auto-add trigger words to captions:

```javascript
// In WF04 Social Agent — caption builder:
// If manychat.enabled === true, append trigger CTA to captions

if (brandConfig.manychat?.enabled) {
  const keyword = brandConfig.manychat.trigger_keywords.product_link[0];
  igCaption += `\n\nComment ${keyword} below and I'll DM you the link 👇`;
  fbCaption += `\n\nComment ${keyword} and I'll send you the direct link!`;
}
```

---

## CONTENT CALENDAR — MANYCHAT-OPTIMIZED POST TYPES

Once ManyChat is live, create these post types weekly:

| Post Type | Caption Hook | ManyChat Trigger | Goal |
|-----------|-------------|-----------------|------|
| Product reveal | "Comment LINK for the direct link 👇" | LINK | Sales |
| Freebie offer | "Comment FREE for my [resource] 📥" | FREE | Leads |
| Tips carousel | "Save this + comment YES for the template" | YES | Engagement |
| Before/after | "Comment TEMPLATE to get this 👇" | TEMPLATE | Sales |
| Q&A | "Reply to this story with your question" | Story reply | Community |

Minimum 2 ManyChat-trigger posts per week once active.

---

## HALAL COMPLIANCE NOTES

✅ ManyChat automation is permissible:
- It's communication automation, not deception
- Users initiate the interaction (comment/DM first)
- No false claims or misleading offers
- Email capture is transparent ("I'll add you to my list")

✅ Best practices:
- Always mention automation in bio: "DMs may be automated"
- Never claim to be human in DMs
- Honor unsubscribe requests immediately
- Don't spam — max 1 follow-up per flow

---

## ESTIMATED IMPACT (Conservative)

```
At 500 followers + 5 ManyChat-trigger posts/week:
  Average post engagement: 3% = 15 interactions
  Comment-to-DM conversion: 80% = 12 DMs sent
  DM-to-email conversion: 40% = 5 new leads/post
  5 posts × 5 leads = 25 new leads/week
  
  Email sequence conversion rate: 5-10%
  25 leads/week × 8% = 2 sales/week from email alone
  
  At $12 average order value:
  2 sales × $12 × 4 weeks = $96/month from ManyChat alone
  
  At 2,000 followers (Month 4-5):
  ~8-12 sales/month from ManyChat = $96-$144/month
  Cost: $0 (free tier) or $15/month (Pro)
  ROI: 6-10x
```
