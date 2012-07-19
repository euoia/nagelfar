#!/bin/sh
#----------------------------------------------------------------------
# $Revision$
#----------------------------------------------------------------------
# the next line restarts using tclsh \
exec tclsh "$0" "$@"

set thisScript [file normalize [file join [pwd] [info script]]]
set thisDir    [file dirname $thisScript]

package require tcltest
namespace import tcltest::*
tcltest::configure -verbose "body error" -singleproc 1
#tcltest::configure -file oo*
#tcltest::configure -match gui-6*

testConstraint runin86 [expr {[info commands oo::class] ne ""}]
testConstraint runin85 [expr {![catch {list {*}{hej}}]}]
testConstraint runin84 [expr {[catch {list {*}{hej}}]}]
#testConstraint knownbug 1

if {$argc > 0} {
    eval tcltest::configure $argv
}

proc createTestFile {scr {syntaxfile 0}} {
    if {$syntaxfile} {
        set ch [open _testfile_.syntax w]
    } else {
        set ch [open _testfile_ w]
    }
    puts -nonewline $ch $scr
    close $ch
}

proc execTestFile {args} {
    set xx(-fn) _testfile_
    set xx(-flags) {}
    array set xx $args
    set fn $xx(-fn)
    array unset xx -fn
    set flags $xx(-flags)
    array unset xx -flags
    
    set file nagelfar.tcl
    if {[file exists ${file}_i]} {
        set file ${file}_i
    }
    set code [catch {eval [list exec [info nameofexecutable] $file $fn] \
            [array get xx] $flags} res] ;#2>@ stderr
    if {$code && [llength $::errorCode] >= 3} {
        set code [lindex $::errorCode 2]
    }
    # Simplify result by shortening standard result
    regsub {Checking file _testfile_\n?} $res "%%" res
    regsub {Parsing file _testfile_.syntax\n?} $res "xx" res
    regsub {\s*child process exited abnormally\s*} $res "" res
    file delete -force _testfile_.syntax
    return -code $code $res
}    

proc cleanupTestFile {} {
    file delete -force _testfile_
    file delete -force _testfile2_
    file delete -force _testfile_.syntax
}

tcltest::testsDirectory $thisDir
tcltest::runAllTests

cleanupTestFile
