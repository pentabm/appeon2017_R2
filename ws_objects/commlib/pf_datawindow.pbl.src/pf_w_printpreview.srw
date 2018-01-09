$PBExportHeader$pf_w_printpreview.srw
$PBExportComments$출력 미리보기 윈도우
forward
global type pf_w_printpreview from pf_w_popup
end type
type cb_2 from pf_u_commandbutton within pf_w_printpreview
end type
type cb_1 from pf_u_commandbutton within pf_w_printpreview
end type
type cb_printsize from pf_u_commandbutton within pf_w_printpreview
end type
type cb_preview from pf_u_commandbutton within pf_w_printpreview
end type
type print_setup from singlelineedit within pf_w_printpreview
end type
type cb_saveas from pf_u_commandbutton within pf_w_printpreview
end type
type cb_printersetup from pf_u_commandbutton within pf_w_printpreview
end type
type cb_print from pf_u_commandbutton within pf_w_printpreview
end type
type cb_close from pf_u_commandbutton within pf_w_printpreview
end type
type r_2 from pf_u_rectangle within pf_w_printpreview
end type
type st_title from statictext within pf_w_printpreview
end type
type st_10 from statictext within pf_w_printpreview
end type
type st_9 from statictext within pf_w_printpreview
end type
type cbx_tot from checkbox within pf_w_printpreview
end type
type ddlb_way from dropdownlistbox within pf_w_printpreview
end type
type ddlb_paper from dropdownlistbox within pf_w_printpreview
end type
type st_6 from statictext within pf_w_printpreview
end type
type sle_rang from singlelineedit within pf_w_printpreview
end type
type dw_print from pf_u_datawindow within pf_w_printpreview
end type
type hsb_1 from hscrollbar within pf_w_printpreview
end type
type hsb_2 from hscrollbar within pf_w_printpreview
end type
type st_size_rate from statictext within pf_w_printpreview
end type
type st_pre_rate from statictext within pf_w_printpreview
end type
type cb_first from pf_u_commandbutton within pf_w_printpreview
end type
type cb_last from pf_u_commandbutton within pf_w_printpreview
end type
type cb_prior from pf_u_commandbutton within pf_w_printpreview
end type
type cb_next from pf_u_commandbutton within pf_w_printpreview
end type
type st_2 from statictext within pf_w_printpreview
end type
type st_3 from statictext within pf_w_printpreview
end type
type r_5 from rectangle within pf_w_printpreview
end type
type r_6 from rectangle within pf_w_printpreview
end type
type r_1 from pf_u_rectangle within pf_w_printpreview
end type
type r_7 from rectangle within pf_w_printpreview
end type
type ln_6 from line within pf_w_printpreview
end type
type r_3 from rectangle within pf_w_printpreview
end type
type ln_5 from line within pf_w_printpreview
end type
type r_4 from pf_u_rectangle within pf_w_printpreview
end type
type dw_column from pf_u_datawindow within pf_w_printpreview
end type
end forward

global type pf_w_printpreview from pf_w_popup
integer width = 4027
integer height = 2816
string title = "출력 미리보기"
boolean maxbox = true
boolean resizable = true
long backcolor = 33554431
cb_2 cb_2
cb_1 cb_1
cb_printsize cb_printsize
cb_preview cb_preview
print_setup print_setup
cb_saveas cb_saveas
cb_printersetup cb_printersetup
cb_print cb_print
cb_close cb_close
r_2 r_2
st_title st_title
st_10 st_10
st_9 st_9
cbx_tot cbx_tot
ddlb_way ddlb_way
ddlb_paper ddlb_paper
st_6 st_6
sle_rang sle_rang
dw_print dw_print
hsb_1 hsb_1
hsb_2 hsb_2
st_size_rate st_size_rate
st_pre_rate st_pre_rate
cb_first cb_first
cb_last cb_last
cb_prior cb_prior
cb_next cb_next
st_2 st_2
st_3 st_3
r_5 r_5
r_6 r_6
r_1 r_1
r_7 r_7
ln_6 ln_6
r_3 r_3
ln_5 ln_5
r_4 r_4
dw_column dw_column
end type
global pf_w_printpreview pf_w_printpreview

type prototypes
Function long GetWindowLongA(ulong hwnd, integer inx) library "user32.dll" 
Function long SetWindowLongA(ulong hwnd, integer inx, ulong lv) library "user32.dll"

