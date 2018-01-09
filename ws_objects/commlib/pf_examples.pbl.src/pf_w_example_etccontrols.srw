$PBExportHeader$pf_w_example_etccontrols.srw
forward
global type pf_w_example_etccontrols from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_etccontrols
end type
type st_2 from pf_u_statictext within pf_w_example_etccontrols
end type
type st_1 from pf_u_statictext within pf_w_example_etccontrols
end type
type st_3 from pf_u_statictext within pf_w_example_etccontrols
end type
type p_3 from pf_u_picture within pf_w_example_etccontrols
end type
type cb_2 from commandbutton within pf_w_example_etccontrols
end type
type sle_left from singlelineedit within pf_w_example_etccontrols
end type
type sle_top from singlelineedit within pf_w_example_etccontrols
end type
type sle_width from singlelineedit within pf_w_example_etccontrols
end type
type sle_height from singlelineedit within pf_w_example_etccontrols
end type
type st_ from statictext within pf_w_example_etccontrols
end type
type st_5 from statictext within pf_w_example_etccontrols
end type
type st_6 from statictext within pf_w_example_etccontrols
end type
type st_7 from statictext within pf_w_example_etccontrols
end type
type p_4 from pf_u_picture within pf_w_example_etccontrols
end type
type p_5 from pf_u_picture within pf_w_example_etccontrols
end type
type cb_3 from commandbutton within pf_w_example_etccontrols
end type
type st_4 from pf_u_statictext within pf_w_example_etccontrols
end type
type tab_1 from tab within pf_w_example_etccontrols
end type
type tabpage_1 from userobject within tab_1
end type
type st_10 from statictext within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_10 st_10
end type
type tabpage_2 from userobject within tab_1
end type
type st_11 from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_1
st_11 st_11
end type
type tabpage_3 from userobject within tab_1
end type
type st_12 from statictext within tabpage_3
end type
type tabpage_3 from userobject within tab_1
st_12 st_12
end type
type tabpage_4 from userobject within tab_1
end type
type st_13 from statictext within tabpage_4
end type
type tabpage_4 from userobject within tab_1
st_13 st_13
end type
type tab_1 from tab within pf_w_example_etccontrols
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type uo_tab1 from pf_u_tab within pf_w_example_etccontrols
end type
type st_9 from pf_u_statictext within pf_w_example_etccontrols
end type
type ole_1 from pf_u_webbrowser within pf_w_example_etccontrols
end type
type cb_1 from commandbutton within pf_w_example_etccontrols
end type
type cb_4 from commandbutton within pf_w_example_etccontrols
end type
type st_8 from pf_u_statictext within pf_w_example_etccontrols
end type
type st_14 from pf_u_statictext within pf_w_example_etccontrols
end type
type st_15 from pf_u_statictext within pf_w_example_etccontrols
end type
type em_1 from pf_u_editmask within pf_w_example_etccontrols
end type
type pb_1 from picturebutton within pf_w_example_etccontrols
end type
type dw_calendar from pf_u_datawindow within pf_w_example_etccontrols
end type
type cb_5 from commandbutton within pf_w_example_etccontrols
end type
type cb_6 from commandbutton within pf_w_example_etccontrols
end type
type cb_7 from commandbutton within pf_w_example_etccontrols
end type
type cb_8 from commandbutton within pf_w_example_etccontrols
end type
type ln_1 from line within pf_w_example_etccontrols
end type
type ln_2 from line within pf_w_example_etccontrols
end type
type ln_3 from line within pf_w_example_etccontrols
end type
end forward

global type pf_w_example_etccontrols from pf_w_sheet
string title = "기타UI 샘플 윈도우"
cb_close cb_close
st_2 st_2
st_1 st_1
st_3 st_3
p_3 p_3
cb_2 cb_2
sle_left sle_left
sle_top sle_top
sle_width sle_width
sle_height sle_height
st_ st_
st_5 st_5
st_6 st_6
st_7 st_7
p_4 p_4
p_5 p_5
cb_3 cb_3
st_4 st_4
tab_1 tab_1
uo_tab1 uo_tab1
st_9 st_9
ole_1 ole_1
cb_1 cb_1
cb_4 cb_4
st_8 st_8
st_14 st_14
st_15 st_15
em_1 em_1
pb_1 pb_1
dw_calendar dw_calendar
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
cb_8 cb_8
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
end type
global pf_w_example_etccontrols pf_w_example_etccontrols

type variables

end variables

