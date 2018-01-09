$PBExportHeader$w_edu01.srw
forward
global type w_edu01 from pf_w_sheet
end type
type cb_1 from pf_u_commandbutton within w_edu01
end type
type p_1 from pf_u_imagebutton within w_edu01
end type
type p_2 from pf_u_imagebutton within w_edu01
end type
type pb_1 from pf_u_picturebutton within w_edu01
end type
type p_3 from pf_u_picture within w_edu01
end type
type tab_1 from tab within w_edu01
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from pf_u_datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tab_1 from tab within w_edu01
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type uo_1 from pf_u_tab within w_edu01
end type
type em_1 from editmask within w_edu01
end type
type cb_3 from commandbutton within w_edu01
end type
type cb_2 from pf_u_commandbutton within w_edu01
end type
type uo_2 from pf_u_tab within w_edu01
end type
type st_2 from pf_u_titletext within w_edu01
end type
type cb_4 from commandbutton within w_edu01
end type
type cb_5 from commandbutton within w_edu01
end type
end forward

global type w_edu01 from pf_w_sheet
cb_1 cb_1
p_1 p_1
p_2 p_2
pb_1 pb_1
p_3 p_3
tab_1 tab_1
uo_1 uo_1
em_1 em_1
cb_3 cb_3
cb_2 cb_2
uo_2 uo_2
st_2 st_2
cb_4 cb_4
cb_5 cb_5
end type
global w_edu01 w_edu01

on w_edu01.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.p_1=create p_1
this.p_2=create p_2
this.pb_1=create pb_1
this.p_3=create p_3
this.tab_1=create tab_1
this.uo_1=create uo_1
this.em_1=create em_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.uo_2=create uo_2
this.st_2=create st_2
this.cb_4=create cb_4
this.cb_5=create cb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.p_2
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.p_3
this.Control[iCurrent+6]=this.tab_1
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.em_1
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.uo_2
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.cb_4
this.Control[iCurrent+14]=this.cb_5
end on

on w_edu01.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.pb_1)
destroy(this.p_3)
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.em_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.uo_2)
destroy(this.st_2)
destroy(this.cb_4)
destroy(this.cb_5)
end on

type ln_templeft from pf_w_sheet`ln_templeft within w_edu01
end type

type ln_tempright from pf_w_sheet`ln_tempright within w_edu01
end type

type ln_temptop from pf_w_sheet`ln_temptop within w_edu01
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within w_edu01
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within w_edu01
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within w_edu01
end type

type cb_1 from pf_u_commandbutton within w_edu01
integer x = 3749
integer y = 44
integer width = 800
integer taborder = 10
boolean bringtotop = true
string text = "파라다이스 5사 통합 프로젝트"
string powertiptext = "툴팁..."
boolean fixedtoright = true
string referencedobject = "dw_1"
string datawindowaction = "retrieve"
end type

type p_1 from pf_u_imagebutton within w_edu01
integer x = 1458
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\Project\Powerframe_v3\source\img\button\imagebutton\topBtn_write.gif"
end type

type p_2 from pf_u_imagebutton within w_edu01
integer x = 1719
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "C:\Project\Powerframe_v3\source\img\button\imagebutton\write2.gif"
end type

type pb_1 from pf_u_picturebutton within w_edu01
integer x = 2633
integer y = 40
integer width = 558
integer taborder = 30
boolean bringtotop = true
string text = "통합 프로젝트"
string iconpath = "C:\Project\Powerframe_v3\source\img\icon\front_title_img.gif"
end type

type p_3 from pf_u_picture within w_edu01
integer x = 69
integer y = 180
integer width = 4402
integer height = 704
boolean bringtotop = true
boolean originalsize = false
string picturename = "C:\Project\Powerframe_v3\source\img\top\w_home_header.jpg"
boolean scaletoright = true
end type

type tab_1 from tab within w_edu01
integer x = 50
integer y = 912
integer width = 4494
integer height = 1304
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 4457
integer height = 1164
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from pf_u_datawindow within tabpage_1
integer x = 18
integer y = 16
integer width = 4407
integer height = 1132
integer taborder = 30
string title = "공통코드"
string dataobject = "pf_d_com_code_mst_04"
boolean singlerowselection = false
boolean multirowselection = true
boolean scaletoright = true
boolean scaletobottom = true
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 4457
integer height = 1164
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 124
integer width = 4457
integer height = 1164
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
end type

type uo_1 from pf_u_tab within w_edu01
integer x = 334
integer y = 652
integer width = 2245
integer height = 100
integer taborder = 30
boolean bringtotop = true
boolean scaletoright = true
boolean scaletobottom = true
string referencedtab = "tab_1"
end type

on uo_1.destroy
call pf_u_tab::destroy
end on

type em_1 from editmask within w_edu01
integer x = 352
integer y = 40
integer width = 352
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
end type

type cb_3 from commandbutton within w_edu01
integer x = 718
integer y = 36
integer width = 123
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "?"
end type

event clicked;pf_f_setcalendardate_em(em_1)

end event

type cb_2 from pf_u_commandbutton within w_edu01
integer x = 2107
integer y = 32
integer width = 466
integer taborder = 40
boolean bringtotop = true
string text = "가나다라"
string prefixiconfile = "C:\Project\Powerframe_v3.01\source\img\controls\u_commandbutton\sub_btn_icon\sub_btn_ico_21.png"
end type

type uo_2 from pf_u_tab within w_edu01
integer x = 201
integer y = 752
integer taborder = 20
boolean bringtotop = true
boolean scaletoright = true
boolean scaletobottom = true
string referencedtab = "tab_1"
end type

on uo_2.destroy
call pf_u_tab::destroy
end on

type st_2 from pf_u_titletext within w_edu01
integer x = 882
integer y = 44
boolean bringtotop = true
string text = "타이틀입니다"
string posticonimage = "C:\Project\Powerframe_v3.01\source\img\commonuse\front_title_img.gif"
end type

type cb_4 from commandbutton within w_edu01
integer x = 718
integer y = 240
integer width = 457
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Run"
end type

event clicked;OLEObject IE
string ls_ie
string ls_url

IE = CREATE OLEObject
IE.ConnectToNewObject("InternetExplorer.Application")

ls_ie = IE.Fullname ()

ls_url = "http://localhost:8080/powerframe"

Run (ls_ie + " -nosessionmerging " + ls_url, Minimized!)

IE.DisconnectObject()
Destroy IE

end event

type cb_5 from commandbutton within w_edu01
integer x = 718
integer y = 392
integer width = 457
integer height = 132
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Rundll"
end type

event clicked;string ls_url

ls_url = "http://localhost:8080/powerframe"
Run("rundll32 url.dll,FileProtocolHandler " + ls_url)

end event

