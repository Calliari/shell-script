
1) ###### ---- #######
# One-dimensional array in Bash

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

# all xml in one array
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

4) ###### ---- #######
# Basic loop in Bash with range (1 to 10000), cp file X times generating it with names starting with "clm", i.e: "clm51954.doc" which would start with "clm0000.doc" and ending with "clm10000.doc"

for i in $(seq 1 1000); do
    cp original.doc $(printf "clm%04u.doc" $i)
done
