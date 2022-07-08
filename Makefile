.PHONY: help
help:
	$(info Choose a target, `nvim`, `zsh`, `add-nvim`, `add-zsh`)

nvim: nvim/init.vim
	cat nvim/init.vim > ~/.config/nvim/init.vim

zsh: zsh/.zshrc
	cat zsh/.zshrc | ~/.zshrc

add-nvim: ~/.config/nvim/init.vim
	cat ~/.config/nvim/init.vim > nvim/init.vim

add-zsh: ~/.zshrc
	cat ~/.zshrc | zsh/.zshrc
