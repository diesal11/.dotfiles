DOTFILES_DIR="${DOTFILES_DIR:=${PWD}}"
ZSH="${HOME}/.oh-my-zsh"
ZSH_CUSTOM="${ZSH}/custom"

# Set ZSH as default shell
if [[ ! $SHELL == *zsh ]]; then
    echo "[zsh] Setting Zsh as the default shell"
    chsh -s $(which zsh)
fi

# Install Oh My Zsh
OMZ="${HOME}/.oh-my-zsh"
if [[ -d "${OMZ}" ]]; then
    echo "[ohmyzsh] Already installed"
    return
else
    echo "[ohmyzsh] Install"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
fi

echo "[ohmyzsh] Create symlinks"
ln -fs "${DOTFILES_DIR}/zsh/p10k/p10k.zsh" "${ZSH_CUSTOM}/p10k.zsh"
ln -fs "${DOTFILES_DIR}/zsh/aliases.zsh" "${ZSH_CUSTOM}/aliases.zsh"
ln -fs "${DOTFILES_DIR}/zsh/zshrc" "${HOME}/.zshrc"
ln -fs "${DOTFILES_DIR}/zsh/zshenv" "${HOME}/.zshenv"