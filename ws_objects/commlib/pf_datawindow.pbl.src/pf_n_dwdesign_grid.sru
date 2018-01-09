$PBExportHeader$pf_n_dwdesign_grid.sru
$PBExportComments$Grid 스타일 데이터윈도우 디자인 처리용 NVO 입니다.
forward
global type pf_n_dwdesign_grid from pf_n_dwdesign
end type
end forward

global type pf_n_dwdesign_grid from pf_n_dwdesign
end type
global pf_n_dwdesign_grid pf_n_dwdesign_grid

type variables
protected:
	// instance for border
	pf_u_statictext iln_top
	pf_u_statictext iln_bottom
	pf_u_statictext iln_left
	pf_u_statictext iln_right
	long il_borderhndl[4]
	
public:
	long HeaderBandColor = RGB(230,226,219)
	long TrailerBandColor = RGB(236,233,224)
	long SummaryBandColor = RGB(241,255,246)
	long FooterBandColor = RGB(239,241,255)
	long DatawindowBackgroundColor = RGB(255,255,255)
	string HeaderBandBackgroundImage = ''
	
	long BorderTopColor = 	RGB(193,180,158)
	long BorderBottomColor = RGB(243,243,243)
	long BorderLeftColor = RGB(243,243,243)
	long BorderRightColor = RGB(243,243,243)
	
	long MouseOverRowColor = RGB(230,226,220)
	long AlternateFirstRowColor = RGB(255,255,255) 
	long AlternateSecondRowcolor = RGB(249,248,244)
	long ColumnBorderColor = RGB(230,230,230)
	long EditableColumnBorderColor = RGB(255,166,166)
	
	// 입력 가능한 컬럼 테두리 표시 여부
	boolean EditableColumnBorder = true
	
	// 입력가능한 컬럼 마커 표시 여부
	boolean EditableColumnMarker = false
	
	// MouseOver 백그라운드 컬러 표시 여부
	boolean ib_mouseoverbackgroundcolor = true

end variables

forward prototypes
public function integer of_applydesign ()
public function string of_getclassname ()
public function integer of_drawcustomborder ()
public function long of_resetwidtheditableicon ()
end prototypes

public function integer of_applydesign ();if not isvalid(idw_target) then return -1

string ls_newsyntax, ls_modsyntax, ls_error, ls_setdisplayorder[]
long ll_maxwidth, ll_headerheight, ll_detailheight, i, ll_pos

// Header Row 디자인
ll_maxwidth = this.of_getdwomaxwidth()
ll_headerheight = long(idw_target.describe("Datawindow.Header.Height"))
ll_detailheight = long(idw_target.describe("Datawindow.Detail.Height"))

// Header Band Color
if HeaderBandColor > 0 then
	ls_modsyntax += 'Datawindow.Header.Color="' + string(HeaderBandColor) + '"~r~n'
end if

// Header Band Background Image
if HeaderBandBackgroundImage <> '' then
	if appeongetclienttype() = 'PB' then
		ls_setdisplayorder[ upperbound(ls_setdisplayorder) + 1 ] = 'p_header_bg'
		ls_newsyntax += 'bitmap(band=background filename="' + HeaderBandBackgroundImage + '" x="0" y="0" height="' + string(ll_headerheight) + '" width="' + string(ll_maxwidth) + '" border="0"  name=p_header_bg visible="1" )~r~n'
	else
		ls_newsyntax += 'bitmap(band=header filename="' + HeaderBandBackgroundImage + '" x="0" y="-4" height="' + string(ll_headerheight) + '" width="' + string(ll_maxwidth) + '" border="0"  name=p_header_bg visible="1" )~r~n'
	end if
end if

// Detail Band 디자인
ls_modsyntax += 'create text(band=header alignment="2" text="" border="0" color="33554432" x="841" y="8" height="76" width="2633" html.valueishtml="0" name=pf_mousepointerrow_t visible="0" font.face="Tahoma" font.height="-9" font.weight="400" font.family="2" font.pitch="1" font.charset="129" background.mode="1" background.color="536870912" )~r~n'

// AlternativeRowColor 처리
pf_u_datawindow ldw_ref
ldw_ref = idw_target

