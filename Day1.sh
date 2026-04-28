#!/bin/bash
########################################
# Script: Day1.sh
# Author: Vihari
# Purpose: To check the Disk space
# Version: 1.0
# Date: 2026-04-26
##########################################

set -euo pipefail #setup for strict error handling.

#Variables
DATE=$(date +"%m-%d-%Y")

echo $DATE
echo "Disk usage:"

df -h /



