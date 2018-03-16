# Gnuplot script file for plotting data in file "force.dat"

# set terminal x11 size 1500,500 font 'Deja Vu Sans Mono,14' persist

set terminal pngcairo transparent size 2100,700 rounded font 'Deja Vu Sans,15'
set output 'haskell_all.png'

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
set yrange [0:]
# set logscale y

# Put the legend at the bottom left of the plot
set key left top

set multiplot layout 1,3 columnsfirst scale 1,1
set tmargin 2



set style line 1 lt 1 lc rgb "#1b9e77" lw 2 pt 7 ps 1.5 dt solid
set style line 2 lt 1 lc rgb "#d95f02" lw 2 pt 11 ps 1.5 dt "-"
set style line 3 lt 1 lc rgb "#7570b3" lw 2 pt 9 ps 1.5 dt ". "

re = 'a* (ab*)* ~(a*)b'
algo = "naive ref refConv seg segConv"


do for [i = 1:words(re)] {
  set title word(re,i) noenhanced
  plot for [j = 1:words(algo)] word(re,i)."_".word(algo,j)."_haskell.csv" using 2:($1/10000) title word(algo,j) noenhanced with lines ls j
  }

unset multiplot
