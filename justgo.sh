#!/bin/sh
  mkdir -p $HOME/.vim/ftdetect
  mkdir -p $HOME/.vim/syntax
  mkdir -p $HOME/.vim/autoload/go
  ln -s $GOROOT/misc/vim/ftdetect/gofiletype.vim $HOME/.vim/ftdetect/
  ln -s $GOROOT/misc/vim/syntax/go.vim $HOME/.vim/syntax
  ln -s $GOROOT/misc/vim/autoload/go/complete.vim $HOME/.vim/autoload/go
  echo "syntax on" >> $HOME/.vimrc.local


