.PHONY: help
help:
	$(error Choose a target, `nvim`, `zsh`, `add-nvim`, `add-zsh`)

.PHONY: nvim
nvim:
	cp -R nvim/* ~/.config/nvim/

.PHONY: zsh
zsh:
	cat zsh/.zshrc > ~/.zshrc

.PHONY: tmux
tmux:
	cat tmux/.tmux.conf > ~/.tmux.conf
