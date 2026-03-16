# Google Sheets master list — tabs and required columns

Single source of truth for all tabs and required columns. Sourced from SETUP_GUIDE.md, ARCHITECTURE_V2.md, 02B_SETUP_ADDENDUM.md, 08_KDP_SETUP_GUIDE.md, 09A/09B_SETUP_GUIDE.md and 09_CONTENT_ENGINE_GUIDE.md.

---

## Tab: `Research_Opportunities`

| Column | Type | Notes |
|--------|------|-------|
| Week | Text | Auto-filled |
| Rank | Number | 1-8 |
| Product_Name | Text | Auto-filled |
| Category | Text | Auto-filled |
| Trend_Score | Number | 0-100 |
| Recreatability_Score | Number | 0-10 |
| Price_Min, Price_Max | Number | USD |
| Creation_Tool | Text | Auto-filled |
| Creation_Hours | Number | Auto-filled |
| Target_Keyword | Text | Auto-filled |
| Description | Text | Auto-filled |
| Creation_Steps | Text | Pipe-separated, auto-filled |
| Market_Insights | Text | Auto-filled |
| **APPROVED** | Text | **You set: YES or NO** |
| Notes | Text | Your notes |
| Date_Added | DateTime | Auto-filled |
| Status | Text | Auto-filled |
| **Brand_ID** | Text | Auto-set (e.g. clearstack) — ARCHITECTURE_V2 |
| **Halal_Status** | Text | Auto-set after screening — ARCHITECTURE_V2 |
| **Genre_Tag** | Text | Auto-detected genre — ARCHITECTURE_V2 |

---

## Tab: `Products_Ready`

| Column | Notes |
|--------|-------|
| Product_ID | Auto-generated slug |
| Title | SEO listing title |
| Category | Product category |
| Price | USD |
| Short_Description | 2-3 sentences |
| Tags | Comma-separated |
| Image_Prompt_Mockup, Image_Prompt_Thumbnail, Image_Prompt_Social | For Leonardo/Canva |
| IG_Caption, FB_Post, TikTok_Script, Pinterest_Description, YouTube_Title | Copy for social |
| Creation_Guide | JSON (creation steps) |
| Status | Auto-updated (e.g. Ready to Publish) |
| Created_At | DateTime |
| Published_Etsy, Published_Gumroad, Published_Payhip, Published_Social | YES/NO/FAILED |
| Gumroad_URL, Etsy_URL, Payhip_URL | Auto-filled after publish |
| **Brand_ID** | ARCHITECTURE_V2 |
| **Halal_Approved** | ARCHITECTURE_V2 |
| **Halal_Verdict_Source** | ARCHITECTURE_V2 |

---

## Tab: `Published_Products`

Permanent record of published products with sales tracking. Structure as needed for reporting.

---

## Tab: `Social_Posts_Log`

All social posting results with post IDs. Columns per platform as needed.

---

## Tab: `Weekly_Dashboard`

High-level weekly activity log.

---

## Tab: `Error_Log`

(Optional) Workflow errors. Columns: e.g. Timestamp, Workflow, Message, Context.

---

## Tab: `Brand_Config_Log` (ARCHITECTURE_V2)

| Column | Notes |
|--------|-------|
| Timestamp | |
| Brand_Resolved | |
| Genre_Requested | |
| Enabled_Stores | |
| Enabled_Social | |
| Config_Issues | |
| Ready | |

---

## Tab: `Halal_Review_Log` (ARCHITECTURE_V2)

| Column | Notes |
|--------|-------|
| Timestamp | |
| Product_Name | |
| Verdict | |
| Verdict_Source | |
| Confidence | |
| Approved | |
| Flags | |
| Needs_Human_Review | |
| Action_Required | |
| Reviewer_Note | |
| Edits_Suggested | |

---

## Tab: `Halal_Human_Review_Queue` (ARCHITECTURE_V2)

**You act on this tab.**

| Column | Notes |
|--------|-------|
| Timestamp | |
| Product_Name | |
| Flags | |
| Issues_Detail | |
| Suggested_Edits | |
| Original_Content_Preview | |
| Cleaned_Content_Preview | |
| **YOUR_DECISION** | Set to APPROVED or REJECTED |
| Notes | |
| Reviewer_Note | |

---

## Tab: `KDP_Queue` (08_KDP_SETUP_GUIDE)

| Column | Notes |
|--------|-------|
| Product_ID | Auto or manual |
| Product_Name | Book concept |
| Category | Determines book type |
| Target_Keyword | Main KDP keyword |
| Description | Product description |
| KDP_Type | ebook / low_content / coloring / activity / puzzle |
| Status | Set to `Approved_For_KDP` to trigger 08A |
| KDP_Files_Ready | Auto-set by workflow |
| Brand_ID | e.g. clearstack |

---

## Tab: `KDP_Upload_Queue` (08_KDP_SETUP_GUIDE)

| Column | Notes |
|--------|-------|
| Product_ID, Book_Type | |
| Title, Subtitle | Pre-filled |
| Keywords (7), Categories | Pre-filled |
| Price_USD, Page_Count | |
| Interior_PDF, EPUB_File | File paths |
| Cover_Image_URL | URL to download |
| PDF_Ready, Cover_Ready | Auto |
| Ready_For_Upload | Auto (TRUE when all ready) |
| **KDP_Upload_Status** | You set: PENDING → UPLOADED |
| D2D_Upload_Status, PublishDrive_Status | Auto |
| ASIN, KDP_Live_URL | You fill after live |

---

## Tab: `KDP_Manual_Upload_Guide` (08_KDP_SETUP_GUIDE)

Auto-populated by 08B. One row per book; copy-paste cheat sheet for KDP dashboard.

---

## Tab: `Video_Content_Log` (09B_SETUP_GUIDE)

| Column | Notes |
|--------|-------|
| Date | Auto |
| Product_ID | Auto |
| Product_Title | Auto |
| Brand | Auto |
| Videos_Generated | Auto |
| Avatar_Generated | Auto |
| TikTok_Posted, Reels_Posted, YT_Shorts_Posted | Auto |
| Music_Mood | Auto |
| Work_Dir | Auto |
| Status | Auto |

---

## Summary

- **Core (SETUP_GUIDE + ARCHITECTURE_V2):** Research_Opportunities, Products_Ready, Published_Products, Social_Posts_Log, Weekly_Dashboard, Error_Log, Brand_Config_Log, Halal_Review_Log, Halal_Human_Review_Queue.
- **KDP (08):** KDP_Queue, KDP_Upload_Queue, KDP_Manual_Upload_Guide.
- **Content (09B):** Video_Content_Log.

Create one Google Sheet with these tabs; share with the service account used by n8n.
