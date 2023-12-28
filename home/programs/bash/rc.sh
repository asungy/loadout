# Disable Ctrl-S
#
# Source: https://unix.stackexchange.com/a/332793
stty -ixon

# Terminal prompt format.
PS1="\n\[\033[01;32m\]\u(\W) >\[\033[00m\] "

# Set OPENAI_API_KEY environment variable.
function expose_openai_key() {
    export OPENAI_API_KEY="$(gpg --decrypt $HOME/.openai-key.gpg)"
}

# Enable todoist/fzf integration.
function todoist_fzf() {
    mkdir -p /tmp/todoist

    local todoist_fzf_bash="/tmp/todoist/todoist_functions_fzf_bash.sh"

    if [ ! -e $todoist_fzf_bash ]; then
        curl -o $todoist_fzf_bash -JL \
            https://raw.githubusercontent.com/sachaos/todoist/master/todoist_functions_fzf_bash.sh
    fi

    source $todoist_fzf_bash
}

todoist_fzf
