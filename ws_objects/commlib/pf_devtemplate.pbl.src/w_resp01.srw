$PBExportHeader$w_resp01.srw
forward
global type w_resp01 from window
end type
type cb_1 from commandbutton within w_resp01
end type
end forward

global type w_resp01 from window
integer width = 4727
integer height = 1956
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
end type
global w_resp01 w_resp01

on w_resp01.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_resp01.destroy
destroy(this.cb_1)
end on

event open;//messagebox('', parentwindow().classname())

gnv_extfunc.of_centerpopupwindow(this)

end event

type cb_1 from commandbutton within w_resp01
integer x = 1728
integer y = 652
integer width = 457
integer height = 132
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

