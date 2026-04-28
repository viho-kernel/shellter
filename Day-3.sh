#!/bin/bash
########################################
# Script: Day3.sh
# Author: Vihari
# Purpose: Disk Usage Warning with Logging
# Version: 1.0
# Date: 2026-04-28
##########################################

set -euo pipefail

# Variables
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
THRESHOLD=10
COUNT=2
LOG_FILE="/home/ec2-user/disk_check.log"

TOTAL=$(df -h | tail -n +2 | wc -l)

while [ $COUNT -le $((TOTAL+1)) ]; do
  USAGE=$(df -h / | awk "NR==$COUNT {print \$5}" | sed 's/%//' )
  FILESYSTEM=$(df -h / | awk "NR==$COUNT {print \$1}")
  MOUNTPOINT=$(df -h / | awk "NR==$COUNT {print \$6}")
  TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

  echo "Current Disk usage on Filesystem $FILESYSTEM mounted on $MOUNTPOINT : $USAGE%"

  if [ "$USAGE" -gt "$THRESHOLD" ]; then
   echo -e " ⚠️ ${RED}Warning${NC}: Usage is above the threshold"
   echo "[$TIMESTAMP] WARNING: $FILESYSTEM ($MOUNTPOINT) usage $USAGE%" >> "$LOG_FILE"
   else
    echo -e "${GREEN}Disk is under threshold. ✅${NC}"
        echo "[$TIMESTAMP] OK: $FILESYSTEM ($MOUNTPOINT) usage $USAGE%" >> "$LOG_FILE"
    fi

    COUNT=$((COUNT+1))
done