#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author: Rudra Ghosh | Reg No: 24BCG10070
# Course: Open Source Software | OSS NGMC Project
# Description: Interactively asks the user three questions
#              and composes a personalised open-source
#              philosophy statement, saved to a .txt file.
# ============================================================

# --- Helper Functions (Function-as-alias pattern) ---
print_divider() {
    echo "================================================================"
}

# --- Welcome screen ---
clear
print_divider
echo "        Open Source Manifesto Generator                         "
print_divider
echo ""
echo "  This script will generate a personalised open-source"
echo "  philosophy statement based on your answers."
echo "  Your manifesto will be saved as a .txt file."
echo ""
print_divider
echo ""

# --- Interactive user input ---
# Using -r to handle backslashes correctly in user input
read -p "  1. Name one open-source tool you use every day: " TOOL
echo ""
read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM
echo ""
read -p "  3. Name one thing you would build and share freely: " BUILD
echo ""

# --- Validation ---
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  ERROR: Please answer all three questions."
    echo "  Run the script again and fill in each response."
    exit 1
fi

# --- Date and Environment Setup ---
DATE=$(date '+%d %B %Y')
TIME=$(date '+%H:%M')
USERNAME=$(whoami)
OUTPUT="manifesto_${USERNAME}.txt"

# ============================================================
# COMPOSING THE MANIFESTO
# We use a 'Here-Document' (<<EOF) to write the entire file 
# at once. This is much cleaner than multiple echo commands.
# ============================================================

cat <<EOF > "$OUTPUT"
OPEN SOURCE MANIFESTO
Generated on $DATE at $TIME by $USERNAME
================================================================

I am a student of open source — not just of its code, but of its
values. Every day, I rely on $TOOL, a tool built by people I have
never met, who chose to share their work with the world. They asked
nothing in return except that I do the same.

To me, freedom means $FREEDOM. That is why open source matters: it
is not merely a licensing model but a commitment to the idea that
knowledge grows stronger when it is shared. Every fork, every pull
request, every issue filed is an act of trust between strangers.

One day, I intend to build $BUILD and release it freely under an
open license. I will do this because I understand what it means to
stand on the shoulders of those who came before me. The developers
who built $TOOL did not hoard their work. Neither will I.

This is my commitment to the open-source way.

                                 — $USERNAME, $DATE
================================================================
EOF

# --- Display Results ---
print_divider
echo "  Manifesto saved to: $OUTPUT"
print_divider
echo ""

# Print the saved file to screen for confirmation
cat "$OUTPUT"

echo ""
print_divider
echo "  Your manifesto has been saved. You can share it, commit it"
echo "  to a Git repository, or simply keep it as a reminder of"
echo "  why open source matters."
print_divider
