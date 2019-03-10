#!/usr/bin/bash

regex='^[a-zA-Z_][0-9a-zA-Z_]*$'

while true
do
    clear
    echo -e "Press b if you want to go back\n"
    echo "Please enter your new DataBase name:  ( It must start with a letter or _ )"
    read input
    if [[ $input == "b" ]]

    then break
    elif [[ $input =~ $regex ]]
      then
            if test -e "./DataBases/$input"
            then
                  echo "This name is already taken."
                  sleep 1
                  continue

            else
                        mkdir "./DataBases/$input"
                        clear
                        echo -e '\t " '$input' " DB is created successfully.'
                        sleep 1
                        break
            fi
      else
      echo "Invalid name.(Database name should start with a letter or _ and contain only letters and numbers!!)"
      sleep 2
      continue
      fi

done
