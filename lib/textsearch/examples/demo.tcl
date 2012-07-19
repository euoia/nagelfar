#!/bin/sh
# the next line restarts using tclsh \
exec tclsh "$0" "$@"

package require Tk
if {[catch {package require textSearch}]} {
    if {[file tail [pwd]] == "examples"} {
        lappend ::auto_path [file join [pwd] ..]
        package require textSearch
    }
}

option add *Menu.tearOff 0

proc Scroll {class w args} {
    frame $w
    eval [list $class $w.s] $args

    $w.s configure -xscrollcommand [list $w.sbx set] \
            -yscrollcommand [list $w.sby set]
    scrollbar $w.sbx -orient horizontal -command [list $w.s xview]
    scrollbar $w.sby -orient vertical   -command [list $w.s yview]

    grid $w.s   $w.sby -sticky news
    grid $w.sbx x      -sticky we
    grid columnconfigure $w 0 -weight 1
    grid rowconfigure    $w 0 -weight 1

    return $w.s
}

set w [Scroll text .t -width 80 -height 40 -font "Courier 10"]
textSearch::enableSearch $w -label ::isearch
pack .t -fill both -expand 1

label .l -textvariable ::isearch
grid .l -in .t -row 1 -column 1

menu .m
. configure -menu .m

.m add cascade -label "File" -menu .m.f -underline 0
menu .m.f
.m.f add command -label "Quit" -command exit -underline 0

.m add cascade -label "Search" -menu .m.s -underline 0
menu .m.s
textSearch::searchMenu .m.s

foreach dir {. tcl ../tcl} {
    if {![catch {set ch [open [file join $dir textsearch.tcl] r]}]} {
        $w insert end [read $ch]
        close $ch
        break
    }
}
