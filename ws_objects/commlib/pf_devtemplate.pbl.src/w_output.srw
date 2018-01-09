$PBExportHeader$w_output.srw
$PBExportComments$출력용윈도우
forward
global type w_output from w_basic
end type
type pb_print from pf_u_imagebutton within w_output
end type
type pb_search from pf_u_imagebutton within w_output
end type
type pb_excel from pf_u_imagebutton within w_output
end type
end forward

global type w_output from w_basic
pb_print pb_print
pb_search pb_search
pb_excel pb_excel
end type
global w_output w_output

type variables

end variables

on w_output.create
int iCurrent
call super::create
this.pb_print=create pb_print
this.pb_search=create pb_search
this.pb_excel=create pb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_print
this.Control[iCurrent+2]=this.pb_search
this.Control[iCurrent+3]=this.pb_excel
end on

on w_output.destroy
call super::destroy
destroy(this.pb_print)
destroy(this.pb_search)
destroy(this.pb_excel)
end on

type ln_templeft from w_basic`ln_templeft within w_output
end type

type ln_tempright from w_basic`ln_tempright within w_output
end type

type ln_temptop from w_basic`ln_temptop within w_output
end type

type ln_tempbuttom from w_basic`ln_tempbuttom within w_output
integer beginx = 32
integer endx = 4503
end type

type ln_tempbutton from w_basic`ln_tempbutton within w_output
end type

type ln_tempstart from w_basic`ln_tempstart within w_output
end type

type st_title from w_basic`st_title within w_output
integer height = 68
end type

type pb_close from w_basic`pb_close within w_output
end type

type p_thelp from w_basic`p_thelp within w_output
end type

type p_tfavor from w_basic`p_tfavor within w_output
end type

type pb_print from pf_u_imagebutton within w_output
integer x = 2889
integer y = 28
integer width = 233
integer height = 88
integer taborder = 10
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_print.gif"
boolean fixedtoright = true
string datawindowaction = "print"
end type

type pb_search from pf_u_imagebutton within w_output
integer x = 2642
integer y = 28
integer width = 233
integer height = 88
integer taborder = 20
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_search.gif"
boolean fixedtoright = true
string datawindowaction = "retrieve"
end type

type pb_excel from pf_u_imagebutton within w_output
integer x = 3136
integer y = 28
integer width = 279
integer height = 88
integer taborder = 30
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_excel.gif"
boolean fixedtoright = true
string datawindowaction = "excel"
end type