end prototypes

type variables
long il_return

end variables

forward prototypes
public function integer of_setheadertextcolor ()
public function integer of_setdatawindowcolumn ()
end prototypes

public function integer of_setheadertextcolor ();// Header Band에 폰트 컬러가 흰색인 텍스트가 존재하는 경우
// 이를 검은색으로 변경시킴 --> 화면에 안 보이는 문제 처리

long ll_objcnt, i
string ls_objects[]

ll_objcnt = pf_f_parsetoarray(dw_print.describe("Datawindow.Objects"), "~t", ls_objects[])
for i = 1 to ll_objcnt
	if dw_print.describe(ls_objects[i] + ".Type") = "text" and dw_print.describe(ls_objects[i] + ".Band") = "header" then
		choose case long(dw_print.describe(ls_objects[i] + ".Color"))
			case 16777215, 1073741824		// White or Windows Background
				dw_print.modify(ls_objects[i] + ".Color=" + string(rgb(80, 80, 80)))
		end choose
	end if
next

return success

end function

public function integer of_setdatawindowcolumn ();// 컬럼 삭제용 컬럼 정보 설정

if pf_f_isemptystring(dw_print.dataobject) then return failure

integer li_colcnt, i
string ls_column, ls_title
long ll_new

li_colcnt = integer(dw_print.describe("Datawindow.Column.Count"))
for i = 1 to li_colcnt
	ls_column = dw_print.describe("#" + string(i) + ".Name")
	ls_title = dw_print.describe(ls_column + "_t.Text")
	if ls_title = '!' then continue
	
	ll_new = dw_column.insertrow(0)
	dw_column.setitem(ll_new, 'column_id', ls_column)
	dw_column.setitem(ll_new, 'column_nm', ls_title)
next

return success

end function

on pf_w_printpreview.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_printsize=create cb_printsize
this.cb_preview=create cb_preview
this.print_setup=create print_setup
this.cb_saveas=create cb_saveas
this.cb_printersetup=create cb_printersetup
this.cb_print=create cb_print
this.cb_close=create cb_close
this.r_2=create r_2
this.st_title=create st_title
this.st_10=create st_10
this.st_9=create st_9
this.cbx_tot=create cbx_tot
this.ddlb_way=create ddlb_way
this.ddlb_paper=create ddlb_paper
this.st_6=create st_6
this.sle_rang=create sle_rang
this.dw_print=create dw_print
this.hsb_1=create hsb_1
this.hsb_2=create hsb_2
this.st_size_rate=create st_size_rate
this.st_pre_rate=create st_pre_rate
this.cb_first=create cb_first
this.cb_last=create cb_last
this.cb_prior=create cb_prior
this.cb_next=create cb_next
this.st_2=create st_2
this.st_3=create st_3
this.r_5=create r_5
this.r_6=create r_6
this.r_1=create r_1
this.r_7=create r_7
this.ln_6=create ln_6
this.r_3=create r_3
this.ln_5=create ln_5
this.r_4=create r_4
this.dw_column=create dw_column
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_printsize
this.Control[iCurrent+4]=this.cb_preview
this.Control[iCurrent+5]=this.print_setup
this.Control[iCurrent+6]=this.cb_saveas
this.Control[iCurrent+7]=this.cb_printersetup
this.Control[iCurrent+8]=this.cb_print
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.r_2
this.Control[iCurrent+11]=this.st_title
this.Control[iCurrent+12]=this.st_10
this.Control[iCurrent+13]=this.st_9
this.Control[iCurrent+14]=this.cbx_tot
this.Control[iCurrent+15]=this.ddlb_way
this.Control[iCurrent+16]=this.ddlb_paper
this.Control[iCurrent+17]=this.st_6
this.Control[iCurrent+18]=this.sle_rang
this.Control[iCurrent+19]=this.dw_print
this.Control[iCurrent+20]=this.hsb_1
this.Control[iCurrent+21]=this.hsb_2
this.Control[iCurrent+22]=this.st_size_rate
this.Control[iCurrent+23]=this.st_pre_rate
this.Control[iCurrent+24]=this.cb_first
this.Control[iCurrent+25]=this.cb_last
this.Control[iCurrent+26]=this.cb_prior
this.Control[iCurrent+27]=this.cb_next
this.Control[iCurrent+28]=this.st_2
this.Control[iCurrent+29]=this.st_3
this.Control[iCurrent+30]=this.r_5
this.Control[iCurrent+31]=this.r_6
this.Control[iCurrent+32]=this.r_1
this.Control[iCurrent+33]=this.r_7
this.Control[iCurrent+34]=this.ln_6
this.Control[iCurrent+35]=this.r_3
this.Control[iCurrent+36]=this.ln_5
this.Control[iCurrent+37]=this.r_4
this.Control[iCurrent+38]=this.dw_column
end on

