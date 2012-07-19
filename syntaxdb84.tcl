# Automatically generated syntax database.

lappend ::dbInfo {Tcl 8.4.19 unix, Tk 8.4.19 x11}
set ::dbTclVersion 8.4
set ::knownGlobals {argc argv argv0 auto_index auto_oldpath auto_path env errorCode errorInfo tcl_interactive tcl_libPath tcl_library tcl_nonwordchars tcl_patchLevel tcl_pkgPath tcl_platform tcl_rcFileName tcl_version tcl_wordchars tk_library tk_patchLevel tk_strictMotif tk_version}
set ::knownCommands {. EvalAttached after append array auto_execok auto_import auto_load auto_load_index auto_mkindex auto_mkindex_old auto_qualify auto_reset bell bgerror binary bind bindtags break button canvas case catch cd checkbutton clipboard clock close concat continue destroy encoding entry eof error eval event exec exit expr fblocked fconfigure fcopy file fileevent flush focus font for foreach format frame gets glob global grab grid history if image incr info interp join label labelframe lappend lindex linsert list listbox llength load lower lrange lreplace lsearch lset lsort menu menubutton message msgcat::mc msgcat::mcload msgcat::mclocale msgcat::mcmax msgcat::mcmset msgcat::mcpreferences msgcat::mcset msgcat::mcunknown namespace open option pack package panedwindow parray pid pkg_compareExtension pkg_mkIndex place proc puts pwd radiobutton raise read regexp regsub rename return scale scan scrollbar seek selection send set socket source spinbox split string subst switch tclLdAout tclListValidFlags tclLog tclParseConfigSpec tclPkgSetup tclPkgUnknown tcl_endOfWord tcl_findLibrary tcl_startOfNextWord tcl_startOfPreviousWord tcl_wordBreakAfter tcl_wordBreakBefore tell text time tk tk_bindForTraversal tk_bisque tk_chooseColor tk_chooseDirectory tk_dialog tk_focusFollowsMouse tk_focusNext tk_focusPrev tk_getFileType tk_getOpenFile tk_getSaveFile tk_menuBar tk_menuSetFocus tk_messageBox tk_optionMenu tk_popup tk_setPalette tk_textCopy tk_textCut tk_textPaste tkwait toplevel trace unknown unset update uplevel upvar variable vwait while winfo wm}
set ::syntax(.) {s x*}
set {::syntax(. cget)} o
set {::syntax(. configure)} {o. x. p*}
set ::syntax(_obj,button) {s x*}
set {::syntax(_obj,button cget)} o
set {::syntax(_obj,button configure)} {o. x. p*}
set ::syntax(_obj,canvas) {s x*}
set {::syntax(_obj,canvas cget)} o
set {::syntax(_obj,canvas configure)} {o. x. p*}
set ::syntax(_obj,checkbutton) {s x*}
set {::syntax(_obj,checkbutton cget)} o
set {::syntax(_obj,checkbutton configure)} {o. x. p*}
set ::syntax(_obj,entry) {s x*}
set {::syntax(_obj,entry cget)} o
set {::syntax(_obj,entry configure)} {o. x. p*}
set ::syntax(_obj,frame) {s x*}
set {::syntax(_obj,frame cget)} o
set {::syntax(_obj,frame configure)} {o. x. p*}
set ::syntax(_obj,label) {s x*}
set {::syntax(_obj,label cget)} o
set {::syntax(_obj,label configure)} {o. x. p*}
set ::syntax(_obj,labelframe) {s x*}
set {::syntax(_obj,labelframe cget)} o
set {::syntax(_obj,labelframe configure)} {o. x. p*}
set ::syntax(_obj,listbox) {s x*}
set {::syntax(_obj,listbox cget)} o
set {::syntax(_obj,listbox configure)} {o. x. p*}
set {::syntax(_obj,listbox selection)} {s x x?}
set ::syntax(_obj,menu) {s x*}
set {::syntax(_obj,menu cget)} o
set {::syntax(_obj,menu configure)} {o. x. p*}
set ::syntax(_obj,menubutton) {s x*}
set {::syntax(_obj,menubutton cget)} o
set {::syntax(_obj,menubutton configure)} {o. x. p*}
set ::syntax(_obj,message) {s x*}
set {::syntax(_obj,message cget)} o
set {::syntax(_obj,message configure)} {o. x. p*}
set ::syntax(_obj,panedwindow) {s x*}
set {::syntax(_obj,panedwindow cget)} o
set {::syntax(_obj,panedwindow configure)} {o. x. p*}
set ::syntax(_obj,radiobutton) {s x*}
set {::syntax(_obj,radiobutton cget)} o
set {::syntax(_obj,radiobutton configure)} {o. x. p*}
set ::syntax(_obj,scale) {s x*}
set {::syntax(_obj,scale cget)} o
set {::syntax(_obj,scale configure)} {o. x. p*}
set ::syntax(_obj,scrollbar) {s x*}
set {::syntax(_obj,scrollbar cget)} o
set {::syntax(_obj,scrollbar configure)} {o. x. p*}
set ::syntax(_obj,spinbox) {s x*}
set {::syntax(_obj,spinbox cget)} o
set {::syntax(_obj,spinbox configure)} {o. x. p*}
set ::syntax(_obj,text) {s x*}
set {::syntax(_obj,text cget)} o
set {::syntax(_obj,text configure)} {o. x. p*}
set ::syntax(_obj,toplevel) {s x*}
set {::syntax(_obj,toplevel cget)} o
set {::syntax(_obj,toplevel configure)} {o. x. p*}
set ::syntax(after) {r 1}
set ::syntax(append) {n x*}
set ::syntax(array) {s v x?}
set {::syntax(array exists)} l=array
set {::syntax(array names)} {v=array x? x?}
set {::syntax(array set)} {n=array x}
set {::syntax(array size)} v=array
set {::syntax(array statistics)} v=array
set {::syntax(array unset)} {l x?}
set ::syntax(auto_execok) 1
set ::syntax(auto_import) 1
set ::syntax(auto_load) {r 1 2}
set ::syntax(auto_load_index) 0
set ::syntax(auto_mkindex) {r 1}
set ::syntax(auto_mkindex_old) {r 1}
set ::syntax(auto_qualify) 2
set ::syntax(auto_reset) 0
set ::syntax(bell) {o* x*}
set ::syntax(bgerror) 1
set ::syntax(binary) {s x*}
set {::syntax(binary scan)} {x x n n*}
set ::syntax(bind) {x x? cg?}
set ::syntax(bindtags) {x x?}
set ::syntax(break) 0
set ::syntax(button) {x p*}
set ::syntax(canvas) {x p*}
set ::syntax(case) x*
set ::syntax(catch) {c n?}
set ::syntax(cd) {r 0 1}
set ::syntax(checkbutton) {x p*}
set ::syntax(clipboard) {s x*}
set ::syntax(clock) {s x*}
set {::syntax(clock clicks)} o?
set {::syntax(clock format)} {x p*}
set {::syntax(clock scan)} {x p*}
set {::syntax(clock seconds)} 0
set ::syntax(close) 1
set ::syntax(concat) {r 0}
set ::syntax(continue) 0
set ::syntax(destroy) x*
set ::syntax(encoding) {s x*}
set {::syntax(encoding convertfrom)} {r 1 2}
set {::syntax(encoding convertto)} {r 1 2}
set {::syntax(encoding names)} 0
set {::syntax(encoding system)} {r 0 1}
set ::syntax(entry) {x p*}
set ::syntax(eof) 1
set ::syntax(error) {r 1 3}
set ::syntax(event) {s x*}
set ::syntax(exec) {o* x x*}
set ::syntax(exit) {r 0 1}
set ::syntax(fblocked) 1
set ::syntax(fconfigure) {x o. x. p*}
set ::syntax(fcopy) {x x p*}
set ::syntax(file) {s x*}
set {::syntax(file atime)} {x x?}
set {::syntax(file attributes)} {x o. x. p*}
set {::syntax(file channels)} x?
set {::syntax(file copy)} {o* x x x*}
set {::syntax(file delete)} {o* x x*}
set {::syntax(file dirname)} x
set {::syntax(file executable)} x
set {::syntax(file exists)} x
set {::syntax(file extension)} x
set {::syntax(file isdirectory)} x
set {::syntax(file isfile)} x
set {::syntax(file join)} {x x*}
set {::syntax(file link)} {o? x x?}
set {::syntax(file lstat)} {x n}
set {::syntax(file mkdir)} {x x*}
set {::syntax(file mtime)} {x x?}
set {::syntax(file nativename)} x
set {::syntax(file normalize)} x
set {::syntax(file owned)} x
set {::syntax(file pathtype)} x
set {::syntax(file readable)} x
set {::syntax(file readlink)} x
set {::syntax(file rename)} {o* x x x*}
set {::syntax(file rootname)} x
set {::syntax(file separator)} x?
set {::syntax(file size)} x
set {::syntax(file split)} x
set {::syntax(file stat)} {x n}
set {::syntax(file system)} x
set {::syntax(file tail)} x
set {::syntax(file type)} x
set {::syntax(file volumes)} 0
set {::syntax(file writable)} x
set ::syntax(fileevent) {x x x?}
set ::syntax(flush) 1
set ::syntax(focus) {o? x?}
set ::syntax(font) {s x*}
set ::syntax(for) {c E c c}
set ::syntax(format) {r 1}
set ::syntax(frame) {x p*}
set ::syntax(gets) {x n?}
set ::syntax(glob) {o* x x*}
set ::syntax(grab) {x x*}
set ::syntax(grid) {x x*}
set ::syntax(history) {s x*}
set ::syntax(if) {e c}
set ::syntax(image) {s x*}
set ::syntax(incr) {v x?}
set ::syntax(info) {s x*}
set {::syntax(info default)} {x x n}
set {::syntax(info exists)} l
set ::syntax(interp) {s x*}
set {::syntax(interp invokehidden)} {x o* x x*}
set ::syntax(join) {r 1 2}
set ::syntax(label) {x p*}
set ::syntax(labelframe) {x p*}
set ::syntax(lappend) {n x*}
set ::syntax(lindex) {r 2}
set ::syntax(linsert) {r 3}
set ::syntax(list) {r 0}
set ::syntax(listbox) {x p*}
set ::syntax(llength) 1
set ::syntax(load) {r 1 3}
set ::syntax(lower) {x x?}
set ::syntax(lrange) 3
set ::syntax(lreplace) {r 3}
set ::syntax(lsearch) {o* x x}
set ::syntax(lset) {n x x x*}
set ::syntax(lsort) {o* x}
set ::syntax(menu) {x p*}
set ::syntax(menubutton) {x p*}
set ::syntax(message) {x p*}
set ::syntax(msgcat::mc) {r 1}
set ::syntax(msgcat::mcload) 1
set ::syntax(msgcat::mclocale) {r 0}
set ::syntax(msgcat::mcmax) {r 0}
set ::syntax(msgcat::mcmset) 2
set ::syntax(msgcat::mcpreferences) 0
set ::syntax(msgcat::mcset) {r 2 3}
set ::syntax(msgcat::mcunknown) {r 2}
set ::syntax(namespace) {s x*}
set {::syntax(namespace import)} {o* x*}
set {::syntax(namespace which)} {o* x?}
set ::syntax(open) {r 1 3}
set ::syntax(option) {s x*}
set ::syntax(pack) {x x*}
set ::syntax(package) {s x*}
set ::syntax(panedwindow) {x p*}
set ::syntax(parray) {v x?}
set ::syntax(pid) {r 0 1}
set ::syntax(pkg_compareExtension) {r 1 2}
set ::syntax(pkg_mkIndex) {r 0}
set ::syntax(place) {x x*}
set ::syntax(proc) dp
set ::syntax(puts) {1: x : o? x x?}
set ::syntax(pwd) 0
set ::syntax(radiobutton) {x p*}
set ::syntax(raise) {x x?}
set ::syntax(read) {r 1 2}
set ::syntax(regexp) {o* x x n*}
set ::syntax(regsub) {o* x x x n?}
set ::syntax(rename) 2
set ::syntax(return) {p* x?}
set ::syntax(scale) {x p*}
set ::syntax(scan) {x x n*}
set ::syntax(scrollbar) {x p*}
set ::syntax(seek) {r 2 3}
set ::syntax(selection) {s x*}
set ::syntax(send) {o* x x x*}
set ::syntax(set) {1: v=scalar : n=scalar x}
set ::syntax(socket) {r 2}
set ::syntax(source) 1
set ::syntax(spinbox) {x p*}
set ::syntax(split) {r 1 2}
set ::syntax(string) {s x x*}
set {::syntax(string bytelength)} 1
set {::syntax(string compare)} {o* x x}
set {::syntax(string equal)} {o* x x}
set {::syntax(string first)} {r 2 3}
set {::syntax(string index)} 2
set {::syntax(string is)} {s o* x}
set {::syntax(string last)} {r 2 3}
set {::syntax(string length)} 1
set {::syntax(string map)} {o? x x}
set {::syntax(string match)} {o? x x}
set {::syntax(string range)} 3
set {::syntax(string repeat)} 2
set {::syntax(string replace)} {r 3 4}
set {::syntax(string tolower)} {r 1 3}
set {::syntax(string totitle)} {r 1 3}
set {::syntax(string toupper)} {r 1 3}
set {::syntax(string trim)} {r 1 2}
set {::syntax(string trimleft)} {r 1 2}
set {::syntax(string trimright)} {r 1 2}
set {::syntax(string wordend)} 2
set {::syntax(string wordstart)} 2
set ::syntax(subst) {o* x}
set ::syntax(tclLdAout) {r 0 3}
set ::syntax(tclListValidFlags) 1
set ::syntax(tclLog) 1
set ::syntax(tclParseConfigSpec) 4
set ::syntax(tclPkgSetup) 4
set ::syntax(tclPkgUnknown) {r 2 3}
set ::syntax(tcl_endOfWord) 2
set ::syntax(tcl_findLibrary) 6
set ::syntax(tcl_startOfNextWord) 2
set ::syntax(tcl_startOfPreviousWord) 2
set ::syntax(tcl_wordBreakAfter) 2
set ::syntax(tcl_wordBreakBefore) 2
set ::syntax(tell) 1
set ::syntax(text) {x p*}
set ::syntax(time) {c x?}
set ::syntax(tk) {s x*}
set ::syntax(tk_bindForTraversal) {r 0}
set ::syntax(tk_bisque) 0
set ::syntax(tk_chooseColor) p*
set ::syntax(tk_chooseDirectory) p*
set ::syntax(tk_dialog) {r 5}
set ::syntax(tk_focusFollowsMouse) 0
set ::syntax(tk_focusNext) 1
set ::syntax(tk_focusPrev) 1
set ::syntax(tk_getFileType) 0
set ::syntax(tk_getOpenFile) p*
set ::syntax(tk_getSaveFile) p*
set ::syntax(tk_menuBar) {r 0}
set ::syntax(tk_menuSetFocus) 1
set ::syntax(tk_messageBox) p*
set ::syntax(tk_optionMenu) {r 3}
set ::syntax(tk_popup) {r 3 4}
set ::syntax(tk_setPalette) {r 0}
set ::syntax(tk_textCopy) 1
set ::syntax(tk_textCut) 1
set ::syntax(tk_textPaste) 1
set ::syntax(tkwait) {s x}
set {::syntax(tkwait variable)} l
set ::syntax(toplevel) {x p*}
set ::syntax(trace) {s x x*}
set {::syntax(trace add)} {s x x x}
set {::syntax(trace add command)} {x x c3}
set {::syntax(trace add execution)} {x s c2}
set {::syntax(trace add execution leave)} c4
set {::syntax(trace add execution leavestep)} c4
set {::syntax(trace add variable)} {v x c3}
set {::syntax(trace info)} {s x x x}
set {::syntax(trace info command)} x
set {::syntax(trace info execution)} x
set {::syntax(trace info variable)} v
set {::syntax(trace remove)} {s x x x}
set {::syntax(trace remove command)} {x x x}
set {::syntax(trace remove execution)} {x x x}
set {::syntax(trace remove variable)} {v x x}
set {::syntax(trace variable)} {n x x}
set {::syntax(trace vdelete)} {v x x}
set {::syntax(trace vinfo)} l
set ::syntax(unknown) {r 0}
set ::syntax(unset) {o* l l*}
set ::syntax(update) s.
set ::syntax(vwait) n
set ::syntax(while) {E c}
set ::syntax(winfo) {s x x*}
set ::syntax(wm) {s x x*}