if ldw_ref.alternativerowcolor = true then
	if ib_mouseoverbackgroundcolor = true then
		ls_modsyntax += 'Datawindow.Detail.Color="536870912~tif(long(describe(~~~"pf_mousepointerrow_t.text~~~")) = getrow(), ' + string(MouseOverRowColor) + ', if(mod(getrow(), 2) = 0, ' + string(AlternateSecondRowcolor) + ', ' + string(AlternateFirstRowColor) + '))"~r~n'
	else
		ls_modsyntax += 'Datawindow.Detail.Color="536870912~tif(mod(getrow(), 2) = 0, ' + string(AlternateSecondRowcolor) + ', ' + string(AlternateFirstRowColor) + ')"~r~n'
	end if
else
	if ib_mouseoverbackgroundcolor = true then
		ls_modsyntax += 'Datawindow.Detail.Color="536870912~tif(long(describe(~~~"pf_mousepointerrow_t.text~~~")) = getrow(), ' + string(MouseOverRowColor) + ', ' + string(AlternateFirstRowcolor) + ')"~r~n'
	end if
end if

// Column Border 디자인
long ll_objcnt, ll_tabseq
long ll_xpos, ll_ypos
long ll_width, ll_height
string ls_objname
string ls_band
string ls_bgcolor
string ls_visible
boolean lb_editable

if EditableColumnMarker or EditableColumnBorder then
	// Editable 컬럼이 있는지 확인
	ll_objcnt = long(idw_target.describe("Datawindow.Column.Count"))
	
	for i = 1 to ll_objcnt
		ls_objname = idw_target.describe("#" + string(i) + ".Name")
		
		// 화면에 위치 하지 않는 컨트롤 제외
		ls_band = idw_target.describe(ls_objname + ".Band")
		if ls_band = "?" or ls_band = "!" then continue
		
		// TabOrder 가 0 이상인 경우만 Border 생성
		ll_tabseq = long(idw_target.describe(ls_objname + ".TabSequence"))
		if ll_tabseq > 0 then
			
			ls_bgcolor = idw_target.describe(ls_objname + ".Background.Color")
			if ls_bgcolor = '!' or ls_bgcolor = '?' then
				ls_bgcolor=string(553648127)
			end if
			
			if left(ls_bgcolor, 1) = '"' and right(ls_bgcolor, 1) = '"' then
				ls_bgcolor = of_fixescapechar(mid(ls_bgcolor, 2, len(ls_bgcolor) - 2))
			end if
			
			ls_visible = idw_target.describe(ls_objname + ".visible")
			if left(ls_visible, 1) = '"' and right(ls_visible, 1) = '"' then
				ls_visible = mid(ls_visible, 2, len(ls_visible) - 2)
			end if
			
			ls_setdisplayorder[ upperbound(ls_setdisplayorder) + 1 ] = ls_objname + '_editableicon'
			ls_visible = "0~tif(long(describe('pf_mousepointerrow_t.text')) = getrow() and describe('" + ls_objname + ".Protected') <> '1' and describe('" + ls_objname + ".Edit.DisplayOnly') <> 'yes', 1, 0)"
			
			// Editable Column Icon 표시
			if EditableColumnMarker = true then
				ll_xpos = long(idw_target.describe(ls_objname + ".x")) + long(idw_target.describe(ls_objname + ".width")) - 23
				ll_ypos = 0
				ll_width = 23
				ll_height = 20
				ls_newsyntax += 'bitmap(band=' + ls_band + ' filename="..\img\datawindow\u_datawindow\EditableColumn.jpg" x="' + string(ll_xpos) + '~tlong(describe(~~~"' + ls_objname + '.x~~~")) + long(describe(~~~"' + ls_objname + '.width~~~")) - 23" y="' + string(ll_ypos) + '~tlong(describe(~~~"' + ls_objname + &
										'.y~~~"))" height="20" width="0~t23" border="0" name=' + ls_objname + '_editableicon visible="' + ls_visible + '" )~r~n'
			end if
			
			// Column border 표시
			if EditableColumnBorder = true then
				ll_xpos = long(idw_target.describe(ls_objname + ".x"))
				ll_ypos = long(idw_target.describe(ls_objname + ".y"))
				ll_width = long(idw_target.describe(ls_objname + ".width"))
				ll_height = long(idw_target.describe(ls_objname + ".height"))
				
				ls_newsyntax += 'roundrectangle(band=' + ls_band + ' ellipseheight="12" ellipsewidth="15" x="' + string(ll_xpos) + '" y="' + string(ll_ypos) + '" height="' + string(ll_height) + '"' + &
									  ' width="' + string(ll_width) + '" name='  + ls_objname + '_rrct visible="' + ls_visible + '" brush.hatch="7" brush.color="' + ls_bgcolor + '"' +  &
									  ' pen.style="0" pen.width="1" pen.color="1073741824~t' +  string(ColumnBorderColor) + '"' + &
									  ' background.mode="1" background.color="553648127" )~r~n'
			end if
		end if
	next
