#!/bin/zsh

if ! [ -x "$(command -v brew)" ]; then
    if ! [ -z "$YES" ] || read -q "choice?Homebrew not installed or not on path. Install? (Press Y/y): "; then
        echo "Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
        if ! [ -x "$(command -v brew)" ]; then
            echo "Homebrew not on path. Using a default."
            if [[ "$(arch)" == "arm64" ]]; then
                BREW="/opt/homebrew/bin/brew"
            else
                BREW="/usr/local/bin/brew"
            fi
        else
            BREW="brew"
        fi
    
    else
        exit 1
    fi
else
    BREW="brew"
fi

"$BREW" install gh
"$BREW" install jq

gh auth login
gh extension install github/gh-copilot

echo "Example command explanation"
gh copilot explain "brew install bazel"

ln -s "$DIR/copilot_hook.zsh" ~/copilot_hook.zsh

