.DEFAULT_GOAL := help
.PHONY: help

help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install-git      Install Git"
	@echo "  install-nvm      Install Nvm"
	@echo "  install-homebrew Install Homebrew"
	@echo "  install-tmux     Install Tmux"
	@echo "  install-zsh      Install Zsh"
	@echo "  install          Install all"

install-git:
	@./git/install.sh

install-nvm:
	@./nvm/install.sh

install-homebrew:
	@./homebrew/install.sh

install-swiftly:
	@./tmux/install.sh

install-tmux:
	@./tmux/install.sh

install-zsh:
	@./zsh/install.sh

install: install-git install-homebrew install-nvm install-tmux install-zsh
