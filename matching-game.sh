#!/bin/bash

# August Linux Journal - Creating the Concentration Game PAIRS with Bash

declare -a letters=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

initialize ()
{
	# initialize the board with sequential letters
	count=1 maxcount=$1
	while [ $count -le $maxcount ]
	do
		addon=$(( 13 * ( $count - 1 ) ))
    echo $addon
		for slot in {1..13}
		do
			index=$(( $addon + $slot ))
			letter=$(( $index % 26 ))
			board[ $index ]=${letters[$letter]}
		done
		count=$(( $count + 1 ))
	done
  echo $board
}

initialize $1
