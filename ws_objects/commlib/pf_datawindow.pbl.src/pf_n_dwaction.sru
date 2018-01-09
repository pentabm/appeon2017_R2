$PBExportHeader$pf_n_dwaction.sru
$PBExportComments$데이터윈도우 액션 서비스를 제공하는 오브젝트 입니다.
forward
global type pf_n_dwaction from pf_n_nonvisualobject
end type
end forward

global type pf_n_dwaction from pf_n_nonvisualobject
event type long pfe_rowfocuschanged ( long currentrow )
event type long pfe_rowfocuschanging ( long currentrow,  long newrow )
event type long pfe_itemchanged ( long row,  dwobject dwo,  string data )
end type
global pf_n_dwaction pf_n_dwaction

type variables
protected:
	window iw_parent
	pf_u_datawindow idw_target

public:
	// 현재 실행중인 액션명
	string is_RunningAction
	
	// RowFocusChange 방지
	boolean ib_PreventRowFocusChange
	
	// Retrieve 된 행 수
	long il_RowsRetrieved
	
	// INSERTROW 방향 = 하단
	boolean ib_InsertRowOnTop = False

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_setprocessorder ()
public function string of_excel ()
public function integer of_update ()
public function integer of_accepttext ()
public function boolean of_checkmodified ()
public function long of_retrieve ()
public function integer of_resetupdate ()
public function integer of_insertrow (long al_row)
public function long of_retrievedddw (string as_column)
public function integer of_retrievedddw ()
public function string of_getrunningaction ()
public subroutine of_setrunningaction (string as_action)
public function long of_retrieve (datawindow adw_target)
public function integer of_insertrow (ref datawindow adw_target, long al_row)
public function integer of_deleterow (ref datawindow adw_target, long al_row)
public function integer of_deleterow (long al_row)
public function integer of_deleterow_multi ()
public function integer of_gettransobject (readonly datawindow adw_target[], ref transaction atr_result[])
public subroutine of_initialize (datawindow adw_target, window awo_parent)
public function integer of_getmodified (ref datawindow adw_modified[])
public function integer of_commitupdate ()
public function long of_datawindowaction (string as_action)
public function long of_print ()
public function integer of_logicaldelete (long al_row)
public subroutine of_setnewrowdirection (string as_direction)
end prototypes

event type long pfe_rowfocuschanged(long currentrow);// 연계 데이터윈도우 조회

if not isvalid(idw_target) then return 0
if this.of_getrunningaction() <> '' then return 0
if currentrow = 0 then return 0

integer li_synccnt, li_linkcnt
integer i, j
pf_u_datawindow ldw_synced[], ldw_ulink, ldw_dlink[]

// Synced Datawindow 조회
li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
for i = 1 to li_synccnt
	if idw_target <> ldw_synced[i] then
		ldw_synced[i].inv_action.of_setrunningaction('rowfocuschanged')
		
		choose case ldw_synced[i].of_getpresentationstyle()
			case 'Freeform'
				ldw_ulink = ldw_synced[i].inv_link.of_getuplinkeddatawindow()
				if isvalid(ldw_ulink) then
					//if idw_target <> ldw_ulink then
						choose case ldw_ulink.getitemstatus(currentrow, 0, primary!)
							case new!, newmodified!
								if len(ldw_synced[i].inv_link.iblb_changes) > 0 then
									ldw_synced[i].reset()
									if ldw_synced[i].setchanges(ldw_synced[i].inv_link.iblb_changes) > 0 then
										ldw_synced[i].setrow(1)
									end if
								end if
							case notmodified!, datamodified!
								if ldw_ulink.rowcount() = 0 or currentrow = 0 then
									ldw_synced[i].reset()
								else
									this.of_retrieve(ldw_synced[i])
								end if
							//case else
							//	ldw_synced[i].reset()
						end choose
					//end if
				end if
			case else
				//ldw_synced[i].scrolltorow(currentrow)
				//ldw_synced[i].event rowfocuschanged(currentrow)
		end choose
		
		ldw_synced[i].inv_action.of_setrunningaction('')
	end if
next

// Linked Datawindow 조회
for i = 1 to li_synccnt
	li_linkcnt = ldw_synced[i].inv_link.of_getdownlinkeddatawindow(ldw_dlink)
	for j = 1 to li_linkcnt
		if ldw_dlink[j].inv_link.idw_uplinked.rowcount() = 0 or currentrow = 0 then
			ldw_dlink[j].reset()
		else
			//messagebox('linked datawindow', 'parent=' + ldw_synced[i].classname() + ', child=' + ldw_dlink[j].classname())
			this.of_retrieve(ldw_dlink[j])
		end if
	next
next

return 0

end event

event type long pfe_rowfocuschanging(long currentrow, long newrow);// 연계된 데이터 윈도우 변경여부를 체크하고 저장한다
//0  Continue processing (setting the current row)
//1  Prevent the current row from changing

if not isvalid(idw_target) then return no_action
if newrow = 0 then return 0
if this.of_getrunningaction() <> '' then return 0
if this.of_accepttext() = failure then return 1

//pf_u_datawindow ldw_dlink[]
long ll_retval
//integer i, li_linkcnt
//boolean lb_modified

//messagebox(idw_target.of_gettitle(), 'pfe_rowfocuschanging')

integer li_synccnt, li_linkcnt
integer i, j
pf_u_datawindow ldw_synced[], ldw_dlink[]
boolean lb_modified = false

//// 하위 연계 데이터윈도우가 존재하는 경우만 데이터 변경여부를 체크 합니다
//choose case idw_target.of_getpresentationstyle()
//	case 'Freeform'
//		lb_modified = this.of_checkmodified()
//	case else

li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
for i = 1 to li_synccnt
	if isvalid(ldw_synced[i].inv_link.idw_uplinked) and ldw_synced[i].of_getpresentationstyle() = 'Freeform' then
		if ldw_synced[i].of_isupdatable() = true then
			if ldw_synced[i].modifiedcount() + ldw_synced[i].deletedcount() > 0 or upperbound(ldw_synced[i].inv_link.iblb_deleted) > 0 then
				lb_modified = true
				exit
			end if
		end if
	end if
	
	li_linkcnt = ldw_synced[i].inv_link.of_getdownlinkeddatawindow(ldw_dlink)
	for j = 1 to li_linkcnt
		if ldw_dlink[j].of_isupdatable() = true then
			if ldw_dlink[j].modifiedcount() + ldw_dlink[j].deletedcount() > 0 then
				lb_modified = true
				exit
			end if
		end if
	next
	if lb_modified = true then exit
next

if lb_modified = false then return no_action

if idw_target.ConfirmUpdateOnRowChange = true then
	choose case messagebox('[' + idw_target.of_gettitle() + '] 알림', '변경 내역이 저장되지 않았습니다.~r~n변경 내역을 저장 하시겠습니까?', Question!, YesNoCancel!, 3)
		case 1
			if this.of_update() = success then
				ll_retval = 0
			else
				ll_retval = 1
			end if
		case 2
			this.of_resetupdate()
			ll_retval = 0
		case 3
			ll_retval = 1
	end choose
else
	if this.of_update() = success then
		ll_retval = 0
	else
		ll_retval = 1
	end if
end if


//// 하위 연계 데이터윈도우가 존재하는 경우만 데이터 변경여부를 체크 합니다
//choose case idw_target.of_getpresentationstyle()
//	case 'Freeform'
//		lb_modified = this.of_checkmodified()
//	case else
//		li_linkcnt = idw_target.inv_link.of_getdownlinkeddatawindow(ldw_dlink)
//		for i = 1 to li_linkcnt
//			if ldw_dlink[i].dynamic of_isupdatable() = true then
//				if ldw_dlink[i].modifiedcount() + ldw_dlink[i].deletedcount() > 0 then
//					lb_modified = true
//					exit
//				end if
//			end if
//		next
//end choose
//
//if lb_modified = false then return 0
//
//if idw_target.ConfirmUpdateOnRowChange = true then
//	choose case messagebox('[' + idw_target.of_gettitle() + '] 알림', '데이터 변경 내역이 존재합니다.~r~n변경 내역을 저장 하시겠습니까?', Question!, YesNoCancel!, 3)
//		case 1
//			if this.of_update() = success then
//				ll_retval = 0
//			else
//				ll_retval = 1
//			end if
//		case 2
//			this.of_resetupdate()
//			ll_retval = 0
//		case 3
//			ll_retval = 1
//	end choose
//else
//	if this.of_update() = success then
//		ll_retval = 0
//	else
//		ll_retval = 1
//	end if
//end if

