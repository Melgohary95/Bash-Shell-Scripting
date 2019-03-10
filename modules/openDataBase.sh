#!/usr/bin/bash

regex='^[a-zA-Z_][0-9a-zA-Z_]*$'


let x=`ls "./DataBases" | wc -w`

if [ $x -eq 0 ]
then
    echo "You don't have any DBs yet!"
    sleep 1
else
    while true
    do
        clear
        echo "available databases are:"
        ls ./DataBases
        echo -e "\nPlease enter database name to open or press 'b' to go back: "
        read input

        if [[ $input == "b" ]]

        then break
        elif [[ $input =~ $regex ]]
        then

            if test -z "$input"
            then
                echo "Invalid name.(DB name should contain at least one character!!)"
                sleep 1
                continue

            elif test -e "./DataBases/$input"
            then
                clear
                ./modules/table.sh $input
                break

            else
                echo "' $input ' DB doesn't exist!"
                sleep 1
                continue
            fi
        else
        echo "' $input ' DB doesn't exist!"
        sleep 1
        continue
        fi

    done

fi
