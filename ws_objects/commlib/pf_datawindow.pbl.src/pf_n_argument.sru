$PBExportHeader$pf_n_argument.sru
$PBExportComments$데이터윈도우 조회 시 아규먼트 설정을 담당하는 오브젝트 입니다.
forward
global type pf_n_argument from pf_n_nonvisualobject
end type
end forward

global type pf_n_argument from pf_n_nonvisualobject
end type
global pf_n_argument pf_n_argument

type variables
protected:
	powerobject ipo_target
	window iw_parent
	datawindow idw_parent
	pf_n_expression inv_exp
	string is_dwobject
	
public:
	pf_n_hashtable inv_args

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_checknotassignedargument ()
public function integer of_getallargumentvalue (ref any as_argvalue[])
protected function any of_converttoargumenttype (string as_strval, string as_argtype)
public function integer of_setargument (string as_argname, any aa_argvalue)
public function integer of_displayerrormessage (readonly powerobject apo_mesgobj, readonly string as_mesgtext)
public function integer of_getrefobjinfo (string as_ref_str, ref string as_ref_type, ref windowobject awo_ref_obj, ref string as_ref_prop, ref long al_ref_row)
public function integer of_getobjectvalue (string as_arg_type, windowobject awo_ref_obj, string as_ref_prop, long al_ref_row, ref any aa_argvalue)
public function integer of_getargumentvalue (string as_argname, ref any aa_argvalue)
public subroutine of_initialize (powerobject apo_target, window awo_parent)
public subroutine of_initialize (powerobject apo_target, window awo_parent, datawindow adw_parent, string as_dwobject)
public function integer of_parsearguments (string as_arguments)
end prototypes

public function string of_getclassname ();return 'pf_n_argument'

end function

public function integer of_checknotassignedargument ();// 데이터윈도우 아규먼트 중 SetArgument 설정되지  않은  항목이  있는지  점검한다
// 리턴값: success=모두 설정된 상태, failure=설정되지  않은  항목이  있음

pf_s_argument lstr_arg
string ls_notassigned
string ls_keys[]
long ll_keycnt
integer i

ll_keycnt = inv_args.of_sortedkeyset(ls_keys)
for i = 1 to ll_keycnt
	lstr_arg = inv_args.of_get(ls_keys[i])
	if lstr_arg.arg_exp = '' then
		if len(ls_notassigned) > 0 then ls_notassigned += ', '
		ls_notassigned += lstr_arg.arg_name
	end if
next

if len(ls_notassigned) > 0 then
	this.of_displayerrormessage(ipo_target, '[' + ls_notassigned + '] 설정되지 않은 RetrievalArgument 가 있습니다')
	return failure
end if

return success

end function

public function integer of_getallargumentvalue (ref any as_argvalue[]);// 선언 된 모든 아규먼트의  값을  구한다
// as_argvalue: 값을 리턴받을 레퍼런스 변수(배열)
// 리턴값: success=성공, failure=실패

string ls_keys[]
integer li_keycnt, i
any la_result

li_keycnt = inv_args.of_keyset(ls_keys)
for i = 1 to li_keycnt
	if this.of_getargumentvalue(ls_keys[i], la_result) = success then
		as_argvalue[i] = la_result
	else
		return failure
	end if
next

return success

end function

protected function any of_converttoargumenttype (string as_strval, string as_argtype);// 아규먼트 타입에 맞춰서  문자열을  형변환  한다
// 배열타입  아규먼트는  지원되지  않음
// as_strval: 형변환할  문자열
// as_argtype: 형변환할  타입
// 리턴값: 형변환된  값

any la_retval

choose case as_argtype
	case 'date'
		la_retval = date(as_strval)
	case 'datetime'
		la_retval = datetime(as_strval)
	case 'number'
		la_retval = long(as_strval)
	case 'time'
		la_retval = time(as_strval)
	case 'string'
		la_retval = as_strval
	case 'decimal'
		la_retval = dec(as_strval)
	case 'datelist', 'datetimelist', 'numberlist', 'timelist', 'stringlist', 'decimallist'
		messagebox('알림', '배열타입 아규먼트는  지원되지  않습니다')