return ll_retval

//ll_linkcnt = idw_target.inv_link.of_getdownlinkeddatawindow(ldw_dlink)
//for i = 1 to ll_linkcnt
//	// check if updatable
//	if ldw_dlink[i].of_isupdatable() = false then continue
//	if ldw_dlink[i].inv_link.of_getlinkagetype() = 'syncable' then continue
//	
//	// check down linked modification
//	if ldw_dlink[i].modifiedcount() + ldw_dlink[i].deletedcount() > 0 then
//		lb_modified = true
//		exit
//	end if
//next
//
//if lb_modified = true then
//	if idw_target.ConfirmUpdateOnRowChange = true then
//		choose case messagebox('[' + idw_target.of_gettitle() + '] 알림', '데이터 변경 내역이 존재합니다.~r~n변경 내역을 저장 하시겠습니까?', Question!, YesNoCancel!, 3)
//			case 1
//				if idw_target.inv_action.of_update() = success then
//					ll_retval = 0
//				else
//					ll_retval = 1
//				end if
//			case 2
//				idw_target.inv_action.of_resetupdate()
//				ll_retval = 0
//			case 3
//				ll_retval = 1
//		end choose
//	else
//		if idw_target.inv_action.of_update() = success then
//			ll_retval = 0
//		else
//			ll_retval = 1
//		end if
//	end if
//end if

//if ll_retval = 1 then
//	idw_target.selectrow(0, false)
//	idw_target.selectrow(currentrow, true)
//end if

//return ll_retval

end event

event type long pfe_itemchanged(long row, dwobject dwo, string data);// 연계된 데이터윈도우 변경

if not isvalid(idw_target) then return 0
if this.of_getrunningaction() <> '' then return 0
if row = 0 then return 0

integer li_synccnt
integer i, j
pf_u_datawindow ldw_synced[]
dwitemstatus ll_itemstatus
string ls_colname

// 연계된 데이터윈도우 변경
li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
for i = 1 to li_synccnt
	if ldw_synced[i].rowcount() = 0 then continue
	if idw_target <> ldw_synced[i] then
		if long(ldw_synced[i].describe(string(dwo.name) + ".ID")) > 0 then
			
			if ldw_synced[i].of_getpresentationstyle() <> 'Freeform' then
				row = ldw_synced[i].getrow()
			else
				row = 1
			end if
			
			ll_itemstatus = ldw_synced[i].getitemstatus(row, string(dwo.name), primary!)
			ldw_synced[i].setitem(row, string(dwo.name), data)
			if ll_itemstatus = notmodified! then
				ldw_synced[i].setitemstatus(row, string(dwo.name), primary!, datamodified!)
				ldw_synced[i].setitemstatus(row, string(dwo.name), primary!, notmodified!)
			end if
		end if
	end if
next

return 0

end event

public function string of_getclassname ();return 'pf_n_dwaction'

end function

public function integer of_setprocessorder ();//// 윈도우오브젝트가 가지고 있는 데이터윈도우의 처리 순서를 설정한다
//// 처리 순서는 윈도우 TABORDER를 기준으로 진행되며,
//// UPLINKED_DATAWINDOW가 선언된 경우 상위 데이터윈도우를 처리한 다음 진행된다
//
//if not isvalid(iw_parent) then return no_action
//
//if not isvalid(inv_procdw) then
//	inv_procdw = create pf_n_hashtable
//else
//	inv_procdw.of_clear()
//end if
//
//windowobject lwo_objects[]
//pf_u_datawindow ldw_target, ldw_linked
//integer i, li_objcnt, li_linkcnt, li_taborder, li_zerocnt
//string ls_procorder
//
//li_objcnt = iw_parent.dynamic of_getwindowobjects(lwo_objects)
//for i = 1 to li_objcnt
//	if lwo_objects[i].typeof() = datawindow! then
//		
//		li_linkcnt = 0
//		ldw_target = lwo_objects[i]
//		
//		if ldw_target.triggerevent('pfe_ispowerframecontrol') = 1 then
//			if ldw_target.dynamic of_issearchcondition() = true then
//				continue
//			end if
//		end if
//		
//		li_taborder = ldw_target.taborder
//		
//		ldw_linked = ldw_target.inv_link.of_getuplinkeddatawindow()
//		do while isvalid(ldw_linked)
//			li_linkcnt ++
//			li_taborder = ldw_linked.taborder
//			ldw_linked = ldw_linked.inv_link.of_getuplinkeddatawindow()
//		loop
//		
//		if li_taborder = 0 then li_zerocnt ++
//		ls_procorder = string(li_taborder * 10000 + li_zerocnt * 100 + li_linkcnt, '00000000')
//		inv_procdw.of_put(ls_procorder, ldw_target)
//	end if
//next

return success

end function

public function string of_excel ();// 데이터윈도우 내용을 SAVEAS 합니다
// 리턴값: SAVEAS된 파일명

if not isvalid(idw_target) then return ''
this.of_setrunningaction('excel')

pf_n_saveas lnv_save
string ls_filename

ls_filename = lnv_save.of_saveas(idw_target, true)

this.of_setrunningaction('')
return ls_filename

end function

public function integer of_update ();// 데이터 변경사항을 저장 합니다
// 리턴값: 성공=1, 실패=-1

if not isvalid(idw_target) then return no_action

this.of_setrunningaction('update')

// AcceptText 수행
if this.of_accepttext() = failure then
	this.of_setrunningaction('')
	return failure
end if

// 변경사항이 존재하는 데이터윈도우를 구합니다
integer li_modifiedcnt
pf_u_datawindow ldw_modified[]

li_modifiedcnt = this.of_getmodified(ldw_modified)
if li_modifiedcnt = 0 then
	messagebox('[' + idw_target.of_gettitle() + '] 알림', '저장할 내용이 없습니다')
	this.of_setrunningaction('')
	return failure
end if

// 변경사항이 존재하는 데이터윈도우의 트랜젝션 오브젝트를 구합니다
transaction ltr_trans[]
integer li_transcnt, i, j

li_transcnt = this.of_gettransobject(ldw_modified, ltr_trans)

// 저장 전 수행될 사용자 이벤트 호출
for i = 1 to li_modifiedcnt
	if ldw_modified[i].event pfe_preupdate() = failure then
		this.of_setrunningaction('')
		return failure
	end if
next

// 필수 입력 항목 체크
for i = 1 to li_modifiedcnt
	if isvalid(ldw_modified[i].inv_required) then
		if ldw_modified[i].inv_required.of_checkrequiredcolumn() > 0 then
			this.of_setrunningaction('')
			return failure
		end if
	end if
next

// 참고) Foreign Key 가 구현된 테이블 구조의 경우
// UPDATE시 삭제내역만 별도로 역순으로 저장해야 함

// UPDATE 수행
pf_n_datastore lds_deleted
long ll_delcnt

for i = 1 to li_modifiedcnt
	// 삭제 버퍼 기능 안 씀.
