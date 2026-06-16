#! /usr/bin/env zsh
DOTFILES_DIR="${DOTFILES_DIR:=${PWD}}"

# Set ZSH as default shell
if [[ ! $SHELL == *zsh ]]; then
    echo "[zsh] Setting Zsh as the default shell"
    chsh -s $(which zsh)
fi

echo "[zsh] Create root symlinks"
# ln -is $DOTFILES_DIR/.config /Users/dyl/chmod
ln -is $DOTFILES_DIR/zsh/.zshrc /Users/dyl/.zshrc
ln -is $DOTFILES_DIR/git/.gitconfig /Users/dyl/.gitconfig
ln -is $DOTFILES_DIR/git/.gitignore /Users/dyl/.gitignore

ln -is $DOTFILES_DIR/nvim/ /Users/dyl/.config/
ln -is $DOTFILES_DIR/starship/starship.toml /Users/dyl/.config/starship.toml

ln -is $DOTFILES_DIR/tmux/.tmux.conf /Users/dyl/.tmux.conf
ln -is $DOTFILES_DIR/tmux/ /Users/dyl/.config/

# Install zsh plugins

# Syntax highlighting for Zsh
if [[ ! -d "$HOME/.f-sy-h" ]]; then
    echo "[zsh] Cloning F-Sy-H"
    git clone https://github.com/z-shell/F-Sy-H ~/.f-sy-h
fi

if [[ ! -d "$HOME/.fzf-tab" ]]; then
    echo "[zsh] Cloning fzf-tab"
    git clone https://github.com/Aloxaf/fzf-tab ~/.fzf-tab
fi
