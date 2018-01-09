$PBExportHeader$w_demo02.srw
forward
global type w_demo02 from w_output
end type
type dw_1 from pf_u_datawindow within w_demo02
end type
type dw_2 from pf_u_datawindow within w_demo02
end type
type dw_3 from pf_u_datawindow within w_demo02
end type
type st_1 from pf_u_splitbar_vertical within w_demo02
end type
type st_2 from pf_u_splitbar_vertical within w_demo02
end type
end forward

global type w_demo02 from w_output
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
st_1 st_1
st_2 st_2
end type
global w_demo02 w_demo02

on w_demo02.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
end on

on w_demo02.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_1)
destroy(this.st_2)
end on

type ln_templeft from w_output`ln_templeft within w_demo02
end type

type ln_tempright from w_output`ln_tempright within w_demo02
end type

type ln_temptop from w_output`ln_temptop within w_demo02
end type

type ln_tempbuttom from w_output`ln_tempbuttom within w_demo02
end type

type ln_tempbutton from w_output`ln_tempbutton within w_demo02
end type

type ln_tempstart from w_output`ln_tempstart within w_demo02
end type

type st_title from w_output`st_title within w_demo02
end type

type pb_close from w_output`pb_close within w_demo02
end type

type p_thelp from w_output`p_thelp within w_demo02
end type

type p_tfavor from w_output`p_tfavor within w_demo02
end type

type pb_print from w_output`pb_print within w_demo02
string referencedobject = "dw_1"
end type

type pb_search from w_output`pb_search within w_demo02
string referencedobject = "dw_1"
end type

type pb_excel from w_output`pb_excel within w_demo02
string referencedobject = "dw_1"
end type

type dw_1 from pf_u_datawindow within w_demo02
integer x = 37
integer y = 164
integer width = 1317
integer height = 2432
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_demo01_02"
boolean hscrollbar = true
boolean vscrollbar = true
string retrievalarguments = "as_parent_code=constant.00000"
boolean scaletobottom = true
end type

type dw_2 from pf_u_datawindow within w_demo02
integer x = 1367
integer y = 164
integer width = 1317
integer height = 2432
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_demo01_02"
boolean hscrollbar = true
boolean vscrollbar = true
string uplinkeddatawindow = "dw_1"
string retrievalarguments = "as_parent_code=dw_1.code_id"
boolean scaletobottom = true
end type

type dw_3 from pf_u_datawindow within w_demo02
integer x = 2697
integer y = 164
integer width = 965
integer height = 2432
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_demo01_02"
boolean hscrollbar = true
boolean vscrollbar = true
string uplinkeddatawindow = "dw_2"
string retrievalarguments = "as_parent_code=dw_2.code_id"
boolean scaletoright = true
boolean scaletobottom = true
end type

type st_1 from pf_u_splitbar_vertical within w_demo02
integer x = 1353
integer y = 164
integer height = 2432
boolean bringtotop = true
string leftdragobject = "dw_1"
string rightdragobject = "dw_2"
end type

type st_2 from pf_u_splitbar_vertical within w_demo02
integer x = 2683
integer y = 164
integer height = 2432
boolean bringtotop = true
string leftdragobject = "dw_2"
string rightdragobject = "dw_3"
end type

