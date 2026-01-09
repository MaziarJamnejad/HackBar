#!/bin/bash
set -euo pipefail

OUT_DIR="panel-export"
./config/export-panel-config.sh "$OUT_DIR"

ZIP="panel-export.zip"
rm -f "$ZIP"
zip -r "$ZIP" "$OUT_DIR" >/dev/null

echo "Created: $ZIP"
echo "Upload panel-export.zip to ChatGPT (after redacting if needed)."
