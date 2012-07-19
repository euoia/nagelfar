#----------------------------------------------------------------------
#  Nagelfar, a syntax checker for Tcl.
#  Copyright (c) 1999-2007, Peter Spjuth
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
# gui.tcl
#----------------------------------------------------------------------

proc busyCursor {} {
    if {![info exists ::oldcursor]} {
        set ::oldcursor  [. cget -cursor]
        set ::oldcursor2 [$::Nagelfar(resultWin) cget -cursor]
    }

    . config -cursor watch
    $::Nagelfar(resultWin) config -cursor watch
}

proc normalCursor {} {
    . config -cursor $::oldcursor
    $::Nagelfar(resultWin) config -cursor $::oldcursor2
}

proc exitApp {} {
    exit
}

# Browse for and add a syntax database file
proc addDbFile {} {
    if {[info exists ::Nagelfar(lastdbdir)]} {
        set initdir $::Nagelfar(lastdbdir) 
    } elseif {[info exists ::Nagelfar(lastdir)]} {
        set initdir $::Nagelfar(lastdir)
    } else {
        set initdir [pwd]
    }
    set apa [tk_getOpenFile -title "Select db file" \
            -initialdir $initdir]
    if {$apa == ""} return

    lappend ::Nagelfar(db) $apa
    lappend ::Nagelfar(allDb) $apa
    lappend ::Nagelfar(allDbView) $apa
    updateDbSelection 1
    set ::Nagelfar(lastdbdir) [file dirname $apa]
}

# File drop using TkDnd
proc fileDropDb {files} {
    foreach file $files {
        set file [fileRelative [pwd] $file]
        lappend ::Nagelfar(db) $file
        lappend ::Nagelfar(allDb) $file
        lappend ::Nagelfar(allDbView) $file
    }
    updateDbSelection 1
}

# Remove a file from the database list
proc removeDbFile {} {
    set ixs [lsort -decreasing -integer [$::Nagelfar(dbWin) curselection]]
    foreach ix $ixs {
        set ::Nagelfar(allDb) [lreplace $::Nagelfar(allDb) $ix $ix]
        set ::Nagelfar(allDbView) [lreplace $::Nagelfar(allDbView) $ix $ix]
    }
    updateDbSelection
    updateDbSelection 1
}

# Browse for and add a file to check.
proc addFile {} {
    if {[info exists ::Nagelfar(lastdir)]} {
        set initdir $::Nagelfar(lastdir)
    } elseif {[info exists ::Nagelfar(lastdbdir)]} {
        set initdir $::Nagelfar(lastdbdir) 
    } else {
        set initdir [pwd]
    }
    
    set filetypes [list {{Tcl Files} {.tcl}} \
            [list {All Tcl Files} $::Prefs(extensions)] \
            {{All Files} {.*}}]
    set apa [tk_getOpenFile -title "Select file(s) to check" \
            -initialdir $initdir \
            -defaultextension .tcl -multiple 1 \
            -filetypes $filetypes]
    if {[llength $apa] == 0} return

    set newpwd [file dirname [lindex $apa 0]]
    if {[llength $::Nagelfar(files)] == 0 && $newpwd ne [pwd]} {
        set res [tk_messageBox -title "Nagelfar" -icon question -type yesno \
                -message \
                "Change current directory to [file nativename $newpwd] ?"]
        if {$res eq "yes"} {
            cd $newpwd
        }
    }
    set skipped {}
    foreach file $apa {
        set relfile [fileRelative [pwd] $file]
        if {[lsearch -exact $::Nagelfar(files) $relfile] >= 0} {
            lappend skipped $relfile
            continue
        }
        lappend ::Nagelfar(files) $relfile
        set ::Nagelfar(lastdir) [file dirname $file]
    }
    if {[llength $skipped] > 0} {
        tk_messageBox -title "Nagelfar" -icon info -type ok -message \
                "Skipped duplicate file"
    }
}

# Remove a file from the list to check
proc removeFile {} {
    set ixs [lsort -decreasing -integer [$::Nagelfar(fileWin) curselection]]
    foreach ix $ixs {
        set ::Nagelfar(files) [lreplace $::Nagelfar(files) $ix $ix]
    }
}

