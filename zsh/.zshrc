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

alias z="nvim ~/.zshrc"
alias s="source ~/.zshrc"
alias n="nvim ."


alias "??"="github-copilot-cli what-the-shell"
alias cs="cd ~/cs"
alias rm="trash"
alias lg="lazygit"

alias cat="bat --paging=never"
alias gcm="git commit -m"
alias dot="cd ~/.dotfiles"

alias mine="cd ~/mine"
alias mdkir="mkdir"
alias lazygit="CONFIG_DIR=$HOME/.config/lazygit lazygit"



export EDITOR="nvim"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/Users/sairaj.chouhan/.bun/_bun" ] && source "/Users/sairaj.chouhan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/sairaj.chouhan/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="/Users/sairaj.chouhan/mine/wrk:$PATH"
# pnpm end

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"
