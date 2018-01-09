$PBExportHeader$pf_w_popmenusort.srw
$PBExportComments$데이터윈도우 Sort
forward
global type pf_w_popmenusort from window
end type
type cb_ok from pf_u_commandbutton within pf_w_popmenusort
end type
type cb_cancel from pf_u_commandbutton within pf_w_popmenusort
end type
type dw_criteria from pf_u_datawindow within pf_w_popmenusort
end type
end forward

global type pf_w_popmenusort from window
integer width = 2002
integer height = 1048
boolean titlebar = true
string title = "Data Sorting"
boolean controlmenu = true
windowtype windowtype = response!
boolean center = true
event pfe_postopen ( )
cb_ok cb_ok
cb_cancel cb_cancel
dw_criteria dw_criteria
end type
global pf_w_popmenusort pf_w_popmenusort

type variables
DataWindow idw_target
end variables

event pfe_postopen();long ll_cnter, ll_columncnt, nInsRow,ll_pos
string ls_column, ls_dropdownlist, ls_text

ll_columncnt = long(idw_target.describe('DataWindow.Column.Count'))
if ll_columncnt < 1 then return

ls_dropdownlist = ' ' + '~t' + ' ' + '/'
for ll_cnter = 1 to ll_columncnt
	ls_column = idw_target.Describe('#' + String(ll_cnter) + '.Name')
	ls_text = idw_target.Describe(ls_column + "_t.Text")
	if ls_text = '!' or ls_text = '?' or ls_text = '' then continue
	
	ls_text = pf_f_replaceall(ls_text, '~r', '')
	ls_text = pf_f_replaceall(ls_text, '~n', '')
	ls_text = pf_f_replaceall(ls_text, '"', '')
	ls_text = pf_f_replaceall(ls_text, '~~', '')
		
	ls_dropdownlist += ls_text + '~t' + ls_column + '/'
next

dw_criteria.modify("sort_column.Values='" + ls_dropdownlist + "'")
for ll_cnter = 1 to 10
	dw_criteria.insertrow(0)
next

//String cColumn, cDropDownList,ls_text,ls_data,ls_bit[]
//Long   nColCnt, nColumnCount, nInsRow
//
//nColumnCount = Integer(idw_target.Object.DataWindow.Column.Count)
//IF nColumnCount < 1 THEN RETURN 
//
//ls_bit[1] = '~r'
//ls_bit[2] = '~n'
//ls_bit[3] = '"'
//
//cDropDownList = ' ' + '~t' + ' ' + '/' 
//FOR nColCnt = 1 TO nColumnCount
//	cColumn = idw_target.Describe('#' + String(nColCnt) + '.Name')
//	ls_text = idw_target.Describe(cColumn+"_t.text")
//	IF len(ls_text) > 1 THEN
//		ls_data = pf_f_replaceall(ls_text, ls_bit[1], '')
//		ls_data = pf_f_replaceall(ls_data, ls_bit[2], '')
//		ls_data = pf_f_replaceall(ls_data, ls_bit[3], '')
//		
//		cDropDownList = cDropDownList + ls_data + '~t' + cColumn + '/' 
//	END IF
//NEXT
//
//dw_target.Object.sort_column.Values = cDropDownList
//dw_target.InsertRow(0)
//dw_target.InsertRow(0)
//dw_target.InsertRow(0)
//dw_target.InsertRow(0)
//dw_target.InsertRow(0)
//dw_target.InsertRow(0)
//dw_target.InsertRow(0)
//dw_target.InsertRow(0)
//dw_target.InsertRow(0)

end event

on pf_w_popmenusort.create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.dw_criteria=create dw_criteria
this.Control[]={this.cb_ok,&
this.cb_cancel,&
this.dw_criteria}
end on

on pf_w_popmenusort.destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.dw_criteria)
end on

event open;idw_target = message.powerobjectparm
if not isvalid(idw_target) then
	messagebox('알림(pf_w_popmenusort)', '올바르지 않은 윈도우 호출입니다')
	close(this)
end if

this.post event pfe_postopen()

end event

type cb_ok from pf_u_commandbutton within pf_w_popmenusort
integer x = 1362
integer y = 840
integer width = 297
string text = "확인"
end type

event clicked;integer li_colcnt, i
string ls_column, ls_text, ls_sortorder
string ls_sortcriteria
long ll_pos, ll_rowcnt, ll_sort

// SortOrder 표시 (△,  ▽ ) 초기화
li_colcnt = integer(idw_target.describe("Datawindow.Column.Count"))
for i = 1 to li_colcnt
	ls_column = idw_target.describe("#" + string(i) + ".Name")
	ls_text = idw_target.describe(ls_column + "_t.Text")
	ls_text = pf_f_replaceall(ls_text, "~"", "")
	
	ll_pos = pos(ls_text, '△')
	if ll_pos = 0 then ll_pos = pos(ls_text, '▽')

	if ll_pos > 0 then
		ls_text = mid(ls_text, 1, ll_pos - 1)
		idw_target.modify(ls_column + "_t.Text='" + ls_text + "'")
	end if
next

ll_rowcnt = dw_criteria.rowcount()
for i = 1 to ll_rowcnt
	ls_column = dw_criteria.getitemstring(i, 'sort_column')
	if pf_f_isemptystring(ls_column) then continue
	
	ls_sortorder = dw_criteria.getitemstring(i, 'sort_gb')
	if ls_sortorder = 'N' then continue

	if pf_f_isemptystring(ls_sortorder) then
		ls_sortorder = 'A'
	end if
	
	ls_text = idw_target.describe(ls_column + "_t.Text")
	ls_text = pf_f_replaceall(ls_text, "~"", "")
	
	ll_sort ++
	choose case ls_sortorder
		case 'A'
			ls_text += '△' + string(ll_sort)
		case 'D'
			ls_text += '▽' + string(ll_sort)
		case else
			continue
	end choose
	
	idw_target.modify(ls_column + "_t.Text='" + ls_text + "'")
	
	if len(ls_sortcriteria) > 0 then
		ls_sortcriteria += ", "
	end if
	
	ls_sortcriteria += ls_column + ' ' + ls_sortorder
next

idw_target.modify("DataWindow.Sparse=''") 
idw_target.setsort(ls_sortcriteria)
idw_target.sort()
idw_target.groupcalc()

close(parent)

end event

type cb_cancel from pf_u_commandbutton within pf_w_popmenusort
integer x = 1678
integer y = 840
integer width = 297
string text = "닫기"
end type

event clicked;integer li_colcnt, i
string ls_column, ls_text
long ll_pos

// SortOrder 표시 (△,  ▽ ) 초기화
li_colcnt = integer(idw_target.describe("Datawindow.Column.Count"))
for i = 1 to li_colcnt
	ls_column = idw_target.describe("#" + string(i) + ".Name")
	ls_text = idw_target.describe(ls_column + "_t.Text")
	ls_text = pf_f_replaceall(ls_text, "~"", "")
	
	ll_pos = pos(ls_text, '△')
	if ll_pos = 0 then ll_pos = pos(ls_text, '▽')

	if ll_pos > 0 then
		ls_text = mid(ls_text, 1, ll_pos - 1)
		idw_target.modify(ls_column + "_t.Text='" + ls_text + "'")
	end if
next

end event

type dw_criteria from pf_u_datawindow within pf_w_popmenusort
integer x = 23
integer y = 20
integer width = 1952
integer height = 800
string dataobject = "pf_d_popmenusort"
boolean vscrollbar = true
end type

event clicked;setrow(row)

end event

event itemchanged;if dwo.name = 'sort_column' then
	if len(trim(data)) > 0 then
		this.object.sort_gb[row] = 'A'
	else
		this.object.sort_gb[row] = 'N'
	end if
end if

end event

