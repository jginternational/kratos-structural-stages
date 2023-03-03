
namespace eval ::Structural {
    variable _private
}

proc GiD_Event_InitProblemtype { dir } {
    Structural::Event_InitProblemtype $dir
}


proc GiD_Event_EndProblemtype {}  {
    unset -nocomplain _private
    GidUtils::DisableGraphics 
    GidUtils::EnableToolbar AllToolbars
    after 1000 {GidUtils::EnableGraphics}
}

proc ::Structural::Event_InitProblemtype { dir } {
    
    variable _private
    unset -nocomplain _private
    set _private(Path) $dir
    ::Structural::PrepareGUI
    ::Structural::LoadScripts
    after 1000 [list ::Structural::CreatePreprocessModelTBar]
}

proc ::Structural::LoadScripts {} {
    variable _private
    source [file join $_private(Path) scripts toolbar.tcl]
    source [file join $_private(Path) scripts xml_controller.tcl]
}
proc ::Structural::PrepareGUI {} {
    variable _private
    GidUtils::RemoveGUI
    GidUtils::EnableToolbar "Command line"
    GidUtils::EnableToolbar "Standard bar"
    GidUtils::EnableToolbar "Up menu"
    GidUtils::EnableToolbar "Status & Information"
    GidUtils::CloseWindow CUSTOMLIB

    set _private(GeomMenuView) 0

}