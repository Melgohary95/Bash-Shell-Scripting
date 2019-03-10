#!/usr/bin/bash

shopt -s extglob
export LC_COLLATE=C

regex='^[a-zA-Z][0-9a-zA-Z_]*$'

while [ true ]
    do
    clear
    echo "available tables are:"
    ls "./DataBases/$1"
    echo "Enter the table's name or press 'b' to go back: "
    read input
    if [[ $input == "b" ]]
    then break
    elif [[ $input =~ $regex ]]
then
    if test -z "$input"
    then
    echo "Invalid name.(Table name should contain at least one character!!)"
    sleep 1
    clear
    break

    elif test -e "./DataBases/$1/$input"
    then
    clear
    awk -F\; '{for(i=1;i<NF;i++){ print $i}}' "./DataBases/$1/.$input" | cut -f1 -d: > ./DataBases/$1/.colsnames
    clear
        while true
        do
          clear
        echo "Now You are working with '$input' table"
        echo "Please Enter the PK you want to Display"
        read pk
        awk -F: '{if('$pk'==$1) print "Found"}' "./DataBases/$1/$input" > ./DataBases/$1/.data
        if test -e "./DataBases/$1/.data"
        then
            awk -F: 'BEGIN{OFS="\t";ORS="\t"}{print $1,$2}' ./DataBases/$1/.colsnames
            echo ""
            awk -F: 'BEGIN{OFS="\t \t";}{if ('$pk'==$1) print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10}' "./DataBases/$1/$input"
            echo "Press any key to continue "
            read back
            if [[ $back =~ $regex ]]
            then
            break
            fi
        else
            echo "Invalid Primary Key!!"
        fi
        rm ./DataBases/$1/.data
            done
    fi
    fi
    done
rm ./DataBases/$1/.colsnames