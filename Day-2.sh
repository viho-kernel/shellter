#!/bin/bash
########################################
# Script: Day2.sh
# Author: Vihari
# Purpose: Disk Usage Warning
# Version: 1.0.2
# Date: 2026-04-27
##########################################

set -euo pipefail # strict error handling

# Variables
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

THRESHOLD=10
COUNT=2

# Count total number of filesystem lines (skip header)
TOTAL=$(df -h | tail -n +2 | wc -l)

# Loop through each filesystem line by line
while [ $COUNT -le $((TOTAL+1)) ]; do
    USAGE=$(df -h | awk "NR==$COUNT {print \$5}" | sed 's/%//')
    FILESYSTEM=$(df -h | awk "NR==$COUNT {print \$1}")
    MOUNTPOINT=$(df -h | awk "NR==$COUNT {print \$6}")

    echo "Current Disk usage on Filesystem $FILESYSTEM mounted on $MOUNTPOINT : $USAGE%"

    if [ "$USAGE" -gt "$THRESHOLD" ]; then
        echo -e "⚠️ ${RED}Warning${NC}: Usage is above the threshold"
    else
        echo -e "${GREEN}Disk is under threshold. ✅${NC}"
    fi

    COUNT=$((COUNT+1))   # increment for next filesystem
done
