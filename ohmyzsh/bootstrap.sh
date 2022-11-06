ZSH="${HOME}/.oh-my-zsh"
ZSH_CUSTOM="${ZSH}/custom"

declare -A ZSH_CUSTOM_PLUGINS=(
	["plugins/F-Sy-H"]="https://github.com/z-shell/F-Sy-H"
	["plugins/zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
	["plugins/fzf-tab"]="https://github.com/Aloxaf/fzf-tab"
	["plugins/zsh-nvm"]="https://github.com/lukechilds/zsh-nvm"
	["themes/powerlevel10k"]="https://github.com/romkatv/powerlevel10k"
)

if [[ -d "${ZSH}" ]]; then
    echo "[ohmyzsh] Already installed"
    return
else
	echo "[ohmyzsh] Install"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
fi

info "[ohmyzsh] Install/Update plugins"
for path in "${!ZSH_CUSTOM_PLUGINS[@]}"; do
    if [[ ! -d "${ZSH_CUSTOM}/$path" ]]; then
        info "[ohmyzsh] Install $path"
        git clone --quiet "${ZSH_CUSTOM_PLUGINS[$path]}" "${ZSH_CUSTOM}/$path"
    else
        info "[ohmyzsh] Update $path"
        cd "${ZSH_CUSTOM}/$path" && git pull --quiet
    fi
done