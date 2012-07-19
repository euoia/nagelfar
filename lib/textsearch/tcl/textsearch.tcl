#----------------------------------------------------------------------
#
#  textsearch.tcl,
#     a package providing search facilites for the text widget
#
#  Copyright (c) 2003-2006, Peter Spjuth  (peter.spjuth@gmail.com)
#
#----------------------------------------------------------------------
# $Revision: 1.4 $
#----------------------------------------------------------------------

package require Tk 8.4
package provide textSearch 0.3

namespace eval textSearch {
    namespace export enableSearch searchMenu

    variable isearchW ""
    variable isearchLast ""
    variable searchCase 0
    variable searchWhole 0
    variable searchIndex 1.0
    variable searchString ""

    if {[info commands ::ttk::*] ne ""} {
        catch {namespace path ::ttk}
    }
}

# Setup a text widget for searching
proc textSearch::enableSearch {w args} {
    variable widgets
    variable isearchLabel

    set class [winfo class $w]
    if {$class != "Text" && $class != "Ctext"} {
        error "Only text widgets can be searched!"
    }
    # Try to get the "real" text widget in ctext.
    if {$class eq "Ctext"} {
        if {[winfo exists $w.t]} {
            set w $w.t
        } else {
            error "Only text widgets can be searched!"
        }
    }

    set opts(isearch) 1
    set opts(search)  1
    set opts(label) ""
    
    set value ""
    foreach arg $args {
        if {$value != ""} {
            set opts($value) $arg
            set value ""
        } else {
            switch -- $arg {
                -noisearch {
                    set opts(isearch) 0
                }
                -nosearch {
                    set opts(search) 0
                }
                -label {
                    set value label
                }
                default {
                    return -code error "bad switch \"$arg\": must be -noisearch, or -isearch"
                }
            }
        }
    }

    # Create an extra tag that looks like the selection tag.
    # On windows, the selection is not drawn unless the text widget has
    # focus.  This is fixed by the extra tag.
    foreach conf [$w tag configure sel] {
        foreach {opt d1 d2 def val} $conf break
        if {$val != ""} {
            $w tag configure _textSearchSel $opt $val
        }
    }
    
    bind textSearchIS <Control-Key-s> "textSearch::startIncrementalSearch %W"
    if {$opts(isearch)} {
        bindtags $w "textSearchIS [bindtags $w]"
        set isearchLabel($w) $opts(label)
    }

    if {$opts(search)} {
        set top [winfo toplevel $w]

        if {![info exists widgets($top)] || [lsearch $widgets($top) $w] < 0} {
            lappend widgets($top) $w
        }

        bind $top <Control-Key-f>  textSearch::search
        bind $top <Key-F3>         textSearch::searchNext
        bind $top <Shift-Key-F3>  "textSearch::searchNext 1"
    }
}

# Add searching to a menu
proc textSearch::searchMenu {menu} {
    $menu add command -label "Find..."   -accelerator "Ctrl+F" \
            -command ::textSearch::search -underline 0
    $menu add command -label "Find Next" -accelerator "F3" \
            -command ::textSearch::searchNext -underline 5
    $menu add command -label "Find Prev" -accelerator "Shift+F3" \
            -command "::textSearch::searchNext 1" -underline 5
}

# Start an incremental search
proc textSearch::startIncrementalSearch {w} {
    variable isearchW
    variable isearchString
    variable isearchHistory
    variable isearchIndex
    variable isearchLabel

    # This shouldn't happen
    if {$isearchW != ""} {
        endIncrementalSearch
    }

    set isearchW $w

    # Setup all bindings for incremental search
    bind textSearchIS <Control-Key-s> "textSearch::isearchAgain %W ; break"
    bind textSearchIS <Key-Delete>    "textSearch::isearchBack %W ; break"
    bind textSearchIS <Key-BackSpace> "textSearch::isearchBack %W ; break"
    bind textSearchIS <Key>           "textSearch::isearchKey %W %A %s %K"
    bind textSearchIS <Key-Escape>    "textSearch::endIncrementalSearch ; break"
    bind textSearchIS <Control-Key-g> "textSearch::endIncrementalSearch ; break"
    bind textSearchIS <FocusOut>      "textSearch::endIncrementalSearch"

    # Initialise variables
    set isearchString ""
    set isearchHistory {}
    set isearchIndex [$w index insert]
    if {$isearchLabel($w) != ""} {
        uplevel \#0 [list set $isearchLabel($w) "i"]
    }
}

