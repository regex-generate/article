# Gnuplot script file for plotting data in file "force.dat"

# set terminal x11 size 700,700 font 'Deja Vu Sans Mono,14' persist

set terminal pngcairo transparent size 1000,700 rounded font 'Deja Vu Sans,15'
set output 'haskell_langs.png'

# set terminal tikz standalone size 15,6 textscale 0.5
# set output 'tex/re-gen.tex'

# Make it pretty -- http://edg.uchicago.edu/tutorials/pretty_plots_with_gnuplot/
set xtics nomirror
set ytics nomirror
set mxtics 2
set mytics 2
set style line 80 lc rgb "#808080"
set border 3 back ls 80
set style line 81 lt 0 lc rgb "#808080" lw 0.5
set grid xtics
set grid ytics
set grid back ls 81

set ylabel "Count (×10^4)"
set xlabel "Time (s)"
set xrange [0:5]
set yrange [0:600]
set logscale y

# Put the legend at the bottom left of the plot
set key right bottom

set style line 1 lt 1 lc rgb "#1b9e77" lw 2 pt 7 ps 1.5 dt solid
set style line 2 lt 1 lc rgb "#d95f02" lw 2 pt 11 ps 1.5 dt "."
set style line 3 lt 1 lc rgb "#7570b3" lw 2 pt 9 ps 1.5 dt "-"
set style line 4 lt 1 lc rgb "#e7298a" lw 2 pt 7 ps 1.5 dt solid
set style line 5 lt 1 lc rgb "#66a61e" lw 2 pt 7 ps 1.5 dt "_. "
set style line 6 lt 1 lc rgb "#e6ab02" lw 2 pt 7 ps 1.5 dt ". "
set style line 7 lt 1 lc rgb "#a6761d" lw 2 pt 7 ps 1.5 dt "-"

re = 'a* a*b ba* (ab*)* ~(a*)b ((a|b)(a|b))* (1(01*0)*1|0)*'
algo = "segConv"

plot for [i = 1:words(re)] word(re,i)."_".algo."_haskell.csv" using 2:($1/10000) title word(re,i) noenhanced with lines ls i
