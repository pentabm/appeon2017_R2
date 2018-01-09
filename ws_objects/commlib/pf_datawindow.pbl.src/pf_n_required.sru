$PBExportHeader$pf_n_required.sru
$PBExportComments$데이터윈도우 액션 서비스와 관계되어 필수 입력 항목 체크 를 담당하는 오브젝트 입니다.
forward
global type pf_n_required from pf_n_nonvisualobject
end type
end forward

global type pf_n_required from pf_n_nonvisualobject
end type
global pf_n_required pf_n_required

type variables
// 필수입력항목 체크 스타일
constant integer AsteriskOnTheTitle = 1
//constant integer ColumnTag = 2
//constant integer RequiredProperty = 3

protected:
	datawindow idw_target
	window iw_parent
	
	integer ii_requiredcount
	string is_requiredcolumn[]
	string is_requiredtext[]
	
	integer ii_popupcount
	string is_popupcolumn[]
	string is_popuptext[]

public:
	integer RequiredServiceType = AsteriskOnTheTitle
	boolean RequiredColumnMarker = true
	string RequiredColumnMarkerImageFile = "..\img\datawindow\u_datawindow\red_asterisk.gif"
	string PopupColumnMarkerImageFile = "..\img\commonuse\ib_search.gif"

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_setrequiredcolumnmarker ()
public function integer of_setrequiredcolumn ()
public function integer of_checkrequiredcolumn ()
public function integer of_setpopupcolumn ()
public function integer of_setpopupcolumnmarker ()
public subroutine of_initialize (datawindow adw_datawindow, window aw_parent)
end prototypes

public function string of_getclassname ();return 'pf_n_required'

end function

public function integer of_setrequiredcolumnmarker ();// 필수입력항목에 마커를 표시 해줍니다
// 리턴값: success=성공, failure=실패

if not isvalid(idw_target) then return no_action

string ls_syntax, ls_error
string ls_visible, ls_band, ls_text
string ls_fontface, ls_alignment
long ll_fontheight, ll_fontweight
long ll_xpos, ll_ypos, ll_width, ll_iconstart
pf_s_size lstr_textsize
integer i

for i = 1 to ii_requiredcount
	ls_visible = "0~tif(describe('" + is_requiredtext[i] + ".Visible') = '1', 1, 0)"
	ls_band = idw_target.describe(is_requiredtext[i] + ".Band")
	ls_text = idw_target.describe(is_requiredtext[i] + ".Text")
	
	// 헤더 Text 가 없는 경우
	if ls_text = '' or ls_text = '!' or ls_text = '?' then continue
	
	// 텍스트 사이즈
	if left(ls_text, 1) = '*' then
		ls_text = '   ' + mid(ls_text, 2)
	else
		ls_text = '  ' + ls_text
	end if
	
	ls_fontface = idw_target.describe(is_requiredtext[i] + ".Font.Face")
	ll_fontheight = - long(idw_target.describe(is_requiredtext[i] + ".Font.Height"))
	ll_fontweight = long(idw_target.describe(is_requiredtext[i] + ".Font.Weight"))
	gnv_extfunc.pf_GetTextSizeW(handle(idw_target), ls_text, ls_fontface, ll_fontheight, ll_fontweight, lstr_textsize)
	lstr_textsize.width = pixelstounits(lstr_textsize.width, xpixelstounits!)
	lstr_textsize.height = pixelstounits(lstr_textsize.height, ypixelstounits!)
	
	// 텍스트 정렬방식
	ls_alignment = idw_target.describe(is_requiredtext[i] + ".Alignment")
	
	ll_xpos = long(idw_target.describe(is_requiredtext[i] + ".x"))
	ll_ypos = long(idw_target.describe(is_requiredtext[i] + ".y"))
	ll_width = long(idw_target.describe(is_requiredtext[i] + ".width"))
	
	choose case ls_alignment
		// left or justify
		case '0', '3'
			ll_iconstart = 0
		// center
		case '2'
			ll_iconstart = (ll_width - lstr_textsize.width) / 2
		// right
		case '1'
			ll_iconstart = ll_width - lstr_textsize.width
	end choose

	if ll_iconstart < 0 then
		ll_iconstart = 0
	end if

	ls_syntax +=  'create bitmap(band=' + ls_band + ' filename="' + RequiredColumnMarkerImageFile + '" x="' + string(ll_xpos) + '~tlong(describe(~~~"' + is_requiredtext[i] + '.x~~~")) + ' + string(ll_iconstart) + '" y="' + string(ll_ypos) + '~tlong(describe(~~~"' + is_requiredtext[i] + &
					'.y~~~")) + 16" height="36" width="0~t41" border="0" name=' + is_requiredtext[i] + '_required visible="' + ls_visible + '" )~r~n'
	ls_syntax += is_requiredtext[i] + '.text="' + ls_text + '"~r~n'
next

// Modify Syntax
if len(ls_syntax) > 0 then
	ls_error = idw_target.modify(ls_syntax)
	if ls_error <> '' then
		::clipboard(ls_syntax)
		messagebox("syntax modify", "pf_n_required, syntax modification failure!~r~n" + ls_error)
		return failure
	end if
end if

return success

end function

public function integer of_setrequiredcolumn ();// 필수입력 항목을 체크후 컬럼명을 보관합니다

if not isvalid(idw_target) then return no_action

string ls_object, ls_objarr[], ls_empty[]
string ls_objtype, ls_text, ls_column, ls_tag
long i, j, ll_objcnt

ii_requiredcount = 0
is_requiredcolumn = ls_empty
is_requiredtext = ls_empty

ls_object = idw_target.describe("Datawindow.Objects")
ll_objcnt = pf_f_parsetoarray(ls_object, '~t', ls_objarr[])
for i = 1 to ll_objcnt
	ls_objtype = idw_target.describe(ls_objarr[i] + ".Type")
	
	choose case ls_objtype
		case "text"
			ls_text = idw_target.describe(ls_objarr[i] + ".Text")
			if left(ls_text, 1) = '*' then
				ls_column = ls_objarr[i]
				if right(ls_column, 2) = '_t' then
					ls_column = left(ls_column, len(ls_column) - 2)
					for j = 1 to ll_objcnt
						if ls_column = ls_objarr[j] then
							ii_requiredcount ++
							is_requiredcolumn[ii_requiredcount] = ls_column
							is_requiredtext[ii_requiredcount] = ls_objarr[i]
							
							ls_tag = idw_target.describe(ls_column + ".Tag")
							if ls_tag = '?' or ls_tag = '!' or ls_tag = '' then
								ls_tag = "required=true"
							else
								ls_tag += ";required=true"
							end if
							
							ls_tag = pf_f_replaceall(ls_tag, "'", "~~'")
							idw_target.modify(ls_column + ".Tag='" + ls_tag + "'")
						end if
					next
				end if
			end if
			
		case "column"
			ls_column = ls_objarr[i]
			ls_tag = idw_target.describe(ls_column + ".Tag")
			if match(ls_tag, 'required *= *true') = true then
				ls_text = trim(idw_target.describe(ls_column + "_t.Text"))
				if ls_text = '' or ls_text = '!' or ls_text = '?' then
					ls_text = ls_column
				end if
				
				ii_requiredcount ++
				is_requiredcolumn[ii_requiredcount] = ls_column
				is_requiredtext[ii_requiredcount] = ls_column + '_t'
			end if
	end choose
next

return ii_requiredcount

end function

public function integer of_checkrequiredcolumn ();// 미 입력된 필수입력 항목이 있는지 확인합니다
// 리턴값: 발견된 미입력 항목 갯수(0=미입력 없음)

long ll_row
integer i, li_reqcnt
string ls_required_msg, ls_text
string ls_unfilled[]

