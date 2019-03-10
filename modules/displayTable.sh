#!/usr/bin/bash

regex='^[a-zA-Z][0-9a-zA-Z_]*$'
DBname=$1


let x=`ls "./DataBases/$DBname" | wc -w`

if [ $x -eq 0 ]
then
    echo ""
    echo "There are no Tables in this DB !"
    sleep 1
else
    while true
    do
        clear
        echo "available tables are:"
        ls "./DataBases/$DBname"
        echo "Please enter Table name to be Displayed or press 'b' to go back: "
        read input

        if [[ $input == "b" ]]

        then break
        elif [[ $input =~ $regex ]]
    then

        if test -z "$input"
        then
        echo "Invalid name >> (Table name should contain at least one character!!)"
        sleep 1
        clear
        break


        elif test -e "./DataBases/$DBname/$input"
        then
        clear

        awk -F\; '{for(i=1;i<NF;i++){ print $i}}' "./DataBases/$DBname/.$input" | cut -f1 -d: > ./DataBases/$DBname/.colsnames
            while [[ true ]]; do
              clear
              echo -e "press 'b' if you want to go back"
              awk -F: 'BEGIN{OFS="\t";ORS="\t"}{print $1,$2}' ./DataBases/$DBname/.colsnames
              echo ""
              awk -F: 'BEGIN{OFS="\t \t";}{print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10}' ./DataBases/$DBname/$input
              read input2
              if [[ $input2 == "b" ]]

              then break 2
              else
                echo "Wrong Choice"
                sleep 1
                continue
              fi
            done


        else
        echo "' $input ' Table doesn't exist!"
        sleep 2
        clear
        break
        fi
    else
    echo "' $input ' Table doesn't exist!"
    sleep 2
    clear
    break
    fi

    done
fi

rm ./DataBases/$DBname/.colsnames