set ::return(button) _obj,button
set ::return(canvas) _obj,canvas
set ::return(checkbutton) _obj,checkbutton
set ::return(entry) _obj,entry
set ::return(frame) _obj,frame
set ::return(label) _obj,label
set ::return(labelframe) _obj,labelframe
set ::return(linsert) list
set ::return(list) list
set ::return(listbox) _obj,listbox
set ::return(llength) int
set ::return(lrange) list
set ::return(lreplace) list
set ::return(lsort) list
set ::return(menu) _obj,menu
set ::return(menubutton) _obj,menubutton
set ::return(message) _obj,message
set ::return(panedwindow) _obj,panedwindow
set ::return(radiobutton) _obj,radiobutton
set ::return(scale) _obj,scale
set ::return(scrollbar) _obj,scrollbar
set ::return(spinbox) _obj,spinbox
set ::return(text) _obj,text
set ::return(toplevel) _obj,toplevel

set ::subCmd(.) {cget configure}
set ::subCmd(_obj,button) {cget configure flash invoke}
set ::subCmd(_obj,canvas) {addtag bbox bind canvasx canvasy cget configure coords create dchars delete dtag find focus gettags icursor index insert itemcget itemconfigure lower move postscript raise scale scan select type xview yview}
set ::subCmd(_obj,checkbutton) {cget configure deselect flash invoke select toggle}
set ::subCmd(_obj,entry) {bbox cget configure delete get icursor index insert scan selection validate xview}
set ::subCmd(_obj,frame) {cget configure}
set ::subCmd(_obj,label) {cget configure}
set ::subCmd(_obj,labelframe) {cget configure}
set ::subCmd(_obj,listbox) {activate bbox cget configure curselection delete get index insert itemcget itemconfigure nearest scan see selection size xview yview}
set {::subCmd(_obj,listbox selection)} {anchor clear includes set}
set ::subCmd(_obj,menu) {activate add cget clone configure delete entrycget entryconfigure index insert invoke post postcascade type unpost yposition}
set ::subCmd(_obj,menubutton) {cget configure}
set ::subCmd(_obj,message) {cget configure}
set ::subCmd(_obj,panedwindow) {add cget configure forget identify panecget paneconfigure panes proxy sash}
set ::subCmd(_obj,radiobutton) {cget configure deselect flash invoke select}
set ::subCmd(_obj,scale) {cget configure coords get identify set}
set ::subCmd(_obj,scrollbar) {activate cget configure delta fraction get identify set}
set ::subCmd(_obj,spinbox) {bbox cget configure delete get icursor identify index insert invoke scan selection set validate xview}
set ::subCmd(_obj,text) {bbox cget compare configure debug delete dlineinfo dump edit get image index insert mark scan search see tag window xview yview}
set ::subCmd(_obj,toplevel) {cget configure}
set ::subCmd(array) {anymore donesearch exists get names nextelement set size startsearch statistics unset}
set ::subCmd(binary) {format scan}
set ::subCmd(clipboard) {append clear get}
set ::subCmd(clock) {clicks format scan seconds}
set ::subCmd(encoding) {convertfrom convertto names system}
set ::subCmd(event) {add delete generate info}
set ::subCmd(file) {atime attributes channels copy delete dirname executable exists extension isdirectory isfile join link lstat mkdir mtime nativename normalize owned pathtype readable readlink rename rootname separator size split stat system tail type volumes writable}
set ::subCmd(font) {actual configure create delete families measure metrics names}
set ::subCmd(history) {add change clear event info keep nextid redo}
set ::subCmd(image) {create delete height inuse names type types width}
set ::subCmd(info) {args body cmdcount commands complete default exists functions globals hostname level library loaded locals nameofexecutable patchlevel procs script sharedlibextension tclversion vars}
set ::subCmd(interp) {alias aliases create delete eval exists expose hidden hide invokehidden issafe marktrusted recursionlimit share slaves target transfer}
set ::subCmd(namespace) {children code current delete eval exists export forget import inscope origin parent qualifiers tail which}
set ::subCmd(option) {add clear get readfile}
set ::subCmd(package) {forget ifneeded names present provide require unknown vcompare versions vsatisfies}
set ::subCmd(selection) {clear get handle own}
set ::subCmd(string) {bytelength compare equal first index is last length map match range repeat replace tolower totitle toupper trim trimleft trimright wordend wordstart}
set {::subCmd(string is)} {alnum alpha ascii boolean control digit double false graph integer lower print punct space true upper wordchar xdigit}
set ::subCmd(tk) {appname caret scaling useinputmethods windowingsystem}
set ::subCmd(tkwait) {variable visibility window}
set ::subCmd(trace) {add info remove variable vdelete vinfo}
set {::subCmd(trace add)} {command execution variable}
set {::subCmd(trace add execution)} {enter enterstep leave leavestep}
set {::subCmd(trace info)} {command execution variable}
set {::subCmd(trace remove)} {command execution variable}
set ::subCmd(update) idletasks
set ::subCmd(winfo) {atom atomname cells children class colormapfull containing depth exists fpixels geometry height id interps ismapped manager name parent pathname pixels pointerx pointerxy pointery reqheight reqwidth rgb rootx rooty screen screencells screendepth screenheight screenmmheight screenmmwidth screenvisual screenwidth server toplevel viewable visual visualid visualsavailable vrootheight vrootwidth vrootx vrooty width x y}
set ::subCmd(wm) {aspect attributes client colormapwindows command deiconify focusmodel frame geometry grid group iconbitmap iconify iconmask iconname iconphoto iconposition iconwindow maxsize minsize overrideredirect positionfrom protocol resizable sizefrom stackorder state title transient withdraw}

