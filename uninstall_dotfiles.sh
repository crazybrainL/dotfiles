#!/bin/bash

CURRENT_PATH=`pwd`
OS_PLATFORM=`uname`

# remove the previous files
rm -rf $HOME/.zsh
rm -rf $HOME/.oh-my-zsh
rm -rf $HOME/.zlogin      
rm -rf $HOME/.zlogout     
rm -rf $HOME/.zprezto     
rm -rf $HOME/.zpreztorc   
rm -rf $HOME/.zprofile    
rm -rf $HOME/.zshenv      
rm -rf $HOME/.zshrc       
rm -rf $HOME/.zshsetting
rm -rf $HOME/.personal_scripts

rm -rf $HOME/.subversion
rm -rf $HOME/.gitconfig
rm -rf $HOME/.tmux.conf
rm -rf $HOME/.cgdbrc
rm -rf $HOME/.htoprc
rm -rf $HOME/.screenrc
rm -rf $HOME/.ssh/rc
rm -rf $HOME/.ssh
rm -rf $HOME/.tmux

rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
rm -rf $HOME/.gvimrc
