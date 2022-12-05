#!/bin/bash

BASEPATH=/home/sfserver
LSGMSFSERVERCFG=${BASEPATH}/lgsm/config-lgsm/sfserver/sfserver.cfg

echo "[INFO] Selection version ${VERSION} to install"

if [ "${VERSION,,}" == 'stable'  ] || [ "${VERSION,,}" == 'public'  ]
    then
        if grep -R "branch" "$LSGMSFSERVERCFG"
            then
                sed -i "s/branch=.*/branch=\"\"/" "$LSGMSFSERVERCFG"
                echo "[INFO] Version changed to ${VERSION,,}"
            else
                echo "[INFO] Already on ${VERSION,,}"
        fi
    else
        if grep -R "branch" "$LSGMSFSERVERCFG"
            then
                sed -i 's/branch=.*/branch="$VERSION"/' "$LSGMSFSERVERCFG"
            else
                echo branch='"-beta $VERSION"' >> "$LSGMSFSERVERCFG"
                echo "[INFO] Version changed to ${VERSION,,}"
        fi
fi

./sfserver update

echo "[INFO] The server have been updated to ${VERSION,,} version"
