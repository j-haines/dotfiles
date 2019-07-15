#! /usr/bin/env zsh

DOTFILES=(Xdefaults Xresources zpreztorc zshrc)

# install zprezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N)
do
  ln --verbose -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# delete zprezto-created files we're going to override
rm ~/.zshrc ~/.zpreztorc

# setup zsh environment
for dotfile in ${DOTFILES}
do
    ln --verbose -s "${PWD}/${dotfile}" "${HOME}/.${dotfile}"
done

for prompt in "${PWD}"/prompts/*
do
    cp --verbose "${prompt}" "~/.zprezto/modules/prompt/functions"
done

# install awesome config
mkdir -p ~/.config/awesome
for file in "${PWD}"/awesome/*
do
    cp --verbose --remove-destination --recursive "${file}" ~/.config/awesome
done

# install font settings
mkdir -p ~/.config/fontconfig/conf.d
for font in "${PWD}"/fonts/fontconfig/*
do
    fontfile=$(basename -- "${font}")
    cp --verbose --remove-destination "${font}" "~/.config/awesome/fontconfig/conf.d/${fontfile}"
done

# install urxvt extensions
cp --verbose --remove-destination --recursive "${PWD}/urxvt" ~/.urxvt
