.DEFAULT_GOAL := all
.PHONY: all

bootstrap:
    @find . -name bootstrap.sh | while read installer ; do zsh -c "${installer}" ; done

install-brewfile:
    @./homebrew/install.sh

install-homebrew:
    @./homebrew/install.sh

install-zsh:
    @./zsh/setup.sh

install: install-homebrew install-zsh install-brewfile bootstrap

all: install