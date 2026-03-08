#!/bin/bash
# Mullvad VPN Waybar Indicator
# Dependencies: mullvad CLI
# Place in ~/.config/waybar/scripts/mullvad-status.sh and chmod +x
get_status() {
    if ! command -v mullvad &>/dev/null; then
        echo '{"text": "", "tooltip": "mullvad not found", "class": "error"}'
        return
    fi
    STATUS=$(mullvad status 2>/dev/null)
    if echo "$STATUS" | grep -q "Connected"; then
        # Extract server info
        SERVER=$(echo "$STATUS" | grep -oP '(?<=Connected to )[^\n]+' | head -1)
        COUNTRY=$(echo "$SERVER" | grep -oP '^[^,]+')
        IP=$(mullvad status --json 2>/dev/null | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('relay',{}).get('location',{}).get('country',''))" 2>/dev/null || echo "")
        TOOLTIP=" Connected$SERVER"
        [ -n "$IP" ] && TOOLTIP="$TOOLTIP\n$IP"
        echo "{\"text\": \" $COUNTRY\", \"tooltip\": \"$TOOLTIP\", \"class\": \"connected\"}"
    elif echo "$STATUS" | grep -q "Connecting"; then
        echo '{"text": "󱥸 ", "tooltip": "Connecting…", "class": "connecting"}'
    elif echo "$STATUS" | grep -q "Disconnecting"; then
        echo '{"text": "󱥸 ", "tooltip": "Disconnecting…", "class": "disconnecting"}'
    else
        echo '{"text": " ", "tooltip": "Disconnected", "class": "disconnected"}'
    fi
}
get_status