ll_row = idw_target.getnextmodified(0, primary!)
do while ll_row > 0
	ls_required_msg = ''
	
	for i = 1 to ii_requiredcount
		choose case lower(left(idw_target.describe(is_requiredcolumn[i] + ".ColType"), 5))
			case "char(", "char"
				string ls_data
				ls_data = idw_target.getitemstring(ll_row, is_requiredcolumn[i])
				if isnull(ls_data) or ls_data = '' then
					li_reqcnt ++
					ls_unfilled[li_reqcnt] = is_requiredcolumn[i]
					ls_text = trim(idw_target.describe(is_requiredtext[i] + ".Text"))
					
					if len(ls_required_msg) > 0 then ls_required_msg += ', '
					if ls_text <> '!' and ls_text <> '?' and ls_text <> '' then
						ls_required_msg += ls_text
					else
						ls_required_msg += is_requiredcolumn[i]
					end if
				end if
				
			case "date"
				date ldt_data
				ldt_data = idw_target.getitemdate(ll_row, is_requiredcolumn[i])
				if isnull(ldt_data) then
					li_reqcnt ++
					ls_unfilled[li_reqcnt] = is_requiredcolumn[i]
					ls_text = trim(idw_target.describe(is_requiredtext[i] + ".Text"))
					
					if len(ls_required_msg) > 0 then ls_required_msg += ', '
					if ls_text <> '!' and ls_text <> '?' and ls_text <> '' then
						ls_required_msg += ls_text
					else
						ls_required_msg += is_requiredcolumn[i]
					end if
				end if
				
			case "datet", "times"
				datetime ldtm_data
				ldtm_data = idw_target.getitemdatetime(ll_row, is_requiredcolumn[i])
				if isnull(ldtm_data) then
					li_reqcnt ++
					ls_unfilled[li_reqcnt] = is_requiredcolumn[i]
					ls_text = trim(idw_target.describe(is_requiredtext[i] + ".Text"))
					
					if len(ls_required_msg) > 0 then ls_required_msg += ', '
					if ls_text <> '!' and ls_text <> '?' and ls_text <> '' then
						ls_required_msg += ls_text
					else
						ls_required_msg += is_requiredcolumn[i]
					end if
				end if
				
			case "decim"
				decimal ld_data
				ld_data = idw_target.getitemdecimal(ll_row, is_requiredcolumn[i])
				if isnull(ld_data) then
					li_reqcnt ++
					ls_unfilled[li_reqcnt] = is_requiredcolumn[i]
					ls_text = trim(idw_target.describe(is_requiredtext[i] + ".Text"))
					
					if len(ls_required_msg) > 0 then ls_required_msg += ', '
					if ls_text <> '!' and ls_text <> '?' and ls_text <> '' then
						ls_required_msg += ls_text
					else
						ls_required_msg += is_requiredcolumn[i]
					end if
				end if
				
			case "numbe", "long", "ulong", "real", "int"
				double ldbl_data
				ldbl_data = idw_target.getitemnumber(ll_row, is_requiredcolumn[i])
				if isnull(ldbl_data) then
					li_reqcnt ++
					ls_unfilled[li_reqcnt] = is_requiredcolumn[i]
					ls_text = trim(idw_target.describe(is_requiredtext[i] + ".Text"))
					
					if len(ls_required_msg) > 0 then ls_required_msg += ', '
					if ls_text <> '!' and ls_text <> '?' and ls_text <> '' then
						ls_required_msg += ls_text
					else
						ls_required_msg += is_requiredcolumn[i]
					end if
				end if

			case "time"
				time lt_data
				lt_data = idw_target.getitemtime(ll_row, is_requiredcolumn[i])
				if isnull(lt_data) then
					li_reqcnt ++
					ls_unfilled[li_reqcnt] = is_requiredcolumn[i]
					ls_text = trim(idw_target.describe(is_requiredtext[i] + ".Text"))
					
					if len(ls_required_msg) > 0 then ls_required_msg += ', '
					if ls_text <> '!' and ls_text <> '?' and ls_text <> '' then
						ls_required_msg += ls_text
					else
						ls_required_msg += is_requiredcolumn[i]
					end if
				end if
		end choose
	next
	
	if li_reqcnt > 0 then
		choose case idw_target.dynamic of_getpresentationstyle()
			case 'Freeform'
				messagebox('[' + idw_target.dynamic of_gettitle() + '] 알림', '아래 필수입력 항목이 등록되지 않았습니다.~r~n(' + ls_required_msg + ')')
			case else
				idw_target.scrolltorow(ll_row)
				messagebox('[' + idw_target.dynamic of_gettitle() + '] 알림', string(ll_row) + ' 번째 행에 아래와 같은 필수입력 항목이 등록되지 않았습니다.~r~n(' + ls_required_msg + ')')
		end choose
		
		idw_target.setcolumn(ls_unfilled[1])
		idw_target.setfocus()
		return li_reqcnt
	end if
	
	ll_row = idw_target.getnextmodified(ll_row, primary!)
loop

return 0

end function

public function integer of_setpopupcolumn ();// 팝업 입력 항목을 체크후 컬럼명을 보관합니다

if not isvalid(idw_target) then return no_action

string ls_object, ls_objarr[], ls_empty[]
string ls_objtype, ls_text, ls_column
long i, j, ll_objcnt

ii_popupcount = 0
is_popupcolumn = ls_empty
is_popuptext = ls_empty

ls_object = idw_target.describe("Datawindow.Objects")
ll_objcnt = pf_f_parsetoarray(ls_object, '~t', ls_objarr[])
for i = 1 to ll_objcnt
	ls_objtype = idw_target.describe(ls_objarr[i] + ".Type")
	if ls_objtype <> "text" then continue
	
	ls_text = idw_target.describe(ls_objarr[i] + ".Text")
	if right(ls_text, 1) = '@' then
		ls_column = ls_objarr[i]
		if right(ls_column, 2) = '_t' then
			ls_column = left(ls_column, len(ls_column) - 2)
			for j = 1 to ll_objcnt
				if ls_column = ls_objarr[j] then
					ii_popupcount ++
					is_popupcolumn[ii_popupcount] = ls_column
					is_popuptext[ii_popupcount] = ls_objarr[i]
				end if
			next
		end if
	end if