end choose

return la_retval

end function

public function integer of_setargument (string as_argname, any aa_argvalue);// 데이터윈도우에 선언된 아규먼트의 값을 설정합니다
// 사용자가 직접 아규먼트 값을 설정 할 때 호출됩니다
// as_argname: 설정할 데이터윈도우 아규먼트 명칭
// aa_argvalue: 설정할 데이터윈도우 값
// 리턴값: success=성공, failure=실패

string ls_name, ls_value
string ls_obj, ls_prop
long ll_row, ll_pos, ll_lastpos
windowobject lwo_ref
pf_s_argument lstr_arg

// 아규먼트 명칭
if isnull(as_argname) then return no_action
if isnull(aa_argvalue) then return no_action

ls_name = trim(as_argname)
if not inv_args.of_containskey(ls_name) then
	// 선언된 아규먼트가 없으면 오류 메시지 표시하지 않고 failure(-1) 리턴 
	//this.of_displayerrormessage(ipo_target, '[' + ls_name + '] 은 선언되지 않은 아규먼트 명입니다')
	return failure
end if

lstr_arg = inv_args.of_get(ls_name)
ls_value = string(aa_argvalue)

choose case classname(aa_argvalue)
	case 'string'
		if (left(ls_value, 1) = "'" and right(ls_value, 1) = '"') or (left(ls_value, 1) = "'" and right(ls_value, 1) = "'") then
			lstr_arg.arg_exp = ls_value
		else
			// 오브젝트 명칭
			ll_pos = pos(ls_value, '.')
			if ll_pos = 0 then
				lstr_arg.arg_exp = 'constant.' + ls_value
			else
				ls_obj = trim(left(ls_value, ll_pos - 1))
				ls_prop = trim(mid(ls_value, ll_pos + 1))
				
				choose case lower(ls_obj)
					case 'session', 'constant', 'this', 'parent'
						lstr_arg.arg_exp = ls_value
					case else
						if right(ls_prop, 2) = '()' then
							lwo_ref = iw_parent.dynamic of_getwindowobjectbyname(ls_obj)
							if not isvalid(lwo_ref) then
								this.of_displayerrormessage(ipo_target, '[' + ls_obj + '] 는 선언되지 않은 윈도우 컨트롤 명칭 입니다')
								return failure
							end if
						else
							// 행번호 GET
							ll_pos = pos(ls_prop, '[')
							if ll_pos > 0 then
								ll_lastpos = pos(ls_prop, ']', ll_pos + 1)
								if ll_lastpos = 0 then
									this.of_displayerrormessage(ipo_target, '잘못된 Syntax 입니다~r~n' + '[' + ls_prop + ']')
									return failure
								end if
								ll_row = long(mid(ls_prop, ll_pos + 1, ll_lastpos - ll_pos - 1))
								ls_prop = left(ls_prop, ll_pos - 1)
							else
								ll_row = 0
							end if
							
							// 윈도우 컨트롤 명칭 확인
							lwo_ref = iw_parent.dynamic of_getwindowobjectbyname(ls_obj)
							if not isvalid(lwo_ref) then
								this.of_displayerrormessage(ipo_target, '[' + ls_obj + '] 는 선언되지 않은 윈도우 컨트롤 명칭 입니다')
								return failure
							end if
						end if
						
						lstr_arg.arg_exp = ls_value
				end choose
			end if
		end if
	case else
		lstr_arg.arg_exp = 'constant.' + ls_value
end choose

//lstr_arg.arg_exp = string(aa_argvalue)
inv_args.of_put(ls_name, lstr_arg)

return success

end function

public function integer of_displayerrormessage (readonly powerobject apo_mesgobj, readonly string as_mesgtext);// 오류가 발생한 오브젝트명을 포함한 에러 메시지를 디스플레이 합니다 
// apo_mesgobj : 오류가 발생한 오브젝트
// as_mesgtext : 오류 메시지
// 리턴값
// messagebox의 리턴 값

string ls_title

choose case apo_mesgobj.typeof()
	case datawindow!
		ls_title = '[' + apo_mesgobj.dynamic of_gettitle() + '] 알림'
	case datastore!
		ls_title = '[' + apo_mesgobj.classname() + '] 알림'
	case datawindowchild!
		ls_title = '[' + idw_parent.classname() + '.' + is_dwobject + '] dddw 알림'
end choose

return messagebox(ls_title, as_mesgtext)

end function

public function integer of_getrefobjinfo (string as_ref_str, ref string as_ref_type, ref windowobject awo_ref_obj, ref string as_ref_prop, ref long al_ref_row);// 아규먼트 타입별로 참조할 오브젝트 정보를 구합니다.
// 현재 사용 안 함. 참조 오브젝트 정보는 pf_n_expression 에서 처리.

string ls_obj, ls_prop
long ll_pos, ll_lastpos, ll_row
windowobject lwo_ref

// 오브젝트 명칭
ll_pos = pos(as_ref_str, '.')
if ll_pos = 0 then
	this.of_displayerrormessage(ipo_target, 'RetrievalArgument의 형태는 "아규먼트명=오브젝트명.프로퍼티" 입니다')
	return failure
end if

ls_obj = trim(left(as_ref_str, ll_pos - 1))
ls_prop = trim(mid(as_ref_str, ll_pos + 1))

if right(ls_prop, 2) = '()' then
	ls_prop = ls_prop
end if

choose case lower(ls_obj)
	// gnv_session 글로벌 변수
	case 'session'
		as_ref_type = 'session'
		awo_ref_obj = lwo_ref
		as_ref_prop = ls_prop
		al_ref_row = 0
	// 상수
	case 'constant'
		as_ref_type = 'constant'
		awo_ref_obj = lwo_ref
		as_ref_prop = ls_prop
		al_ref_row = 0
	case else
		// getter 함수
		if right(ls_prop, 2) = '()' then
			as_ref_type = 'getter'
			as_ref_prop = ls_prop
			al_ref_row = 0
			
			choose case lower(ls_obj)
				case 'this'
					lwo_ref = idw_parent
				case 'parent'
					setnull(lwo_ref)
				case else
					lwo_ref = iw_parent.dynamic of_getwindowobjectbyname(ls_obj)
					if not isvalid(lwo_ref) then
						this.of_displayerrormessage(ipo_target, '[' + ls_obj + '] 는 선언되지 않은 윈도우 컨트롤 명칭 입니다')
						return failure
					end if
			end choose
		else
			// 행번호 GET
			ll_pos = pos(ls_prop, '[')
			if ll_pos > 0 then
				ll_lastpos = pos(ls_prop, ']', ll_pos + 1)
				if ll_lastpos = 0 then
					this.of_displayerrormessage(ipo_target, '잘못된 Syntax 입니다~r~n' + '[' + ls_prop + ']')
					return failure
				end if
				ll_row = long(mid(ls_prop, ll_pos + 1, ll_lastpos - ll_pos - 1))
				ls_prop = left(ls_prop, ll_pos - 1)
			else
				ll_row = 0
			end if
			
			// 윈도우 컨트롤 명칭 확인
			lwo_ref = iw_parent.dynamic of_getwindowobjectbyname(ls_obj)
			if not isvalid(lwo_ref) then
				this.of_displayerrormessage(ipo_target, '[' + ls_obj + '] 는 선언되지 않은 윈도우 컨트롤 명칭 입니다')
				return failure
			end if
			
			as_ref_type = 'object'
			awo_ref_obj = lwo_ref
			as_ref_prop = ls_prop
			al_ref_row = ll_row
		end if
end choose

return success

end function

