#!/bin/bash
function installPackages {

    declare -a scopedPrerequisites=("${!1}")

    if [[ $FORCE == true ]]; then
        pacFlags="-y"
    fi

    sudo ${PACMAN} ${INSTALL_CMD} ${scopedPrerequisites[@]} ${pacFlags}

    if [[ -z $2 ]]; then
        return 0
    fi

    declare -a scopedPackages=("${!2}")
    sudo ${PACMAN} ${INSTALL_CMD} ${scopedPackages[@]} ${pacFlags}
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
