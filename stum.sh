#!/bin/bash
set -e

BREW="brew-cask,ffmpeg,git,imagemagick,jp2a,maven,node,wget"
CASK="java,atom,bittorrent,clion,divvy,google-chrome,hipchat,intellij-idea,keeweb,licecap,minerva,nanobox,obs,r-name,scroll-reverser,skype,spotify,steam,visual-studio-code,vlc,webstorm,yacreader"
APM="atom-beautify,atom-typescript,auto-indent,color-picker,editorconfiggit-plus,highlight-line,highlight-selected,jumpy,language-actionscript3,language-batch,linter,linter-eslint,linter-jsonlint,minimap,minimap-color-highlight,minimap-git-diff,minimap-highlight-selected,pretty-json,sort-lines,toggle-quotes,tree-view-git-status,wordcount"

function install {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function brew_install {
  brew update

  for i in ${BREW//,/ }
    do
        echo "Brew installing $i"
        brew install $i
    done
}

function brew_update {
  brew update

  for i in ${BREW//,/ }
    do
        echo "Brew updating $i"
        brew upgrade $i
    done
}

function cask_install {
  brew cask update

  for i in ${CASK//,/ }
    do
        echo "Brew cask installing $i"
        brew cask install $i
    done
}

function cask_update {
  brew cask update

  for i in ${CASK//,/ }
    do
        echo "Brew cask updating $i"
        brew cask update $i
    done
}

function apm_install {
  for i in ${APM//,/ }
    do
        echo "Apm installing $i"
        apm cask install $i
    done
}

if [ $# -eq 0 ] || [ "$1" == "--help" ]; then
    cat <<EOF
Simple install and update script.
REQUIRES xcode to be installed and terms accepted.
Cask installs might/will require su permissions

Usage:
  ./stum.sh [options] [COMMAND] [ARGS...]
  ./stum.sh --help

Commands:
  install           Installs packages
  update            Updates packages

EOF
else
    case "$1" in
        install)
            install
            brew_install
            cask_install
            apm_install
            ;;
        update)
            brew_update
            cask_update
            apm update
            ;;
        *)
            echo "Unknown command"
            ;;
    esac
fi
