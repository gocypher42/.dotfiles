set -U fish_greeting

alias v=nvim
alias ls="exa -la --color=always --group-directories-first"

set -U fish_user_paths ~/.cargo/bin $fish_user_paths
set -U fish_user_paths /usr/lib/jvm/default/bin $fish_user_paths
set JAVA_HOME /usr/lib/jvm/default
