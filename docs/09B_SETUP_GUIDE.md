# 🎬 WORKFLOW 09B — VIDEO ENGINE SETUP GUIDE
## FFmpeg + Piper TTS + ElevenLabs + D-ID Avatar

---

## Which file?

- **Canonical workflow:** `workflows/09B_video_engine.json` — use this for import into n8n and for the pipeline described in this guide (FFmpeg, Piper, ElevenLabs, D-ID, Video_Content_Log).
- **Other file:** `workflows/09B_video_renderer.json` — alternate or earlier export; same domain (video render) but this guide and the content engine (09A → 09B) refer to the **video engine** JSON. If you have both, prefer `workflows/09B_video_engine.json` unless you have a reason to use the renderer variant (e.g. backup or a different node set).

---

## WHAT THIS WORKFLOW PRODUCES PER PRODUCT

```
1 product → 09B triggers → generates:

📹 TEXT-OVERLAY VIDEOS (fully automated, no face)
  ├── 15s Hook Video  — TikTok / Reels / Shorts
  │     Strong hook text → 3 value points → CTA
  │
  ├── 30s Story Video — TikTok / Reels
  │     Problem agitation → product reveal → CTA
  │
  ├── 30s Tips Countdown — TikTok / Reels / Shorts
  │     "5 productivity tips" format + voiceover
  │     Piper TTS free voiceover OR ElevenLabs premium
  │
  └── 15s Product Reveal — All platforms
        Cover image zoom-pan + minimal text overlay

🤖 AI AVATAR VIDEO (optional, when D-ID enabled)
  └── 60s UGC talking head
        ElevenLabs voice + D-ID lip-sync
        Brand lower third + AI disclosure overlay

TOTAL: 4-5 videos per product
YOUR TIME: 0 minutes (fully automated)
```

---

## STEP 1 — INSTALL FFMPEG ON YOUR VPS

```bash
# FFmpeg (video assembly — required)
sudo apt-get update
sudo apt-get install -y ffmpeg

# Fonts for text overlays (required)
sudo apt-get install -y fonts-open-sans fonts-dejavu-core
sudo fc-cache -fv

# Verify
ffmpeg -version
fc-list | grep -i open
```

---

## STEP 2 — INSTALL PIPER TTS (Free Voiceover)

Piper runs locally on CPU. ~2 seconds to generate 10 seconds of audio. No API key needed.

```bash
# Download Piper binary
PIPER_VERSION="2023.11.14-2"
wget "https://github.com/rhasspy/piper/releases/download/${PIPER_VERSION}/piper_linux_x86_64.tar.gz" \
  -O /tmp/piper.tar.gz
tar -xzf /tmp/piper.tar.gz -C /tmp/
sudo cp /tmp/piper/piper /usr/local/bin/
sudo chmod +x /usr/local/bin/piper
sudo cp /tmp/piper/espeak-ng-data -r /usr/lib/ 2>/dev/null

# Download voice model (professional, clear English)
sudo mkdir -p /opt/piper-voices
sudo wget -q \
  "https://huggingface.co/rhasspy/piper-voices/resolve/main/en/en_US/libritts_r/medium/en_US-libritts_r-medium.onnx" \
  -O /opt/piper-voices/voice.onnx
sudo wget -q \
  "https://huggingface.co/rhasspy/piper-voices/resolve/main/en/en_US/libritts_r/medium/en_US-libritts_r-medium.onnx.json" \
  -O /opt/piper-voices/voice.onnx.json

# Test it
echo "Hello, this is a test of Piper text to speech." | \
  piper --model /opt/piper-voices/voice.onnx --output_file /tmp/test.wav
ffplay /tmp/test.wav  # or transfer and play locally
echo "Piper working: $(ls -lh /tmp/test.wav)"
```

### Alternative Piper voices (all CPU-friendly):
| Voice | Style | Download name |
|-------|-------|---------------|
| en_US-libritts_r-medium | Natural, professional | Default recommended |
| en_US-amy-medium | Warm, friendly | en_US-amy-medium |
| en_US-kusal-medium | Male, clear | en_US-kusal-medium |
| en_GB-alba-medium | British female | en_GB-alba-medium |

---

## STEP 3 — ELEVENLABS API (Premium Fallback)

Used for: Tips countdown voiceover (Piper fallback) + avatar voiceover (always).

1. Sign up at elevenlabs.io
2. Free tier: 10,000 chars/month (~8 short videos)
3. Starter: $5/month = 1,000,000 chars (~800+ videos)
4. Profile → API Keys → Copy key
5. Replace `YOUR_ELEVENLABS_API_KEY` in workflow

### Voice selection guide:
| Voice ID | Name | Best For |
|----------|------|----------|
| 21m00Tcm4TlvDq8ikWAM | Rachel | Professional, calm — default |
| AZnzlk1XvdvUeBnXmlld | Domi | Energetic, younger |
| EXAVITQu4vr4xnSDxMaL | Bella | Warm, conversational |
| VR6AewLTigWG4xSOukaG | Arnold | Male, authoritative |

---

## STEP 4 — D-ID AVATAR (Optional)

Only needed when `avatar_enabled: true`. Start without it.

1. Sign up at d-id.com
2. Starter: $5.90/month = 10 minutes of video
3. API → Copy API key
4. Base64 encode it: `echo -n "YOUR_KEY:" | base64`
5. Replace `YOUR_DID_API_KEY_BASE64` in workflow

### Avatar image setup:
- Upload a professional headshot or AI-generated avatar image to a public URL
- Recommended: Use a professional AI avatar from thispersondoesnotexist.com or midjourney
- Image requirements: Minimum 512×512px, clear face, neutral background
- HALAL: Ensure avatar has modest appearance
- Replace `YOUR_AVATAR_IMAGE_URL` in the D-ID node

