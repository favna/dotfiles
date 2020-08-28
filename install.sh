#!/usr/bin/env bash

# Write all files to ~/
cat ./.bashrc > ~/.bashrc
cat ./.p10k.zsh > ~/.p10k.zsh
cat ./.profile > ~/.profile
cat ./.zshrc > ~/.zshrc

# Download oh-my-zsh
# git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# Download oh-my-zsh plugins and theme
git clone https://github.com/favware/zsh-git-enhanced.git ~/.oh-my-zsh/custom/plugins/zsh-git-enhanced --depth 1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting --depth 1
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions --depth 1
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k --depth=1

# Install Meslo NGF font
mkdir ~/.fonts
curl -sLo ~/.fonts/MesloLGS\ NF\ Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -sLo ~/.fonts/MesloLGS\ NF\ Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -sLo ~/.fonts/MesloLGS\ NF\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -sLo ~/.fonts/MesloLGS\ NF\ Bold\ Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf