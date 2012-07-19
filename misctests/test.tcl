proc apa {} {

    set bepa 1
    # Detect missing $
    set cepa bepa
    # Detect unknown or misspelled variable
    set depa $cep
    set epa
    # Detect bad $
    set $depa apa
    if {[info exists $cepa]} {
        # Detect wrong number of args
        set apa bepa cepa
    }
    # Detect ugly if
    if {$bepa == $cepa} {
        set hej 1
    } elsif {$bepa == $cepa} {
        set hej 2
    } else {
        set hej 3
    }
    # Detect bad subcommand
    info gurka

    # Detect bad switch comment
    switch $bepa {
        hej {
            set hej hopp
        }
        # This is bad
        hopp {
            # Detect a missing command
            miffo
        }
    }
}

# Test call-by-name handling
# The syntax of this proc is described in
# the file test.syntax
proc copy {srcName dstName} {
    upvar $srcName src $dstName dst
    set dst $src
}

proc testCopy {} {
    set apa 1
    # It should not warn about apa below
    copy apa bepa
    # Bepa should be known now
    set cepa $bepa

    # Detect $ mistake
    copy apa $bepa
    copy $apa bepa
}

proc bepa {} {
    # Missing quote
    set apa "hej hopp
}
# A quote just to fix syntax coloring "

proc cepa {} {
    # Missing bracket
    set apa [hej hopp
}

proc epa {} {
    # Extra close brace
    if {[string length apa}} {
        set bepa 1
    }
}

proc fepa {} {
    # Commented brace {
    if {[string length apa]} {
        set bepa 1
    }
}
}

# This should be last in the file, since
# the missing close brace disturbs anything
# after it
proc depa {} {
    # Missing close brace
    if {[string length apa] {
        set bepa 1
    }
}
