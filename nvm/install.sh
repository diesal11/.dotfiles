# Check for Darwin & ~/.nvm
if [[ $(uname) == "Darwin" ]]; then
    if [[ ! -d "$HOME/.nvm" ]]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    fi
fi