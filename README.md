# holScan

A bash script that makes it easy to scan WordPress sites for vulnerabilities.  
This tool supports scanning single or multiple targets manually or from a file, and can output results in TXT, HTML, or JSON formats.

---

## Introduction

`holScan` automates WPScan commands to streamline WordPress security scanning.  
It allows users to interactively choose targets and output formats without needing to remember WPScan command options.

---

## Prerequisites

- Bash shell (Linux, macOS, or WSL on Windows)  
- [WPScan](https://wpscan.com/) installed and configured on your system  
- A valid WPScan API token. You can get one by registering at [https://wpscan.com/](https://wpscan.com/)  

### Don't Have WPScan Installed?
If WPScan is not already installed on your system, you can use the included install script:

Then execute this command below:

   ```bash
   chmod +x install.sh
   ./install.sh

This script will:
- Check for Ruby
- Automatically install Ruby using your system’s package manager
- Install WPScan via RubyGems

---

## Installation

1. Clone this repository or download the script files.  
2. Ensure `holScan.sh` is executable:

   ```bash
   chmod +x holScan.sh

3. Export your WPScan API token as an environment variable in your terminal session:

   ```bash
   export WPSCAN_API_TOKEN="your-wpscan-api-token-here"

## Usage

Run the script:
  - ./holScan.sh

You will be prompted to:
   - Choose how to load targets: manually or from a file
   - Choose to scan a single target or multiple targets
   - Enter the preferred output format (txt, html, or json)
   - Enter the target URL(s) or file name accordingly

## Example Interaction
- Do you want to load the target(s) manually or from a file?
- 1. Manually
- 2. From a file
- Enter choice (1 or 2): 1
- Do you want to scan a single target or multiple targets? (1 for single, 2 for multiple): 1
- Enter preferred output format (txt, html, json): txt
- Enter the target URL: https://example.com/
- Results will be saved to example.com_scan_result.txt in the current directory.

## Notes

- Make sure your WPSCAN_API_TOKEN environment variable is set before running the script.

- Only scan websites you have permission to test. Unauthorized scanning is illegal.

- For scanning multiple targets, you can create a text file with one URL per line and load it via the file option.

## Troubleshooting

- If you get timeout or connection errors, verify the target URL is up and accessible.

- If the script says the API token is missing, confirm you exported it correctly.

- Ensure WPScan is installed and in your system’s PATH.




