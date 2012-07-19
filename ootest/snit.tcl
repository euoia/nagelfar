# This is an experiment to check snit

# This is the generic definitions needed for Snit.

##nagelfar syntax _stdclass_snit s x*
##nagelfar subcmd _stdclass_snit destroy configurelist
##nagelfar syntax _stdclass_snit\ destroy 0
##nagelfar syntax _stdclass_snit\ configurelist x

##nagelfar syntax snit::type do=_stdclass_snit cn
##nagelfar syntax snit::type::method dm
##nagelfar syntax snit::type::constructor cv
##nagelfar syntax snit::type::destructor cl
##nagelfar syntax snit::type::option x p*


# This is the annotation needed for this object definition

##nagelfar syntax pdf4tcl::pdf4tcl dc=_obj,pdf4tcl p*
##nagelfar option pdf4tcl::pdf4tcl -file
##nagelfar return pdf4tcl::pdf4tcl _obj,pdf4tcl

##nagelfar implicitvar snit::type::pdf4tcl::pdf4tcl self\ _obj,pdf4tcl pdf

snit::type pdf4tcl::pdf4tcl {
    variable pdf
    option -file      -default "" -readonly 1
    constructor {args} {
        $self configurelist $args
    }
    destructor {
        $self finish
        close $pdf(ch)
    }
    method cleanup {} {
        $self destroy
    }
    method finish {} {
        $self RequireVersion a
    }
    method RequireVersion {version} {
        $self finish
        if {$version > $pdf(version)} {
            set pdf(version) $version
        }
    }
}

set x [pdf4tcl::pdf4tcl %AUTO% -file xx]
$x cleanup

pdf4tcl::pdf4tcl myobj -file xx
myobj cleanup

