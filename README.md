# Matt's Home Modules

To initialize:

```sh
# ... https://brew.sh/ and then ...
brew install stow vim git zsh tmux
pip3 install neovim
git clone git@github.com:jvz/matt.git
cd matt
stow git
./manage.sh init
stow external
stow zsh
stow vim
vim -c :PlugInstall
```

To update:

```sh
./manage.sh pull
```