on pf_w_printpreview.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_printsize)
destroy(this.cb_preview)
destroy(this.print_setup)
destroy(this.cb_saveas)
destroy(this.cb_printersetup)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.r_2)
destroy(this.st_title)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.cbx_tot)
destroy(this.ddlb_way)
destroy(this.ddlb_paper)
destroy(this.st_6)
destroy(this.sle_rang)
destroy(this.dw_print)
destroy(this.hsb_1)
destroy(this.hsb_2)
destroy(this.st_size_rate)
destroy(this.st_pre_rate)
destroy(this.cb_first)
destroy(this.cb_last)
destroy(this.cb_prior)
destroy(this.cb_next)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.r_5)
destroy(this.r_6)
destroy(this.r_1)
destroy(this.r_7)
destroy(this.ln_6)
destroy(this.r_3)
destroy(this.ln_5)
destroy(this.r_4)
destroy(this.dw_column)
end on

event open;call super::open;datawindow	ldw_print
blob lb_data

if not isvalid(message.powerobjectparm) then return
if message.powerobjectparm.typeof() <> datawindow! then return
ldw_print = message.powerobjectparm

dw_print.dataobject = ldw_print.dataobject
ldw_print.getfullstate(lb_data)
dw_print.setfullstate(lb_data)

this.of_setheadertextcolor()

if lower(dw_print.describe("DataWindow.Print.Preview")) <> 'yes' then
	dw_print.modify("DataWindow.Print.Preview.Rulers = 'Yes'~r~nDataWindow.Print.Preview = 'Yes'")
end if

dw_print.HscrollBar = True
dw_print.VscrollBar = True

string ls_preview, ls_zoom
string ls_paper, ls_way

ls_preview = ldw_print.describe("DataWindow.Print.Preview.Zoom")
ls_zoom = ldw_print.describe("DataWindow.Zoom")
ls_paper = ldw_print.describe("DataWindow.Print.Paper.Size")
ls_way = ldw_print.describe("Datawindow.Print.Orientation")

if isnumber(ls_preview) then
	hsb_1.position = integer(ls_preview)
	st_pre_rate.text  = trim(ls_preview) + '%'
else
	st_pre_rate.text  = string(hsb_1.position) + '%'
end if

if isnumber(ls_zoom) then
	hsb_2.position = integer(ls_zoom)
	st_size_rate.text = trim(ls_zoom) + '%'
else
	st_size_rate.text = string(hsb_2.position) + '%'
end if

cbx_tot.checked = true
print_setup.text = dw_print.Describe("DataWindow.Printer") 

choose case integer(ls_paper)
	case 0
		ddlb_paper.SelectItem(1)
	case 4
		ddlb_paper.SelectItem(2)
	case 1
		ddlb_paper.SelectItem(3)
	case 9
		ddlb_paper.SelectItem(4)
	case 11
		ddlb_paper.SelectItem(5)
	case 12
		ddlb_paper.SelectItem(6)
	case 13
		ddlb_paper.SelectItem(7)
	case else
		ddlb_paper.SelectItem(1)
end choose

choose case integer(ls_way)
	case 0
		ddlb_way.SelectItem(1)
	case 1
		ddlb_way.SelectItem(2)
	case 2
		ddlb_way.SelectItem(3)
end choose

sle_rang.Enabled = False
st_6.TextColor = RGB(150,150,150)

end event

event key;Choose Case key
	Case KeyEscape!
		cb_close.triggerEvent('Clicked')
End Choose

end event

event pfe_postopen;call super::pfe_postopen;this.of_setdatawindowcolumn()

cb_printsize.TriggerEvent(Clicked!)

end event

type ln_templeft from pf_w_popup`ln_templeft within pf_w_printpreview
end type

type ln_tempright from pf_w_popup`ln_tempright within pf_w_printpreview
end type

