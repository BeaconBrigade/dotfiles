.PHONY: help
help:
	$(info Choose a target, `nvim`, `zsh`, `add-nvim`, `add-zsh`)

.PHONY: nvim
nvim:
	cat nvim/init.vim > ~/.config/nvim/init.vim

.PHONY: zsh
zsh:
	cat zsh/.zshrc > ~/.zshrc

.PHONY: add-nvim
add-nvim:
	cat ~/.config/nvim/init.vim > nvim/init.vim

.PHONY: add-zsh
add-zsh:
	cat ~/.zshrc > zsh/.zshrc