# Move a file up/down file list
proc moveFile {dir} {
    # FIXA: Allow this line on a global level or in .syntax file
    ##nagelfar variable ::Nagelfar(fileWin) _obj,listbox
    set ix [lindex [$::Nagelfar(fileWin) curselection] 0]
    if {$ix eq ""} return
    set len [llength $::Nagelfar(files)]
    set nix [expr {$ix + $dir}]
    if {$nix < 0 || $nix >= $len} return
    set item [lindex $::Nagelfar(files) $ix]
    set ::Nagelfar(files) [lreplace $::Nagelfar(files) $ix $ix]
    set ::Nagelfar(files) [linsert $::Nagelfar(files) $nix $item]
    $::Nagelfar(fileWin) see $nix 
    $::Nagelfar(fileWin) selection clear 0 end
    $::Nagelfar(fileWin) selection set $nix
    $::Nagelfar(fileWin) selection anchor $nix
    $::Nagelfar(fileWin) activate $nix
}

# File drop using TkDnd
proc fileDropFile {files} {
    foreach file $files {
        lappend ::Nagelfar(files) [fileRelative [pwd] $file]
    }
}
# This shows the file and the line from an error in the result window.
proc showError {{lineNo {}}} {
    set w $::Nagelfar(resultWin)
    if {$lineNo == ""} {
        set lineNo [lindex [split [$w index current] .] 0]
    }

    $w tag remove hl 1.0 end
    $w tag add hl $lineNo.0 $lineNo.end
    $w mark set insert $lineNo.0
    set line [$w get $lineNo.0 $lineNo.end]

    if {[regexp {^(.*): Line\s+(\d+):} $line -> fileName fileLine]} {
        editFile $fileName $fileLine
    } elseif {[regexp {^Line\s+(\d+):} $line -> fileLine]} {
        editFile "" $fileLine
    }
}

# Scroll a text window to view a certain line, and possibly some
# lines before and after.
proc seeText {w si} {
    $w see $si
    $w see $si-3lines
    $w see $si+3lines
    if {[llength [$w bbox $si]] == 0} {
        $w yview $si-3lines
    }
    if {[llength [$w bbox $si]] == 0} {
        $w yview $si
    }
}

# Make next "E" error visible
proc seeNextError {} {
    set w $::Nagelfar(resultWin)
    set lineNo [lindex [split [$w index insert] .] 0]

    set index [$w search -exact ": E " $lineNo.end]
    if {$index eq ""} {
        $w see end
        return
    }
    seeText $w $index
    set lineNo [lindex [split $index .] 0]
    $w tag remove hl 1.0 end
    $w tag add hl $lineNo.0 $lineNo.end
    $w mark set insert $lineNo.0
}

proc resultPopup {x y X Y} {
    set w $::Nagelfar(resultWin)

    set index [$w index @$x,$y]
    set tags [$w tag names $index]
    set tag [lsearch -glob -inline $tags "message*"]
    if {$tag == ""} {
        set lineNo [lindex [split $index .] 0]
        set line [$w get $lineNo.0 $lineNo.end]
    } else {
        set range [$w tag nextrange $tag 1.0]
        set line [lindex [split [eval \$w get $range] \n] 0]
    }

    destroy .popup
    menu .popup

    if {[regexp {^(.*): Line\s+(\d+):} $line -> fileName fileLine]} {
        .popup add command -label "Show File" \
                -command [list editFile $fileName $fileLine]
    }
    if {[regexp {^(.*): Line\s+\d+:\s*(.*)$} $line -> pre post]} {
        .popup add command -label "Filter this message" \
                -command [list addFilter "*$pre*$post*" 1]
        .popup add command -label "Filter this message in all files" \
                -command [list addFilter "*$post*" 1]
        regsub {".+?"} $post {"*"} post2
        regsub -all {\d+} $post2 {*} post2
        if {$post2 ne $post} {
            .popup add command -label "Filter this generic message" \
                    -command [list addFilter "*$post2*" 1]
        }
    }
    # FIXA: This should be handled abit better.
    .popup add command -label "Reset all filters" -command resetFilters

    if {[$::Nagelfar(resultWin) get 1.0 1.end] ne ""} {
        .popup add command -label "Save Result" -command saveResult
    }

    tk_popup .popup $X $Y
}

