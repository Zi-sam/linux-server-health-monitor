#!/bin/bash

# ==========================================
# Linux Server Health Monitoring Script
# Author: Ziya Samreen
# Description: Monitors CPU, memory, disk,
# processes, and system uptime.
# ==========================================

# Color codes
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
RED="\033[0;31m"
BLUE="\033[0;34m"
NC="\033[0m"

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

# Header
clear
echo "=========================================="
echo "       LINUX SERVER HEALTH MONITOR"
echo "=========================================="
echo "Hostname       : $(hostname)"
echo "Date & Time   : $(date)"
echo ""

# ------------------------------------------
# CPU USAGE
# ------------------------------------------

echo -e "${BLUE}----- CPU USAGE -----${NC}"

read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

idle1=$((idle + iowait))
total1=$((user + nice + system + idle + iowait + irq + softirq + steal))

sleep 1

read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

idle2=$((idle + iowait))
total2=$((user + nice + system + idle + iowait + irq + softirq + steal))

total_diff=$((total2 - total1))
idle_diff=$((idle2 - idle1))

if [ "$total_diff" -gt 0 ]; then
    cpu_usage=$(( (100 * (total_diff - idle_diff)) / total_diff ))
else
    cpu_usage=0
fi

echo "CPU Usage: ${cpu_usage}%"

if [ "$cpu_usage" -ge "$CPU_THRESHOLD" ]; then
    echo -e "${RED}WARNING: High CPU usage detected!${NC}"
else
    echo -e "${GREEN}CPU status: Normal${NC}"
fi

echo ""

# ------------------------------------------
# MEMORY USAGE
# ------------------------------------------

echo -e "${BLUE}----- MEMORY USAGE -----${NC}"

total_mem=$(free -m | awk '/Mem:/ {print $2}')
used_mem=$(free -m | awk '/Mem:/ {print $3}')
available_mem=$(free -m | awk '/Mem:/ {print $7}')

if [ "$total_mem" -gt 0 ]; then
    mem_usage=$(( (used_mem * 100) / total_mem ))
else
    mem_usage=0
fi

echo "Total Memory     : ${total_mem} MB"
echo "Used Memory     : ${used_mem} MB"
echo "Available Memory : ${available_mem} MB"
echo "Memory Usage    : ${mem_usage}%"

if [ "$mem_usage" -ge "$MEM_THRESHOLD" ]; then
    echo -e "${RED}WARNING: High memory usage detected!${NC}"
else
    echo -e "${GREEN}Memory status: Normal${NC}"
fi

echo ""

# ------------------------------------------
# DISK USAGE
# ------------------------------------------

echo -e "${BLUE}----- DISK USAGE -----${NC}"

df -hP -x tmpfs -x devtmpfs

disk_usage=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo ""
echo "Root Filesystem Usage: ${disk_usage}%"

if [ "$disk_usage" -ge "$DISK_THRESHOLD" ]; then
    echo -e "${RED}WARNING: High disk usage detected!${NC}"
else
    echo -e "${GREEN}Disk status: Normal${NC}"
fi

echo ""

# ------------------------------------------
# RUNNING PROCESSES
# ------------------------------------------

echo -e "${BLUE}----- TOP 10 PROCESSES -----${NC}"

ps -eo pid,ppid,user,%cpu,%mem,comm --sort=-%cpu | head -n 11

echo ""

# ------------------------------------------
# SERVER UPTIME
# ------------------------------------------

echo -e "${BLUE}----- SERVER UPTIME -----${NC}"

uptime -p
uptime

echo ""

# ------------------------------------------
# FINAL SUMMARY
# ------------------------------------------

echo "=========================================="
echo " Monitoring Completed"
echo "=========================================="
