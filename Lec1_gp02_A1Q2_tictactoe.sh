#!/bin/bash

reset(){
	gameArray=(_ _ _ _ _ _ _ _ _)
	playerMoves=1
	gameStatus=1
	totalMoves=0
}

gameScreen(){
	cols=$( tput cols )
	rows=$( tput lines )
	middle_row=$(( $rows / 2 ))
	middle_col=$(( $cols / 2 ))
	tput clear
	tput cup $middle_row $middle_col
	echo "r|c 0 1 2 "
	tput cup $((middle_row+=1)) $middle_col
	echo "0   ${gameArray[0]} ${gameArray[1]} ${gameArray[2]} "
	tput cup $((middle_row+=1)) $middle_col
	echo "1   ${gameArray[3]} ${gameArray[4]} ${gameArray[5]} "
	tput cup $((middle_row+=1)) $middle_col
	echo "2   ${gameArray[6]} ${gameArray[7]} ${gameArray[8]} "
	tput sgr0
	tput cup $( tput lines ) 0
}

setPlayerValue(){
	idx=$(( $1 * 3 +$2 ))
	if [ ${gameArray[$idx]} == "_" ]; then
		gameArray[$idx]=$3
		playerMoves=$((playerMoves$2+1))
		let "playerInput = 1"
		let "totalMoves=totalMoves+1"
	else
		echo "Cannot place there"
	fi
}
setCompValue(){
	idx=$(( $1 * 3 +$2 ))
	if [ ${gameArray[$idx]} == "_" ]; then
		gameArray[$idx]=$3
		playerMoves=$((playerMoves$2+1))
		let "compInput = 1"
		let "totalMoves=totalMoves+1"
	fi
}

gameWon(){
	if [ ${gameArray[$1]} != "_" ] && [ ${gameArray[$1]} == ${gameArray[$2]} ] && [ ${gameArray[$2]} == ${gameArray[$3]} ]; then
		sym=${gameArray[$1]}
		gameStatus=0
		gameScreen
	fi
}
checkgame(){
	gameWon 0 1 2
	gameWon 3 4 5
	gameWon 6 7 8
	gameWon 0 3 6
	gameWon 1 4 7
	gameWon 2 5 8
	gameWon 0 4 8
	gameWon 2 4 6
}

reset
while [ $gameStatus -eq 1 ]
do
	gameScreen
	playerInput=0
	while [ $playerInput -eq 0 ]
	do
		sym=X
		echo "please enter x and y where you want to place your move(You are X)"
		read -r a b
		setPlayerValue $a $b $sym
	done
	if [ $totalMoves != 8 ]
	then
		compInput=0
		while [ $compInput -eq 0 ]
		do
			sym=O
			compX=$((RANDOM % 3))
			compY=$((RANDOM % 3))
			setCompValue $compX $compY $sym
		done
	fi
	checkgame
	if [ $gameStatus != 1 ]
	then
		echo "Game Over"
		if [ $sym == "X" ]
		then
			echo "Player Won!"
		else
			echo "Computer Won!"
		fi
		break
	fi
	if [ $totalMoves -eq 8 ]
	then
		gameScreen
		echo "Game Over"
		echo "Game Draw!"
		gameStatus=0
	fi
done