# Save result as file
proc saveResult {} {
    # set initial filename to 1st file in list
    set iniFile [file rootname [lindex $::Nagelfar(files) 0]]
    if {$iniFile == ""} {
        set iniFile "noname"
    }
    append iniFile ".nfr"
    set iniDir [file dirname $iniFile]
    set types {
        {"Nagelfar Result" {.nfr}}
        {"All Files" {*}}
    }
    set file [tk_getSaveFile -initialdir $iniDir -initialfile $iniFile \
            -filetypes $types -title "Save File"]
    if {$file != ""} {
        set ret [catch {open $file w} msg]
        if {!$ret} {
            set fid $msg
            fconfigure $fid -translation {auto lf}
            set ret [catch {puts $fid [$::Nagelfar(resultWin) get 1.0 end-1c]} msg]
        }
        catch {close $fid}
        if {!$ret} {
            tk_messageBox -title "Nagelfar" -icon info -type ok \
                    -message "Result saved as [file nativename $file]"
        } else {
            tk_messageBox -title "Nagelfar Error" -type ok -icon error \
                    -message "Cannot write [file nativename $file]:\n$msg"
        }
    }
}

# Update the selection in the db listbox to or from the db list.
proc updateDbSelection {{fromVar 0}} {
    if {$fromVar} {
        $::Nagelfar(dbWin) selection clear 0 end
        # Try to keep one selected
        if {[llength $::Nagelfar(db)] == 0} {
            set ::Nagelfar(db) [lrange $::Nagelfar(allDb) 0 0]
        }
        foreach f $::Nagelfar(db) {
            set i [lsearch $::Nagelfar(allDb) $f]
            if {$i >= 0} {
                $::Nagelfar(dbWin) selection set $i
            }
        }
        return
    }

    set ::Nagelfar(db) {}
    foreach ix [$::Nagelfar(dbWin) curselection] {
        lappend ::Nagelfar(db) [lindex $::Nagelfar(allDb) $ix]
    }
}

# Unused experiment to make scrolling snidget
if {[catch {package require snit}]} {
    namespace eval snit {
        proc widget {args} {}
    }
}
::snit::widget ScrollX {
    option -direction both
    option -auto 0

    delegate method * to child
    delegate option * to child

    constructor {class args} {
        set child [$class $win.s]
        $self configurelist $args
        grid $win.s -row 0 -column 0 -sticky news
        grid columnconfigure $win 0 -weight 1
        grid rowconfigure    $win 0 -weight 1

        # Move border properties to frame
        set bw [$win.s cget -borderwidth]
        set relief [$win.s cget -relief]
        $win configure -relief $relief -borderwidth $bw
        $win.s configure -borderwidth 0
    }

    method child {} {
        return $child
    }

    method SetScrollbar {sb from to} {
        $sb set $from $to
        if {$options(-auto) && $from == 0.0 && $top == 1.0} {
            grid remove $sb
        } else {
            grid $sb
        }
    }

    onconfigure -direction {value} {
        switch -- $value {
            both {
                set scrollx 1
                set scrolly 1
            }
            x {
                set scrollx 1
                set scrolly 0
            }
            y {
                set scrollx 0
                set scrolly 1
            }
            default {
                return -code error "Bad -direction \"$value\""
            }
        }
        set options(-direction) $value
        destroy $win.sbx $win.sby
        if {$scrollx} {
            $win.s configure -xscrollcommand [mymethod SetScrollbar $win.sbx]
            scrollbar $win.sbx -orient horizontal -command [list $win.s xview]
            grid $win.sbx -row 1 -sticky we
        } else {
            $win.s configure -xscrollcommand {}
        }
        if {$scrolly} {
            $win.s configure -yscrollcommand [mymethod SetScrollbar $win.sby]
            scrollbar $win.sby -orient vertical -command [list $win.s yview]
            grid $win.sby -row 0 -column 1 -sticky ns
        } else {
            $win.s configure -yscrollcommand {}
        }
    }
}

# A little helper to make a scrolled window
# It returns the name of the scrolled window
proc Scroll {dir class w args} {
    switch -- $dir {
        both {
            set scrollx 1
            set scrolly 1
        }
        x {
            set scrollx 1
            set scrolly 0
        }
        y {
            set scrollx 0
            set scrolly 1
        }
        default {
            return -code error "Bad scrolldirection \"$dir\""
        }
    }

    frame $w
    eval [list $class $w.s] $args

    # Move border properties to frame
    set bw [$w.s cget -borderwidth]
    set relief [$w.s cget -relief]
    $w configure -relief $relief -borderwidth $bw
    $w.s configure -borderwidth 0

    grid $w.s -sticky news

    if {$scrollx} {
        $w.s configure -xscrollcommand [list $w.sbx set]
        scrollbar $w.sbx -orient horizontal -command [list $w.s xview]
        grid $w.sbx -row 1 -sticky we
    }
    if {$scrolly} {
        $w.s configure -yscrollcommand [list $w.sby set]
        scrollbar $w.sby -orient vertical -command [list $w.s yview]
        grid $w.sby -row 0 -column 1 -sticky ns
    }
    grid columnconfigure $w 0 -weight 1
    grid rowconfigure    $w 0 -weight 1

    return $w.s
}

