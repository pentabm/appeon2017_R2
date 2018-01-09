$PBExportHeader$pf_w_example_splitbar.srw
forward
global type pf_w_example_splitbar from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_splitbar
end type
type st_lefttop from pf_u_statictext within pf_w_example_splitbar
end type
type st_leftbottom from pf_u_statictext within pf_w_example_splitbar
end type
type st_right from pf_u_statictext within pf_w_example_splitbar
end type
type st_hsplit from pf_u_splitbar_horizontal within pf_w_example_splitbar
end type
type st_vsplit from pf_u_splitbar_vertical within pf_w_example_splitbar
end type
end forward

global type pf_w_example_splitbar from pf_w_sheet
string title = "화면 분할 샘플 윈도우"
cb_close cb_close
st_lefttop st_lefttop
st_leftbottom st_leftbottom
st_right st_right
st_hsplit st_hsplit
st_vsplit st_vsplit
end type
global pf_w_example_splitbar pf_w_example_splitbar

type variables

end variables

on pf_w_example_splitbar.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_lefttop=create st_lefttop
this.st_leftbottom=create st_leftbottom
this.st_right=create st_right
this.st_hsplit=create st_hsplit
this.st_vsplit=create st_vsplit
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_lefttop
this.Control[iCurrent+3]=this.st_leftbottom
this.Control[iCurrent+4]=this.st_right
this.Control[iCurrent+5]=this.st_hsplit
this.Control[iCurrent+6]=this.st_vsplit
end on

on pf_w_example_splitbar.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_lefttop)
destroy(this.st_leftbottom)
destroy(this.st_right)
destroy(this.st_hsplit)
destroy(this.st_vsplit)
end on

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_splitbar
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_splitbar
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_splitbar
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_splitbar
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_splitbar
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_splitbar
end type

type cb_close from pf_u_commandbutton within pf_w_example_splitbar
integer x = 4279
integer y = 32
integer width = 274
integer height = 96
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = hangeul!
string text = "닫기"
string powertiptext = "해당 화면을 닫습니다."
boolean applydesign = false
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)
end event

type st_lefttop from pf_u_statictext within pf_w_example_splitbar
integer x = 69
integer y = 148
integer width = 2158
integer height = 1144
boolean bringtotop = true
long textcolor = 22040656
long backcolor = 32896501
string text = "Left Top"
boolean border = true
end type

type st_leftbottom from pf_u_statictext within pf_w_example_splitbar
integer x = 69
integer y = 1312
integer width = 2158
integer height = 912
boolean bringtotop = true
long textcolor = 22040656
long backcolor = 32896501
string text = "Left Bottom"
boolean border = true
boolean scaletobottom = true
end type

type st_right from pf_u_statictext within pf_w_example_splitbar
integer x = 2245
integer y = 148
integer width = 2309
integer height = 2076
boolean bringtotop = true
long textcolor = 22040656
long backcolor = 32896501
string text = "Right"
boolean border = true
boolean scaletoright = true
boolean scaletobottom = true
end type

type st_hsplit from pf_u_splitbar_horizontal within pf_w_example_splitbar
integer x = 64
integer y = 1292
integer width = 2176
boolean bringtotop = true
boolean scaletoright = false
string topdragobject = "st_lefttop"
string bottomdragobject = "st_leftbottom"
end type

type st_vsplit from pf_u_splitbar_vertical within pf_w_example_splitbar
integer x = 2226
integer y = 144
integer height = 2084
boolean bringtotop = true
string leftdragobject = "st_lefttop; st_hsplit; st_leftbottom"
string rightdragobject = "st_right"
end type

