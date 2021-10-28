set -eu

# Print info
echo "
=======================================================================
USER INFO:
UID: $PUID
GID: $PGID
MORE INFO:
If you have permission problems remember to use same user UID and GID.
Check it with "id" command
=======================================================================
"

# Set user and group ID to sfserver user
groupmod -o -g "$PGID" sfserver  > /dev/null 2>&1
usermod -o -u "$PUID" sfserver  > /dev/null 2>&1
