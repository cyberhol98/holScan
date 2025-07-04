#!/bin/bash

echo "🔍 Checking for required dependencies..."

# Check if Ruby is installed
if ! command -v ruby &> /dev/null; then
    echo "❌ Ruby not found. Installing Ruby..."
    sudo apt update && sudo apt install -y ruby-full
else
    echo "✅ Ruby is already installed."
fi

# Check if Bundler is installed
if ! gem list -i bundler > /dev/null 2>&1; then
    echo "📦 Installing Bundler..."
    sudo gem install bundler
else
    echo "✅ Bundler is already installed."
fi

# Check if WPScan is installed
if ! command -v wpscan &> /dev/null; then
    echo "🛠 Installing WPScan..."
    sudo gem install wpscan
else
    echo "✅ WPScan is already installed."
fi

echo "✅ All set! You can now run ./holScan.sh"

