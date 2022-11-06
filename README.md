# Components

* `topic/path.zsh` - Will be loaded first and should mostly contain commands to setup `$PATH` or other basic functions
* `topic/completion.zsh` - Will be loaded last and is expected to setup autocomplete.
* `topic/bootstrap.sh` - Will be run as part of the setup script after Brew & Zsh are installed and setup..
* `topic/*.symlink`: Any file ending in `*.symlink` gets symlinked into `$HOME`. These get symlinked in when you run script/bootstrap.