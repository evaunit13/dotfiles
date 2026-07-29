#!/usr/bin/env bash
set -euo pipefail

# Dotfiles Restore Script
# Usage: ./restore.sh [dark-monochrome|mocha]

THEME="${1:-dark-monochrome}"
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${DOTFILES_DIR}/${THEME}"

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Theme directory '$TARGET_DIR' does not exist."
    echo "Available themes: dark-monochrome, mocha"
    exit 1
fi

echo "========================================="
echo " Restoring rice theme: ${THEME}"
echo "========================================="

backup_file() {
    local src="$1"
    local dest="$2"
    if [[ -f "$dest" || -d "$dest" ]]; then
        cp -r "$dest" "${dest}.bak.$(date +%Y%m%d_%H%M%S)" 2>/dev/null || true
    fi
    mkdir -p "$(dirname "$dest")"
    cp -r "$src" "$dest"
    echo "  [✓] Restored $dest"
}

# 1. Ghostty
if [[ -d "${TARGET_DIR}/ghostty" ]]; then
    echo "--> Restoring Ghostty..."
    mkdir -p ~/.config/ghostty
    backup_file "${TARGET_DIR}/ghostty/config" "$HOME/.config/ghostty/config"
    if [[ -d "${TARGET_DIR}/ghostty/shaders" ]]; then
        mkdir -p ~/.config/ghostty/shaders
        cp -r "${TARGET_DIR}/ghostty/shaders/"* "$HOME/.config/ghostty/shaders/" 2>/dev/null || true
    fi
    if [[ -d "${TARGET_DIR}/ghostty/themes" ]]; then
        mkdir -p ~/.config/ghostty/themes
        cp -r "${TARGET_DIR}/ghostty/themes/"* "$HOME/.config/ghostty/themes/" 2>/dev/null || true
    fi
fi

# 2. Starship
if [[ -f "${TARGET_DIR}/starship/starship.toml" ]]; then
    echo "--> Restoring Starship..."
    backup_file "${TARGET_DIR}/starship/starship.toml" "$HOME/.config/starship.toml"
fi

# 3. Fastfetch
if [[ -d "${TARGET_DIR}/fastfetch" ]]; then
    echo "--> Restoring Fastfetch..."
    mkdir -p ~/.config/fastfetch
    backup_file "${TARGET_DIR}/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
    if [[ -f "${TARGET_DIR}/fastfetch/fed.txt" ]]; then
        cp "${TARGET_DIR}/fastfetch/fed.txt" "$HOME/.config/fastfetch/fed.txt"
    fi
fi

# 4. btop
if [[ -d "${TARGET_DIR}/btop" ]]; then
    echo "--> Restoring btop..."
    mkdir -p ~/.config/btop/themes
    backup_file "${TARGET_DIR}/btop/btop.conf" "$HOME/.config/btop/btop.conf"
    if [[ -d "${TARGET_DIR}/btop/themes" ]]; then
        cp -r "${TARGET_DIR}/btop/themes/"* "$HOME/.config/btop/themes/" 2>/dev/null || true
    fi
fi

# 5. Cava
if [[ -f "${TARGET_DIR}/cava/config" ]]; then
    echo "--> Restoring Cava..."
    backup_file "${TARGET_DIR}/cava/config" "$HOME/.config/cava/config"
fi

# 6. Fish
if [[ -f "${TARGET_DIR}/fish/config.fish" ]]; then
    echo "--> Restoring Fish shell..."
    backup_file "${TARGET_DIR}/fish/config.fish" "$HOME/.config/fish/config.fish"
fi

# 7. GTK 3 & GTK 4
if [[ -d "${TARGET_DIR}/gtk-3.0" ]]; then
    echo "--> Restoring GTK 3.0..."
    mkdir -p ~/.config/gtk-3.0
    cp -r "${TARGET_DIR}/gtk-3.0/"* "$HOME/.config/gtk-3.0/" 2>/dev/null || true
