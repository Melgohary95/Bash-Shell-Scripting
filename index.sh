#!/usr/bin/bash
clear

if [ ! -e DataBases ]
then
mkdir "./DataBases"
fi

while [ true ]
do
  clear
  echo 'Please enter your choice as number :
1- Create new Database
2- List existing Databases
3- Select Database
4- Delete Database
5- Exit'

  read input

  case $input in
  1) . ./modules/createDataBase.sh
  ;;

  2)  clear
      let counter=`ls ./DataBases | wc -w`
      if [ $counter -eq 0 ]
      then
      echo "There is no database available"
      sleep 2
      else
        while [[ true ]]; do
          echo "available databases are  -  press 'any charcter + enter' to go back:"
          ls ./DataBases
          read in
          break
        done

      fi
  ;;

  3)  . ./modules/openDataBase.sh
  ;;

  4)
      let counter=`ls ./DataBases | wc -w`
      if [ ! $counter -eq 0 ]
      then
      echo "available databases:"

      ls ./DataBases
      fi
      . ./modules/deleteDataBase.sh
  ;;

  5)
  clear
      exit
  ;;
  *) echo "Wrong choice."
      sleep 0.5
      continue
  ;;
  esac
done
