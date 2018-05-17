#!/usr/bin/env bash

# check if command exists
check_dependency() {
    cmd=$1
    which $cmd &> /dev/null
    rc=$?
    if [[ $rc != 0 ]]; then
        echo "Error) $cmd: command not found" 
        exit $rc
    fi
}

# do git clone after backup existing git repo
git_clone() {
    repo=$1
    path=$2

    # backup existing directory 
    if [[ -e $path ]]; then
        echo "$path already exists"
        mv $path ${path}.old
    fi

    git clone $repo $path
}

copy() {
    src=$1
    dst=$2

    if [[ -e $dst ]]; then
        echo "$dst already exists"
        mv $dst ${dst}.old
    fi

    cp -rf $src $dst
}

# dependencies
dependency="git";

# check dependencies
for dep in $dependency; do
    check_dependency $dep
done

git_clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
copy ./vimrc $HOME/.vimrc

#pathogen installation 
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# download color scheme
git_clone https://github.com/lmintmate/blue-mood-vim.git $HOME/.vim/bundle/
git_clone https://github.com/ajmwagar/vim-deus.git $HOME/.vim/bundle/
git_clone https://github.com/raphamorim/lucario.git $HOME/.vim/bundle/

copy $HOME/.vim/bundle/blue-mood-vim/colors/blue-mood-vim.vim $HOME/.vim/colors/
copy $HOME/.vim/bundle/vim-deus/colors/deus.vim  $HOME/.vim/colors/
copy $HOME/.vim/bundle/raphamorim/colors/lucario.vim $HOME/.vim/colors/

echo "Completed!"

# install Vundle 
# git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim


