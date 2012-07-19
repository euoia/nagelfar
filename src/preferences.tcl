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
# preferences.tcl
#----------------------------------------------------------------------

# Save default options
proc saveOptions {} {
    if {[catch {set ch [open "~/.nagelfarrc" w]}]} {
        errEcho "Could not create options file."
        return
    }

    foreach i [array names ::Prefs] {
        puts $ch [list set ::Prefs($i) $::Prefs($i)]
    }
    close $ch
}

# Fill in default options and load user's saved file
proc getOptions {} {
    array set ::Prefs {
        warnBraceExpr 2
        warnShortSub 1
        strictAppend 0
        prefixFile 0
        forceElse 1
        noVar 0
        severity N
        editFileBackup 1
        editFileFont {Courier 10}
        resultFont {Courier 10}
        editor internal
        extensions {.tcl .test .adp .tk}
        exitcode 0
        html 0
        htmlprefix ""
    }

    # Do not load anything during test
    if {[info exists ::_nagelfar_test]} return

    foreach candidate {.nagelfarrc ~/.nagelfarrc} {
        if {[file exists $candidate]} {
            interp create -safe loadinterp
            interp expose loadinterp source
            interp eval loadinterp source $candidate
            array set ::Prefs [interp eval loadinterp array get ::Prefs]
            interp delete loadinterp
            break
        }
    }
}

# Add an "Options" cascade to a menu
proc addOptionsMenu {m} {
    $m add cascade -label "Options" -underline 0 -menu $m.mo
    menu $m.mo

    $m.mo add cascade -label "Result Window Font" -menu $m.mo.mo
    menu $m.mo.mo
    $m.mo.mo add radiobutton -label "Small" \
	    -variable ::Prefs(resultFont) -value "Courier 8" \
	    -command {font configure ResultFont -size 8}
    $m.mo.mo add radiobutton -label "Medium" \
	    -variable ::Prefs(resultFont) -value "Courier 10" \
	    -command {font configure ResultFont -size 10}
    $m.mo.mo add radiobutton -label "Large" \
	    -variable ::Prefs(resultFont) -value "Courier 14" \
	    -command {font configure ResultFont -size 14}

    $m.mo add cascade -label "Editor" -menu $m.mo.med
    menu $m.mo.med
    $m.mo.med add radiobutton -label "Internal" \
            -variable ::Prefs(editor) -value internal
    $m.mo.med add radiobutton -label "Emacs" \
            -variable ::Prefs(editor) -value emacs
    $m.mo.med add radiobutton -label "Vim" \
            -variable ::Prefs(editor) -value vim

    if {$::tcl_platform(platform) == "windows"} {
        $m.mo.med add radiobutton -label "Pfe" \
                -variable ::Prefs(editor) -value pfe
    }

    $m.mo add separator

    $m.mo add cascade -label "Severity level" -menu $m.mo.ms
    menu $m.mo.ms
    $m.mo.ms add radiobutton -label "Show All (E/W/N)" \
            -variable ::Prefs(severity) -value N
    $m.mo.ms add radiobutton -label {Show Warnings (E/W)} \
            -variable ::Prefs(severity) -value W
    $m.mo.ms add radiobutton -label {Show Errors (E)} \
            -variable ::Prefs(severity) -value E

    $m.mo add checkbutton -label "Warn about shortened subcommands" \
            -variable ::Prefs(warnShortSub)
    $m.mo add cascade -label "Braced expressions" -menu $m.mo.mb
    menu $m.mo.mb
    $m.mo.mb add radiobutton -label "Allow unbraced" \
            -variable ::Prefs(warnBraceExpr) -value 0
    $m.mo.mb add radiobutton -label {Allow 'if [cmd] {xxx}'} \
            -variable ::Prefs(warnBraceExpr) -value 1
    $m.mo.mb add radiobutton -label "Warn on any unbraced" \
            -variable ::Prefs(warnBraceExpr) -value 2
    $m.mo add checkbutton -label "Enforce else keyword" \
            -variable ::Prefs(forceElse)
    $m.mo add checkbutton -label "Strict (l)append" \
            -variable ::Prefs(strictAppend)
    $m.mo add checkbutton -label "Disable variable checking" \
            -variable ::Prefs(noVar)

    $m.mo add cascade -label "Script encoding" -menu $m.mo.me
    menu $m.mo.me
    $m.mo.me add radiobutton -label "Ascii" \
            -variable ::Nagelfar(encoding) -value ascii
    $m.mo.me add radiobutton -label "Iso8859-1" \
            -variable ::Nagelfar(encoding) -value iso8859-1
    $m.mo.me add radiobutton -label "System ([encoding system])" \
            -variable ::Nagelfar(encoding) -value system


    $m.mo add separator
    $m.mo add command -label "Save Options" -command saveOptions

}
