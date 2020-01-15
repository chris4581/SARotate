#!/usr/bin/env bash

## Variables
# Name of remote drive here. If more than one remote uncomment extra remotes to utilize.
REMOTE=remotename
#REMOTE1=remotename
#REMOTE2=remotename
#REMOTE3=remotename
#REMOTE4=remotename
#REMOTE5=remotename

# First json file number in your JSON directory. If utilizing different sets of SA's then uncomment the extra MINJS variables for use.
MINJS=start#
#MINJS1=start#
#MINJS2=start#
#MINJS3=start#
#MINJS4=start#
#MINJS5=start#

# Max json file number you wish to use in your JSON directory.
MAXJS=end#
#MAXJS1=end#
#MAXJS2=end#
#MAXJS3=end#
#MAXJS4=end#
#MAXJS5=end#

# Location of DIR with SA .json files.
JSONDIR=/your/dir/here

# Amount of time you would like to have the script sleep before switching SA .json files.
SLEEPTIME=15m
# COUNT needs to be initialized.
COUNT=$MINJS


while :
do
	echo SA Rotate is running.
		COUNT=$(( $COUNT>=$MAXJS?MINJS:$COUNT+1 ))
	rclone config update $REMOTE service_account_file $JSONDIR/$COUNT.json
	echo SA rotate is now going to sleep for $SLEEPTIME
		sleep $SLEEPTIME
done