# Set the progress
proc progressUpdate {n} {
    if {$n < 0} {
        $::Nagelfar(progressWin) configure -relief flat
    } else {
        $::Nagelfar(progressWin) configure -relief solid
    }
    if {$n <= 0} {
        place $::Nagelfar(progressWin).f -x -100 -relx 0 -y 0 -rely 0 \
                -relheight 1.0 -relwidth 0.0
    } else {
        set frac [expr {double($n) / $::Nagelfar(progressMax)}]

        place $::Nagelfar(progressWin).f -x 0 -relx 0 -y 0 -rely 0 \
                -relheight 1.0 -relwidth $frac
    }
    update idletasks
}

# Set the 100 % level of the progress bar
proc progressMax {n} {
    set ::Nagelfar(progressMax) $n
    progressUpdate 0
}

# Create a simple progress bar
proc progressBar {w} {
    set ::Nagelfar(progressWin) $w

    frame $w -bd 1 -relief solid -padx 2 -pady 2 -width 100 -height 20
    frame $w.f -background blue

    progressMax 100
    progressUpdate -1
}

# A thing to easily get to debug mode
proc backDoor {a} {
    append ::Nagelfar(backdoor) $a
    set ::Nagelfar(backdoor) [string range $::Nagelfar(backdoor) end-9 end]
    if {$::Nagelfar(backdoor) eq "PeterDebug"} {
        # Second time it redraw window, thus giving debug menu
        if {$::debug == 1} {
            makeWin
        }
        set ::debug 1
        catch {console show}
        set ::Nagelfar(backdoor) ""
    }
}

# Flag that the current run should be stopped
proc stopCheck {} {
    set ::Nagelfar(stop) 1
    $::Nagelfar(stopWin) configure -state disabled
}

# Allow the stop button to be pressed
proc allowStop {} {
    set ::Nagelfar(stop) 0
    $::Nagelfar(stopWin) configure -state normal
}

