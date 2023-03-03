
namespace eval ::Structural {
}

proc GiD_Event_InitProblemtype { dir } {
    Structural::Event_InitProblemtype $dir
}

proc Structural::Event_InitProblemtype { dir } {
    GidUtils::RemoveGUI
    # GidUtils::DisableToolbar "AllToolbars"
    # GidUtils::CloseWindow ALL
    GidUtils::EnableToolbar "Command line"
    GidUtils::EnableToolbar "Standard bar"
    GidUtils::EnableToolbar "Up menu"
    GidUtils::EnableToolbar "Status & Information"
    W "hola"
    GidUtils::OpenWindow CUSTOMLIB
}

proc Structural::ViewDoc {} {
    W [[customlib::GetBaseRoot] asXML]
}

proc Structural::ProcgetStateFromXPathValue { domNode args } {
    set args {*}$args
    set arglist [split $args " "]
    set xpath {*}[lindex $arglist 0]
    set checkvalue [split [lindex $arglist 1] ","]
    set pst [$domNode selectNodes $xpath]
    #W "xpath $xpath checkvalue $checkvalue pst $pst"
    if {$pst in $checkvalue} { return "normal"} else {return "hidden"}
}
proc Structural::CheckDimension { domNode args } {

    set checkdim [lindex $args 0]

    if {$checkdim eq "3D"} {return "normal"} else {return "hidden"}
}