$PBExportHeader$w_example04.srw
forward
global type w_example04 from w_input
end type
type dw_1 from pf_u_datawindow within w_example04
end type
type dw_2 from pf_u_datawindow within w_example04
end type
end forward

global type w_example04 from w_input
dw_1 dw_1
dw_2 dw_2
end type
global w_example04 w_example04

on w_example04.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_example04.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
end on

type ln_templeft from w_input`ln_templeft within w_example04
end type

type ln_tempright from w_input`ln_tempright within w_example04
end type

type ln_temptop from w_input`ln_temptop within w_example04
end type

type ln_tempbuttom from w_input`ln_tempbuttom within w_example04
end type

type ln_tempbutton from w_input`ln_tempbutton within w_example04
end type

type ln_tempstart from w_input`ln_tempstart within w_example04
end type

type st_title from w_input`st_title within w_example04
end type

type pb_close from w_input`pb_close within w_example04
end type

type p_thelp from w_input`p_thelp within w_example04
end type

type p_tfavor from w_input`p_tfavor within w_example04
end type

type pb_print from w_input`pb_print within w_example04
string referencedobject = "dw_1"
end type

type pb_search from w_input`pb_search within w_example04
string referencedobject = "dw_1"
end type

type pb_insert from w_input`pb_insert within w_example04
string referencedobject = "dw_1"
end type

type pb_delete from w_input`pb_delete within w_example04
string referencedobject = "dw_1"
end type

type pb_save from w_input`pb_save within w_example04
string referencedobject = "dw_1"
end type

type pb_excel from w_input`pb_excel within w_example04
string referencedobject = "dw_1"
end type

type dw_1 from pf_u_datawindow within w_example04
integer x = 41
integer y = 168
integer width = 1399
integer height = 2396
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_example04_01"
boolean hscrollbar = true
boolean vscrollbar = true
string retrievalarguments = "as_sys_id=constant.PF2SYS; as_upper_code_id=constant.00000"
end type

type dw_2 from pf_u_datawindow within w_example04
integer x = 1463
integer y = 168
integer width = 2185
integer height = 2396
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_example04_02"
boolean hscrollbar = true
boolean vscrollbar = true
string uplinkeddatawindow = "dw_1"
string retrievalarguments = "as_sys_id=dw_1.sys_id; as_upper_code_id=dw_1.upper_code_id; as_code_id=dw_1.code_id"
end type

