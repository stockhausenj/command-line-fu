#!/bin/bash

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
