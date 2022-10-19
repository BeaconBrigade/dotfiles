.PHONY: help nvim zsh tmux scripts
help:
	$(error Choose a target, `nvim`, `zsh`, `tmux`, `scripts`)

nvim: ./nvim/*
	cp -R nvim/* ~/.config/nvim/

zsh: ./zsh/*
	cp zsh/zshrc ~/.zshrc
	cp zsh/p10k.zsh ~/.p10k.zsh
	cp zsh/inputrc ~/.inputrc

tmux: ./tmux/*
	cp tmux/tmux.conf ~/.tmux.conf

scripts: ./scripts/*
	cp scripts/* ~/.local/bin/
