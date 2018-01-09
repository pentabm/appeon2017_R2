HA$PBExportHeader$pf_w_example_datawindowaction.srw
forward
global type pf_w_example_datawindowaction from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_datawindowaction
end type
type dw_2 from pf_u_datawindow within pf_w_example_datawindowaction
end type
type dw_1 from pf_u_datawindow within pf_w_example_datawindowaction
end type
type cb_1 from pf_u_commandbutton within pf_w_example_datawindowaction
end type
type dw_3 from pf_u_datawindow within pf_w_example_datawindowaction
end type
type dw_4 from pf_u_datawindow within pf_w_example_datawindowaction
end type
type cb_2 from pf_u_commandbutton within pf_w_example_datawindowaction
end type
type cb_3 from pf_u_commandbutton within pf_w_example_datawindowaction
end type
type cb_4 from pf_u_commandbutton within pf_w_example_datawindowaction
end type
type cb_5 from pf_u_commandbutton within pf_w_example_datawindowaction
end type
type cb_6 from pf_u_commandbutton within pf_w_example_datawindowaction
end type
type cb_7 from pf_u_commandbutton within pf_w_example_datawindowaction
end type
type cb_8 from pf_u_commandbutton within pf_w_example_datawindowaction
end type
end forward

global type pf_w_example_datawindowaction from pf_w_sheet
string title = "$$HEX12$$f9c62000d0c514b530d12000d8c00cd5200008c7c4b3b0c6$$ENDHEX$$"
cb_close cb_close
dw_2 dw_2
dw_1 dw_1
cb_1 cb_1
dw_3 dw_3
dw_4 dw_4
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
cb_8 cb_8
end type
global pf_w_example_datawindowaction pf_w_example_datawindowaction

type variables

end variables

on pf_w_example_datawindowaction.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_8=create cb_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.cb_5
this.Control[iCurrent+11]=this.cb_6
this.Control[iCurrent+12]=this.cb_7
this.Control[iCurrent+13]=this.cb_8
end on

on pf_w_example_datawindowaction.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_8)
end on

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_datawindowaction
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_datawindowaction
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_datawindowaction
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_datawindowaction
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_datawindowaction
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_datawindowaction
end type

type cb_close from pf_u_commandbutton within pf_w_example_datawindowaction
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

type dw_2 from pf_u_datawindow within pf_w_example_datawindowaction
integer x = 69
integer y = 328
integer width = 2240
integer height = 1892
integer taborder = 20
boolean bringtotop = true
string title = "$$HEX7$$f5acb5d154cfdcb42000b4b0edc5$$ENDHEX$$"
string dataobject = "pf_d_com_code_mst_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean displaytitleontop = true
boolean datawindowaction = true
string retrievalarguments = "as_sys_id = session.sys_id; as_upper_code_id = dw_1.upper_code_id"
boolean scaletobottom = true
end type

type dw_1 from pf_u_datawindow within pf_w_example_datawindowaction
integer x = 69
integer y = 148
integer width = 2240
integer height = 160
integer taborder = 30
boolean bringtotop = true
string dataobject = "pf_d_com_code_mst_01"
boolean issearchcondition = true
boolean datawindowaction = true
string defaultvaluesoninsertrow = "upper_code_id=~'ROOT~'"
end type

type cb_1 from pf_u_commandbutton within pf_w_example_datawindowaction
integer x = 2606
integer y = 32
integer width = 274
integer height = 96
integer taborder = 20
boolean bringtotop = true
string text = "$$HEX2$$70c88cd6$$ENDHEX$$"
boolean applydesign = false
boolean fixedtoright = true
string referencedobject = "dw_2"
string datawindowaction = "retrieve"
end type

