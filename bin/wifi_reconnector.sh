#!/bin/bash

# Wi-Fi Reconnector Script
# WSL2からWindowsのWi-Fi接続状態を監視し，切断時に自動で再接続します．

LOG_DIR="$HOME/.local/state"
LOG_FILE="$LOG_DIR/wifi_reconnector.log"
NETSH="/mnt/c/Windows/System32/netsh.exe"
INTERFACE="Wi-Fi"
SSID="SSID-B91901"
CHECK_HOST="8.8.8.8"

# ログディレクトリの作成
mkdir -p "$LOG_DIR"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# インターネット疎通確認 (pingを2回打つ)
if ping -c 2 -W 3 "$CHECK_HOST" > /dev/null 2>&1; then
    # 接続されている場合は何もしない
    exit 0
fi

# 接続が確認できない場合，再接続を試みる
log_message "WARNING: Internet connection lost. Attempting to reconnect Wi-Fi..."

# Wi-Fi切断
$NETSH wlan disconnect interface="$INTERFACE" > /dev/null 2>&1
sleep 3

# Wi-Fi接続
$NETSH wlan connect name="$SSID" interface="$INTERFACE" > /dev/null 2>&1
sleep 5

# 再確認
if ping -c 2 -W 5 "$CHECK_HOST" > /dev/null 2>&1; then
    log_message "SUCCESS: Wi-Fi reconnected successfully."
else
    log_message "ERROR: Failed to reconnect Wi-Fi."
fi
