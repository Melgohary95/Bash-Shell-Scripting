#!/usr/bin/bash

shopt -s extglob
export LC_COLLATE=C

regex='^[a-zA-Z][0-9a-zA-Z_]*$'
DBname=$1


while true
do
    clear
    echo "Please enter your Table name or press 'b' to go back: "
    read input

    if [[ $input == "b" ]]

    then break
    elif [[ $input =~ $regex ]]
    then

        if test -e "./DataBases/$DBname/$input"
            then
            echo "This table is already exist."
            sleep 1
            continue

        else

          while true
          do
              clear
              echo "note: The first column will be your primary key"
              echo "Now you're working with ' $input ' table."
              echo ""
              echo "Please enter number of columns: "

              read columns

              if [[ $columns =~ ^[2-9]+$ ]]
              then
              break
              else
              echo "Invalid number, columns number should be integer number greter than 1!"
              sleep 1
              continue
              fi
          done

          let numofcols=$columns
          let number=1

          colNames=""
          meta=""

          while [ $numofcols -ne 0 ]
          do
              clear
              echo "Now you're setting the names and datatypes of columns in ' $input ' table."
              echo ""
              echo "Please enter the name of column $number or press 'b' to go back: "

              read colName

              if [[ $colName == "b" ]]

              then break 2
              elif [[ $colName =~ $regex ]]
              then
                  if test -z "$colName"
                  then
                    echo "Invalid name.(Column name should contain at least one character!!)"
                    sleep 1
                    continue
                  else
                  for col in $colNames
                  do
                    if [ "$col" = "$colName" ]
                    then
                        echo "This name is already exist."
                        sleep 1
                        continue 2
                    fi
                  done
                  fi
              else
              echo "Invalid name!"
              sleep 1
              continue
              fi

              colNames=$colNames" "$colName
              meta=$meta""$colName":"

              echo "What data type are you want to store in ' $colName ' ?"
              select option in "Integer" "String"
                  do
                  case $REPLY in
                  1) meta=$meta"i;"
                      break
                  ;;
                  2) meta=$meta"s;"
                      break
                  ;;
                  *)
                      echo "Invalid option!"
                      sleep 1
                      continue
                  esac
              done
              let numofcols=$numofcols-1
              let number=$number+1
          done
          #end of while loop for the every col

          touch ./DataBases/$DBname/$input
          echo $meta > ./DataBases/$DBname/.$input

          clear
          echo "
                ' $input ' table is created successfylly.
                "
          sleep 1

            break
        fi

    else
        echo "Invalid name!" #for the database name
        sleep 1
        continue
    fi
done
