#!/bin/sh
#----------------------------------------------------------------------
# $Revision$
#----------------------------------------------------------------------
# the next line restarts using tclsh \
exec tclsh "$0" "$@"

package require tcltest 2.2
namespace import tcltest::*
tcltest::configure -verbose "body error"

# 0   Missing Quote
set expect(0)  {*Could not complete*double quote*}
# 1   Bad Command  
set expect(1)  {*Unknown command "name"*}
# 2   Wrong Number Args 
set expect(2)  {*Procedure "info" does not*}
# 3   Undefined Proc  
set expect(3)  {*Unknown command "name"*}
# 4   Undefined Proc
set expect(4)  {*Unknown command "name"*}
# 5   Bad var to incr in proc
set expect(5)  {Checking file Err.5.tcl}
# 6   Bad var to expr
set expect(6)  {*Unknown variable "noval"*}
# 7   Bad var to expr in proc
set expect(7)  {*Unknown variable "noval"*}
# 8   Bad upvar variable 
set expect(8)  {*Found constant "id"*}
# 9   Bad args to open 
set expect(9)  {*Wrong number of arguments (4) to "open"*}
# 10  Bad arg to array nextelement 
set expect(10) {*Unknown variable "id"*Suspicious variable name "$arrayVar"*}
# 11   Bad cmd: for{...
set expect(11) "*Unknown command \"for\{set\"*"
# 12   Missing close brace 
set expect(12) {*Could not complete*close brace would*}
# 13   eval bad proc 
set expect(13) "*"
# 14   No Error  
set expect(14) "*"
# 15   Missing Close Bracket 
set expect(15) {*Could not complete*close bracket would*}
# 16   Missing Quote
set expect(16) {*Could not complete*double quote would*}

set files {}
for {set t 0} {$t <= 16} {incr t} {
    test nagelfar-clif-1.$t {
        Test case
    } -body {
        exec ../../nagelfar.kit Err.$t.tcl
    } -result $expect($t) -match glob

    lappend files Err.$t.tcl
}

eval [list exec ../../nagelfar.kit] $files > result.txt
