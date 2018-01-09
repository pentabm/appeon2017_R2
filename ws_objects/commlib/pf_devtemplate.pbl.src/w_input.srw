$PBExportHeader$w_input.srw
$PBExportComments$관리용윈도우
forward
global type w_input from w_basic
end type
type pb_print from pf_u_imagebutton within w_input
end type
type pb_search from pf_u_imagebutton within w_input
end type
type pb_insert from pf_u_imagebutton within w_input
end type
type pb_delete from pf_u_imagebutton within w_input
end type
type pb_save from pf_u_imagebutton within w_input
end type
type pb_excel from pf_u_imagebutton within w_input
end type
end forward

global type w_input from w_basic
pb_print pb_print
pb_search pb_search
pb_insert pb_insert
pb_delete pb_delete
pb_save pb_save
pb_excel pb_excel
end type
global w_input w_input

type variables

end variables

on w_input.create
int iCurrent
call super::create
this.pb_print=create pb_print
this.pb_search=create pb_search
this.pb_insert=create pb_insert
this.pb_delete=create pb_delete
this.pb_save=create pb_save
this.pb_excel=create pb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_print
this.Control[iCurrent+2]=this.pb_search
this.Control[iCurrent+3]=this.pb_insert
this.Control[iCurrent+4]=this.pb_delete
this.Control[iCurrent+5]=this.pb_save
this.Control[iCurrent+6]=this.pb_excel
end on

on w_input.destroy
call super::destroy
destroy(this.pb_print)
destroy(this.pb_search)
destroy(this.pb_insert)
destroy(this.pb_delete)
destroy(this.pb_save)
destroy(this.pb_excel)
end on

type ln_templeft from w_basic`ln_templeft within w_input
end type

type ln_tempright from w_basic`ln_tempright within w_input
end type

type ln_temptop from w_basic`ln_temptop within w_input
end type

type ln_tempbuttom from w_basic`ln_tempbuttom within w_input
end type

type ln_tempbutton from w_basic`ln_tempbutton within w_input
end type

type ln_tempstart from w_basic`ln_tempstart within w_input
end type

type st_title from w_basic`st_title within w_input
end type

type pb_close from w_basic`pb_close within w_input
end type

type p_thelp from w_basic`p_thelp within w_input
string picturename = "..\img\controls\u_imagebutton\topBtn_help.gif"
end type

type p_tfavor from w_basic`p_tfavor within w_input
string picturename = "..\img\controls\u_imagebutton\topBtn_favor.gif"
end type

type pb_print from pf_u_imagebutton within w_input
string tag = "출력"
integer x = 2889
integer y = 28
integer width = 233
integer height = 88
integer taborder = 10
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_print.gif"
boolean fixedtoright = true
string datawindowaction = "print"
end type

type pb_search from pf_u_imagebutton within w_input
string tag = "검색"
integer x = 1902
integer y = 28
integer width = 233
integer height = 88
integer taborder = 20
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_search.gif"
boolean fixedtoright = true
string datawindowaction = "retrieve"
end type

type pb_insert from pf_u_imagebutton within w_input
string tag = "추가"
integer x = 2149
integer y = 28
integer width = 233
integer height = 88
integer taborder = 30
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
boolean fixedtoright = true
string datawindowaction = "insertrow"
end type

type pb_delete from pf_u_imagebutton within w_input
string tag = "삭제"
integer x = 2395
integer y = 28
integer width = 233
integer height = 88
integer taborder = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
boolean fixedtoright = true
string datawindowaction = "deleterow"
end type

type pb_save from pf_u_imagebutton within w_input
string tag = "저장"
integer x = 2642
integer y = 28
integer width = 233
integer height = 88
integer taborder = 50
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
boolean fixedtoright = true
string datawindowaction = "update"
end type

type pb_excel from pf_u_imagebutton within w_input
string tag = "엑셀"
integer x = 3136
integer y = 28
integer width = 279
integer height = 88
integer taborder = 60
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_excel.gif"
boolean fixedtoright = true
string datawindowaction = "excel"
end type