set {::option(. cget)} {-bd -borderwidth -class -menu -relief -screen -use -background -bg -colormap -container -cursor -height -highlightbackground -highlightcolor -highlightthickness -padx -pady -takefocus -visual -width}
set {::option(. configure)} {-bd -borderwidth -class -menu -relief -screen -use -background -bg -colormap -container -cursor -height -highlightbackground -highlightcolor -highlightthickness -padx -pady -takefocus -visual -width}
set {::option(_obj,button cget)} {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -command -compound -cursor -default -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -justify -overrelief -padx -pady -relief -repeatdelay -repeatinterval -state -takefocus -text -textvariable -underline -width -wraplength}
set {::option(_obj,button configure)} {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -command -compound -cursor -default -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -justify -overrelief -padx -pady -relief -repeatdelay -repeatinterval -state -takefocus -text -textvariable -underline -width -wraplength}
set {::option(_obj,button configure -textvariable)} n
set {::option(_obj,canvas cget)} {-background -bd -bg -borderwidth -closeenough -confine -cursor -height -highlightbackground -highlightcolor -highlightthickness -insertbackground -insertborderwidth -insertofftime -insertontime -insertwidth -offset -relief -scrollregion -selectbackground -selectborderwidth -selectforeground -state -takefocus -width -xscrollcommand -xscrollincrement -yscrollcommand -yscrollincrement}
set {::option(_obj,canvas configure)} {-background -bd -bg -borderwidth -closeenough -confine -cursor -height -highlightbackground -highlightcolor -highlightthickness -insertbackground -insertborderwidth -insertofftime -insertontime -insertwidth -offset -relief -scrollregion -selectbackground -selectborderwidth -selectforeground -state -takefocus -width -xscrollcommand -xscrollincrement -yscrollcommand -yscrollincrement}
set {::option(_obj,checkbutton cget)} {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -command -compound -cursor -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -indicatoron -justify -offrelief -offvalue -onvalue -overrelief -padx -pady -relief -selectcolor -selectimage -state -takefocus -text -textvariable -underline -variable -width -wraplength}
set {::option(_obj,checkbutton configure)} {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -command -compound -cursor -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -indicatoron -justify -offrelief -offvalue -onvalue -overrelief -padx -pady -relief -selectcolor -selectimage -state -takefocus -text -textvariable -underline -variable -width -wraplength}
set {::option(_obj,checkbutton configure -textvariable)} n
set {::option(_obj,checkbutton configure -variable)} n
set {::option(_obj,entry cget)} {-background -bd -bg -borderwidth -cursor -disabledbackground -disabledforeground -exportselection -fg -font -foreground -highlightbackground -highlightcolor -highlightthickness -insertbackground -insertborderwidth -insertofftime -insertontime -insertwidth -invalidcommand -invcmd -justify -readonlybackground -relief -selectbackground -selectborderwidth -selectforeground -show -state -takefocus -textvariable -validate -validatecommand -vcmd -width -xscrollcommand}
set {::option(_obj,entry configure)} {-background -bd -bg -borderwidth -cursor -disabledbackground -disabledforeground -exportselection -fg -font -foreground -highlightbackground -highlightcolor -highlightthickness -insertbackground -insertborderwidth -insertofftime -insertontime -insertwidth -invalidcommand -invcmd -justify -readonlybackground -relief -selectbackground -selectborderwidth -selectforeground -show -state -takefocus -textvariable -validate -validatecommand -vcmd -width -xscrollcommand}
set {::option(_obj,entry configure -textvariable)} n
set {::option(_obj,frame cget)} {-bd -borderwidth -class -relief -background -bg -colormap -container -cursor -height -highlightbackground -highlightcolor -highlightthickness -padx -pady -takefocus -visual -width}
set {::option(_obj,frame configure)} {-bd -borderwidth -class -relief -background -bg -colormap -container -cursor -height -highlightbackground -highlightcolor -highlightthickness -padx -pady -takefocus -visual -width}
set {::option(_obj,label cget)} {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -compound -cursor -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -justify -padx -pady -relief -state -takefocus -text -textvariable -underline -width -wraplength}
set {::option(_obj,label configure)} {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -compound -cursor -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -justify -padx -pady -relief -state -takefocus -text -textvariable -underline -width -wraplength}
set {::option(_obj,label configure -textvariable)} n
set {::option(_obj,labelframe cget)} {-bd -borderwidth -class -fg -font -foreground -labelanchor -labelwidget -relief -text -background -bg -colormap -container -cursor -height -highlightbackground -highlightcolor -highlightthickness -padx -pady -takefocus -visual -width}
set {::option(_obj,labelframe configure)} {-bd -borderwidth -class -fg -font -foreground -labelanchor -labelwidget -relief -text -background -bg -colormap -container -cursor -height -highlightbackground -highlightcolor -highlightthickness -padx -pady -takefocus -visual -width}
set {::option(_obj,listbox cget)} {-activestyle -background -bd -bg -borderwidth -cursor -disabledforeground -exportselection -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -relief -selectbackground -selectborderwidth -selectforeground -selectmode -setgrid -state -takefocus -width -xscrollcommand -yscrollcommand -listvariable}
set {::option(_obj,listbox configure)} {-activestyle -background -bd -bg -borderwidth -cursor -disabledforeground -exportselection -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -relief -selectbackground -selectborderwidth -selectforeground -selectmode -setgrid -state -takefocus -width -xscrollcommand -yscrollcommand -listvariable}
set {::option(_obj,listbox configure -listvariable)} n
set {::option(_obj,menu cget)} {-activebackground -activeborderwidth -activeforeground -background -bd -bg -borderwidth -cursor -disabledforeground -fg -font -foreground -postcommand -relief -selectcolor -takefocus -tearoff -tearoffcommand -title -type}
set {::option(_obj,menu configure)} {-activebackground -activeborderwidth -activeforeground -background -bd -bg -borderwidth -cursor -disabledforeground -fg -font -foreground -postcommand -relief -selectcolor -takefocus -tearoff -tearoffcommand -title -type}
set {::option(_obj,menubutton cget)} {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -cursor -direction -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -indicatoron -justify -menu -padx -pady -relief -compound -state -takefocus -text -textvariable -underline -width -wraplength}
set {::option(_obj,menubutton configure)} {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -cursor -direction -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -indicatoron -justify -menu -padx -pady -relief -compound -state -takefocus -text -textvariable -underline -width -wraplength}
set {::option(_obj,menubutton configure -textvariable)} n
set {::option(_obj,message cget)} {-anchor -aspect -background -bd -bg -borderwidth -cursor -fg -font -foreground -highlightbackground -highlightcolor -highlightthickness -justify -padx -pady -relief -takefocus -text -textvariable -width}
set {::option(_obj,message configure)} {-anchor -aspect -background -bd -bg -borderwidth -cursor -fg -font -foreground -highlightbackground -highlightcolor -highlightthickness -justify -padx -pady -relief -takefocus -text -textvariable -width}
set {::option(_obj,message configure -textvariable)} n
set {::option(_obj,panedwindow cget)} {-background -bd -bg -borderwidth -cursor -handlepad -handlesize -height -opaqueresize -orient -relief -sashcursor -sashpad -sashrelief -sashwidth -showhandle -width}
set {::option(_obj,panedwindow configure)} {-background -bd -bg -borderwidth -cursor -handlepad -handlesize -height -opaqueresize -orient -relief -sashcursor -sashpad -sashrelief -sashwidth -showhandle -width}
set {::option(_obj,radiobutton cget)} {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -command -compound -cursor -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -indicatoron -justify -offrelief -overrelief -padx -pady -relief -selectcolor -selectimage -state -takefocus -text -textvariable -underline -value -variable -width -wraplength}
set {::option(_obj,radiobutton configure)} {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -command -compound -cursor -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -indicatoron -justify -offrelief -overrelief -padx -pady -relief -selectcolor -selectimage -state -takefocus -text -textvariable -underline -value -variable -width -wraplength}
set {::option(_obj,radiobutton configure -textvariable)} n
set {::option(_obj,radiobutton configure -variable)} n
set {::option(_obj,scale cget)} {-activebackground -background -bigincrement -bd -bg -borderwidth -command -cursor -digits -fg -font -foreground -from -highlightbackground -highlightcolor -highlightthickness -label -length -orient -relief -repeatdelay -repeatinterval -resolution -showvalue -sliderlength -sliderrelief -state -takefocus -tickinterval -to -troughcolor -variable -width}
set {::option(_obj,scale configure)} {-activebackground -background -bigincrement -bd -bg -borderwidth -command -cursor -digits -fg -font -foreground -from -highlightbackground -highlightcolor -highlightthickness -label -length -orient -relief -repeatdelay -repeatinterval -resolution -showvalue -sliderlength -sliderrelief -state -takefocus -tickinterval -to -troughcolor -variable -width}
set {::option(_obj,scale configure -variable)} n
set {::option(_obj,scrollbar cget)} {-activebackground -activerelief -background -bd -bg -borderwidth -command -cursor -elementborderwidth -highlightbackground -highlightcolor -highlightthickness -jump -orient -relief -repeatdelay -repeatinterval -takefocus -troughcolor -width}
set {::option(_obj,scrollbar configure)} {-activebackground -activerelief -background -bd -bg -borderwidth -command -cursor -elementborderwidth -highlightbackground -highlightcolor -highlightthickness -jump -orient -relief -repeatdelay -repeatinterval -takefocus -troughcolor -width}
set {::option(_obj,spinbox cget)} {-activebackground -background -bd -bg -borderwidth -buttonbackground -buttoncursor -buttondownrelief -buttonuprelief -command -cursor -disabledbackground -disabledforeground -exportselection -fg -font -foreground -format -from -highlightbackground -highlightcolor -highlightthickness -increment -insertbackground -insertborderwidth -insertofftime -insertontime -insertwidth -invalidcommand -invcmd -justify -relief -readonlybackground -repeatdelay -repeatinterval -selectbackground -selectborderwidth -selectforeground -state -takefocus -textvariable -to -validate -validatecommand -values -vcmd -width -wrap -xscrollcommand}
set {::option(_obj,spinbox configure)} {-activebackground -background -bd -bg -borderwidth -buttonbackground -buttoncursor -buttondownrelief -buttonuprelief -command -cursor -disabledbackground -disabledforeground -exportselection -fg -font -foreground -format -from -highlightbackground -highlightcolor -highlightthickness -increment -insertbackground -insertborderwidth -insertofftime -insertontime -insertwidth -invalidcommand -invcmd -justify -relief -readonlybackground -repeatdelay -repeatinterval -selectbackground -selectborderwidth -selectforeground -state -takefocus -textvariable -to -validate -validatecommand -values -vcmd -width -wrap -xscrollcommand}
set {::option(_obj,spinbox configure -textvariable)} n
set {::option(_obj,text cget)} {-autoseparators -background -bd -bg -borderwidth -cursor -exportselection -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -insertbackground -insertborderwidth -insertofftime -insertontime -insertwidth -maxundo -padx -pady -relief -selectbackground -selectborderwidth -selectforeground -setgrid -spacing1 -spacing2 -spacing3 -state -tabs -takefocus -undo -width -wrap -xscrollcommand -yscrollcommand}
set {::option(_obj,text configure)} {-autoseparators -background -bd -bg -borderwidth -cursor -exportselection -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -insertbackground -insertborderwidth -insertofftime -insertontime -insertwidth -maxundo -padx -pady -relief -selectbackground -selectborderwidth -selectforeground -setgrid -spacing1 -spacing2 -spacing3 -state -tabs -takefocus -undo -width -wrap -xscrollcommand -yscrollcommand}
set {::option(_obj,toplevel cget)} {-bd -borderwidth -class -menu -relief -screen -use -background -bg -colormap -container -cursor -height -highlightbackground -highlightcolor -highlightthickness -padx -pady -takefocus -visual -width}
set {::option(_obj,toplevel configure)} {-bd -borderwidth -class -menu -relief -screen -use -background -bg -colormap -container -cursor -height -highlightbackground -highlightcolor -highlightthickness -padx -pady -takefocus -visual -width}
set ::option(bell) {-displayof -nice}
set ::option(button) {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -command -compound -cursor -default -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -justify -overrelief -padx -pady -relief -repeatdelay -repeatinterval -state -takefocus -text -textvariable -underline -width -wraplength}
set {::option(button -textvariable)} n
set ::option(canvas) {-background -bd -bg -borderwidth -closeenough -confine -cursor -height -highlightbackground -highlightcolor -highlightthickness -insertbackground -insertborderwidth -insertofftime -insertontime -insertwidth -offset -relief -scrollregion -selectbackground -selectborderwidth -selectforeground -state -takefocus -width -xscrollcommand -xscrollincrement -yscrollcommand -yscrollincrement}
set ::option(checkbutton) {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -command -compound -cursor -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -indicatoron -justify -offrelief -offvalue -onvalue -overrelief -padx -pady -relief -selectcolor -selectimage -state -takefocus -text -textvariable -underline -variable -width -wraplength}
set {::option(checkbutton -textvariable)} n
set {::option(checkbutton -variable)} n
set {::option(clock clicks)} -milliseconds
set {::option(clock format)} {-format -gmt}
set {::option(clock scan)} {-base -gmt}
set ::option(entry) {-background -bd -bg -borderwidth -cursor -disabledbackground -disabledforeground -exportselection -fg -font -foreground -highlightbackground -highlightcolor -highlightthickness -insertbackground -insertborderwidth -insertofftime -insertontime -insertwidth -invalidcommand -invcmd -justify -readonlybackground -relief -selectbackground -selectborderwidth -selectforeground -show -state -takefocus -textvariable -validate -validatecommand -vcmd -width -xscrollcommand}
set {::option(entry -textvariable)} n
set ::option(exec) {-- -keepnewline}
set ::option(fconfigure) {-blocking -buffering -buffersize -encoding -eofchar -error -handshake -lasterror -mode -peername -pollinterval -queue -sockname -sysbuffer -timeout -translation -ttycontrol -ttystatus -xchar}
set ::option(fcopy) {-command -size}
set {::option(file attributes)} {-group -owner -permissions}
set {::option(file copy)} {-- -force}
set {::option(file delete)} {-- -force}
set {::option(file link)} {-hard -symbolic}
set {::option(file rename)} {-- -force}
set ::option(focus) {-displayof -force -lastfor}
set ::option(frame) {-bd -borderwidth -class -relief -background -bg -colormap -container -cursor -height -highlightbackground -highlightcolor -highlightthickness -padx -pady -takefocus -visual -width}
set ::option(glob) {-- -directory -join -nocomplain -path -tails -types}
set {::option(glob -directory)} 1
set {::option(glob -path)} 1
set {::option(glob -types)} 1
set {::option(interp invokehidden)} {-- -global}
set ::option(label) {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -compound -cursor -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -justify -padx -pady -relief -state -takefocus -text -textvariable -underline -width -wraplength}
set {::option(label -textvariable)} n
set ::option(labelframe) {-bd -borderwidth -class -fg -font -foreground -labelanchor -labelwidget -relief -text -background -bg -colormap -container -cursor -height -highlightbackground -highlightcolor -highlightthickness -padx -pady -takefocus -visual -width}
set ::option(listbox) {-activestyle -background -bd -bg -borderwidth -cursor -disabledforeground -exportselection -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -relief -selectbackground -selectborderwidth -selectforeground -selectmode -setgrid -state -takefocus -width -xscrollcommand -yscrollcommand -listvariable}
set {::option(listbox -listvariable)} n
set ::option(lsearch) {-all -ascii -decreasing -dictionary -exact -glob -increasing -inline -integer -not -real -regexp -sorted -start}
set {::option(lsearch -start)} 1
set ::option(lsort) {-ascii -command -decreasing -dictionary -increasing -index -integer -real -unique}
set {::option(lsort -command)} 1
set {::option(lsort -index)} 1
set ::option(menu) {-activebackground -activeborderwidth -activeforeground -background -bd -bg -borderwidth -cursor -disabledforeground -fg -font -foreground -postcommand -relief -selectcolor -takefocus -tearoff -tearoffcommand -title -type}
set ::option(menubutton) {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -cursor -direction -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -indicatoron -justify -menu -padx -pady -relief -compound -state -takefocus -text -textvariable -underline -width -wraplength}
set {::option(menubutton -textvariable)} n
set ::option(message) {-anchor -aspect -background -bd -bg -borderwidth -cursor -fg -font -foreground -highlightbackground -highlightcolor -highlightthickness -justify -padx -pady -relief -takefocus -text -textvariable -width}
set {::option(message -textvariable)} n
set {::option(namespace which)} {-variable -command}
set {::option(namespace which -variable)} v
set ::option(panedwindow) {-background -bd -bg -borderwidth -cursor -handlepad -handlesize -height -opaqueresize -orient -relief -sashcursor -sashpad -sashrelief -sashwidth -showhandle -width}
set ::option(puts) -nonewline
set ::option(radiobutton) {-activebackground -activeforeground -anchor -background -bd -bg -bitmap -borderwidth -command -compound -cursor -disabledforeground -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -image -indicatoron -justify -offrelief -overrelief -padx -pady -relief -selectcolor -selectimage -state -takefocus -text -textvariable -underline -value -variable -width -wraplength}
set {::option(radiobutton -textvariable)} n
set {::option(radiobutton -variable)} n
set ::option(regexp) {-- -about -all -expanded -indices -inline -line -lineanchor -linestop -nocase -start}
set {::option(regexp -start)} 1
set ::option(regsub) {-- -all -expanded -line -lineanchor -linestop -nocase -start}
set {::option(regsub -start)} 1
set ::option(return) {-code -errorcode -errorinfo}
set ::option(scale) {-activebackground -background -bigincrement -bd -bg -borderwidth -command -cursor -digits -fg -font -foreground -from -highlightbackground -highlightcolor -highlightthickness -label -length -orient -relief -repeatdelay -repeatinterval -resolution -showvalue -sliderlength -sliderrelief -state -takefocus -tickinterval -to -troughcolor -variable -width}
set {::option(scale -variable)} n
set ::option(scrollbar) {-activebackground -activerelief -background -bd -bg -borderwidth -command -cursor -elementborderwidth -highlightbackground -highlightcolor -highlightthickness -jump -orient -relief -repeatdelay -repeatinterval -takefocus -troughcolor -width}
set ::option(send) {-- -async -displayof}
set {::option(send -displayof)} 1
set ::option(spinbox) {-activebackground -background -bd -bg -borderwidth -buttonbackground -buttoncursor -buttondownrelief -buttonuprelief -command -cursor -disabledbackground -disabledforeground -exportselection -fg -font -foreground -format -from -highlightbackground -highlightcolor -highlightthickness -increment -insertbackground -insertborderwidth -insertofftime -insertontime -insertwidth -invalidcommand -invcmd -justify -relief -readonlybackground -repeatdelay -repeatinterval -selectbackground -selectborderwidth -selectforeground -state -takefocus -textvariable -to -validate -validatecommand -values -vcmd -width -wrap -xscrollcommand}
set {::option(spinbox -textvariable)} n
set {::option(string compare)} {-length -nocase}
set {::option(string compare -length)} 1
set {::option(string equal)} {-length -nocase}
set {::option(string equal -length)} 1
set {::option(string is)} {-failindex -strict}
set {::option(string is -failindex)} n
set {::option(string map)} -nocase
set {::option(string match)} -nocase
set ::option(subst) {-nobackslashes -nocommands -novariables}
set ::option(switch) {-- -exact -glob -regexp}
set ::option(text) {-autoseparators -background -bd -bg -borderwidth -cursor -exportselection -fg -font -foreground -height -highlightbackground -highlightcolor -highlightthickness -insertbackground -insertborderwidth -insertofftime -insertontime -insertwidth -maxundo -padx -pady -relief -selectbackground -selectborderwidth -selectforeground -setgrid -spacing1 -spacing2 -spacing3 -state -tabs -takefocus -undo -width -wrap -xscrollcommand -yscrollcommand}
set ::option(tk_chooseColor) {-initialcolor -parent -title}
set ::option(tk_chooseDirectory) {-initialdir -mustexist -parent -title}
set ::option(tk_getOpenFile) {-defaultextension -filetypes -initialdir -initialfile -multiple -parent -title}
set ::option(tk_getSaveFile) {-defaultextension -filetypes -initialdir -initialfile -parent -title}
set ::option(tk_messageBox) {-default -icon -message -parent -title -type}
set ::option(toplevel) {-bd -borderwidth -class -menu -relief -screen -use -background -bg -colormap -container -cursor -height -highlightbackground -highlightcolor -highlightthickness -padx -pady -takefocus -visual -width}
set ::option(unset) {-nocomplain --}

