#!/bin/zsh

if [[ $1 == "" ]]; then 
    echo "No Rep Name"
else
    export GIT_DIR=/home/$USER/git
    export ORI_DIR=`pwd`
    export REP_NAME=$1
    export DIR_NAME=$REP_NAME.git

    cd $GIT_DIR 
    mkdir -p $DIR_NAME
    cd $DIR_NAME
    git --bare init
    sudo chown root:www-data -R . 
    sudo chmod g+rwx -R .
    cd $ORI_DIR 

    unset DIR_NAME
    unset REP_NAME
    unset GIT_DIR
    unset ORI_DIR
fi
