set -g fish_greeting

# Environment variables
set -gx ANDROID_SDK_ROOT $HOME/Android/Sdk
set -gx ANDROID_HOME $HOME/Android/Sdk
set -gx JAVA_HOME /usr/lib/jvm/java-21-openjdk

# User binaries & SDK paths (idempotent, single call)
fish_add_path -g $HOME/.local/bin \
    $HOME/.opencode/bin \
    $HOME/development/flutter/bin \
    $HOME/Android/Sdk/cmdline-tools/latest/bin \
    $HOME/Android/Sdk/platform-tools

# Interactive session setup
if status is-interactive
    alias dw 'aria2c -x16 -s16 -d ~/Downloads'

    # Prompt initialization
    starship init fish | source

    # Force blinking underline cursor (\e[3 q)
    echo -en "\e[3 q"
    function __force_cursor_shape --on-event fish_prompt
        echo -en "\e[3 q"
    end

    # Disable right prompt over SSH to prevent staircase line wrapping on mobile (Termius)
    if test -n "$SSH_CONNECTION"
        function fish_right_prompt; end
    end
end

# Autostart KDE Plasma Wayland on TTY1 login
if status is-login
    if test -z "$DISPLAY" -a -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = 1
        exec startplasma-wayland
    end
end
