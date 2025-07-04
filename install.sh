#!/bin/bash

echo "🔍 Updating package list..."
sudo apt update

echo "📦 Installing dependencies: ruby, ruby-dev, build-essential, libcurl4-openssl-dev, libxml2, libxml2-dev, libxslt1-dev, zlib1g-dev"
sudo apt install -y ruby ruby-dev build-essential libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev zlib1g-dev

echo "🔧 Installing Bundler..."
sudo gem install bundler

echo "🛠 Installing WPScan..."
sudo gem install wpscan

echo "✅ Done! You can now run ./holScan.sh"


