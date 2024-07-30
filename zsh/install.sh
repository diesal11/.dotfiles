#! /usr/bin/env bash
DOTFILES_DIR="${DOTFILES_DIR:=${PWD}}"

# Set ZSH as default shell
if [[ ! $SHELL == *zsh ]]; then
    echo "[zsh] Setting Zsh as the default shell"
    chsh -s $(which zsh)
fi

echo "[zsh] Create symlinks"
for src in $(find -H "$DOTFILES_DIR" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
do
    dst="$HOME/.$(basename "${src%.*}")"
    dst_old="$HOME/.$(basename "${src%.*}").old"

    # TODO: Create oldfile app
    echo mv "$dst" "$dst_old"
    mv "$dst" "$dst_old"

    echo ln -s "$src" "$dst"
    ln -s "$src" "$dst"
done

if [[ ! -d "$HOME/.f-sy-h" ]]; then
    echo "[zsh] Cloning F-Sy-H"
    git clone https://github.com/z-shell/F-Sy-H ~/.f-sy-h
fi

if [[ ! -d "$HOME/.fzf-tab" ]]; then
    echo "[zsh] Cloning fzf-tab"
    git clone https://github.com/Aloxaf/fzf-tab ~/.fzf-tab
fi