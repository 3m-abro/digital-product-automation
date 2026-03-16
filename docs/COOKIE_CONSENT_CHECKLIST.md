# Cookie consent checklist — WordPress (GDPR)

Use this to add a cookie consent solution on your WordPress site so you address GDPR (and similar) requirements before launch.

---

## 1. Decide approach

- **Plugin:** Use a dedicated cookie-consent / GDPR plugin (e.g. Cookie Yes, Cookiebot, Complianz, WP GDPR Cookie Consent).
- **Manual:** Add a simple banner + script that sets a consent flag and only loads non-essential scripts after consent (more work, full control).

---

## 2. Plugin options (if using a plugin)

| Option | Notes |
|-------|--------|
| **Complianz** | Free tier, wizard, cookie scan, consent banner, block scripts until consent. |
| **Cookie Yes** | Free tier, customizable banner, consent log. |
| **Cookiebot** | Scan + auto categorization; paid for full features. |
| **WP GDPR Cookie Consent** | Free, basic banner + shortcode to show/hide content by consent. |

Install one → run its setup wizard → connect to your Privacy Policy (see LEGAL_PACK.md).

---

## 3. GDPR-relevant items to cover

- [ ] **Banner:** Shown on first visit (or until consent is given); clear “Accept” / “Reject” or “Customize.”
- [ ] **Privacy Policy:** Link from banner and footer to your Privacy Policy (LEGAL_PACK.md → Privacy Policy).
- [ ] **Cookie list:** Document which cookies you set (e.g. session, analytics, marketing) and purpose.
- [ ] **Consent before non-essential:** Don’t load analytics/marketing scripts until user consents (plugin can block scripts by category).
- [ ] **Withdraw consent:** User can change mind (link to cookie settings / preference center).
- [ ] **Log consent:** If required in your jurisdiction, keep a record of consent (some plugins do this).

---

## 4. Where to link legal pack

- Footer: “Privacy Policy”, “Terms of Service”, “Refund Policy”, “Cookie policy” or “Cookie settings.”
- Cookie banner: “Privacy Policy” and “Cookie policy” or “Manage preferences.”

---

## 5. After implementation

- Test: Visit in incognito → see banner → accept/reject → verify behavior.
- Re-test after any new plugin or tracking code (e.g. Umami, Google Analytics).

This checklist is for WordPress; adjust if you switch to Ghost or another CMS. Legal pack: see [LEGAL_PACK.md](../LEGAL_PACK.md) in repo root.
