# This is an experiment to check oo in 8.6

# This is the generic definitions needed for TclOO

# This is the annotation needed for this object definition

oo::class create Account {
    constructor {{ownerName undisclosed}} {
        my variable total overdrawLimit owner
        set total 0
        set overdrawLimit 10
        set owner $ownerName
    }
    method deposit amount {
        my variable total
        set total [expr {$total + $amount}]
    }
    method withdraw amount {
        my variable total overdrawLimit
        if {($amount - $total) > $overdrawLimit} {
            error "Can't overdraw - total: $total, limit: $overdrawLimit"
        }
        set total [expr {$total - $amount}]
    }
    method transfer {amount targetAccount} {
        my variable total
        my withdraw $amount
        $targetAccount deposit $amount
        set total
    }
    method dump {} {
    }
    destructor {
        my variable total
        if {$total} {puts "remaining $total will be given to charity"}
    }
}

set a [Account new "John Doe"]
$a deposit 200
$a deposit 20
$a withdraw 150
$a withdraw 100
$a dump
set b [Account new]
$a transfer 65 $b
$a dump
$b dump
$a transfer 1000000 $b
$b destroy


# Define the object methods
##nagelfar subcmd+ _obj,c bar foo Foo lollipop

oo::class create c
c create o
oo::define c method foo {} {
    puts "world"
}
oo::objdefine o {
    method bar {} {
        my Foo "hello "
        my foo
    }
    forward Foo ::puts -nonewline
    unexport foo
}
o bar
o foo
o Foo Bar
oo::objdefine o renamemethod bar lollipop
o lollipop

# Example with implicit variable:
oo::class create foo {
    variable x
    constructor y {
        set x $y
    }
    method boo z {
        list $x $z
    }
}
foo create bar quolf
bar boo x


#############################################################
# Experimenting with inheritance

oo::class create iddl::Base {
    variable id attributes
    constructor {n} {
        set id $n
    }
    method id {} {
        return $id
    }
    method fnurg {} {
        my id
        my variable x
        list $attributes
        return $x
    }
}

oo::class create iddl::Package {
    superclass iddl::Base
    variable records
    constructor {n {r {}}} {
        next $n
        set records {}
        if {$r ne ""} {
            lappend records $r
        }
    }
    method fnurg {} {
        next
    }
    method addRecord {obj} {
        my fnurg
        lappend records $obj
    }
    method getRecords {} {
        return $records
    }
}

set p [iddl::Package new Hej Hopp]
$p addRecord x
$p id
