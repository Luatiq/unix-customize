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
    ${PACMAN} ${INSTALL_CMD} ${scopedPackages[@]} ${pacFlags}
}

