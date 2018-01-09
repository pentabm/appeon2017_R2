$PBExportHeader$w_edu02.srw
forward
global type w_edu02 from pf_w_sheet
end type
type dw_1 from pf_u_datawindow within w_edu02
end type
type dw_2 from pf_u_datawindow within w_edu02
end type
type cb_1 from pf_u_commandbutton within w_edu02
end type
type dw_3 from pf_u_datawindow within w_edu02
end type
type cb_2 from pf_u_commandbutton within w_edu02
end type
end forward

global type w_edu02 from pf_w_sheet
dw_1 dw_1
dw_2 dw_2
cb_1 cb_1
dw_3 dw_3
cb_2 cb_2
end type
global w_edu02 w_edu02

on w_edu02.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.dw_3=create dw_3
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_2
end on

on w_edu02.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.cb_2)
end on

event open;call super::open;//dw_1.insertrow(0)

end event

type ln_templeft from pf_w_sheet`ln_templeft within w_edu02
end type

type ln_tempright from pf_w_sheet`ln_tempright within w_edu02
end type

type ln_temptop from pf_w_sheet`ln_temptop within w_edu02
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within w_edu02
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within w_edu02
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within w_edu02
end type

type dw_1 from pf_u_datawindow within w_edu02
integer x = 50
integer y = 164
integer width = 1390
integer height = 160
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_com_code_mst_01"
boolean issearchcondition = true
boolean datawindowaction = true
string defaultvaluesoninsertrow = "sys_id=session.sys_id"
end type

type dw_2 from pf_u_datawindow within w_edu02
integer x = 50
integer y = 336
integer width = 1390
integer height = 1876
integer taborder = 30
boolean bringtotop = true
string dataobject = "pf_d_com_code_mst_02"
boolean datawindowaction = true
string retrievalarguments = "as_sys_id=~'PF2SYS~'; as_upper_code_id=dw_1.upper_code_id+~'%~'"
end type

type cb_1 from pf_u_commandbutton within w_edu02
integer x = 3177
integer y = 32
integer taborder = 20
boolean bringtotop = true
string text = "조회"
string referencedobject = "dw_2"
string datawindowaction = "retrieve"
end type

type dw_3 from pf_u_datawindow within w_edu02
integer x = 1463
integer y = 168
integer width = 3090
integer height = 1356
integer taborder = 40
boolean bringtotop = true
string dataobject = "pf_d_com_code_mst_03"
boolean datawindowaction = true
string uplinkeddatawindow = "dw_2"
string retrievalarguments = "as_sys_id=dw_2.sys_id; as_upper_code_id=dw_2.upper_code_id; as_code_id=dw_2.code_id"
end type

event doubleclicked;call super::doubleclicked;gnv_session.of_put("pf_w_dwinfo.datawindowref", dw_3)
open(pf_w_dwinfo)

end event

type cb_2 from pf_u_commandbutton within w_edu02
integer x = 3593
integer y = 36
integer taborder = 10
boolean bringtotop = true
string text = "인쇄"
string referencedobject = "dw_2"
string datawindowaction = "print"
end type

