#!/bin/bash
echo "0 5 * * *  /home/sfserver/sfserver backup > /dev/null 2>&1" >> crontab.txt

echo "[INFO] Activated automatic backup"
