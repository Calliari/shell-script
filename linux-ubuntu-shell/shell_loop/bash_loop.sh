
1) ###### ---- #######
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


2) ###### ---- #######
# Multi-dimensional arrays in Bash (WITH NUMBER IN SEQUENCE)

# Declare permit modifying the properties of variables (-a for arrays)
declare -a num
declare -a words

num=(1 2 3 4 5 6 7)
words=(one two three four five six seven)

for var in ${num[@]}; do
    echo "In Number:${num[$var]} = In Numeral:${words[$var]}"
done



3) ###### ---- #######
# Multi-dimensional arrays in Bash interaction

#   all xml in one array
xml=(
    'script1'
    'script2'
    'script3'
    'script4'
)

#   all context in one array
context=(
    'test1'
    'test2'
    'test3'
    'test4'
)

for (( i = 1; i < ${#context[@]} ; i++ )); do
    echo "xml-file: ${xml[$i]} with ${context[$i]}"
done
