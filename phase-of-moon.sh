#!/bin/bash

url="https://www.moongiant.com/phase/today"

pattern="Illumination"

phase="$( curl -s "$url" | grep "$pattern" | tr ',' "\n" | grep "$pattern" | sed 's/[^0-9]//g' )"

url_ago="https://www.moongiant.com/phase"

eval $( date --date="1 days ago" +"mon=%m day=%d year=%Y" )

ydayurl="$url_ago/$mon/$day/$year"

yillumlevel="$( curl -s "$ydayurl" | grep "$pattern" | tr ',' "\n" | grep "$pattern" | sed 's/[^0-9]//g' )"

if [ $phase -gt $yillumlevel ]; then
  waxwane="waxing"
else
  waxwane="waning"
fi

if [ $phase -lt 5 ] ; then                                                                           
  phasename="new"                                                                                    
elif [ $phase -lt 45 ] ; then                                                                        
  phasename="$waxwane crescent"
elif [ $phase -lt 55 ] ; then                                                                        
  phasename="quarter"                                                       
elif [ $phase -lt 95 ] ; then                                                                        
  phasename="$waxwane gibbous"
else
  phasename="full"
fi 

echo "The moon is currently $phasename with $phase illuminated"
