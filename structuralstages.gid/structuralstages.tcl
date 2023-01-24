##################################################################################
#   This file is common for all Kratos Applications.
#   Do not change anything here unless it's strictly necessary.
##################################################################################

namespace eval ::Structural {
}

proc GiD_Event_InitProblemtype { dir } {
    Structural::Event_InitProblemtype $dir
}

proc Structural::Events { } {
    Structural::RegisterGiDEvents
}

proc Structural::RegisterGiDEvents { } {
}

proc Structural::Event_InitProblemtype { dir } {
    variable kratos_private


}

proc Structural::LoadCommonScripts { } {

}
