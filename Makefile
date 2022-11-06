.DEFAULT_GOAL := all
.PHONY: all

bootstrap:
	@./scripts/run-bootstrap.sh

install-homebrew:
	@./homebrew/install.sh

install-zsh:
	@./zsh/install.sh

install: install-homebrew install-zsh bootstrap

all: install