type dw_3 from pf_u_datawindow within pf_w_example_datawindowaction
integer x = 2336
integer y = 148
integer width = 2213
integer height = 1184
integer taborder = 30
boolean bringtotop = true
string title = "$$HEX9$$f5acb5d154cfdcb42000c1c038c1b4b0edc5$$ENDHEX$$"
string dataobject = "pf_d_com_code_mst_03"
boolean displaytitleontop = true
boolean datawindowaction = true
string uplinkeddatawindow = "dw_2.sharedata"
string retrievalarguments = "as_sys_id = session.sys_id; as_upper_code_id = dw_2.upper_code_id; as_code_id = dw_2.code_id"
string defaultvaluesoninsertrow = "sys_id=session.sys_id; upper_code_id=dw_1.upper_code_id"
boolean scaletoright = true
end type

type dw_4 from pf_u_datawindow within pf_w_example_datawindowaction
integer x = 2336
integer y = 1376
integer width = 2213
integer height = 844
integer taborder = 40
boolean bringtotop = true
string title = "$$HEX10$$58d504c72000f5acb5d154cfdcb42000b4b0edc5$$ENDHEX$$"
string dataobject = "pf_d_com_code_mst_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean displaytitleontop = true
boolean datawindowaction = true
string uplinkeddatawindow = "dw_2"
string retrievalarguments = "as_sys_id = session.sys_id; as_upper_code_id = dw_2.code_id; "
string defaultvaluesoninsertrow = "sys_id=session.sys_id; upper_code_id=dw_2.code_id; use_yn=~'Y~'"
boolean scaletoright = true
boolean scaletobottom = true
end type

type cb_2 from pf_u_commandbutton within pf_w_example_datawindowaction
integer x = 2885
integer y = 32
integer width = 274
integer height = 96
integer taborder = 10
boolean bringtotop = true
string text = "$$HEX2$$94cd00ac$$ENDHEX$$"
boolean applydesign = false
boolean fixedtoright = true
string referencedobject = "dw_3"
string datawindowaction = "insertrow"
end type

type cb_3 from pf_u_commandbutton within pf_w_example_datawindowaction
integer x = 3163
integer y = 32
integer width = 274
integer height = 96
integer taborder = 20
boolean bringtotop = true
string text = "$$HEX2$$00c8a5c7$$ENDHEX$$"
boolean applydesign = false
boolean fixedtoright = true
string referencedobject = "dw_3"
string datawindowaction = "update"
end type

type cb_4 from pf_u_commandbutton within pf_w_example_datawindowaction
integer x = 3442
integer y = 32
integer width = 274
integer height = 96
integer taborder = 30
boolean bringtotop = true
string text = "$$HEX2$$adc01cc8$$ENDHEX$$"
boolean applydesign = false
boolean fixedtoright = true
string referencedobject = "dw_3"
string datawindowaction = "delete"
end type

type cb_5 from pf_u_commandbutton within pf_w_example_datawindowaction
integer x = 3721
integer y = 32
integer width = 274
integer height = 96
integer taborder = 40
boolean bringtotop = true
string text = "$$HEX2$$78c7c4c1$$ENDHEX$$"
boolean applydesign = false
boolean fixedtoright = true
string referencedobject = "dw_2"
string datawindowaction = "print"
end type

type cb_6 from pf_u_commandbutton within pf_w_example_datawindowaction
integer x = 4000
integer y = 32
integer width = 274
integer height = 96
integer taborder = 50
boolean bringtotop = true
string text = "$$HEX2$$d1c540c1$$ENDHEX$$"
boolean applydesign = false
boolean fixedtoright = true
string referencedobject = "dw_2"
string datawindowaction = "excel"
end type

type cb_7 from pf_u_commandbutton within pf_w_example_datawindowaction
integer x = 4000
integer y = 1348
integer width = 274
integer height = 96
integer taborder = 40
boolean bringtotop = true
string text = "$$HEX3$$89d594cd00ac$$ENDHEX$$"
boolean fixedtoright = true
string referencedobject = "dw_4"
string datawindowaction = "insertrow"
end type

type cb_8 from pf_u_commandbutton within pf_w_example_datawindowaction
integer x = 4279
integer y = 1348
integer width = 274
integer height = 96
integer taborder = 50
boolean bringtotop = true
string text = "$$HEX3$$89d5adc01cc8$$ENDHEX$$"
boolean fixedtoright = true
string referencedobject = "dw_4"
string datawindowaction = "delete"
end type

