#!/bin/sh
# the next line restarts using tclsh \
exec tclsh "$0" "$@"

set cho [open test.html w]

puts $cho "<html>"
puts $cho "<body>"

puts $cho {<table cellpadding="2" cellspacing="0" border="1">}
puts $cho "  <tbody>"
puts $cho "    <tr>"
puts $cho "      <th>Test File</th>"
puts $cho "      <th>The result of checking it:</th>"
puts $cho "    </tr>"
puts $cho "    <tr>"

puts $cho {<td style="vertical-align: top; white-space: nowrap;"><pre>}
set ch [open test.tcl r]
set n 1
while {[gets $ch line] != -1} {

    if {[regexp {^([^#]*)(#.*)$} $line -> pre post]} {
        set line "$pre<span style=\"color: #b22222\">$post</span>"
    }
    puts $cho [format "<span style=\"color: #808080\">%3d</span>  %s" $n $line]
    incr n
}
close $ch
puts $cho "</pre></td>"


puts $cho {<td style="vertical-align: top; white-space: nowrap;"><pre>}
set ch [open test.result r]
set n 1
while {[gets $ch line] != -1} {
    if {[regexp {^Line\s+(\d+)} $line -> errLine]} {
        while {$errLine > $n} {
            puts $cho ""
            incr n
        }
    }
    puts $cho $line
    incr n
}
close $ch
puts $cho "</pre></td>"

puts $cho "</tr>"
puts $cho "</tbody>"
puts $cho "</table>"

puts $cho "</body>"
puts $cho "</html>"

close $cho
