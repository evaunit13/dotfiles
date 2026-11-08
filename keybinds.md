# KDE Plasma Keybindings & Niri Translation Reference

Extracted from KDE Plasma configuration (`~/.config/kglobalshortcutsrc`).  
Organized by functional category with matching **Niri (`config.kdl`)** syntax equivalents for quick reference when configuring your Niri rice.

---

## 1. Application Launchers

| Action | Current KDE Shortcut | Niri (`config.kdl`) Equivalent |
| :--- | :--- | :--- |
| **Terminal (Kitty)** | `Meta + T` | `Mod+T { spawn "kitty"; }`<br>`Mod+Return { spawn "kitty"; }` |
| **File Manager (Dolphin)** | `Meta + D` | `Mod+D { spawn "dolphin"; }` |
| **Web Browser (Zen)** | `Meta + Z` | `Mod+Z { spawn "zen-browser"; }` |
| **Helium Browser** | `Meta + H` | `Mod+H { spawn "helium"; }` |
| **App Launcher (KRunner / Fuzzel)** | `Meta`, `Alt + Space`, `Alt + F2` | `Mod+Space { spawn "fuzzel"; }` |
| **Clipboard History** | `Meta + V` | `Mod+V { spawn "sh" "-c" "cliphist list \| fuzzel -d \| cliphist decode \| wl-copy"; }` |
| **Touchscreen Toggle** | `Favorites` | `XF86Favorites { spawn "/path/to/touchscreen_toggle.sh"; }` |

---

## 2. Window Management & Tiling (Krohnkite / KWin)

### Window Actions
| Action | Current KDE Shortcut | Niri (`config.kdl`) Equivalent |
| :--- | :--- | :--- |
| **Close Window** | `Meta + Q` | `Mod+Q { close-window; }` |
| **Maximize Window** | `Meta + F` | `Mod+F { maximize-column; }` |
| **Fullscreen Window** | `Meta + Shift + F` | `Mod+Shift+F { fullscreen-window; }` |
| **Center Window** | `Meta + Backspace` | `Mod+C { center-column; }` |
| **Kill Window (Force)** | `Meta + Ctrl + Esc` | `Mod+Ctrl+Esc { spawn "killall" "-9"; }` |

### Focus Navigation
| Action | Current KDE Shortcut | Niri (`config.kdl`) Equivalent |
| :--- | :--- | :--- |
| **Focus Left** | `Meta + Alt + Left` | `Mod+Left { focus-column-left; }`<br>`Mod+H { focus-column-left; }` |
| **Focus Right** | `Meta + Alt + Right` | `Mod+Right { focus-column-right; }`<br>`Mod+L { focus-column-right; }` |
| **Focus Down** | `Meta + J` / `Meta + Alt + Down` | `Mod+Down { focus-window-down; }`<br>`Mod+J { focus-window-down; }` |
| **Focus Up** | `Meta + K` / `Meta + Alt + Up` | `Mod+Up { focus-window-up; }`<br>`Mod+K { focus-window-up; }` |

### Window Movement & Shifting
| Action | Current KDE Shortcut | Niri (`config.kdl`) Equivalent |
| :--- | :--- | :--- |
| **Move Column Left** | `Meta + Shift + H` | `Mod+Shift+Left { move-column-left; }`<br>`Mod+Shift+H { move-column-left; }` |
| **Move Column Right** | `Meta + Shift + L` | `Mod+Shift+Right { move-column-right; }`<br>`Mod+Shift+L { move-column-right; }` |
| **Move Window Down** | `Meta + Shift + J` | `Mod+Shift+Down { move-window-down; }`<br>`Mod+Shift+J { move-window-down; }` |
| **Move Window Up** | `Meta + Shift + K` | `Mod+Shift+Up { move-window-up; }`<br>`Mod+Shift+K { move-window-up; }` |

### Window Resizing
| Action | Current KDE Shortcut | Niri (`config.kdl`) Equivalent |
| :--- | :--- | :--- |
| **Shrink Column Width** | `Meta + Ctrl + H` | `Mod+Minus { set-column-width "-10%"; }`<br>`Mod+Ctrl+H { set-column-width "-10%"; }` |
| **Grow Column Width** | `Meta + Ctrl + L` | `Mod+Equal { set-column-width "+10%"; }`<br>`Mod+Ctrl+L { set-column-width "+10%"; }` |
| **Shrink Window Height** | `Meta + Ctrl + K` | `Mod+Ctrl+K { set-window-height "-10%"; }` |
| **Grow Window Height** | `Meta + Ctrl + J` | `Mod+Ctrl+J { set-window-height "+10%"; }` |
| **Reset Column Width** | `Meta + 0` | `Mod+R { switch-preset-column-width; }` |

---

## 3. Workspaces (Desktops 1–9)