# Highlight a match
proc textSearch::isearchShow {w index string} {
    variable isearchString
    variable isearchLast
    variable isearchIndex

    $w tag remove sel 1.0 end
    $w tag add sel $index "$index + [string length $string] chars"
    $w mark set insert $index
    $w see "$index + 5 lines"
    $w see $index

    set isearchIndex $index
    set isearchString $string
    set isearchLast $string
}

# Search the widget
proc textSearch::isearchSearch {w str ix} {
    # If the search string is all lower case, search case insensitive
    if {[string equal [string tolower $str] $str]} {
        set found [$w search -nocase -- $str $ix]
    } else {
        set found [$w search -- $str $ix]
    }
    return $found
}

# Search for next match
proc textSearch::isearchAgain {w} {
    variable isearchW
    variable isearchHistory
    variable isearchIndex
    variable isearchString
    variable isearchLast

    if {$w != $isearchW} {
        bell
        endIncrementalSearch
        return
    }

    set str $isearchString
    if {$str == ""} {
        set str $isearchLast
    }
    set found [isearchSearch $w $str "$isearchIndex + 1 char"]
    if {$found == ""} {
        bell
        return
    }
    lappend isearchHistory $isearchIndex $isearchString
    isearchShow $w $found $str
}

# A key has been pressed during incremental search
proc textSearch::isearchKey {w key state sym} {
    variable isearchW
    variable isearchHistory
    variable isearchIndex
    variable isearchString

    if {$w != $isearchW} {
        bell
        endIncrementalSearch
        return -code break
    }

    if {$key == ""} {
        # Ignore the Control and Shift keys
        if {[string match Contr* $sym]} {return -code break}
        if {[string match Shift* $sym]} {return -code break}
        # Ignore any Control-ed key
        if {$state == 4} {return -code break}
        # Break isearch on other non-ascii keys, and let it through
        bell
        endIncrementalSearch
        return
    }

    set str $isearchString
    append str $key

    set found [isearchSearch $w $str $isearchIndex]
    if {$found == ""} {
        bell
        return -code break
    }
    lappend isearchHistory $isearchIndex $isearchString
    isearchShow $w $found $str
    return -code break
}

# Go backwards in the isearch stack
proc textSearch::isearchBack {w} {
    variable isearchW
    variable isearchHistory

    if {$w != $isearchW} {
        bell
        endIncrementalSearch
        return
    }
    if {[llength $isearchHistory] < 2} {
        bell
        return
    }

    set str   [lindex $isearchHistory end]
    set found [lindex $isearchHistory end-1]
    set isearchHistory [lrange $isearchHistory 0 end-2]

    isearchShow $w $found $str
}

# End an incremental search
proc textSearch::endIncrementalSearch {} {
    variable isearchW
    variable isearchLabel

    if {$isearchLabel($isearchW) != ""} {
        uplevel \#0 [list set $isearchLabel($isearchW) ""]
    }
    set isearchW ""

    # Remove all bindings from textSearchIS
    foreach b [bind textSearchIS] {
        bind textSearchIS $b ""
    }

    bind textSearchIS <Control-Key-s> "textSearch::startIncrementalSearch %W"
}

# A generic Dialog proc
proc textSearch::Dialog {args} {
    set arg(-parent) .
    set arg(-title) ""
    set arg(-body) {pack [button $top.b -text Ok -command "destroy $top"]}

    foreach {opt val} $args {
	set arg($opt) $val
    }

    if {$arg(-parent) == "."} {
	set arg(-parent) ""
    }

    # Create Toplevel
    set t 0
    set top $arg(-parent).dialog_$t
    while {[winfo exists $top]} {
	incr t
	set top $arg(-parent).dialog_$t
    }

    toplevel $top
    wm title $top $arg(-title)

    set oldfocus [focus -displayof $top]

    # Define the variable "top" in the callers context and
    # execure the body there.

    if {[uplevel 1 {info exists top}]} {
	set oldtop [uplevel 1 {set top}]
    }

    uplevel 1 [list set top $top]
    uplevel 1 $arg(-body)

    if {[info exists oldtop]} {
	uplevel 1 [list set top $oldtop]
    } else {
	uplevel 1 {unset top}
    }

    # Grab focus for the dialog unless the user did it in the body
    if {[winfo toplevel [focus -displayof $top]] != $top} {
	focus $top
    }
    catch {tkwait visibility $top}
    catch {grab $top}

    # Wait for the dialog to complete
    tkwait window $top
    catch {grab release $top}
    focus $oldfocus
}

