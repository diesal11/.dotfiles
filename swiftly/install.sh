# Check for Swiftly
if [[ ! $(which swiftly) ]]; then
  echo "Installing Swiftly."

  # Install the correct homebrew for each OS type
  if [[ $(uname) = "Darwin" ]]; then
    curl -O https://download.swift.org/swiftly/darwin/swiftly.pkg && \
        installer -pkg swiftly.pkg -target CurrentUserHomeDirectory && \
        ~/.swiftly/bin/swiftly init --quiet-shell-followup
  elif [[ "$(expr substr $(uname -s) 1 5)" = "Linux" ]]; then
    curl -O https://download.swift.org/swiftly/linux/swiftly-$(uname -m).tar.gz && \
        tar zxf swiftly-$(uname -m).tar.gz && \
        ./swiftly init --quiet-shell-followup && \
        . "${SWIFTLY_HOME_DIR:-$HOME/.local/share/swiftly}/env.sh" && \
        hash -r
  fi

  echo "Generating Swiftly completion file"
qfi