end if

// ColumnPadding 설정
string ls_objtype, ls_objects[]
string ls_format, ls_editstyle, ls_expression

if idw_target.dynamic of_getservicepropertyvalue('AddColumnPadding') = true then
	ll_objcnt = pf_f_parsetoarray(idw_target.describe("Datawindow.Objects"), "~t", ls_objects[])
	for i = 1 to ll_objcnt
		// 컬럼 타입이 Column, Text, Compute 인 경우만 디자인 적용
		ls_objtype = idw_target.describe(ls_objects[i] + ".Type")
		if not (ls_objtype = "column" or ls_objtype = "compute") then continue
		
		// 화면에 위치 하지 않는 컨트롤 제외
		ls_band = idw_target.describe(ls_objects[i] + ".Band")
		if ls_band = "?" or ls_band = "!" then continue

		// Computed 컬럼 중 Bitmap() 함수를 사용하는 경우 제외
		if ls_objtype = "compute" then
			ls_expression = idw_target.describe(ls_objects[i] + ".Expression")
			if match(ls_expression, 'bitmap *(') = true then
				continue
			end if
		end if
		
		// 컬럼 좌우 여백 추가(ddlb는 적용 안 됨)
		ls_editstyle = idw_target.describe(ls_objects[i] + ".Edit.Style")
		choose case ls_editstyle
			case 'ddlb'
			case else
				ls_format = idw_target.describe(ls_objects[i] + ".Format")
				if ls_format = "?" or ls_format = "!" then continue

				if pos(ls_format, '~t') = 0 then
					ls_modsyntax += ls_objects[i] + '.Format=" ' + trim(ls_format) + ' "~r~n'
				end if
		end choose
	next
end if

// Highlight get focused column
ls_newsyntax += 'rectangle(band=detail x="0" y="0" height="0" width="0"  name=r_getfocused visible="0" brush.hatch="7" brush.color="570425344" pen.style="0" pen.width="8" pen.color="6731519"  background.mode="1" background.color="553648127" )~r~n'

// Trailer, Summary, Footer Band backgroundcolor 설정
if isnumber(idw_target.describe("Datawindow.Header.1.Height")) then
	ls_modsyntax += 'DataWindow.Trailer.1.Color="' + string(TrailerBandColor) + '"~r~n'
end if

ls_modsyntax += 'DataWindow.Summary.Color="' + string(SummaryBandColor) + '"~r~n'
ls_modsyntax += 'DataWindow.Footer.Color="' + string(FooterBandColor) + '"~r~n'
ls_modsyntax += 'DataWindow.Selected.Mouse = No'

// Modify datawindow syntax 
ls_error = idw_target.Modify(ls_modsyntax)
if len(ls_error) > 0 then
	::clipboard(ls_modsyntax)
	messagebox("pf_n_dwdesign_grid.of_applydesign() Error", idw_target.classname() + " Syntax Modification Failure!! :~r~n" + ls_error)
	return -1
end if

string ls_dwsyntax
string ls_findstr[] = { "column(name", "compute(name", "text(name" }
long ll_minpos = 2147483647

if ls_newsyntax <> '' then
	ls_dwsyntax = idw_target.describe("datawindow.syntax")
	for i = 1 to upperbound(ls_findstr)
		ll_pos = pos(ls_dwsyntax, ls_findstr[i])
		if ll_pos > 0 then
			if ll_pos < ll_minpos then ll_minpos = ll_pos
		end if
	next
	
	if ll_minpos > 0 then
		ls_dwsyntax = replace(ls_dwsyntax, ll_minpos, 0, ls_newsyntax)
		if idw_target.Create(ls_dwsyntax, ls_error) = -1 then
			::clipboard(idw_target.classname() + "~r~n" + ls_dwsyntax)
			messagebox("pf_n_dwdesign_grid.of_applydesign() Error", idw_target.classname() + " Syntax Modification(Create) Failure!! :~r~n" + ls_error)
			return -1
		end if
		this.of_resetdwdisplayorder(idw_target.classname())
	end if
end if

return 1

end function

public function string of_getclassname ();return 'pf_n_dwdesign_grid'

end function

