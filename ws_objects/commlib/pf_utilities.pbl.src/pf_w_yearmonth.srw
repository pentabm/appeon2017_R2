$PBExportHeader$pf_w_yearmonth.srw
$PBExportComments$년월_선택용 윈도우 입니다
forward
global type pf_w_yearmonth from window
end type
type dw_cal from datawindow within pf_w_yearmonth
end type
end forward

global type pf_w_yearmonth from window
integer width = 960
integer height = 616
windowtype windowtype = child!
long backcolor = 16777215
string icon = "AppIcon!"
event pfe_postopen ( )
dw_cal dw_cal
end type
global pf_w_yearmonth pf_w_yearmonth

type prototypes
FUNCTION boolean AnimateWindow(long lhWnd, long lTm, long lFlags ) library 'user32.dll'
FUNCTION boolean GetCursorPos(REF pf_s_POINT ipPoint) LIBRARY "user32.dll"
FUNCTION boolean ScreenToClient(ulong hWnd, ref pf_s_POINT lpPoint) Library "USER32.DLL"

end prototypes

type variables
window iw_parent
windowobject iwo_parent
dwobject idwo_parent
long il_row
pf_n_animate inv_dropdown
string is_yearmonthselected

end variables

forward prototypes
public function string of_getpresentationstyle (datawindow ldw_target)
public subroutine of_highlightcolumn ()
public function integer of_drawyearmonth (integer ai_year, integer ai_month)
public function integer of_setparentyearmonth (integer li_year, integer li_month)
end prototypes

public function string of_getpresentationstyle (datawindow ldw_target);// 데이터윈도우 오브젝트의 Presentation Style을 리턴한다

string ls_processing, ls_style

ls_processing = ldw_target.describe("datawindow.processing")
choose case long(ls_processing)
	case 0
		//FreeForm인 경우 : detail band height가 dw control의 height의 2.5배 미만(만약 Header가 있는경우를 대비)
		long ll_detailheight, ll_dwcontrolheight, ll_headerheight
		
		ll_headerheight = long(ldw_target.describe("Datawindow.Header.Height"))
		ll_detailheight = long(ldw_target.describe("Datawindow.Detail.Height"))
		ll_dwcontrolheight = ldw_target.Height
		
		if ll_headerheight > pixelstounits(10, ypixelstounits!) then
			ls_style = "Tabular"
		elseif ll_detailheight * 2.2 < ll_dwcontrolheight then
			ls_style = "Tabular"
		else
			ls_style = "Freeform"
		end if
	case 1
		ls_style = 'Grid'
	case 2
		ls_style = 'Label'
	case 3
		ls_style = 'Graph'
	case 4
		ls_style = 'Crosstab'
	case 5
		ls_style = 'Composite'
	case 6
		ls_style = 'OLE'
	case 7
		ls_style = 'RichText'
	case 8
		ls_style = 'TreeView'
	case 9
		ls_style = 'TreeViewWithGrid'
	Case Else
		ls_style = 'Etc'
end choose

return ls_style

end function

public subroutine of_highlightcolumn ();
end subroutine

public function integer of_drawyearmonth (integer ai_year, integer ai_month);// 년월일 그리기

dw_cal.setredraw(false)
dw_cal.reset()
dw_cal.insertrow(0)

dw_cal.setitem(1, 'year', ai_year)
dw_cal.setitem(1, 'month', ai_month)
dw_cal.setredraw(true)

return 0

end function

public function integer of_setparentyearmonth (integer li_year, integer li_month);if isnull(iwo_parent) or not isvalid(iwo_parent) then return -1

date ld_selected
string ls_selected
ld_selected = date(li_year, li_month, 1)
ls_selected = string(li_year, '0000') + string(li_month, '00')
if isnull(ld_selected) or ld_selected = 1900-01-01 then return -1

