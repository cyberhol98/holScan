#!/bin/bash

set -e

# Print info messages
echo_info() {
  echo -e "\e[1;34m[INFO]\e[0m $1"
}

# Print success messages
echo_success() {
  echo -e "\e[1;32m[SUCCESS]\e[0m $1"
}

echo_info "Updating package list..."
sudo apt update

echo_info "Installing required packages (ruby, build tools, libraries)..."
sudo apt install -y ruby-full build-essential libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev zlib1g-dev git

echo_info "Installing WPScan via gem..."
sudo gem install wpscan

if command -v wpscan &> /dev/null; then
  echo_success "WPScan installed successfully!"
  wpscan --version
else
  echo -e "\e[1;31m[ERROR]\e[0m WPScan installation failed."
  exit 1
fi

read -p "Do you have a WPScan API token to use? (y/n): " use_token
if [[ "$use_token" =~ ^[Yy]$ ]]; then
  read -p "Enter your WPScan API token: " api_token

  # Determine shell config file to write to
  SHELL_CONFIG=""
  if [[ $SHELL == */zsh ]]; then
    SHELL_CONFIG="$HOME/.zshrc"
  else
    SHELL_CONFIG="$HOME/.bashrc"
  fi

  echo_info "Adding API token export to $SHELL_CONFIG ..."
  # Avoid duplicate entries
  if grep -q "export WPSCAN_API_TOKEN=" "$SHELL_CONFIG"; then
    sed -i "/export WPSCAN_API_TOKEN=/d" "$SHELL_CONFIG"
  fi

  echo "export WPSCAN_API_TOKEN=$api_token" >> "$SHELL_CONFIG"
  export WPSCAN_API_TOKEN=$api_token

  echo_success "WPScan API token set for current session and saved in $SHELL_CONFIG"
  echo_info "Please reload your shell or run: source $SHELL_CONFIG"
else
  echo_info "You can manually export your WPScan API token later by running:"
  echo "    export WPSCAN_API_TOKEN=your-api-token-here"
fi

echo_success "Installation complete. You can now run your WPScan wrapper tool."
