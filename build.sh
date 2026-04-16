#!/bin/bash
# ab-deck PDF generator
# Usage: ./build.sh path/to/deck.html [output-name]
# Produces: {output-name}.pdf in the same dir as the HTML (landscape, dark mode)

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <path-to-deck.html> [output-name]"
  echo "  Generates a landscape PDF in the same directory."
  exit 1
fi

HTML_PATH="$1"
if [ ! -f "$HTML_PATH" ]; then
  echo "Error: HTML file not found at $HTML_PATH"
  exit 1
fi

DIR=$(dirname "$HTML_PATH")
NAME=$(basename "$HTML_PATH" .html)
OUTPUT_NAME="${2:-$NAME}"
PDF_PATH="$DIR/$OUTPUT_NAME.pdf"

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
if [ ! -x "$CHROME" ]; then
  echo "Error: Google Chrome not found at $CHROME"
  echo "Install Chrome, or open the HTML in your browser and use Cmd+P → Save as PDF"
  exit 1
fi

# Convert to absolute file:// URL
ABS_PATH=$(python3 -c "import os, sys; print(os.path.abspath(sys.argv[1]))" "$HTML_PATH")

"$CHROME" \
  --headless=new \
  --disable-gpu \
  --print-to-pdf="$PDF_PATH" \
  --no-pdf-header-footer \
  --print-to-pdf-no-header \
  "file://$ABS_PATH" 2>&1 | grep -v "SharedImageManager" | tail -3

echo "PDF: $PDF_PATH"
open "$PDF_PATH"
