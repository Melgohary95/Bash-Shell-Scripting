#!/usr/bin/bash

shopt -s extglob
export LC_COLLATE=C

pkvalue=$2
linecounter=$3
input=$4


colnames=`awk -F\:[is]\; '{for(i=1;i<NF;i++){print $i}}' ./DataBases/$1/.$input`
colnametype=`awk -F\; '{for(i=1;i<NF;i++){ print $i}}' "./DataBases/$1/.$input"`

colname=""
coltype=""


while true
do
    clear
    echo "Editing ' $input ' Table"
    echo ""
    echo "Columns and their datatypes in this table are:"
    echo "$colnametype "
    echo ""
    echo "Enter column name to modify its value: "
    read value

    let colcounter=0
    let colfound=0

    if test -z "$value"
    then
        clear
        echo "Invalid name >> (Column name should contain at least one character!!)"
        sleep 1
        continue
    else
        for test in $colnametype
        do
        #echo $test
        let colcounter=$colcounter+1                            #cell indicator >> number of column

        colname=`echo $test | cut -d: -f1`
        coltype=`echo $test | cut -d: -f2`

        if [ $colname -eq $value ] 2> /dev/null || [ "$colname" = "$value" ] 2> /dev/null
        then
        let colfound=1
        break
        fi
        done
    fi

    if [ $colfound -eq 0 ]
    then
    clear
    echo "This column doesn't exist!"
    sleep 1
    continue

    elif [ $colcounter -eq 1 ]
    then
    clear
    echo "PK values can not be modified!"
    sleep 1
    continue

    else


    while true
    do
        clear
        echo "Enter the new value of column '$value'"
        read newvalue

        case $newvalue in
            +([0-9]))
            if [ $newvalue -eq $newvalue ] 2> /dev/null && [ $coltype = 'i' ]
            then
                clear
                echo '
                        " The record is updated successfully. "
                '
                sleep 1
                break
            else
                echo "Invalid data type!"
                sleep 1
                continue
            fi

            ;;
            +([a-z]|[A-Z]|[" "|.|@|_]))
            if [ "$newvalue" = "$newvalue" ] 2> /dev/null && [ $coltype = 's' ]
            then
                clear
                echo " The record is updated successfully. "
                sleep 1
                break
            else
                echo "Invalid data type!"
                sleep 1
                continue
            fi
            ;;
            *)
            echo "Invalid data type!"
            sleep 1
            continue
            ;;
        esac


    done

    touch ./DataBases/.tmp
    awk -F: -v pkvalue=$pkvalue -v cellnumber=$colcounter -v cellvalue=$newvalue '{OFS=FS;if($1==pkvalue){$cellnumber=cellvalue}print $0}' ./DataBases/$1/$input > ./DataBases/.tmp

    cat ./DataBases/.tmp > ./DataBases/$1/$input
    rm ./DataBases/.tmp


    break
    fi

done
