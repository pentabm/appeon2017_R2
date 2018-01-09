$PBExportHeader$w_excel.srw
forward
global type w_excel from w_output
end type
type dw_1 from pf_u_datawindow within w_excel
end type
end forward

global type w_excel from w_output
dw_1 dw_1
end type
global w_excel w_excel

on w_excel.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_excel.destroy
call super::destroy
destroy(this.dw_1)
end on

type ln_templeft from w_output`ln_templeft within w_excel
end type

type ln_tempright from w_output`ln_tempright within w_excel
end type

type ln_temptop from w_output`ln_temptop within w_excel
end type

type ln_tempbuttom from w_output`ln_tempbuttom within w_excel
end type

type ln_tempbutton from w_output`ln_tempbutton within w_excel
end type

type ln_tempstart from w_output`ln_tempstart within w_excel
end type

type st_title from w_output`st_title within w_excel
end type

type pb_close from w_output`pb_close within w_excel
end type

type p_thelp from w_output`p_thelp within w_excel
end type

type p_tfavor from w_output`p_tfavor within w_excel
end type

type pb_print from w_output`pb_print within w_excel
string referencedobject = "dw_1"
end type

type pb_search from w_output`pb_search within w_excel
string referencedobject = "dw_1"
end type

type pb_excel from w_output`pb_excel within w_excel
string referencedobject = "dw_1"
end type

type dw_1 from pf_u_datawindow within w_excel
integer x = 41
integer y = 168
integer width = 3616
integer height = 2424
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_excel"
string retrievalarguments = "as_sys_id=session.sys_id"
boolean scaletoright = true
boolean scaletobottom = true
end type

