#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: Rudra Ghosh | Reg No: 24BCG10070
# Course: Open Source Software | OSS NGMC Project
# Description: Reads a log file line by line, counts keyword
#              matches, prints the last 5 matching lines.
# Usage: ./script4_log_analyzer.sh /path/to/logfile [KEYWORD]
# ============================================================

# --- Command-line arguments ---
LOGFILE="$1"             # Wrap in quotes to handle paths with spaces
KEYWORD="${2:-error}"    # Default keyword: error

# --- Counter for matching lines ---
COUNT=0

# --- Array to store last matching lines ---
MATCH_LINES=()

echo "================================================================"
echo "                Log File Analyzer                               "
echo "================================================================"
echo ""

# ============================================================
# Validate: Check if a log file argument was provided
# ============================================================
if [ -z "$LOGFILE" ]; then
    echo "  ERROR: No log file specified."
    echo "  Usage: $0 /path/to/logfile [keyword]"
    echo ""
    echo "  Common log files to try:"
    echo "    /var/log/syslog      (Ubuntu/Debian)"
    echo "    /var/log/messages    (Fedora/CentOS)"
    exit 1
fi

# ============================================================
# Validate: Check if the log file exists and is readable
# ============================================================
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found."
    
    RETRY=true
    ATTEMPT=0
    MAX_ATTEMPTS=3

    while [ "$RETRY" = true ]; do
        ATTEMPT=$((ATTEMPT + 1))
        [ $ATTEMPT -gt $MAX_ATTEMPTS ] && break

        echo "  Retry attempt $ATTEMPT of $MAX_ATTEMPTS..."

        case $ATTEMPT in
            1) FALLBACK="/var/log/syslog" ;;
            2) FALLBACK="/var/log/messages" ;;
            3) FALLBACK="/var/log/auth.log" ;;
        esac

        if [ -f "$FALLBACK" ]; then
            echo "  Found fallback log file: $FALLBACK"
            LOGFILE="$FALLBACK"
            RETRY=false
        elif [ "$ATTEMPT" -eq "$MAX_ATTEMPTS" ]; then
            echo "  No fallback log files found."
            exit 1
        fi
    done
fi

# ============================================================
# Check if the file is empty
# ============================================================
if [ ! -s "$LOGFILE" ]; then
    echo "  WARNING: '$LOGFILE' is empty. No lines to analyze."
    exit 0
fi

echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo ""
echo "  Scanning file..."
echo ""

# ============================================================
# WHILE READ LOOP
# ============================================================
# Note: For very large logs, 'grep' alone is faster, 
# but we follow your loop logic for the assignment requirements.
while IFS= read -r LINE || [ -n "$LINE" ]; do
    # Using [[ ]] with regex is faster than calling 'echo | grep'
    if [[ "${LINE,,}" == *"${KEYWORD,,}"* ]]; then
        COUNT=$((COUNT + 1))
        MATCH_LINES+=("$LINE")
    fi
done < "$LOGFILE"

# ============================================================
# Display results
# ============================================================
echo "  ----------------------------------------------------------------"
echo "  SUMMARY"
echo "  ----------------------------------------------------------------"
echo "  Keyword '$KEYWORD' found : $COUNT time(s)"
echo ""

if [ $COUNT -gt 0 ]; then
    echo "  Last 5 matching lines:"
    echo "  ----------------------------------------------------------------"

    TOTAL=${#MATCH_LINES[@]}
    START=$(( TOTAL > 5 ? TOTAL - 5 : 0 ))

    for (( i=START; i<TOTAL; i++ )); do
        # Substring expansion to truncate long lines
        DISPLAY_LINE="${MATCH_LINES[$i]:0:100}"
        echo "  [$(( i - START + 1 ))] $DISPLAY_LINE"
    done
    echo ""
else
    echo "  No lines matched the keyword '$KEYWORD'."
fi

echo "================================================================"
