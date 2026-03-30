#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: Rudra Ghosh | Reg No: 24BCG10070
# Course: Open Source Software | OSS NGMC Capstone Project
# Description: Loops through key system directories, reports
#              their permissions, owner, group, and disk usage.
#              Also checks Git's config directory specifically.
# ============================================================

# --- List of important system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/var" "/opt")

# --- Git-specific config directory (our chosen software) ---
GIT_SYSTEM_CONFIG="/etc/gitconfig"
GIT_USER_CONFIG="$HOME/.gitconfig"
GIT_GLOBAL_DIR="$HOME/.config/git"

echo "================================================================"
echo "        Disk and Permission Auditor                             "
echo "================================================================"
echo ""
echo "  Auditing standard system directories using a for loop..."
echo ""
printf "  %-20s %-25s %-10s %-10s\n" "Directory" "Permissions/Owner/Group" "Size" "Status"
echo "  ----------------------------------------------------------------------------"

# ============================================================
# FOR LOOP: Iterate over each directory in the DIRS array
# For each directory: check existence, get permissions, size
# ============================================================
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions, owner, and group using ls and awk
        # awk '{print $1, $3, $4}' extracts: perms, owner, group
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # Get human-readable directory size
        # 2>/dev/null suppresses permission-denied errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print formatted row
        printf "  %-20s %-10s %-8s %-8s %-10s %s\n" \
            "$DIR" "$PERMS" "$OWNER" "$GROUP" "${SIZE:-N/A}" "OK"
    else
        # Directory does not exist on this system
        printf "  %-20s %-25s %-10s %s\n" \
            "$DIR" "N/A" "N/A" "NOT FOUND"
    fi
done

echo ""
echo "================================================================"
echo "  GIT-SPECIFIC CONFIGURATION FILE AUDIT"
echo "  (Chosen software: Git)"
echo "================================================================"
echo ""

# ============================================================
# Check Git's system-wide config file and user config
# This section fulfils the TODO: check software config
# ============================================================

# Check system-wide git config
if [ -f "$GIT_SYSTEM_CONFIG" ]; then
    PERMS=$(ls -l "$GIT_SYSTEM_CONFIG" | awk '{print $1, $3, $4}')
    SIZE=$(du -sh "$GIT_SYSTEM_CONFIG" 2>/dev/null | cut -f1)
    echo "  System config : $GIT_SYSTEM_CONFIG"
    echo "  Permissions   : $PERMS"
    echo "  Size          : ${SIZE:-tiny}"
    echo ""
else
    echo "  System config ($GIT_SYSTEM_CONFIG) : NOT FOUND"
    echo "  (Git may be installed but no system-wide config set yet)"
    echo ""
fi

# Check user-level git config
if [ -f "$GIT_USER_CONFIG" ]; then
    PERMS=$(ls -l "$GIT_USER_CONFIG" | awk '{print $1, $3, $4}')
    echo "  User config   : $GIT_USER_CONFIG"
    echo "  Permissions   : $PERMS"
else
    echo "  User config ($GIT_USER_CONFIG) : NOT FOUND"
    echo "  (Run 'git config --global user.name' to create it)"
fi

echo ""
echo "================================================================"
echo "  WHY PERMISSIONS MATTER IN OPEN SOURCE"
echo "================================================================"
echo ""
echo "  Linux permissions are a direct expression of open-source values:"
echo "  - /etc (755): Readable by all — transparency in configuration"
echo "  - /var/log (755/750): Logs visible to admins — auditability"
echo "  - /home (755): Each user owns their space — personal freedom"
echo "  - /tmp (1777): Sticky bit — shared but protected"
echo ""
echo "================================================================"
