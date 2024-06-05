#!/bin/bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


ln -s "$DIR/p10k.zsh" ~/.p10k.zsh
ln -s "$DIR/p10k.zsh" ~/p10k.zsh
ln -s "$DIR/bazel_magic.zsh" ~/bazel_magic.zsh
ln -s "$DIR/bazel_magic.bash" ~/bazel_magic.bash

mv ~/.zshrc ~/zshrc-old || ln -s "$DIR/zshrc" ~/.zshrc
g++ --std=c++17 bazel_fast_metadata.cc -o bazel_fast_metadata
ln -s "$DIR/bazel_fast_metadata" ~/bazel_fast_metadata

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

mkdir -p ~/.config/powerline-shell
ln -s "$DIR/powerline-shell" ~/.config/powerline-shell

ln -s "$DIR/zshrc" ~/.zshrc



