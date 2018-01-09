HA$PBExportHeader$pf_w_inputdialog.srw
$PBExportComments$pf_f_inputdialog $$HEX16$$a9c620001dd3c5c508c7c4b3b0c6200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_inputdialog from window
end type
type st_title from pf_u_statictext within pf_w_inputdialog
end type
type p_icon from picture within pf_w_inputdialog
end type
type p_cancel from pf_u_imagebutton within pf_w_inputdialog
end type
type p_ok from pf_u_imagebutton within pf_w_inputdialog
end type
type sle_input from singlelineedit within pf_w_inputdialog
end type
type st_desc from statictext within pf_w_inputdialog
end type
end forward

global type pf_w_inputdialog from window
integer width = 1394
integer height = 684
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
string icon = "AppIcon!"
boolean toolbarvisible = false
boolean center = true
st_title st_title
p_icon p_icon
p_cancel p_cancel
p_ok p_ok
sle_input sle_input
st_desc st_desc
end type
global pf_w_inputdialog pf_w_inputdialog

on pf_w_inputdialog.create
this.st_title=create st_title
this.p_icon=create p_icon
this.p_cancel=create p_cancel
this.p_ok=create p_ok
this.sle_input=create sle_input
this.st_desc=create st_desc
this.Control[]={this.st_title,&
this.p_icon,&
this.p_cancel,&
this.p_ok,&
this.sle_input,&
this.st_desc}
end on

on pf_w_inputdialog.destroy
destroy(this.st_title)
destroy(this.p_icon)
destroy(this.p_cancel)
destroy(this.p_ok)
destroy(this.sle_input)
destroy(this.st_desc)
end on

event open;string ls_mesg, ls_parm[]

ls_mesg = message.stringparm
if pf_f_parsetoarray(ls_mesg, '~t', ls_parm) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX13$$98c7bbba1cb4200008c7c4b3b0c6200038d69ccd85c7c8b2e4b2$$ENDHEX$$')
	post close(this)
end if

this.title = ls_parm[1]
st_title.text = ls_parm[1]
st_desc.text = ls_parm[2]
if upperbound(ls_parm) > 2 then
	sle_input.text = ls_parm[3]
end if

sle_input.setfocus()

end event

event key;choose case key
	case KeyEscape!
		p_cancel.post event clicked()
end choose

end event

type st_title from pf_u_statictext within pf_w_inputdialog
integer x = 274
integer y = 40
integer width = 1083
integer height = 96
integer textsize = -12
integer weight = 700
long textcolor = 25123896
string text = "Title"
end type

type p_icon from picture within pf_w_inputdialog
integer x = 37
integer y = 40
integer width = 206
integer height = 180
string picturename = "..\img\mainframe\w_favorite\favorite.jpg"
boolean focusrectangle = false
end type

type p_cancel from pf_u_imagebutton within pf_w_inputdialog
integer x = 1129
integer y = 492
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_cancel.gif"
end type

event clicked;call super::clicked;closewithreturn(parent, 'Cancel')

end event

type p_ok from pf_u_imagebutton within pf_w_inputdialog
integer x = 882
integer y = 492
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_ok.gif"
end type

event clicked;call super::clicked;closewithreturn(parent, 'OK~t' + sle_input.text)

end event

type sle_input from singlelineedit within pf_w_inputdialog
integer x = 146
integer y = 332
integer width = 1120
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20395836
borderstyle borderstyle = stylelowered!
end type

event modified;// Enter $$HEX3$$10b694b22000$$ENDHEX$$Tab $$HEX17$$a4d0200085c725b8dcc2200055d678c7200084bcbcd2200074d0adb92000a8d6fcac$$ENDHEX$$

if len(this.text) > 0 then
	p_ok.post event clicked()
end if

end event

type st_desc from statictext within pf_w_inputdialog
integer x = 274
integer y = 148
integer width = 1083
integer height = 128
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 23488102
string text = "Description"
boolean focusrectangle = false
end type

