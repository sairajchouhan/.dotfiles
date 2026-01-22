# ============================================================================
# ZSH Configuration - Optimized for Fast Startup
# ============================================================================
# Key optimizations:
# 1. Cached eval outputs (no subprocess spawning on every shell start)
# 2. Zinit turbo mode (deferred plugin loading)
# 3. mise handles Node.js (and other runtimes)
# 4. Instant prompt support
# ============================================================================

# Directory for caching shell init scripts
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "$ZSH_CACHE_DIR" ]] || mkdir -p "$ZSH_CACHE_DIR"

# ============================================================================
# FPATH for custom completions
# ============================================================================
if [[ ":$FPATH:" != *":/Users/sairaj.chouhan/.zsh/completions:"* ]]; then
  export FPATH="/Users/sairaj.chouhan/.zsh/completions:$FPATH"
fi

# ============================================================================
# Zinit Plugin Manager
# ============================================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if not present
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# ============================================================================
# Plugins - Using Turbo Mode for Deferred Loading
# ============================================================================
# These load AFTER the prompt appears, making shell startup feel instant

# Syntax highlighting - load after prompt (wait"0a" = 0ms after prompt, order a)
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
    zsh-users/zsh-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

# fzf-tab needs completions loaded first
zinit wait lucid light-mode for \
  Aloxaf/fzf-tab

# Git aliases from Oh-My-Zsh
zinit wait lucid for \
  OMZP::git

# ============================================================================
# Keybindings
# ============================================================================
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ============================================================================
# History Configuration
# ============================================================================
HISTSIZE=10000
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

# ============================================================================
# Completion Styling
# ============================================================================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ============================================================================
# Aliases
# ============================================================================
alias s="source ~/.zshrc"
alias n="nvim"
alias c="clear"
alias l="eza -l --icons --all"
alias d="lumen diff"

alias ls="eza"
alias cs="cd ~/cs"
alias rm="trash"
alias lg="lazygit"
alias pr="gh pr create -w"
alias kp="kill-port"
alias no="curl -s https://naas.isalman.dev/no | jq \".reason\""
alias ca="cursor-agent"

alias cat="bat --paging=never"
alias gcm="git commit -m"
alias gcp="git add -p"
alias say="fortune | cowsay"

alias touch="retouch"
alias mine="cd ~/mine"

alias lazygit="CONFIG_DIR=$HOME/.config/lazygit lazygit"
alias builder="bun run ~/cs/builder-cli/src/index.ts"

alias ":w"="echo \"bro what are you doing?\""
alias ":q"="exit"

