$PBExportHeader$pf_n_defaultvalue.sru
$PBExportComments$데이터윈도우 행추가 시 기본 설정 값을 담당하는 오브젝트 입니다.
forward
global type pf_n_defaultvalue from pf_n_nonvisualobject
end type
end forward

global type pf_n_defaultvalue from pf_n_nonvisualobject
end type
global pf_n_defaultvalue pf_n_defaultvalue

type variables
protected:
	datawindow idw_target
	window iw_parent
	pf_n_expression inv_exp
	
public:
	pf_n_hashtable inv_initvalues

end variables

forward prototypes
public function string of_getclassname ()
public function boolean of_containscolumn (string as_columnname)
public function any of_getdefaultvalue (string as_columnname)
public function integer of_getdefaultvalue (string as_columnname, ref any aa_argvalue)
public function integer of_setdefaultvalue (long al_row, string as_column)
public subroutine of_initialize (datawindow adw_datawindow, window awo_parent)
public function integer of_parsedefaultvalues (string as_defaultvalues)
public function integer of_setalldefaultvalue (long al_row)
end prototypes

public function string of_getclassname ();return 'pf_n_defaultvalue'

end function

public function boolean of_containscolumn (string as_columnname);// as_columnname 에 해당하는 컬럼명이 데이터윈도우에 있는지 확인합니다
// as_columnname: 확인할 데이터윈도우 컬럼명
// 리턴값: true=컬럼명 있음, false=컬럼명 없음

if isnull(as_columnname) then return false
if len(trim(as_columnname)) = 0 then return false

integer i, li_columncnt

li_columncnt = long(idw_target.describe("Datawindow.Column.Count"))
for i = 1 to li_columncnt
	if idw_target.describe("#" + string(i) + ".Name") = as_columnname then return true
next

return false

end function

public function any of_getdefaultvalue (string as_columnname);// 선언 된  아규먼트의  값을  구한다
// as_columnname: 값을 구할 아규먼트 명칭
// as_argvalue: 값을 리턴받을 레퍼런스 변수
// 리턴값: 기본값

any la_retval
integer li_retval

li_retval = this.of_getdefaultvalue(as_columnname, la_retval)
return la_retval

end function

public function integer of_getdefaultvalue (string as_columnname, ref any aa_argvalue);// 선언 된  아규먼트의  값을  구한다
// as_columnname: 초기값을 구할 컬럼 명칭
// as_argvalue: 값을 리턴받을 레퍼런스 변수
// 리턴값: success=성공, failure=실패

pf_s_argument lstr_value
string ls_result
integer li_retval

if not inv_initvalues.of_containskey(as_columnname) then
	messagebox(idw_target.classname(), '[' + as_columnname  + '] 는 초기값 선언되지 않은 컬럼 명칭입니다')
	return failure
end if

lstr_value = inv_initvalues.of_get(as_columnname)
li_retval = inv_exp.of_evaluate(lstr_value.arg_exp, ls_result)

choose case left(lstr_value.arg_type, 5)
	case 'char('
		aa_argvalue = ls_result
	case 'date'
		aa_argvalue = date(ls_result)
	case 'time'
		aa_argvalue = time(ls_result)
	case 'datet', 'times'
		aa_argvalue = datetime(ls_result)
	case 'decim'
		aa_argvalue = dec(ls_result)
	case 'int'
		aa_argvalue = integer(ls_result)
	case 'long', 'ulong'
		aa_argvalue = long(ls_result)
	case 'numbe', 'real'
		aa_argvalue = dec(ls_result)
end choose

return li_retval

//any la_retval
//pf_s_argument lstr_value
//long ll_row
//string ls_strval, ls_title
//boolean lb_required
//
//if not inv_initvalues.of_containskey(as_columnname) then
//	messagebox('알림', '[' + as_columnname  + '] 는 선언되지 않은 컬럼명 입니다')
//	return failure
//end if
//
//lstr_value = inv_initvalues.of_get(as_columnname)
//
//choose case lstr_value.ref_type[1]
//	case 'session'
//		if not gnv_session.of_containskey(lstr_value.ref_prop[1]) then
//			messagebox('[pf_n_defaultvalue] 알림', '[' + lstr_value.ref_prop[1] + '] 는  선언되지  않은  SESSION 값입니다')
//			return failure
//		end if
//		la_retval = gnv_session.of_get(lstr_value.ref_prop[1])
//		
//	case 'constant'
//		la_retval = lstr_value.ref_prop[1]
//		
//	case 'user'
//		la_retval = lstr_value.arg_value[1]
//		
//	case 'object'
//		choose case lstr_value.ref_obj[1].typeof()
//			case datawindow!
//				datawindow ldw_ref
//				ldw_ref = lstr_value.ref_obj[1]
//				
//				if ldw_ref.accepttext() <> 1 then return failure
//				
//				ll_row = lstr_value.ref_row[1]
//				if ll_row = 0 then
//					ll_row = ldw_ref.getrow()
//					if ll_row = 0 then
//						messagebox('[' + idw_target.dynamic of_gettitle() + '] 알림', '[' + string(ldw_ref.dynamic of_gettitle()) + '] 에 참조할 수 있는 데이터가 존재하지 않습니다(RowCount=0)')
//						return failure
//					end if
//				end if
//				
//				if pos(ldw_ref.describe(lstr_value.ref_prop[1] + ".Tag"), "required=true") > 0 then
//					lb_required = true
//				else
//					lb_required = false
//				end if
//				
//				//if lstr_value.is_exp = true then
//				//	la_retval = ldw_ref.dynamic of_getexpvalue(lstr_value.ref_prop[1], ldw_ref.dynamic getrow())
//				//else
//					choose case left(ldw_ref.describe(lstr_value.ref_prop[1] + ".ColType"), 5)
//						case 'char('
//							la_retval = ldw_ref.getitemstring(ll_row, lstr_value.ref_prop[1])
//							if lb_required = true then
//								if string(la_retval) = '' then
//									ls_title = trim(ldw_ref.describe(lstr_value.ref_prop[1] + "_t.text"))
//									if ls_title = '!' or ls_title = '?' or ls_title = '' then ls_title = lstr_value.ref_prop[1]
//									messagebox("알림", "[" + ls_title + "] 필수 검색 조건을 입력 하세요")
//									return failure
//								end if
//							end if
//						case 'date'
//							la_retval = ldw_ref.getitemdate(ll_row, lstr_value.ref_prop[1])
//						case 'time'
//							la_retval = ldw_ref.getitemtime(ll_row, lstr_value.ref_prop[1])
//						case 'datet', 'times'
//							la_retval = ldw_ref.getitemdatetime(ll_row, lstr_value.ref_prop[1])
//						case 'decim'
//							la_retval = ldw_ref.getitemdecimal(ll_row, lstr_value.ref_prop[1])
//						case 'int', 'long', 'numbe', 'real', 'ulong'
//							la_retval = ldw_ref.getitemnumber(ll_row, lstr_value.ref_prop[1])
//					end choose
//				//end if
//				
//				if lb_required = true then
//					if isnull(la_retval) then
//						ls_title = trim(ldw_ref.describe(lstr_value.ref_prop[1] + "_t.text"))
//						if ls_title = '!' or ls_title = '?' or ls_title = '' then ls_title = lstr_value.ref_prop[1]
//						messagebox("알림", "[" + ls_title + "] 필수 검색 조건을 입력 하세요")
//						return failure
//					end if
//				end if
//				
//			case statictext!
//				statictext lst_ref
//				
//				lst_ref = lstr_value.ref_obj[1]
//				choose case lower(lstr_value.ref_prop[1])
//					case 'text'
//						ls_strval = lst_ref.text
//					case 'tag'
//						ls_strval = lst_ref.tag
//				end choose
//				
//				la_retval = ls_strval
//				
//			case singlelineedit!
//				singlelineedit lsle_ref
//				
//				lsle_ref = lstr_value.ref_obj[1]
//				choose case lower(lstr_value.ref_prop[1])
//					case 'text'
//						ls_strval = lsle_ref.text
//					case 'tag'
//						ls_strval = lsle_ref.tag
//				end choose
//				
//				la_retval = ls_strval
//
//			case multilineedit!
//				multilineedit lmle_ref
//				
//				lmle_ref = lstr_value.ref_obj[1]
//				choose case lower(lstr_value.ref_prop[1])
//					case 'text'
//						ls_strval = lmle_ref.text
//					case 'tag'
//						ls_strval = lmle_ref.tag
//				end choose
//				
//				la_retval = ls_strval
//				
//			case editmask!
//				editmask lem_ref
//				
//				lem_ref = lstr_value.ref_obj[1]
//				choose case lower(lstr_value.ref_prop[1])
//					case 'text'
//						ls_strval = lem_ref.text
//					case 'tag'
//						ls_strval = lem_ref.tag
//					case 'mask'
//						ls_strval = lem_ref.mask
//				end choose
//				
//				la_retval = ls_strval
//				
//			case radiobutton!
//				radiobutton lrb_ref
//				
//				lrb_ref = lstr_value.ref_obj[1]
//				choose case lower(lstr_value.ref_prop[1])
//					case 'text'
//						ls_strval = lrb_ref.text
//					case 'tag'
//						ls_strval = lrb_ref.tag
//					case 'checked'
//						if lrb_ref.checked then
//							ls_strval = 'checked'
//						else
//							ls_strval = 'unchecked'
//						end if
//				end choose
//				
//				la_retval = ls_strval
//				
//			case checkbox!
//				checkbox lcb_ref
//				
//				lcb_ref = lstr_value.ref_obj[1]
//				choose case lower(lstr_value.ref_prop[1])
//					case 'text'
//						ls_strval = lcb_ref.text
//					case 'tag'
//						ls_strval = lcb_ref.tag
//					case 'checked'
//						if lcb_ref.checked then
//							ls_strval = 'checked'
//						else
//							ls_strval = 'unchecked'
//						end if
//				end choose
//				
//				la_retval = ls_strval
//				
//			case listbox!
//				listbox llb_ref
//				
//				llb_ref = lstr_value.ref_obj[1]
//				choose case lower(lstr_value.ref_prop[1])
//					case 'text'
//						ls_strval = llb_ref.selecteditem()
//						la_retval = ls_strval
//					case 'tag'
//						ls_strval = llb_ref.tag
//						la_retval = ls_strval
//					case 'item'
//						la_retval = llb_ref.item[]
//				end choose
//				
//			case dropdownlistbox!
//				dropdownlistbox lddlb_ref
//				
//				lddlb_ref = lstr_value.ref_obj[1]
//				choose case lower(lstr_value.ref_prop[1])
//					case 'text'
//						ls_strval = lddlb_ref.text
//						la_retval = ls_strval
//					case 'tag'
//						ls_strval = lddlb_ref.tag
//						la_retval = ls_strval
//					case 'item'
//						la_retval = lddlb_ref.item[]
//				end choose
//		end choose
//end choose
//
//as_argvalue = la_retval
//return success

