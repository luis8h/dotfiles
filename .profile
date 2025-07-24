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


# Only if OS is not macOS
if [ "$(uname)" != "Darwin" ]; then
    # Optional: setxkbmap -layout us -option caps:escape

    # Load Nix environment if available
    if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/nix.sh"
    fi

    # Load Rust (Cargo) environment if available
    if [ -f "$HOME/.cargo/env" ]; then
        . "$HOME/.cargo/env"
    fi

    # Load Linuxbrew environment if it's installed
    if [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
fi
