#!/bin/bash

RDP=""      # runtime dependencies
DP=""       # dependencies
BUILDDP=""  # build dependencies
next=""
COMPLETE="" # a variable that holds a complete depend string for the nexLogic function

getNext () {
    next=$(find /var/db/pkg/* -maxdepth 1 -mindepth 1 | sed -e 's/\/var\/db\/pkg\///' | dmenu -l 30)
}

nextLogic () {
    COMPLETE=""
    while [ 1 ]
    do
        getNext
        if [ $next == "stop" ]
        then
            break
        fi
        COMPLETE+=">=$next
"
    done
}

if [ $# == 0 ]; then


    echo ""
    echo ""
    echo "Please enter needed dependencies"
    echo "to stop, type stop"
    read -n 1 -p "Type any key to begin"
    nextLogic
    echo "$COMPLETE" | xclip -selection clipboard

elif [ $1 == "--new" ] || [ $1 == "-n" ]; then

    read -p "Please enter the name of the ebuild ( without version )
    " name
    echo ""
    read -p "Please enter the version of the ebuild
    " version
    
    echo ""
    echo ""
    echo "Please enter needed runtime dependencies"
    echo "to stop, type stop"
    read -n 1 -p "Type any key to begin"
    nextLogic
    RDP="$COMPLETE"
    
    
    
    echo ""
    echo ""
    echo "Please enter needed dependencies"
    echo "to stop, type stop"
    read -n 1 -p "Type any key to begin"
    nextLogic
    DP="$COMPLETE"
    
    
    echo ""
    echo ""
    echo "Please enter needed build dependencies"
    echo "to stop, type stop"
    read -n 1 -p "Type any key to begin"
    nextLogic
    BUILDDP="$COMPLETE"
    
    
    
    
    echo "\
    # Copyright 1999-2020 Gentoo Authors
    # Distributed under the terms of the GNU General Public License v2
    
    EAPI=7
    
    # Short one-line description of this package.
    DESCRIPTION=\"\"
    
    
    # Homepage, not used by Portage directly but handy for developer reference
    HOMEPAGE=\"\"
    
    
    # Point to any required sources; these will be automatically downloaded by
    # Portage.
    SRC_URI=\"\"
    
    
    # License of the package.  This must match the name of file(s) in the
    # licenses/ directory.  For complex license combination see the developer
    # docs on gentoo.org for details.
    LICENSE=\"\"
    
    SLOT=\"0\"
    
    KEYWORDS=\"~amd64\"
    
    IUSE=\"\"
    
    RDEPEND=\"
    $RDP\"
    
    DEPEND=\"\${RDEPEND}
    $DP\"
    
    BDEPEND=\"
    $BUILDDP\"
    " > "$name-$version.ebuild"
    echo ""
    echo ""
    echo ""
    echo "file written to $name-$version.ebuild"

fi


