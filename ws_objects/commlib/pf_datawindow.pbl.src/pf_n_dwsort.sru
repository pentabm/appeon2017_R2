$PBExportHeader$pf_n_dwsort.sru
$PBExportComments$데이터윈도우 행 정열 서비스 오브젝트 입니다.
forward
global type pf_n_dwsort from pf_n_nonvisualobject
end type
end forward

global type pf_n_dwsort from pf_n_nonvisualobject
event type long pfe_clicked ( integer xpos,  integer ypos,  long row,  dwobject dwo )
end type
global pf_n_dwsort pf_n_dwsort

type variables
protected:
	datawindow idw_target
	graphicobject igo_parent
	pf_n_hashtable inv_sortedcols
	//pf_n_syntaxbuffer inv_sortedcols

	// column information
	long il_columncount
	string is_columnname[]
	long il_columnxpos[], il_columnwidth[]
	
	// sort option
	boolean ib_multisort = false
	boolean ib_nullsort = true
	boolean ib_lookupsort = true
	
	// attribute
	Long SortArrowColor = RGB(29,189,31)

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_sortbyheader (dwobject dwo)
public subroutine of_initialize (datawindow adw_datawindow)
end prototypes

event type long pfe_clicked(integer xpos, integer ypos, long row, dwobject dwo);integer li_xpos

// Text 컬럼 클릭 시에만 Sort 기능 수행
if string(dwo.type) <> 'text' then return 0

choose case row
	case 0
		if string(dwo.name) = 'datawindow' then return 0
		if left(idw_target.getbandatpointer(),7) = 'header~t' then
			
			if keydown(KeyControl!) then
				ib_multisort = true
			else
				ib_multisort = false
			end if
			
			this.of_sortbyheader(dwo)
			return 1
		else
			ib_multisort = false
		end if
end choose

return 0

end event

public function string of_getclassname ();return 'pf_n_dwsort'
end function

public function integer of_sortbyheader (dwobject dwo);// 데이터윈도우 SORT

// 헤더 텍스트 클릭시에만 Sort 동작
if string(dwo.type) <> 'text' then return 0
if string(dwo.band) <> 'header' or string(dwo.band) = 'foreground' then return 0

// '_arrow' 텍스트 클릭한 경우 소트 컬럼명
boolean lb_dosort = false
string ls_dwoname
string ls_columnname

ls_dwoname = string(dwo.name)

// 1. '_t' 를 제외한 소트 컬럼명이 있는지 확인
long ll_pos, ll_lastpos
long i, ll_xpos, ll_width

if lb_dosort = false then
	ll_pos = pos(ls_dwoname, '_t')
	if ll_pos > 0 then
		ls_columnname = left(ls_dwoname, ll_pos - 1)
		for i = 1 to il_columncount
			if ls_columnname = is_columnname[i] then
				lb_dosort = true
				exit
			end if
		next
	end if
end if

// 2. Tag 에 소트 컬럼명이 있는지 확인
string ls_tag

if lb_dosort = false then
	ls_tag = string(dwo.tag)
	ll_pos = pos(ls_tag, 'sort=')
	if ll_pos > 0 then
		ll_lastpos = pos(ls_tag, '&', ll_pos + 1)
		if ll_lastpos = 0 then
			ll_lastpos = pos(ls_tag, ',', ll_pos + 1)
			if ll_lastpos = 0 then
				ll_lastpos = len(ls_tag)
			end if
		end if
		ls_columnname = mid(ls_tag, ll_pos + 5, ll_lastpos - ll_pos - 5 + 1)
		lb_dosort = true
	end if
end if

// 3. xpos 와 width 가 일치하는 소트 컬럼이 있는지 확인
if lb_dosort = false then
	ll_xpos = long(dwo.x)
	ll_width = long(dwo.width)
	
	for i = 1 to il_columncount
		if ll_xpos = il_columnxpos[i] and ll_width = il_columnwidth[i] then
			ls_columnname = is_columnname[i]
			lb_dosort = true
			exit
		end if
	next
end if

// 소트 컬럼이 없으면 리턴
if lb_dosort = false then return 0

// 소트 Order 구하기
string ls_titletext
string ls_sortorder_old, ls_sortorder_new
string ls_sortcriteria

ls_titletext = idw_target.describe(ls_dwoname + ".Text")
ls_sortorder_old = right(ls_titletext, 1)
choose case ls_sortorder_old
	case '▲'
		ls_titletext = left(ls_titletext, len(ls_titletext) - 2)
		ls_sortorder_old = 'D'
		ls_sortorder_new = 'A'
	case '▼'
		ls_titletext = left(ls_titletext, len(ls_titletext) - 2)
		ls_sortorder_old = 'A'
		ls_sortorder_new = 'D'
	case else
		ls_sortorder_old = 'None'
		ls_sortorder_new = 'A'
end choose

// dddw, ddlb 컬럼을 코드값이 아닌 화면에 보이는 값으로 sort 하는 옵션
string ls_editstyle
string ls_colexp
boolean lb_lookup

ls_colexp = ls_columnname

