#!/bin/bash

##############################################################################
# LaTeX to Microsoft Word (.docx) Conversion Script
#
# This script converts the Kubernetes lab manual from LaTeX to Word format
# using pandoc.
#
# Requirements:
#   - pandoc: https://pandoc.org/installing.html
#   - pandoc-crossref (optional): For better reference handling
#
# Usage:
#   chmod +x convert_to_word.sh
#   ./convert_to_word.sh
##############################################################################

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== LaTeX to Word Conversion ===${NC}"

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo -e "${RED}Error: pandoc is not installed${NC}"
    echo "Install pandoc from: https://pandoc.org/installing.html"
    echo ""
    echo "Quick install options:"
    echo "  macOS:  brew install pandoc"
    echo "  Linux:  sudo apt-get install pandoc"
    echo "  Windows: choco install pandoc"
    exit 1
fi

INPUT_FILE="main.tex"
OUTPUT_FILE="kubernetes_lab_manual.docx"

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo -e "${RED}Error: $INPUT_FILE not found${NC}"
    exit 1
fi

echo -e "${YELLOW}Input:${NC}  $INPUT_FILE"
echo -e "${YELLOW}Output:${NC} $OUTPUT_FILE"
echo ""

# Convert LaTeX to Word
echo -e "${YELLOW}Converting LaTeX to Word format...${NC}"

pandoc \
    "$INPUT_FILE" \
    -f latex \
    -t docx \
    -o "$OUTPUT_FILE" \
    --variable=colorlinks:true \
    2>&1 || true

# Check if conversion was successful
if [ -f "$OUTPUT_FILE" ]; then
    FILE_SIZE=$(ls -lh "$OUTPUT_FILE" | awk '{print $5}')
    echo -e "${GREEN}✓ Conversion successful!${NC}"
    echo -e "${GREEN}✓ File created: $OUTPUT_FILE ($FILE_SIZE)${NC}"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "  1. Open $OUTPUT_FILE in Microsoft Word"
    echo "  2. Review formatting (some LaTeX features may need manual adjustments)"
    echo "  3. The document structure, headings, and code blocks are preserved"
else
    echo -e "${RED}✗ Conversion failed${NC}"
    echo "Try installing pandoc and running again:"
    echo "  brew install pandoc  (macOS)"
    echo "  sudo apt-get install pandoc  (Linux)"
    exit 1
fi

##############################################################################
# Notes on conversion:
# - Most LaTeX formatting is preserved
# - \textbf{} → Bold, \textit{} → Italic
# - Code listings → Formatted code blocks
# - Tables → Word tables
# - Colored boxes → May appear as plain text (can be manually styled in Word)
# - Internal references may not convert perfectly (check and update manually)
# - Section numbering is preserved
#
# Manual touch-ups in Word may be needed for:
# - Custom box colors (blue, green, yellow boxes)
# - Some special characters or symbols
# - Fine-tuning layout and margins
##############################################################################
