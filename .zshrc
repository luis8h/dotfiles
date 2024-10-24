# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH_THEME="powerlevel10k/powerlevel10k"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode

ZVM_INIT_MODE=sourcing # very important fix for zsh vi mode working with tmux (resurect)

zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

## using ohmyposh (when enabling everything with p10k should be removed)
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
# eval "$(oh-my-posh init zsh)"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# exports
export PATH="$PATH:/home/elliott/Library/flutter/bin"
export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"
export PATH="$PATH:$HOME/go/bin"
export LD_LIBRARY_PATH=/usr/local/lib

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

source $HOME/.profile
source $HOME/.config/tmuxinator/tmuxinator.zsh


# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"


## fuzzy switch directory
cda() {
    local dir
    dir=$(fd --hidden --type d . | fzf --height 40% --layout=reverse --preview 'tree -C -L 1 {} | head -200') && cd "$dir"
}
cdf() {
    local dir
    dir=$(fd --type d . | fzf --height 40% --layout=reverse --preview 'tree -C -L 1 {} | head -200') && cd "$dir"
}
cdh() {
    local dir
    dir=$(fd --type d . ~ | fzf --height 40% --layout=reverse --preview 'tree -C -L 1 {} | head -200') && cd "$dir"
}
cdha() {
    local dir
    dir=$(fd --hidden --type d . ~ | fzf --height 40% --layout=reverse --preview 'tree -C -L 1 {} | head -200') && cd "$dir"
}
cdr() {
    local dir
    dir=$(fd --type d . ~ | fzf --height 40% --layout=reverse --preview 'tree -C -L 1 {} | head -200') && cd "$dir"
}
cdra() {
    local dir
    dir=$(fd --hidden --type d . ~ | fzf --height 40% --layout=reverse --preview 'tree -C -L 1 {} | head -200') && cd "$dir"
}


# Aliases
alias ls='ls --color'
alias vim='nvim'

alias sudo='sudo '
alias vimk="nvim ~/kbase/"
alias dco="docker-compose"
alias gico="git commit -m"
alias giad="git add ."
alias gipu="git push"
alias gitmp="sh ~/.scripts/tmp-commit.sh"
alias l="ls --color -a -l"

alias ..='cd ..'
alias cd..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'


## fuzzy find commands in history
if command -v fzf > /dev/null; then
  bindkey '^R' fzf-history-widget
fi

fzf-history-widget() {
  BUFFER=$(fc -l -n -r 1 | fzf)  # Use '1' to include the full history
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N fzf-history-widget

# Define the ZLE widgets for line movement
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Bind keys for line movement
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

if [ -e /home/luis8h/.nix-profile/etc/profile.d/nix.sh ]; then . /home/luis8h/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
