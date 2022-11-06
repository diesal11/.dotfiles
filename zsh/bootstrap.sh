DOTFILES_DIR="${DOTFILES_DIR:=${PWD}}"
ZSH="${HOME}/.oh-my-zsh"
ZSH_CUSTOM="${ZSH}/custom"

declare -A ZSH_CUSTOM_PLUGINS=(
	["plugins/F-Sy-H"]="https://github.com/z-shell/F-Sy-H"
	["plugins/zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
	["plugins/zsh-completions"]="https://github.com/zsh-users/zsh-completions"
	["plugins/fzf-tab"]="https://github.com/Aloxaf/fzf-tab"
	["plugins/you-should-use"]="https://github.com/MichaelAquilina/zsh-you-should-use"
	["plugins/zsh-nvm"]="https://github.com/lukechilds/zsh-nvm"
	["themes/powerlevel10k"]="https://github.com/romkatv/powerlevel10k"
)

# # Set ZSH as default shell
if [[ ! $SHELL == *zsh ]]; then
    echo "[zsh] Setting Zsh as the default shell"
    chsh -s $(which zsh)
fi

# # Install Oh My Zsh
OMZ="${HOME}/.oh-my-zsh"
if [[ -d "${OMZ}" ]]; then
    echo "[ohmyzsh] Already installed"
else
    echo "[ohmyzsh] Install"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
fi

echo "[ohmyzsh] Download plugins"
for path in "${!ZSH_CUSTOM_PLUGINS[@]}"; do
    if [[ ! -d "${ZSH_CUSTOM}/$path" ]]; then
        git clone --quiet "${ZSH_CUSTOM_PLUGINS[$path]}" "${ZSH_CUSTOM}/$path"
    fi
done

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

