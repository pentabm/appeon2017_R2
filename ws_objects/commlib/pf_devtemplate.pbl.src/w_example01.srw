﻿$PBExportHeader$w_example01.srw
forward
global type w_example01 from w_input
end type
type dw_cond from pf_u_datawindow within w_example01
end type
type dw_1 from pf_u_datawindow within w_example01
end type
type dw_2 from pf_u_datawindow within w_example01
end type
type p_1 from pf_u_imagebutton within w_example01
end type
type p_2 from pf_u_imagebutton within w_example01
end type
type dw_3 from pf_u_datawindow within w_example01
end type
type p_3 from pf_u_imagebutton within w_example01
end type
type p_4 from pf_u_imagebutton within w_example01
end type
end forward

global type w_example01 from w_input
dw_cond dw_cond
dw_1 dw_1
dw_2 dw_2
p_1 p_1
p_2 p_2
dw_3 dw_3
p_3 p_3
p_4 p_4
end type
global w_example01 w_example01

on w_example01.create
int iCurrent
call super::create
this.dw_cond=create dw_cond
this.dw_1=create dw_1
this.dw_2=create dw_2
this.p_1=create p_1
this.p_2=create p_2
this.dw_3=create dw_3
this.p_3=create p_3
this.p_4=create p_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cond
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.p_2
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.p_3
this.Control[iCurrent+8]=this.p_4
end on

on w_example01.destroy
call super::destroy
destroy(this.dw_cond)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.dw_3)
destroy(this.p_3)
destroy(this.p_4)
end on

type ln_templeft from w_input`ln_templeft within w_example01
end type

type ln_tempright from w_input`ln_tempright within w_example01
end type

type ln_temptop from w_input`ln_temptop within w_example01
end type

type ln_tempbuttom from w_input`ln_tempbuttom within w_example01
end type

type ln_tempbutton from w_input`ln_tempbutton within w_example01
end type

type ln_tempstart from w_input`ln_tempstart within w_example01
end type

type st_title from w_input`st_title within w_example01
end type

type pb_close from w_input`pb_close within w_example01
end type

type p_thelp from w_input`p_thelp within w_example01
end type

type p_tfavor from w_input`p_tfavor within w_example01
end type

type pb_print from w_input`pb_print within w_example01
string referencedobject = "dw_1"
end type

type pb_search from w_input`pb_search within w_example01
string referencedobject = "dw_1"
end type

type pb_insert from w_input`pb_insert within w_example01
string referencedobject = "dw_1"
end type

type pb_delete from w_input`pb_delete within w_example01
string referencedobject = "dw_1"
end type

type pb_save from w_input`pb_save within w_example01
string referencedobject = "dw_1"
end type

type pb_excel from w_input`pb_excel within w_example01
string referencedobject = "dw_1"
end type

type dw_cond from pf_u_datawindow within w_example01
integer x = 37
integer y = 164
integer width = 3625
integer height = 140
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_code_cond"
boolean issearchcondition = true
string defaultvaluesoninsertrow = "upper_code_id=constant.00000"
boolean scaletoright = true
end type

type dw_1 from pf_u_datawindow within w_example01
integer x = 37
integer y = 320
integer width = 1417
integer height = 2276
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_code_mst"
boolean hscrollbar = true
boolean vscrollbar = true
string retrievalarguments = "as_sys_id = session.sys_id; as_upper_code_id = dw_cond.upper_code_id"
string defaultvaluesoninsertrow = "sys_id=session.sys_id; use_yn=constant.Y; upper_code_id=dw_cond.upper_code_id"
boolean scaletobottom = true
end type

type dw_2 from pf_u_datawindow within w_example01
integer x = 1467
integer y = 412
integer width = 1417
integer height = 2184
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_code_mst"
boolean hscrollbar = true
boolean vscrollbar = true
string uplinkeddatawindow = "dw_1"
string retrievalarguments = "as_sys_id=session.sys_id; as_upper_code_id=dw_1.code_id"
string defaultvaluesoninsertrow = "sys_id=session.sys_id; use_yn=constant.Y; upper_code_id=dw_1.code_id"
boolean scaletobottom = true
end type

type p_1 from pf_u_imagebutton within w_example01
integer x = 2405
integer y = 316
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
string referencedobject = "dw_2"
string datawindowaction = "insertrow"
end type

type p_2 from pf_u_imagebutton within w_example01
integer x = 2651
integer y = 316
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
string referencedobject = "dw_2"
string datawindowaction = "deleterow"
end type

type dw_3 from pf_u_datawindow within w_example01
integer x = 2898
integer y = 412
integer width = 763
integer height = 2184
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_code_mst"
boolean hscrollbar = true
boolean vscrollbar = true
string uplinkeddatawindow = "dw_2"
string retrievalarguments = "as_sys_id=session.sys_id; as_upper_code_id=dw_2.code_id"
string defaultvaluesoninsertrow = "sys_id=session.sys_id; use_yn=constant.Y; upper_code_id=dw_2.code_id"
boolean scaletoright = true
boolean scaletobottom = true
end type

type p_3 from pf_u_imagebutton within w_example01
integer x = 3177
integer y = 316
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
boolean fixedtoright = true
string referencedobject = "dw_3"
string datawindowaction = "insertrow"
end type

type p_4 from pf_u_imagebutton within w_example01
integer x = 3424
integer y = 316
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
boolean fixedtoright = true
string referencedobject = "dw_3"
string datawindowaction = "deleterow"
end type