public function integer of_drawcustomborder ();// backup message object before OpenUserObject()
message lm_backup
lm_backup = create message
lm_backup.Handle = message.Handle
lm_backup.Number = message.Number
lm_backup.WordParm = message.WordParm
lm_backup.LongParm = message.LongParm
lm_backup.DoubleParm = message.DoubleParm
lm_backup.StringParm = message.StringParm
lm_backup.PowerObjectParm = message.PowerObjectParm
lm_backup.Processed = message.Processed
lm_backup.ReturnValue = message.ReturnValue

long ll_x, ll_y
long ll_width, ll_height

// top line
if not isvalid(iln_top) then
	if idw_target.border = true then
		ll_x = idw_target.x
		ll_y = idw_target.y
		ll_width = idw_target.width
		ll_height = pixelstounits(1, ypixelstounits!)
	else
		ll_x = idw_target.x - pixelstounits(1, xpixelstounits!)
		ll_y = idw_target.y - pixelstounits(1, ypixelstounits!)
		ll_width = idw_target.width + pixelstounits(2, xpixelstounits!)
		ll_height = pixelstounits(1, ypixelstounits!)
	end if
	
	if iw_parent.openuserobject(iln_top, ll_x, ll_y) = 1 then
		iln_top.width = ll_width
		iln_top.height = ll_height
		iln_top.backcolor = BorderTopColor
	end if
end if

if igo_parent.typeof() = userobject! then
	il_borderhndl[1] = gnv_extfunc.getparent(handle(iln_top))
	gnv_extfunc.setparent(handle(iln_top), handle(igo_parent))
end if

// bottom line
if not isvalid(iln_bottom) then
	if idw_target.border = true then
		ll_x = idw_target.x
		ll_y = idw_target.y + idw_target.height - pixelstounits(1, ypixelstounits!)
		ll_width = idw_target.width
		ll_height = pixelstounits(1, ypixelstounits!)
	else
		ll_x = idw_target.x - pixelstounits(1, xpixelstounits!)
		ll_y = idw_target.y + idw_target.height
		ll_width = idw_target.width + pixelstounits(2, xpixelstounits!)
		ll_height = pixelstounits(1, ypixelstounits!)
	end if
	
	if iw_parent.openuserobject(iln_bottom, ll_x, ll_y) = 1 then
		iln_bottom.width = ll_width
		iln_bottom.height = ll_height
		iln_bottom.backcolor = BorderBottomColor
	end if
end if

if igo_parent.typeof() = userobject! then
	il_borderhndl[2] = gnv_extfunc.getparent(handle(iln_bottom))
	gnv_extfunc.setparent(handle(iln_bottom), handle(igo_parent))
end if

// left line
if not isvalid(iln_left) then
	iln_left = create pf_u_statictext
	
	if idw_target.border = true then
		iln_left.x = idw_target.x
		iln_left.y = idw_target.y
		iln_left.width = pixelstounits(1, xpixelstounits!)
		iln_left.height = idw_target.height
	else
		iln_left.x = idw_target.x - pixelstounits(1, xpixelstounits!)
		iln_left.y = idw_target.y - pixelstounits(1, ypixelstounits!)
		iln_left.width = pixelstounits(1, xpixelstounits!)
		iln_left.height = idw_target.height + pixelstounits(2, ypixelstounits!)
	end if
	
	iln_left.backcolor = BorderLeftColor
	iw_parent.openuserobject(iln_left, iln_left.x, iln_left.y)
end if

if igo_parent.typeof() = userobject! then
	il_borderhndl[3] = gnv_extfunc.getparent(handle(iln_left))
	gnv_extfunc.setparent(handle(iln_left), handle(igo_parent))
end if

// right line
if not isvalid(iln_right) then
	iln_right = create pf_u_statictext
	
	if idw_target.border = true then
		iln_right.x = idw_target.x + idw_target.width - pixelstounits(1, xpixelstounits!)
		iln_right.y = idw_target.y
		iln_right.width = pixelstounits(1, xpixelstounits!)
		iln_right.height = idw_target.height
	else
		iln_right.x = idw_target.x + idw_target.width
		iln_right.y = idw_target.y - pixelstounits(1, ypixelstounits!)
		iln_right.width = pixelstounits(1, xpixelstounits!)
		iln_right.height = idw_target.height + pixelstounits(2, ypixelstounits!)
	end if
	
	iln_right.backcolor = BorderRightColor
	iw_parent.openuserobject(iln_right, iln_right.x, iln_right.y)
