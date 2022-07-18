.PHONY: help
help:
	$(error Choose a target, `nvim`, `zsh`, `add-nvim`, `add-zsh`)

.PHONY: nvim
nvim:
	cp -R nvim/* ~/.config/nvim/

.PHONY: zsh
zsh:
	cp zsh/.zshrc ~/.zshrc

.PHONY: tmux
tmux:
	cp tmux/.tmux.conf ~/.tmux.conf
