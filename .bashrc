# copy env from Dockerfile
export EDITOR=emacs

test -z "$TMUX" && (tmux attach || tmux new-session)