# Create main window
proc makeWin {} {
    defaultGuiOptions

    catch {font create ResultFont -family courier \
            -size [lindex $::Prefs(resultFont) 1]}

    eval destroy [winfo children .]
    wm protocol . WM_DELETE_WINDOW exitApp
    wm title . "Nagelfar: Tcl Syntax Checker"
    tk appname Nagelfar
    wm withdraw .

    # Syntax database section

    frame .fs
    label .fs.l -text "Syntax database files"
    button .fs.bd -text "Del" -width 10 -command removeDbFile
    button .fs.b -text "Add" -width 10 -command addDbFile
    set lb [Scroll y listbox .fs.lb \
                    -listvariable ::Nagelfar(allDbView) \
                    -height 4 -width 40 -selectmode single]
    set ::Nagelfar(dbWin) $lb

    bind $lb <Key-Delete> "removeDbFile"
    bind $lb <<ListboxSelect>> updateDbSelection
    bind $lb <Button-1> [list focus $lb]
    updateDbSelection 1

    grid .fs.l  .fs.bd .fs.b -sticky w -padx 2 -pady 2
    grid .fs.lb -      -     -sticky news
    grid columnconfigure .fs 0 -weight 1
    grid rowconfigure .fs 1 -weight 1


    # File section

    frame .ff
    label .ff.l -text "Tcl files to check"
    button .ff.bd -text "Del" -width 10 -command removeFile
    button .ff.b -text "Add" -width 10 -command addFile
    set lb [Scroll y listbox .ff.lb \
                    -listvariable ::Nagelfar(files) \
                    -height 4 -width 40]
    set ::Nagelfar(fileWin) $lb

    bind $lb <Key-Delete> "removeFile"
    bind $lb <Button-1> [list focus $lb]
    bind $lb <Shift-Up> {moveFile -1}
    bind $lb <Shift-Down> {moveFile 1}

    grid .ff.l  .ff.bd .ff.b -sticky w -padx 2 -pady 2
    grid .ff.lb -      -     -sticky news
    grid columnconfigure .ff 0 -weight 1
    grid rowconfigure .ff 1 -weight 1

    # Set up file dropping in listboxes if TkDnd is available
    if {![catch {package require tkdnd}]} {
        dnd bindtarget . text/uri-list <Drop> {fileDropFile %D}
        #dnd bindtarget $::Nagelfar(fileWin) text/uri-list <Drop> {fileDropFile %D}
        dnd bindtarget $::Nagelfar(dbWin) text/uri-list <Drop> {fileDropDb %D}
    }

    # Result section

    frame .fr
    progressBar .fr.pr
    button .fr.b -text "Check" -underline 0 -width 10 -command "doCheck"
    bind . <Alt-Key-c> doCheck
    bind . <Alt-Key-C> doCheck
    button .fr.bb -text "Stop" -underline 0 -width 10 -command "stopCheck"
    bind . <Alt-Key-b> stopCheck
    bind . <Alt-Key-B> stopCheck
    set ::Nagelfar(stopWin) .fr.bb
    button .fr.bn -text "Next E" -underline 0 -width 10 -command "seeNextError"
    bind . <Alt-Key-n> seeNextError
    bind . <Alt-Key-N> seeNextError
    if {$::debug == 0} {
        bind . <Key> "backDoor %A"
    }

    set ::Nagelfar(resultWin) [Scroll both \
            text .fr.t -width 100 -height 25 -wrap none -font ResultFont]

    grid .fr.b .fr.bb .fr.bn .fr.pr -sticky w -padx 2 -pady {0 2}
    grid .fr.t -      -      -      -sticky news
    grid columnconfigure .fr 2 -weight 1
    grid rowconfigure    .fr 1 -weight 1

    $::Nagelfar(resultWin) tag configure info -foreground #707070
    $::Nagelfar(resultWin) tag configure error -foreground red
    $::Nagelfar(resultWin) tag configure hl -background yellow
    bind $::Nagelfar(resultWin) <Double-Button-1> "showError ; break"
    bind $::Nagelfar(resultWin) <Button-3> "resultPopup %x %y %X %Y ; break"

    # Use the panedwindow in 8.4
    panedwindow .pw -orient vertical
    lower .pw
    frame .pw.f
    grid .fs x .ff -in .pw.f -sticky news
    grid columnconfigure .pw.f {0 2} -weight 1 -uniform a
    grid columnconfigure .pw.f 1 -minsize 4
    grid rowconfigure .pw.f 0 -weight 1

    # Make sure the frames have calculated their size before
    # adding them to the pane
    # This update can be excluded in 8.4.4+
    update idletasks
    .pw add .pw.f -sticky news
    .pw add .fr   -sticky news
    pack .pw -fill both -expand 1


    # Menus

    menu .m
    . configure -menu .m

    # File menu

    .m add cascade -label "File" -underline 0 -menu .m.mf
    menu .m.mf
    .m.mf add command -label "Exit" -underline 1 -command exitApp

    # Options menu
    addOptionsMenu .m

    # Tools menu

    .m add cascade -label "Tools" -underline 0 -menu .m.mt
    menu .m.mt
    .m.mt add command -label "Edit Window" -underline 0 \
            -command {editFile "" 0}
    .m.mt add command -label "Browse Database" -underline 0 \
            -command makeDbBrowserWin
    addRegistryToMenu .m.mt

    # Debug menu

    if {$::debug == 1} {
        .m add cascade -label "Debug" -underline 0 -menu .m.md
        menu .m.md
        if {$::tcl_platform(platform) == "windows"} {
            .m.md add checkbutton -label Console -variable consolestate \
                    -onvalue show -offvalue hide \
                    -command {console $consolestate}
            .m.md add separator
        }
        .m.md add command -label "Reread Source" -command {source $thisScript}
        .m.md add separator
        .m.md add command -label "Redraw Window" -command {makeWin}
        #.m.md add separator
        #.m.md add command -label "Normal Cursor" -command {normalCursor}
    }

    # Help menu is last

    .m add cascade -label "Help" -underline 0 -menu .m.help
    menu .m.help
    foreach label {README Messages {Syntax Databases} {Inline Comments} {Call By Name} {Syntax Tokens} {Code Coverage}} \
            file {README.txt messages.txt syntaxdatabases.txt inlinecomments.txt call-by-name.txt syntaxtokens.txt codecoverage.txt} {
        .m.help add command -label $label -command [list makeDocWin $file]
    }
    .m.help add separator
    .m.help add command -label About -command makeAboutWin

    wm deiconify .
}

#############################
# A simple file viewer/editor
#############################

