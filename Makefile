.PHONY: help nvim zsh tmux scripts stow-setup stow-rm stow
help:
	$(error Choose a target, `nvim`, `zsh`, `tmux`, `scripts`, `all`)

all: nvim zsh tmux scripts

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

stow-setup: ./nvim/* ./zsh/zshrc ./tmux/tmux.conf ./scripts/*
	cd stow; ./stow-setup.sh; stow -t $(HOME) .

stow-rm:
	cd stow; stow -t $(HOME) -D .; git clean -x . -f
	
stow: ./nvim/* ./zsh/zshrc ./tmux/tmux.conf ./scripts/*
	cd stow; stow -t $(HOME) -D .; git clean -x . -f
	cd stow; ./stow-setup.sh; stow -t $(HOME) .

auto-import-plist: ./scripts/com.rcullen.auto-import.plist
	cp scripts/com.rcullen.auto-import.plist ~/Library/LaunchAgents/com.rcullen.auto-import.plist

