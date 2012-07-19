#----------------------------------------------------------------------
#  Nagelfar, a syntax checker for Tcl.
#  Copyright (c) 1999-2005, Peter Spjuth
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; see the file COPYING.  If not, write to
#  the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
#  Boston, MA 02111-1307, USA.
#
#----------------------------------------------------------------------
# startup.tcl
#----------------------------------------------------------------------

# Output usage info and exit
proc usage {} {
    puts $::version
    puts {Usage: nagelfar [options] scriptfile ...
 -help             : Show usage.
 -gui              : Start with GUI even when files are specified.
 -s <dbfile>       : Include a database file. (More than one is allowed.)
 -encoding <enc>   : Read script with this encoding.
 -filter <p>       : Any message that matches the glob pattern is suppressed.
 -severity <level> : Set severity level filter to N/W/E (default N).
 -html             : Generate html-output.
 -prefix <pref>    : Prefix for line anchors (html output)
 -novar            : Disable variable checking.
 -WexprN           : Sets expression warning level to N.
   2 (def)         = Warn about any unbraced expression.
   1               = Don't warn on single commands. "if [apa] {...}" is ok.
 -WsubN            : Sets subcommand warning level to N.
   1 (def)         = Warn about shortened subcommands.
 -WelseN           : Enforce else keyword. Default 1.
 -strictappend     : Enforce having an initialised variable in (l)append.
 -tab <size>       : Tab size, default is 8.
 -header <file>    : Create a "header" file with syntax info for scriptfiles.
 -instrument       : Instrument source file for code coverage.
 -markup           : Markup source file with code coverage result.
 -quiet            : Suppress non-syntax output.
 -glob <pattern>   : Add matching files to scriptfiles to check.
 -H                : Prefix each error line with file name.
 -exitcode         : Return status code 2 for any error or 1 for warning.}
    exit
}

# Initialise global variables with defaults.
proc StartUp {} {
    set ::Nagelfar(db) {}
    set ::Nagelfar(files) {}
    set ::Nagelfar(gui) 0
    set ::Nagelfar(quiet) 0
    set ::Nagelfar(filter) {}
    set ::Nagelfar(2pass) 1
    set ::Nagelfar(encoding) system
    set ::Nagelfar(dbpicky) 0
    set ::Nagelfar(withCtext) 0
    set ::Nagelfar(instrument) 0
    set ::Nagelfar(header) ""
    set ::Nagelfar(tabReg) { {0,7}\t| {8,8}}
    set ::Nagelfar(tabSub) [string repeat " " 8]
    set ::Nagelfar(tabMap) [list \t $::Nagelfar(tabSub)]
    set ::Nagelfar(procs) {}
    set ::Nagelfar(stop) 0
    if {![info exists ::Nagelfar(embedded)]} {
        set ::Nagelfar(embedded) 0
    }

    getOptions
}

# Procedure to perform a check when embedded.
proc synCheck {fpath dbPath} {
    set ::Nagelfar(files) [list $fpath]
    set ::Nagelfar(allDb) {}
    set ::Nagelfar(allDbView) {}
    set ::Nagelfar(allDb) [list $dbPath]
    set ::Nagelfar(allDbView) [list [file tail $dbPath] "(app)"]
    set ::Nagelfar(db) [list $dbPath]
    set ::Nagelfar(embedded) 1
    set ::Nagelfar(chkResult) ""
    doCheck
    return $::Nagelfar(chkResult)
}


