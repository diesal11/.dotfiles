
if [[ $(uname) == "Darwin" ]]; then
    # Use Secretive Auth Soket
    export SSH_AUTH_SOCK=~/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
fi