type ln_temptop from pf_w_popup`ln_temptop within pf_w_printpreview
end type

type ln_tempbuttom from pf_w_popup`ln_tempbuttom within pf_w_printpreview
end type

type ln_tempbutton from pf_w_popup`ln_tempbutton within pf_w_printpreview
end type

type ln_tempstart from pf_w_popup`ln_tempstart within pf_w_printpreview
end type

type cb_2 from pf_u_commandbutton within pf_w_printpreview
integer x = 960
integer y = 16
integer width = 622
integer height = 100
integer taborder = 60
boolean bringtotop = true
string text = "출력크기 용지에 맞춤"
end type

event clicked;call super::clicked;long ll_pagecnt, ll_zoom

if dw_print.describe("Datawindow.Print.Preview") <> 'yes' then return

setpointer(hourglass!)
dw_print.setredraw(false)

ll_zoom = long(dw_print.describe("DataWindow.Zoom"))
ll_pagecnt = long(dw_print.describe("evaluate('PageCountAcross()', 0)"))

do until ll_pagecnt = 1 and ll_zoom > 10
	ll_zoom -= 1
	dw_print.modify("DataWindow.Zoom=" + string(ll_zoom))
	ll_pagecnt = long(dw_print.describe("evaluate('PageCountAcross()', 0)"))
loop

hsb_1.position = ll_zoom
st_size_rate.text = string(ll_zoom) + '%'
dw_print.setredraw(true)
return

// 미리보기창에 크기 맞추기
//boolean lb_shrink
//long ll_hscrollmax, ll_zoom
//
//setpointer(hourglass!)
//dw_print.setredraw(false)
//
//ll_hscrollmax = long(dw_print.describe("DataWindow.HorizontalScrollMaximum"))
//if ll_hscrollmax = 0 then return
//
////ll_zoom = long(dw_print.describe("DataWindow.Print.Preview.Zoom"))
//ll_zoom = long(dw_print.describe("DataWindow.Zoom"))
//do until ll_hscrollmax = 0
//	ll_zoom -= 1
//	//dw_print.modify("DataWindow.Print.Preview.Zoom=" + string(ll_zoom))
//	dw_print.modify("DataWindow.Zoom=" + string(ll_zoom))
//	ll_hscrollmax = long(dw_print.describe("DataWindow.HorizontalScrollMaximum"))
//loop
//
//hsb_1.position = ll_zoom
//dw_print.setredraw(true)
//return

//// A4 사이즈로 맞추기
//long ll_objcnt, i
//long ll_x, ll_width, ll_maxwidth
//string ls_objects[], ls_objtype
//
//ll_objcnt = pf_f_parsetoarray(dw_print.describe("Datawindow.Objects"), "~t", ls_objects[])
//for i = 1 to ll_objcnt
//	ls_objtype = dw_print.describe(ls_objects[i] + ".Type")
//	if ls_objtype = 'line' then
//		ll_x = long(dw_print.describe(ls_objects[i] + ".x1"))
//		ll_width = abs(long(dw_print.describe(ls_objects[i] + ".x2")) - long(dw_print.describe(ls_objects[i] + ".x1")))
//	else
//		ll_x = long(dw_print.describe(ls_objects[i] + ".x"))
//		ll_width = long(dw_print.describe(ls_objects[i] + ".width"))
//	end if
//	
//	if ll_x + ll_width > ll_maxwidth then
//		ll_maxwidth = ll_x + ll_width
//	end if
//next
//
//long ll_margins, ll_pagewidth
//long ll_zoom, ll_pbunitA4 = 3626
//
//ll_margins = long(dw_print.describe("Datawindow.Print.Margin.Left")) + long(dw_print.describe("Datawindow.Print.Margin.Right"))
//ll_pagewidth = ll_pbunitA4 - ll_margins
//
//if ll_maxwidth > 0 then
//	ll_zoom = ll_pagewidth / ll_maxwidth * 100
//	dw_print.modify("Datawindow.Zoom=" + string(ll_zoom))
//	hsb_2.position = ll_zoom
//	st_size_rate.text = string(ll_zoom) + '%'
//end if

end event

type cb_1 from pf_u_commandbutton within pf_w_printpreview
integer x = 1595
integer y = 16
integer width = 370
integer height = 100
integer taborder = 50
boolean bringtotop = true
string text = "컬럼삭제"
end type

