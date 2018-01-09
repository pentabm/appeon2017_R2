$PBExportHeader$pf_w_popupsearch.srw
$PBExportComments$공통 팝업 윈도우 화면 입니다.
forward
global type pf_w_popupsearch from pf_w_response
end type
type p_close from pf_u_imagebutton within pf_w_popupsearch
end type
type p_select from pf_u_imagebutton within pf_w_popupsearch
end type
type p_search from pf_u_imagebutton within pf_w_popupsearch
end type
type dw_list from pf_u_datawindow within pf_w_popupsearch
end type
type dw_cond from pf_u_datawindow within pf_w_popupsearch
end type
end forward

global type pf_w_popupsearch from pf_w_response
boolean visible = false
integer width = 2373
integer height = 2264
p_close p_close
p_select p_select
p_search p_search
dw_list dw_list
dw_cond dw_cond
end type
global pf_w_popupsearch pf_w_popupsearch

type variables
pf_s_popupsearch istr_search

end variables

on pf_w_popupsearch.create
int iCurrent
call super::create
this.p_close=create p_close
this.p_select=create p_select
this.p_search=create p_search
this.dw_list=create dw_list
this.dw_cond=create dw_cond
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_close
this.Control[iCurrent+2]=this.p_select
this.Control[iCurrent+3]=this.p_search
this.Control[iCurrent+4]=this.dw_list
this.Control[iCurrent+5]=this.dw_cond
end on

on pf_w_popupsearch.destroy
call super::destroy
destroy(this.p_close)
destroy(this.p_select)
destroy(this.p_search)
destroy(this.dw_list)
destroy(this.dw_cond)
end on

event open;call super::open;// get parameter
istr_search = message.powerobjectparm
if not isvalid(istr_search) then
	messagebox('알림', '잘못된 윈도우 호출입니다')
	close(this)
	return
end if

// move window
if istr_search.xpos <> 0 or istr_search.ypos <> 0 then
	this.move(istr_search.xpos, istr_search.ypos)
end if

// resize window
if istr_search.width + istr_search.height > 0 then
	if istr_search.width = 0 then istr_search.width = this.width
	if istr_search.height = 0 then istr_search.height = this.height
	this.resize(istr_search.width, istr_search.height)
end if

end event

event pfe_postopen;call super::pfe_postopen;// 윈도우 타이틀 설정
this.title = istr_search.window_title

// 조회조건용 DataObject와 TransactionObject 를 설정 합니다
dw_cond.defaultvaluesoninsertrow = istr_search.condition_defaultvalues
dw_cond.of_setdataobject(istr_search.condition_dwobject)
if isvalid(istr_search.transaction_object) then
	dw_cond.settransobject(istr_search.transaction_object)
end if

// 조회조건 행추가
dw_cond.inv_action.of_insertrow(0)

// 리스트용 DataObject와 TransactionObject 를 설정 합니다
dw_list.retrievalarguments = istr_search.list_arguments
dw_list.of_setdataobject(istr_search.list_dwobject)
if isvalid(istr_search.transaction_object) then
	dw_list.settransobject(istr_search.transaction_object)
end if

// 데이터 조회 시작
if istr_search.auto_retrieve = true then
	p_search.event clicked()
end if

// SetFocus
long ll_columncnt, i
string ls_data

dw_cond.setfocus()
ll_columncnt = long(dw_cond.describe("Datawindow.Column.Count"))
for i = 1 to ll_columncnt
	choose case lower(left(dw_cond.describe('#' + string(i) + ".ColType"), 5))
		case "char(", "char"
			if len(dw_cond.getitemstring(1, i)) > 0 then
				dw_cond.setcolumn(i)
				exit
			end if
	end choose
next

// 데이터가 한 건 조회된 경우 자동 선택 & 리턴 합니다
if dw_list.rowcount() = 1 then
	p_select.event clicked()
else
	this.visible = true
end if

end event

type ln_templeft from pf_w_response`ln_templeft within pf_w_popupsearch
end type

type ln_tempright from pf_w_response`ln_tempright within pf_w_popupsearch
end type

type ln_temptop from pf_w_response`ln_temptop within pf_w_popupsearch
end type

type ln_tempbuttom from pf_w_response`ln_tempbuttom within pf_w_popupsearch
end type

