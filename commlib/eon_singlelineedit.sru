HA$PBExportHeader$eon_singlelineedit.sru
forward
global type eon_singlelineedit from singlelineedit
end type
end forward

global type eon_singlelineedit from singlelineedit
integer width = 457
integer height = 132
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type
global eon_singlelineedit eon_singlelineedit

type variables
integer ii_vertical   //When ii_vertical is set to 1, eon_singlelineedit is centered vertically; when set to 0, eon_singlelineedit is consistent with PowerBuilder.
end variables

on eon_singlelineedit.create
end on

on eon_singlelineedit.destroy
end on

