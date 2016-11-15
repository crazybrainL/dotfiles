#!/bin/bash

CURRENT_PATH=`pwd`
OS_PLATFORM=`uname`

# init vim and prezto module
git submodule init
git submodule update --recursive
./script/git_submodule_update.sh

# remove the previous files
rm -rf $HOME/.zlogin      
rm -rf $HOME/.zlogout     
rm -rf $HOME/.zprezto     
rm -rf $HOME/.zpreztorc   
rm -rf $HOME/.zprofile    
rm -rf $HOME/.zshenv      
rm -rf $HOME/.zshrc       
rm -rf $HOME/.zshsetting
rm -rf $HOME/.personal_scripts

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
if [[ ! -d "$HOME/.subversion" ]]; then
    mkdir -p $HOME/.subversion
    cp $CURRENT_PATH/svn_config $HOME/.subversion/config
fi

# link script folder
ln -s $CURRENT_PATH/script $HOME/.personal_scripts

# download vim plugins and install
cd vim && ./install_vim.sh

if [[ "$OS_PLATFORM" == 'Linux' ]]; then
    echo "Copy linux dotfiles"
    cp $CURRENT_PATH/gitconfig.linux    $HOME/.gitconfig
    cp $CURRENT_PATH/tmux.conf          $HOME/.tmux.conf
    cp $CURRENT_PATH/cgdbrc             $HOME/.cgdbrc
    cp $CURRENT_PATH/htoprc             $HOME/.htoprc
    cp $CURRENT_PATH/screenrc           $HOME/.screenrc

    mkdir -p $HOME/.ssh
    cp $CURRENT_PATH/sshrc              $HOME/.ssh/rc

elif [[ "$OS_PLATFORM" == 'Darwin' ]]; then
    echo "Copy Darwin dotfiles"
    cp $CURRENT_PATH/gitconfig.darwin   $HOME/.gitconfig
    cp $CURRENT_PATH/tmux.conf          $HOME/.tmux.conf
    cp $CURRENT_PATH/cgdbrc             $HOME/.cgdbrc
    cp $CURRENT_PATH/htoprc             $HOME/.htoprc
    cp $CURRENT_PATH/screenrc           $HOME/.screenrc

    mkdir -p $HOME/.ssh
    cp $CURRENT_PATH/sshrc              $HOME/.ssh/rc
fi

# install tmux plugin manager
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

# config git information
git config --global user.name "whlin"
git config --global user.email "dds45612@gmail.com"
