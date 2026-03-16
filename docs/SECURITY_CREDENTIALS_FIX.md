# 🔐 CREDENTIALS SECURITY FIX
## Move all hardcoded credentials to n8n Credential Manager

---

## WHY THIS MATTERS

Every workflow JSON file currently contains real API keys,
tokens, and bank account numbers as plain text.

If your VPS is compromised, all accounts are exposed:
WordPress, Etsy, Gumroad, Brevo, ElevenLabs, Telegram,
Mercury Bank routing numbers, and more.

n8n has an encrypted credential store built in.
This fix takes 2-3 hours and eliminates that risk entirely.

---

## HOW n8n CREDENTIALS WORK

```
BEFORE (insecure — current state):
  HTTP Request node:
  Header: Authorization: Bearer sk-abc123xyz...REAL_KEY

AFTER (secure):
  HTTP Request node:
  Credential: "Brevo API" (reference only — no value shown)
  n8n stores sk-abc123xyz...REAL_KEY encrypted in its database
  Even if you export the workflow JSON: no keys visible
```

---

## STEP BY STEP

### In n8n UI: Settings → Credentials → Add Credential

---

## CREDENTIAL 1: WordPress (Basic Auth)

```
Credential Type: HTTP Header Auth
Name: WordPress — ClearStack Studio
Header Name: Authorization
Header Value: Basic [YOUR_BASE64_AUTH]

How to generate Basic auth:
  echo -n "admin:YOUR_WP_APP_PASSWORD" | base64
  → use the output as the value after "Basic "

Generate WordPress App Password:
  WP Admin → Users → Your Profile → Application Passwords
  Add new: "n8n Automation"
  Copy the password (shown once only)
```

Used in: WF09A, WF10A, WF10B, WF12A, WF12B, WF12C

---

## CREDENTIAL 2: Brevo API

```
Credential Type: HTTP Header Auth  
Name: Brevo API
Header Name: api-key
Header Value: xkeysib-YOUR_BREVO_API_KEY
```

Used in: WF11B

---

## CREDENTIAL 3: Google Sheets (OAuth2)

```
Credential Type: Google Sheets OAuth2 API
Name: Google Sheets — Abro Digital
Follow n8n's Google OAuth setup guide:
  n8n → Credentials → Google Sheets OAuth2
  → Connect Google Account → authorize
```

Used in: All workflows with Google Sheets nodes

---

## CREDENTIAL 4: Etsy API

```
Credential Type: HTTP Header Auth
Name: Etsy API — ClearStack
Header Name: x-api-key
Header Value: YOUR_ETSY_API_KEY

Also add OAuth token:
Credential Type: HTTP Header Auth
Name: Etsy OAuth — ClearStack
Header Name: Authorization
Header Value: Bearer YOUR_ETSY_OAUTH_TOKEN
```

Used in: WF03

---

## CREDENTIAL 5: ElevenLabs

```
Credential Type: HTTP Header Auth
Name: ElevenLabs API
Header Name: xi-api-key
Header Value: YOUR_ELEVENLABS_API_KEY
```

Used in: WF09B

---

## CREDENTIAL 6: D-ID API

```
Credential Type: HTTP Header Auth
Name: D-ID API
Header Name: Authorization
Header Value: Basic YOUR_DID_BASE64_KEY
```

Used in: WF09B (when avatar_enabled: true)

---

## CREDENTIAL 7: Telegram Bot

```
Credential Type: HTTP Header Auth (or use in URL)
Name: Telegram Bot — Abro Digital
Note: Telegram uses token in URL, not header.
Store the token here for reference:
Header Value: YOUR_TELEGRAM_BOT_TOKEN

In workflow nodes, reference as:
https://api.telegram.org/bot{{$credentials.telegramBot.headerValue}}/sendMessage
```

Used in: WF10B, all error notification nodes

---

## CREDENTIAL 8: Ayrshare (Social Media)

```
Credential Type: HTTP Header Auth
Name: Ayrshare API
Header Name: Authorization
Header Value: Bearer YOUR_AYRSHARE_API_KEY
```

Used in: WF04, WF09B

---

## CREDENTIAL 9: Cloudflare R2 (via rclone)

```
This one stays in rclone config (not n8n).
rclone config is stored at: ~/.config/rclone/rclone.conf
Protect this file:
  chmod 600 ~/.config/rclone/rclone.conf
```

---

## CREDENTIAL 10: Mercury Bank

```
DO NOT store bank credentials in n8n at all.
Mercury credentials are only used in:
  - Your browser (manual login)
  - Mercury mobile app
  - API (if you build automated reporting)

If you build a reporting integration later,
use Mercury's read-only API key only.
Never store write-access banking credentials
in any automation system.
```