choose case iwo_parent.typeof()
	case editmask!
		editmask lem_parent
		lem_parent = iwo_parent
		
		choose case lem_parent.maskdatatype
			case datemask!, datetimemask!
				lem_parent.text = string(ld_selected, lem_parent.mask)
			case stringmask!
				lem_parent.text = ls_selected
			case else
				return -1
		end choose
		
		lem_parent.post event modified()
		
	case datawindow!
		datawindow ldw_parent
		ldw_parent = iwo_parent
		
		choose case lower(left(ldw_parent.describe(string(idwo_parent.name) + ".ColType"), 5))
			case "char(", "char"
				ldw_parent.setrow(il_row)
				if ldw_parent.setcolumn(string(idwo_parent.name)) <> 1 then return -1
				ldw_parent.settext(ls_selected)
				ldw_parent.post accepttext()
				
				//ldw_parent.setitem(il_row, string(idwo_parent.name), ls_selected)
				//ldw_parent.post event itemchanged(il_row, idwo_parent, ls_selected)
			case "date", "datet"
				ldw_parent.setrow(il_row)
				if ldw_parent.setcolumn(string(idwo_parent.name)) <> 1 then return -1
				ldw_parent.settext(string(ls_selected, '@@@@/@@'))
				ldw_parent.post accepttext()
				
				//ldw_parent.setitem(il_row, string(idwo_parent.name), ld_selected)
				//ldw_parent.post event itemchanged(il_row, idwo_parent, string(ld_selected))
			case else
				return -1
		end choose
end choose

return 1

end function

on pf_w_yearmonth.create
this.dw_cal=create dw_cal
this.Control[]={this.dw_cal}
end on

on pf_w_yearmonth.destroy
destroy(this.dw_cal)
end on

event open;iwo_parent = gnv_session.of_get('pf_w_yearmonth.parent_object')
if not isvalid(iwo_parent) then
	messagebox('알림(pf_w_yearmonth)', '잘못된 달력 오브젝트 호출입니다')
	return
end if

powerobject lpo_parent
long ll_xpos, ll_ypos

if not isvalid(inv_dropdown) then
	inv_dropdown = create pf_n_animate
end if

// 부모 컨트롤의 X,Y 좌표를 구합니다.
lpo_parent = iwo_parent.getparent()
do while isvalid(lpo_parent)
	choose case lpo_parent.typeof()
		case tab!
			tab ltab
			ltab = lpo_parent
			ll_xpos += ltab.x
			ll_ypos += ltab.y
		case userobject!
			userobject luo
			luo = lpo_parent
			ll_xpos += luo.x
			ll_ypos += luo.y
		case window!
			iw_parent = lpo_parent
			exit
	end choose
	lpo_parent = lpo_parent.getparent()
loop

if not isvalid(iw_parent) then
	messagebox('알림(pf_w_yearmonth)', '부모 윈도우를 찾을 수 없습니다.')
	return
end if

// 오브젝트의 타입에 따라 달력 위치를 조절합니다.
string ls_yearmonth
date ldt_yearmonth

choose case iwo_parent.typeof()
	case editmask!
		editmask lem

		lem = iwo_parent
		ll_xpos += lem.x
		ll_ypos += lem.y + lem.height
		
		ls_yearmonth = left(lem.text, 4) + mid(lem.text, 6, 2)
		if isdate(string(ls_yearmonth + '01', '@@@@/@@/@@')) then
			is_yearmonthselected = ls_yearmonth
		end if
		
	case datawindow!
		datawindow ldw_parent
		
		ldw_parent = iwo_parent
		idwo_parent = gnv_session.of_get('pf_w_yearmonth.dwobject')
		il_row = gnv_session.of_getint('pf_w_yearmonth.row')
		
		if this.of_getpresentationstyle(ldw_parent)  = 'Freeform' then
			ll_xpos += ldw_parent.x + long(idwo_parent.x)
			ll_ypos += ldw_parent.y + long(idwo_parent.y) + long(idwo_parent.height) + pixelstounits(2, ypixelstounits!)
		else
			ll_xpos += ldw_parent.x + ldw_parent.pointerx()
			ll_ypos += ldw_parent.y + ldw_parent.pointery() + pixelstounits(2, ypixelstounits!)
		end if
		
		choose case lower(left(ldw_parent.describe(string(idwo_parent.name) + ".ColType"), 5))
			case "char(", "char"
				ls_yearmonth = ldw_parent.getitemstring(il_row, string(idwo_parent.name))
				if isdate(string(ls_yearmonth + '01', '@@@@/@@/@@')) then
					is_yearmonthselected = ls_yearmonth
				end if
			case "date", "datet"
				ldt_yearmonth = ldw_parent.getitemdate(il_row, string(idwo_parent.name))
				is_yearmonthselected = string(year(ldt_yearmonth), '0000') + string(month(ldt_yearmonth), '00')
			case else
				messagebox('알림', '문자 타입 컬럼에만 년월 오브젝트를 사용가능 합니다')
				return
		end choose
end choose

// 부모 윈도우 크기에 맞게 달력 위치 조정합니다.
integer li_direction