# Try to locate emacs, if not done before
proc locateEmacs {} {
    if {[info exists ::Nagelfar(emacs)]} return

    # Look for standard names in the path
    set path [auto_execok emacs]
    if {$path != ""} {
        set ::Nagelfar(emacs) [list $path -f server-start]
    } else {
        set path [auto_execok runemacs.exe]
        if {$path != ""} {
            set ::Nagelfar(emacs) [list $path]
        }
    }

    if {![info exists ::Nagelfar(emacs)]} {
        # Try the places where I usually have emacs on Windows
        foreach dir [lsort -decreasing -dictionary \
                [glob -nocomplain c:/apps/emacs*]] {
            set em [file join $dir bin runemacs.exe]
            set em [file normalize $em]
            if {[file exists $em]} {
                set ::Nagelfar(emacs) [list $em]
                break
            }
        }
    }
    # Look for emacsclient
    foreach name {emacsclient} {
        set path [auto_execok $name]
        if {$path != ""} {
            set ::Nagelfar(emacsclient) $path
            break
        }
    }
}

# Try to show a file using emacs
proc tryEmacs {filename lineNo} {
    locateEmacs
    # First try with emacsclient
    if {[catch {exec $::Nagelfar(emacsclient) -n +$lineNo $filename}]} {
        # Start a new emacs
        if {[catch {eval exec $::Nagelfar(emacs) [list +$lineNo \
                $filename] &}]} {
            # Failed
            return 0
        }
    }
    return 1
}

# Try to show a file using vim
proc tryVim {filename lineNo} {
    if {[catch {exec gvim +$lineNo $filename &}]} {
        if {[catch {exec xterm -exec vi +$lineNo $filename &}]} {
            return 0
        }
    }
    return 1
}

# Try to show a file using pfe
proc tryPfe {filename lineNo} {
    if {$lineNo > 0} {
        if {[catch {exec [auto_execok pfe32] /g $lineNo $filename &}]} {
            return 0
        }
    } elseif {[catch {exec [auto_execok pfe32] &}]} {
        return 0
    }
    return 1
}

