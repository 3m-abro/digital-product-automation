# Credentials audit — in-JSON vs n8n credential store

Per **SECURITY_CREDENTIALS_FIX.md**: credentials should live in n8n’s credential store, not in workflow JSON. This audit lists where credentials are used and whether they are still in JSON or in n8n.

---

## How to read this table

- **In JSON:** Value or placeholder (e.g. `YOUR_ETSY_API_KEY`) is in the exported workflow file — **insecure** if real keys; must be moved to n8n.
- **In n8n:** Node uses a credential reference only; no secret in the JSON — **preferred**.

---

## By workflow / feature

| Workflow / feature | Credential | Where used | Status (in JSON vs n8n) |
|-------------------|------------|------------|--------------------------|
| **WF03** Publishing | Gumroad access token | Publish to Gumroad node | In JSON (YOUR_GUMROAD_ACCESS_TOKEN) |
| **WF03** | Etsy API key, OAuth token, Shop ID | Publish to Etsy node | In JSON (YOUR_ETSY_*, YOUR_SHOP_ID) |
| **WF03** | Payhip API key | Publish to Payhip node | In JSON (YOUR_PAYHIP_API_KEY) |
| **All** | Google Sheet ID | Various Sheets nodes | In JSON (YOUR_GOOGLE_SHEET_ID_HERE) — ID is not secret but should be env/config |
| **WF06** | Brand/store credentials | workflows/06_brand_config.json or webhook | May be in JSON; see SECURITY_CREDENTIALS_FIX |
| **WF09A** | WordPress Basic Auth | HTTP nodes to WP | Documented → n8n (WordPress — ClearStack Studio) |
| **WF09B** | ElevenLabs, D-ID | Video engine | Documented → n8n (ElevenLabs API, D-ID API) |
| **WF11B** | Brevo API | Email automation | Documented → n8n (Brevo API) |
| **WF04** | Ayrshare / Meta / TikTok / Pinterest / YouTube | Social posting | Documented → n8n (Ayrshare API + OAuth where applicable) |
| **WF10B** | Telegram bot | Alerts | Documented → n8n (Telegram Bot — Abro Digital) |
| **Sheets** | Google Sheets OAuth2 | All Sheets nodes | Documented → n8n (Google Sheets — Abro Digital) |

---

## Summary

- **Still in JSON (launch risk):** WF03 (Gumroad, Etsy, Payhip) and any workflow still using `YOUR_*` placeholders or real keys in the file.
- **Target state:** Every API key, token, and secret in **n8n Credentials**; workflow JSON contains only credential **references**. See SECURITY_CREDENTIALS_FIX.md for step-by-step migration.

**Next:** Migrate remaining credentials to n8n (priority: WF03 store credentials, then WordPress, Brevo, Etsy OAuth, social, Telegram). After each migration, re-export workflow and confirm no secrets appear in the JSON.

---

**Migration status (done line):** As of 2025-03-16: placeholders in JSON for WF03 (Gumroad, Etsy, Payhip); target = all real secrets in n8n, JSONs only references. Re-export workflows after moving secrets to n8n and update this line when complete.
