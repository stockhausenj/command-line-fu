#!/bin/bash

# https://lwn.net/Articles/754980/
#
# The real or effective user ID of the sending process must equal the real or
# saved set-user-ID of the target process. Just create a new reaper_uid, and
# set its <euid, ruid, suid> to <target_uid, reaper_uid, X> (where X can be
# anything as long as it's not target_uid).
#
# ruid = owner of process
# euid = which permissions are used
# suid = saves ruid for switching back
#

response=""

while [[ ($response != "yes") && ($response != "no") ]]
do
  echo "Are you sure you want to kick off fork bomb? (yes/no)"
  read response
done

if [[ $response == "yes" ]]; then
  :(){ :|: & };:
else
	echo "cancelled"
fi