event clicked;call super::clicked;dw_column.visible = not dw_column.visible

end event

type cb_printsize from pf_u_commandbutton within pf_w_printpreview
integer x = 1074
integer y = 392
integer width = 370
integer height = 88
integer taborder = 10
string text = "출력크기"
end type

event clicked;call super::clicked;dw_print.Modify("DataWindow.Zoom = "  + String(hsb_2.position) )
end event

type cb_preview from pf_u_commandbutton within pf_w_printpreview
integer x = 1074
integer y = 304
integer width = 370
integer height = 88
integer taborder = 20
string text = "미리보기"
end type

event clicked;call super::clicked;dw_print.Modify("DataWindow.Print.Preview.Zoom = "  + string(hsb_1.position))
end event

type print_setup from singlelineedit within pf_w_printpreview
integer x = 375
integer y = 132
integer width = 1056
integer height = 72
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long backcolor = 31439244
boolean border = false
end type

type cb_saveas from pf_u_commandbutton within pf_w_printpreview
integer x = 777
integer y = 212
integer width = 667
integer height = 92
integer taborder = 10
boolean enabled = false
string text = "         Save As         "
end type

event clicked;call super::clicked;pf_n_saveas lnv_save
lnv_save.of_saveas(dw_print, true)

end event

type cb_printersetup from pf_u_commandbutton within pf_w_printpreview
integer x = 87
integer y = 212
integer width = 667
integer height = 92
integer taborder = 10
string text = "    Printer Setup    "
end type

event clicked;call super::clicked;printsetup()
//print_setup.text = dw_print.Describe("DataWindow.Printer")

end event

type cb_print from pf_u_commandbutton within pf_w_printpreview
integer x = 3506
integer y = 16
integer width = 215
integer height = 100
boolean bringtotop = true
string text = "인쇄"
boolean fixedtoright = true
end type

event clicked;call super::clicked;String lsRange

Choose Case True
	Case cbx_tot.Checked = False
		lsRange = sle_rang.Text
		dw_print.modify("datawindow.print.page.range = '"+lsRange+"'")
	CASE ELSE
End Choose

il_return = Dw_Print.Print()

end event

type cb_close from pf_u_commandbutton within pf_w_printpreview
integer x = 3735
integer y = 16
integer width = 215
integer height = 100
boolean bringtotop = true
string text = "닫기"
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)

end event

type r_2 from pf_u_rectangle within pf_w_printpreview
long linecolor = 29595236
long fillcolor = 32896501
integer x = 1509
integer y = 204
integer width = 2441
integer height = 284
boolean scaletoright = true
end type

type st_title from statictext within pf_w_printpreview
integer x = 82
integer y = 144
integer width = 251
integer height = 48
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 31439244
string text = "인쇄준비"
boolean focusrectangle = false
end type

type st_10 from statictext within pf_w_printpreview
integer x = 1550
integer y = 324
integer width = 270
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
long backcolor = 33090525
boolean enabled = false
string text = "출력방향"
boolean focusrectangle = false
end type

type st_9 from statictext within pf_w_printpreview
integer x = 1550
integer y = 232
integer width = 270
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
long backcolor = 33090525
boolean enabled = false
string text = "출력용지"
boolean focusrectangle = false
end type

type cbx_tot from checkbox within pf_w_printpreview
integer x = 3191
integer y = 392
integer width = 247
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
long backcolor = 32896501
string text = "전체"
end type

event clicked;IF This.Checked THEN
	sle_rang.Enabled = False
	st_6.TextColor = RGB(150,150,150)
ELSE
	sle_rang.Enabled = True
	st_6.TextColor = RGB(0,0,0)
END IF
end event

