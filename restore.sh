#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

copy_and_backup() {
    local src="$1"
    local dest="$2"
    
    if [ -e "$dest" ]; then
        echo -e "\e[33mBacking up $dest to $dest.bak\e[0m"
        mv "$dest" "$dest.bak"
    fi
    
    mkdir -p "$(dirname "$dest")"
    echo -e "\e[32mRestoring $(basename "$src") to $dest\e[0m"
    cp -r "$src" "$dest"
}

echo -e "\e[34m--- Restoring Ghostty ---\e[0m"
copy_and_backup "$DOTFILES_DIR/ghostty/config" ~/.config/ghostty/config
copy_and_backup "$DOTFILES_DIR/ghostty/shaders/cursor_warp.glsl" ~/.config/ghostty/shaders/cursor_warp.glsl
copy_and_backup "$DOTFILES_DIR/ghostty/shaders/ripple_cursor.glsl" ~/.config/ghostty/shaders/ripple_cursor.glsl
copy_and_backup "$DOTFILES_DIR/ghostty/themes/dankcolors" ~/.config/ghostty/themes/dankcolors

echo -e "\e[34m--- Restoring Starship ---\e[0m"
copy_and_backup "$DOTFILES_DIR/starship/starship.toml" ~/.config/starship.toml

echo -e "\e[34m--- Restoring Fastfetch ---\e[0m"
copy_and_backup "$DOTFILES_DIR/fastfetch/config.jsonc" ~/.config/fastfetch/config.jsonc
copy_and_backup "$DOTFILES_DIR/fastfetch/fed.txt" ~/.config/fastfetch/fed.txt

echo -e "\e[34m--- Restoring btop ---\e[0m"
copy_and_backup "$DOTFILES_DIR/btop/btop.conf" ~/.config/btop/btop.conf
copy_and_backup "$DOTFILES_DIR/btop/themes/mocha.theme" ~/.config/btop/themes/mocha.theme

echo -e "\e[34m--- Restoring KDE Plasma ---\e[0m"
copy_and_backup "$DOTFILES_DIR/kde/kdeglobals" ~/.config/kdeglobals
copy_and_backup "$DOTFILES_DIR/kde/kwinrc" ~/.config/kwinrc
copy_and_backup "$DOTFILES_DIR/kde/plasmarc" ~/.config/plasmarc
copy_and_backup "$DOTFILES_DIR/kde/kscreenlockerrc" ~/.config/kscreenlockerrc
copy_and_backup "$DOTFILES_DIR/kde/ksplashrc" ~/.config/ksplashrc
copy_and_backup "$DOTFILES_DIR/kde/color-schemes/CatppuccinMochaBlue.colors" ~/.local/share/color-schemes/CatppuccinMochaBlue.colors
copy_and_backup "$DOTFILES_DIR/kde/aurorae/CatppuccinMocha-Modern" ~/.local/share/aurorae/themes/CatppuccinMocha-Modern
copy_and_backup "$DOTFILES_DIR/kde/look-and-feel/Catppuccin-Mocha-Blue" ~/.local/share/plasma/look-and-feel/Catppuccin-Mocha-Blue

echo -e "\e[34m--- Restoring GTK 3.0 ---\e[0m"
copy_and_backup "$DOTFILES_DIR/gtk-3.0/colors.css" ~/.config/gtk-3.0/colors.css
copy_and_backup "$DOTFILES_DIR/gtk-3.0/settings.ini" ~/.config/gtk-3.0/settings.ini
copy_and_backup "$DOTFILES_DIR/gtk-3.0/gtk.css" ~/.config/gtk-3.0/gtk.css
copy_and_backup "$DOTFILES_DIR/gtk-3.0/window_decorations.css" ~/.config/gtk-3.0/window_decorations.css
copy_and_backup "$DOTFILES_DIR/gtk-3.0/assets" ~/.config/gtk-3.0/assets

echo -e "\e[34m--- Restoring GTK 4.0 ---\e[0m"
copy_and_backup "$DOTFILES_DIR/gtk-4.0/colors.css" ~/.config/gtk-4.0/colors.css
copy_and_backup "$DOTFILES_DIR/gtk-4.0/settings.ini" ~/.config/gtk-4.0/settings.ini
copy_and_backup "$DOTFILES_DIR/gtk-4.0/gtk.css" ~/.config/gtk-4.0/gtk.css
copy_and_backup "$DOTFILES_DIR/gtk-4.0/assets" ~/.config/gtk-4.0/assets

echo -e "\e[34m--- Restoring Fish ---\e[0m"
copy_and_backup "$DOTFILES_DIR/fish/config.fish" ~/.config/fish/config.fish

echo -e "\e[34m--- Restoring Zen Browser ---\e[0m"
copy_and_backup "$DOTFILES_DIR/zen-browser/chrome/userChrome.css" ~/.zen/"pjzhpxnw.Default (release)"/chrome/userChrome.css
copy_and_backup "$DOTFILES_DIR/zen-browser/chrome/userContent.css" ~/.zen/"pjzhpxnw.Default (release)"/chrome/userContent.css

echo -e "\e[34m--- Restoring Cava ---\e[0m"
copy_and_backup "$DOTFILES_DIR/cava/config" ~/.config/cava/config

echo -e "\e[32mDone! Please reload KDE (e.g. qdbus org.kde.KWin /KWin reconfigure) for changes to take effect.\e[0m"