end if

if igo_parent.typeof() = userobject! then
	il_borderhndl[4] = gnv_extfunc.getparent(handle(iln_right))
	gnv_extfunc.setparent(handle(iln_right), handle(igo_parent))
end if

// restore message object
message.Handle = lm_backup.Handle
message.Number = lm_backup.Number
message.WordParm = lm_backup.WordParm
message.LongParm = lm_backup.LongParm
message.DoubleParm = lm_backup.DoubleParm
message.StringParm = lm_backup.StringParm
message.PowerObjectParm = lm_backup.PowerObjectParm
message.Processed = lm_backup.Processed
message.ReturnValue = lm_backup.ReturnValue

iln_top.visible = idw_target.visible
iln_bottom.visible = idw_target.visible
iln_left.visible = idw_target.visible
iln_right.visible = idw_target.visible

if idw_target.border = true then
	idw_target.border = false
	idw_target.x += pixelstounits(1, xpixelstounits!)
	idw_target.y += pixelstounits(1, ypixelstounits!)
	idw_target.width -= pixelstounits(2, xpixelstounits!)
	idw_target.height -= pixelstounits(2, ypixelstounits!)
end if

return 1

end function

public function long of_resetwidtheditableicon ();string ls_object, ls_objarr[]
string ls_syntax
long i, ll_objcnt

ls_object = idw_target.describe("Datawindow.Objects")
ll_objcnt = pf_f_parsetoarray(ls_object, '~t', ls_objarr[])
for i = 1 to ll_objcnt
	if right(ls_objarr[i], 13) = '_editableicon' then
		ls_syntax += ls_objarr[i] + '.width="23"~r~n'
	end if
next

if ls_syntax <> '' then
	idw_target.modify(ls_syntax)
end if

return 0

end function

on pf_n_dwdesign_grid.create
call super::create
end on

on pf_n_dwdesign_grid.destroy
call super::destroy
end on

event move;call super::move;if isvalid(iln_top) then
	iln_top.x = xpos - pixelstounits(1, xpixelstounits!)
	iln_top.y = ypos - pixelstounits(1, ypixelstounits!)
end if

if isvalid(iln_bottom) then
	iln_bottom.x = xpos - pixelstounits(1, xpixelstounits!)
	iln_bottom.y = ypos + idw_target.height + pixelstounits(1, ypixelstounits!)
end if

if isvalid(iln_left) then
	iln_left.x = xpos - pixelstounits(1, xpixelstounits!)
	iln_left.y = ypos - pixelstounits(1, ypixelstounits!)
end if

if isvalid(iln_right) then
	iln_right.x = xpos + idw_target.width + pixelstounits(1, xpixelstounits!)
	iln_right.y = ypos - pixelstounits(1, ypixelstounits!)
end if

end event

event resize;call super::resize;// 상단 Border 사이즈
if isvalid(iln_top) then
	iln_top.width = idw_target.width + pixelstounits(2, xpixelstounits!)
end if

// 하단 Border 사이즈
if isvalid(iln_bottom) then
	iln_bottom.y = idw_target.y + idw_target.height
	iln_bottom.width = idw_target.width + pixelstounits(2, xpixelstounits!)
end if

// 좌측 Border 사이즈
if isvalid(iln_left) then
	iln_left.height = idw_target.height + pixelstounits(2, ypixelstounits!)
end if

// 우측 Border 사이즈
if isvalid(iln_right) then
	iln_right.x = idw_target.x + idw_target.width
	iln_right.height = idw_target.height + pixelstounits(2, ypixelstounits!)
end if

end event

event clicked;call super::clicked;//if row > 0 and row <> idw_target.getrow() then
//	idw_target.setrow(row)
//end if

end event

event destructor;call super::destructor;// Appeon 에서 Popup 윈도우는 CloseUserObject 를 수행하면 클라이언트가 멈추는 현상 있음
// (Appeon2016Build1119 버전은 CloseUserObject 호출 안하면 오류발생됨)
//if appeongetclienttype() <> 'PB' then return

if isvalid(iln_top) then
	if igo_parent.typeof() = userobject! then gnv_extfunc.setparent(handle(iln_top), il_borderhndl[1])
	iw_parent.CloseUserObject(iln_top)
	destroy iln_top
end if

if isvalid(iln_bottom) then
	if igo_parent.typeof() = userobject! then gnv_extfunc.setparent(handle(iln_bottom), il_borderhndl[2])
	iw_parent.CloseUserObject(iln_bottom)
	destroy iln_bottom
end if

if isvalid(iln_left) then
	if igo_parent.typeof() = userobject! then gnv_extfunc.setparent(handle(iln_left), il_borderhndl[3])
	iw_parent.CloseUserObject(iln_left)
	destroy iln_left
end if

if isvalid(iln_right) then
	if igo_parent.typeof() = userobject! then gnv_extfunc.setparent(handle(iln_right), il_borderhndl[4])
	iw_parent.CloseUserObject(iln_right)
	destroy iln_right
end if

end event

event pfe_visiblechanged;call super::pfe_visiblechanged;if isvalid(iln_top) then
	iln_top.visible = idw_target.visible
end if

if isvalid(iln_bottom) then
	iln_bottom.visible = idw_target.visible
end if

if isvalid(iln_left) then
	iln_left.visible = idw_target.visible
end if

if isvalid(iln_right) then
	iln_right.visible = idw_target.visible
end if

end event

event pfe_dwowidthchanged;call super::pfe_dwowidthchanged;string ls_syntax
long ll_maxwidth

ll_maxwidth = this.of_getdwomaxwidth()
ls_syntax = "p_header_bg.x=0~r~np_header_bg.width=" + string(ll_maxwidth)
idw_target.modify(ls_syntax)

//of_resetwidtheditableicon()

//idw_target.modify("DataWindow.Syntax.Modified=No")
//idw_target.post setredraw(true)
//return

//string ls_syntax
//string ls_lastobj
//long ll_maxwidth
//
//ls_lastobj = this.of_getlastobject('header')
//if ls_lastobj = '' then return
//ll_maxwidth = long(idw_target.describe(ls_lastobj + ".X")) + long(idw_target.describe(ls_lastobj + ".Width"))
//
//ls_syntax = "p_header_bg.x=0~t0"
//ls_syntax += '~r~np_header_bg.width=' + string(ll_maxwidth) + '~tlong(describe(~~~"' + ls_lastobj + '.x~~~"))+long(describe(~~~"' + ls_lastobj + '.width~~~"))'
//
//idw_target.modify(ls_syntax)
//return

end event

event pfe_mouseleave;call super::pfe_mouseleave;idw_target.modify('pf_mousepointerrow_t.text=""')
idw_target.setredraw(true)

end event

event pfe_mouseover;call super::pfe_mouseover;idw_target.modify('pf_mousepointerrow_t.text="' + string(al_row) + '"')
idw_target.setredraw(true)

end event

event itemfocuschanged;call super::itemfocuschanged;if not isvalid(idw_target) then return
if row = 0 then return

long ll_xpos, ll_ypos, ll_width, ll_height
string ls_syntax, ls_error

if string(dwo.type) = 'column' then
	if EditableColumnBorder = true then
		ll_xpos = long(idw_target.describe(dwo.name + ".x"))
		if ll_xpos > 0 then
			ll_ypos = long(idw_target.describe(dwo.name + ".y"))
			ll_width = long(idw_target.describe(dwo.name + ".width"))
			ll_height = long(idw_target.describe(dwo.name + ".height"))
			
			ll_xpos -= pixelstounits(1, xpixelstounits!)
			ll_ypos -= pixelstounits(1, ypixelstounits!)
			ll_width += pixelstounits(3, xpixelstounits!)
			ll_height += pixelstounits(3, ypixelstounits!)
			
			ls_syntax += "r_getfocused.x='" + string(ll_xpos) + "'~r~n"
			ls_syntax += "r_getfocused.y='" + string(ll_ypos) + "'~r~n"
			ls_syntax += "r_getfocused.width='" + string(ll_width) + "'~r~n"
			ls_syntax += "r_getfocused.height='" + string(ll_height) + "'"
		end if
		
		ls_error = idw_target.modify(ls_syntax)
		//if len(ls_error) > 0 then
		//	::clipboard(ls_syntax)
		//	messagebox('itemfocuschanged', ls_error)
		//end if
	end if
end if

end event

event getfocus;call super::getfocus;if isvalid(idw_target) then
	idw_target.modify("r_getfocused.visible='0~tif(getrow() = currentrow(), 1, 0)'")
end if

end event

event losefocus;call super::losefocus;if isvalid(idw_target) then
	idw_target.modify("r_getfocused.visible='0'")
	idw_target.setredraw(true)
end if

end event

