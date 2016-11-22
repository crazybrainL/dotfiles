#!/bin/bash

CURRENT_PATH=`pwd`
OS_PLATFORM=`uname`

# init vim and prezto module
git submodule init
git submodule update --recursive
./script/git_submodule_update.sh

# link all zsh files
if [[ -d "$CURRENT_PATH/zsh" ]]; then
    ln -s $CURRENT_PATH/zsh                         $HOME/.zshsetting
    ln -s $HOME/.zshsetting/prezto/runcoms/zlogin   $HOME/.zlogin      
    ln -s $HOME/.zshsetting/prezto/runcoms/zlogout  $HOME/.zlogout     
    ln -s $HOME/.zshsetting/prezto                  $HOME/.zprezto     
    ln -s $HOME/.zshsetting/zshrc/prezto/zpreztorc  $HOME/.zpreztorc   
    ln -s $HOME/.zshsetting/prezto/runcoms/zprofile $HOME/.zprofile    
    ln -s $HOME/.zshsetting/prezto/runcoms/zshenv   $HOME/.zshenv      
    ln -s $HOME/.zshsetting/zshrc/zshrc             $HOME/.zshrc       
    ln -s $HOME/.zshsetting/zshrc/prezto/prompt_yen3_setup  $HOME/.zprezto/modules/prompt/functions/prompt_yen3_setup
fi

# add subversion config file
ln -s $CURRENT_PATH/subversion $HOME/.subversion

# link script folder
ln -s $CURRENT_PATH/script $HOME/.personal_scripts

# download vim plugins and install
cd vim && ./install_vim.sh

# install tmux plugin manager
ln -s $CURRENT_PATH/tmux $HOME/.tmux

if [[ "$OS_PLATFORM" == 'Linux' ]]; then
    echo "Copy linux dotfiles"
    cp $CURRENT_PATH/gitconfig.linux       $CURRENT_PATH/gitconfig
    ln -s $CURRENT_PATH/gitconfig           $HOME/.gitconfig
    ln -s $CURRENT_PATH/cgdbrc              $HOME/.cgdbrc
    ln -s $CURRENT_PATH/htoprc              $HOME/.htoprc
    ln -s $CURRENT_PATH/screenrc            $HOME/.screenrc

    if [[ ! -d $HOME/.ssh ]]; then
        mkdir -p $HOME/.ssh
    fi
    ln -s $CURRENT_PATH/sshrc               $HOME/.ssh/rc

    ln -s $HOME/.tmux/tmux.conf             $HOME/.tmux.conf

elif [[ "$OS_PLATFORM" == 'Darwin' ]]; then
    echo "Copy Darwin dotfiles"
    cp $CURRENT_PATH/gitconfig.darwin       $CURRENT_PATH/gitconfig
    ln -s $CURRENT_PATH/gitconfig           $HOME/.gitconfig
    ln -s $CURRENT_PATH/cgdbrc              $HOME/.cgdbrc
    ln -s $CURRENT_PATH/htoprc              $HOME/.htoprc
    ln -s $CURRENT_PATH/screenrc            $HOME/.screenrc

    if [[ ! -d $HOME/.ssh ]]; then
        mkdir -p $HOME/.ssh
    fi
    ln -s $CURRENT_PATH/sshrc               $HOME/.ssh/rc

    ln -s $HOME/.tmux/tmux.conf             $HOME/.tmux.conf
fi

# config git information
git config --global user.name "whlin"
git config --global user.email "dds45612@gmail.com"
