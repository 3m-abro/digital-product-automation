#!/bin/bash
# ============================================================
# DIGITAL EMPIRE — VPS SETUP SCRIPT
# Run this on your Ubuntu/Debian Linux VPS as root or sudo
# ============================================================

echo "🚀 Setting up Digital Product Empire dependencies..."

# Update system
apt-get update -y
apt-get upgrade -y

# Install core tools
apt-get install -y \
  curl \
  wget \
  zip \
  unzip \
  git \
  python3 \
  python3-pip \
  nodejs \
  npm \
  imagemagick \
  ghostscript

echo "✅ Core tools installed"

# ============================================================
# Install wkhtmltopdf (HTML to PDF converter)
# ============================================================
echo "📄 Installing wkhtmltopdf..."

# For Ubuntu 20.04/22.04
apt-get install -y xvfb libfontconfig wkhtmltopdf

# Test wkhtmltopdf
wkhtmltopdf --version && echo "✅ wkhtmltopdf installed" || echo "❌ wkhtmltopdf failed"

# For headless servers, create xvfb wrapper
cat > /usr/local/bin/wkhtmltopdf-headless << 'EOF'
#!/bin/bash
xvfb-run -a --server-args="-screen 0, 1024x768x24" /usr/bin/wkhtmltopdf "$@"
EOF
chmod +x /usr/local/bin/wkhtmltopdf-headless

echo "✅ wkhtmltopdf headless wrapper created at /usr/local/bin/wkhtmltopdf-headless"
echo "   Use this path in n8n Execute Command nodes instead of wkhtmltopdf"

# ============================================================
# Install Ollama
# ============================================================
echo "🤖 Installing Ollama..."
curl -fsSL https://ollama.com/install.sh | sh

# Start Ollama service
systemctl enable ollama
systemctl start ollama

# Wait for Ollama to start
sleep 5

# Pull required models
echo "📥 Pulling AI models (this will take a while)..."
ollama pull llama3
ollama pull mistral
ollama pull phi3

echo "✅ Ollama installed with llama3, mistral, phi3"

# Test Ollama
curl -s http://localhost:11434/api/tags | python3 -c "import sys,json; data=json.load(sys.stdin); print('✅ Ollama running. Models:', [m['name'] for m in data.get('models',[])])"

# ============================================================
# Create working directories
# ============================================================
mkdir -p /tmp/digital-products
mkdir -p /tmp/product-packages
mkdir -p /var/www/products  # Optional: for local file serving

echo "✅ Directories created"

# ============================================================
# Create Ollama systemd service (if not auto-created)
# ============================================================
cat > /etc/systemd/system/ollama.service << 'EOF'
[Unit]
Description=Ollama Service
After=network-online.target

[Service]
ExecStart=/usr/local/bin/ollama serve
User=root
Group=root
Restart=always
RestartSec=3
Environment="OLLAMA_HOST=0.0.0.0:11434"

[Install]
WantedBy=default.target
EOF

systemctl daemon-reload
systemctl enable ollama
systemctl restart ollama

echo ""
echo "============================================================"
echo "✅ SETUP COMPLETE!"
echo "============================================================"
echo ""
echo "📋 NEXT STEPS:"
echo ""
echo "1. Verify Ollama: curl http://localhost:11434/api/tags"
echo "2. Test PDF: echo '<h1>Test</h1>' > /tmp/test.html && wkhtmltopdf /tmp/test.html /tmp/test.pdf && ls -la /tmp/test.pdf"
echo "3. Note your VPS IP: $(curl -s ifconfig.me)"
echo ""
echo "🔑 CREDENTIALS TO ADD IN n8n:"
echo "   - Ollama: http://localhost:11434"
echo "   - Replicate: https://replicate.com/account/api-tokens"
echo "   - HuggingFace: https://huggingface.co/settings/tokens"
echo "   - Freepik: https://www.freepik.com/api"
echo "   - Google Drive/Sheets: OAuth via Google Cloud Console"
echo "   - Notion: https://www.notion.so/my-integrations"
echo ""
echo "⚠️  n8n SETTINGS TO UPDATE:"
echo "   Settings > Execution > Timeout: Set to 3600 seconds (1 hour)"
echo "   This allows long Ollama generation jobs to complete"
echo ""
