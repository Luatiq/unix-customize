#!/bin/bash
cd "$(dirname "$0")"

# @TODO fix this help message to actually help
HELPMSG='this is here to help'

PREREQUISITES=("curl" "git" "dialog" "flatpak")
FORCE=false
UNDOPROFILE=true

chmod a+x ./functions.sh
source ./functions.sh

while getopts 'fhP' flag; do
    case "${flag}" in
        f)
            FORCE=true
            ;;
        P)
            UNDOPROFILE=false
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

REMOVE_CMD=$(
    case "${PACMAN}" in
        "pacman")
            echo "-R"
            ;;
        "emerge")
            echo "-c"
            ;;
        "apk")
            echo "del"
            ;;
        *)
            echo "remove"
            ;;
    esac
)

installPackages PREREQUISITES[@]

mapfile -t AVAILABLE_MODULES <<< "$(ls ./Modules/*.sh -1)"
touch ./.profile

moduleOptions=""
n=1
for moduleOption in ${AVAILABLE_MODULES[@]}
do
    moduleOptions="$moduleOptions $moduleOption $moduleOption on"
    n=$[n+1]
done

choices=$(/usr/bin/dialog --stdout --keep-tite --no-cancel --title "Select modules to install" --ok-button "Install selected" --notags --checklist "Choose modules" 0 0 0 \
    $moduleOptions)

if [ $? -eq 0 ]
then
    set +e
    for choice in $choices
    do
        chmod a+x $choice

        echo "Installing module \"$choice\"..."
        source $choice
    done

    echo "Installed selected modules."
else
    echo "No modules selected."
fi

profile=$(eval echo "~$USER")/.profile
oldProfile=''

if (( $(grep -Ec "# luaten(v|d)" $profile ) > 0 )); then
    startLine=$(grep -En "# luatenv" $profile |cut -d: -f1)
    endLine=$(grep -En "# luatend" $profile |cut -d: -f1)

    if [[ $UNDOPROFILE == false ]]; then
        contentLine=$((startLine+1))
        contendLine=$((endLine-1))

        oldProfile=$(sed -n ${contentLine},${contendLine}p $profile)
    fi

    delLines="${startLine},${endLine}d"
    sed -ie $delLines $profile 
fi


echo '# luatenv' >> $profile

if [[ -n "$oldProfile" ]]; then
    echo "$oldProfile" >> $profile
fi

cat ./.profile >> $profile 
echo '# luatend' >> $profile

# @TODO - doesn't source
source $profile

rm ./.profile

exit 0
