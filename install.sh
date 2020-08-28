#!/usr/bin/env bash

# Write all files to $HOME
cat ./.bashrc > $HOME/.bashrc
cat ./.p10k.zsh > $HOME/.p10k.zsh
cat ./.profile > $HOME/.profile
cat ./.zshrc > $HOME/.zshrc

# Download oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh

# Download oh-my-zsh plugins
git clone https://github.com/favware/zsh-git-enhanced.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-git-enhanced --depth 1
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting --depth 1
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install Meslo NGF font
mkdir $HOME/.fonts
curl -sLo $HOME/.fonts/MesloLGS_NF_Regular.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -sLo $HOME/.fonts/MesloLGS_NF_Bold.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -sLo $HOME/.fonts/MesloLGS_NF_Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -sLo $HOME/.fonts/MesloLGS_NF_Bold_Italic.ttf https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf