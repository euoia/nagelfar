#!/bin/sh
# the next line restarts using tclsh \
exec tclsh "$0" "$@"

#----------------------------------------------------------------------
#  Nagelfar, a syntax checker for Tcl.
#  Copyright (c) 1999-2011, Peter Spjuth
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
# prologue.tcl
#----------------------------------------------------------------------
# $Revision$
#----------------------------------------------------------------------

set debug 0
package require Tcl 8.4

package provide app-nagelfar 1.0
set version "Version 1.1.12 2011-11-27"

set thisScript [file normalize [file join [pwd] [info script]]]
set thisDir    [file dirname $thisScript]

# Follow any link
set tmplink $thisScript
while {[file type $tmplink] == "link"} {
    set tmplink [file readlink $tmplink]
    set tmplink [file normalize [file join $thisDir $tmplink]]
    set thisDir [file dirname $tmplink]
}
unset tmplink

# This makes it possible to customize where files are installed
set dbDir      $thisDir
set docDir     $thisDir/doc
set libDir     $thisDir/lib
 
# Search where the script is to be able to place e.g. ctext there.
if {[info exists ::starkit::topdir]} {
    lappend auto_path [file dirname [file normalize $::starkit::topdir]]
} else {
    lappend auto_path $libDir
}
