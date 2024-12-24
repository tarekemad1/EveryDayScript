#!/bin/bash

# Log file to store system metrics
LOG_FILE="system_monitor.log"

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=90
DISK_THRESHOLD=80

# Function to log system metrics
log_metrics() {
    echo "----- $(date) -----" >> "$LOG_FILE"
    echo "CPU Usage: $(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')%" >> "$LOG_FILE"
    echo "Memory Usage: $(free -m | awk '/Mem:/ {print $3/$2 * 100.0}')%" >> "$LOG_FILE"
    echo "Disk Usage: $(df -h / | awk '/\// {print $5}' | tail -n 1)" >> "$LOG_FILE"
    echo "Network Activity:" >> "$LOG_FILE"
    ifconfig | grep -E 'RX packets|TX packets' >> "$LOG_FILE"
    echo "" >> "$LOG_FILE"
}

# Function to display system metrics
show_metrics() {
    echo "Current System Metrics:"
    echo "-----------------------"
    echo "CPU Usage: $(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')%"
    echo "Memory Usage: $(free -m | awk '/Mem:/ {print $3/$2 * 100.0}')%"
    echo "Disk Usage: $(df -h / | awk '/\// {print $5}' | tail -n 1)"
    echo "Network Activity:"
    ifconfig | grep -E 'RX packets|TX packets'
}

# Function to check thresholds
check_thresholds() {
    CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    MEM=$(free -m | awk '/Mem:/ {print $3/$2 * 100.0}')
    DISK=$(df -h / | awk '/\// {print $5}' | tail -n 1 | tr -d '%')

    if (( $(echo "$CPU > $CPU_THRESHOLD" | bc -l) )); then
        echo "WARNING: CPU usage is above ${CPU_THRESHOLD}%"
    fi
    if (( $(echo "$MEM > $MEM_THRESHOLD" | bc -l) )); then
        echo "WARNING: Memory usage is above ${MEM_THRESHOLD}%"
    fi
    if (( DISK > DISK_THRESHOLD )); then
        echo "WARNING: Disk usage is above ${DISK_THRESHOLD}%"
    fi
}

# Function to clear the log file
clear_log() {
    > "$LOG_FILE"
    echo "Log file cleared."
}

# Menu for user actions
while true; do
    echo "Choose an action:"
    echo "1. Log Metrics"
    echo "2. Show Current Metrics"
    echo "3. Check Thresholds"
    echo "4. Clear Log File"
    echo "5. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) log_metrics ;;
        2) show_metrics ;;
        3) check_thresholds ;;
        4) clear_log ;;
        5) echo "Exiting..."; break ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done
