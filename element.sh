#!/bin/bash
if [ "$#" -eq 0 ]; then
  echo "Please provide an element as an argument."
  else

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align --tuples-only -c"
ELEMENT_INPUT=$1
if [[ $ELEMENT_INPUT =~ ^[0-9]+$ ]]; then
SQL_QUERY="SELECT * FROM properties JOIN elements USING(atomic_number) WHERE atomic_number=$ELEMENT_INPUT"
elif [[ $ELEMENT_INPUT =~ ^[A-Z][a-z]?$ ]]; then
SQL_QUERY="SELECT * FROM properties JOIN elements USING(atomic_number) WHERE symbol='$ELEMENT_INPUT'"
else
SQL_QUERY="SELECT * FROM properties JOIN elements USING(atomic_number) WHERE name ILIKE '$ELEMENT_INPUT'"
fi

ELEMENT=$($PSQL "$SQL_QUERY" 2>&1)
if [[ -z $ELEMENT || $ELEMENT == *"ERROR:"* ]]
then
  echo "Element with atomic number $ELEMENT_INPUT not found."
    exit 1
else

echo -e "\n$ELEMENT"
fi

fi