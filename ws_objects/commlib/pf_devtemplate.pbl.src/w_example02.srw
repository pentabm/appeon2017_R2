$PBExportHeader$w_example02.srw
forward
global type w_example02 from w_input
end type
type dw_cond from pf_u_datawindow within w_example02
end type
type dw_1 from pf_u_datawindow within w_example02
end type
type dw_2 from pf_u_datawindow within w_example02
end type
type dw_3 from pf_u_datawindow within w_example02
end type
type p_1 from pf_u_imagebutton within w_example02
end type
type p_2 from pf_u_imagebutton within w_example02
end type
type cb_1 from pf_u_commandbutton within w_example02
end type
type cb_2 from pf_u_commandbutton within w_example02
end type
type cb_3 from pf_u_commandbutton within w_example02
end type
type st_1 from pf_u_statictext within w_example02
end type
type p_3 from pf_u_picture within w_example02
end type
type cb_4 from pf_u_commandbutton within w_example02
end type
type cb_5 from pf_u_commandbutton within w_example02
end type
end forward

global type w_example02 from w_input
event ue_message ( )
dw_cond dw_cond
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
p_1 p_1
p_2 p_2
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
st_1 st_1
p_3 p_3
cb_4 cb_4
cb_5 cb_5
end type
global w_example02 w_example02

on w_example02.create
int iCurrent
call super::create
this.dw_cond=create dw_cond
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.p_1=create p_1
this.p_2=create p_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.st_1=create st_1
this.p_3=create p_3
this.cb_4=create cb_4
this.cb_5=create cb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cond
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.p_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.p_3
this.Control[iCurrent+12]=this.cb_4
this.Control[iCurrent+13]=this.cb_5
end on

on w_example02.destroy
call super::destroy
destroy(this.dw_cond)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.p_3)
destroy(this.cb_4)
destroy(this.cb_5)
end on

type ln_templeft from w_input`ln_templeft within w_example02
end type

type ln_tempright from w_input`ln_tempright within w_example02
end type

type ln_temptop from w_input`ln_temptop within w_example02
end type

type ln_tempbuttom from w_input`ln_tempbuttom within w_example02
end type

type ln_tempbutton from w_input`ln_tempbutton within w_example02
end type

type ln_tempstart from w_input`ln_tempstart within w_example02
end type

type st_title from w_input`st_title within w_example02
end type

type pb_close from w_input`pb_close within w_example02
end type

type p_thelp from w_input`p_thelp within w_example02
end type

type p_tfavor from w_input`p_tfavor within w_example02
end type

type pb_print from w_input`pb_print within w_example02
string referencedobject = "dw_2"
end type

type pb_search from w_input`pb_search within w_example02
string referencedobject = "dw_1"
end type

type pb_insert from w_input`pb_insert within w_example02
string referencedobject = "dw_2"
end type

type pb_delete from w_input`pb_delete within w_example02
string referencedobject = "dw_2"
end type

type pb_save from w_input`pb_save within w_example02
string referencedobject = "dw_2"
end type

type pb_excel from w_input`pb_excel within w_example02
string referencedobject = "dw_2"
end type

type dw_cond from pf_u_datawindow within w_example02
integer x = 41
integer y = 584
integer width = 1125
integer height = 172
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_code_cond"
boolean issearchcondition = true
string defaultvaluesoninsertrow = "upper_code_id=constant.00000"
end type

type dw_1 from pf_u_datawindow within w_example02
integer x = 41
integer y = 772
integer width = 1125
integer height = 1824
integer taborder = 100
boolean bringtotop = true
string title = "대분류코드"
string dataobject = "d_code_list"
boolean vscrollbar = true
boolean displaytitleontop = true
string retrievalarguments = "as_sys_id = session.sys_id; as_upper_code_id = dw_cond.upper_code_id"
boolean scaletobottom = true
end type

event doubleclicked;call super::doubleclicked;long ll_row

ll_row = this.getnextmodified(0, primary!)
do while ll_row > 0
	messagebox('modified', ll_row)
	ll_row = this.getnextmodified(ll_row, primary!)
loop

end event

type dw_2 from pf_u_datawindow within w_example02
integer x = 1175
integer y = 164
integer width = 2487
integer height = 1224
integer taborder = 110
boolean bringtotop = true
string title = "대분류코드 상세"
string dataobject = "d_code_free"
boolean hscrollbar = true
boolean vscrollbar = true
boolean displaytitleontop = true
string uplinkeddatawindow = "dw_1.sync"
string retrievalarguments = "as_sys_id = session.sys_id; as_upper_code_id = dw_1.upper_code_id; as_code_id=dw_1.code_id"
string defaultvaluesoninsertrow = "sys_id=session.sys_id; upper_code_id=dw_cond.upper_code_id; use_yn=constant.Y; sort_order=dw_1.evaluate(getrow())"
boolean scaletoright = true
end type

event doubleclicked;call super::doubleclicked;long ll_row

ll_row = this.getnextmodified(0, primary!)
do while ll_row > 0
	messagebox('modified', ll_row)
	ll_row = this.getnextmodified(ll_row, primary!)