//	ll_delcnt = upperbound(ldw_modified[i].inv_link.iblb_deleted)
//	if ll_delcnt > 0 then
//		lds_deleted = create pf_n_datastore
//		lds_deleted.dataobject = ldw_modified[i].dataobject
//		lds_deleted.settransobject(ldw_modified[i].of_gettransobject())
//		for j = 1 to ll_delcnt
//			lds_deleted.reset()
//			lds_deleted.setchanges(ldw_modified[i].inv_link.iblb_deleted[j])
//			if lds_deleted.update(true, false) = -1 then
//				rollback using ldw_modified[i].of_gettransobject();
//				messagebox('[' + ldw_modified[i].of_gettitle() + '] 에러!!', '데이터를 저장하는 중 아래와 같은 오류가 발생했습니다.~r~n' + '~r~n* LINE = ' + string(lds_deleted.istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(lds_deleted.istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + lds_deleted.istr_dberror.sqlerrtext)
//				return failure
//			end if
//			lds_deleted.resetupdate()
//		next
//		destroy lds_deleted
//	end if

	if ldw_modified[i].update(true, false) = -1 then
		// Rollback Transactions
		for j = 1 to li_transcnt
			rollback using ltr_trans[j];
		next
		// Display the error message
		messagebox('[' + ldw_modified[i].of_gettitle() + '] 에러!!', '데이터를 저장하는 중 아래와 같은 오류가 발생했습니다.~r~n' + '~r~n* LINE = ' + string(ldw_modified[i].istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(ldw_modified[i].istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + ldw_modified[i].istr_dberror.sqlerrtext)
		this.of_setrunningaction('')
		return failure
	end if
next

// 저장 후 수행될 사용자 이벤트 호출
// 리턴값이 Failure(-1) 인 경우 Update된 내역을 Rollback 한다
for i = 1 to li_modifiedcnt
	if ldw_modified[i].event pfe_postupdate() = failure then
		for i = 1 to li_transcnt
			rollback using ltr_trans[i];
		next
		this.of_setrunningaction('')
		return failure
	end if
next

// Commit Transactions
for i = 1 to li_transcnt
	commit using ltr_trans[i];
next

// Update 내용 상위 Sync 데이터윈도우에 반영
pf_u_datawindow ldw_synced[]
integer li_synccnt
long ll_modified

if this.of_getrunningaction() <> 'deleterow' then
	li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
	for i = 2 to li_synccnt
		choose case ldw_synced[i].of_getpresentationstyle()
			case 'Freeform'
				ldw_synced[i].inv_link.of_copydownlinkeditemstouplinked(ldw_synced[1].getrow(), ldw_synced[i].getrow())
			case else
				ll_modified = ldw_synced[i].getnextmodified(0, primary!)
				do while ll_modified > 0
					ldw_synced[i].inv_link.of_copydownlinkeditemstouplinked(ll_modified, ll_modified)
					ll_modified = ldw_synced[i].getnextmodified(ll_modified, primary!)
				loop
		end choose
	next
end if

// Reset Update
this.of_resetupdate()

// 저장 완료 메시지를 Display 합니다
//if this.of_getrunningaction() = 'update' then
//	messagebox('알림', '저장 완료!')
//end if

// 저장 완료 메시지 표시
if left(iw_parent.dynamic of_getclassname(), 2) = 'w_' then
	iw_parent.dynamic of_setmessage('정상적으로 저장 되었습니다')
end if

this.of_setrunningaction('')
return success

end function

public function integer of_accepttext ();// 연계된 데이터윈도우에 AcceptText를 수행한다
// 리턴값: 성공=1, 실패=-1

if not isvalid(idw_target) then return no_action

integer li_synccnt, li_linkcnt
integer i, j
pf_u_datawindow ldw_synced[], ldw_dlink[]

li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)

for i = 1 to li_synccnt
	if ldw_synced[i].accepttext() = -1 then return failure
	
	li_linkcnt = ldw_synced[i].inv_link.of_getdownlinkeddatawindow(ldw_dlink)
	for j = 1 to li_linkcnt
		if ldw_dlink[j].accepttext() = -1 then return failure
	next
next

return success

end function

public function boolean of_checkmodified ();// 데이터윈도우 변경여부를 확인한다
// 리턴값: 변경사항있음=true, 변경사항 없음=false

if not isvalid(idw_target) then return false

integer li_synccnt, li_linkcnt
integer i, j
pf_u_datawindow ldw_synced[], ldw_dlink[]

li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
for i = 1 to li_synccnt
	if ldw_synced[i].of_isupdatable() = true then
		if ldw_synced[i].modifiedcount() + ldw_synced[i].deletedcount() > 0 or upperbound(ldw_synced[i].inv_link.iblb_deleted) > 0 then
			return true
		end if
	end if
	
	li_linkcnt = ldw_synced[i].inv_link.of_getdownlinkeddatawindow(ldw_dlink)
	for j = 1 to li_linkcnt
		if ldw_dlink[j].of_isupdatable() = true then
			if ldw_dlink[j].modifiedcount() + ldw_dlink[j].deletedcount() > 0 or upperbound(ldw_dlink[j].inv_link.iblb_deleted) > 0 then
				return true
			end if
		end if
	next
next

return false

end function

public function long of_retrieve ();// 등록된  데이터윈도우를 조회합니다
// 리턴값: 성공=데이터윈도우 조회 행 수, 실패=-1

pointer lt_pointer
long ll_rowcnt

if not isvalid(idw_target) then return failure

this.of_setrunningaction('retrieve')
//this.post of_setrunningaction('')

lt_pointer = setpointer(hourglass!)

// 연계된 데이터윈도우의 AcceptText를 수행합니다
if this.of_accepttext() = -1 then
	this.of_setrunningaction('')
	return failure
end if

// 연계된 데이터윈도우의 데이터 변경여부를 확인 합니다
if this.of_checkmodified() = true then
	choose case messagebox('[' + idw_target.of_gettitle() + '] 알림', '변경 내역이 저장되지 않았습니다.~r~n저장 후 조회 하시겠습니까?', Question!, YesNoCancel!, 3)
		case 1
			if this.of_update() = failure then
				this.of_setrunningaction('')
				return no_action
			end if
		case 2
			this.of_resetupdate()
		case 3
			this.of_setrunningaction('')
			return no_action
	end choose
end if
 
// 조회 후 RowFocuschanged 이벤트 호출
ll_rowcnt = this.of_retrieve(idw_target)
if  ll_rowcnt > 0 then
	idw_target.post event rowfocuschanged(1)
else
	idw_target.post event rowfocuschanged(0)
end if

if left(iw_parent.dynamic of_getclassname(), 2) = 'w_' then
	if ll_rowcnt > 0 then
		iw_parent.dynamic of_setmessage(string(ll_rowcnt, '#,##0') + ' 건의 자료가 조회 되었습니다')
	else
		iw_parent.dynamic of_setmessage('조회할 자료가 존재하지 않습니다')
	end if
end if

//// 연계된 데이터윈도우를 조회 합니다
//integer li_synccnt, li_linkcnt
//integer i, j
//pf_u_datawindow ldw_synced[], ldw_dlink[]
//blob lblb_empty[]
//
//li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
//for i = 1 to li_synccnt
//	
//	ll_rowcnt = this.of_retrieve(ldw_synced[i])
//	if ll_rowcnt = -1 then return failure
//	
//	li_linkcnt = ldw_synced[i].inv_link.of_getdownlinkeddatawindow(ldw_dlink)
//	for j = 1 to li_linkcnt
//		if ldw_synced[i].rowcount() = 0 then
//			ldw_dlink[j].reset()
//		else
//			this.of_retrieve(ldw_dlink[j])
//		end if
//		
//		if upperbound(ldw_dlink[j].inv_link.iblb_deleted) > 0 then
//			ldw_dlink[j].inv_link.iblb_deleted = lblb_empty
//		end if
//	next
//next

this.of_setrunningaction('')
setpointer(lt_pointer)
return idw_target.rowcount()

end function

public function integer of_resetupdate ();// UPDATE 내역을 리셋합니다
// 리턴값: success=성공, failure=실패

if not isvalid(idw_target) then return failure

pf_u_datawindow ldw_synced[], ldw_dlinked[]
integer li_linkcnt, li_synccnt, i, j
blob lblb_empty[]

// sync 연계 데이터 윈도우 reset
li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
for i = 1 to li_synccnt
	ldw_synced[i].resetupdate()
	if upperbound(ldw_synced[i].inv_link.iblb_deleted) > 0 then
		ldw_synced[i].inv_link.iblb_deleted = lblb_empty
	end if
	
	li_linkcnt = ldw_synced[i].inv_link.of_getdownlinkeddatawindow(ldw_dlinked)
	for j = 1 to li_linkcnt
		ldw_dlinked[j].resetupdate()
		if upperbound(ldw_dlinked[j].inv_link.iblb_deleted) > 0 then
			ldw_dlinked[j].inv_link.iblb_deleted = lblb_empty
		end if
	next
next

return success

end function

public function integer of_insertrow (long al_row);// 해당 데이터윈도우에 행을 추가합니다
// 리턴값: 성공=추가된 행번호, 실패=-1

if not isvalid(idw_target) then return failure

this.of_setrunningaction('insertrow')

long ll_new
integer i, j
pf_u_datawindow ldw_ulink

// 상위 데이터윈도우의 데이터가 존재하지 않으면 행추가 불가
ldw_ulink = idw_target.inv_link.of_getuplinkeddatawindow()
if isvalid(ldw_ulink) and idw_target.inv_link.of_getlinkagetype() <> 'syncable' then
	if idw_target.of_isupdatable() = true then
		if ldw_ulink.getrow() = 0 then
			messagebox('[' + idw_target.of_gettitle() + '] 알림', '상위 항목의 데이터가 존재하지 않습니다.~r~n먼저 [' + ldw_ulink.of_gettitle() + '] 의 데이터를 입력 하세요.')
			this.of_setrunningaction('')
			return no_action
		end if
	end if
end if

// 연계된 데이터윈도우의 AcceptText를 수행합니다
if this.of_accepttext() = -1 then
	this.of_setrunningaction('')
	return failure
end if

// 행추가 전 하위 연계된 데이터윈도우의 변경내역 확인
integer li_synccnt, li_linkcnt
pf_u_datawindow ldw_synced[], ldw_dlink[]
boolean lb_modified = false

li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
for i = 1 to li_synccnt
	li_linkcnt = ldw_synced[i].inv_link.of_getdownlinkeddatawindow(ldw_dlink)
	for j = 1 to li_linkcnt
		if ldw_dlink[j].of_isupdatable() = true then
			if ldw_dlink[j].modifiedcount() + ldw_dlink[j].deletedcount() > 0 then
				lb_modified = true
				exit
			end if
		end if
	next
	if lb_modified = true then exit
next

if lb_modified = true then
	choose case messagebox('[' + ldw_dlink[i].of_gettitle() + '] 알림', '변경 내역이 저장되지 않았습니다.~r~n저장 후 추가 하시겠습니까?', Question!, YesNoCancel!, 3)
		case 1
			if this.of_update() = failure then
				this.of_setrunningaction('')
				return no_action
			end if
		case 2
			this.of_resetupdate()
		case 3
			this.of_setrunningaction('')
			return no_action
	end choose
end if

// 행추가 전 수행될 사용자 이벤트 호출
for i = 1 to li_synccnt
	if ldw_synced[i].event pfe_preinsertrow() = failure then
		this.of_setrunningaction('')
		return failure
	end if
next

// 자체 데이터윈도우를 행추가 합니다
for i = 1 to li_synccnt
	ll_new = this.of_insertrow(ldw_synced[i], al_row)
	if ll_new = failure then
		this.of_setrunningaction('')
		return failure
	end if
	if ldw_synced[i].of_getpresentationstyle() = 'Freeform' then
		ldw_synced[i].getchanges(ldw_synced[i].inv_link.iblb_changes)
	end if
	
	li_linkcnt = ldw_synced[i].inv_link.of_getdownlinkeddatawindow(ldw_dlink)
	for j = 1 to li_linkcnt
		ldw_dlink[j].reset()
	next
next

//// 행추가 후 수행될 사용자 이벤트 호출
//for i = 1 to li_synccnt
//	if ldw_synced[i].event pfe_postinsertrow() = failure then return failure
//next

// SetFocus
idw_target.setfocus()

this.of_setrunningaction('')
return success

end function

public function long of_retrievedddw (string as_column);// DDDW 컬럼의 데이터를 조회합니다
// DDDW 컬럼의 Tag 값을 읽어서 아규먼트로 처리 합니다
// as_columnname: DDDW 컬럼명
// 리턴값: 조회된 데이터 행수

if not isvalid(idw_target) then return -1
if not isnumber(idw_target.describe(as_column + ".ID")) then return -1
if idw_target.describe(as_column + ".Edit.Style") <> "dddw" then return -1

datawindowchild ldwc_dddw

if idw_target.getchild(as_column, ldwc_dddw) = -1 then
	messagebox('[' + idw_target.dynamic of_gettitle() + '] 알림', '[' + as_column + '] DDDW 컬럼을 가져올 수 없습니다')
	return -1
end if

string ls_retarg
any la_args[]
integer li_argcnt
long ll_rowcnt
pf_n_argument lnv_args
transaction ltr_args

ls_retarg = idw_target.describe(as_column + ".Tag")
if ls_retarg = '!' or ls_retarg = '?' then return 0
if len(trim(ls_retarg)) = 0 then return 0
if pos(ls_retarg, '=') = 0 then return 0

ltr_args = idw_target.of_gettransobject()
if not isvalid(ltr_args) then
	messagebox('알림', '데이터윈도우에 트랜잭션이 할당되지 않았습니다')
	return -1
end if

ldwc_dddw.settransobject(ltr_args)

lnv_args = create pf_n_argument
lnv_args.of_initialize(ldwc_dddw, iw_parent, idw_target, as_column)

lnv_args.of_parsearguments(ls_retarg)
if lnv_args.of_checknotassignedargument() = failure then return failure
if lnv_args.of_getallargumentvalue(la_args) = failure then return failure
li_argcnt = upperbound(la_args)

choose case li_argcnt
	case 0
		ll_rowcnt = ldwc_dddw.retrieve()
	case 1
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1])
	case 2
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2])
	case 3
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3])
	case 4
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4])
	case 5
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5])
	case 6
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6])
	case 7
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7])
	case 8
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8])
	case 9
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9])
	case 10
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10])
	case 11
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11])
	case 12
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12])
	case 13
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13])
	case 14
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14])
	case 15
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15])
	case 16
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16])
	case 17
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17])
	case 18
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18])
	case 19
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19])
	case 20
		ll_rowcnt = ldwc_dddw.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20])
