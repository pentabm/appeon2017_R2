$PBExportHeader$w_demo03.srw
$PBExportComments$출력용윈도우
forward
global type w_demo03 from w_basic
end type
type pb_print from pf_u_imagebutton within w_demo03
end type
type pb_search from pf_u_imagebutton within w_demo03
end type
type pb_excel from pf_u_imagebutton within w_demo03
end type
type dw_1 from pf_u_datawindow within w_demo03
end type
type dw_2 from pf_u_datawindow within w_demo03
end type
type dw_3 from pf_u_datawindow within w_demo03
end type
type st_1 from pf_u_splitbar_vertical within w_demo03
end type
type st_2 from pf_u_splitbar_vertical within w_demo03
end type
end forward

global type w_demo03 from w_basic
pb_print pb_print
pb_search pb_search
pb_excel pb_excel
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
st_1 st_1
st_2 st_2
end type
global w_demo03 w_demo03

type variables

end variables

on w_demo03.create
int iCurrent
call super::create
this.pb_print=create pb_print
this.pb_search=create pb_search
this.pb_excel=create pb_excel
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_print
this.Control[iCurrent+2]=this.pb_search
this.Control[iCurrent+3]=this.pb_excel
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_2
end on

on w_demo03.destroy
call super::destroy
destroy(this.pb_print)
destroy(this.pb_search)
destroy(this.pb_excel)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_1)
destroy(this.st_2)
end on

type ln_templeft from w_basic`ln_templeft within w_demo03
end type

type ln_tempright from w_basic`ln_tempright within w_demo03
end type

type ln_temptop from w_basic`ln_temptop within w_demo03
end type

type ln_tempbuttom from w_basic`ln_tempbuttom within w_demo03
integer beginx = 32
integer endx = 4503
end type

type ln_tempbutton from w_basic`ln_tempbutton within w_demo03
end type

type ln_tempstart from w_basic`ln_tempstart within w_demo03
end type

type st_title from w_basic`st_title within w_demo03
integer height = 68
end type

type pb_close from w_basic`pb_close within w_demo03
end type

type p_thelp from w_basic`p_thelp within w_demo03
end type

type p_tfavor from w_basic`p_tfavor within w_demo03
end type

type pb_print from pf_u_imagebutton within w_demo03
integer x = 2889
integer y = 28
integer width = 233
integer height = 88
integer taborder = 10
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_print.gif"
boolean fixedtoright = true
string referencedobject = "dw_2"
string datawindowaction = "print"
end type

type pb_search from pf_u_imagebutton within w_demo03
integer x = 2642
integer y = 28
integer width = 233
integer height = 88
integer taborder = 20
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_search.gif"
boolean fixedtoright = true
string referencedobject = "dw_1"
string datawindowaction = "retrieve"
end type

type pb_excel from pf_u_imagebutton within w_demo03
integer x = 3136
integer y = 28
integer width = 279
integer height = 88
integer taborder = 30
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_excel.gif"
boolean fixedtoright = true
string referencedobject = "dw_2"
string datawindowaction = "excel"
end type

type dw_1 from pf_u_datawindow within w_demo03
integer x = 41
integer y = 160
integer width = 1184
integer height = 2436
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_demo01_02"
string retrievalarguments = "as_parent_code=constant.00000"
boolean fixedtoright = true
boolean fixedtobottom = true
boolean scaletoright = true
boolean scaletobottom = true
end type

type dw_2 from pf_u_datawindow within w_demo03
integer x = 1243
integer y = 160
integer width = 1184
integer height = 2436
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_demo01_02"
string uplinkeddatawindow = "dw_1"
string retrievalarguments = "as_parent_code=dw_1.code_id"
boolean fixedtoright = true
boolean fixedtobottom = true
boolean scaletoright = true
boolean scaletobottom = true
end type

type dw_3 from pf_u_datawindow within w_demo03
integer x = 2446
integer y = 160
integer width = 1216
integer height = 2436
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_demo01_02"
string uplinkeddatawindow = "dw_2"
string retrievalarguments = "as_parent_code=dw_2.code_id"
boolean fixedtoright = true
boolean fixedtobottom = true
boolean scaletoright = true
boolean scaletobottom = true
end type

type st_1 from pf_u_splitbar_vertical within w_demo03
integer x = 1225
integer y = 164
integer height = 2428
boolean bringtotop = true
boolean fixedtoright = true
boolean fixedtobottom = true
boolean scaletoright = true
string leftdragobject = "dw_1"
string rightdragobject = "dw_2"
end type

type st_2 from pf_u_splitbar_vertical within w_demo03
integer x = 2427
integer y = 164
integer height = 2428
boolean bringtotop = true
boolean fixedtoright = true
boolean fixedtobottom = true
boolean scaletoright = true
string leftdragobject = "dw_2"
string rightdragobject = "dw_3"
end type

