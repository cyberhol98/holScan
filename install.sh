#!/bin/bash

echo "🔍 Checking if WPScan is installed..."

if ! command -v wpscan &> /dev/null; then
    echo "⚙️ WPScan not found. Installing dependencies and WPScan..."

    sudo apt update
    sudo apt install -y ruby ruby-dev build-essential libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev zlib1g-dev git

    sudo gem install wpscan

    echo "✅ WPScan installed successfully."
else
    echo "✅ WPScan is already installed."
fi

echo ""
echo "📝 Reminder: Don’t forget to export your WPScan API token:"
echo "   export WPSCAN_API_TOKEN=\"your-wpscan-api-token-here\""