loop

end event

type dw_3 from pf_u_datawindow within w_example02
integer x = 1175
integer y = 1428
integer width = 2487
integer height = 1168
integer taborder = 100
boolean bringtotop = true
string title = "중분류코드"
string dataobject = "d_code_mst"
boolean hscrollbar = true
boolean vscrollbar = true
boolean displaytitleontop = true
string uplinkeddatawindow = "dw_1"
string retrievalarguments = "as_sys_id=session.sys_id; as_upper_code_id=dw_1.code_id"
string defaultvaluesoninsertrow = "sys_id=session.sys_id; upper_code_id=dw_1.code_id; use_yn=constant.Y; sort_order=dw_3.evaluate(getrow())"
boolean scaletoright = true
boolean scaletobottom = true
end type

event doubleclicked;call super::doubleclicked;long ll_row

ll_row = this.getnextmodified(0, primary!)
do while ll_row > 0
	messagebox('modified', ll_row)
	ll_row = this.getnextmodified(ll_row, primary!)
loop

end event

type p_1 from pf_u_imagebutton within w_example02
integer x = 3182
integer y = 1396
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
boolean fixedtoright = true
string referencedobject = "dw_3"
string datawindowaction = "insertrow"
end type

type p_2 from pf_u_imagebutton within w_example02
integer x = 3429
integer y = 1396
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
boolean fixedtoright = true
string referencedobject = "dw_3"
string datawindowaction = "deleterow"
end type

type cb_1 from pf_u_commandbutton within w_example02
integer x = 1088
integer y = 20
integer width = 315
integer height = 108
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Enable"
end type

event clicked;//gnv_extfunc.pf_EnableSendMessage()

cb_3.enabled = true


end event

type cb_2 from pf_u_commandbutton within w_example02
integer x = 1403
integer y = 20
integer width = 315
integer height = 108
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Disable"
end type

event clicked;//gnv_extfunc.pf_DisableSendMessage()

cb_3.enabled = false

end event

type cb_3 from pf_u_commandbutton within w_example02
integer x = 1719
integer y = 20
integer width = 315
integer height = 108
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Foo"
end type

event clicked;//gnv_extfunc.pf_EnableSendMessage()
//
//st_1.text = '잘돼야 할 텐데...'
//
//gnv_extfunc.pf_DisableSendMessage()
//
//messagebox('handle', handle(st_1))

//gnv_extfunc.pf_EnableSendMessage()
//
//p_3.picturename = 'C:\Project\Powerframe_v3\source\img\icon\chk_ok.jpg'
//
//gnv_extfunc.pf_DisableSendMessage()
//
//messagebox(string(handle(parent)), handle(p_3))

//string ls_aaa
//
//select	 /*+ ALL_ROWS */ 'abcde'
//into :ls_aaa
//from pf_user_mst;

String ls_get_url, ls_post_url
String ls_post_variables, ls_response
String ls_response_text, ls_status_text
long   ll_status_code
blob lb_post_variables
OleObject loo_xmlhttp

//include parameters on the URL here for get parameters
ls_post_url = "http://localhost/pentadispatchers/LoggerServlet"
ls_post_variables = "LogType=info&LogMesg=로거테스트용문자열"
lb_post_variables = blob(ls_post_variables, EncodingUTF8!)

//Create an instance of our COM object
loo_xmlhttp = CREATE oleobject
loo_xmlhttp.ConnectToNewObject("Msxml2.XMLHTTP")

//First lets do a POST request 
loo_xmlhttp.open("POST", ls_post_url, false)
loo_xmlhttp.SetRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8")
loo_xmlhttp.send(lb_post_variables)

//Get our response
ls_status_text = loo_xmlhttp.StatusText
ll_status_code =  loo_xmlhttp.Status

messagebox(ls_status_text, 'status_code=' + string(ll_status_code))

//Check HTTP Response code for errors
if ll_status_code >= 300 then
	MessageBox("HTTP POST Request Failed", ls_response_text)
else
	//Get the response we received from the web server
	ls_response_text = loo_xmlhttp.ResponseText
	MessageBox("POST Request Succeeded", ls_response_text)
end if

//Done so cleanup
loo_xmlhttp.DisconnectObject()
 
end event

type st_1 from pf_u_statictext within w_example02
integer x = 69
integer y = 184
boolean bringtotop = true
end type

type p_3 from pf_u_picture within w_example02
integer x = 59
integer y = 316
integer width = 73
integer height = 64
boolean bringtotop = true
string picturename = "AddWatch!"
end type

type cb_4 from pf_u_commandbutton within w_example02
integer x = 1088
integer y = 148
integer width = 315
integer height = 108
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Visible"
end type

event clicked;call super::clicked;cb_3.visible = true

end event

type cb_5 from pf_u_commandbutton within w_example02
integer x = 1403
integer y = 148
integer width = 315
integer height = 108
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Invisible"
end type

event clicked;call super::clicked;cb_3.visible = false

end event

