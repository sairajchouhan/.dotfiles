export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

function t(){
  if tmux ls | cut -d ":" -f 1 | grep $(pwd | xargs basename | tr . -) > /dev/null; then
    tmux attach -t $(pwd | xargs basename | tr . -)
  else
    tmux new -s $(pwd | xargs basename | tr . -)
  fi
}


alias ":w"="echo \"bro what are you doing?\""

alias s="source ~/.zshrc"
alias n="nvim"
alias c="clear"
alias touch="retouch"



alias cs="cd ~/cs"
alias rm="trash"
alias lg="lazygit"

alias zsh="nvim ~/.zshrc"
alias cat="bat --paging=never"
alias gcm="git commit -m"


alias mine="cd ~/mine"
alias lazygit="CONFIG_DIR=$HOME/.config/lazygit lazygit"


neovim_command() {
  dir=$(find ~/mine ~/cs -d -mindepth 1 -maxdepth 1 | xargs basename | tr . _ | cut -d ":" -f 1 | fzf-tmux -p --reverse)
  # echo "$dir"
  # selected=$(tmux ls | cut -d ":" -f 1 | grep -w $dir)

  if tmux has-session -t "$dir" 2>/dev/null; then
    # Attach to the tmux session
    tmux switch -t "$dir"
  else
    # tmux new -s $(pwd | xargs basename | tr . -)
    tmux new-session -s "$dir"
    tmux switch-client -t "$dir"
  fi
}

zle -N neovim_command
bindkey '^F' neovim_command

# fzf-tmux -p --reverse

export EDITOR="nvim"

# nvm - node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/sairaj.chouhan/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# wrk
export PATH="/Users/sairaj.chouhan/mine/wrk:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#
# eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
# eval "$(play alias zsh)"

# bun completions
[ -s "/Users/sairaj.chouhan/.bun/_bun" ] && source "/Users/sairaj.chouhan/.bun/_bun"
export PATH="/Users/sairaj.chouhan/.deno/bin:$PATH"
