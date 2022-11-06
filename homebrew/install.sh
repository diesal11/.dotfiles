#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

DOTFILES="${DOTFILES_DIR:=${PWD}}"

# Check for Homebrew
if [[ ! $(which brew) ]]; then
  echo "Installing Homebrew for you."

  # Install the correct homebrew for each OS type
  if [[ $(uname) = "Darwin" ]]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  elif [[ "$(expr substr $(uname -s) 1 5)" = "Linux" ]]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
fi

export PATH="/opt/homebrew/bin:$PATH"

brew bundle install --file $DOTFILES/homebrew/Brewfile