end function

public function integer of_setdefaultvalue (long al_row, string as_column);// 컬럼 기본값을 데이터윈도우에 SetItem 처리 합니다.
// al_row: SetItem 을 수행할 행 수
// as_column: 컬럼 기본값을 설정한 컬럼명
// 리턴값: 성공=1, 실패=-1

if not isvalid(idw_target) then return no_action
if not isnumber(idw_target.describe(as_column + ".id")) then return failure
if al_row = 0 or al_row > idw_target.rowcount() then return failure

any la_value

if this.of_getdefaultvalue(as_column, la_value) = failure then return failure
//messagebox('of_setdefaultvalue()', 'as_column=' + as_column + ', al_row=' + string(al_row) + ', result=' + string(la_value))

choose case left(idw_target.describe(as_column + ".ColType"), 5)
	case 'char('
		idw_target.setitem(al_row, as_column, string(la_value))
	case 'date'
		idw_target.setitem(al_row, as_column, date(la_value))
	case 'time'
		idw_target.setitem(al_row, as_column, time(la_value))
	case 'datet', 'times'
		idw_target.setitem(al_row, as_column, datetime(la_value))
	case 'decim'
		idw_target.setitem(al_row, as_column, dec(la_value))
	case 'int'
		idw_target.setitem(al_row, as_column, int(la_value))
	case 'long', 'ulong'
		idw_target.setitem(al_row, as_column, long(la_value))
	case 'numbe', 'real'
		idw_target.setitem(al_row, as_column, real(la_value))
