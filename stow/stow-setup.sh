#!/bin/bash

mkdir -p .config/nvim .local/bin
cp -r ../nvim/* .config/nvim
cp -r ../scripts/* .local/bin
cp ../zsh/zshrc .zshrc
cp ../zsh/inputrc .inputrc
cp ../tmux/tmux.conf .tmux.conf
