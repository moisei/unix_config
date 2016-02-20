USER_CFG_DIR=$HOME/.config_private

alias a="alias"
alias ra="source $USER_CFG_DIR/.bash_aliases"
alias ea="pico $USER_CFG_DIR/.bash_aliases"

alias del="rm"
alias ren="mv"
alias rmdir="rm -rf"

alias g="grep"
alias gi="grep -i"
alias cd..="cd .."


source "$USER_CFG_DIR/.docker_aliases"
