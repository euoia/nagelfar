#----------------------------------------------------------------------
# dbbrowser.tcl, Database browser
#----------------------------------------------------------------------

proc makeDbBrowserWin {} {
    if {[winfo exists .db]} {
        wm deiconify .db
        raise .db
        set w $::Nagelfar(dbBrowserWin)
    } else {
        toplevel .db
        wm title .db "Nagelfar Database"

        set w [Scroll y text .db.t -wrap word \
                       -width 80 -height 15 -font $::Prefs(editFileFont)]
        set ::Nagelfar(dbBrowserWin) $w
        $w tag configure all -lmargin2 2c
        set f [frame .db.f -padx 3 -pady 3]
        grid .db.f -sticky we
        grid .db.t -sticky news
        grid columnconfigure .db 0 -weight 1
        grid rowconfigure .db 1 -weight 1

        label $f.l -text "Command"
        entry $f.e -textvariable ::Nagelfar(dbBrowserCommand) -width 15
        button $f.b -text "Search" -command dbBrowserSearch -default active

        grid $f.l $f.e $f.b -sticky ew -padx 3
        grid columnconfigure $f 1 -weight 1

        bind .db <Key-Return> dbBrowserSearch
    }
}

proc dbBrowserSearch {} {
    set cmd $::Nagelfar(dbBrowserCommand)
    set w $::Nagelfar(dbBrowserWin)

    loadDatabases
    $w delete 1.0 end

    # Must be at least one word char in the pattern
    set pat $cmd*
    if {![regexp {\w} $pat]} {
        set pat ""
    }

    foreach item [lsort -dictionary [array names ::syntax $pat]] {
        $w insert end "\#\#nagelfar syntax [list $item]"
        $w insert end " "
        $w insert end $::syntax($item)\n
    }
    foreach item [lsort -dictionary [array names ::subCmd $pat]] {
        $w insert end "\#\#nagelfar subcmd [list $item]"
        $w insert end " "
        $w insert end $::subCmd($item)\n
    }
    foreach item [lsort -dictionary [array names ::option $pat]] {
        $w insert end "\#\#nagelfar option [list $item]"
        $w insert end " "
        $w insert end $::option($item)\n
    }
    foreach item [lsort -dictionary [array names ::return $pat]] {
        $w insert end "\#\#nagelfar return [list $item]"
        $w insert end " "
        $w insert end $::return($item)\n
    }

    if {[$w index end] eq "2.0"} {
        $w insert end "No match!"
    }
    $w tag add all 1.0 end
}
