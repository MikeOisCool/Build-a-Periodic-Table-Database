#!/bin/bash
if [ "$#" -eq 0 ]; then
  echo "Please provide an element as an argument."
  else



PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align --tuples-only -c"
ELEMENT_INPUT=$1
if [[ $ELEMENT_INPUT =~ ^[0-9]+$ ]]; then
SQL_QUERY=" SELECT * FROM properties JOIN elements USING(atomic_number) JOIN types USING (type_id) WHERE atomic_number=$ELEMENT_INPUT"
elif [[ $ELEMENT_INPUT =~ ^[A-Z][a-z]?$ ]]; then
SQL_QUERY=" SELECT * FROM properties JOIN elements USING(atomic_number) JOIN types USING (type_id) WHERE symbol='$ELEMENT_INPUT'"
else
SQL_QUERY=" SELECT * FROM properties JOIN elements USING(atomic_number) JOIN types USING (type_id) WHERE name ILIKE '$ELEMENT_INPUT'"
fi
ELEMENT_OUTPUT=$($PSQL "$SQL_QUERY" 2>&1)


ELEMENT=$($PSQL "$SQL_QUERY" 2>&1)
if [[ -z $ELEMENT_OUTPUT || $ELEMENT_OUTPUT == *"ERROR:"* ]]
then
  echo "I could not find that element in the database."
    
else
IFS='|' read -r -a ELEMENT <<< "$ELEMENT_OUTPUT"
ATOMIC_NUMBER=${ELEMENT[1]}
SYMBOL=${ELEMENT[5]}
NAME=${ELEMENT[6]}
MASSE=${ELEMENT[2]}
MELTING_POINT=${ELEMENT[3]}
BOILING_POINT=${ELEMENT[4]}
TYPE=${ELEMENT[7]}
echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASSE amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi

fi