fi
if [[ -d "${TARGET_DIR}/gtk-4.0" ]]; then
    echo "--> Restoring GTK 4.0..."
    mkdir -p ~/.config/gtk-4.0
    cp -r "${TARGET_DIR}/gtk-4.0/"* "$HOME/.config/gtk-4.0/" 2>/dev/null || true
fi

# 8. Zen Browser
if [[ -d "${TARGET_DIR}/zen-browser/chrome" ]]; then
    echo "--> Restoring Zen Browser CSS..."
    for profile in "$HOME/.zen/"*.Default*; do
        if [[ -d "$profile" ]]; then
            mkdir -p "$profile/chrome"
            cp -r "${TARGET_DIR}/zen-browser/chrome/"* "$profile/chrome/" 2>/dev/null || true
            echo "  [✓] Applied to Zen profile: $(basename "$profile")"
        fi
    done
fi

# 9. KDE Plasma & Window Decorations
if [[ -d "${TARGET_DIR}/kde" ]]; then
    echo "--> Restoring KDE Plasma..."
    mkdir -p ~/.config ~/.local/share/color-schemes ~/.local/share/aurorae/themes ~/.local/share/plasma/look-and-feel

    [[ -f "${TARGET_DIR}/kde/kdeglobals" ]] && cp "${TARGET_DIR}/kde/kdeglobals" "$HOME/.config/kdeglobals"
    [[ -f "${TARGET_DIR}/kde/kwinrc" ]] && cp "${TARGET_DIR}/kde/kwinrc" "$HOME/.config/kwinrc"
    [[ -f "${TARGET_DIR}/kde/plasmarc" ]] && cp "${TARGET_DIR}/kde/plasmarc" "$HOME/.config/plasmarc"
    [[ -f "${TARGET_DIR}/kde/kscreenlockerrc" ]] && cp "${TARGET_DIR}/kde/kscreenlockerrc" "$HOME/.config/kscreenlockerrc"
    [[ -f "${TARGET_DIR}/kde/ksplashrc" ]] && cp "${TARGET_DIR}/kde/ksplashrc" "$HOME/.config/ksplashrc"
    [[ -f "${TARGET_DIR}/kde/dolphinrc" ]] && cp "${TARGET_DIR}/kde/dolphinrc" "$HOME/.config/dolphinrc"
    [[ -f "${TARGET_DIR}/kde/elisarc" ]] && cp "${TARGET_DIR}/kde/elisarc" "$HOME/.config/elisarc"

    if [[ -d "${TARGET_DIR}/kde/color-schemes" ]]; then
        cp -r "${TARGET_DIR}/kde/color-schemes/"* "$HOME/.local/share/color-schemes/" 2>/dev/null || true
    fi
    if [[ -d "${TARGET_DIR}/kde/aurorae" ]]; then
        cp -r "${TARGET_DIR}/kde/aurorae/"* "$HOME/.local/share/aurorae/themes/" 2>/dev/null || true
    fi
    if [[ -d "${TARGET_DIR}/kde/look-and-feel" ]]; then
        cp -r "${TARGET_DIR}/kde/look-and-feel/"* "$HOME/.local/share/plasma/look-and-feel/" 2>/dev/null || true
    fi
fi

# Apply KDE live changes
if command -v plasma-apply-colorscheme >/dev/null 2>&1; then
    if [[ "$THEME" == "dark-monochrome" ]]; then
        plasma-apply-colorscheme DarkMonochrome 2>/dev/null || true
    elif [[ "$THEME" == "mocha" ]]; then
        plasma-apply-colorscheme CatppuccinMochaBlue 2>/dev/null || true
    fi
fi

if command -v qdbus >/dev/null 2>&1; then
    qdbus org.kde.KWin /KWin reconfigure 2>/dev/null || true
fi

echo "========================================="
echo " Done restoring ${THEME} rice!"
echo " Restart Zen Browser & Ghostty to see full changes."
echo "========================================="