end choose

idw_target.setitemstatus(al_row, as_column, primary!, datamodified!)
idw_target.setitemstatus(al_row, as_column, primary!, notmodified!)

return success

end function

public subroutine of_initialize (datawindow adw_datawindow, window awo_parent);// 기본값 서비스를 초기화하는 함수
// adw_datawindow: 아규먼스 서비스를 제공할 데이터윈도우
// 리턴값: 없음

// 부모 데이터윈도우 등록
if not isvalid(adw_datawindow) then
	messagebox('알림', '올바르지 않은 함수호출 입니다.~r~npf_n_defaultvalue.of_initialize()')
	return
end if

idw_target = adw_datawindow
iw_parent = awo_parent

// Expression Object 설정
inv_exp.of_initialize(idw_target, iw_parent)

end subroutine

public function integer of_parsedefaultvalues (string as_defaultvalues);// as_argumentss 값을 데이터윈도우 기본값 설정에 따라 파싱한다
// as_argumentss 형태는 '컬럼명=오브젝트.참조값' 형태입니다
// 참조 가능한 오브젝트 타입은 { session, constant, datawindow, statictext... 등 } 입니다
// 기본값이 여러개일 경우 ';' 으로 구분 합니다
// as_defaultvalues: 기본값 정의 문자열(예: "sys_id=session.sys_id; dept_cd=dw_cond.dept_cd")
// 리턴값: success 또는 failure

if isnull(as_defaultvalues) then return no_action
if len(trim(as_defaultvalues)) =  0  then return no_action
if not isvalid(idw_target) then return no_action

string ls_linebuf[]
string ls_colname, ls_expression
integer li_line, i
long ll_pos
pf_s_argument lstr_arg

li_line = pf_f_parsetoarray(as_defaultvalues, ';', ls_linebuf)
for i = 1 to li_line
	ls_linebuf[i] = trim(ls_linebuf[i])
	if ls_linebuf[i] = '' then continue
	ll_pos = pos(ls_linebuf[i], '=')
	if ll_pos = 0 then
		messagebox('알림(pf_n_defaultvalue.of_setDefaultValues)', 'DefaultValue 의 형태는 "컬럼명=오브젝트명.프로퍼티" 입니다')
		return failure
	end if
	
	ls_colname = trim(left(ls_linebuf[i], ll_pos - 1))
	
	if not this.of_containscolumn(ls_colname) then
		messagebox('알림(pf_n_defaultvalue.of_setDefaultValues)', '[' + ls_colname + '] 은 선언되지 않은 컬럼명 입니다')
		return failure
	end if
	
	ls_expression = trim(mid(ls_linebuf[i], ll_pos + 1))

	lstr_arg.arg_name = ls_colname
	lstr_arg.arg_type = idw_target.describe(ls_colname + ".ColType")
	lstr_arg.arg_exp = ls_expression
	
	inv_initvalues.of_put(ls_colname, lstr_arg)
next

return success

end function

public function integer of_setalldefaultvalue (long al_row);// 모든 컬럼 기본값을 데이터윈도우에 al_row에 SetItem 처리 합니다.
// al_row: SetItem 을 수행할 행 수
// 리턴값: 성공=1, 실패=-1

if not isvalid(idw_target) then return no_action

string ls_keyset[]
integer li_keycnt, i

li_keycnt = inv_initvalues.of_keyset( ls_keyset )
for i = 1 to li_keycnt
	if this.of_setdefaultvalue(al_row, ls_keyset[i]) = failure then
		return failure
	end if
next

return success

end function

on pf_n_defaultvalue.create
call super::create
end on

on pf_n_defaultvalue.destroy
call super::destroy
end on

event constructor;call super::constructor;inv_initvalues = create pf_n_hashtable
inv_exp = create pf_n_expression

end event

event destructor;call super::destructor;destroy inv_initvalues
destroy inv_exp

end event

