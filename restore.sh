#!/usr/bin/env bash
set -euo pipefail

# Dotfiles Restore Script
# Usage: ./restore.sh [dark-monochrome|mocha|kanagawa-dragon|endor|nocturne]

THEME="${1:-dark-monochrome}"
[[ "$THEME" == "kanagawa" ]] && THEME="kanagawa-dragon"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${DOTFILES_DIR}/${THEME}"

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Theme directory '$TARGET_DIR' does not exist."
    echo "Available themes: dark-monochrome, mocha, kanagawa-dragon, endor, nocturne"
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

# 2. Kitty
if [[ -d "${TARGET_DIR}/kitty" ]]; then
    echo "--> Restoring Kitty..."
    mkdir -p ~/.config/kitty
    backup_file "${TARGET_DIR}/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
    if [[ -d "${TARGET_DIR}/kitty/themes" ]]; then
        mkdir -p ~/.config/kitty/themes
        cp -r "${TARGET_DIR}/kitty/themes/"* "$HOME/.config/kitty/themes/" 2>/dev/null || true
    fi
    if [[ -e "${TARGET_DIR}/kitty/current-theme.conf" ]]; then
        cp -a "${TARGET_DIR}/kitty/current-theme.conf" "$HOME/.config/kitty/current-theme.conf"
    fi
fi

# 3. Starship
if [[ -f "${TARGET_DIR}/starship/starship.toml" ]]; then
    echo "--> Restoring Starship..."
    backup_file "${TARGET_DIR}/starship/starship.toml" "$HOME/.config/starship.toml"
fi

# 4. Fastfetch
if [[ -d "${TARGET_DIR}/fastfetch" ]]; then
    echo "--> Restoring Fastfetch..."
    mkdir -p ~/.config/fastfetch
    backup_file "${TARGET_DIR}/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
    for logofile in "${TARGET_DIR}/fastfetch/"*.txt "${TARGET_DIR}/fastfetch/"*.png; do
        if [[ -f "$logofile" ]]; then
            cp "$logofile" "$HOME/.config/fastfetch/"
        fi
    done
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

# 8b. Helium Browser
if [[ -f "${TARGET_DIR}/helium/manifest.json" ]]; then
    echo "--> Restoring Helium Browser theme..."
    mkdir -p "$HOME/.config/net.imput.helium/themes/rice-dark-theme"
    backup_file "${TARGET_DIR}/helium/manifest.json" "$HOME/.config/net.imput.helium/themes/rice-dark-theme/manifest.json"
    rm -f "$HOME/.config/net.imput.helium/themes/rice-dark-theme/Cached Theme.pak" 2>/dev/null || true
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
    if [[ "$THEME" == "dark-monochrome" || "$THEME" == "kanagawa-dragon" || "$THEME" == "endor" || "$THEME" == "nocturne" ]]; then
        plasma-apply-colorscheme DarkMonochrome 2>/dev/null || true
    elif [[ "$THEME" == "mocha" ]]; then
        plasma-apply-colorscheme CatppuccinMochaBlue 2>/dev/null || true
    fi
fi

if [[ "$THEME" == "endor" && -f "$HOME/Pictures/Wallpapers/starwars.png" ]]; then
    if command -v plasma-apply-wallpaperimage >/dev/null 2>&1; then
        plasma-apply-wallpaperimage "$HOME/Pictures/Wallpapers/starwars.png" 2>/dev/null || true
    fi
elif [[ "$THEME" == "nocturne" && -f "$HOME/Pictures/Wallpapers/sea night.jpg" ]]; then
    if command -v plasma-apply-wallpaperimage >/dev/null 2>&1; then
        plasma-apply-wallpaperimage "$HOME/Pictures/Wallpapers/sea night.jpg" 2>/dev/null || true
    fi
fi

if command -v qdbus >/dev/null 2>&1; then
    qdbus org.kde.KWin /KWin reconfigure 2>/dev/null || true
fi

echo "========================================="
echo " Done restoring ${THEME} rice!"
echo " Restart Zen Browser, Helium, Ghostty & Kitty to see full changes."
echo "========================================="
