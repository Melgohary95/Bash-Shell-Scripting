#!/usr/bin/bash

DBname=$1
regex='^[a-zA-Z][0-9a-zA-Z_]*$'

let x=`ls "./DataBases/$1" | wc -w`

if [ $x -eq 0 ]
then
    echo ""
    echo "You don't have any Tables in this DB !"
    sleep 1
    continue
else
    while true
    do
        clear
        echo "available tables are:"
        ls ./DataBases/$DBname
        echo "Please enter Table name to be DELETED: "
        read input

    if [[ $input =~ $regex ]]
    then

        if test -z "$input"
        then
        echo "Invalid name.(Table name should contain at least one character!!)"
        sleep 1
        continue

        elif test -e "./DataBases/$1/$input"
        then
        rm "./DataBases/$1/$input"
        rm "./DataBases/$1/.$input"
        clear
        break

        else
        echo "' $input ' Table doesn't exist!"
        sleep 1
        continue
        fi
    else
    echo "' $input ' Table doesn't exist!"
    sleep 1
    continue
    fi

    done
fi
