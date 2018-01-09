HA$PBExportHeader$pf_w_example_webeditor.srw
forward
global type pf_w_example_webeditor from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_webeditor
end type
type uo_editor from pf_u_webeditor within pf_w_example_webeditor
end type
type cb_1 from commandbutton within pf_w_example_webeditor
end type
type sle_editor_url from singlelineedit within pf_w_example_webeditor
end type
type st_1 from statictext within pf_w_example_webeditor
end type
type cb_2 from commandbutton within pf_w_example_webeditor
end type
type cb_3 from commandbutton within pf_w_example_webeditor
end type
type cb_4 from commandbutton within pf_w_example_webeditor
end type
end forward

global type pf_w_example_webeditor from pf_w_sheet
string title = "$$HEX12$$f9c62000d0c514b530d12000d8c00cd5200008c7c4b3b0c6$$ENDHEX$$"
cb_close cb_close
uo_editor uo_editor
cb_1 cb_1
sle_editor_url sle_editor_url
st_1 st_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
end type
global pf_w_example_webeditor pf_w_example_webeditor

type variables

end variables

on pf_w_example_webeditor.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.uo_editor=create uo_editor
this.cb_1=create cb_1
this.sle_editor_url=create sle_editor_url
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.uo_editor
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.sle_editor_url
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.cb_4
end on

on pf_w_example_webeditor.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.uo_editor)
destroy(this.cb_1)
destroy(this.sle_editor_url)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
end on

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_webeditor
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_webeditor
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_webeditor
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_webeditor
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_webeditor
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_webeditor
end type

type cb_close from pf_u_commandbutton within pf_w_example_webeditor
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

type uo_editor from pf_u_webeditor within pf_w_example_webeditor
integer x = 96
integer y = 268
integer width = 4430
integer height = 1936
integer taborder = 20
boolean bringtotop = true
boolean scaletoright = true
boolean scaletobottom = true
end type

on uo_editor.destroy
call pf_u_webeditor::destroy
end on

type cb_1 from commandbutton within pf_w_example_webeditor
integer x = 2702
integer y = 140
integer width = 457
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "navigate"
end type

event clicked;// Editor $$HEX6$$98d374c7c0c9200024c608d5$$ENDHEX$$
uo_editor.of_seteditorurl(sle_editor_url.text)
uo_editor.of_openwebeditor()

end event

type sle_editor_url from singlelineedit within pf_w_example_webeditor
integer x = 430
integer y = 144
integer width = 2263
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "http://localhost/smarteditor/SmartEditor2_editor.html"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within pf_w_example_webeditor
integer x = 114
integer y = 168
integer width = 315
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Editor URL : "
boolean focusrectangle = false
end type

type cb_2 from commandbutton within pf_w_example_webeditor
integer x = 3159
integer y = 140
integer width = 457
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "GetContents"
end type

event clicked;string ls_contents

ls_contents = uo_editor.of_getcontents()
messagebox('ls_contenst', ls_contents)

end event

type cb_3 from commandbutton within pf_w_example_webeditor
integer x = 3616
integer y = 140
integer width = 457
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "Reset"
end type

event clicked;uo_editor.of_resetcontents()

end event

type cb_4 from commandbutton within pf_w_example_webeditor
integer x = 4073
integer y = 140
integer width = 457
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "PasteContents"
end type

event clicked;string ls_contents

ls_contents = ::clipboard()
uo_editor.of_setcontents(ls_contents)

end event

