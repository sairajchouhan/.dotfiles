# ============================================================================
# Environment Variables
# ============================================================================
export EDITOR="nvim"
export EZA_CONFIG_DIR="$HOME/.config/eza"
export HUSKY=0
export HOMEBREW_NO_AUTO_UPDATE=1

# export DISABLE_AUTOUPDATER=1 # this is claude auto update
export GOPATH="$HOME/go"

[[ -f ~/.envvars ]] && source ~/.envvars

# ============================================================================
# PATH
# ============================================================================
typeset -U path

path=(
  /opt/homebrew/bin
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.bun/bin"
  "$HOME/.amp/bin"
  "$HOME/.opencode/bin"
  "$HOME/.orbstack/bin"
  "$HOME/.antigravity/antigravity/bin"
  "$HOME/mine/bin"
  "$GOPATH/bin"
  /Applications/WebStorm.app/Contents/MacOS
  /Applications/Obsidian.app/Contents/MacOS
  $path
)

# ============================================================================
# History
# ============================================================================
HISTSIZE=500000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt autocd
setopt nobeep

# ============================================================================
# Keybindings
# ============================================================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ============================================================================
# Startup-speed plugins (must come before anything that uses them)
# ============================================================================
# evalcache — caches `eval "$(tool init zsh)"` output to ~/.cache/evalcache/
if [[ ! -d ~/.local/share/evalcache ]]; then
  git clone --quiet https://github.com/mroth/evalcache ~/.local/share/evalcache
fi
source ~/.local/share/evalcache/evalcache.plugin.zsh

# zsh-defer — runs queued commands while zle is idle
if [[ ! -d ~/.local/share/zsh-defer ]]; then
  git clone --quiet https://github.com/romkatv/zsh-defer ~/.local/share/zsh-defer
fi
source ~/.local/share/zsh-defer/zsh-defer.plugin.zsh

# ============================================================================
# Completion
# ============================================================================
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then compinit; else compinit -C; fi
zsh-defer eval 'source <(jj util completion zsh 2>/dev/null)'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no

# ============================================================================
# Aliases
# ============================================================================
alias s="source ~/.zshrc"
alias n="nvim"
alias c="clear"
alias l="eza -l --icons --all"
alias d="hunk diff"

alias ls="eza"
alias cat="bat --paging=never"
alias rm="trash"
# alias touch="retouch"
# config.yml carries the dark theme; overlay light.yml when macOS is in light mode
lazygit() {
    local cfg="$HOME/.config/lazygit"
    local files="$cfg/config.yml"
    if ! defaults read -g AppleInterfaceStyle &>/dev/null; then
        files="$files,$cfg/light.yml"
    fi
    CONFIG_DIR="$cfg" LG_CONFIG_FILE="$files" command lazygit "$@"
}

alias cs="cd ~/cs"
alias lg="lazygit"
alias pr="gh pr create -w"
alias kp="kill-port"
alias no="curl -s https://naas.isalman.dev/no | jq \".reason\""
alias ca="cursor-agent"
alias gcm="git commit -m"
alias gcp="git add -p"
alias cwd="pwd | pbcopy"
alias say="fortune | cowsay"
alias mine="cd ~/mine"
alias builder="bun run ~/cs/builder-cli/src/index.ts"
alias cedit="nvim ~/.config/"
alias tedit="nvim ~/.config/tmux/tmux.conf"
alias zedit="nvim ~/.zshrc"
alias nedit="nvim ~/.config/nvim/"
alias shebang='echo "#!/usr/bin/env bash"'
alias cct='claude --channels plugin:telegram@claude-plugins-official'
alias cc='claude'


alias ":w"="echo \"bro what are you doing?\""
alias ":q"="exit"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# ============================================================================
# Functions
# ============================================================================
t() {
  local session_name=$(basename "$PWD" | tr '.' '-')
  if ! tmux has-session -t="$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name"
  fi
  if [ -z "$TMUX" ]; then
    tmux attach-session -t "$session_name"
  else
    tmux switch-client -t "$session_name"
  fi
}

cds() {
  if [[ "$TMUX" ]]; then
    cd "$(tmux display-message -p '#{session_path}')"
  else
    echo "Runs only inside Tmux"
  fi
}

take() {
  mkdir -p "$1" && cd "$1"
}

q() {
  pi -p "$@"
}

# ============================================================================
# Auto-add node_modules/.bin to PATH
# ============================================================================
autoload -U add-zsh-hook

add_node_modules_to_path() {
  if [[ -d "./node_modules/.bin" ]]; then
    if [[ ":$PATH:" != *":./node_modules/.bin:"* ]]; then
      export PATH="./node_modules/.bin:$PATH"
    fi
  fi
}

add-zsh-hook chpwd add_node_modules_to_path
add_node_modules_to_path

# ============================================================================
# gh account by directory: work (~/cs/**) -> sairaj-cs, else personal
# Exported so child processes (jj's `gh pr` alias, scripts) inherit it too.
# ============================================================================
gh_account_by_dir() {
  case "$PWD/" in
    "$HOME"/cs/*) export GH_CONFIG_DIR="$HOME/.config/gh-cs" ;;
    *)            unset GH_CONFIG_DIR ;;
  esac
}

add-zsh-hook chpwd gh_account_by_dir
gh_account_by_dir

# ============================================================================
# Shell Integrations
# ============================================================================
[[ -x ~/.local/bin/mise ]]    && _evalcache ~/.local/bin/mise activate zsh
command -v starship >/dev/null && _evalcache starship init zsh
command -v fzf      >/dev/null && zsh-defer eval 'eval "$(fzf --zsh)"'
command -v zoxide   >/dev/null && zsh-defer eval 'eval "$(zoxide init zsh)"'

# pi() {
#   mise x node@24.13.1 -- command pi "$@"
# }

ghui() {
  mise x node@24.13.1 -- command ghui "$@"
}

# fzf-tab — fuzzy tab completion (must be last to avoid overrides)
if [[ ! -d ~/.local/share/fzf-tab ]]; then
  git clone --quiet https://github.com/Aloxaf/fzf-tab ~/.local/share/fzf-tab
fi
source ~/.local/share/fzf-tab/fzf-tab.plugin.zsh

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# fast-syntax-highlighting — highlights commands as you type (deferred)
if [[ ! -d ~/.local/share/fast-syntax-highlighting ]]; then
  git clone --quiet https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.local/share/fast-syntax-highlighting
fi
zsh-defer source ~/.local/share/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# zsh-autosuggestions — ghost-text completions from history (deferred)
if [[ ! -d ~/.local/share/zsh-autosuggestions ]]; then
  git clone --quiet https://github.com/zsh-users/zsh-autosuggestions ~/.local/share/zsh-autosuggestions
fi
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
zsh-defer source ~/.local/share/zsh-autosuggestions/zsh-autosuggestions.zsh



# pnpm
export PNPM_HOME="/Users/sairaj.chouhan/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
