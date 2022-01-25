#!/bin/bash

BASEPATH=/home/sfserver
LSGMSDTDSERVERCFG=${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg

source $scriptsDir/check_space.sh

echo "[INFO] It seems to be the first installation, making preparations..."

# Start to create default files
./sfserver

# Check version

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

echo "[INFO] Starting server installation"

# Install Satisfactory Server

./sfserver auto-install

echo "[INFO] The server have been installed."

echo "If this file is missing, server will be re-installed" > serverfiles/DONT_REMOVE.txt
