function tn --wraps='tmux new-session -A -t' --description 'alias tn=tmux new-session -A -t'
  tmux new-session -A -t $argv
        
end
