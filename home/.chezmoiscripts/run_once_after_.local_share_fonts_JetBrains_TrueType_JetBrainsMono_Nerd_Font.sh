#!/bin/bash

FONT_DIR="$HOME/.local/share/fonts"
echo "🔄 Installing JetBrainsMono fonts..."
if [ -d "$FONT_DIR" ]; then
  echo "✅ JetBrainsMono fonts installed. Running fc-cache..."
  fc-cache -fv "$FONT_DIR"
fi