# Edit a file using internal or external editor.
proc editFile {filename lineNo} {
    if {$::Prefs(editor) eq "emacs" && [tryEmacs $filename $lineNo]} return
    if {$::Prefs(editor) eq "vim"   && [tryVim   $filename $lineNo]} return
    if {$::Prefs(editor) eq "pfe"   && [tryPfe   $filename $lineNo]} return

    if {[winfo exists .fv]} {
        wm deiconify .fv
        raise .fv
        set w $::Nagelfar(editWin)
    } else {
        toplevel .fv
        wm title .fv "Nagelfar Editor"

	if {$::Nagelfar(withCtext)} {
	    set w [Scroll both ctext .fv.t -linemap 0 \
                    -width 80 -height 25 -font $::Prefs(editFileFont)]
	    ctext::setHighlightTcl $w
	} else {
            set w [Scroll both text .fv.t \
                    -width 80 -height 25 -font $::Prefs(editFileFont)]
        }
        set ::Nagelfar(editWin) $w
        # Set up a tag for incremental search bindings
        if {[info procs textSearch::enableSearch] != ""} {
            textSearch::enableSearch $w -label ::Nagelfar(iSearch)
        }

        frame .fv.f
        grid .fv.t -sticky news
        grid .fv.f -sticky we
        grid columnconfigure .fv 0 -weight 1
        grid rowconfigure .fv 0 -weight 1

        menu .fv.m
        .fv configure -menu .fv.m
        .fv.m add cascade -label "File" -underline 0 -menu .fv.m.mf
        menu .fv.m.mf
        .fv.m.mf add command -label "Save"  -underline 0 -command "saveFile"
        .fv.m.mf add separator
        .fv.m.mf add command -label "Close"  -underline 0 -command "closeFile"

        .fv.m add cascade -label "Edit" -underline 0 -menu .fv.m.me
        menu .fv.m.me
        .fv.m.me add command -label "Clear/Paste" -underline 6 \
                -command "clearAndPaste"
        .fv.m.me add command -label "Check" -underline 0 \
                -command "checkEditWin"

        .fv.m add cascade -label "Search" -underline 0 -menu .fv.m.ms
        menu .fv.m.ms
        if {[info procs textSearch::searchMenu] != ""} {
            textSearch::searchMenu .fv.m.ms
        } else {
            .fv.m.ms add command -label "Text search not available" \
                    -state disabled
        }

        .fv.m add cascade -label "Options" -underline 0 -menu .fv.m.mo
        menu .fv.m.mo
        .fv.m.mo add checkbutton -label "Backup" -underline 0 \
                -variable ::Prefs(editFileBackup)

        .fv.m.mo add cascade -label "Font" -underline 0 -menu .fv.m.mo.mf
        menu .fv.m.mo.mf
        set cmd "[list $w] configure -font \$::Prefs(editFileFont)"
        foreach lab {Small Medium Large} size {8 10 14} {
            .fv.m.mo.mf add radiobutton -label $lab  -underline 0 \
                    -variable ::Prefs(editFileFont) \
                    -value [list Courier $size] \
                    -command $cmd
        }

        label .fv.f.ln -width 5 -anchor e -textvariable ::Nagelfar(lineNo)
        label .fv.f.li -width 1 -pady 0 -padx 0 \
                -textvariable ::Nagelfar(iSearch)
        pack .fv.f.ln .fv.f.li -side right -padx 3

        bind $w <Any-Key> {
            after idle {
                set ::Nagelfar(lineNo) \
                        [lindex [split [$::Nagelfar(editWin) index insert] .] 0]
            }
        }
        bind $w <Any-Button> [bind $w <Any-Key>]

        wm protocol .fv WM_DELETE_WINDOW closeFile
        $w tag configure hl -background yellow
        if {[info exists ::Nagelfar(editFileGeom)]} {
            wm geometry .fv $::Nagelfar(editFileGeom)
        } else {
            after idle {after 1 {
                set ::Nagelfar(editFileOrigGeom) [wm geometry .fv]
            }}
        }
    }

    if {$filename != "" && \
            (![info exists ::Nagelfar(editFile)] || \
            $filename != $::Nagelfar(editFile))} {
        $w delete 1.0 end
        set ::Nagelfar(editFile) $filename
        wm title .fv [file tail $filename]

        # Try to figure out eol style
        set ch [open $filename r]
        fconfigure $ch -translation binary
        set data [read $ch 400]
        close $ch

        set crCnt [expr {[llength [split $data \r]] - 1}]
        set lfCnt [expr {[llength [split $data \n]] - 1}]
        if {$crCnt == 0 && $lfCnt > 0} {
            set ::Nagelfar(editFileTranslation) lf
        } elseif {$crCnt > 0 && $crCnt == $lfCnt} {
            set ::Nagelfar(editFileTranslation) crlf
        } elseif {$lfCnt == 0 && $crCnt > 0} {
            set ::Nagelfar(editFileTranslation) cr
        } else {
            set ::Nagelfar(editFileTranslation) auto
        }

        #puts "EOL $::Nagelfar(editFileTranslation)"

        set ch [open $filename r]
        set data [read $ch]
        close $ch
	if {$::Nagelfar(withCtext)} {
	    $w fastinsert end $data
	} else {
            $w insert end $data
        }
    }

    $w tag remove hl 1.0 end
    $w tag add hl $lineNo.0 $lineNo.end
    $w mark set insert $lineNo.0
    focus $w
    set ::Nagelfar(lineNo) $lineNo
    update
    $w see insert
    #after 1 {after idle {$::Nagelfar(editWin) see insert}}
    if {$::Nagelfar(withCtext)} {
        after idle [list $w highlight 1.0 end]
    }
}

proc saveFile {} {
    if {[tk_messageBox -parent .fv -title "Save File" -type okcancel \
            -icon question \
            -message "Save file\n$::Nagelfar(editFile)"] != "ok"} {
        return
    }
    if {$::Prefs(editFileBackup)} {
        file copy -force -- $::Nagelfar(editFile) $::Nagelfar(editFile)~
    }
    set ch [open $::Nagelfar(editFile) w]
    fconfigure $ch -translation $::Nagelfar(editFileTranslation)
    puts -nonewline $ch [$::Nagelfar(editWin) get 1.0 end-1char]
    close $ch
}

proc closeFile {} {
    if {[info exists ::Nagelfar(editFileGeom)] || \
            ([info exists ::Nagelfar(editFileOrigGeom)] && \
             $::Nagelfar(editFileOrigGeom) != [wm geometry .fv])} {
        set ::Nagelfar(editFileGeom) [wm geometry .fv]
    }

    destroy .fv
    set ::Nagelfar(editFile) ""
}

proc clearAndPaste {} {
    set w $::Nagelfar(editWin)
    $w delete 1.0 end
    focus $w

    if {$::tcl_platform(platform) == "windows"} {
        event generate $w <<Paste>>
    } else {
        $w insert 1.0 [selection get]
    }
}