public function integer of_getobjectvalue (string as_arg_type, windowobject awo_ref_obj, string as_ref_prop, long al_ref_row, ref any aa_argvalue);long ll_row
boolean lb_required
string ls_title, ls_strval

choose case awo_ref_obj.typeof()
	case datawindow!
		datawindow lw_ref
		lw_ref = awo_ref_obj
		if lw_ref.accepttext() <> 1 then return failure
		
		ll_row = al_ref_row
		if ll_row = 0 then
			ll_row = lw_ref.getrow()
			if ll_row = 0 then
				this.of_displayerrormessage(ipo_target, '[' + string(lw_ref.dynamic of_gettitle()) + '] 에 참조할 수 있는 데이터가 존재하지 않습니다(RowCount=0)')
				return failure
			end if
		end if

		if match(lw_ref.describe(as_ref_prop + ".Tag"), "required *= *true") = true and lw_ref.dynamic of_issearchcondition() = true then
			lb_required = true
		else
			lb_required = false
		end if
		
		choose case as_arg_type
			case 'string'
				aa_argvalue = lw_ref.getitemstring(ll_row, as_ref_prop)
				if isnull(aa_argvalue) then aa_argvalue = ''
				if lb_required = true then
					if string(aa_argvalue) = '' then
						ls_title = trim(lw_ref.describe(as_ref_prop + "_t.text"))
						if ls_title = '!' or ls_title = '?' or ls_title = '' then ls_title = as_ref_prop
						this.of_displayerrormessage(ipo_target, "[" + ls_title + "] 필수 검색 조건을 입력 하세요")
						return failure
					end if
				end if
			case 'date'
				aa_argvalue = lw_ref.getitemdate(ll_row, as_ref_prop)
			case 'datetime'
				aa_argvalue = lw_ref.getitemdatetime(ll_row, as_ref_prop)
			case 'number'
				aa_argvalue = lw_ref.getitemnumber(ll_row, as_ref_prop)
			case 'time'
				aa_argvalue = lw_ref.getitemtime(ll_row, as_ref_prop)
			case 'decimal'
				aa_argvalue = lw_ref.getitemdecimal(ll_row, as_ref_prop)
			case 'datelist', 'datetimelist', 'numberlist', 'timelist', 'stringlist', 'decimallist'
				this.of_displayerrormessage(ipo_target, '배열타입 아규먼트는  지원되지  않습니다')
				return failure
		end choose
		
		if lb_required = true then
			if isnull(aa_argvalue) then
				ls_title = trim(lw_ref.describe(as_ref_prop + "_t.text"))
				if ls_title = '!' or ls_title = '?' or ls_title = '' then ls_title = as_ref_prop
				this.of_displayerrormessage(ipo_target, "[" + ls_title + "] 필수 검색 조건을 입력 하세요")
				return failure
			end if
		end if
		
	case statictext!
		statictext lst_ref
		
		lst_ref = awo_ref_obj
		choose case lower(as_ref_prop)
			case 'text'
				ls_strval = lst_ref.text
			case 'tag'
				ls_strval = lst_ref.tag
		end choose
		
		aa_argvalue = this.of_converttoargumenttype(ls_strval, as_arg_type)
		
	case singlelineedit!
		singlelineedit lsle_ref
		
		lsle_ref = awo_ref_obj
		choose case lower(as_ref_prop)
			case 'text'
				ls_strval = lsle_ref.text
			case 'tag'
				ls_strval = lsle_ref.tag
		end choose
		
		aa_argvalue = this.of_converttoargumenttype(ls_strval, as_arg_type)

	case multilineedit!
		multilineedit lmle_ref
		
		lmle_ref = awo_ref_obj
		choose case lower(as_ref_prop)
			case 'text'
				ls_strval = lmle_ref.text
			case 'tag'
				ls_strval = lmle_ref.tag
		end choose
		
		aa_argvalue = this.of_converttoargumenttype(ls_strval, as_arg_type)
		
	case editmask!
		editmask lem_ref
		
		lem_ref = awo_ref_obj
		choose case lower(as_ref_prop)
			case 'text'
				ls_strval = lem_ref.text
			case 'tag'
				ls_strval = lem_ref.tag
			case 'mask'
				ls_strval = lem_ref.mask
		end choose
		
		aa_argvalue = this.of_converttoargumenttype(ls_strval, as_arg_type)
		
	case radiobutton!
		radiobutton lrb_ref
		
		lrb_ref = awo_ref_obj
		choose case lower(as_ref_prop)
			case 'text'
				ls_strval = lrb_ref.text
			case 'tag'
				ls_strval = lrb_ref.tag
			case 'checked'
				if lrb_ref.checked then
					ls_strval = 'checked'
				else
					ls_strval = 'unchecked'
				end if
		end choose
		
		aa_argvalue = this.of_converttoargumenttype(ls_strval, as_arg_type)
		
	case checkbox!
		checkbox lcb_ref
		
		lcb_ref = awo_ref_obj
		choose case lower(as_ref_prop)
			case 'text'
				ls_strval = lcb_ref.text
			case 'tag'
				ls_strval = lcb_ref.tag
			case 'checked'
				if lcb_ref.checked then
					ls_strval = 'checked'
				else
					ls_strval = 'unchecked'
				end if
		end choose
		
		aa_argvalue = this.of_converttoargumenttype(ls_strval, as_arg_type)
		
	case listbox!
		listbox llb_ref
		
		llb_ref = awo_ref_obj
		choose case lower(as_ref_prop)
			case 'text'
				ls_strval = llb_ref.selecteditem()
				aa_argvalue = this.of_converttoargumenttype(ls_strval, as_arg_type)
			case 'tag'
				ls_strval = llb_ref.tag
				aa_argvalue = this.of_converttoargumenttype(ls_strval, as_arg_type)
			case 'item'
				aa_argvalue = llb_ref.item[]
		end choose
		
	case dropdownlistbox!
		dropdownlistbox lddlb_ref
		
		lddlb_ref = awo_ref_obj
		choose case lower(as_ref_prop)
			case 'text'
				ls_strval = lddlb_ref.text
				aa_argvalue = this.of_converttoargumenttype(ls_strval, as_arg_type)
			case 'tag'
				ls_strval = lddlb_ref.tag
				aa_argvalue = this.of_converttoargumenttype(ls_strval, as_arg_type)
			case 'item'
				aa_argvalue = lddlb_ref.item[]
		end choose
