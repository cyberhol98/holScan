#!/bin/bash

# Check if WPScan API token is set in environment variable
if [[ -z "$WPSCAN_API_TOKEN" ]]; then
    echo "❌ Error: WPSCAN_API_TOKEN environment variable is not set."
    echo "👉 Please export your WPScan API token before running the script:"
    echo "   export WPSCAN_API_TOKEN=your-api-token-here"
    exit 1
fi

API_TOKEN="$WPSCAN_API_TOKEN"

# Function to scan a single target
scan_target() {
    target=$1
    output_format=$2

    # Clean filename for output
    safe_target=$(echo "$target" | sed 's|https\?://||g' | sed 's|/|_|g')
    output_file="${safe_target}_scan_result.$output_format"

    echo "🔍 Scanning target: $target"

    # Perform the scan with token and format
    case "$output_format" in
        txt)
            wpscan --url "$target" --api-token "$API_TOKEN" --scope passive --ignore-main-redirect --enumerate vp --random-user-agent --output "$output_file"
            ;;
        html)
            wpscan --url "$target" --api-token "$API_TOKEN" --scope passive --ignore-main-redirect --enumerate vp --random-user-agent --format html --output "$output_file"
            ;;
        json)
            wpscan --url "$target" --api-token "$API_TOKEN" --scope passive --ignore-main-redirect --enumerate vp --random-user-agent --format json --output "$output_file"
            ;;
        *)
            echo "⚠️ Invalid format. Defaulting to text."
            wpscan --url "$target" --api-token "$API_TOKEN" --scope passive --ignore-main-redirect --enumerate vp --random-user-agent --output "$output_file"
            ;;
    esac

    echo "✅ Scan completed. Results saved to: $output_file"
}

# Function to scan multiple targets
scan_multiple_targets() {
    targets=$1
    output_format=$2

    for target in $targets; do
        scan_target "$target" "$output_format"
    done
}

# Main menu
echo "Do you want to load the target(s) manually or from a file?"
echo "1. Manually"
echo "2. From a file"
read -p "Enter choice (1 or 2): " choice

if [ "$choice" == "1" ]; then
    read -p "Do you want to scan a single target or multiple targets? (1 for single, 2 for multiple): " target_choice
    read -p "Enter preferred output format (txt, html, json): " output_format

    if [ "$target_choice" == "1" ]; then
        read -p "Enter the target URL: " target
        scan_target "$target" "$output_format"
    elif [ "$target_choice" == "2" ]; then
        read -p "Enter the targets separated by space: " targets
        scan_multiple_targets "$targets" "$output_format"
    else
        echo "❌ Invalid option."
        exit 1
    fi

elif [ "$choice" == "2" ]; then
    read -p "Enter the file name containing the targets: " file

    if [ ! -f "$file" ]; then
        echo "❌ File does not exist."
        exit 1
    fi

    read -p "Do you want to scan a single target or multiple targets from the file? (1 for single, 2 for multiple): " target_choice
    read -p "Enter preferred output format (txt, html, json): " output_format

    if [ "$target_choice" == "1" ]; then
        target=$(head -n 1 "$file")
        scan_target "$target" "$output_format"
    elif [ "$target_choice" == "2" ]; then
        targets=$(cat "$file")
        scan_multiple_targets "$targets" "$output_format"
    else
        echo "❌ Invalid option."
        exit 1
    fi
else
    echo "❌ Invalid choice."
    exit 1
fi

