$PBExportHeader$eon_editmask.sru
forward
global type eon_editmask from editmask
end type
end forward

global type eon_editmask from editmask
integer width = 457
integer height = 128
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type
global eon_editmask eon_editmask

type variables
integer ii_vertical  //When ii_vertical is set to 1, eon_statictext is centered vertically; when set to 0, eon_statictext is consistent with PowerBuilder.
end variables

on eon_editmask.create
end on

on eon_editmask.destroy
end on

