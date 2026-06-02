#!/bin/bash

# Xalgorix Local Scan Enabler Script
# This script enables scanning of local/internal network addresses (192.168.x.x, 10.x.x.x, etc.)
# by setting XALGORIX_ALLOW_LOCAL_SCAN=true in the configuration file.

CONFIG_FILE="$HOME/.xalgorix.env"

echo "=== Xalgorix Local Scan Enabler ==="
echo ""

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file not found at $CONFIG_FILE"
    echo "Please create the config file first with: xalgorix --setup"
    exit 1
fi

echo "Config file: $CONFIG_FILE"
echo ""

# Create backup
echo "Creating backup of config file..."
cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"
echo "Backup created: ${CONFIG_FILE}.bak"
echo ""

# Check if XALGORIX_ALLOW_LOCAL_SCAN already exists
if grep -q "^XALGORIX_ALLOW_LOCAL_SCAN" "$CONFIG_FILE"; then
    # Update existing line
    echo "Updating existing XALGORIX_ALLOW_LOCAL_SCAN setting..."
    sed -i 's/^XALGORIX_ALLOW_LOCAL_SCAN=.*/XALGORIX_ALLOW_LOCAL_SCAN=true/' "$CONFIG_FILE"
else
    # Add new line
    echo "Adding XALGORIX_ALLOW_LOCAL_SCAN=true to config..."
    echo "" >> "$CONFIG_FILE"
    echo "# Enable scanning of local/internal network addresses" >> "$CONFIG_FILE"
    echo "XALGORIX_ALLOW_LOCAL_SCAN=true" >> "$CONFIG_FILE"
fi

echo ""
echo "Successfully enabled local/internal network scanning!"
echo ""
echo "Configuration updated. You can now scan targets like:"
echo "  - http://192.168.1.100"
echo "  - http://10.0.0.50:8080"
echo "  - http://localhost:3000"
echo ""
echo "To start Xalgorix with these settings:"
echo "  xalgorix --server"
echo ""
echo "To disable local scan later, set XALGORIX_ALLOW_LOCAL_SCAN=false in $CONFIG_FILE"