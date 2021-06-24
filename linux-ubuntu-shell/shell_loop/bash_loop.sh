
# One dimensional array in Bash
NAMES=(
"Test CAVALCANTE"
"Jack Smith"
"BARBOSA PEREIRA"
"HENRIQUE DA SILVA"
"APARECIDO Da PAZ"
"MANOEL MARTINS"
"JEFDA SILVA"
"FRAN Ferreira"
)

for NAME in "${NAMES[@]}" ; do
    echo -e "Number:$NAME"
done


###### ---- #######

# Multi-dimensional arrays in Bash

# Declare permit modifying the properties of variables (-a for arrays)
declare -a num
declare -a words

num=(1 2 3 4 5 6 7)
words=(one two three four five six seven)

for var in ${num[@]}; do
    echo "In Number:${num[$var]} = In Numeral:${words[$var]}"
done
