#! /usr/bin/env bash
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
else
    echo "[ohmyzsh] Install"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
fi

download_plugin() {
    if [[ ! -d "${ZSH_CUSTOM}/$1" ]]; then
        echo "[ohmyzsh] Downloading $1"
        git clone --quiet "$2" "$ZSH_CUSTOM/$1"
    fi
}

echo "[ohmyzsh] Download plugins"
download_plugin plugins/F-Sy-H "https://github.com/z-shell/F-Sy-H"
download_plugin plugins/zsh-autosuggestions "https://github.com/zsh-users/zsh-autosuggestions"
download_plugin plugins/zsh-completions "https://github.com/zsh-users/zsh-completions"
download_plugin plugins/fzf-tab "https://github.com/Aloxaf/fzf-tab"
download_plugin plugins/you-should-use "https://github.com/MichaelAquilina/zsh-you-should-use"
download_plugin plugins/zsh-nvm "https://github.com/lukechilds/zsh-nvm"
download_plugin themes/powerlevel10k "https://github.com/romkatv/powerlevel10k"


echo "[zsh] Create symlinks"
for src in $(find -H "$DOTFILES_DIR" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
do
    dst="$HOME/.$(basename "${src%.*}")"
    dst_old="$HOME/.$(basename "${src%.*}").old"

    echo mv "$dst" "$dst_old"
    mv "$dst" "$dst_old"

    echo ln -s "$src" "$dst"
    ln -s "$src" "$dst"
done
