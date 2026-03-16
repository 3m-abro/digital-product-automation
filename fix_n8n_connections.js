#!/usr/bin/env node
/**
 * fix_n8n_connections — Post-clone/import fix for n8n workflow JSONs
 *
 * Intent: After cloning this repo or importing workflows into a new n8n instance,
 * webhook base URLs and credential references may point to the wrong host.
 * Run this (or apply the same logic) to replace YOUR_N8N_BASE_URL or
 * webhook URLs in workflow JSONs with the actual n8n base URL for this environment.
 *
 * Usage (example):
 *   N8N_BASE=https://n8n.example.com node fix_n8n_connections.js
 *
 * Optionally: scan repo root for *.json, replace placeholder URL in
 * webhook/node URLs with process.env.N8N_BASE. Do not replace credential
 * values — use n8n credential store (see SECURITY_CREDENTIALS_FIX.md).
 */

const N8N_BASE = process.env.N8N_BASE || '';
if (!N8N_BASE) {
  console.warn('No N8N_BASE set. Set e.g. N8N_BASE=https://your-n8n.example.com and re-run to apply URL fixes.');
  process.exit(0);
}

console.log('N8N_BASE:', N8N_BASE);
console.log('Intent: replace webhook/base URL placeholders in workflow JSONs. Implement file scan/replace here if needed.');