### AI disclosure (mandatory):
The workflow already adds "AI-generated content" as a lower-third overlay via FFmpeg. This is required by Meta, TikTok, and YouTube policies for AI-generated content. Do not remove it.

---

## STEP 5 — SETUP RCLONE FOR GOOGLE DRIVE UPLOADS

```bash
# Install rclone
curl https://rclone.org/install.sh | sudo bash

# Configure Google Drive
rclone config
# Follow prompts:
# n = new remote
# name: gdrive
# type: 15 (drive)
# client_id: blank
# client_secret: blank
# scope: 1 (full access)
# Follow OAuth flow

# Test
rclone ls gdrive: | head -5

# Uncomment the rclone line in the workflow node
```

---

## STEP 6 — PLATFORM POSTING SETUP

### TikTok Content Posting API
⚠️ Requires business account + approval process

1. Create TikTok Business account
2. Apply at developers.tiktok.com → Content Posting API
3. Fill application form (takes 1-2 weeks for approval)
4. After approval: generate access token
5. Replace `YOUR_CLEARSTACK_TIKTOK_TOKEN`

**While waiting for TikTok API approval:** Download videos from Google Drive and post manually. The scripts are all generated — just copy-paste the captions.

### Instagram Reels
- Uses same Meta token as existing WF04
- Videos must be at a public URL — upload to Drive first, use public link
- Or use Cloudflare R2 (free 10GB) for hosting video files

### YouTube Shorts
- Uses OAuth2 token (already in WF06 brand config)
- YouTube API upload is 2-step: init → binary upload
- Full implementation requires n8n HTTP node to follow the resumable upload URL from init response

---

## STEP 7 — WIRE 09B INTO WORKFLOW 03

Same as 09A — add a second HTTP trigger at end of WF03:

```json
{
  "product_id": "{{ $json.product_id }}",
  "title": "{{ $json.title }}",
  "description": "{{ $json.description_long }}",
  "category": "{{ $json.category }}",
  "brand_id": "clearstack",
  "keywords": "{{ $json.tags }}",
  "price": "{{ $json.price }}",
  "etsy_url": "{{ $json.etsy_url }}",
  "gumroad_url": "{{ $json.gumroad_url }}",
  "cover_image": "{{ $json.cover_image_url }}",
  "avatar_enabled": false
}
```

Set `avatar_enabled: true` once D-ID subscription is active.

---

## NEW GOOGLE SHEETS TAB: `Video_Content_Log`

| Column | Auto/Manual |
|--------|-------------|
| Date | Auto |
| Product_ID | Auto |
| Product_Title | Auto |
| Brand | Auto |
| Videos_Generated | Auto |
| Avatar_Generated | Auto |
| TikTok_Posted | Auto |
| Reels_Posted | Auto |
| YT_Shorts_Posted | Auto |
| Music_Mood | Auto |
| Work_Dir | Auto |
| Status | Auto |

---

## VIDEO STRATEGY FOR CLEARSTACK

### What performs best for template/productivity products:

**#1 — Tips Countdown (30s)**
"5 things keeping you disorganized" → tip 5 is secretly solved by your template
Gets saves (highest signal to algorithm), educational = trusted

**#2 — Product Reveal (15s)**
Cover image slowly zooms in while text appears
"The template that runs my entire business →" + CTA
Pure curiosity + desire. High CTR to store.

**#3 — Hook Video (15s)**
First 3 words MUST stop the scroll
Best performing hooks for productivity niche:
- "Stop using spreadsheets."
- "Your system is broken."
- "I wasted 3 years."
- "This changed everything."

**#4 — Avatar UGC (60s)**
"I'm a freelancer and I used to spend 4 hours a week on client tracking..."
Converts best on TikTok and Reels
Enable once text-overlay videos are working

### Posting schedule:
```
Monday:    Tips Countdown → TikTok + Reels + Shorts
Tuesday:   Hook 15s → TikTok + Reels
Wednesday: Product Reveal → all platforms
Thursday:  30s Story → TikTok + Reels
Friday:    Avatar UGC (if enabled) → TikTok + Reels

Each video = 3 platform posts = 15 posts/week per product
With 3 products: 45 video posts/week, fully automated
```

---

## TYPICAL PROCESSING TIMES ON CPU VPS

| Task | Time |
|------|------|
| mistral script writing | 3-6 min |
| Environment setup + cover download | 30s |
| FFmpeg render 15s video | 20-40s |
| FFmpeg render 30s video | 40-80s |
| Piper TTS 30s of audio | 5-8s |
| ElevenLabs API call | 3-5s |
| D-ID avatar 60s video | 90-120s |
| Drive upload | 10-30s |
| **Total per product** | **~15-25 min** |

All runs in background — zero involvement from you.

---

## TROUBLESHOOTING

| Issue | Fix |
|-------|-----|
| FFmpeg: `drawtext` font not found | Run `fc-list` to find font path, update node |
| Piper: `espeak-ng` missing | `apt-get install espeak-ng` |
| Videos render black | Add `--enable-local-file-access` to FFmpeg, check input file path |
| D-ID: 402 error | Exceeded plan minutes — upgrade or wait for reset |
| TikTok: 401 | Token expired — refresh in TikTok Developer Portal |
| IG Reels: video rejected | Must be 9:16 ratio, max 90s, H.264 codec — our output is already correct |
| Drive upload fails | Run `rclone config reconnect gdrive:` to refresh OAuth |
