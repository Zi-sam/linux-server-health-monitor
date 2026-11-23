# Linux Server Health Monitoring Script

## Overview

A Bash-based Linux server monitoring tool designed to monitor
essential system health metrics and help administrators
identify resource utilization issues.

## Features

- CPU usage monitoring
- Memory utilization monitoring
- Disk space monitoring
- Top 10 CPU-consuming processes
- Server uptime monitoring
- Configurable usage thresholds
- Warning alerts for high resource utilization

## Technologies Used

- Bash Shell Scripting
- Linux
- Proc filesystem (/proc)
- Linux system monitoring commands
- Git
- GitHub

## Requirements

- Linux operating system
- Bash
- Standard Linux utilities:
  - free
  - df
  - ps
  - awk
  - uptime

## Usage

Clone the repository:

    git clone https://github.com/YOUR_USERNAME/linux-server-health-monitor.git

Navigate to the project directory:

    cd linux-server-health-monitor

Give execution permission:

    chmod +x server_monitor.sh

Run the monitoring script:

    ./server_monitor.sh

## Monitoring Metrics

| Metric | Description |
|--------|-------------|
| CPU | CPU utilization percentage |
| Memory | Total, used, and available memory |
| Disk | Filesystem capacity and utilization |
| Processes | Top CPU-consuming processes |
| Uptime | Server uptime information |

## Alert Thresholds

Default alert thresholds:

- CPU: 80%
- Memory: 80%
- Disk: 80%

Thresholds can be modified inside the script.

## Project Purpose

This project demonstrates practical Linux administration,
Bash scripting, system monitoring, resource analysis,
and automation skills.
