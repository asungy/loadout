# Disable Ctrl-S
#
# Source: https://unix.stackexchange.com/a/332793
stty -ixon

# Set OPENAI_API_KEY environment variable.
function expose_openai_key() {
    export OPENAI_API_KEY="$(gpg --decrypt $HOME/.openai-key.gpg)"
}
