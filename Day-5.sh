#!/bin/bash
########################################
# Script: Day5.sh
# Author: Vihari
# Purpose: Modular Disk Usage Checker with Logging
# Version: 1.0.5
# Date: 2026-04-29
##########################################

set -euo pipefail

THRESHOLD=15
LOG_FILE=/home/ec2-user/disk_check.log

CONFIG_FILE="/home/ec2-user/disk_check.conf"
#checking if file is presnt or not
if [ -f "$CONFIG_FILE" ]; then
   source "$CONFIG_FILE"
else 
   echo "Config file not found: $CONFIG_FILE"
   exit 1
fi

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

log_message() {
    local level="$1"
    local message="$2"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $level: $message" >> "$LOG_FILE"

}

check_usage() {
    local filesystem="$1"
    local mountpoint="$2"
    local usage="$3"

    echo "Current Disk usage on $filesystem mounted on $mountpoint : $usage%"

    if [ "$usage" -gt "$THRESHOLD" ]; then
        echo -e "⚠️ ${RED}Warning${NC}: Usage is above threshold"
        log_message "WARNING" "$filesystem ($mountpoint) usage $usage%"
    else
        echo -e "${GREEN}Disk is under threshold ✅${NC}"
        log_message "OK" "$filesystem ($mountpoint) usage $usage%"
    fi

}

echo "Disk check started"

TOTAL=$(df -h / | tail -n +2 | wc -l)
COUNT=2

while [ $COUNT -le $((TOTAL1+1)) ]; do
  USAGE=$(df -h | awk "NR==$COUNT {print \$5}" | sed 's/%//')
    FILESYSTEM=$(df -h | awk "NR==$COUNT {print \$1}")
    MOUNTPOINT=$(df -h | awk "NR==$COUNT {print \$6}")

    check_usage "$FILESYSTEM" "$MOUNTPOINT" "$USAGE"

    COUNT=$((COUNT+1))
done

echo "=== Disk Check Completed ==="