end choose

// 에러시 메시지 출력
if ll_rowcnt = -1 then
	messagebox('알림(' + string(ltr_args.sqldbcode) + ')', '[' + as_column + '] DDDW 조회를 수행하는 중 아래와 같은 오류가 발생했습니다~r~n' + ltr_args.sqlerrtext)
end if

// 행추가 TAG 처리
if match(ls_retarg, 'dddwinsertrow *= *yes') or match(ls_retarg, 'dddwinsertrow *= *true') then
	string ls_displaycolumn, ls_datacolumn

	ls_datacolumn = idw_target.describe(as_column + '.DDDW.DataColumn')
	if ls_datacolumn = '!' or ls_datacolumn = '?' or ls_datacolumn = '' then return -1
	
	ls_displaycolumn = idw_target.describe(as_column + '.DDDW.DisplayColumn')
	if ls_displaycolumn = '!' or ls_displaycolumn = '?' or ls_displaycolumn = '' then return -1
	
	ldwc_dddw.insertrow(1)
	ldwc_dddw.setitem(1, ls_datacolumn, '%')
	ldwc_dddw.setitem(1, ls_displaycolumn, 'ALL')
end if

// Set AutoRetrieve=False
idw_target.modify(as_column + ".DDDW.AutoRetrieve='no'")
if long(idw_target.describe(as_column + ".DDDW.Lines")) = 0 then
	idw_target.modify(as_column + ".DDDW.Lines=10")
end if

return ll_rowcnt

end function

public function integer of_retrievedddw ();//  모든 DDDW 컬럼의 데이터를 조회합니다
// 리턴값: 1=성공, -1=실패

if not isvalid(idw_target) then return -1

integer li_colcnt, i
string ls_column

li_colcnt = long(idw_target.describe("Datawindow.Column.Count"))
for i = 1 to li_colcnt
	ls_column = idw_target.describe("#" + string(i) + ".Name")
	if idw_target.describe(ls_column + ".Edit.Style") <> "dddw" then continue
	if this.of_retrievedddw(ls_column) = -1 then
		return -1
	end if
next

return 1

end function

public function string of_getrunningaction ();return is_runningaction

end function

public subroutine of_setrunningaction (string as_action);if is_runningaction = '' or as_action = '' then
	is_runningaction = as_action
end if

end subroutine

public function long of_retrieve (datawindow adw_target);// adw_target 데이터윈도우를 개별 조회 합니다
// adw_target: 조회할 데이터윈도우 레퍼런스
// 리턴값: 성공=조회된 데이터 건수, 실패=-1

pf_u_datawindow ldw_target

