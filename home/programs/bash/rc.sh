# Disable Ctrl-S
#
# Source: https://unix.stackexchange.com/a/332793
stty -ixon

# Terminal prompt format.
PS1="\n\[\033[01;32m\]\u(\W) >\[\033[00m\] "

function expose_openai_key() {
    export OPENAI_API_KEY="$(gpg --decrypt $HOME/.openai-key.gpg)"
}
