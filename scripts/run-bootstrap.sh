for script in $(find . -name bootstrap.sh);
do
    zsh -c "$script"
done
