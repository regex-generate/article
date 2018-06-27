# Gnuplot script file for plotting data in file "force.dat"

# set terminal x11 size 1500,500 font 'Deja Vu Sans Mono,14' persist

set terminal pngcairo transparent size 1000,2000 rounded font 'Deja Vu Sans,19'
set output 'ocaml_all.png'

# set terminal tikz standalone size 15,6 textscale 0.5
# set output 'tex/re-gen.tex'

# Make it pretty -- http://edg.uchicago.edu/tutorials/pretty_plots_with_gnuplot/
set xtics nomirror
set ytics nomirror
set mxtics 2
set mytics 2
set style line 80 lc rgb "#4D4D4D"
set border 3 back ls 80
set style line 81 lt 0 lc rgb "#4D4D4D" lw 0.9
set grid xtics
set grid ytics
set grid back ls 81

set ylabel "Count (×10^4)"
set xlabel "Time (s)"
set xrange [0:5]
set yrange [0:]
# set logscale y

# Put the legend at the bottom left of the plot
set key left top

set multiplot layout 4,1 columnsfirst scale 1,1 spacing 0,0

set lmargin at screen 0.15; set rmargin at screen 0.98
set tmargin 0.3

set style line 1 lt 1 lc rgb "#1b9e77" lw 4 pt 7 ps 1.5 dt solid
set style line 2 lt 1 lc rgb "#d95f02" lw 4 pt 11 ps 1.5 dt ". "
set style line 3 lt 1 lc rgb "#7570b3" lw 4 pt 9 ps 1.5 dt "-"
set style line 4 lt 1 lc rgb "#e7298a" lw 4 pt 7 ps 1.5 dt solid
set style line 5 lt 1 lc rgb "#66a61e" lw 4 pt 7 ps 1.5 dt "_. "
set style line 6 lt 1 lc rgb "#e6ab02" lw 4 pt 7 ps 1.5 dt ". "
set style line 7 lt 1 lc rgb "#a6761d" lw 4 pt 7 ps 1.5 dt "-"

re = '(ab*)* a* ~(a*)b ~(a*)&~(b*)'
algo = "ThunkList ThunkListMemo LazyList StrictSet Trie"

last = words(re)

do for [i = 1:last] {
    if (i == last) {
        unset format x
        set xlabel "Time (s)"
    } else {
        set format x ''
        unset xlabel
    }
    if (i == 1) {
        set key left top
    } else {
        unset key
    }
    set label 1 word(re,i) noenhanced center at graph 0.5,0.95 font ',21'
    plot for [j = 1:words(algo)] word(re,i)."_".word(algo,j)."_ocaml.csv" using 2:($1/10000) title word(algo,j) noenhanced with lines ls j
}

unset multiplot
