
package require Tk
source textsearch.tcl

text .t -width 80 -height 10
textSearch::enableSearch .t

menu .m
. configure -menu .m
.m add cascade -label "Menu" -menu .m.m -underline 0
menu .m.m
textSearch::searchMenu .m.m
.m.m add separator
.m.m add command -label "Quit" -command exit -underline 0
.m add command -label "Resource" -underline 0 -command "source textsearch.tcl"

pack .t -fill both -expand 1
update
wm geometry . -5+5

set ch [open textsearch.tcl r]
.t insert end [read $ch]
close $ch