on pf_w_example_etccontrols.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_2=create st_2
this.st_1=create st_1
this.st_3=create st_3
this.p_3=create p_3
this.cb_2=create cb_2
this.sle_left=create sle_left
this.sle_top=create sle_top
this.sle_width=create sle_width
this.sle_height=create sle_height
this.st_=create st_
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.p_4=create p_4
this.p_5=create p_5
this.cb_3=create cb_3
this.st_4=create st_4
this.tab_1=create tab_1
this.uo_tab1=create uo_tab1
this.st_9=create st_9
this.ole_1=create ole_1
this.cb_1=create cb_1
this.cb_4=create cb_4
this.st_8=create st_8
this.st_14=create st_14
this.st_15=create st_15
this.em_1=create em_1
this.pb_1=create pb_1
this.dw_calendar=create dw_calendar
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_8=create cb_8
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.p_3
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.sle_left
this.Control[iCurrent+8]=this.sle_top
this.Control[iCurrent+9]=this.sle_width
this.Control[iCurrent+10]=this.sle_height
this.Control[iCurrent+11]=this.st_
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.st_7
this.Control[iCurrent+15]=this.p_4
this.Control[iCurrent+16]=this.p_5
this.Control[iCurrent+17]=this.cb_3
this.Control[iCurrent+18]=this.st_4
this.Control[iCurrent+19]=this.tab_1
this.Control[iCurrent+20]=this.uo_tab1
this.Control[iCurrent+21]=this.st_9
this.Control[iCurrent+22]=this.ole_1
this.Control[iCurrent+23]=this.cb_1
this.Control[iCurrent+24]=this.cb_4
this.Control[iCurrent+25]=this.st_8
this.Control[iCurrent+26]=this.st_14
this.Control[iCurrent+27]=this.st_15
this.Control[iCurrent+28]=this.em_1
this.Control[iCurrent+29]=this.pb_1
this.Control[iCurrent+30]=this.dw_calendar
this.Control[iCurrent+31]=this.cb_5
this.Control[iCurrent+32]=this.cb_6
this.Control[iCurrent+33]=this.cb_7
this.Control[iCurrent+34]=this.cb_8
this.Control[iCurrent+35]=this.ln_1
this.Control[iCurrent+36]=this.ln_2
this.Control[iCurrent+37]=this.ln_3
end on

on pf_w_example_etccontrols.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.p_3)
destroy(this.cb_2)
destroy(this.sle_left)
destroy(this.sle_top)
destroy(this.sle_width)
destroy(this.sle_height)
destroy(this.st_)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.p_4)
destroy(this.p_5)
destroy(this.cb_3)
destroy(this.st_4)
destroy(this.tab_1)
destroy(this.uo_tab1)
destroy(this.st_9)
destroy(this.ole_1)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.st_8)
destroy(this.st_14)
destroy(this.st_15)
destroy(this.em_1)
destroy(this.pb_1)
destroy(this.dw_calendar)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
end on

event pfe_postopen;call super::pfe_postopen;dw_calendar.insertrow(0)

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_etccontrols
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_etccontrols
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_etccontrols
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_etccontrols
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_etccontrols
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_etccontrols
end type

type cb_close from pf_u_commandbutton within pf_w_example_etccontrols
integer x = 4279
integer y = 32
integer width = 274
integer height = 96
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = hangeul!
string text = "닫기"
string powertiptext = "해당 화면을 닫습니다."
boolean applydesign = false
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)
end event

type st_2 from pf_u_statictext within pf_w_example_etccontrols
integer x = 2583
integer y = 152
integer width = 1696
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
long textcolor = 20066866
string text = "Picture [ pf_controls.pbl > pf_u_picture ]"
end type

type st_1 from pf_u_statictext within pf_w_example_etccontrols
integer x = 2583
integer y = 268
integer width = 485
boolean bringtotop = true
fontcharset fontcharset = hangeul!
long textcolor = 20066866
string text = " ▶ 이미지 추출"
end type

type st_3 from pf_u_statictext within pf_w_example_etccontrols
integer x = 2583
integer y = 784
integer width = 745
boolean bringtotop = true
fontcharset fontcharset = hangeul!
long textcolor = 20066866
string text = " ▶ 클립보드 이미지 붙여넣기"
end type

type p_3 from pf_u_picture within pf_w_example_etccontrols
integer x = 2679
integer y = 380
integer width = 293
integer height = 256
boolean bringtotop = true
string picturename = "..\img\mainframe\w_favorite\favorite.jpg"
end type

type cb_2 from commandbutton within pf_w_example_etccontrols
integer x = 4064
integer y = 764
integer width = 402
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "붙여넣기"
end type

event clicked;p_5.picturename = ''
p_5.of_getclipboardimage()

end event

type sle_left from singlelineedit within pf_w_example_etccontrols
integer x = 3474
integer y = 328
integer width = 402
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string text = "0"
borderstyle borderstyle = stylelowered!
end type

type sle_top from singlelineedit within pf_w_example_etccontrols
integer x = 3474
integer y = 416
integer width = 402
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string text = "0"
borderstyle borderstyle = stylelowered!
end type

