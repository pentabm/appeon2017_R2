HA$PBExportHeader$pf_w_example_objectresize.srw
forward
global type pf_w_example_objectresize from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_objectresize
end type
type st_1 from pf_u_statictext within pf_w_example_objectresize
end type
type st_2 from pf_u_statictext within pf_w_example_objectresize
end type
type st_4 from pf_u_statictext within pf_w_example_objectresize
end type
type st_5 from pf_u_statictext within pf_w_example_objectresize
end type
type st_6 from pf_u_statictext within pf_w_example_objectresize
end type
type st_7 from pf_u_statictext within pf_w_example_objectresize
end type
type st_3 from statictext within pf_w_example_objectresize
end type
type ddlb_1 from dropdownlistbox within pf_w_example_objectresize
end type
end forward

global type pf_w_example_objectresize from pf_w_sheet
string title = "$$HEX16$$24c60cbe1dc8b8d22000acb9acc074c788c92000d8c00cd5200008c7c4b3b0c6$$ENDHEX$$"
cb_close cb_close
st_1 st_1
st_2 st_2
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_3 st_3
ddlb_1 ddlb_1
end type
global pf_w_example_objectresize pf_w_example_objectresize

type variables

end variables

on pf_w_example_objectresize.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_1=create st_1
this.st_2=create st_2
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_3=create st_3
this.ddlb_1=create ddlb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_5
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.st_7
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.ddlb_1
end on

on pf_w_example_objectresize.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_3)
destroy(this.ddlb_1)
end on

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_objectresize
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_objectresize
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_objectresize
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_objectresize
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_objectresize
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_objectresize
end type

type cb_close from pf_u_commandbutton within pf_w_example_objectresize
integer x = 4279
integer y = 32
integer width = 274
integer height = 96
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = hangeul!
string text = "$$HEX2$$ebb230ae$$ENDHEX$$"
string powertiptext = "$$HEX11$$74d5f9b2200054d674ba44c72000ebb2b5c2c8b2e4b2$$ENDHEX$$."
boolean applydesign = false
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)
end event

type st_1 from pf_u_statictext within pf_w_example_objectresize
integer x = 37
integer y = 192
integer width = 2245
integer height = 1008
boolean bringtotop = true
long textcolor = 20066866
long backcolor = 32896501
string text = "$$HEX2$$b6252000$$ENDHEX$$No Resize"
boolean border = true
end type

type st_2 from pf_u_statictext within pf_w_example_objectresize
integer x = 37
integer y = 1216
integer width = 2245
integer height = 912
boolean bringtotop = true
long textcolor = 20066866
long backcolor = 32896501
string text = "$$HEX2$$b6252000$$ENDHEX$$Resize = ScaleToBottom"
boolean border = true
boolean scaletobottom = true
end type

type st_4 from pf_u_statictext within pf_w_example_objectresize
integer x = 2295
integer y = 192
integer width = 2254
integer height = 1008
boolean bringtotop = true
long textcolor = 20066866
long backcolor = 32896501
string text = "$$HEX2$$b6252000$$ENDHEX$$Resize = ScaleToRight"
alignment alignment = right!
boolean border = true
boolean scaletoright = true
end type

type st_5 from pf_u_statictext within pf_w_example_objectresize
integer x = 2295
integer y = 1216
integer width = 2254
integer height = 912
boolean bringtotop = true
long textcolor = 20066866
long backcolor = 32896501
string text = "$$HEX2$$b6252000$$ENDHEX$$Resize = ScaleToRight + ScaleToBottom"
alignment alignment = right!
boolean border = true
boolean scaletoright = true
boolean scaletobottom = true
end type

type st_6 from pf_u_statictext within pf_w_example_objectresize
integer x = 3575
integer y = 40
integer width = 699
integer height = 80
boolean bringtotop = true
long textcolor = 20066866
long backcolor = 32896501
string text = "$$HEX2$$b6252000$$ENDHEX$$Resize = FixedToRight"
boolean border = true
boolean fixedtoright = true
end type

type st_7 from pf_u_statictext within pf_w_example_objectresize
integer x = 41
integer y = 2148
integer width = 4512
integer height = 80
boolean bringtotop = true
long textcolor = 20066866
long backcolor = 32896501
string text = "$$HEX2$$b6252000$$ENDHEX$$Resize = FixedToBottom + ScaleToRight"
boolean border = true
boolean fixedtobottom = true
boolean scaletoright = true
end type

type st_3 from statictext within pf_w_example_objectresize
integer x = 46
integer y = 64
integer width = 453
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX2$$3b202000$$ENDHEX$$Resize Options:"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within pf_w_example_objectresize
integer x = 521
integer y = 56
integer width = 649
integer height = 376
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string item[] = {"FixedToRight","FixedToBottom","ScaleToRight","ScaleToBottom"}
borderstyle borderstyle = stylelowered!
end type