type ddlb_way from dropdownlistbox within pf_w_printpreview
integer x = 1984
integer y = 304
integer width = 517
integer height = 284
integer taborder = 160
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
boolean vscrollbar = true
string item[] = {"Default","가로","세로"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE index
	CASE 1	// Default
		dw_print.Modify( "datawindow.print.Orientation = 0" )
	CASE 2	// Landscape
		dw_print.Modify( "datawindow.print.Orientation = 1" )
	CASE 3	// Portrait
		dw_print.Modify( "datawindow.print.Orientation = 2" )
END CHOOSE

end event

type ddlb_paper from dropdownlistbox within pf_w_printpreview
integer x = 1984
integer y = 212
integer width = 517
integer height = 380
integer taborder = 150
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Default","136 Col","80 Col","A4","A5","B4","B5"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE index
	CASE 1	// Default
		dw_print.Modify( "DataWindow.Print.Paper.Size = 0 " )
	CASE 2	// Ledger
		dw_print.Modify( "DataWindow.Print.Paper.Size = 04 " )
	CASE 3	// Letter
		dw_print.Modify( "DataWindow.Print.Paper.Size = 01 " )
	CASE 4	// A4
		dw_print.Modify( "DataWindow.Print.Paper.Size = 09 " )
	CASE 5	// A5
		dw_print.Modify( "DataWindow.Print.Paper.Size = 11 " )
	CASE 6	// B4
		dw_print.Modify( "DataWindow.Print.Paper.Size = 12 " )
	CASE 7	// B5
		dw_print.Modify( "DataWindow.Print.Paper.Size = 13 " )
END CHOOSE

end event

type st_6 from statictext within pf_w_printpreview
integer x = 3195
integer y = 232
integer width = 370
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
long backcolor = 32896501
string text = "Ex) 1, 2, 3-6"
boolean focusrectangle = false
end type

type sle_rang from singlelineedit within pf_w_printpreview
integer x = 3191
integer y = 304
integer width = 526
integer height = 76
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "궁서"
long textcolor = 20724796
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_print from pf_u_datawindow within pf_w_printpreview
integer x = 50
integer y = 512
integer width = 3895
integer height = 2156
integer taborder = 170
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean scaletoright = true
boolean scaletobottom = true
end type

type hsb_1 from hscrollbar within pf_w_printpreview
event lineleft pbm_sbnlineup
event lineright pbm_sbnlinedown
event moved pbm_sbnthumbtrack
integer x = 87
integer y = 312
integer width = 832
integer height = 68
boolean bringtotop = true
integer minposition = 10
integer maxposition = 200
integer position = 100
end type

event lineleft;this.position -= 1
st_pre_rate.text = string(this.position) + '%'
end event

event lineright;this.position += 1
st_pre_rate.text = string(this.position) + '%'
end event

event moved;st_pre_rate.text = string(this.position) + '%'
end event

type hsb_2 from hscrollbar within pf_w_printpreview
event lineleft pbm_sbnlineup
event lineright pbm_sbnlinedown
event moved pbm_sbnthumbtrack
integer x = 87
integer y = 404
integer width = 832
integer height = 68
boolean bringtotop = true
integer minposition = 1
integer maxposition = 300
integer position = 100
end type

event lineleft;this.position -= 1
st_size_rate.text = string(this.position) + '%'
end event

event lineright;this.position += 1
st_size_rate.text = string(this.position) + '%'
end event

event moved;st_size_rate.text = string(this.position) + '%'
end event

type st_size_rate from statictext within pf_w_printpreview
integer x = 933
integer y = 408
integer width = 142
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "궁서"
long textcolor = 20724796
long backcolor = 32896501
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_pre_rate from statictext within pf_w_printpreview
integer x = 933
integer y = 312
integer width = 142
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "궁서"
long textcolor = 20724796
long backcolor = 32896501
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_first from pf_u_commandbutton within pf_w_printpreview
integer x = 46
integer y = 16
integer width = 215
integer height = 100
integer taborder = 20
boolean bringtotop = true
string text = "처음"
end type

on cb_first.destroy
//call uo_imgbtn::destroy
end on

event clicked;call super::clicked;dw_print.ScrollToRow(1)
end event

type cb_last from pf_u_commandbutton within pf_w_printpreview
integer x = 274
integer y = 16
integer width = 215
integer height = 100
integer taborder = 30
boolean bringtotop = true
string text = "이전"
end type

on cb_last.destroy
//call uo_imgbtn::destroy
end on

event clicked;call super::clicked;IF dw_print.ScrollpriorPage() = -1 THEN
   BEEP(3)
END IF

end event

type cb_prior from pf_u_commandbutton within pf_w_printpreview
integer x = 503
integer y = 16
integer width = 215
integer height = 100
integer taborder = 40
boolean bringtotop = true
string text = "다음"
end type

on cb_prior.destroy
//call uo_imgbtn::destroy
end on

event clicked;call super::clicked;IF dw_print.ScrollNextPage()= -1 THEN
   BEEP(3)
END IF

end event

type cb_next from pf_u_commandbutton within pf_w_printpreview
integer x = 731
integer y = 16
integer width = 215
integer height = 100
integer taborder = 50
boolean bringtotop = true
string text = "끝"
end type

on cb_next.destroy
//call uo_imgbtn::destroy
end on

event clicked;call super::clicked;dw_print.ScrollToRow( dw_print.RowCount() )

end event

type st_2 from statictext within pf_w_printpreview
integer x = 1550
integer y = 144
integer width = 951
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 31439244
string text = "인쇄옵션 및 범위"
boolean focusrectangle = false
end type

type st_3 from statictext within pf_w_printpreview
integer x = 2789
integer y = 232
integer width = 270
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 20724796
long backcolor = 33090525
boolean enabled = false
string text = "인쇄범위"
boolean focusrectangle = false
end type

type r_5 from rectangle within pf_w_printpreview
long linecolor = 29595236
integer linethickness = 4
long fillcolor = 31439244
integer x = 46
integer y = 128
integer width = 1426
integer height = 80
end type

type r_6 from rectangle within pf_w_printpreview
long linecolor = 29595236
integer linethickness = 4
long fillcolor = 32896501
integer x = 46
integer y = 204
integer width = 1426
integer height = 284
end type

type r_1 from pf_u_rectangle within pf_w_printpreview
long linecolor = 29595236
long fillcolor = 31439244
integer x = 1509
integer y = 128
integer width = 2441
integer height = 80
boolean scaletoright = true
end type

type r_7 from rectangle within pf_w_printpreview
long linecolor = 33090525
integer linethickness = 4
long fillcolor = 33090525
integer x = 1513
integer y = 208
integer width = 425
integer height = 276
end type

type ln_6 from line within pf_w_printpreview
long linecolor = 29935816
integer linethickness = 4
integer beginx = 1513
integer beginy = 388
integer endx = 2715
integer endy = 388
end type

type r_3 from rectangle within pf_w_printpreview
long linecolor = 33090525
integer linethickness = 4
long fillcolor = 33090525
integer x = 2715
integer y = 208
integer width = 425
integer height = 276
end type

type ln_5 from line within pf_w_printpreview
long linecolor = 29935816
integer linethickness = 4
integer beginx = 1513
integer beginy = 296
integer endx = 2715
integer endy = 296
end type

type r_4 from pf_u_rectangle within pf_w_printpreview
long linecolor = 29595236
long fillcolor = 33554431
integer x = 46
integer y = 508
integer width = 3904
integer height = 2164
boolean scaletoright = true
boolean scaletobottom = true
end type

type dw_column from pf_u_datawindow within pf_w_printpreview
boolean visible = false
integer x = 1966
integer y = 12
integer width = 1541
integer height = 936
integer taborder = 180
boolean bringtotop = true
string dataobject = "pf_d_printpreview"
boolean vscrollbar = true
boolean singlerowselection = false
boolean multirowselection = true
end type

event buttonclicked;call super::buttonclicked;choose case dwo.name
	case 'b_delete'
		string ls_column_id, ls_column_nm
		long ll_selectedrow, ll_rows[], i
		
		ll_selectedrow = this.getselectedrow(0)
		do while ll_selectedrow > 0
			ll_rows[upperbound(ll_rows) + 1] = ll_selectedrow
			ll_selectedrow = this.getselectedrow(ll_selectedrow)
		loop
		
		if upperbound(ll_rows) = 0 then
			messagebox('알림', '선택된 행이 없습니다.~r~n먼저 출력 제외할 컬럼을 선택하세요(다중 선택 가능)')
			return
		end if
		
		dw_print.setredraw(false)
		
		for i = upperbound(ll_rows) to 1 step -1
			ls_column_id = this.getitemstring(ll_rows[i], 'column_id')
			ls_column_nm = this.getitemstring(ll_rows[i], 'column_nm')
			
			dw_print.modify("destroy " + ls_column_id + "_t")
			dw_print.modify("destroy column " + ls_column_id)
			
			this.deleterow(ll_rows[i])
		next
		
		dw_print.setredraw(true)
		
	case 'b_close'
		this.visible = false
end choose

end event