---

## HOW TO UPDATE NODES AFTER ADDING CREDENTIALS

For each HTTP Request node that currently has
hardcoded Authorization headers:

```
1. Open the node
2. Go to: Authentication tab (or Headers section)
3. Find the hardcoded credential value
4. Change Auth type to "Predefined Credential Type"
   OR keep Header Auth and use expression:
   {{ $credentials.brevoApi.headerValue }}
5. Select your saved credential
6. Remove the hardcoded value
7. Save the workflow
8. Test with a manual run
```

---

## AFTER UPDATING ALL CREDENTIALS

```
VERIFY SECURITY:
□ Export any workflow as JSON
□ Open the JSON file
□ Search for your actual API keys
  If any appear: that node still needs updating
□ No keys should appear in exported JSON

PROTECT YOUR VPS:
□ SSH key only (disable password auth)
  /etc/ssh/sshd_config: PasswordAuthentication no
□ Fail2ban installed: apt-get install fail2ban
□ UFW firewall:
  ufw allow 22    (SSH)
  ufw allow 80    (HTTP)
  ufw allow 443   (HTTPS)
  ufw allow 5678  (n8n — restrict to your IP only)
  ufw enable

BACKUP n8n DATABASE (contains credentials):
□ n8n stores data in: ~/.n8n/database.sqlite
  OR PostgreSQL if configured
□ Include this in your daily backup:
  tar -czf n8n_backup_$(date +%Y%m%d).tar.gz ~/.n8n/
  Upload to Backblaze B2 daily
```

---

## VPS BACKUP SETUP (while you're here)

Install this cron job now — takes 15 minutes:

```bash
# Install rclone (if not done for R2)
curl https://rclone.org/install.sh | sudo bash

# Configure Backblaze B2 (cheapest backup storage: $0.006/GB)
rclone config
# → New remote → Name: b2backup → Type: b2
# → Account ID + Application Key from backblaze.com
# → Create bucket: abro-digital-vps-backups

# Create backup script
cat > /usr/local/bin/backup-vps.sh << 'EOF'
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M)
BACKUP_DIR="/tmp/vps_backup_$DATE"
mkdir -p "$BACKUP_DIR"

# n8n data (workflows + credentials)
tar -czf "$BACKUP_DIR/n8n_$DATE.tar.gz" ~/.n8n/ 2>/dev/null

# WordPress (if on this VPS)
# wp db export "$BACKUP_DIR/wp_db_$DATE.sql" --path=/var/www/html 2>/dev/null

# Nginx Proxy Manager config
tar -czf "$BACKUP_DIR/npm_$DATE.tar.gz" /opt/npm/data/ 2>/dev/null

# Upload to Backblaze B2
rclone copy "$BACKUP_DIR" "b2backup:abro-digital-vps-backups/daily/"

# Keep only last 30 days on B2
rclone delete "b2backup:abro-digital-vps-backups/daily/" \
  --min-age 30d 2>/dev/null

# Clean local temp
rm -rf "$BACKUP_DIR"

echo "Backup complete: $DATE"
EOF

chmod +x /usr/local/bin/backup-vps.sh

# Schedule: daily at 4 AM
(crontab -l 2>/dev/null; echo "0 4 * * * /usr/local/bin/backup-vps.sh >> /var/log/vps-backup.log 2>&1") | crontab -

# /tmp cleanup cron — runs at 1 AM daily
(crontab -l 2>/dev/null; echo "0 1 * * * find /tmp -name 'pdf_gen*' -o -name 'mockups*' -o -name 'carousel*' -o -name 'video_*' | xargs rm -rf 2>/dev/null") | crontab -

echo "Backup and cleanup crons installed"
crontab -l
```

Cost: Backblaze B2 — first 10GB free, $0.006/GB after.
Your backups will be under 1GB. Effectively free.
```

---

## PRIORITY ORDER FOR THIS WORK

```
Do in this order (most critical first):

1. VPS backup cron (30 min) — protects everything
2. /tmp cleanup cron (5 min) — prevents disk fill  
3. WordPress credential → n8n (15 min)
4. Brevo credential → n8n (5 min)
5. Etsy + Gumroad credentials → n8n (15 min)
6. Telegram + ElevenLabs → n8n (10 min)
7. Google Sheets OAuth → n8n (20 min)
8. SSH hardening + UFW firewall (20 min)

Total: ~2 hours
Result: business is protected, backups running,
        disk won't fill, keys are encrypted
```