if isnull(adw_target) then return failure
if not isvalid(adw_target) then return failure

ldw_target = adw_target
ldw_target.inv_action.of_setrunningaction('retrieve')
//ldw_target.inv_action.post of_setrunningaction('')

any la_args[], la_empty[]
long ll_rowcnt

// 조회 전 사용자 이벤트 수행
if ldw_target.event pfe_preretrieve() = failure then
	ldw_target.inv_action.of_setrunningaction('')
	return failure
end if

if isvalid(ldw_target.inv_args) then
	// 아직 할당되지않은 아규먼트가 있는지 확인합니다
	if ldw_target.inv_args.of_checknotassignedargument() = failure then
		ldw_target.inv_action.of_setrunningaction('')
		return failure
	end if

	// 아규먼트 값들을 산출 합니다
	la_args = la_empty
	if ldw_target.inv_args.of_getallargumentvalue(la_args) = failure then
		ldw_target.inv_action.of_setrunningaction('')
		return failure
	end if
end if

// 조회 전 데이터윈도우 리셋
ldw_target.reset()

// 데이터를 조회합니다
long ll_currentrow

ll_currentrow = ldw_target.getrow()
choose case upperbound(la_args)
	case 0
		ll_rowcnt = ldw_target.retrieve()
	case 1
		ll_rowcnt = ldw_target.retrieve(la_args[1])
	case 2
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2])
	case 3
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3])
	case 4
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4])
	case 5
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5])
	case 6
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6])
	case 7
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7])
	case 8
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8])
	case 9
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9])
	case 10
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10])
	case 11
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11])
	case 12
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12])
	case 13
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13])
	case 14
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14])
	case 15
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15])
	case 16
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16])
	case 17
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17])
	case 18
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18])
	case 19
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19])
	case 20
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20])
	case 21
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21])
	case 22
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22])
	case 23
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23])
	case 24
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24])
	case 25
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25])
	case 26
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26])
	case 27
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27])
	case 28
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28])
	case 29
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29])
	case 30
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30])
	case 31
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31])
	case 32
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32])
	case 33
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33])
	case 34
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34])
	case 35
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35])
	case 36
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36])
	case 37
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37])
	case 38
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38])
	case 39
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39])
	case 40
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40])
	case 41
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41])
	case 42
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42])
	case 43
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43])
	case 44
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44])
	case 45
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44], la_args[45])
	case 46
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44], la_args[45], la_args[46])
	case 47
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44], la_args[45], la_args[46], la_args[47])
	case 48
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44], la_args[45], la_args[46], la_args[47], la_args[48])
	case 49
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44], la_args[45], la_args[46], la_args[47], la_args[48], la_args[49])
	case 50
		ll_rowcnt = ldw_target.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44], la_args[45], la_args[46], la_args[47], la_args[48], la_args[49], la_args[50])
end choose

// 에러시 메시지 출력
if ll_rowcnt = -1 then
	messagebox('알림(DBCode=' + string(ldw_target.dynamic of_getlasterrorcode()) + ')', '조회를 수행하는 중 아래와 같은 오류가 발생했습니다~r~n' + string(ldw_target.dynamic of_getlasterrortext()))
	ldw_target.inv_action.of_setrunningaction('')
	return failure
end if

// 조회후 사용자 이벤트 수행
ldw_target.event pfe_postretrieve(ll_rowcnt)

// 조회된 행 수 보관
il_RowsRetrieved = ll_rowcnt

//// RowFocusChanged 이벤트 수행
//if ll_currentrow = 1 and ldw_target.getrow() = 1 then
//	ldw_target.event rowfocuschanged(1)
//end if

ldw_target.inv_action.of_setrunningaction('')
return ll_rowcnt

end function

public function integer of_insertrow (ref datawindow adw_target, long al_row);// adw_target 데이터윈도우에 행을 추가합니다(단일 데이터윈도우)
// 리턴값: 성공=추가된 행번호, 실패=-1

if isnull(adw_target) then return failure
if not isvalid(adw_target) then return failure

long ll_new
string ls_keyset[]
integer li_keycnt, i
pf_u_datawindow ldw_target

ldw_target = adw_target
ldw_target.inv_action.of_setrunningaction('insertrow')

// 행추가 전 실행할 데이터윈도우 이벤트 호출
//if ldw_target.event pfe_preinsertrow() = failure then return failure

// 프리폼 스타일의 경우 행추가 전 데이터윈도우 리셋
if ldw_target.of_getpresentationstyle() = 'Freeform' then
	ldw_target.reset()
else
	if al_row = 0 then
		if ib_InsertRowOnTop = true then
			al_row = 1
		end if
	end if
end if

// 데이터윈도우 행 추가
ll_new = ldw_target.insertrow(al_row)

//// 행추가 후 기본값을 설정합니다(INSERTROW 시 자동 처리로 변경됨)
//if isvalid(ldw_target.inv_defaultvalue) then
//	li_keycnt = ldw_target.inv_defaultvalue.inv_initvalues.of_keyset(ls_keyset)
//	for i = 1 to li_keycnt
//		ldw_target.inv_defaultvalue.of_setdefaultvalue(ll_new, ls_keyset[i])
//	next
//end if

// 행추가 후 실행할 데이터윈도우 이벤트 호출
ldw_target.event pfe_postinsertrow(ll_new)

// 추가한 행으로 Focus 변경
ldw_target.scrolltorow(ll_new)
if ldw_target.of_getpresentationstyle() <> 'Freeform' then
	if idw_target.dynamic of_getservicepropertyvalue('SingleRowSelection') = true or &
		idw_target.dynamic of_getservicepropertyvalue('MultiRowSelection') = true then
		ldw_target.selectrow(0, false)
		ldw_target.selectrow(ll_new, true)
	end if
end if

ldw_target.inv_action.of_setrunningaction('')
return ll_new

end function

public function integer of_deleterow (ref datawindow adw_target, long al_row);// adw_target 데이터윈도우의 al_row 행을 삭제합니다
// adw_target : 행삭제를 수행할 데이터윈도우 레퍼런스
// al_row: 삭제할 행
// 리턴값: 성공=1, 실패=-1

if not isvalid(idw_target) then return failure
if not isvalid(adw_target) then return failure

pf_u_datawindow ldw_target
long ll_rc

ldw_target = adw_target
ldw_target.inv_action.of_setrunningaction('deleterow')

// 행삭제 수행
ll_rc = ldw_target.deleterow(al_row)

ldw_target.inv_action.of_setrunningaction('')
return ll_rc

end function

public function integer of_deleterow (long al_row);// 해당 데이터윈도우의 현재행을 삭제합니다
// 리턴값: 성공=1, 실패=-1

if not isvalid(idw_target) then return failure

this.of_setrunningaction('deleterow')

// 하위 데이터위도우의 데이터가 존재하면 행삭제 불가
integer li_synccnt, li_linkcnt, i, j
pf_u_datawindow ldw_synced[], ldw_dlink[]
long ll_row, ll_rc

li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
for i = 1 to li_synccnt
	li_linkcnt = ldw_synced[i].inv_link.of_getdownlinkeddatawindow(ldw_dlink)
	for j = 1 to li_linkcnt
		if ldw_dlink[j].rowcount() > 0 then
			messagebox('[' + idw_target.of_gettitle() + '] 알림', '[' + ldw_dlink[j].of_gettitle() + '] 에 데이터가 존재하기 때문에 삭제할 수 없습니다.~r~n먼저 [' + ldw_dlink[j].of_gettitle() + '] 데이터를 삭제 후 다시 시도하세요.')
			this.of_setrunningaction('')
			return failure
		end if
	next
next

// 삭제할 행이 없으면 리턴
ll_row = idw_target.getrow()
if ll_row = 0 then
	messagebox('알림', '삭제할 데이터가 없습니다')
	this.of_setrunningaction('')
	return no_action
end if

// 행삭제 사용자 확인
choose case idw_target.getitemstatus(ll_row, 0, primary!)
	case new!, newmodified!
		ll_rc = 1
	case datamodified!, notmodified!
		ll_rc = messagebox('알림', '선택된 데이터를 삭제 하시겠습니까?', Question!, YesNo!, 2)
end choose

if ll_rc = 2 then
	this.of_setrunningaction('')
	return no_action
end if

// 행삭제 전 실행할 데이터윈도우 이벤트 호출
for i = li_synccnt to 1 step -1
	if ldw_synced[i].event pfe_predeleterow() = failure then
		this.of_setrunningaction('')
		return failure
	end if
next

// 연계된 Sync 데이터윈도우를 DeleteRow 처리 합니다
for i = li_synccnt to 1 step -1
	choose case ldw_synced[i].of_getpresentationstyle()
		case 'Freeform'
			if this.of_deleterow(ldw_synced[i], 0) = failure then
				this.of_setrunningaction('')
				return failure
			end if
		case else
			if this.of_deleterow(ldw_synced[i], al_row) = failure then
				this.of_setrunningaction('')
				return failure
			end if
	end choose
		
	if idw_target <> ldw_synced[i] then
		if ldw_synced[i].deletedcount() > 0 then
			ldw_synced[i].rowsdiscard(ldw_synced[i].deletedcount(), ldw_synced[i].deletedcount(), delete!)
		end if
	end if
next

// 변경내역 저장
for i = li_synccnt to 1 step -1
	if ldw_synced[i].of_isupdatable() = true then
		ll_rc = ldw_synced[i].update(true, false)
		if ll_rc = 1 then
			commit using ldw_synced[i].of_gettransobject();
			ldw_synced[i].resetupdate();
		else
			rollback using ldw_synced[i].of_gettransobject();
			messagebox('[' + ldw_synced[i].of_gettitle() + '] 에러!!', '데이터를 저장하는 중 아래와 같은 오류가 발생했습니다.~r~n' + '~r~n* LINE = ' + string(ldw_synced[i].istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(ldw_synced[i].istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + ldw_synced[i].istr_dberror.sqlerrtext)
			this.of_setrunningaction('')
			return failure
		end if	
	end if
next

// 행삭제 후 실행할 데이터윈도우 이벤트 호출
for i = li_synccnt to 1 step -1
	ldw_synced[i].event pfe_postdeleterow(al_row)
next

// 삭제 완료 메시지 표시
if left(iw_parent.dynamic of_getclassname(), 2) = 'w_' then
	iw_parent.dynamic of_setmessage('정상적으로 삭제 되었습니다')
end if

// RowFocusChanged
for i = 1 to li_synccnt
	choose case ldw_synced[i].of_getpresentationstyle()
		case 'Grid', 'Tabular'
			ll_row = ldw_synced[i].getrow()
			ldw_synced[i].post event rowfocuschanged(ll_row)
	end choose
next

this.of_setrunningaction('')
return success

end function

public function integer of_deleterow_multi ();// 해당 데이터윈도우의 다중 선택된 행을 삭제합니다
// 리턴값: 성공=1, 실패=-1

if not isvalid(idw_target) then return failure

// 연계된 데이터위도우가 존재하면 행삭제 불가
integer li_synccnt, li_linkcnt, i
pf_u_datawindow ldw_synced[], ldw_dlink[]
long ll_row, ll_rc

li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
if li_synccnt > 1 then
	messagebox('[' + idw_target.of_gettitle() + '] 알림', 'Sync 연계된 데이터윈도우가 존재하는 경우는 일괄 삭제할 수 없습니다.')
	return failure
end if

li_linkcnt = idw_target.inv_link.of_getdownlinkeddatawindow(ldw_dlink)
if li_linkcnt > 0 then
	messagebox('[' + idw_target.of_gettitle() + '] 알림', '하위 연계된 데이터윈도우가 존재하는 경우는 일괄 삭제할 수 없습니다.')
	return failure
end if

// 선택된 행이 없으면 리턴
long ll_selectedcnt, ll_selectedrow[]

ll_row = idw_target.getselectedrow(0)
do while ll_row > 0
	ll_selectedcnt ++
	ll_selectedrow[ll_selectedcnt] = ll_row
	ll_row = idw_target.getselectedrow(ll_row)
loop

if ll_selectedcnt = 0 then
	messagebox('알림', '선택된 행이 없습니다')
	return no_action
end if

// 행삭제 사용자 확인
ll_rc = messagebox('알림', '선택된 데이터를 삭제 하시겠습니까?', Question!, YesNo!, 2)
if ll_rc = 2 then return no_action

// 데이터윈도우를 DeleteRow 처리 합니다
for i = ll_selectedcnt to 1 step -1
	if this.of_deleterow(idw_target, ll_selectedrow[i]) = failure then return failure
next

// 변경내역 저장
if idw_target.of_isupdatable() = true then
	if idw_target.deletedcount() > 0 then
		ll_rc = idw_target.update(true, false)
		if ll_rc = 1 then
			commit using idw_target.of_gettransobject();
			idw_target.resetupdate()
		else
			rollback using idw_target.of_gettransobject();
			messagebox('[' + idw_target.of_gettitle() + '] 에러!!', '데이터를 저장하는 중 아래와 같은 오류가 발생했습니다.~r~n' + '~r~n* LINE = ' + string(idw_target.istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(idw_target.istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + idw_target.istr_dberror.sqlerrtext)
			return failure
		end if
	end if
end if

// RowFocusChanged 이벤트 호출
ll_row = idw_target.getrow()
idw_target.post event rowfocuschanged(ll_row)

// 저장 완료 메시지 표시
if left(iw_parent.dynamic of_getclassname(), 2) = 'w_' then
	iw_parent.dynamic of_setmessage('정상적으로 저장 되었습니다')
end if

return success

end function

public function integer of_gettransobject (readonly datawindow adw_target[], ref transaction atr_result[]);// 함수설명
//   데이터윈도우의 트랜젝션 오브젝트를 구합니다
// 파라미터
//   adw_target[] : 할당된 트랜젝션을 구할 데이터윈도우
//   atr_result[] : 데이터윈도우들이 갖는 트랜젝션 오브젝트를 담을 레퍼런스 변수
// 결과값
//   트랜젝션 오브젝트 갯수

transaction ltr_comp
boolean lb_equaltrans
integer li_dwcnt, li_transcnt, i, j

li_dwcnt = upperbound(adw_target)
for i = 1 to li_dwcnt
	lb_equaltrans = false
	ltr_comp = adw_target[i].dynamic of_gettransobject()
	
	for j = 1 to li_transcnt
		if ltr_comp = atr_result[j] then
			lb_equaltrans = true
			exit
		end if
	next
	
	if lb_equaltrans = false then
		li_transcnt ++
		atr_result[li_transcnt] = ltr_comp
	end if
next

return li_transcnt

end function

public subroutine of_initialize (datawindow adw_target, window awo_parent);// 조회 서비스를 초기화하는 함수
// aw_window: 조회 서비스를 제공할 윈도우 오브젝트
// 리턴값: 없음

// 부모 데이터윈도우 등록
if not isvalid(adw_target) then
	messagebox('알림', '올바르지 않은 함수호출 입니다.~r~npf_n_crudservice.of_initialize()')
	return
end if

idw_target = adw_target
iw_parent = awo_parent

return

end subroutine

public function integer of_getmodified (ref datawindow adw_modified[]);// 연계된 데이터윈도우 중 변경 또는 삭제된 내역이 있는 데이터윈도우를 구합니다
// adw_modified[]: 변경사항이 존재하는 데이터윈도우 레퍼런스를 저장할 변수(배열)
// 리턴값: 변경사항이 존재하는 데이터윈도우 갯수

if not isvalid(idw_target) then return 0

integer li_synccnt, li_linkcnt, li_modcnt
integer i, j
pf_u_datawindow ldw_synced[], ldw_dlink[], ldw_modified[]

li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
for i = 1 to li_synccnt
	if ldw_synced[i].of_isupdatable() = true then
		if ldw_synced[i].modifiedcount() + ldw_synced[i].deletedcount() > 0 or upperbound(ldw_synced[i].inv_link.iblb_deleted) > 0 then
			li_modcnt ++
			ldw_modified[li_modcnt] = ldw_synced[i]
		end if
	end if
	
	li_linkcnt = ldw_synced[i].inv_link.of_getdownlinkeddatawindow(ldw_dlink)
	for j = 1 to li_linkcnt
		if ldw_dlink[j].of_isupdatable() = true then
			if ldw_dlink[j].modifiedcount() + ldw_dlink[j].deletedcount() > 0 or upperbound(ldw_dlink[j].inv_link.iblb_deleted) > 0 then
				li_modcnt ++
				ldw_modified[li_modcnt] = ldw_dlink[j]
			end if
		end if
	next
next

adw_modified = ldw_modified
return li_modcnt

end function

public function integer of_commitupdate ();// 데이터 변경사항을 저장 후 COMMIT 합니다
// 리턴값: 성공=1, 실패=-1

if not isvalid(idw_target) then return no_action

this.of_setrunningaction('update')

// AcceptText 수행
if this.of_accepttext() = failure then 
	this.of_setrunningaction('')
	return failure
end if

// 변경사항이 존재하는 데이터윈도우를 구합니다
integer li_modifiedcnt
pf_u_datawindow ldw_modified[]

li_modifiedcnt = this.of_getmodified(ldw_modified)
if li_modifiedcnt = 0 then
	messagebox('[' + idw_target.of_gettitle() + '] 알림', '저장할 내용이 없습니다')
	this.of_setrunningaction('')
	return failure
end if

// 변경사항이 존재하는 데이터윈도우의 트랜젝션 오브젝트를 구합니다
transaction ltr_trans[]
integer li_transcnt, i, j

li_transcnt = this.of_gettransobject(ldw_modified, ltr_trans)

// 저장 전 수행될 사용자 이벤트 호출
for i = 1 to li_modifiedcnt
	if ldw_modified[i].event pfe_preupdate() = failure then
		this.of_setrunningaction('')
		return failure
	end if
next

// 필수 입력 항목 체크
for i = 1 to li_modifiedcnt
	if isvalid(ldw_modified[i].inv_required) then
		if ldw_modified[i].inv_required.of_checkrequiredcolumn() > 0 then
			this.of_setrunningaction('')
			return failure
		end if
	end if
next

// 참고) Foreign Key 가 구현된 테이블 구조의 경우
// UPDATE시 삭제내역만 별도로 역순으로 저장해야 함

// UPDATE 수행
pf_n_datastore lds_deleted
long ll_delcnt

for i = 1 to li_modifiedcnt
	// 삭제 버퍼 기능 안 씀.
//	ll_delcnt = upperbound(ldw_modified[i].inv_link.iblb_deleted)
//	if ll_delcnt > 0 then
//		lds_deleted = create pf_n_datastore
//		lds_deleted.dataobject = ldw_modified[i].dataobject
//		lds_deleted.settransobject(ldw_modified[i].of_gettransobject())
//		for j = 1 to ll_delcnt
//			lds_deleted.reset()
//			lds_deleted.setchanges(ldw_modified[i].inv_link.iblb_deleted[j])
//			if lds_deleted.update(true, false) = -1 then
//				rollback using ldw_modified[i].of_gettransobject();
//				messagebox('[' + ldw_modified[i].of_gettitle() + '] 에러!!', '데이터를 저장하는 중 아래와 같은 오류가 발생했습니다.~r~n' + '~r~n* LINE = ' + string(lds_deleted.istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(lds_deleted.istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + lds_deleted.istr_dberror.sqlerrtext)
//				return failure
//			end if
//			lds_deleted.resetupdate()
//		next
//		destroy lds_deleted
//	end if

	if ldw_modified[i].update(true, false) = -1 then
		// Rollback Transactions
		for j = 1 to li_transcnt
			rollback using ltr_trans[j];
		next
		// Display the error message
		messagebox('[' + ldw_modified[i].of_gettitle() + '] 에러!!', '데이터를 저장하는 중 아래와 같은 오류가 발생했습니다.~r~n' + '~r~n* LINE = ' + string(ldw_modified[i].istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(ldw_modified[i].istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + ldw_modified[i].istr_dberror.sqlerrtext)
		this.of_setrunningaction('')
		return failure
	end if
next

// Commit Transactions
for i = 1 to li_transcnt
	commit using ltr_trans[i];
	if ltr_trans[i].sqlcode <> 0 then
		messagebox('[' + ldw_modified[i].of_gettitle() + '] Commit 에러!!', '데이터를 저장하는 중 아래와 같은 오류가 발생했습니다.~r~n' + '~r~n* LINE = ' + string(ldw_modified[i].istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(ldw_modified[i].istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + ldw_modified[i].istr_dberror.sqlerrtext)
		this.of_setrunningaction('')
		return failure
	end if
next

// Update 내용 상위 Sync 데이터윈도우에 반영
pf_u_datawindow ldw_synced[]
integer li_synccnt
long ll_modified

if this.of_getrunningaction() <> 'deleterow' then
	li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
	for i = 2 to li_synccnt
		choose case ldw_synced[i].of_getpresentationstyle()
			case 'Freeform'
				ldw_synced[i].inv_link.of_copydownlinkeditemstouplinked(ldw_synced[1].getrow(), ldw_synced[i].getrow())
			case else
				ll_modified = ldw_synced[i].getnextmodified(0, primary!)
				do while ll_modified > 0
					ldw_synced[i].inv_link.of_copydownlinkeditemstouplinked(ll_modified, ll_modified)
					ll_modified = ldw_synced[i].getnextmodified(ll_modified, primary!)
				loop
		end choose
	next
end if

// Reset Update
this.of_resetupdate()

// 저장 후 수행될 사용자 이벤트 호출
for i = 1 to li_modifiedcnt
	if ldw_modified[i].event pfe_postupdate() = failure then
		this.of_setrunningaction('')
		return failure
	end if
next

// 저장 완료 메시지를 Display 합니다
//if this.of_getrunningaction() = 'update' then
//	messagebox('알림', '저장 완료!')
//end if

// 저장 완료 메시지 표시
if left(iw_parent.dynamic of_getclassname(), 2) = 'w_' then
	iw_parent.dynamic of_setmessage('정상적으로 저장 되었습니다')
end if

this.of_setrunningaction('')
return success

end function

public function long of_datawindowaction (string as_action);// 데이터윈도우 CRUD 서비스 기능을 호출합니다
// as_function: 호출할 서비스 명
// 리턴값: success=성공, failure=실패

long ll_rc
string ls_filename

if isnull(as_action) then return no_action

choose case lower(as_action)
	case 'retrieve'
		ll_rc = this.of_retrieve()
	case 'insert', 'insertrow'
		ll_rc = this.of_insertrow(0)
	case 'delete', 'deleterow'
		if idw_target.multirowselection = true then
			ll_rc = this.of_deleterow_multi()
		else
			ll_rc = this.of_deleterow(0)
		end if
	case 'logicaldelete'
		ll_rc = this.of_logicaldelete(0)
	case 'update'
		ll_rc = this.of_update()
	case 'updatecommit', 'commitupdate'
		ll_rc = this.of_commitupdate()
	case 'print'
		ll_rc = this.of_print()
	case 'excel'
		ls_filename = this.of_excel()
		if len(ls_filename) > 0 then
			ll_rc = success
		else
			ll_rc = no_action
		end if
	case else
		messagebox('[' + idw_target.of_gettitle() + '] 알림', '[' + as_action + '] 은(는) 잘못된 데이터윈도우 액션입니다')
		return no_action
end choose

return ll_rc

end function

public function long of_print ();// 출력용 미리보기 창을 보여줍니다

if not isvalid(idw_target) then return failure

integer li_rc

this.of_setrunningaction('print')

// PrePrint Event 수행
li_rc = idw_target.event pfe_preprint()
if li_rc <> success then
	this.of_setrunningaction('')
	return li_rc
end if

openwithparm(pf_w_printpreview, idw_target)

// PostPrint Event 수행
idw_target.event pfe_postprint()

this.of_setrunningaction('')
return success

end function

public function integer of_logicaldelete (long al_row);
//// 해당 데이터윈도우의 현재행을 논리 삭제합니다
//// 리턴값: 성공=1, 실패=-1
//
//if not isvalid(idw_target) then return failure
//
//this.of_setrunningaction('deleterow')
//this.post of_setrunningaction('')
//
//// 삭제할 행이 없으면 리턴
//long ll_row
//
//if al_row = 0 then
//	ll_row = idw_target.getrow()
//else
//	ll_row = al_row
//end if
//
//if 1 > ll_row or idw_target.rowcount() < ll_row then
//	messagebox('알림', '삭제할 데이터가 없습니다')
//	return no_action
//end if
//
//// 하위 데이터위도우의 데이터가 존재하면 행삭제 불가
//integer li_synccnt, li_linkcnt, i, j
//pf_u_datawindow ldw_synced[], ldw_dlink[]
//long ll_rc
//
//li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
//for i = 1 to li_synccnt
//	li_linkcnt = ldw_synced[i].inv_link.of_getdownlinkeddatawindow(ldw_dlink)
//	for j = 1 to li_linkcnt
//		if ldw_dlink[j].rowcount() > 0 then
//			messagebox('[' + idw_target.of_gettitle() + '] 알림', '[' + ldw_dlink[j].of_gettitle() + '] 에 데이터가 존재하기 때문에 삭제할 수 없습니다.~r~n먼저 [' + ldw_dlink[j].of_gettitle() + '] 데이터를 삭제 후 다시 시도하세요.')
//			return failure
//		end if
//	next
//next
//
//// 행삭제 사용자 확인
//choose case idw_target.getitemstatus(ll_row, 0, primary!)
//	case new!, newmodified!
//		ll_rc = 1
//	case datamodified!, notmodified!
//		ll_rc = messagebox('알림', '선택된 데이터를 삭제 하시겠습니까?', Question!, YesNo!, 2)
//end choose
//
//if ll_rc = 2 then return no_action
//
//// 행삭제 전 실행할 데이터윈도우 이벤트 호출
//for i = li_synccnt to 1 step -1
//	if ldw_synced[i].event pfe_predeleterow() = failure then return failure
//next
//
//// 연계된 Sync 데이터윈도우를 논리 삭제 처리 합니다
//string ls_colname
//str_parm lstr_parm
//transaction ltr_sql
//datetime ldtm_now
//string ls_delreason
//
//pf_n_datastore lds_deltemp
//lds_deltemp = create pf_n_datastore
//
//for i = li_synccnt to 1 step -1
//	if idw_target = ldw_synced[i] then
//		//messagebox('idw_target', idw_target.classname())
//
//		choose case idw_target.getitemstatus(ll_row, 0, primary!)
//			case new!, newmodified!
//				idw_target.deleterow(ll_row)
//			case else
//				ltr_sql = idw_target.of_gettransobject()
//				if not isvalid(ltr_sql) then
//					messagebox('알림', 'Transaction Object가 올바로 설정되지 않았습니다')
//					return failure
//				end if
//				
//				lds_deltemp.dataobject = idw_target.dataobject
//				lds_deltemp.settransobject(ltr_sql)
//				
//				// del_reason 설정
//				ls_colname = lds_deltemp.of_getcolumnnamebydbname('del_reason', true)
//				if len(ls_colname) > 0 then
//					lstr_parm.astring[1] = gnv_session.is_user_id
//					lstr_parm.astring[2] = gnv_session.is_user_name
//					
//					openwithparm(w_com_delete_reason_input, lstr_parm)
//					lstr_parm = message.powerobjectparm
//					if isvalid(lstr_parm) then
//						if lstr_parm.astring[1] = 'Y' then
//							if len(lstr_parm.astring[3]) > 0 then
//								ls_delreason = lstr_parm.astring[3]
//							end if
//						else
//							messagebox('알림', '삭제사유 입력 취소로 삭제를 중단합니다.')
//							return no_action
//						end if
//					else
//						messagebox('알림', '삭제사유 입력 취소로 삭제를 중단합니다.')
//						return no_action
//					end if
//				end if
//				
//				//idw_target.rowsmove(ll_row, ll_row, primary!, lds_deltemp, 1, primary!)
//				idw_target.rowscopy(ll_row, ll_row, primary!, lds_deltemp, 1, primary!)
//				lds_deltemp.resetupdate()
//				lds_deltemp.modify("datawindow.table.updatekeyinplace=yes")
//				lds_deltemp.modify("datawindow.table.updatewhere=0")
//				
//				// del_yn 설정
//				ls_colname = lds_deltemp.of_getcolumnnamebydbname('del_yn', true)
//				if len(ls_colname) > 0 then
//					lds_deltemp.setitem(lds_deltemp.rowcount(), ls_colname, 'Y')
//				else
//					messagebox('알림', 'DEL_YN 컬럼을 찾을 수 없어 삭제를 중단합니다.')
//					return failure
//				end if
//				
//				ldtm_now = pf_f_getdbmsdatetime()
//				
//				// del_dtime 설정
//				ls_colname = lds_deltemp.of_getcolumnnamebydbname('del_dtime', true)
//				if len(ls_colname) > 0 then
//					lds_deltemp.setitem(lds_deltemp.rowcount(), ls_colname, ldtm_now)
//				end if
//				
//				// mod_dtime 설정
//				ls_colname = lds_deltemp.of_getcolumnnamebydbname('mod_dtime', true)
//				if len(ls_colname) > 0 then
//					lds_deltemp.setitem(lds_deltemp.rowcount(), ls_colname, ldtm_now)
//				end if
//				
//				// mod_empno 설정
//				ls_colname = lds_deltemp.of_getcolumnnamebydbname('mod_empno', true)
//				if len(ls_colname) > 0 then
//					lds_deltemp.setitem(lds_deltemp.rowcount(), ls_colname, gnv_session.is_user_id)
//				end if
//				
//				// mod_ip 설정
//				ls_colname = lds_deltemp.of_getcolumnnamebydbname('mod_ip', true)
//				if len(ls_colname) > 0 then
//					lds_deltemp.setitem(lds_deltemp.rowcount(), ls_colname, gnv_appmgr.is_ipaddress)
//				end if
//				
//				// del_reason 설정
//				ls_colname = lds_deltemp.of_getcolumnnamebydbname('del_reason', true)
//				if len(ls_delreason) > 0 then
//					lds_deltemp.setitem(lds_deltemp.rowcount(), ls_colname, lstr_parm.astring[3])
//				end if
//				
//				if lds_deltemp.update() = -1 then
//					rollback using ltr_sql;
//					messagebox('알 림', '논리 삭제를 수행하는 중 오류가 발생했습니다:~r~n' + ltr_sql.SQLErrText)
//					return failure
//				end if
//				
//				if ltr_sql.sqlnrows = 0 then
//					messagebox('알 림', '데이터베이스에 삭제할 자료를 찾을 수 없습니다')
//					return failure
//				end if
//				
//				idw_target.post rowsmove(ll_row, ll_row, primary!, lds_deltemp, 1, primary!)
//				commit using ltr_sql;
//		end choose
//	else
//		ldw_synced[i].deleterow(0)
//		if ldw_synced[i].deletedcount() > 0 then
//			ldw_synced[i].rowsdiscard(ldw_synced[i].deletedcount(), ldw_synced[i].deletedcount(), delete!)
//		end if
//	end if
//next
//
//// 행삭제 후 실행할 데이터윈도우 이벤트 호출
//for i = li_synccnt to 1 step -1
//	ldw_synced[i].event pfe_postdeleterow(al_row)
//next
//
//// 삭제 완료 메시지 표시
//if left(iw_parent.dynamic of_getclassname(), 2) = 'w_' then
//	iw_parent.dynamic of_setmessage('정상적으로 삭제 되었습니다')
//end if
//
//// RowFocusChanged
//for i = 1 to li_synccnt
//	if idw_target = ldw_synced[i] then
//		choose case ldw_synced[i].of_getpresentationstyle()
//			case 'Grid', 'Tabular'
//				ll_row = ldw_synced[i].getrow()
//				ldw_synced[i].post event rowfocuschanged(ll_row)
//		end choose
//	end if
//next

return success

end function

public subroutine of_setnewrowdirection (string as_direction);// InsertRow 가 실행될 때 행추가할 방향을 설정 합니다
// upper = 데이터윈도우 상단에 행추가
// lower = 데이터윈도우 하단에 행추가

choose case lower(as_direction)
	case 'upper'
		ib_InsertRowOnTop = true
	case 'lower'
		ib_InsertRowOnTop = false
end choose

end subroutine

on pf_n_dwaction.create
call super::create
end on

on pf_n_dwaction.destroy
call super::destroy
end on

