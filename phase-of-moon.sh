#!/bin/bash

url="http://www.moongiant.com/phase/today"
pattern="Illumination"
phase="$( curl -s "$url" | grep "$pattern" | tr ',' "\n" | grep "$pattern" | sed 's/[^0-9]//g' )"

if [ $phase -lt 5 ] ; then
  phasename="new"
elif [ $phase -lt 45 ] ; then
  phasename="crescent"
elif [ $phase -lt 55 ] ; then
  phasename="quarter"
elif [ $phase -lt 95 ] ; then
  phasename="gibbous"
else
  phasename="full"
fi

echo "The moon is currently $phasename with $phase illuminated"