# Global code is only run first time to allow re-sourcing
if {![info exists gurka]} {
    set gurka 1

    StartUp

    if {[info exists _nagelfar_test]} return
    # To use Nagelfar embedded, set ::Nagelfar(embedded) 1
    # before sourcing nagelfar.tcl.
    if {$::Nagelfar(embedded)} return

    # Locate default syntax database(s)
    set ::Nagelfar(allDb) {}
    set ::Nagelfar(allDbView) {}
    set apa {}
    lappend apa [file join [pwd] syntaxdb.tcl]
    eval lappend apa [glob -nocomplain [file join [pwd] syntaxdb*.tcl]]

    lappend apa [file join $::dbDir syntaxdb.tcl]
    eval lappend apa [glob -nocomplain [file join $::dbDir syntaxdb*.tcl]]

    foreach file $apa {
        if {[file isfile $file] && [file readable $file] && \
                [lsearch $::Nagelfar(allDb) $file] == -1} {
            lappend ::Nagelfar(allDb) $file
            if {[file dirname $file] == $::dbDir} {
                lappend ::Nagelfar(allDbView) "[file tail $file] (app)"
            } else {
                lappend ::Nagelfar(allDbView) [fileRelative [pwd] $file]
            }
        }
    }

    # Parse command line options
    for {set i 0} {$i < $argc} {incr i} {
        set arg [lindex $argv $i]
        switch -glob -- $arg {
            --h* -
            -h - -hel* {
                usage
            }
            -s {
                incr i
                set arg [lindex $argv $i]
                if {[file isfile $arg] && [file readable $arg]} {
                    lappend ::Nagelfar(db) $arg
                    lappend ::Nagelfar(allDb) $arg
                    lappend ::Nagelfar(allDbView) $arg
                } else {
                    # Look through allDb for a match
                    set found 0
                    foreach db $::Nagelfar(allDb) {
                        if {$arg eq $db || $arg eq [file tail $db]} {
                            lappend ::Nagelfar(db) $db
                            set found 1
                            break
                        }
                    }
                    if {!$found} {
                        puts stderr "Cannot read \"$arg\""
                    }
                }
            }
 	    -editor {
                incr i
                set arg [lindex $argv $i]
		switch -glob -- $arg {
		    ema*    {set ::Prefs(editor) emacs}
		    inte*   {set ::Prefs(editor) internal}
		    vi*     {set ::Prefs(editor) vim}
		    default {
                        puts stderr "Bad -editor option: \"$arg\""
                    }
		}
            }
            -encoding {
                incr i
                set enc [lindex $argv $i]
                if {$enc eq ""} {set enc system}
                if {[lsearch -exact [encoding names] $enc] < 0} {
                    puts stderr "Bad encoding name: \"$enc\""
                    set enc system
                }
                set ::Nagelfar(encoding) $enc
            }
            -H {
                set ::Prefs(prefixFile) 1
            }
            -exitcode {
                set ::Prefs(exitcode) 1
            }
            -2pass {
                set ::Nagelfar(2pass) 1
            }
            -gui {
                set ::Nagelfar(gui) 1
            }
            -quiet {
                set ::Nagelfar(quiet) 1
            }
            -header {
                incr i
                set arg [lindex $argv $i]
                set ::Nagelfar(header) $arg
                # Put checks down as much as possible
                array set ::Prefs {
                    warnBraceExpr 0
                    warnShortSub 0
                    strictAppend 0
                    forceElse 0
                    severity E
                }
            }
            -instrument {
                set ::Nagelfar(instrument) 1
                # Put checks down as much as possible
                array set ::Prefs {
                    warnBraceExpr 0
                    warnShortSub 0
                    strictAppend 0
                    forceElse 0
                    noVar 1
                    severity E
                }
            }
            -markup {
                incr i
                if {$i < $argc} {
                    lappend ::Nagelfar(files) [lindex $argv $i]
                }
                instrumentMarkup [lindex $::Nagelfar(files) 0]
                exit
            }
            -novar {
                set ::Prefs(noVar) 1
            }
            -dbpicky { # A debug thing to help make a more complete database
                set ::Nagelfar(dbpicky) 1
            }
            -Wexpr* {
                set ::Prefs(warnBraceExpr) [string range $arg 6 end]
            }
            -Wsub* {
                set ::Prefs(warnShortSub) [string range $arg 5 end]
            }
            -Welse* {
                set ::Prefs(forceElse) [string range $arg 6 end]
            }
            -strictappend {
                set ::Prefs(strictAppend) 1
            }
            -filter {
                incr i
                addFilter [lindex $argv $i]
            }
            -severity {
                incr i
                set ::Prefs(severity) [lindex $argv $i]
                if {![regexp {^[EWN]$} $::Prefs(severity)]} {
                    puts "Bad severity level '$::Prefs(severity)',\
                            should be E/W/N."
                    exit
                }
            }
            -html {
                set ::Prefs(html) 1
            }
            -prefix {
                incr i
                set ::Prefs(htmlprefix) [lindex $argv $i]
            }
 	    -tab {
                incr i
                set arg [lindex $argv $i]
                if {![string is integer -strict $arg] || \
                        $arg < 2 || $arg > 20} {
                    puts "Bad tab value '$arg'"
                    exit
                }
                set ::Nagelfar(tabReg) " {0,[expr {$arg - 1}]}\t| {$arg,$arg}"
                set ::Nagelfar(tabSub) [string repeat " " $arg]
                set ::Nagelfar(tabMap) [list \t $::Nagelfar(tabSub)]
            }
            -glob {
                incr i
                set files [glob -nocomplain [lindex $argv $i]]
                set ::Nagelfar(files) [concat $::Nagelfar(files) $files]
            }
             -* {
                puts "Unknown option $arg"
                usage
            }
            default {
                lappend ::Nagelfar(files) $arg
            }
        }
    }

    # Use default database if none were given
    if {[llength $::Nagelfar(db)] == 0} {
        if {[llength $::Nagelfar(allDb)] != 0} {
            lappend ::Nagelfar(db) [lindex $::Nagelfar(allDb) 0]
        }
    }

    # If we are on Windows and Tk is already loaded it means we run in
    # wish, and there is no stdout. Thus non-gui is pointless.
    if {!$::Nagelfar(gui) && $::tcl_platform(platform) eq "windows" &&
        [package provide Tk] ne ""} {
        set ::Nagelfar(gui) 1
    }

    # If there is no file specified, try invoking a GUI
    if {$::Nagelfar(gui) || [llength $::Nagelfar(files)] == 0} {
        if {[catch {package require Tk}]} {
            if {$::Nagelfar(gui)} {
                puts stderr "Failed to start GUI"
                exit 1
            } else {
                puts stderr "No files specified"
                exit 1
            }
        }
        # use ctext if available
        if {![catch {package require ctext}]} {
            if {![catch {package require ctext_tcl}]} {
                if {[info procs ctext::setHighlightTcl] ne ""} {
                    set ::Nagelfar(withCtext) 1
                    proc ctext::update {} {::update}
                }
            }
        }

        catch {package require textSearch}
        set ::Nagelfar(gui) 1
        makeWin
        vwait forever
        exit
    }

    doCheck

    #_dumplogme
    #if {[array size _stats] > 0} {
    #    array set _apa [array get _stats]
    #    parray _apa
    #    set sum 0
    #    foreach name [array names _apa] {
    #        incr sum $_apa($name)
    #    }
    #    puts "Total $sum"
    #}
    exit [expr {$::Prefs(exitcode) ? $::Nagelfar(exitstatus) : 0}]
}
