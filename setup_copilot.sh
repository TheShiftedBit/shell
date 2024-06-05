#!/bin/bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ `uname` == "Darwin" ]]; then
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

else  # Not mac
	(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh jq
fi

"$BREW" install gh

gh auth login
gh extension install github/gh-copilot

echo "Example command explanation"
gh copilot explain "brew install bazel"

ln -s "$DIR/copilot_hook.zsh" ~/copilot_hook.zsh