// 애니메이션 방향 설정
if ll_ypos + this.height > iw_parent.workspaceheight() then
	ll_ypos -= this.height
	li_direction = inv_dropdown.BottomUp
else
	li_direction = inv_dropdown.TopDown
end if

this.x = ll_xpos
this.y = ll_ypos

// 년월 설정
if pf_f_isemptystring(ls_yearmonth) then
	is_yearmonthselected = string(today(), 'yyyymm')
end if

// 달력 DRAW
this.of_drawyearmonth(integer(left(is_yearmonthselected, 4)), integer(mid(is_yearmonthselected, 5, 2)))

// 풀다운 형태로 윈도우가 오픈됩니다.
if appeongetclienttype() = 'PB' then
	this.width = dw_cal.width
	this.height = dw_cal.height

	inv_dropdown.of_initialize(this, li_direction)
	inv_dropdown.of_show()
else
	// Child 윈도우 사이즈가 파워빌더와 달라 사이즈 저장함(2013R2 기준)
	this.width = dw_cal.width - pixelstounits(10, xpixelstounits!)
	this.height = dw_cal.height - pixelstounits(11, ypixelstounits!)
end if

dw_cal.setredraw(true)
dw_cal.setfocus()

this.post event pfe_postopen()

end event

event close;gnv_session.of_remove('pf_w_yearmonth.parent_object')

if appeongetclienttype() = 'PB' then
	if isvalid(inv_dropdown) then
		inv_dropdown.of_hide()
	end if
end if

destroy inv_dropdown

// 달력 컨트롤 종료 후 호출한 오브젝트로 포커스 변경
iwo_parent.post dynamic setfocus()

end event

type dw_cal from datawindow within pf_w_yearmonth
event ue_dwnkey pbm_dwnkey
integer width = 951
integer height = 600
integer taborder = 10
string dataobject = "pf_d_yearmonth"
boolean border = false
end type

event ue_dwnkey;CHOOSE CASE key
	CASE KeyHome!
		this.event clicked(0, 0, this.getrow(), this.object.p_nextyear)
	CASE KeyEnd!
		this.event clicked(0, 0, this.getrow(), this.object.p_preyear)
	CASE KeyPageUp!
		this.event clicked(0, 0, this.getrow(), this.object.p_premonth)
	CASE KeyPageDown!
		this.event clicked(0, 0, this.getrow(), this.object.p_nextmonth)
//	CASE KeyRightArrow!
//		of_movefocusedcolumn('right')
//	CASE KeyLeftArrow!
//		of_movefocusedcolumn('left')
//	CASE KeyUpArrow!
//		of_movefocusedcolumn('up')
//	CASE KeyDownArrow!
//		of_movefocusedcolumn('down')
	CASE KeyEscape!
		post close(parent)
	CASE KeyEnter!
		integer li_year, li_month
		
		li_year = this.getitemnumber(this.getrow(), 'year')
		li_month = this.getitemnumber(this.getrow(), 'month')
		of_setparentyearmonth(li_year, li_month)
		post close(parent)
END CHOOSE

end event

event clicked;if row = 0 then return
if isnull(dwo) then return

// 개별 월 버튼
integer li_month

if left(dwo.name, 7) = 't_month' then
	li_month = long(mid(dwo.name, 8))
	this.setitem(row, 'month', li_month)
	this.setredraw(true)
	return
end if

// 이전월, 다음월
integer li_year
long ll_monthcnt

if left(dwo.name, 5) = 'p_pre' or left(dwo.name, 6) = 'p_next' then
	li_year = this.getitemnumber(row, 'year')
	li_month = this.getitemnumber(row, 'month')
	ll_monthcnt = li_year * 12 + li_month

	choose case dwo.name
		case 'p_preyear'
			ll_monthcnt -= 12
		case 'p_premonth'
			ll_monthcnt -= 1
		case 'p_nextyear'
			ll_monthcnt += 12
		case 'p_nextmonth'
			ll_monthcnt += 1
	end choose
	
	ll_monthcnt --
	li_year = truncate(ll_monthcnt / 12, 0)
	li_month = mod(ll_monthcnt, 12) + 1
	parent.of_drawyearmonth(li_year, li_month)
end if

end event

event doubleclicked;if row = 0 then return
if left(dwo.name, 7) <> 't_month' then return

integer li_year, li_month

li_year = this.getitemnumber(row, 'year')
li_month = this.getitemnumber(row, 'month')

of_setparentyearmonth(li_year, li_month)
post close(parent)

end event

event losefocus;// 포커스 잃는 경우 종료
post close(parent)

end event

