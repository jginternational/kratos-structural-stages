
proc ::Structural::EndCreatePreprocessTBar {} {
    variable _private

    set name KPreprocessModelbar

    ReleaseToolbar ${name}
    if {[info exists _private(ToolBars,PreprocessModelTBar)]} {
        destroy $_private(ToolBars,PreprocessModelTBar)
    }
    
    if {[info exists _private(MenuItems)]} {
        unset _private(MenuItems)
    }
    update
}

proc ::Structural::CreatePreprocessModelTBar { {type "DEFAULT INSIDELEFT"} } {
    if { [GidUtils::IsTkDisabled] } {
        return 0
    }
    ::Structural::EndCreatePreprocessTBar
    ::Structural::ToolbarAddItem "Geometry" "geometry.png" [list -np- ::Structural::ToggleGeometryToolbar ] [= "Model Geometry"]
    ::Structural::ToolbarAddItem "Conditions" "properties.png" [list -np- ::Structural::ToggleCustomlibToolbar] [= "Conditions and properties"]

    ::Structural::RenderToolbar $type
    
}

proc ::Structural::ToolbarAddItem {id icon code tex} {
    variable _private
    if {![info exists _private(MenuItems)]} {
        set _private(MenuItems) [dict create]
    }
    set num [llength [dict keys $_private(MenuItems)]]
    incr num
    dict set _private(MenuItems) $num id $id
    dict set _private(MenuItems) $num icon $icon
    dict set _private(MenuItems) $num code $code
    dict set _private(MenuItems) $num tex $tex
    return $num
}

proc ::Structural::ToggleGeometryToolbar {} {
    variable _private
    if ($_private(GeomMenuView)) {set _private(GeomMenuView) 0} {set _private(GeomMenuView) 1}
    set _private(CustomLibView) 0
    ::Structural::ShowToolbarConfiguration
}
proc ::Structural::ToggleCustomlibToolbar {} {
    variable _private
    if ($_private(CustomLibView)) {set _private(CustomLibView) 0} {set _private(CustomLibView) 1}
    set _private(GeomMenuView) 0
    ::Structural::ShowToolbarConfiguration
}

proc ::Structural::ShowToolbarConfiguration {} {
    variable _private

    set geometry_name "Geometry & View bar"
    if ($_private(GeomMenuView)) { GidUtils::EnableToolbar $geometry_name} {GidUtils::DisableToolbar $geometry_name}
    
    set customlib_name "CUSTOMLIB"
    if ($_private(CustomLibView)) { GidUtils::OpenWindow $customlib_name} {GidUtils::CloseWindow $customlib_name}
}

proc ::Structural::RenderToolbar { type } {
    
    global KBitmapsNames KBitmapsCommands KBitmapsHelp
    variable _private
    set dir [file join $::Structural::_private(Path) resources images ]
    set theme [gid_themes::GetCurrentTheme]
    set iconslist [list ]
    set commslist [list ]
    set helpslist [list ]
    foreach item [dict keys $_private(MenuItems)] {
        set icon [dict get $_private(MenuItems) $item icon]
        set icon_path ""
        if {[file exists $icon]} {
            set icon_path $icon
        } else {
            set list_dirs [list ]
            lappend list_dirs $dir
            foreach path $list_dirs {
                if {$icon ne ""} {
                    set good_dir $path
                    if {$theme eq "GiD_black"} {
                        set good_dir [file join $path Black]
                        if {![file exists [file join $good_dir $icon]]} {set good_dir $path}
                    }
                    set icon_path [file join $good_dir $icon]
                    if {[file exists $icon_path]} {break;}
                }
            }
        }
        lappend iconslist [expr {$icon ne "" ? $icon_path : "---"}]
        lappend commslist  [dict get $_private(MenuItems) $item code]
        lappend helpslist [dict get $_private(MenuItems) $item tex]
    }

    set KBitmapsNames(0) $iconslist
    set KBitmapsCommands(0) $commslist
    set KBitmapsHelp(0) $helpslist

    set prefix Pre
    set name KPreprocessModelbar
    set procname ::Structural::CreatePreprocessModelTBar
    set _private(ToolBars,PreprocessModelTBar) [CreateOtherBitmaps ${name} [= "Main toolbar"] KBitmapsNames KBitmapsCommands KBitmapsHelp $dir $procname $type $prefix]

    AddNewToolbar [= "Main toolbar"] ${prefix}${name}WindowGeom $procname
}