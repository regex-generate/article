#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

set -f #Disable globing


ReBase=('a*' '(ab*)*' '~(a*)b' '~(a*)&~(b*)')
ReMore=('a*' 'a*b' 'ba*' '(ab*)*' '~(a*)b' '((a|b)(a|b))*' '(1(01*0)*1|0)*'  '~(a*)&~(b*)')

BackendBase=("ThunkListMemo" "ThunkList" "StrictSet" "Trie")
BackendMore=("LazyList")

function genH {
    file="$2_$1_ocaml.csv"
    echo "Regex $2 on backend $1 to $file"
    regenerate prof \
        -a "ab" -s20 \
        -i "$1" \
        "$2" > "$file" || true
}

function go {
    local -n Bs=$1
    local -n ReS=$2
    echo "(${ReS[@]}) with (${Bs[@]})"
    for B in "${Bs[@]}"
    do
        for Re in "${ReS[@]}"
        do
            genH $B $Re
        done
    done
}
    
go BackendBase ReBase
go BackendMore ReMore

echo "Gnuploting to ocaml_all.png!"
gnuplot ocaml_all.gnuplot
# echo "Gnuploting to ocaml_langs.png!"
# gnuplot ocaml_langs.gnuplot
