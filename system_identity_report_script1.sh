#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: Rudra Ghosh | Reg No: 24BCG10070
# Course: Open Source Software | OSS NGMC Capstone Project
# Description: Displays a welcome screen with system info
#              and open-source license details for the OS.
# ============================================================

# --- Student & Software Variables ---
STUDENT_NAME="Rudra Ghosh"
REG_NO="24BCG10070"
SOFTWARE_CHOICE="Git"

# --- Gather System Information using command substitution ---
KERNEL=$(uname -r)                          # Kernel version
DISTRO=$(cat /etc/os-release | grep "^PRETTY_NAME" | cut -d= -f2 | tr -d '"')  # Distro name
USER_NAME=$(whoami)                         # Logged-in user
HOME_DIR=$HOME                             # User's home directory
UPTIME=$(uptime -p)                         # System uptime in human-readable form
CURRENT_DATE=$(date '+%A, %d %B %Y')        # Full date (e.g., Monday, 01 January 2024)
CURRENT_TIME=$(date '+%H:%M:%S %Z')         # Current time with timezone

# --- Determine OS License ---
# Most Linux distributions are licensed under GPL v2 or compatible licenses
# The Linux kernel itself is licensed under GPL v2
OS_LICENSE="GNU General Public License v2 (GPL v2)"

# ============================================================
# Display: Open Source Audit Welcome Screen
# ============================================================
echo "================================================================"
echo "        OPEN SOURCE AUDIT — System Identity Report             "
echo "================================================================"
echo ""
echo "  Student  : $RUDRA_GHOSH"
echo "  Reg No   : $24BCG10070"
echo "  Software : $Git"
echo ""
echo "----------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "----------------------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Logged User  : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date         : $CURRENT_DATE"
echo "  Time         : $CURRENT_TIME"
echo ""
echo "----------------------------------------------------------------"
echo "  LICENSE INFORMATION"
echo "----------------------------------------------------------------"
echo "  This operating system is covered under:"
echo "  $OS_LICENSE"
echo ""
echo "  The GPL v2 ensures that the OS kernel source code is freely"
echo "  available, modifiable, and redistributable — as long as any"
echo "  derivative work is also distributed under the same license."
echo "================================================================"
echo ""
