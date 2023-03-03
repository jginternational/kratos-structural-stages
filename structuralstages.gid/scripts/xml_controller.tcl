
proc ::Structural::ProcgetStateFromXPathValue { domNode args } {
    set args {*}$args
    set arglist [split $args " "]
    set xpath {*}[lindex $arglist 0]
    set checkvalue [split [lindex $arglist 1] ","]
    set pst [$domNode selectNodes $xpath]
    #W "xpath $xpath checkvalue $checkvalue pst $pst"
    if {$pst in $checkvalue} { return "normal"} else {return "hidden"}
}
proc ::Structural::CheckDimension { domNode args } {

    set checkdim [lindex $args 0]

    if {$checkdim eq "3D"} {return "normal"} else {return "hidden"}
}


proc ::Structural::ViewDoc {} {
    W [[customlib::GetBaseRoot] asXML]
}
