git clone https://github.com/dillonhuff/VimSetup.git
cp ./VimSetup/.vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
