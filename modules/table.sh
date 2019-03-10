#!/usr/bin/bash

    while [ true ]
        do
            clear
            echo "Current database: ' "$1" '"

            echo '
1- Create new Table
2- Delete table
3- Insert record into Table
4- Edit Record
5- Display one table
6- List existing tables
7- Display record
8- Delete record
9- Back to main menu'

            echo "Enter your choice: "
            read choice

            case $choice in
            1) . ./modules/createTable.sh $1
            ;;
            2)  let contain=`ls ./DataBases/$1 | wc -w`
                if [ ! $contain -eq 0 ]
                then
                    echo "available tables are:"
                ls ./DataBases/$1
                fi
                . ./modules/deleteTable.sh $1
            ;;
            3)  let contain=`ls ./DataBases/$1 | wc -w`
                if [ ! $contain -eq 0 ]
                then
                echo "available tables are:"
                ls ./DataBases/$1
                fi
                . ./modules/insertRecord.sh $1
            ;;
            4)  let contain=`ls ./DataBases/$1 | wc -w`
                if [ ! $contain -eq 0 ]
                then
                  echo "available tables are:"
                ls ./DataBases/$1
                fi
                . ./modules/editTable.sh $1
            ;;
            5)  let contain=`ls ./DataBases/$1 | wc -w`
                if [ ! $contain -eq 0 ]
                then
                . ./modules/displayTable.sh $1
                fi



            ;;
            6)  let contain=`ls ./DataBases/$1 | wc -w`
            clear
                if [ $contain -eq 0 ]
                then
                echo ""
                echo "There is no Tables created in this DB."
                sleep 1
                continue
                else
                  while [[ true ]]; do
                    echo "available tables are  -  press 'any charcter + enter' to go back:"
                    ls ./DataBases/$1
                    read in
                    break
                  done
                fi
            ;;

            7)  clear
                . ./modules/displayRecord.sh $1
            ;;

            8)  clear
                . ./modules/deleteRecord.sh $1
            ;;

            9)  clear
                break 2
            ;;
            *) echo "Invalid choice!"
                sleep 0.5
                continue
            ;;
            esac
        done
