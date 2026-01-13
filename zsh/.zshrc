# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/sairaj.chouhan/.zsh/completions:"* ]]; then export FPATH="/Users/sairaj.chouhan/.zsh/completions:$FPATH"; fi
# if [[ -z $TMUX ]]; then
#   tmux a
# fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# # Pure prompt - Gruvbox theme colors
# zmodload zsh/nearcolor
# zstyle :prompt:pure:path color '#d79921'                    # yellow
# zstyle :prompt:pure:git:branch color '#8ec07c'              # aqua
# zstyle :prompt:pure:prompt:success color '#b8bb26'         # green
# zstyle :prompt:pure:prompt:error color '#fb4934'           # red
# zstyle :prompt:pure:execution_time color '#fe8019'         # orange
# zstyle :prompt:pure:user color '#fabd2f'                    # bright yellow
# zstyle :prompt:pure:host color '#fabd2f'                    # bright yellow
# zstyle :prompt:pure:git:stash color '#d3869b'              # purple
# zstyle :prompt:pure:git:action color '#fe8019'             # orange

# zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit light sindresorhus/pure

zinit snippet OMZP::git


# Load completions with cache (faster startup)
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zinit cdreplay -q


bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward


# History
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


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'



# Aliases
alias s="source ~/.zshrc"
alias n="nvim"
alias c="clear"
alias l="eza -l --icons --all"
alias x="bunx"

alias ls="eza"
alias cs="cd ~/cs"
alias rm="trash"
alias lg="lazygit"
alias pr="gh pr create -w"
alias kp="kill-port"
alias no="curl -s https://naas.isalman.dev/no | jq ".reason""
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


# Shell integrations
eval "$(~/.local/bin/mise activate zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(fnm env --use-on-cd --version-file-strategy=recursive --shell zsh)"
eval "$(starship init zsh)"

# exports
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
export PATH=$PATH:$GOPATH/bin
# export COREPACK_ENABLE_AUTO_PIN=0


# pnpm
export PNPM_HOME="/Users/sairaj.chouhan/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/sairaj.chouhan/.bun/_bun" ] && source "/Users/sairaj.chouhan/.bun/_bun"


export PATH="/Users/sairaj.chouhan/.bun/bin:$PATH"
export PATH="$PATH:/Users/sairaj.chouhan/mine/bin"
# export PATH="$HOME/.govm/shim:$PATH"
export PATH="$PATH:/Applications/WebStorm.app/Contents/MacOS"
export PATH="$HOME/.local/bin:$PATH"
# export PURE_GIT_STASH_SYMBOL=""
export HUSKY=0
export HOMEBREW_NO_AUTO_UPDATE=1
# opencode
export PATH=/Users/sairaj.chouhan/.opencode/bin:$PATH
# Added by Antigravity
export PATH="/Users/sairaj.chouhan/.antigravity/antigravity/bin:$PATH"
export DISABLE_AUTOUPDATER=1 # auto updates claude code


source ~/.envvars


autoload -U add-zsh-hook

function add_node_modules_to_path() {
  if [[ -d "./node_modules/.bin" ]]; then
    if [[ ":$PATH:" != *":./node_modules/.bin:"* ]]; then
      export PATH="./node_modules/.bin:$PATH"
    fi
  fi
}

add-zsh-hook chpwd add_node_modules_to_path
add_node_modules_to_path

# Amp CLI
export PATH="/Users/sairaj.chouhan/.amp/bin:$PATH"
