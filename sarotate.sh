#!/usr/bin/env bash

## Variables Single Remote

REMOTE=remotename                          # Name of remote drive here
MINJS=start#                               # First json file number in your JSON directory.
MAXJS=end#                                 # Max json file number you wish to use in your JSON directory.
JSONDIR=/your/dir/here                     # Location of DIR with SA .json files.
SLEEPTIME=15m                              # Amount of time you would like to have the script sleep before switching SA .json files.
MULTI=true                                 # True = Using multiple teamdrives. False = Using single teamdrive.
RCLONE=~/.config/rclone/rclone.conf        # This is the default rclone config. If yours is different change it here.

# COUNT needs to be initialized.
COUNT=$MINJS


change_sa()
{ rclone config update $REMOTE service_account_file $JSONDIR/$COUNT.json; }

check_rclone()
{ if [ -f "$RCLONE" ]; then
	echo "$RCLONE exist"
else
	echo "rclone config file could not be found at: $RCLONE. If your config file is located in a different location change the variable in the script."
fi
}


while :
do
	echo "SA Rotate is running."
	COUNT=$(( $COUNT>=$MAXJS?MINJS:$COUNT+1 ))
	rclone config update $REMOTE service_account_file $JSONDIR/$COUNT.json
	echo "SA rotate is now going to sleep for $SLEEPTIME"
	sleep $SLEEPTIME
done


