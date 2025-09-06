#
# NOTE: Add this to main .bashrc
# ```
# source ~/.dotfiles/bash/.custom_profile_bashrc.sh
# ```
#

alias ls='eza -lah --group-directories-first --color=auto --icons=auto'

v() {
    selection=$(rg --files '.' \
        -g '!node_modules' \
        -g '!*.gif' \
        -g '!*.ico' \
        -g '!*.d.*' \
        -g '!*.png' | fzf)

    if [[ -n "$selection" ]]; then
        nvim "$selection"
    fi
}

# === For Rust applications ===
. "$HOME/.cargo/env"

# === Zoxide ===
eval "$(zoxide init bash)"
# ======

