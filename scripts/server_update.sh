#!/bin/bash
./sfserver update

        if [ "${VERSION,,}" == 'stable'  ]
        then
	    # Remove branch line
            sed -i '/branch/d' /home/sfserver/lgsm/config-lgsm/sfserver/sfserver.cfg
        else
	    # Remove branch line if exist to avoid multiple branch lines
	    sed -i '/branch/d' /home/sfserver/lgsm/config-lgsm/sfserver/sfserver.cfg
	    
            echo branch='"-beta $VERSION"' >> /home/sfserver/lgsm/config-lgsm/sfserver/sfserver.cfg
	    
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

            The server have been updated to ${VERSION,,}
            More info: https://github.com/vinanrra/Docker-Satisfactory#start-modes
            =======================================================================
            "
