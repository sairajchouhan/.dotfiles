#!/bin/bash

# --color=bg:#16161e \
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --border \
  --cycle
"

cleanup_and_exit() {
    exit 0
}

trap cleanup_and_exit SIGINT



# finds all the dirs in ~/cs, ~/mine
# if there is a tmux session attach to it
# else create and attach to it

selected=$(
  find ~/cs ~/mine -mindepth 1 -maxdepth 1 -type d | 
    xargs basename | 
    fzf-tmux -p
)

if [[ -z $selected ]]; then
  exit 0;
fi

already_present=$(tmux ls | cut -d ":" -f 1 | grep "$selected")


if [[ -n "$already_present" ]]; then
  tmux switch-client -t "$already_present"
else
  tmux new -s "$selected" -d
  tmux switch-client -t "$selected"
fi


