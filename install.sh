HELPMSG='this is here to help'

PREREQUISITES=("curl" "git")
FORCE=false

while getopts 'fh' flag; do
    case "${flag}" in
        f)
            FORCE=true
            ;;
        h)
            echo ${HELPMSG}
            exit 0
            ;;
        *)
            echo ${HELPMSG}
            exit 1
    esac
done

set -e

declare -A osInfo;
osInfo[/etc/redhat-release]=yum
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]=apt-get
osInfo[/etc/alpine-release]=apk

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        PACMAN=$(echo ${osInfo[$f]})
        break
    fi
done

if [[ -z "${PACMAN}" ]]; then
    echo "No compatible package manager found."
    exit 1
fi

echo "Found package manager ${PACMAN}."

INSTALL_CMD=$(
    case "${PACMAN}" in
        "pacman")
            echo "-S"
            ;;
        "emerge")
            echo ""
            ;;
        "apk")
            echo "add"
            ;;
        *)
            echo "install"
            ;;
    esac
)

function installPackages {
    scopedPrerequisites=$1[@]
    pacFlags=$([[ $FORCE == true ]] && echo "-y")

    sudo ${PACMAN} ${INSTALL_CMD} ${!scopedPrerequisites} ${pacFlags}

    if [[ -z $2 ]]; then
        exit
    fi

    scopedPackages=$2[@]
    sudo ${PACMAN} ${INSTALL_CMD} ${!scopedPackages} ${pacFlags}
}

installPackages ${PREREQUISITES}
