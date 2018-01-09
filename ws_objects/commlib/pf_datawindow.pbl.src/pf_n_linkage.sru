$PBExportHeader$pf_n_linkage.sru
$PBExportComments$데이터윈도우 액션 서비스와 관계되어 데이터윈도우 간의 연계 관계를 담당하는 오브젝트 입니다.
forward
global type pf_n_linkage from pf_n_nonvisualobject
end type
end forward

global type pf_n_linkage from pf_n_nonvisualobject
end type
global pf_n_linkage pf_n_linkage

type variables
protected:
	pf_u_datawindow idw_target
	window iw_parent

public:
	pf_n_hashtable inv_cols
	pf_u_datawindow idw_uplinked
	pf_u_datawindow idw_downlinked[]
	string is_linkagetype
	blob iblb_changes
	blob iblb_deleted[]

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_setuplinkeddatawindow (string as_uplinkeddw)
public function datawindow of_getuplinkeddatawindow ()
public function integer of_checkifbothareusingthesametable (datawindow adw_uplinked)
public function integer of_copydownlinkeditemstouplinked (long al_ul_row, long al_dl_row)
public function string of_getlinkagetype ()
public subroutine of_setlinkagetype (string as_linkagetype)
public function datawindow of_getrootdatawindow ()
public function integer of_getsynceddatawindow (ref datawindow adw_syncable[])
public subroutine of_initialize (datawindow adw_datawindow, window aw_parent)
public function integer of_getdownlinkeddatawindow (ref pf_u_datawindow adw_linked[])
public function integer of_getdownlinkeddatawindow (readonly pf_u_datawindow adw_basenode, ref pf_u_datawindow adw_linked[])
public function integer of_setdownlinkeddatawindow (ref string as_linkeddw)
public function integer of_sortdownlinkeddatawindows ()
public function integer of_setdownlinkeddatawindow (ref datawindow adw_linkeddw)
public function integer of_setdownlinkeddatawindowall ()
end prototypes

public function string of_getclassname ();return 'pf_n_linkage'

end function

public function integer of_setuplinkeddatawindow (string as_uplinkeddw);// 상위 연계된 데이터윈도우를 등록한다
// 연계된 데이터윈우는 조회서비스, 저장서비스 사용시 이용됩니다
// as_uplinkeddw: 상위 연계된 데이터윈도우 명칭
// 리턴값: success=등록성공, failure=등록실패

if isnull(as_uplinkeddw) then return failure
if len(as_uplinkeddw) = 0 then return failure
//if isnull(iw_parent) then return failure

long ll_pos
string ls_type

ll_pos = pos(as_uplinkeddw, '.')
if ll_pos > 0 then
	ls_type = mid(as_uplinkeddw, ll_pos + 1)
	as_uplinkeddw = left(as_uplinkeddw, ll_pos - 1)
end if

idw_uplinked = iw_parent.dynamic of_getwindowobjectbyname(as_uplinkeddw)
if isvalid(idw_uplinked) then
	this.of_setdownlinkeddatawindow(idw_uplinked)
else
	messagebox('[' + idw_target.of_gettitle() + '] 알림', '연계 설정한 데이터윈도우가 존재하지 않습니다~r~n[' + as_uplinkeddw + ']')
	return failure
end if

// set type of linkage
choose case lower(ls_type)
	case 'sync', 'share', 'syncable', 'sharedata'
		is_linkagetype = 'syncable'
	case 'ret', 'retrieve'
		is_linkagetype = 'retrieve'
	case ''
		is_linkagetype = 'retrieve'
	case else
		messagebox('[' + idw_target.of_gettitle() + '] 알림', '[' + ls_type + '] 데이터윈도우 연계 타입은 지원되지 않습니다.~r~nSyntax Error!!')
		return failure
end choose

//messagebox('of_setuplinkeddatawindow', 'uplinked datawindow: ' + as_uplinkeddw + ', downlinked datawindow: ' + this.idw_target.classname() + ', linkage type: ' + is_linkagetype)
return success

end function

public function datawindow of_getuplinkeddatawindow ();// 상위 연계된 데이터윈도우를 리턴합니다
// 리턴값: 상위 연계된 데이터윈도우 레퍼런스

datawindow ldw_empty

if not isvalid(idw_target) then
	return ldw_empty
else
	return idw_uplinked
end if

end function

public function integer of_checkifbothareusingthesametable (datawindow adw_uplinked);// 두 개의 데이터윈도우가 같은 테이블을 사용하는지 확인합니다(현재 미사용)
// adw_uplinked: 상위 연계된 데이터윈도우 레퍼런스
// 리턴값: success=같은 테이블 사용, failure=다른 테이블 사용

