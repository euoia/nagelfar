# A profiling tool
proc _dumplogme {} {
    if {[info exists ::logme]} {
        parray ::logme
    }
}
    
proc _initlogme {} {
    proc logme {} {
        set a [lindex [info level -1] 0]
        if {[info exists ::logme($a)]} {
            incr ::logme($a)
        } else {
            set ::logme($a) 1
        }
    }
    rename proc _proc

    _proc "proc" {name arg body} {
        uplevel 1 [list _proc $name $arg "logme\n $body"]
    }
}
#_initlogme

# A profiling thingy
proc timestamp {str} {
    global _timestamp_
    set apa [clock clicks]
    if {[info exists _timestamp_]} {
        puts stderr $str:$apa:[expr {$apa - $_timestamp_}]
    } else {
        puts stderr $str:$apa
    }
    set _timestamp_ $apa
}

# A tool to collect profiling data
##nagelfar syntax profile x c
proc profile {str script} {
    global profiledata
    if {![info exists profiledata($str)]} {
        set profiledata($str)   0
        set profiledata($str,n) 0
    }
    set apa [clock clicks]
    set res [uplevel 1 $script]
    incr profiledata($str) [expr {[clock clicks] - $apa}]
    incr profiledata($str,n)
    return $res
}

proc dumpProfileData {} {
    global profiledata
    set maxl 0
    foreach name [array names profiledata] {
	if {[string length $name] > $maxl} {
	    set maxl [string length $name]
	}
    }
    foreach name [lsort -dictionary [array names profiledata]] {
	puts stdout [format "%-*s = %s" $maxl $name $profiledata($name)]
    }
}