end choose

return success

end function

public function integer of_getargumentvalue (string as_argname, ref any aa_argvalue);// 선언 된  아규먼트의  값을  구한다
// as_argname: 값을 구할 아규먼트 명칭
// as_argvalue: 값을 리턴받을 레퍼런스 변수
// 리턴값: success=성공, failure=실패

pf_s_argument lstr_arg
string ls_result
integer li_retval

if not inv_args.of_containskey(as_argname) then
	this.of_displayerrormessage(ipo_target, '[' + as_argname  + '] 는 선언되지 않은 아규먼트 명칭입니다')
	return failure
end if

lstr_arg = inv_args.of_get(as_argname)
li_retval = inv_exp.of_evaluate(lstr_arg.arg_exp, ls_result)

choose case lstr_arg.arg_type
	case 'number', 'decimal'
		aa_argvalue = dec(ls_result)
	case 'string'
		aa_argvalue = ls_result
	case 'date'
		aa_argvalue = date(ls_result)
	case 'time'
		aa_argvalue = time(ls_result)
	case 'datetime'
		aa_argvalue = datetime(ls_result)
end choose

return li_retval

end function

public subroutine of_initialize (powerobject apo_target, window awo_parent);// 아규먼트 서비스를 초기화하는 함수
// adw_datawindow: 아규먼스 서비스를 제공할 데이터윈도우
// 리턴값: 없음

if not isvalid(apo_target) then
	messagebox('알림', '올바르지 않은 함수호출 입니다.~r~npf_n_argument.of_registertarget()')
	return
