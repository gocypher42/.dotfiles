#
# NOTE: Add this to main .bashrc
# ```
# source ~/.dotfiles/bash/.custom_profile_bashrc.sh
# ```
#

alias ls='eza -lah --group-directories-first --color=auto --icons=auto'

# === For Rust applications ===
. "$HOME/.cargo/env"

# === Zoxide ===
eval "$(zoxide init bash)"
# ======

