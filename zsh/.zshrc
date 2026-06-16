# Some shortcuts
export DOTFILES="${HOME}/.dotfiles"

# all of our zsh files (don't include bootstrap completion or path.zsh)
typeset -U config_files
config_files=($DOTFILES/**/*.zsh)

# Load the path files
for file in ${(M)config_files:#*/path.zsh}
do
  source $file
done

# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
    source $file
done

# initialize autocomplete here, otherwise functions won't be loaded
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

# bun completions
[ -s "/Users/dyl/.bun/_bun" ] && source "/Users/dyl/.bun/_bun"

# opencode
export PATH=/Users/dyl/.opencode/bin:$PATH

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/dyl/.lmstudio/bin"
# End of LM Studio CLI section