alias cedit="nvim ~/.config/"
alias tedit="nvim ~/.config/tmux/tmux.conf"
alias zedit="nvim ~/.zshrc"
alias nedit="nvim ~/.config/nvim/"
alias shebang='echo "#!/usr/bin/env bash"'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# ============================================================================
# Functions
# ============================================================================
function t(){
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

function cds () {
  if [[ "$TMUX" ]]; then
    session=$(tmux display-message -p "#{session_path}")
    cd "$session"
  else
    echo "Runs only inside Tmux"
  fi
}

# ============================================================================
# Shell Integrations - CACHED for Speed
# ============================================================================
# Instead of running `eval "$(tool init zsh)"` every time (slow!),
# we cache the output and source it. Regenerate with `zsh-rebuild-cache`.

# Helper: Source cached init or generate if missing/stale
_source_cached_init() {
  local name="$1"
  local cmd="$2"
  local cache_file="$ZSH_CACHE_DIR/${name}.zsh"

  # Source cache if it exists
  if [[ -f "$cache_file" ]]; then
    source "$cache_file"
  else
    # Cache doesn't exist, generate it
    eval "$cmd" > "$cache_file" 2>/dev/null
    source "$cache_file"
  fi
}

# Rebuild all caches (run this after updating tools or if something breaks)
zsh-rebuild-cache() {
  echo "Rebuilding ZSH init caches..."
  rm -rf "$ZSH_CACHE_DIR"/*.zsh

  echo "  - mise..."
  [[ -x ~/.local/bin/mise ]] && ~/.local/bin/mise activate zsh > "$ZSH_CACHE_DIR/mise.zsh" 2>/dev/null

  echo "  - fzf..."
  command -v fzf >/dev/null && fzf --zsh > "$ZSH_CACHE_DIR/fzf.zsh" 2>/dev/null

  echo "  - zoxide..."
  command -v zoxide >/dev/null && zoxide init zsh > "$ZSH_CACHE_DIR/zoxide.zsh" 2>/dev/null

  echo "  - starship..."
  command -v starship >/dev/null && starship init zsh > "$ZSH_CACHE_DIR/starship.zsh" 2>/dev/null

  echo "Done! Restart your shell or run 'source ~/.zshrc'"
}

# Source cached inits (fast - just file reads, no subprocess spawning)
[[ -f "$ZSH_CACHE_DIR/mise.zsh" ]] && source "$ZSH_CACHE_DIR/mise.zsh"
[[ -f "$ZSH_CACHE_DIR/fzf.zsh" ]] && source "$ZSH_CACHE_DIR/fzf.zsh"
[[ -f "$ZSH_CACHE_DIR/zoxide.zsh" ]] && source "$ZSH_CACHE_DIR/zoxide.zsh"
# [[ -f "$ZSH_CACHE_DIR/starship.zsh" ]] && source "$ZSH_CACHE_DIR/starship.zsh"

# ============================================================================
# Environment Variables
# ============================================================================
export EDITOR="nvim"
export BAT_THEME="gruvbox-dark"
export EZA_CONFIG_DIR="$HOME/.config/eza"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#3c3836 \
  --color=bg:#282828 \
  --color=border:#504945 \
  --color=fg:#ebdbb2 \
  --color=gutter:#282828 \
  --color=header:#fe8019 \
  --color=hl+:#fabd2f \
  --color=hl:#d79921 \
  --color=info:#83a598 \
  --color=marker:#fb4934 \
  --color=pointer:#fb4934 \
  --color=prompt:#b8bb26 \
  --color=query:#ebdbb2:regular \
  --color=scrollbar:#504945 \
  --color=separator:#fe8019 \
  --color=spinner:#fb4934 \
"
export GOPATH=$HOME/go
export HUSKY=0
export HOMEBREW_NO_AUTO_UPDATE=1
export DISABLE_AUTOUPDATER=1

# ============================================================================
# PATH Configuration
# ============================================================================
typeset -U path  # Ensure unique entries in PATH

path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "$HOME/.bun/bin"
  "$HOME/.amp/bin"
  "$HOME/.opencode/bin"
  "$HOME/.antigravity/antigravity/bin"
  "$HOME/mine/bin"
  "$GOPATH/bin"
  "/Applications/WebStorm.app/Contents/MacOS"
  $path
)

# pnpm
export PNPM_HOME="/Users/sairaj.chouhan/Library/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && path=("$PNPM_HOME" $path)

# ============================================================================
# Bun Completions - Deferred
# ============================================================================
# Load bun completions in the background after prompt
if [[ -s "/Users/sairaj.chouhan/.bun/_bun" ]]; then
  zinit wait lucid for \
    id-as"bun-completions" \
    atload'source /Users/sairaj.chouhan/.bun/_bun' \
    zdharma-continuum/null
fi

# ============================================================================
# Source private environment variables
# ============================================================================
[[ -f ~/.envvars ]] && source ~/.envvars

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
# First-run: Generate caches if they don't exist
# ============================================================================
if [[ ! -f "$ZSH_CACHE_DIR/starship.zsh" ]]; then
  # First run - generate caches in background, use eval for this session
  (zsh-rebuild-cache &) 2>/dev/null

  # For this first session only, use eval (will be cached for next time)
  command -v starship >/dev/null && eval "$(starship init zsh)"
  [[ -x ~/.local/bin/mise ]] && eval "$(~/.local/bin/mise activate zsh)"
  command -v fzf >/dev/null && eval "$(fzf --zsh)"
  command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
fi

# opencode
export PATH=/Users/sairaj.chouhan/.opencode/bin:$PATH
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

