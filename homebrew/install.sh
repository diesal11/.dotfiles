#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if [[ ! $(which brew) ]]; then
  echo "Installing Homebrew for you."

  # Install the correct homebrew for each OS type
  if [[ $(uname) = "Darwin" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  elif [[ "$(expr substr $(uname -s) 1 5)" = "Linux" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
fi

brew bundle install --file ./Brewfile