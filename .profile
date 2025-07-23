alias c="clear"
alias vim='nvim'
alias vimo='vim'
alias ls='ls --color=auto'

export EDITOR="nvim"
export SHELL="zsh"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/sbin"

if ! type open > /dev/null ; then
  alias open=xdg-open
fi

export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

if [ -f /opt/asdf-vm/asdf.sh ]; then
  export ASDF_DIR=/opt/asdf-vm
  export ASDF_CONFIG_FILE=$HOME/asdf/asdfrc
  export ASDF_DATA_DIR=$HOME/asdf
  source $ASDF_DIR/asdf.sh

  # Insert autocompletion setup for your shell here.
fi

if [ -f "${HOME}/.dotfiles-settings" ]; then
    source "${HOME}/.dotfiles-settings";
fi

# run scripts
# if [ "${H8_DEVICE}" = "pc" ]; then
#     if [ -f "${HOME}/.scripts/monitor-setup.sh" ]; then
#         sh "${HOME}/.scripts/monitor-setup.sh" > /dev/null 2>&1
#     fi
#
#     if [ -f "${HOME}/.scripts/mousesettings.sh" ]; then
#         sh "${HOME}/.scripts/mousesettings.sh" > /dev/null 2>&1
#     fi
# fi
#
if [ "${H8_DEVICE}" = "yoga-laptop" ]; then
    if [ -f "${HOME}/.scripts/mousesettings-laptop.sh" ]; then
        sh "${HOME}/.scripts/mousesettings-laptop.sh" > /dev/null 2>&1
    fi
fi


# only if os is not macos
if [ "$(uname)" != "Darwin" ]; then
    # setxkbmap -layout us -option caps:escape

    if [ -e /home/luis8h/.nix-profile/etc/profile.d/nix.sh ]; then . /home/luis8h/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
    . "$HOME/.cargo/env"

    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

