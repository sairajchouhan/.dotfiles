export ZSH="$HOME/.oh-my-zsh"

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


alias cs="cd ~/cs"
alias rm="trash"
alias lg="lazygit"
alias gp="git push && gh browse"
alias pr="gh pr view -w"

alias zsh="nvim ~/.zshrc"
alias cat="bat --paging=never"
alias gcm="git commit -m"


alias mine="cd ~/mine"
alias lazygit="CONFIG_DIR=$HOME/.config/lazygit lazygit"


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

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(github-copilot-cli alias -- "$0")"
# eval "$(play alias zsh)"

# bun completions
[ -s "/Users/sairaj.chouhan/.bun/_bun" ] && source "/Users/sairaj.chouhan/.bun/_bun"