if not isvalid(idw_target) then return failure
if not isvalid(adw_uplinked) then return failure

string ls_2ndtable

ls_2ndtable = lower(idw_target.dynamic describe("DataWindow.Table.UpdateTable"))
choose case ls_2ndtable
	case '!', '?', ''
		return failure
end choose

// 데이터윈도우 비교로직 다시 작성할 것...
//string ls_keys[]
//integer li_keycnt, i
//pf_s_argument lstr_arg
//string ls_column
//
//li_keycnt = idw_target.inv_args.inv_args.of_keyset(ls_keys)
//for i = 1 to li_keycnt
//	lstr_arg = idw_target.inv_args.inv_args.of_get(ls_keys[i])
//	if not isvalid(lstr_arg) then continue
//	
//	if lstr_arg.ref_type[1] = 'object' then
//		if lstr_arg.ref_obj[1] = adw_uplinked then
//			ls_column = lstr_arg.ref_prop[1]
//			ls_dbname = lower(adw_uplinked.dynamic describe(ls_column + ".dbName"))
//			ll_pos = pos(ls_dbname, ".")
//			if ll_pos > 0 then
//				ls_1sttable = left(ls_dbname, ll_pos - 1)
//				if ls_1sttable = ls_2ndtable then
//					if inv_cols.of_containskey(ls_dbname) then
//						if idw_target.dynamic describe(string(inv_cols.of_get(ls_dbname)) + ".Key") = "yes" then
//							return success
//						end if
//					end if
//				end if
//			end if
//		end if
//	end if
//next

return failure

end function

public function integer of_copydownlinkeditemstouplinked (long al_ul_row, long al_dl_row);// 하위 데이터 윈도우 아이템 값을 상위 데이터 윈도우로 아이템으로 복사합니다
// 동일한 컬럼명을 갖는 컬럼값만 복사합니다.
// al_ul_row: 복사될 데이터윈도우 레퍼런스
// al_dl_row: 복사할 소스 데이터윈도우 레퍼런스
// 리턴값: success=성공, failure=실패

if not isvalid(idw_uplinked) then return failure
if not isvalid(idw_target) then return failure

integer li_colcnt, i, li_copycnt
string ls_dbname, ls_colname
string ls_ul_colname, ls_dl_colname

// 데이터윈도우 컬럼 정보 보관
if not isvalid(inv_cols) then
	inv_cols = create pf_n_hashtable
	
	li_colcnt = long(idw_target.describe("Datawindow.Column.Count"))
	for i = 1 to li_colcnt
		ls_colname = idw_target.describe("#" + string(i) + ".Name")
		ls_dbname = idw_target.describe("#" + string(i) + ".dbName")
		inv_cols.of_put(ls_dbname, ls_colname)
	next	
end if

li_colcnt = integer(idw_uplinked.describe("Datawindow.Column.Count"))
for i = 1 to li_colcnt
	ls_ul_colname = idw_uplinked.describe("#" + string(i) + ".Name")
	ls_dbname = idw_uplinked.describe(ls_ul_colname + ".dbName")
	if inv_cols.of_containskey(ls_dbname) then
		ls_dl_colname = string(inv_cols.of_get(ls_dbname))
		if idw_target.getitemstatus(al_dl_row, ls_dl_colname, primary!) = datamodified! then
			choose case left(idw_uplinked.describe(ls_ul_colname + ".ColType"), 5)
				case 'char('
					idw_uplinked.setitem(al_ul_row, ls_ul_colname, idw_target.getitemstring(al_dl_row, ls_dl_colname))
				case 'date'
					idw_uplinked.setitem(al_ul_row, ls_ul_colname, idw_target.getitemdate(al_dl_row, ls_dl_colname))
				case 'time'
					idw_uplinked.setitem(al_ul_row, ls_ul_colname, idw_target.getitemtime(al_dl_row, ls_dl_colname))
				case 'datet', 'times'
					idw_uplinked.setitem(al_ul_row, ls_ul_colname, idw_target.getitemdatetime(al_dl_row, ls_dl_colname))
				case 'decim'
					idw_uplinked.setitem(al_ul_row, ls_ul_colname, idw_target.getitemdecimal(al_dl_row, ls_dl_colname))
				case 'int', 'long', 'numbe', 'real', 'ulong'
					idw_uplinked.setitem(al_ul_row, ls_ul_colname, idw_target.getitemnumber(al_dl_row, ls_dl_colname))
			end choose
			idw_uplinked.setitemstatus(al_ul_row, ls_ul_colname, primary!, notmodified!)
			li_copycnt ++
		end if
	end if