proc textSearch::DismissDialog {top} {
    variable prompt
    variable searchWin

    set prompt(geo) [wm geometry $top]
    destroy $top

    $searchWin tag remove _textSearchSel 1.0 end
}

# Ask for a search string
proc textSearch::FindDialog {} {
    variable prompt

    Dialog -title Find -body {
        $top configure -padx 4 -pady 4
        frame $top.f
        label $top.f.l -text "Find text:" -anchor w -underline 5
        bind $top <Alt-Key-t> [list focus $top.f.entry]
        entry $top.f.entry -textvariable ::textSearch::searchString -width 30
        pack $top.f.l -side left -ipadx 10
        pack $top.f.entry -side right -fill x -expand 1

        checkbutton $top.whole -text "Match whole words" \
                -underline 6 \
                -variable ::textSearch::searchWhole
        bind $top <Alt-Key-w> [list $top.whole invoke]
        checkbutton $top.case -text "Match upper/lower case" \
                -underline 0 \
                -variable ::textSearch::searchCase
        bind $top <Alt-Key-m> [list $top.case invoke]
    
        button $top.next   -text "Find next" -width 10 -default active \
                -command ::textSearch::searchNext
        button $top.cancel -text Cancel -width 10 -default normal \
                -command [list ::textSearch::DismissDialog $top]
    
        grid $top.f     - $top.next    -sticky we -padx 4 -pady 4
        grid $top.whole x $top.cancel  -sticky w  -padx 4 -pady 4
        grid $top.case  x ^            -sticky w  -padx 4 -pady 4
        grid $top.cancel -sticky nwe

        grid columnconfigure $top 1 -weight 1
        grid columnconfigure $top 1 -minsize 10 -weight 2
        grid rowconfigure $top 3 -weight 1
    
        bind $top.f.entry <Key-Return> \
                "[list $top.next invoke] ; break"
        bind $top.f.entry <Key-Escape> \
                "[list $top.cancel invoke] ; break"
        focus $top.f.entry
	if {[info exists prompt(geo)]} {
	    wm geometry $top $prompt(geo)
	}
    }
}

# "Normal" search
proc textSearch::search {} {
    variable searchWin
    variable widgets
    variable searchIndex

    set foc [focus -displayof .]
    set top [winfo toplevel $foc]
    set searchWin [lindex $widgets($top) 0]
    if {[lsearch $widgets($top) $foc] >= 0} {
        set searchWin $foc
    }
    set searchIndex [$searchWin index "@0,0 - 1 chars"]
    FindDialog
}

# Search again
proc textSearch::searchNext {{backwards 0}} {
    variable searchString
    variable searchWin
    variable searchCase
    variable searchWhole
    variable searchIndex

    if {$searchString == ""} return

    set cmd [list $searchWin search -count cnt]

    if {!$searchCase} {
        lappend cmd "-nocase"
    }
    if {$backwards} {
        lappend cmd "-backwards"
    }

    if {$searchWhole} {
        lappend cmd "-regexp"
        lappend cmd "--"
        regsub -all {[][\\().*+{}]} $searchString {\\&} RE
        lappend cmd "\\y$RE\\y"
    } else {
        lappend cmd "--"
        lappend cmd $searchString
    }

    if {$backwards} {
        lappend cmd "$searchIndex - 1 chars"
    } else {
        lappend cmd "$searchIndex + 1 chars"
    }
    set searchPos [eval $cmd]

    if {$searchPos == "" || $searchPos == $searchIndex} {
        tk_messageBox -message "String not found!" -type ok -title "Find"
        return
    }

    if {$backwards} {
        $searchWin see "$searchPos - 5 lines"
    } else {
        $searchWin see "$searchPos + 5 lines"
    }
    $searchWin see $searchPos
    $searchWin tag remove sel 1.0 end
    $searchWin tag remove _textSearchSel 1.0 end
    $searchWin tag add sel $searchPos "$searchPos + $cnt chars"
    if {[focus -displayof $searchWin] != $searchWin} {
        $searchWin tag add _textSearchSel $searchPos "$searchPos + $cnt chars"
    }
    set searchIndex $searchPos
}
