export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Use GNU coreutils over BSD/MacOS provided
export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"

export LDFLAGS="-L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/include"
export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh