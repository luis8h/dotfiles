export ZSH=~/.oh-my-zsh

source $ZSH/oh-my-zsh.sh

### dreams of code

# Set the GPG_TTY to be the same as the TTY, either via the env var
# or via the tty command.
if [ -n "$TTY" ]; then
  export GPG_TTY=$(tty)
else
  export GPG_TTY="$TTY"
fi

# SSH_AUTH_SOCK set to GPG to enable using gpgagent as the ssh agent.
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="${PATH}:/usr/local/bin:/usr/bin"

autoload -Uz compinit && compinit

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light ohmyzsh/ohmyzsh
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit snippet OMZP::git
# zinit snippet OMZP::sudo
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
# zinit snippet OMZP::rust
zinit snippet OMZP::command-not-found

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light jeffreytse/zsh-vi-mode

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

source $HOME/.profile
source $HOME/.config/tmuxinator/tmuxinator.zsh

setopt auto_cd

#export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="$PATH:/home/elliott/Library/flutter/bin"

alias sudo='sudo '
export LD_LIBRARY_PATH=/usr/local/lib

# Completions

# source <(doctl completion zsh)

# source <(kubectl completion zsh)

# P10k customizations
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Fix for password store
export PASSWORD_STORE_GPG_OPTS='--no-throw-keyids'

export NVM_DIR="$HOME/.nvm"                            # You can change this if you want.
export NVM_SOURCE="/usr/share/nvm"                     # The AUR package installs it to here.
[ -s "$NVM_SOURCE/nvm.sh" ] && . "$NVM_SOURCE/nvm.sh"  # Load N

bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

[ -s "/home/elliott/.svm/svm.sh" ] && source "/home/elliott/.svm/svm.sh"

# Capslock command
alias capslock="sudo killall -USR1 caps2esc"

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi


### custom

## not relevant any more because of vim mode
# bindkey '^l' autosuggest-accept

### aliases
alias vim=nvim
alias vimk="nvim ~/kbase/"
alias dco="docker-compose"
alias gico="git commit -m"
alias giad="git add ."
alias gipu="git push"
alias gitmp="sh ~/.scripts/tmp-commit.sh"

### plugins
# source /home/luis8h/.zsh-vi-mode/zsh-vi-mode.plugin.zsh


# Load Angular CLI autocompletion.
# this line made problems when ng is not installed
# source <(ng completion script)


# zoxide initialization
eval "$(zoxide init --cmd cd zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
