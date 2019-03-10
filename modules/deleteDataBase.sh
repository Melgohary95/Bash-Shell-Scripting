#!/usr/bin/bash

PS3="Please enter your option: "
regex='^[a-zA-Z_][0-9a-zA-Z_]*$'

choice=2

clear

let x=`ls "./DataBases" | wc -w`

if [ $x -eq 0 ]
then
    echo "You don't have any DBs yet!"
    sleep 1
else
    while true
    clear
    do
        echo -e "Press b if you want to go back\n"
        echo -e "Available databases are :"
        ls "./DataBases"
        echo -e "\nPlease enter Database name to be deleted: "
        read input

    if [[ $input == "b" ]]

    then break
    elif [[ $input =~ $regex ]]
    then

        if test -e "./DataBases/$input"
        then

        rm -r "./DataBases/$input"
        clear
        echo -e "\t\" $input \" DB is deleted successfully."
        sleep 2
        break

        else
        echo "' $input ' DataBase doesn't exist!"
        sleep 1
        continue
        fi
    else
        echo "' $input ' DataBase doesn't exist!"
        sleep 1
        continue
    fi

    done

fi
