#!/usr/bin/bash

shopt -s extglob
export LC_COLLATE=C

DBname=$1

regex='^[a-zA-Z][0-9a-zA-Z_]*$'


let x=`ls "./DataBases/$DBname" | wc -w`

if [ $x -eq 0 ]
then
    echo ""
    echo "There are no tables in this DB!"
    sleep 1
    clear
else

    while true
    do
      clear
      echo "available Tables are:"
      ls ./DataBases/$DBname
    echo "Please enter Table name to be edited: "
    read input

        if [[ $input =~ $regex ]]
        then
            if test -z "$input"
            then
                echo "Invalid name >> (Table name should contain at least one character!!)"
                sleep 1
                continue

            elif test -e "./DataBases/$DBname/$input"
            then
                clear
                echo "Editing ' $input ' Table"
                let isempty=`cat ./DataBases/$DBname/$input | wc -l`
                if [ $isempty -eq 0 ]
                then
                    echo "Empty table, Nothing to modify!"
                    sleep 2

                break
                fi

                while true
                do
                    clear
                    echo "Editing ' $input ' Table"
                    echo ""
                    echo "Please enter your PK value: "
                    read pkvalue

                    let pkexist=1
                    let linecounter=0

                    pkrecord=`cut -f1 -d":" ./DataBases/$DBname/$input`               #the  PKs column

                    for test in $pkrecord                         #to get the line number to delete it
                    do
                        let linecounter=$linecounter+1
                        if [ $test -eq $pkvalue ] 2> /dev/null || [ $test = $pkvalue ] 2> /dev/null
                        then
                        let pkexist=0
                        break
                        fi
                    done

                    if [ $pkexist -ne 0 ]
                    then
                        echo "This PK value doesn't exist."
                        sleep 1
                        continue
                    fi

                        . ./modules/editCell.sh $DBname $pkvalue $linecounter $input
                        break 2
                    
                done

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
