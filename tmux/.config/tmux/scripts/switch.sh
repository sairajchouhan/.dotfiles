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

# # command to find all dirs in my dirs
# find ~/cs ~/mine -maxdepth 1 -type d | 
#   sed 's/.*\///' | 
#   sed '/^$/d' | 
#   fzf-tmux -p
# --query "$current_session" --select-1

# current_session=$(tmux display-message -p '#S')
selected_session=$(tmux ls | cut -d ":" -f 1 | fzf-tmux -p)

if [[ -n "$selected_session"  ]]; then
  tmux switch-client -t "$selected_session"
fi

# tmux ls | cut -d ":" -f 1 | fzf-tmux -p | xargs tmux switch-client -t



# Check the exit status
exit_status=$?

# If fzf-tmux was interrupted (status 130), exit cleanly
if [ $exit_status -eq 130 ]; then
    exit 0
else
    exit $exit_status
fi
