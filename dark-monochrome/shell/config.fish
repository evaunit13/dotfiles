set -g fish_greeting
if status is-interactive
    # Commands to run in interactive sessions can go here
end
alias dw "aria2c -x16 -s16 -d "/home/near/Downloads" "
function findext
    find . -name "*.$argv[1]" -type f
end
# opencode
fish_add_path /home/near/.opencode/bin
starship init fish | source
fish_add_path /home/near/development/flutter/bin
fish_add_path /home/near/Android/Sdk/cmdline-tools/latest/bin
fish_add_path /home/near/Android/Sdk/platform-tools
set -x ANDROID_SDK_ROOT /home/near/Android/Sdk
set -x ANDROID_HOME /home/near/Android/Sdk
set -x JAVA_HOME /usr/lib/jvm/java-21-openjdk


# Added by Antigravity CLI installer
set -gx PATH "/home/near/.local/bin" $PATH

# Autostart KDE Plasma Wayland on TTY1 login
if status is-login
    if test -z "$DISPLAY" -a -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = 1
        exec startplasma-wayland
    end
end

