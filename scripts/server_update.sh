#!/bin/bash

BASEPATH=/home/sfserver
LSGMSDTDSERVERCFG=${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg

echo "[INFO] Selection version ${VERSION} to install"

if [ "${VERSION,,}" == 'stable'  ] || [ "${VERSION,,}" == 'public'  ]
    then
        if grep -R "branch" "$LSGMSDTDSERVERCFG"
            then
                sed -i "s/branch=.*/branch=\"\"/" "$LSGMSDTDSERVERCFG"
                echo "[INFO] Version changed to ${VERSION,,}"
            else
                echo "[INFO] Already on ${VERSION,,}"
        fi
    else
        if grep -R "branch" "$LSGMSDTDSERVERCFG"
            then
                sed -i 's/branch=.*/branch="$VERSION"/' "$LSGMSDTDSERVERCFG"
            else
                echo branch='"-beta $VERSION"' >> "$LSGMSDTDSERVERCFG"
                echo "[INFO] Version changed to ${VERSION,,}"
        fi
fi

./sfserver update

echo "[INFO] The server have been updated to ${VERSION,,} version"
