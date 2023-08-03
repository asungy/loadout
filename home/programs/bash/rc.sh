# Disable Ctrl-S
#
# Source: https://unix.stackexchange.com/a/332793
stty -ixon

# Terminal prompt format.
PS1="\n\[\033[01;32m\]\u(\W) >\[\033[00m\] "
