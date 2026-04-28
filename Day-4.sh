#!/bin/bash
########################################
# Script: Day4.sh
# Author: Vihari
# Purpose: Modular Disk Usage Checker with Logging
# Version: 1.0.4
# Date: 2026-04-28
##########################################

set -euo pipefail

#Varibales

THRESHOLD=10
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

LOG_DIR="/home/ec2-user/log/"
LOG_FILE="${LOG_DIR}/disk_health.log"

log_message() {
    local level="$1"
    local message="$2"
    local timestamp
    timestamp=$(date + "+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $level $message " >> $LOG_FILE
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

#-- Main workflow --

echo "=======Disk check started ====="

TOTAL=$(df -h | tail -n +2 | wc -l)
COUNT=2

while [ $COUNT -le $((TOTAL+1)) ]; do
    USAGE=$(df -h | awk "NR==$COUNT {print \$5}" | sed 's/%//')
    FILESYSTEM=$(df -h | awk "NR==$COUNT {print \$1}")
    MOUNTPOINT=$(df -h | awk "NR==$COUNT {print \$6}")

    check_usage "$FILESYSTEM" "$MOUNTPOINT" "$USAGE"

    COUNT=$((COUNT+1))
done


echo "=== Disk Check Completed ==="