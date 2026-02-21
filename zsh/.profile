export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/android-sdk/tools:/opt/android-sdk/tools/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.bin:$HOME/.local/bin:$HOME/.bin:$HOME:/.local.bin:$HOME/.local/share/mise/install/python/3.13.3/bin

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

QT_QPA_PLATFORMTHEME="qt5ct"

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" # ghcup-env
