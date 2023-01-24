
namespace eval ::Structural {
}

proc GiD_Event_InitProblemtype { dir } {
    Structural::Event_InitProblemtype $dir
}
proc Structural::ViewDoc {} {
    W [[customlib::GetBaseRoot] asXML]
}