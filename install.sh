#!/bin/bash

echo "🔗 Setting up dotfiles..."

# Symlink shell configs
ln -sf ~/dotfiles/shell/.zshrc ~/.zshrc
ln -sf ~/dotfiles/shell/.zprofile ~/.zprofile
#ln -sf ~/dotfiles/shell/bashrc ~/.bashrc
ln -sf ~/dotfiles/shell/.aliases ~/.aliases

# Symlink tmux & screen configs
ln -sf ~/dotfiles/.config/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/screen/.screenrc ~/.screenrc

# Symlink Git config
myComputer=$(uname -n)

if [[ $myComputer == "JWTN2K-29C15FB2" ]]
then
    ln -sf ~/dotfiles/git/macbook-pro-kyndryl/.gitconfig ~/.gitconfig
else
    echo ".gitconfig file - This is not the Macbook Pro at Kyndryl. Doing nothing here"
fi

# Symlink .config directory apps
#ln -sf ~/dotfiles.config ~/.config
mkdir -p ~/.config
#ln -sf ~/dotfiles/config/* ~/.config/
for configDIR in $(/bin/ls -1 ~/dotfiles/.config)
do
    ln -sf ~/dotfiles/.config/$configDIR ~/.config
done

# Restart shell to apply changes
exec $SHELL -l
