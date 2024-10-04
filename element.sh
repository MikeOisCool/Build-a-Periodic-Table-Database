#!/bin/bash
if [ "$#" -eq 0 ]; then
  echo "Please provide an element as an argument."
  else

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align --tuples-only -c"
ELEMENT_NUMBER_1=$1


ATOMIC_NUMBER=$($PSQL "SELECT * FROM properties JOIN elements USING(atomic_number) WHERE atomic_number=$ELEMENT_NUMBER_1" 2>&1)
if [[ -z $ATOMIC_NUMBER || $ATOMIC_NUMBER == *"ERROR:"* ]]
then
  echo "Element with atomic number $ELEMENT_NUMBER_1 not found."
    exit 1
else

echo -e "\n$ATOMIC_NUMBER"
fi

fi