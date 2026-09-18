#!/bin/sh

set -ex
export PATH=/run/current-system/sw/bin

multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"
cmd="yazi"
termcmd="${TERMCMD:-wezterm start --always-new-process --class yazi-picker}"

if [ "$save" = "1" ]; then
    set -- --chooser-file="$out" "$path"
elif [ "$directory" = "1" ]; then
    set -- --chooser-file="$out" --cwd-file="$out" "$path"
elif [ "$multiple" = "1" ]; then
    set -- --chooser-file="$out" "$path"
else
    set -- --chooser-file="$out" "$path"
fi

command="$termcmd $cmd"
for arg in "$@"; do
    escaped=$(printf "%s" "$arg")
    command="$command \"$escaped\""
done

exec $termcmd $cmd "$@"