type sle_width from singlelineedit within pf_w_example_etccontrols
integer x = 3474
integer y = 504
integer width = 402
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string text = "200"
borderstyle borderstyle = stylelowered!
end type

type sle_height from singlelineedit within pf_w_example_etccontrols
integer x = 3474
integer y = 592
integer width = 402
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string text = "200"
borderstyle borderstyle = stylelowered!
end type

type st_ from statictext within pf_w_example_etccontrols
integer x = 3214
integer y = 344
integer width = 114
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string text = "Left"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within pf_w_example_etccontrols
integer x = 3214
integer y = 432
integer width = 114
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string text = "Top"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within pf_w_example_etccontrols
integer x = 3214
integer y = 520
integer width = 174
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string text = "Width"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within pf_w_example_etccontrols
integer x = 3214
integer y = 608
integer width = 192
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string text = "Height"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_4 from pf_u_picture within pf_w_example_etccontrols
integer x = 4078
integer y = 308
integer width = 370
integer height = 256
boolean bringtotop = true
boolean originalsize = false
end type

type p_5 from pf_u_picture within pf_w_example_etccontrols
integer x = 2642
integer y = 896
integer width = 1815
integer height = 352
boolean bringtotop = true
boolean originalsize = false
end type

type cb_3 from commandbutton within pf_w_example_etccontrols
integer x = 4064
integer y = 604
integer width = 402
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "이미지 추출"
end type

event clicked;string ls_temppath
long ll_left, ll_top, ll_width, ll_height

ls_temppath = gnv_extfunc.of_getsystemtemppath() + "temp01.jpg"

ll_left = long(sle_left.text)
ll_top = long(sle_top.text)
ll_width = long(sle_width.text)
ll_height = long(sle_height.text)

p_3.of_cropimage(ls_temppath, ll_left, ll_top, ll_width, ll_height)

p_4.picturename = ''
p_4.picturename = ls_temppath

end event

type st_4 from pf_u_statictext within pf_w_example_etccontrols
integer x = 146
integer y = 152
integer width = 1696
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
long textcolor = 20066866
string text = "Tab [ pf_controls.pbl > pf_u_tab ]"
end type

type tab_1 from tab within pf_w_example_etccontrols
integer x = 146
integer y = 276
integer width = 2240
integer height = 588
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 2203
integer height = 464
string text = "tabpage_1"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
st_10 st_10
end type

on tabpage_1.create
this.st_10=create st_10
this.Control[]={this.st_10}
end on

on tabpage_1.destroy
destroy(this.st_10)
end on

type st_10 from statictext within tabpage_1
integer x = 800
integer y = 152
integer width = 402
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "탭페이지1"
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 2203
integer height = 464
string text = "tabpage_2"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
st_11 st_11
end type

on tabpage_2.create
this.st_11=create st_11
this.Control[]={this.st_11}
end on

on tabpage_2.destroy
destroy(this.st_11)
end on

type st_11 from statictext within tabpage_2
integer x = 800
integer y = 152
integer width = 402
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "탭페이지2"
boolean focusrectangle = false
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 2203
integer height = 464
boolean enabled = false
string text = "tabpage_3"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
st_12 st_12
end type

on tabpage_3.create
this.st_12=create st_12
this.Control[]={this.st_12}
end on

on tabpage_3.destroy
destroy(this.st_12)
end on

type st_12 from statictext within tabpage_3
integer x = 800
integer y = 152
integer width = 402
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "탭페이지3"
boolean focusrectangle = false
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 2203
integer height = 464
string text = "tabpage_4"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
st_13 st_13
end type

on tabpage_4.create
this.st_13=create st_13
this.Control[]={this.st_13}
end on

on tabpage_4.destroy
destroy(this.st_13)
end on

type st_13 from statictext within tabpage_4
integer x = 800
integer y = 152
integer width = 402
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "탭페이지4"
boolean focusrectangle = false
end type

type uo_tab1 from pf_u_tab within pf_w_example_etccontrols
integer x = 581
integer y = 24
integer width = 2203
integer taborder = 40
boolean bringtotop = true
string referencedtab = "tab_1"
end type

on uo_tab1.destroy
call pf_u_tab::destroy
end on

type st_9 from pf_u_statictext within pf_w_example_etccontrols
integer x = 169
integer y = 980
integer width = 1358
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
long textcolor = 20066866
string text = "IE [ pf_controls.pbl > pf_u_webbrowser ]"
end type

type ole_1 from pf_u_webbrowser within pf_w_example_etccontrols
integer x = 169
integer y = 1084
integer width = 2208
integer height = 1100
integer taborder = 40
boolean bringtotop = true
boolean border = true
string binarykey = "pf_w_example_etccontrols.win"
boolean scaletobottom = true
end type

