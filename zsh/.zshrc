# if [[ -z $TMUX ]]; then
#   # if there is runway sesstion attach to it
#   # else create a new session with name "runway"
#   tmux a -t runway
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

zinit snippet OMZP::git


# Load completions
autoload -Uz compinit && compinit
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

alias ls="eza"
alias cs="cd ~/cs"
alias rm="trash"
alias lg="lazygit"
alias pr="gh pr create -w"

alias cat="bat --paging=never"
alias gcm="git commit -m"
alias say="fortune | cowsay"

alias touch="retouch"
alias mine="cd ~/mine"
alias lazygit="CONFIG_DIR=$HOME/.config/lazygit lazygit"

alias ":w"="echo \"bro what are you doing?\""
alias ".."="cd .."
alias "..."="cd .. && cd .."

alias cedit="nvim ~/.config/"
alias tedit="nvim ~/.config/tmux/tmux.conf"
alias zedit="nvim ~/.zshrc"
alias nedit="nvim ~/.config/nvim/"


function t(){
  session_name=$(basename $(pwd) | tr . -)
  if tmux ls 2> /dev/null | cut -d ":" -f 1 | grep "$session_name" > /dev/null; then
    if [[ $TMUX ]]; then
      tmux switch-client -t "$session_name" 
    else
      tmux attach -t "$session_name" 
    fi
  else
    tmux new -s "$session_name" -d
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
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"


# exports
export EDITOR="nvim"
# export BAT_THEME="Dracula"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#283457 \
  --color=bg:#000000 \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"


# pnpm
export PNPM_HOME="/Users/sairaj.chouhan/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
