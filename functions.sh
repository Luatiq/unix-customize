#!/bin/bash
function installPackages {

    declare -a scopedPrerequisites=("${!1}")

    if [[ $FORCE == true ]]; then
        pacFlags="-y"
    fi

    sudo ${PACMAN} ${INSTALL_CMD} ${scopedPrerequisites[@]} ${pacFlags}

    declare -a scopedPackages=("${!2}")
    if [[ -z $scopedPackages ]]; then
        return 0
    fi

    sudo ${PACMAN} ${INSTALL_CMD} ${scopedPackages[@]} ${pacFlags}
}

function removePackages {
    declare -a packages=("${!1}")

    if [[ $FORCE == true ]]; then
        pacFlags="-y"
    fi

    sudo ${PACMAN} ${REMOVE_CMD} ${packages[@]} ${pacFlags}
}

function updateRepos {
    UPDATE_CMD=$(
    case "${PACMAN}" in
        "pacman")
            echo "-Syy"
            ;;
        "emerge")
            echo "--sync"
            ;;
        *)
            echo "update"
            ;;
    esac
    )

    sudo ${PACMAN} ${UPDATE_CMD}
}

function addRepository {
    if [[ $FORCE == true ]]; then
        pacFlags="-y"
    fi

    ADD_REPO_CMD=$(
    case "${PACMAN}" in
        "pacman")
            echo "repo-add"
            ;;
        "emerge")
            echo "eselect repository"
            ;;
        *)
            echo "add-apt-repository"
            ;;
    esac
    )

    sudo ${ADD_REPO_CMD} $1 ${pacFlags}
}

# Only works for gnome
# Usage: setShortcut "name" "command" "keycombo" shortcutId
function setShortcut {
    name="$1"
    commandToRun="$2"
    binding="$3"
    path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom$4"
    dconf write "$path/name" "'""$name""'"
    dconf write "$path/command" "'""$commandToRun""'"
    dconf write "$path/binding" "'""$binding""'"
}

function copyDotFiles {
    folderName=$1
    srcConfigFileName=$2
    targetConfigFileName=$3

    configFileDir=$(eval echo "~$USER")/.config/${folderName}
    configFile=${configFileDir}/${targetConfigFileName}

    mkdir -p ${configFileDir}

    if [ -f ${configFile} ]; then
        cp ${configFile} ${configFile}.bak
    else
        touch ${configFile}
    fi

    cat $(dirname "$0")/Dotfiles/${srcConfigFileName} > ${configFile}
}

function flatInstall {
    flatpak install flathub $1 $([[ $FORCE == true ]] && echo '--noninteractive')
}

function flatRemove {
    flatpak remove $1 $([[ $FORCE == true ]] && echo '--noninteractive')
}

function installNonPacManPrerequisites {
    mapfile -t available_prereqs <<< "$(ls ./NonPacManPrerequisites/*.sh -1)"

    if [[ ! ${available_prereqs[@]} =~ "$1.sh" ]]; then
        echo "No such non-pacman prerequisite found"
        return 1
    fi

    pathToExec="./NonPacManPrerequisites/$1.sh"
    chmod a+x $pathToExec

    echo "Installing prerequisite \"$1.sh\"..."
    source $pathToExec
}