type cb_1 from commandbutton within pf_w_example_etccontrols
integer x = 1550
integer y = 968
integer width = 402
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "navigate"
end type

event clicked;ole_1.of_navigate('http://www.penta.co.kr')

end event

type cb_4 from commandbutton within pf_w_example_etccontrols
integer x = 1966
integer y = 968
integer width = 402
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "getHTML"
end type

event clicked;messagebox('documentHTML', ole_1.of_getdocumenthtml())

end event

type st_8 from pf_u_statictext within pf_w_example_etccontrols
integer x = 2574
integer y = 1388
integer width = 1696
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
long textcolor = 20066866
string text = "Calendar [ pf_utilities.pbl > pf_w_calendar ]"
end type

type st_14 from pf_u_statictext within pf_w_example_etccontrols
integer x = 2574
integer y = 1508
integer width = 485
boolean bringtotop = true
fontcharset fontcharset = hangeul!
long textcolor = 20066866
string text = " ▶ EditMask 용"
end type

type st_15 from pf_u_statictext within pf_w_example_etccontrols
integer x = 2574
integer y = 1740
integer width = 512
boolean bringtotop = true
fontcharset fontcharset = hangeul!
long textcolor = 20066866
string text = " ▶ Datawindow 용"
end type

type em_1 from pf_u_editmask within pf_w_example_etccontrols
integer x = 2642
integer y = 1620
integer taborder = 50
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
end type

type pb_1 from picturebutton within pf_w_example_etccontrols
integer x = 3049
integer y = 1612
integer width = 114
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string picturename = "..\img\commonuse\ib_calendar.gif"
string disabledname = "..\img\commonuse\ib_calendar.gif"
alignment htextalign = left!
end type

event clicked;pf_f_setcalendardate_em(em_1)

end event

type dw_calendar from pf_u_datawindow within pf_w_example_etccontrols
integer x = 2642
integer y = 1832
integer width = 1024
integer height = 352
integer taborder = 60
boolean bringtotop = true
string dataobject = "pf_d_example_etccontrols_01"
end type

event clicked;call super::clicked;choose case dwo.name
	case 'p_from'
		pf_f_setcalendardate_dw(this, this.object.from_dt, row)
	case 'p_to'
		pf_f_setcalendardate_dw(this, this.object.to_dt, row)
end choose

end event

type cb_5 from commandbutton within pf_w_example_etccontrols
integer x = 2066
integer y = 144
integer width = 329
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "TabText"
end type

event clicked;// 직접 탭페이지 TEXT 처리
tab_1.tabpage_2.text = '탭 텍스트 변경'

// 간접 탭페이지 TEXT 처리
//uo_tab1.of_settabpagetext(2, '탭 텍스트 변경')

end event

type cb_6 from commandbutton within pf_w_example_etccontrols
integer x = 1737
integer y = 144
integer width = 329
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "Enabled"
end type

event clicked;// 직접 탭페이지 ENABLE 처리
tab_1.tabpage_2.enabled = not tab_1.tabpage_2.enabled

// 간접 탭페이지 ENABLE 처리
//uo_tab1.of_setTabpageEnabled(2, not tab_1.tabpage_2.enabled)

end event

type cb_7 from commandbutton within pf_w_example_etccontrols
integer x = 1408
integer y = 144
integer width = 329
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "Visible"
end type

event clicked;// 직접 탭페이지 VISIBLE 처리
tab_1.tabpage_2.visible = not tab_1.tabpage_2.visible

// 간접 탭페이지 VISIBLE 처리
//uo_tab1.of_setTabpageVisible(2, not tab_1.tabpage_2.visible)

end event

type cb_8 from commandbutton within pf_w_example_etccontrols
boolean visible = false
integer x = 3607
integer y = 28
integer width = 329
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "TabText"
end type

event clicked;//open(pf_w_example_hashtable, 

window lw_tobeopen

Open(lw_tobeopen, 'pf_w_example_hashtable')

lw_tobeopen.windowstate = maximized!




end event

type ln_1 from line within pf_w_example_etccontrols
long linecolor = 134217728
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2473
integer beginy = 188
integer endx = 2473
integer endy = 2524
end type

type ln_2 from line within pf_w_example_etccontrols
long linecolor = 134217728
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 137
integer beginy = 916
integer endx = 2478
integer endy = 916
end type

type ln_3 from line within pf_w_example_etccontrols
long linecolor = 134217728
linestyle linestyle = dot!
integer linethickness = 4
integer beginx = 2478
integer beginy = 1304
integer endx = 4471
integer endy = 1304
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Dpf_w_example_etccontrols.bin 
2E00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000004ed8bcd001d3470200000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f000000004ed8bcd001d347024ed8bcd001d34702000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
26ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c000031eb00001c6c0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c000031eb00001c6c0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Dpf_w_example_etccontrols.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
