#!/bin/bash
./sfserver update

        if [ "${VERSION,,}" == 'public'  ]
        then
	    # Remove branch line
            sed -i 's/branch=".*"/branch=""/' /home/sfserver/lgsm/config-lgsm/sfserver/common.cfg
        else
	    # Remove branch line if exist to avoid multiple branch lines
	        sed -i "s/branch=".*"/branch="\"${VERSION,,}"\"/" /home/sfserver/lgsm/config-lgsm/sfserver/common.cfg
	    
            echo "
            =======================================================================
            IMPORTANT:
            
            Server version changed to: ${VERSION,,}
            
            =======================================================================
            "
        fi

        ./sfserver update

            echo "
            =======================================================================
            IMPORTANT:

            The server have been updated to latest ${VERSION,,} version
            More info: https://github.com/vinanrra/Docker-Satisfactory#start-modes
            =======================================================================
            "
