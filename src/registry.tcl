#----------------------------------------------------------------------
# registry.tcl, Support for Windows Registry
#----------------------------------------------------------------------

# Make a labelframe for one registry item
proc makeRegistryFrame {w label key newvalue} {

    set old {}
    catch {set old [registry get $key {}]}

    set l [labelframe $w -text $label -padx 4 -pady 4]

    label $l.key1 -text "Key:"
    label $l.key2 -text $key
    label $l.old1 -text "Old value:"
    label $l.old2 -text $old
    label $l.new1 -text "New value:"
    label $l.new2 -text $newvalue

    button $l.change -text "Change" -width 10 -command \
            "[list registry set $key {} $newvalue] ; \
             [list $l.change configure -state disabled]"
    button $l.delete -text "Delete" -width 10 -command \
            "[list registry delete $key] ; \
             [list $l.delete configure -state disabled]"
    if {$newvalue eq $old} {
        $l.change configure -state disabled
    }
    if {"" eq $old} {
        $l.delete configure -state disabled
    }
    grid $l.key1 $l.key2 -     -sticky "w" -padx 4 -pady 4
    grid $l.old1 $l.old2 -     -sticky "w" -padx 4 -pady 4
    grid $l.new1 $l.new2 -     -sticky "w" -padx 4 -pady 4
    grid $l.delete - $l.change -sticky "w" -padx 4 -pady 4
    grid $l.change -sticky "e"
    grid columnconfigure $l 2 -weight 1
}

# Registry dialog
proc makeRegistryWin {} {
    global thisScript

    # Locate executable for this program
    set exe [info nameofexecutable]
    if {[regexp {^(.*wish)\d+\.exe$} $exe -> pre]} {
        set alt $pre.exe
        if {[file exists $alt]} {
            set a [tk_messageBox -title "Nagelfar" -icon question \
                    -title "Which Wish" -message \
                    "Would you prefer to use the executable\n\
                    \"$alt\"\ninstead of\n\
                    \"$exe\"\nin the registry settings?" -type yesno]
            if {$a eq "yes"} {
                set exe $alt
            }
        }
    }

    set top .reg
    destroy $top
    toplevel $top
    wm title $top "Register Nagelfar"

    # Registry keys

    set key {HKEY_CLASSES_ROOT\.tcl\shell\Check\command}
    set old {}
    catch {set old [registry get {HKEY_CLASSES_ROOT\.tcl} {}]}
    if {$old != ""} {
        set key "HKEY_CLASSES_ROOT\\$old\\shell\\Check\\command"
    }

    # Are we in a starkit?
    if {[info exists ::starkit::topdir]} {
        # In a starpack ?
        set exe [file normalize $exe]
        if {[file normalize $::starkit::topdir] eq $exe} {
            set myexe [list $exe]
        } else {
            set myexe [list $exe $::starkit::topdir]
        }
    } else {
        if {[regexp {wish\d+\.exe} $exe]} {
            set exe [file join [file dirname $exe] wish.exe]
            if {[file exists $exe]} {
                set myexe [list $exe]
            }
        }
        set myexe [list $exe $thisScript]
    }

    set valbase {}
    foreach item $myexe {
        lappend valbase \"[file nativename $item]\"
    }
    set valbase [join $valbase]

    set new "$valbase -gui \"%1\""
    makeRegistryFrame $top.d "Check" $key $new

    pack $top.d -side "top" -fill x -padx 4 -pady 4

    button $top.close -text "Close" -width 10 -command [list destroy $top] \
            -default active
    pack $top.close -side bottom -pady 4
    bind $top <Key-Return> [list destroy $top]
    bind $top <Key-Escape> [list destroy $top]
}

# Add a registry item to a menu, if supported.
proc addRegistryToMenu {m} {
    if {$::tcl_platform(platform) eq "windows"} {
        if {![catch {package require registry}]} {
            $m add separator
            $m add command -label "Setup Registry" -underline 6 \
                    -command makeRegistryWin
        }
    }
}
