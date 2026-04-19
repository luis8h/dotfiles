OS="$(uname -s | tr '[:upper:]' '[:lower:]')"

# ─── Instant prompt (must stay near top) ───────────────────────────────────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ─── Zinit bootstrap ───────────────────────────────────────────────────────────
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# ─── Plugins ───────────────────────────────────────────────────────────────────
zinit ice depth=1; zinit light romkatv/powerlevel10k

ZVM_INIT_MODE=sourcing  # must be set before loading zsh-vi-mode (fixes tmux-resurrect)
zinit light jeffreytse/zsh-vi-mode

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit load  zsh-users/zsh-history-substring-search

zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ─── Completion ────────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit
zinit cdreplay -q

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*'         fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ─── History ───────────────────────────────────────────────────────────────────
HISTSIZE=500000000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# ─── Exports ───────────────────────────────────────────────────────────────────
export PATH="$PATH:$HOME/.local/share/bob/nvim-bin"
export PATH="$PATH:$HOME/go/bin"
export LD_LIBRARY_PATH=/usr/local/lib

export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"   # man pages in nvim with syntax highlighting

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

source $HOME/.profile
source $HOME/.config/tmuxinator/tmuxinator.zsh

# ─── Aliases ───────────────────────────────────────────────────────────────────
alias c="clear"
alias vim='nvim'
alias sudo='sudo '
alias vimk='nvim ~/kbase/'
alias dco='docker-compose'
alias ls='lsd'
alias l='lsd -lh'
alias la='lsd -lah'

alias ..='cd ..'
alias cd..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'

# ─── Functions ─────────────────────────────────────────────────────────────────
# Fuzzy cd from current dir — hidden files included
cda() {
  local dir
  dir=$(fd --hidden --type d . | fzf --height 40% --layout=reverse --preview 'tree -C -L 1 {} | head -200') && cd "$dir"
}
# Fuzzy cd from current dir — no hidden files
cdf() {
  local dir
  dir=$(fd --type d . | fzf --height 40% --layout=reverse --preview 'tree -C -L 1 {} | head -200') && cd "$dir"
}
# Fuzzy cd from home — no hidden files
cdh() {
  local dir
  dir=$(fd --type d . ~ | fzf --height 40% --layout=reverse --preview 'tree -C -L 1 {} | head -200') && cd "$dir"
}
# Fuzzy cd from home — hidden files included
cdha() {
  local dir
  dir=$(fd --hidden --type d . ~ | fzf --height 40% --layout=reverse --preview 'tree -C -L 1 {} | head -200') && cd "$dir"
}

# ─── Keybindings ───────────────────────────────────────────────────────────────
# ctrl+backspace: delete word backwards
bindkey -M viins '^[^?' backward-kill-word

# ctrl+delete: delete word forwards (escape code differs by OS)
if [ "$OS" = "darwin" ]; then
  bindkey -M viins '^[[3;3~' kill-word
  bindkey -M vicmd '^[[3;3~' kill-word
elif [ "$OS" = "linux" ]; then
  bindkey -M viins '^[[3;5~' kill-word
  bindkey -M vicmd '^[[3;5~' kill-word
fi

# History substring search (page up/down)
bindkey "^[[5~" history-substring-search-up
bindkey "^[[6~" history-substring-search-down
HISTORY_SUBSTRING_SEARCH_FUZZY=1

# Beginning-of-line history navigation (ctrl+p/n)
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

# ─── Integrations ──────────────────────────────────────────────────────────────
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# jj — dynamic completions (includes bookmark names)
source <(COMPLETE=zsh jj)

# keychain SSH agent
# eval $(keychain --eval --noask --quiet ~/.ssh/id_ed25519)

# jenv
if [ -d "$HOME/.jenv" ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

# bun completions
[ -s "/home/luis8h/.bun/_bun" ] && source "/home/luis8h/.bun/_bun"

. "$HOME/.local/share/../bin/env"
