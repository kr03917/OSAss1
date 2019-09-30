#!/bin/bash

inputPassword=$1
echo
isCorrect=0

while [ $isCorrect -eq 0 ]
do
	if [ ${#inputPassword} -ge 8 ]
	then
		if [[ $inputPassword =~ [0-9] ]]
		then
			if [[ ! $inputPassword =~ ^[[:alnum:]]+$ ]]
			then
				let "isCorrect=1"
			else
				echo "There must be atleast one special character"
				break
			fi
		else
			echo "There must be atleast one number"
			break
		fi
	else
		echo "Password is not long enough"
		break
	fi
done

if [ $isCorrect -eq 1 ]
then
	echo "Password is Strong!"
else
	echo "Password is not strong enough please fix it"
fi
