#!/usr/bin/bash

shopt -s extglob
export LC_COLLATE=C

DBname=$1
regex='^[a-z|A-Z][0-9|a-z|A-Z|_|\d]*$'
let choice=3


let x=`ls "./DataBases/$1" | wc -w`

if [ $x -eq 0 ]
then

    echo ""
    echo "There are no tables in this DB!"
    sleep 1
    clear
else
    while true                          #getting table name
    do
      clear
      echo "available tables are:"
      ls "./DataBases/$DBname"
        echo "Please enter Table name to insert into: "
        read input

    if [[ $input =~ $regex ]]
    then

        if test -z $input
        then
        echo "Invalid name >> (Table name should contain at least one character!!.)"
        continue

        elif test -e "./DataBases/$1/$input"
        then
            clear
            echo "Now you're going to insert into '$input' Table"

            colnametype=`awk -F\; '{for(i=1;i<NF;i++){ print $i}}' "./DataBases/$1/.$input"`
            pkrecord=`cut -f1 -d":" ./DataBases/$1/$input`         #values of PKs
            let pkround=0                                   #pk Flag

            coltype=""
            colname=""
            record=""
            if [ $coltype == "i" ]
            then
              typeMessage="integer"
            else
              typeMessage="string"
            fi

            for test in $colnametype
            do
                colname=`echo $test | cut -d: -f1`
                coltype=`echo $test | cut -d: -f2`

                if [ $pkround -eq 0 ]                       #handling PK value
                then
                    while true
                    do
                        clear
                        echo "Now you're going to insert into '$input' Table"
                        echo ""
                        echo "Enter the $typeMessage value of column ' $colname ' (which is your PK column): "
                        read value

                        for pkval in $pkrecord              #checking PK UNIQUE
                        do
                            if [ $pkval -eq $value ] 2> /dev/null || [ $pkval = $value ] 2> /dev/null
                            then
                            echo "This PK exists, and PK should be a UNIQUE value"
                            sleep 1
                            continue 2
                            fi
                        done

                        if test -z $value 2> /dev/null                 #cheking PK not NULL
                        then
                        echo "PK can't be a null value!"
                        sleep 1
                        continue

                        else
                        case $value in                      #Checking PK datatype
                            +([0-9]))
                                if [ $value -eq $value ] 2> /dev/null && [ $coltype = 'i' ]
                                then
                                record=$record"$value:"
                                let pkround=1
                                else
                                    echo "Invalid data type!"
                                    sleep 1
                                    continue
                                fi
                                continue 2
                            ;;
                            +([a-z]|[A-Z]|[" "|.|@|_]))
                                if [ "$value" = "$value" ] 2> /dev/null && [ $coltype = 's' ]
                                then
                                record=$record"$value:"
                                let pkround=1
                                else
                                    echo "Invalid data type!"
                                    sleep 1
                                    continue
                                fi
                                continue 2
                            ;;
                            *)
                                echo "Invalid data type!"
                                sleep 1
                                continue
                            ;;
                        esac
                        fi
                    done
                fi

                while true
                do
                    clear
                    echo "Now you're going to insert into ' $input ' Table"
                    echo ""
                    echo "Enter the $typeMessage value of column ' $colname '"

                        read value
                        case $value in
                            +([0-9]))
                                if [ $value -eq $value ] 2> /dev/null && [ $coltype = 'i' ]
                                then
                                record=$record"$value:"
                                else
                                    echo "Invalid data type!"
                                    sleep 1
                                    continue
                                fi
                                break 2
                            ;;
                            +([a-z]|[A-Z]|[" "|.|@|_]))
                                if [ "$value" = "$value" ] 2> /dev/null && [ $coltype = 's' ]
                                then
                                record=$record"$value:"
                                else
                                    echo "Invalid data type!"
                                    sleep 1
                                    continue
                                fi
                                break
                            ;;
                            "")
                              record=$record"Null:"
                              continue 2
                            ;;
                            *)

                                echo "Invalid data type!"
                                sleep 1
                                continue
                            ;;
                        esac
                done
            done


            echo "$record" >> "./DataBases/$1/$input"
            clear
            echo '
                "Your record is saved successfully"
            '
            sleep 1.5
            break

        else
            echo "' $input ' Table doesn't exist!"
            sleep 1
            clear
        continue

        fi
    else
    echo "' $input ' Table doesn't exist!"
    sleep 1
    clear
    continue
    fi

    done
fi