next

return ii_popupcount

end function

public function integer of_setpopupcolumnmarker ();// 팝업 입력항목에 마커를 표시 해줍니다
// 리턴값: success=성공, failure=실패

if not isvalid(idw_target) then return no_action

string ls_syntax, ls_error
string ls_visible, ls_band, ls_text
string ls_fontface, ls_alignment
long ll_fontheight, ll_fontweight
long ll_xpos, ll_ypos, ll_width, ll_iconstart
pf_s_size lstr_textsize
integer i

for i = 1 to ii_popupcount
	ls_visible = "0~tif(describe('" + is_popuptext[i] + ".Visible') = '1', 1, 0)"
	ls_band = idw_target.describe(is_popuptext[i] + ".Band")
	ls_text = idw_target.describe(is_popuptext[i] + ".Text")
	
	// 텍스트 사이즈
	ls_text = left(ls_text, len(ls_text) - 1) + '    '
	ls_fontface = idw_target.describe(is_popuptext[i] + ".Font.Face")
	ll_fontheight = - long(idw_target.describe(is_popuptext[i] + ".Font.Height"))
	ll_fontweight = long(idw_target.describe(is_popuptext[i] + ".Font.Weight"))
	gnv_extfunc.pf_GetTextSizeW(handle(idw_target), ls_text, ls_fontface, ll_fontheight, ll_fontweight, lstr_textsize)
	lstr_textsize.width = pixelstounits(lstr_textsize.width, xpixelstounits!)
	lstr_textsize.height = pixelstounits(lstr_textsize.height, ypixelstounits!)
	
	// 텍스트 정렬방식
	ls_alignment = idw_target.describe(is_popuptext[i] + ".Alignment")
	
	ll_xpos = long(idw_target.describe(is_popuptext[i] + ".x"))
	ll_ypos = long(idw_target.describe(is_popuptext[i] + ".y"))
	ll_width = long(idw_target.describe(is_popuptext[i] + ".width"))
	
	choose case ls_alignment
		// left or justify
		case '0', '3'
			ll_iconstart = lstr_textsize.width - 68
		// center
		case '2'
			ll_iconstart = lstr_textsize.width + ((ll_width - lstr_textsize.width) / 2) - 68
		// right
		case '1'
			ll_iconstart = ll_width - 68 - pixelstounits(2, xpixelstounits!)
	end choose

	if ll_iconstart < 0 then
		ll_iconstart = 0
	end if

	// imagesize(original:height=72, original:width=82, height=58, width=66)
	ls_syntax +=  'create bitmap(band=' + ls_band + ' filename="' + PopupColumnMarkerImageFile + '" x="' + string(ll_xpos) + '~tlong(describe(~~~"' + is_popuptext[i] + '.x~~~")) + ' + string(ll_iconstart) + '" y="' + string(ll_ypos) + '~tlong(describe(~~~"' + is_popuptext[i] + &
					'.y~~~"))" height="60" width="0~t68" border="0" name=' + is_popuptext[i] + '_popup visible="' + ls_visible + '" )~r~n'
	ls_syntax += is_popuptext[i] + '.text="' + ls_text + '"~r~n'
next

// Modify Syntax
if len(ls_syntax) > 0 then
	ls_error = idw_target.modify(ls_syntax)
	if ls_error <> '' then
		::clipboard(ls_syntax)
		messagebox("syntax modify", "pf_n_required, syntax modification failure!~r~n" + ls_error)
		return failure
	end if
end if

return success

end function

public subroutine of_initialize (datawindow adw_datawindow, window aw_parent);// 아규먼트 서비스를 초기화하는 함수
// adw_datawindow: 아규먼스 서비스를 제공할 데이터윈도우
// 리턴값: 없음

// 부모 데이터윈도우 등록
if not isvalid(adw_datawindow) then
	messagebox('알림', '올바르지 않은 함수호출 입니다.~r~npf_n_required.of_registertarget()')
	return
end if

idw_target = adw_datawindow
iw_parent = aw_parent

// 필수입력항목 컬럼명을 보관합니다
this.of_setrequiredcolumn()

// 필수입력항목 마커를 표시합니다
if RequiredColumnMarker = true then
	this.of_setrequiredcolumnmarker()
end if

// 팝업 입력항목 컬럼명을 보관합니다
//this.of_setpopupcolumn()

// 팝업 입력항목 마커를 표시합니다
//this.of_setpopupcolumnmarker()

end subroutine

on pf_n_required.create
call super::create
end on

on pf_n_required.destroy
call super::destroy
end on