type ln_tempbutton from pf_w_response`ln_tempbutton within pf_w_popupsearch
end type

type ln_tempstart from pf_w_response`ln_tempstart within pf_w_popupsearch
end type

type p_close from pf_u_imagebutton within pf_w_popupsearch
integer x = 2103
integer y = 32
integer width = 233
integer height = 88
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;istr_search.data_selected = false
closewithreturn(parent, istr_search)

end event

type p_select from pf_u_imagebutton within pf_w_popupsearch
integer x = 1856
integer y = 32
integer width = 233
integer height = 88
string picturename = "..\img\controls\u_imagebutton\topBtn_select.gif"
boolean fixedtoright = true
string referencedobject = "parent"
string onclickcallevent = "ue_selected"
end type

event clicked;call super::clicked;long ll_row

if not isvalid(istr_search) then return

ll_row = dw_list.getrow()
if ll_row = 0 then
	messagebox('알림', '선택할 수 있는 자료가 없습니다')
	return
end if

integer i, li_itemcnt

li_itemcnt = upperbound(istr_search.getitem_column)
if li_itemcnt = 0 then
	messagebox('알림', '값을 구해올 컬럼명을 pf_s_popupsearch.getitem_column[] 멤버변수에 추가하세요')
	return
end if

for i = 1 to li_itemcnt
	choose case left(dw_list.describe(istr_search.getitem_column[i] + ".ColType"), 5)
		case '!', '?'
			messagebox('알림', '[' + istr_search.getitem_column[i] + '] 컬럼명을 찾을 수 없습니다')
			return
		case 'char('
			istr_search.column_value[i] = dw_list.getitemstring(ll_row, istr_search.getitem_column[i])
		case 'date'
			istr_search.column_value[i] = string(dw_list.getitemdate(ll_row, istr_search.getitem_column[i]), 'YYYYMMDD')
		case 'time'
			istr_search.column_value[i] = string(dw_list.getitemtime(ll_row, istr_search.getitem_column[i]), 'hhmmss')
		case 'datet', 'times'
			istr_search.column_value[i] = string(dw_list.getitemdatetime(ll_row, istr_search.getitem_column[i]), 'YYYYMMDDhhmmss')
		case 'decim'
			istr_search.column_value[i] = string(dw_list.getitemdecimal(ll_row, istr_search.getitem_column[i]))
		case 'int', 'long', 'numbe', 'real', 'ulong'
			istr_search.column_value[i] = string(dw_list.getitemnumber(ll_row, istr_search.getitem_column[i]))
	end choose
next

istr_search.data_selected = true
closewithreturn(parent, istr_search)

end event

type p_search from pf_u_imagebutton within pf_w_popupsearch
integer x = 1609
integer y = 32
integer width = 233
integer height = 88
string picturename = "..\img\controls\u_imagebutton\topBtn_search.gif"
boolean fixedtoright = true
string referencedobject = "dw_list"
string datawindowaction = "retrieve"
end type

type dw_list from pf_u_datawindow within pf_w_popupsearch
integer x = 27
integer y = 340
integer width = 2309
integer height = 1816
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean confirmupdateonrowchange = false
boolean datawindowaction = true
boolean scaletoright = true
boolean scaletobottom = true
end type

event doubleclicked;call super::doubleclicked;if row > 0 then
	p_select.event clicked()
end if

end event

event pfe_postretrieve;call super::pfe_postretrieve;// 조회 후 SetFocus 처리
long ll_columncnt, i
string ls_data

if al_rowcount > 0 then
	this.setfocus()
else
	dw_cond.setfocus()
	ll_columncnt = long(dw_cond.describe("Datawindow.Column.Count"))
	for i = 1 to ll_columncnt
		choose case lower(left(dw_cond.describe('#' + string(i) + ".ColType"), 5))
			case "char(", "char"
				if len(dw_cond.getitemstring(1, i)) > 0 then
					dw_cond.setcolumn(i)
					exit
				end if
		end choose
	next
end if

end event

event pfe_processenter;call super::pfe_processenter;p_select.event clicked()

end event

type dw_cond from pf_u_datawindow within pf_w_popupsearch
integer x = 27
integer y = 136
integer width = 2309
integer height = 188
integer taborder = 10
boolean livescroll = false
boolean singlerowselection = false
boolean issearchcondition = true
boolean confirmupdateonrowchange = false
boolean datawindowaction = true
boolean scaletoright = true
end type

