.PHONY: help
help:
	$(info Choose a target, `nvim`, `zsh`, `add-nvim`, `add-zsh`)

.PHONY: nvim
nvim:
	cat nvim/init.vim > ~/.config/nvim/init.vim

.PHONY: zsh
zsh:
	cat zsh/.zshrc > ~/.zshrc

.PHONY: tmux
tmux:
	cat tmux/.tmux.conf > ~/.tmux.conf

.PHONY: add-nvim
add-nvim:
	cat ~/.config/nvim/init.vim > nvim/init.vim

.PHONY: add-zsh
add-zsh:
	cat ~/.zshrc > zsh/.zshrc

.PHONY: add-tmux
add-tmux:
	cat ~/.tmux.conf > tmux/.tmux.conf
