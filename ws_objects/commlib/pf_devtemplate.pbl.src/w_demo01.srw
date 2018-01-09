$PBExportHeader$w_demo01.srw
forward
global type w_demo01 from w_input
end type
type dw_1 from pf_u_datawindow within w_demo01
end type
type dw_2 from pf_u_datawindow within w_demo01
end type
type dw_3 from pf_u_datawindow within w_demo01
end type
type dw_4 from pf_u_datawindow within w_demo01
end type
end forward

global type w_demo01 from w_input
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
end type
global w_demo01 w_demo01

on w_demo01.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_4
end on

on w_demo01.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
end on

type ln_templeft from w_input`ln_templeft within w_demo01
end type

type ln_tempright from w_input`ln_tempright within w_demo01
end type

type ln_temptop from w_input`ln_temptop within w_demo01
end type

type ln_tempbuttom from w_input`ln_tempbuttom within w_demo01
end type

type ln_tempbutton from w_input`ln_tempbutton within w_demo01
end type

type ln_tempstart from w_input`ln_tempstart within w_demo01
end type

type st_title from w_input`st_title within w_demo01
end type

type pb_close from w_input`pb_close within w_demo01
end type

type p_thelp from w_input`p_thelp within w_demo01
end type

type p_tfavor from w_input`p_tfavor within w_demo01
end type

type pb_print from w_input`pb_print within w_demo01
string referencedobject = "dw_2"
end type

type pb_search from w_input`pb_search within w_demo01
string referencedobject = "dw_2"
end type

type pb_insert from w_input`pb_insert within w_demo01
string referencedobject = "dw_3"
end type

type pb_delete from w_input`pb_delete within w_demo01
string referencedobject = "dw_3"
end type

type pb_save from w_input`pb_save within w_demo01
string referencedobject = "dw_3"
end type

type pb_excel from w_input`pb_excel within w_demo01
string referencedobject = "dw_2"
end type

type dw_1 from pf_u_datawindow within w_demo01
integer x = 37
integer y = 164
integer width = 1417
integer height = 164
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_demo01_01"
boolean issearchcondition = true
end type

type dw_2 from pf_u_datawindow within w_demo01
integer x = 37
integer y = 352
integer width = 1417
integer height = 2244
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_demo01_02"
boolean hscrollbar = true
boolean vscrollbar = true
string retrievalarguments = "as_parent_code=dw_1.evaluate(if(isnull(parent_code), ~'00000~', parent_code))"
boolean scaletobottom = true
end type

type dw_3 from pf_u_datawindow within w_demo01
integer x = 1472
integer y = 164
integer width = 2190
integer height = 1356
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_demo01_03"
boolean hscrollbar = true
boolean vscrollbar = true
string uplinkeddatawindow = "dw_2.sync"
string retrievalarguments = "as_parent_code=dw_2.parent_code; as_code_id=dw_2.code_id"
boolean scaletoright = true
end type

type dw_4 from pf_u_datawindow within w_demo01
integer x = 1472
integer y = 1540
integer width = 2190
integer height = 1056
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_demo01_04"
boolean hscrollbar = true
boolean vscrollbar = true
string uplinkeddatawindow = "dw_2"
string retrievalarguments = "as_parent_code=dw_2.code_id"
boolean scaletoright = true
boolean scaletobottom = true
end type

