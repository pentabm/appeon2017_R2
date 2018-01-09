$PBExportHeader$w_test4.srw
forward
global type w_test4 from pf_w_sheet
end type
type cb_1 from pf_u_commandbutton within w_test4
end type
type cb_2 from pf_u_commandbutton within w_test4
end type
type dw_1 from pf_u_datawindow within w_test4
end type
type dw_2 from pf_u_datawindow within w_test4
end type
type st_1 from pf_u_splitbar_vertical within w_test4
end type
type dw_3 from pf_u_datawindow within w_test4
end type
type cb_3 from pf_u_commandbutton within w_test4
end type
type uo_1 from pf_u_webeditor within w_test4
end type
end forward

global type w_test4 from pf_w_sheet
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
dw_2 dw_2
st_1 st_1
dw_3 dw_3
cb_3 cb_3
uo_1 uo_1
end type
global w_test4 w_test4

on w_test4.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.dw_2=create dw_2
this.st_1=create st_1
this.dw_3=create dw_3
this.cb_3=create cb_3
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.uo_1
end on

on w_test4.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.cb_3)
destroy(this.uo_1)
end on

type ln_templeft from pf_w_sheet`ln_templeft within w_test4
end type

type ln_tempright from pf_w_sheet`ln_tempright within w_test4
end type

type ln_temptop from pf_w_sheet`ln_temptop within w_test4
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within w_test4
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within w_test4
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within w_test4
end type

type cb_1 from pf_u_commandbutton within w_test4
integer x = 110
integer y = 60
integer width = 677
integer taborder = 10
boolean bringtotop = true
string text = "이것은 버튼입니다"
string powertiptext = "툴팁텍스트"
string prefixiconfile = "C:\Project\Powerframe_v3.02\source\img\controls\u_commandbutton\sub_btn_icon\sub_btn_ico_15.png"
string referencedobject = "dw_1"
end type

event clicked;call super::clicked;//ole_1.of_navigate( "http://naver.com" )

//uo_1.of_setcontents("")

// Editor 페이지 오픈
//uo_1.ole_ie.of_navigate(uo_1.webeditor_url)

///uo_1.post of_resetcontents()

dw_3.settransobject(sqlca)
//dw_3.retrieve()
dw_3.insertrow(0)

end event

type cb_2 from pf_u_commandbutton within w_test4
integer x = 1070
integer y = 52
integer width = 677
integer taborder = 10
boolean bringtotop = true
string text = "이것은 버튼입니다"
string powertiptext = "툴팁텍스트"
string prefixiconfile = "C:\Project\Powerframe_v3.02\source\img\controls\u_commandbutton\sub_btn_icon\sub_btn_ico_15.png"
string referencedobject = "dw_1"
end type

event clicked;call super::clicked;//ole_1.of_execscript("alert('hello!!');")

end event

type dw_1 from pf_u_datawindow within w_test4
string tag = "onVSplitScroll=noresize"
integer x = 82
integer y = 224
integer taborder = 20
boolean bringtotop = true
end type

type dw_2 from pf_u_datawindow within w_test4
integer x = 1097
integer y = 208
integer taborder = 30
boolean bringtotop = true
end type

type st_1 from pf_u_splitbar_vertical within w_test4
integer x = 914
integer y = 20
integer height = 620
boolean bringtotop = true
boolean scaletobottom = false
string leftdragobject = "cb_1;dw_1"
string rightdragobject = "cb_2; dw_2"
end type

type dw_3 from pf_u_datawindow within w_test4
integer x = 1842
integer y = 28
integer width = 2245
integer height = 580
integer taborder = 30
boolean bringtotop = true
string title = "타이틀입니당"
string dataobject = "d_code_free"
boolean hscrollbar = true
boolean vscrollbar = true
boolean singlerowselection = false
boolean multirowselection = true
boolean confirmupdateonrowchange = false
end type

type cb_3 from pf_u_commandbutton within w_test4
integer x = 91
integer y = 656
integer width = 462
integer taborder = 20
boolean bringtotop = true
string text = "웹에디터"
string powertiptext = "툴팁텍스트"
string prefixiconfile = "C:\Project\Powerframe_v3.02\source\img\controls\u_commandbutton\sub_btn_icon\sub_btn_ico_15.png"
string referencedobject = "dw_1"
end type

event clicked;call super::clicked;//ole_1.of_navigate( "http://naver.com" )

//uo_1.of_setcontents("")

// Editor 페이지 오픈
//uo_1.ole_ie.of_navigate(uo_1.webeditor_url)

///uo_1.post of_resetcontents()

uo_1.of_openwebeditor()

end event

type uo_1 from pf_u_webeditor within w_test4
integer x = 114
integer y = 784
integer width = 3689
integer taborder = 30
boolean bringtotop = true
end type

on uo_1.destroy
call pf_u_webeditor::destroy
end on

