#!/bin/bash
set -e

BREW="homebrew/completions/brew-cask-completion,ffmpeg,git,bash-completion,imagemagick,jp2a,mas,node,wget"
CASK="java,atom,bittorrent,clion,divvy,google-chrome,hipchat,intellij-idea,keeweb,licecap,minerva,nanobox,obs,scroll-reverser,skype,spotify,steam,toggldesktop,visual-studio-code,vlc,webstorm,yacreader"
CASK_POST_BREW="maven"
APM="atom-beautify,atom-typescript,auto-indent,color-picker,editorconfig,git-plus,highlight-line,highlight-selected,jumpy,language-actionscript3,language-batch,linter,linter-eslint,linter-jsonlint,minimap,minimap-git-diff,minimap-highlight-selected,pretty-json,sort-lines,toggle-quotes,tree-view-git-status,wordcount"
MAS="413857545,455970963,497799835,451444120"

function install {
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function brew_install {
  brew update
  brew tap caskroom/cask

  for i in ${BREW//,/ }
    do
        brew install $i
    done
}

function brew_update {
  brew update

  for i in ${BREW//,/ }
    do
        brew upgrade $i
    done
}

function cask_install {
  brew cask update

  for i in ${CASK//,/ }
    do
        brew cask install $i
    done
}

function cask_update {
  brew cask update

  for i in ${CASK//,/ }
    do
        brew cask update $i
    done
}

function apm_install {
  for i in ${APM//,/ }
    do
        apm install $i
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
            #install
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
