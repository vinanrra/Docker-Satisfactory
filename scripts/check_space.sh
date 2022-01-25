#!/bin/bash
mkdir -p /home/sfserver/serverfiles/FactoryGame
free=$(df -k --output=avail /home/sfserver/serverfiles/FactoryGame | tail -n1)   # df -k not df -h
freeGB=$(expr $free / 1024 / 1024)
if [[ $free -lt 12582912 ]]; then               # 12G = 12*1024*1024k
     space=no
fi

if [ "${space,,}" == 'no'  ]; then    
     echo "[ERROR]
          =======================================================================

          Not enough space.

          Needed: 12 GB
          Available: $freeGB GB

          =======================================================================
     "
     exit
fi