next

return li_copycnt

end function

public function string of_getlinkagetype ();if is_linkagetype = '' then
	return 'retrieve'
else
	return is_linkagetype
end if

end function

public subroutine of_setlinkagetype (string as_linkagetype);is_linkagetype = as_linkagetype

end subroutine

public function datawindow of_getrootdatawindow ();// idw_target을 기준으로 최상위 연계 데이터윈도우를 구합니다
// 리턴값: 최상위 연계 데이터윈도우 레퍼런스

datawindow ldw_root
pf_u_datawindow ldw_ulink

if not isvalid(idw_target) then return ldw_root

ldw_ulink = this.of_getuplinkeddatawindow()
do while isvalid(ldw_ulink)
	ldw_root = ldw_ulink
	ldw_ulink = ldw_ulink.inv_link.of_getuplinkeddatawindow()
loop

return ldw_root

end function

public function integer of_getsynceddatawindow (ref datawindow adw_syncable[]);// 자신과 동기화 연계된 데이터윈도우를 구합니다(자신 포함)
// adw_syncable: 검색된 동기화 연계된 데이터윈도우를 리턴받을 레퍼런스 변수(배열)
// 리턴값: 성공=검색된 데이터윈도우 갯수, 실패=-1

if not isvalid(idw_target) then return no_action

pf_u_datawindow ldw_ulink, ldw_dlink[], ldw_sync[]
integer li_linkcnt, i, li_syncnt

if idw_target.inv_link.of_getlinkagetype() = 'syncable' then
	ldw_ulink = idw_uplinked
else
	ldw_ulink = idw_target
end if

li_syncnt ++
ldw_sync[li_syncnt] = ldw_ulink

ldw_dlink = ldw_ulink.inv_link.idw_downlinked
li_linkcnt = upperbound(ldw_dlink)
for i = 1 to li_linkcnt
	if ldw_dlink[i].inv_link.of_getlinkagetype() = 'syncable' then
		li_syncnt ++
		ldw_sync[li_syncnt] = ldw_dlink[i]
	end if
next

adw_syncable = ldw_sync
return li_syncnt

end function

public subroutine of_initialize (datawindow adw_datawindow, window aw_parent);// 아규먼트 서비스를 초기화하는 함수
// adw_datawindow: 아규먼스 서비스를 제공할 데이터윈도우
// 리턴값: 없음

// 부모 데이터윈도우 등록
if not isvalid(adw_datawindow) then
	messagebox('알림', '올바르지 않은 함수호출 입니다.~r~npf_n_argument.of_registertarget()')
	return
end if

idw_target = adw_datawindow
iw_parent = aw_parent

// 연계 데이터윈도우 초기화
pf_u_datawindow ldw_empty, ldw_emptys[]

idw_uplinked = ldw_empty
idw_downlinked = ldw_emptys

end subroutine

public function integer of_getdownlinkeddatawindow (ref pf_u_datawindow adw_linked[]);// 하위 연계된 모든 데이터윈도우를 가져오는 함수
// adw_linked[] : 하위 연계된 데이터윈도우를 리턴받을 레퍼런스
// 리턴값 : 하위 연계된 데이터윈도우 갯수

long ll_linkcnt

if not isvalid(idw_target) then return no_action
pf_u_datawindow ldw_empty[]

adw_linked = ldw_empty
ll_linkcnt = this.of_getdownlinkeddatawindow(idw_target, adw_linked)

return ll_linkcnt

end function

public function integer of_getdownlinkeddatawindow (readonly pf_u_datawindow adw_basenode, ref pf_u_datawindow adw_linked[]);// 하위 연계된 데이터윈도우를 가져오는 함수
// 연결된 모든 하위 데이터윈도우를 구하기 위해 재귀호출을 합니다.
// adw_basenode: 하위연계된 데이터위도우를 찾을 데이터윈도우
// adw_linked[] : 하위 연계된 데이터윈도우를 리턴받을 레퍼런스
// 리턴값 : 하위 연계된 데이터윈도우 갯수

long ll_downcnt, ll_linkcnt
pf_u_datawindow ldw_downlinked
integer i

ll_linkcnt = upperbound(adw_linked)
ll_downcnt = upperbound(adw_basenode.inv_link.idw_downlinked)

for i = 1 to ll_downcnt
	ldw_downlinked = adw_basenode.inv_link.idw_downlinked[i]
	if ldw_downlinked.inv_link.of_getlinkagetype() = 'syncable' then continue
	ll_linkcnt ++
	adw_linked[ll_linkcnt] = ldw_downlinked
	if upperbound(ldw_downlinked.inv_link.idw_downlinked) > 0 then
		ll_linkcnt = this.of_getdownlinkeddatawindow(ldw_downlinked, adw_linked)
	end if
next

return ll_linkcnt

end function

public function integer of_setdownlinkeddatawindow (ref string as_linkeddw);// 하위 연계된 데이터윈도우를 등록한다
// adw_linkeddw: 연계될 데이터윈도우 명칭

if isnull(as_linkeddw) then return failure
if not isvalid(iw_parent) then return failure
if not isvalid(idw_target) then return failure

integer li_dwcnt
windowobject lwo_control
pf_u_datawindow ldw_control

lwo_control = iw_parent.dynamic of_getwindowcontrolbyname(as_linkeddw)
if not isvalid(lwo_control) then return failure

if  lwo_control.typeof() = datawindow! then
	if lwo_control.triggerevent("pfe_ispowerframecontrol") = 1 then
		if lwo_control.dynamic of_getclassname() = 'pf_u_datawindow' then
			ldw_control = lwo_control
			if not isvalid(ldw_control.inv_link) then ldw_control.of_setlinkageservice(true)
			li_dwcnt = upperbound(ldw_control.inv_link.idw_downlinked) + 1
			ldw_control.inv_link.idw_downlinked[li_dwcnt] = idw_target
			ldw_control.inv_link.of_sortdownlinkeddatawindows()
		end if
	end if
end if

return li_dwcnt

end function

public function integer of_sortdownlinkeddatawindows ();// bubble sort down-linked datawindows by taborder

integer i, j, li_dwcnt
pf_u_datawindow ldw_temp

li_dwcnt = upperbound(idw_downlinked)

for i = 1 to li_dwcnt
	for j = i + 1 to li_dwcnt
		if idw_downlinked[i].taborder > idw_downlinked[j].taborder then
			ldw_temp = idw_downlinked[i]
			idw_downlinked[i] = idw_downlinked[j]
			idw_downlinked[j] = ldw_temp
		end if
	next
next

return SUCCESS

end function

public function integer of_setdownlinkeddatawindow (ref datawindow adw_linkeddw);// 하위 연계된 데이터윈도우를 등록한다
// adw_linkeddw: 연계될 데이터윈도우 레퍼런스

integer li_dwcnt
pf_u_datawindow lw_control

if isnull(adw_linkeddw) then return failure
if not isvalid(adw_linkeddw) then return failure

if adw_linkeddw.triggerevent("pfe_ispowerframecontrol") = 1 then
	if adw_linkeddw.dynamic of_getclassname() = 'pf_u_datawindow' then
		lw_control = adw_linkeddw
		if not isvalid(lw_control.inv_link) then lw_control.of_setlinkageservice(true)
		li_dwcnt = upperbound(lw_control.inv_link.idw_downlinked) + 1
		lw_control.inv_link.idw_downlinked[li_dwcnt] = idw_target
		lw_control.inv_link.of_sortdownlinkeddatawindows()
	end if
end if

return li_dwcnt

end function

public function integer of_setdownlinkeddatawindowall ();// 하위 연계된 데이터윈도우를 등록합니다.
integer li_dwcnt, li_wocnt
integer i, j

windowobject lwo_controls[]
pf_u_datawindow ldw_temp, ldw_empty[]
idw_downlinked = ldw_empty

long ll_pos
string ls_uplinkeddw

iw_parent.dynamic of_getcontrols(iw_parent, lwo_controls)
li_wocnt = upperbound(lwo_controls)
for i = 1 to li_wocnt
	if  lwo_controls[i].typeof() = datawindow! then
		if lwo_controls[i].triggerevent("pfe_ispowerframecontrol") = 1 then
			if lwo_controls[i].dynamic of_getclassname() = 'pf_u_datawindow' then
				ldw_temp = lwo_controls[i]
				if ldw_temp.classname() = idw_target.classname() then continue
				
				ll_pos = pos(ldw_temp.uplinkeddatawindow, '.')
				if ll_pos > 0 then
					ls_uplinkeddw = lower(trim(left(ldw_temp.uplinkeddatawindow, ll_pos - 1)))
				else
					ls_uplinkeddw = lower(trim(ldw_temp.uplinkeddatawindow))
				end if
				
				if ls_uplinkeddw = idw_target.classname() then
					li_dwcnt ++
					idw_downlinked[li_dwcnt] = ldw_temp
				end if
			end if
		end if
	end if
next

this.of_sortdownlinkeddatawindows()
return li_dwcnt

end function

on pf_n_linkage.create
call super::create
end on

on pf_n_linkage.destroy
call super::destroy
end on