| Action | Current KDE Shortcut | Niri (`config.kdl`) Equivalent |
| :--- | :--- | :--- |
| **Switch to Workspace 1** | `Meta + 1` | `Mod+1 { focus-workspace 1; }` |
| **Switch to Workspace 2** | `Meta + 2` | `Mod+2 { focus-workspace 2; }` |
| **Switch to Workspace 3** | `Meta + 3` | `Mod+3 { focus-workspace 3; }` |
| **Switch to Workspace 4** | `Meta + 4` | `Mod+4 { focus-workspace 4; }` |
| **Switch to Workspace 5** | `Meta + 5` | `Mod+5 { focus-workspace 5; }` |
| **Switch to Workspace 6** | `Meta + 6` | `Mod+6 { focus-workspace 6; }` |
| **Switch to Workspace 7** | `Meta + 7` | `Mod+7 { focus-workspace 7; }` |
| **Switch to Workspace 8** | `Meta + 8` | `Mod+8 { focus-workspace 8; }` |
| **Switch to Workspace 9** | `Meta + 9` | `Mod+9 { focus-workspace 9; }` |
| **Move Window to WS 1** | `Meta + !` (`Meta + Shift + 1`) | `Mod+Shift+1 { move-column-to-workspace 1; }` |
| **Move Window to WS 2** | `Meta + @` (`Meta + Shift + 2`) | `Mod+Shift+2 { move-column-to-workspace 2; }` |
| **Move Window to WS 3** | `Meta + #` (`Meta + Shift + 3`) | `Mod+Shift+3 { move-column-to-workspace 3; }` |
| **Move Window to WS 4** | `Meta + $` (`Meta + Shift + 4`) | `Mod+Shift+4 { move-column-to-workspace 4; }` |
| **Move Window to WS 5** | `Meta + %` (`Meta + Shift + 5`) | `Mod+Shift+5 { move-column-to-workspace 5; }` |

---

## 4. Multi-Monitor / Screen Navigation

| Action | Current KDE Shortcut | Niri (`config.kdl`) Equivalent |
| :--- | :--- | :--- |
| **Focus Screen Left / 0** | `Meta + ]` | `Mod+BracketLeft { focus-monitor-left; }` |
| **Focus Screen Right / 1** | `Meta + [` | `Mod+BracketRight { focus-monitor-right; }` |
| **Move Column to Prev Screen** | `Meta + Shift + Left` | `Mod+Shift+BracketLeft { move-column-to-monitor-left; }` |
| **Move Column to Next Screen** | `Meta + Shift + Right` | `Mod+Shift+BracketRight { move-column-to-monitor-right; }` |

---

## 5. Hardware, Audio & Media Controls

| Hardware Key / Event | Function | Niri Command / Spawn |
| :--- | :--- | :--- |
| `XF86AudioRaiseVolume` | Volume Up (+5%) | `spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"` |
| `Shift + XF86AudioRaiseVolume` | Fine Volume Up (+1%) | `spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "1%+"` |
| `XF86AudioLowerVolume` | Volume Down (-5%) | `spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"` |
| `Shift + XF86AudioLowerVolume` | Fine Volume Down (-1%) | `spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "1%-"` |
| `XF86AudioMute` | Mute Output | `spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"` |
| `XF86AudioMicMute` / `Meta + VolMute` | Mute Microphone | `spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"` |
| `XF86AudioPlay` / `XF86AudioPause` | Media Play/Pause | `spawn "playerctl" "play-pause"` |
| `XF86AudioNext` | Next Track | `spawn "playerctl" "next"` |
| `XF86AudioPrev` | Previous Track | `spawn "playerctl" "previous"` |
| `XF86MonBrightnessUp` | Screen Brightness Up | `spawn "brightnessctl" "set" "+5%"` |
| `XF86MonBrightnessDown` | Screen Brightness Down | `spawn "brightnessctl" "set" "5%-"` |
| `XF86KbdBrightnessUp` | Keyboard Backlight Up | `spawn "brightnessctl" "--device=*" "set" "+10%"` |
| `XF86KbdBrightnessDown` | Keyboard Backlight Down | `spawn "brightnessctl" "--device=*" "set" "10%-"` |

---

## 6. System & Session Management

| Action | Current KDE Shortcut | Niri (`config.kdl`) Equivalent |
| :--- | :--- | :--- |
| **Lock Screen** | `Meta + L` / `Screensaver` | `Mod+L { spawn "swaylock"; }` |
| **Logout / Power Menu** | `Ctrl + Alt + Del` | `Ctrl+Alt+Delete { quit; }` |
| **Power Profile Switch** | `Meta + B` | `Mod+B { spawn "powerprofilesctl" "cycle"; }` |
| **Keyboard Layout Switch** | `Meta + Alt + K` / `Meta + Alt + L` | `Mod+Space { switch-layout "next"; }` |
