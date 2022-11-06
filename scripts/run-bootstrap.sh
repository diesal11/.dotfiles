for script in $(find . -name bootstrap.sh);
do
    echo $script
    zsh -c "$script"
done