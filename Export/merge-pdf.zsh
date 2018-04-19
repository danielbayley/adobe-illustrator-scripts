#! /bin/zsh -f
set -- ${(s , )PDF}
((#)) || exit

# Merge PDF pages
/System/Library/Automator/Combine*PDF*.action/*/*/join.py -o $@ &&
mv ${@:2} ~/.Trash

open -R $1 # Reveal PDF