proc checkEditWin {} {
    set w $::Nagelfar(editWin)

    set script [$w get 1.0 end]
    set ::Nagelfar(checkEdit) $script
    doCheck
    unset ::Nagelfar(checkEdit)
}

######
# Help
######

proc helpWin {w title} {
    destroy $w

    toplevel $w
    wm title $w $title
    bind $w <Key-Return> "destroy $w"
    bind $w <Key-Escape> "destroy $w"
    frame $w.f
    button $w.b -text "Close" -command "destroy $w" -width 10 \
            -default active
    pack $w.b -side bottom -pady 3
    pack $w.f -side top -expand y -fill both
    focus $w
    return $w.f
}

proc makeAboutWin {} {
    global version

    set w [helpWin .ab "About Nagelfar"]


    text $w.t -width 45 -height 7 -wrap none -relief flat \
            -bg [$w cget -bg]
    pack $w.t -side top -expand y -fill both

    $w.t insert end "A syntax checker for Tcl\n\n"
    $w.t insert end "$version\n\n"
    $w.t insert end "Made by Peter Spjuth\n"
    $w.t insert end "E-Mail: peter.spjuth@gmail.com\n"
    $w.t insert end "\nURL: http://nagelfar.berlios.de\n"
    $w.t insert end "\nTcl version: [info patchlevel]"
    set d [package provide tkdnd]
    if {$d != ""} {
        $w.t insert end "\nTkDnd version: $d"
    }
    catch {loadDatabases}
    if {[info exists ::Nagelfar(dbInfo)] &&  $::Nagelfar(dbInfo) != ""} {
        $w.t insert end "\nSyntax database: $::Nagelfar(dbInfo)"
    }
    set last [lindex [split [$w.t index end] "."] 0]
    $w.t configure -height $last
    $w.t configure -state disabled
}

# Partial backslash-subst
proc mySubst {str} {
    subst -nocommands -novariables [string map {\\\n \\\\\n} $str]
}

# Insert a text file into a text widget.
# Any XML-style tags in the file are used as tags in the text window.
proc insertTaggedText {w file} {
    set ch [open $file r]
    set data [read $ch]
    close $ch

    set tags {}
    while {$data != ""} {
        if {[regexp {^([^<]*)<(/?)([^>]+)>(.*)$} $data -> pre sl tag post]} {
            $w insert end [mySubst $pre] $tags
            set i [lsearch $tags $tag]
            if {$sl != ""} {
                # Remove tag
                if {$i >= 0} {
                    set tags [lreplace $tags $i $i]
                }
            } else {
                # Add tag
                lappend tags $tag
            }
            set data $post
        } else {
            $w insert end [mySubst $data] $tags
            set data ""
        }
    }
}

proc makeDocWin {fileName} {
    set w [helpWin .doc "Nagelfar Help"]
    set t [Scroll both \
                   text $w.t -width 80 -height 25 -wrap none -font ResultFont]
    pack $w.t -side top -expand 1 -fill both

    # Set up tags
    $t tag configure ul -underline 1

    if {![file exists $::docDir/$fileName]} {
        $t insert end "ERROR: Could not find doc file "
        $t insert end \"$fileName\"
        return
    }
    insertTaggedText $t $::docDir/$fileName

    #focus $t
    $t configure -state disabled
}

# Generate a file path relative to a dir
proc fileRelative {dir file} {
    set dirpath [file split $dir]
    set filepath [file split $file]
    set newpath {}

    set dl [llength $dirpath]
    set fl [llength $filepath]
    for {set t 0} {$t < $dl && $t < $fl} {incr t} {
        set f [lindex $filepath $t]
        set d [lindex $dirpath $t]
        if {$f ne $d} break
    }
    # Return file if too unequal
    if {$t <= 2 || ($dl - $t) > 3} {
        return $file
    }
    for {set u $t} {$u < $dl} {incr u} {
        lappend newpath ".."
    }
    return [eval file join $newpath [lrange $filepath $t end]]
}

proc defaultGuiOptions {} {
    catch {package require griffin}

    option add *Menu.tearOff 0
    if {[tk windowingsystem]=="x11"} {
        option add *Menu.activeBorderWidth 1
        option add *Menu.borderWidth 1

        option add *Listbox.exportSelection 0
        option add *Listbox.borderWidth 1
        option add *Listbox.highlightThickness 1
        option add *Font "Helvetica -12"
    }

    if {$::tcl_platform(platform) == "windows"} {
        option add *Panedwindow.sashRelief flat
        option add *Panedwindow.sashWidth 4
        option add *Panedwindow.sashPad 0
    }
}
