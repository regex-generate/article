#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

set -f #Disable globing


ReBase=('a*' '(ab*)*' '~(a*)b')
ReMore=('a*' 'a*b' 'ba*' '(ab*)*' '~(a*)b' '((a|b)(a|b))*' '(1(01*0)*1|0)*')

BackendBase=("naive" "ref")
BackendMore=("seg")

function genH {
    file="$2_$1_haskell.csv"
    echo "Regex $2 on backend $1 to $file"
    re-generate-exe \
        --alphabet "ab" -s20 \
        -b "${1^}Star" \
        "$2" > "$file"
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

echo "Gnuploting to haskell_all.png!"
gnuplot haskell_all.gnuplot
echo "Gnuploting to haskell_langs.png!"
gnuplot haskell_langs.gnuplot
