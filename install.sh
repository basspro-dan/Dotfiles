#!/bin/bash

## Remove .bashrc -> Link to Bashrc in Dotfiles
## Remove .tmux.conf -> Link to tmux.conf in Dotfiles
## Remove .vimrc -> Link to vimrc in Dotfiles
## Remove .gitconfig -> Link to gitcomfig in Cli-foo
## Linx ~/Dotfiles/Bin -> ~/bin folder and copy 

touch ~/.edgerc
echo ${{ secrets.DOTEDGERC }} > ~/.edgerc
cat ~/.edgerc
# aka_client_secret="client_secret="${{ aka_client_secret }} ; echo $aka_client_secret >> ~/.edgerc

#client_secret=$(env | grep 'client_secret' | gawk -F= '{print $3}') && echo "client_secret="$client_secret"=" >> ~/.edgerc
#host=$(env | grep 'host' | gawk -F= '{print $2}') && echo "host="$host >> ~/.edgerc
#access_token=$(env | grep 'access_token' | gawk -F= '{print $2}') && echo "access_token="$access_token >> ~/.edgerc
#client_token=$(env | grep 'client_token' | gawk -F= '{print $2}') && echo "client_token="$client_token >> ~/.edgerc

# Todo: Figure this out for .edgerc. 
# client_secret: ${{ secrets.client_secret }}
# Fix Git config local vars so I don't have to tell github who I am when pushing code up in a codespace. 

git clone https://github.com/basspro-dan/Dotfiles.git ~/Dotfiles 

[[ -f ~/.bashrc ]] && rm -f ~/.bashrc
ln -s ~/Dotfiles/DotFiles/bashrc ~/.bashrc

[[ -f ~/.tmux.conf ]] && rm -f ~/.tmux.conf
ln -s ~/Dotfiles/DotFiles/tmux.conf ~/.tmux.conf

[[ -f ~/.vimrc ]] && rm -f ~/.vimrc
ln -s ~/Dotfiles/DotFiles/vimrc ~/.vimrc

## We don't want to link the gitconfig as any changes on one host 
## will End up in the repo and change commit info on another host. 
[[ -f ~/.gitconfig ]] && rm -f ~/.gitconfig
cp ~/Dotfiles/DotFiles/gitconfig ~/.gitconfig


[[ -e ~/bin ]] && rm -rf ~/bin
ln -s ~/Dotfiles/Bin ~/Bin

source  ~/.bashrc

# curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
# pyenv install 3.11.5
# pyenv global 3.11.5 
pip3 install psutil




## Add Compile Function for cmatrix and nmon
## Add to Bashrc : Check for code changes to push everyting you login. 