if ib_lookupsort = true then
	ls_editstyle = idw_target.describe(ls_columnname + ".Edit.Style")
	choose case ls_editstyle
		case 'dddw', 'ddlb'
			lb_lookup = true
		case 'edit'
			choose case lower(idw_target.describe(ls_columnname + ".Edit.CodeTable"))
				case 'yes', '1'
					lb_lookup = true
			end choose
		case 'editmask'
			choose case lower(idw_target.describe(ls_columnname + ".EditMask.CodeTable"))
				case 'yes', '1'
					lb_lookup = true
			end choose
	end choose
	
	if lb_lookup = true then
		ls_colexp = "lookupdisplay(" + ls_columnname + ")"
	end if
end if

// null 데이터 값을 empty로 치환해서 sort 하는 옵션
if ib_nullsort = true then
	choose case left(lower(idw_target.describe(ls_columnname + ".coltype")), 5)
		case 'char('
			ls_colexp = 'if(isnull(' + ls_colexp + '), "", ' + ls_colexp + ')'
		case 'datet', 'times'
			ls_colexp = 'if(isnull(' + ls_colexp + '), 1900-01-01 00:00:00, ' + ls_colexp + ')'
		case 'date'
			ls_colexp = 'if(isnull(' + ls_colexp + '), 1900-01-01, ' + ls_colexp + ')'
		case 'decim', 'int', 'long', 'numbe', 'real', 'ulong'
			ls_colexp = 'if(isnull(' + ls_colexp + '), 0, ' + ls_colexp + ')'
		case 'time'
			ls_colexp = 'if(isnull(' + ls_colexp + '), 00:00:00, ' + ls_colexp + ')'
	end choose
end if

// 소트 criteria 생성
if ib_multisort = true then
	ls_sortcriteria = idw_target.describe("Datawindow.Table.Sort")
	if ls_sortcriteria = '!' or ls_sortcriteria = '?' then ls_sortcriteria = ''
	
	ll_pos = pos(ls_sortcriteria, ls_colexp + " " + ls_sortorder_old)
	if ll_pos > 0 then
		ls_sortcriteria = replace(ls_sortcriteria, ll_pos, len(ls_colexp + " " + ls_sortorder_old), ls_colexp + " " + ls_sortorder_new)
	else
		if len(ls_sortcriteria) > 0 then ls_sortcriteria += ", "
		ls_sortcriteria += ls_colexp + " " + ls_sortorder_new
	end if
else
	ls_sortcriteria = ls_colexp + " " + ls_sortorder_new
end if

// 소트 수행
idw_target.setsort(ls_sortcriteria)
idw_target.sort()
if idw_target.findgroupchange(0, 1) > 0 then
	idw_target.groupcalc()
end if

// 데이터윈도우 디자인
string ls_text
string ls_syntax
pf_n_syntaxbuffer lnv_syntax
string ls_error

lnv_syntax = create pf_n_syntaxbuffer

choose case ls_sortorder_new
	case 'A'
		lnv_syntax.of_append(ls_dwoname + ".Text='" + ls_titletext + " ▼'")
	case 'D'
		lnv_syntax.of_append(ls_dwoname + ".Text='" + ls_titletext + " ▲'")
end choose

// Hide SortArrow
long ll_sortobjcnt

if ib_multisort = false then
	ll_sortobjcnt = inv_sortedcols.of_size()
	for i = 1 to ll_sortobjcnt
		if inv_sortedcols.of_getkey(i) <> ls_dwoname then
			ls_titletext = idw_target.describe(inv_sortedcols.of_getkey(i) + ".Text")
			ls_titletext = left(ls_titletext, len(ls_titletext) - 2)
			lnv_syntax.of_append(inv_sortedcols.of_getkey(i) + ".Text='" + ls_titletext + "'")
		end if
	next
	
	inv_sortedcols.of_clear()
end if

inv_sortedcols.of_put(ls_dwoname, ls_columnname)

// do syntax modify
ls_error = idw_target.modify(lnv_syntax.of_tostring())
if ls_error <> '' then
	::clipboard(idw_target.classname() + "~r~n" + lnv_syntax.of_tostring())
	messagebox("of_sort()", idw_target.classname() + " Syntax Creation Failure!!~r~n" + ls_error)
	return -1
end if

return 1

end function

public subroutine of_initialize (datawindow adw_datawindow);// parent datawindow 등록
idw_target = adw_datawindow
igo_parent = idw_target.getparent()

// column name, xpos, width 저장
long i

il_columncount = long(idw_target.describe("Datawindow.Column.Count"))
for i = 1 to il_columncount
	is_columnname[i] = idw_target.describe("#" + string(i) + ".Name")
	il_columnxpos[i] = long(idw_target.describe("#" + string(i) + ".X"))
	il_columnwidth[i] = long(idw_target.describe("#" + string(i) + ".Width"))
next

// sorted column 보관용
if not isvalid(inv_sortedcols) then inv_sortedcols = create pf_n_hashtable

end subroutine

on pf_n_dwsort.create
call super::create
end on

on pf_n_dwsort.destroy
call super::destroy
end on

