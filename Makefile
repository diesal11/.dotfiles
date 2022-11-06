.DEFAULT_GOAL := all
.PHONY: all

bootstrap:
	@./scripts/bootstrap.sh

install-homebrew:
	@./homebrew/install.sh

install-zsh:
	@./zsh/setup.sh

install: install-homebrew install-zsh bootstrap

all: install