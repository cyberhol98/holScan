#!/bin/bash

echo "🔍 Checking for Ruby..."
if ! command -v ruby &> /dev/null; then
    echo "❌ Ruby not found. Installing Ruby..."

    # Detect and install based on available package manager
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install ruby-full -y
    elif command -v dnf &> /dev/null; then
        sudo dnf install ruby -y
    elif command -v yum &> /dev/null; then
        sudo yum install ruby -y
    elif command -v pacman &> /dev/null; then
        sudo pacman -Sy --noconfirm ruby
    elif command -v zypper &> /dev/null; then
        sudo zypper install ruby
    else
        echo "⚠️ Unsupported package manager. Please install Ruby manually."
        exit 1
    fi
else
    echo "✅ Ruby is already installed."
fi

echo "💎 Installing WPScan..."
sudo gem install wpscan

echo "✅ WPScan installation complete!"
echo ""
echo "📢 IMPORTANT: Before running holScan, export your WPScan API token:"
echo 'export WPSCAN_API_TOKEN="your-api-token-here"'