end if

// 처리대상 데이터윈도우 보관
ipo_target = apo_target

// 부모 윈도우 보관
iw_parent = awo_parent

// 데이터윈도우 아규먼트 정보 보관
string ls_arguments
ls_arguments = trim(apo_target.dynamic describe("Datawindow.Table.Arguments"))
if ls_arguments = '?' or ls_arguments = '!' or ls_arguments = '' then return

string ls_linebuf[]
string ls_itembuf[]
integer li_line, i
pf_s_argument lstr_arg, lstr_empty

inv_args.of_clear()
li_line = pf_f_parsetoarray(ls_arguments, '~n', ls_linebuf)
for i = 1 to li_line
	if pf_f_parsetoarray(ls_linebuf[i], '~t', ls_itembuf) <> 2 then continue
	
	lstr_arg = lstr_empty
	lstr_arg.arg_name = trim(ls_itembuf[1])
	lstr_arg.arg_type = trim(ls_itembuf[2])
	inv_args.of_put(lstr_arg.arg_name, lstr_arg)
next

// Expression Object 설정
inv_exp.of_initialize(ipo_target, iw_parent)

end subroutine

public subroutine of_initialize (powerobject apo_target, window awo_parent, datawindow adw_parent, string as_dwobject);// DDDW용 아규먼트 초기화 함수
this.of_initialize(apo_target, awo_parent)

this.idw_parent = adw_parent
this.is_dwobject = as_dwobject

return

end subroutine

public function integer of_parsearguments (string as_arguments);// as_argumentss 값을 데이터윈도우 아규먼트 설정에 따라 파싱한다
// as_argumentss 형태는 '아규먼트명=오브젝트.참조값' 형태입니다
// 참조 가능한 오브젝트 타입은 { session, datawindow, statictext } 입니다
// 아규먼트가 여러개일 경우 ';' 으로 구분 합니다
// as_argumentss: 아규먼트 정의값(예: "sys_id=session.sys_id; dept_cd=dw_cond.dept_cd")
// 리턴값: success 또는 failure

if isnull(as_arguments) then return no_action
if len(trim(as_arguments)) =  0  then return no_action

string ls_linebuf[]
string ls_name, ls_expression
integer li_line, i
long ll_pos
pf_s_argument lstr_arg

li_line = pf_f_parsetoarray(as_arguments, ';', ls_linebuf)
for i = 1 to li_line
	ls_linebuf[i] = trim(ls_linebuf[i])
	if ls_linebuf[i] = '' then continue
	ll_pos = pos(ls_linebuf[i], '=')
	if ll_pos = 0 then
		this.of_displayerrormessage(ipo_target, 'RetrievalArgument의 형태는 "아규먼트명=오브젝트명.프로퍼티" 입니다')
		return failure
	end if
	
	ls_name = trim(left(ls_linebuf[i], ll_pos - 1))
	
	// Argument 내용 중 예약어 제거
	choose case lower(ls_name)
		case 'required', 'verticalcenter', 'posticon', 'dddwinsertrow'
			continue
	end choose
	
	if not inv_args.of_containskey(ls_name) then
		this.of_displayerrormessage(ipo_target, '[' + ls_name + '] 은 선언되지 않은 아규먼트 명입니다')
		return failure
	end if
	
	ls_expression = trim(mid(ls_linebuf[i], ll_pos + 1))
	
	lstr_arg = inv_args.of_get(ls_name)
	lstr_arg.arg_exp = ls_expression
	inv_args.of_put(ls_name, lstr_arg)
next

return success

end function

on pf_n_argument.create
call super::create
end on

on pf_n_argument.destroy
call super::destroy
end on

event constructor;call super::constructor;inv_args = create pf_n_hashtable
inv_exp = create pf_n_expression

end event

event destructor;call super::destructor;if isvalid(inv_args) then destroy inv_args
if isvalid(inv_exp) then destroy inv_exp

end event

