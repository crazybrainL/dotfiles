#!/bin/bash

CLEANRC=all

help() {
  cat << EOF
usage: $0 [OPTIONS]
    -c      Clean dotfilers rc

    example:
        ./uninstall_dotfiles.sh or ./uninstall_dotfiles.sh -c all
        ./uninstall_dotfiles.sh -c zsh
        ./uninstall_dotfiles.sh -c vim
        ./uninstall_dotfiles.sh -c other
EOF
}

cleanZshrc (){
    FILES=(
        $HOME/.zsh
        $HOME/.oh-my-zsh
        $HOME/.zlogin      
        $HOME/.zlogout     
        $HOME/.zprezto     
        $HOME/.zpreztorc   
        $HOME/.zprofile    
        $HOME/.zshenv      
        $HOME/.zshrc       
        $HOME/.zshsetting
    )
    tLen=${#FILES[@]}

    for (( i=0; i<${tLen}; i++ ));
    do
      if [[ -e ${FILES[$i]} ]]; then
          echo "rm -rf ${FILES[$i]}"
          rm -rf ${FILES[$i]}
      else
          echo "${FILES[$i]} doesn't exist"
      fi
    done
}

cleanVimrc (){
    FILES=(
        $HOME/.vim
        $HOME/.vimrc
        $HOME/.gvimrc
        $HOME/.fzf
    )
    tLen=${#FILES[@]}

    ~/.fzf/uninstall
    for (( i=0; i<${tLen}; i++ ));
    do
      if [[ -e ${FILES[$i]} ]]; then
          echo "rm -rf ${FILES[$i]}"
          rm -rf ${FILES[$i]}
      else
          echo "${FILES[$i]} doesn't exist"
      fi
    done
}

cleanOther (){
    FILES=(
        $HOME/.subversion
        $HOME/.gitconfig
        $HOME/.tmux.conf
        $HOME/.cgdbrc
        $HOME/.htoprc
        $HOME/.screenrc
        $HOME/.ssh/rc
        $HOME/.ssh
        $HOME/.tmux
        $HOME/.personal_scripts
    )
    tLen=${#FILES[@]}

    for (( i=0; i<${tLen}; i++ ));
    do
      if [[ -e ${FILES[$i]} ]]; then
          echo "rm -rf ${FILES[$i]}"
          rm -rf ${FILES[$i]}
      else
          echo "${FILES[$i]} doesn't exist"
      fi
    done
}

while getopts c: opt
do
    case $opt in
        c) CLEANRC=$OPTARG;;
        \?) echo "Invalid option -$OPTARG" >&2;;
    esac
done

# remove the previous files

if [ "$CLEANRC" == zsh ]; then
    cleanZshrc
elif [ "$CLEANRC" == vim ]; then
    cleanVimrc
elif [ "$CLEANRC" == other ]; then
    cleanOther
else
    cleanZshrc
    cleanVimrc
    cleanOther
fi

