#!/bin/bash
########################################
# Script: Day5.sh
# Author: Vihari
# Purpose: Modular Disk Usage Checker with Logging
# Version: 1.0.5
# Date: 2026-04-29
##########################################

set -euo pipefail
CONFIG_MAP="/home/ec2-user/shellter/disk_check.conf"
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
THRESHOLD=10
COUNT=2

TOTAL=$(df -h | tail -n +2 | wc -l)

#checking CONFIG_MAP present or not

if [ -f "$CONFIG_MAP" ]; then
  echo "Config map found"
  source $CONFIG_MAP
else
  echo " ${RED} Error: ${NC} CONFIG_MAP file not found "
  exit 1
fi

log_message() {

    local INFO=$1
    local message=$2
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $INFO: $message" >> "$LOG_FILE"
}

check_usage() {
      local filesystem="$1"
  local mountpoint="$2"
  local usage="$3"

  echo "Current Disk usage on the ${filesystem} mounted on ${mountpoint} is ${usage} "

  if [ "$usage" -gt "$THRESHOLD" ]; then
    echo -e " ${RED} Warning ${NC}: The usage is above the threshold!, take necessry action "
    log_message "WARNING" "$filesystem on $mountpoint usage is $usage%"

  else
    echo -e "${GREEN}Disk is under threshold ✅${NC}"
        log_message "OK" "$filesystem on $mountpoint usage is $usage%"
    fi
}

echo "===Disk usage check started==="
while [ $COUNT -le $((TOTAL+2)) ]; do
   FILESYSTEM=$(df -h | awk "NR==2 {print \$1}")
   MOUNTPOINT=$(df -h | awk "NR==2 {print \$6}")
   USAGE=$(df -h | awk 'NR==2 {print \$5}' | sed 's/%//')

   check_usage "$USAGE" "$MOUNTPOINT" "$FILESYSTEM"
   COUNT=$(COUNT+1)
done
    