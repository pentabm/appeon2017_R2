$PBExportHeader$pf_n_expression.sru
forward
global type pf_n_expression from pf_n_nonvisualobject
end type
end forward

global type pf_n_expression from pf_n_nonvisualobject
end type
global pf_n_expression pf_n_expression

type variables
private:
	window iw_parent
	powerobject ipo_target
	pf_n_regexp inv_regexp

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_evaluate (string as_expression, ref string as_result)
public function integer of_getobjectproperty (string as_object, string as_property, ref string as_result)
public subroutine of_initialize (powerobject apo_target, window awo_parent)
end prototypes

public function string of_getclassname ();return 'pf_n_expression'

end function

public function integer of_evaluate (string as_expression, ref string as_result);// 주어진 expression 의 결과 값을 산출합니다
// format1 : dw_name.evaluate(expression)
// format2 : expression only

string ls_objref[]
string ls_object, ls_property, ls_result
string ls_describe, ls_quote = '"'
string ls_eventname
long ll_refcnt, i, ll_pos
windowobject lwo_refobj

// Evaluate 함수 사용한 경우
ll_pos = pos(as_expression, '.evaluate')
if ll_pos > 0 then
	string ls_objtmp, ls_exptmp
	
	ls_objtmp = left(as_expression, ll_pos - 1)
	lwo_refobj = iw_parent.dynamic of_getwindowobjectbyname(ls_objtmp)
	if not isvalid(lwo_refobj) then
		messagebox('아규먼트 설정 오류[pf_n_Expression.of_Evaluate]', '[' + ls_objtmp + '] 는 선언되지 않은 윈도우 컨트롤 명칭 입니다')
		return failure
	end if
	
	ls_exptmp = trim(mid(as_expression, ll_pos + 9))
	if left(ls_exptmp, 1) = '(' and right(ls_exptmp, 1) = ')' then
		as_expression = mid(ls_exptmp, 2, len(ls_exptmp) - 2)
	end if
end if

ll_refcnt = inv_regexp.of_findmatches(as_expression, "(\w+\.\w+(\[\d+\])?)", ls_objref[])
for i = 1 to ll_refcnt
	ll_pos = pos(ls_objref[i], '.')
	ls_object = trim(left(ls_objref[i], ll_pos - 1))
	ls_property = trim(mid(ls_objref[i], ll_pos + 1))
	
	choose case ls_object
		// gnv_session 참조
		case 'session'
			any la_result
			
			if not gnv_session.of_containskey(ls_property) then
				messagebox('아규먼트 설정 오류', '[' + ls_property + '] 는  선언되지  않은  SESSION 값입니다')
				return failure
			end if
			
			la_result = gnv_session.of_get(ls_property)
			ls_result = string(la_result)
			if classname(la_result) = "string" then
				ls_result = "'" + ls_result + "'"
			end if
		// constant 처리
		case 'constant'
			if (left(ls_property, 1) = "'" and right(ls_property, 1) = "'") or (left(ls_property, 1) = '"' and right(ls_property, 1) = '"') then
				ls_result = ls_property
			else
				ls_result = "'" + ls_property + "'"
			end if
		// Datawindow GetItem 처리
		case else
			if this.of_getobjectproperty(ls_object, ls_property, ls_result) = failure then
				return failure
			end if
	end choose
	
	as_expression = pf_f_replaceall(as_expression, ls_objref[i], ls_result)
next

//string ls_temp
//ls_temp = inv_regexp.of_replaceall(as_expression, "\'([^\'\\\\]|\\\\.)*\'", "@STR")

// 함수호출
if isvalid(lwo_refobj) then
	ls_describe = 'evaluate(' + ls_quote + as_expression + ls_quote + ',' + string(lwo_refobj.dynamic getrow() ) + ')'
	as_result = lwo_refobj.dynamic describe(ls_describe)
	//messagebox('of_evaluate', 'as_expression=' + as_expression + ', referenced object=' + lwo_refobj.classname() + ', result=' + as_result)
else
	ls_describe = 'evaluate(' + ls_quote + as_expression + ls_quote + ',' + string(ipo_target.dynamic getrow() ) + ')'
	as_result = ipo_target.dynamic describe(ls_describe)
	//messagebox('of_evaluate', 'as_expression=' + as_expression + ', referenced object=' + ipo_target.classname() + ', result=' + as_result + ', describe=' + ls_describe)
end if

return success

end function

public function integer of_getobjectproperty (string as_object, string as_property, ref string as_result);long ll_pos, ll_lastpos, ll_row
any la_result
boolean lb_required
string ls_title
integer i

// 행번호 파싱
ll_pos = pos(as_property, '[')
if ll_pos > 0 then
	ll_lastpos = pos(as_property, ']', ll_pos + 1)
	if ll_lastpos = 0 then
		messagebox('아규먼트 설정 오류[pf_n_Expression.of_GetObjectProperty]', '잘못된 Syntax 입니다~r~n' + '[' + as_property + ']')
		return failure
	end if
	ll_row = long(mid(as_property, ll_pos + 1, ll_lastpos - ll_pos - 1))
	as_property = left(as_property, ll_pos - 1)
else
	ll_row = 0
end if

// 윈도우 참조 오브젝트
windowobject lwo_refobj

lwo_refobj = iw_parent.dynamic of_getwindowobjectbyname(as_object)
if not isvalid(lwo_refobj) then
	messagebox('아규먼트 설정 오류[pf_n_Expression.of_GetObjectProperty]', '[' + as_object + '] 는 선언되지 않은 윈도우 컨트롤 명칭 입니다')
	return failure
end if

// 참조 오브젝트 타입별 속성값
choose case lwo_refobj.typeof()
	case datawindow!
		datawindow ldw_ref
		ldw_ref = lwo_refobj
		if ldw_ref.accepttext() <> 1 then return failure
		
		if ll_row = 0 then
			ll_row = ldw_ref.getrow()
			if ll_row = 0 then
				messagebox('아규먼트 설정 오류[pf_n_Expression.of_GetObjectProperty]', '[' + string(ldw_ref.dynamic of_gettitle()) + '] 에 참조할 수 있는 데이터가 존재하지 않습니다(RowCount=0)')
				return failure
			end if
		end if
		
		if match(ldw_ref.describe(as_property + ".Tag"), "required *= *true") = true and ldw_ref.dynamic of_issearchcondition() = true then
			lb_required = true
		else
			lb_required = false
		end if
		
		choose case left(ldw_ref.describe(as_property + ".ColType"), 5)
			case 'char('
				la_result = ldw_ref.getitemstring(ll_row, as_property)
				if isnull(la_result) then la_result = ''
				if lb_required = true then
					if string(la_result) = '' then
						ls_title = trim(ldw_ref.describe(as_property + "_t.text"))
						if ls_title = '!' or ls_title = '?' or ls_title = '' then ls_title = as_property
						messagebox('알림', "[" + ls_title + "] 필수 검색 조건을 입력 하세요")
						return failure
					end if
				end if
				
			case 'date'
				la_result = ldw_ref.getitemdate(ll_row, as_property)
				if isnull(la_result) then la_result = date('1900-01-01')
			case 'time'
				la_result = ldw_ref.getitemtime(ll_row, as_property)
				if isnull(la_result) then la_result = time('00:00:00')
			case 'datet', 'times'
				la_result = ldw_ref.getitemdatetime(ll_row, as_property)
				if isnull(la_result) then la_result = datetime(date('1900-01-01'), time('00:00:00'))
			case 'decim'
				la_result = ldw_ref.getitemdecimal(ll_row, as_property)
				if isnull(la_result) then la_result = 0
			case 'int', 'long', 'numbe', 'real', 'ulong'
				la_result = ldw_ref.getitemnumber(ll_row, as_property)
				if isnull(la_result) then la_result = 0
			case else
				messagebox('아규먼트 설정 오류[pf_n_Expression.of_GetObjectProperty]', '[' + string(ldw_ref.dynamic of_gettitle()) + '] 에서 ' + as_property + ' 컬럼을 찾을 수 없습니다')
				return failure
		end choose
		
	case statictext!
		statictext lst_ref
		
		lst_ref = lwo_refobj
		choose case lower(as_property)
			case 'text'
				la_result = lst_ref.text
			case 'tag'
				la_result = lst_ref.tag
			case else
				messagebox('아규먼트 설정 오류[pf_n_Expression.of_GetObjectProperty]', '[' + lst_ref.classname() + '] 오브젝트 ' + as_property + ' 속성을 찾을 수 없습니다')
				return failure
		end choose
		
	case singlelineedit!
		singlelineedit lsle_ref
		
		lsle_ref = lwo_refobj
		choose case lower(as_property)
			case 'text'
				la_result = lsle_ref.text
			case 'tag'
				la_result = lsle_ref.tag
			case else
				messagebox('아규먼트 설정 오류[pf_n_Expression.of_GetObjectProperty]', '[' + lsle_ref.classname() + '] 오브젝트 ' + as_property + ' 속성을 찾을 수 없습니다')
				return failure
		end choose

	case multilineedit!
		multilineedit lmle_ref
		
		lmle_ref = lwo_refobj
		choose case lower(as_property)
			case 'text'
				la_result = lmle_ref.text
			case 'tag'
				la_result = lmle_ref.tag
			case else
				messagebox('아규먼트 설정 오류[pf_n_Expression.of_GetObjectProperty]', '[' + lmle_ref.classname() + '] 오브젝트 ' + as_property + ' 속성을 찾을 수 없습니다')
				return failure
		end choose
		
	case editmask!
		editmask lem_ref
		
		lem_ref = lwo_refobj
		choose case lower(as_property)
			case 'text'
				la_result = lem_ref.text
			case 'tag'
				la_result = lem_ref.tag
			case 'mask'
				la_result = lem_ref.mask
			case else
				messagebox('아규먼트 설정 오류[pf_n_Expression.of_GetObjectProperty]', '[' + lem_ref.classname() + '] 오브젝트 ' + as_property + ' 속성을 찾을 수 없습니다')
				return failure
		end choose
		
	case radiobutton!
		radiobutton lrb_ref
		
		lrb_ref = lwo_refobj
		choose case lower(as_property)
			case 'text'
				la_result = lrb_ref.text
			case 'tag'
				la_result = lrb_ref.tag
			case 'checked'
				la_result = lrb_ref.checked
			case else
				messagebox('아규먼트 설정 오류[pf_n_Expression.of_GetObjectProperty]', '[' + lrb_ref.classname() + '] 오브젝트 ' + as_property + ' 속성을 찾을 수 없습니다')
				return failure
		end choose
		
	case checkbox!
		checkbox lcb_ref
		
		lcb_ref = lwo_refobj
		choose case lower(as_property)
			case 'text'
				la_result = lcb_ref.text
			case 'tag'
				la_result = lcb_ref.tag
			case 'checked'
				la_result = lcb_ref.checked
			case else
				messagebox('아규먼트 설정 오류[pf_n_Expression.of_GetObjectProperty]', '[' + lcb_ref.classname() + '] 오브젝트 ' + as_property + ' 속성을 찾을 수 없습니다')
				return failure
		end choose
		
	case listbox!
		listbox llb_ref
		
		llb_ref = lwo_refobj
		choose case lower(as_property)
			case 'text'
				la_result = llb_ref.selecteditem()
			case 'tag'
				la_result = llb_ref.tag
			case 'item'
				for i = 1 to upperbound(llb_ref.item[])
					if i > 1 then la_result += "/"
					la_result += llb_ref.item[i]
				next
			case else
				messagebox('아규먼트 설정 오류[pf_n_Expression.of_GetObjectProperty]', '[' + llb_ref.classname() + '] 오브젝트 ' + as_property + ' 속성을 찾을 수 없습니다')
				return failure
		end choose
		
	case dropdownlistbox!
		dropdownlistbox lddlb_ref
		
		lddlb_ref = lwo_refobj
		choose case lower(as_property)
			case 'text'
				la_result = lddlb_ref.text
			case 'tag'
				la_result = lddlb_ref.tag
			case 'item'
				for i = 1 to upperbound(lddlb_ref.item[])
					if i > 1 then la_result += "/"
					la_result += lddlb_ref.item[i]
				next
			case else
				messagebox('아규먼트 설정 오류[pf_n_Expression.of_GetObjectProperty]', '[' + lddlb_ref.classname() + '] 오브젝트 ' + as_property + ' 속성을 찾을 수 없습니다')
				return failure
		end choose
end choose

if classname(la_result) = 'string' then
	as_result = "'" + la_result + "'"
else
	as_result = string(la_result)
end if

return success

end function

public subroutine of_initialize (powerobject apo_target, window awo_parent);// 아규먼트 서비스를 초기화하는 함수
// adw_datawindow: 아규먼스 서비스를 제공할 데이터윈도우
// 리턴값: 없음

// 부모 데이터윈도우 등록
if not isvalid(apo_target) then
	messagebox('알림', '올바르지 않은 함수호출 입니다.~r~npf_n_expression.of_initialize()')
	return
end if

// 처리대상 데이터윈도우 보관
ipo_target = apo_target

// 부모 데이터윈도우 보관
iw_parent = awo_parent

end subroutine

on pf_n_expression.create
call super::create
end on

on pf_n_expression.destroy
call super::destroy
end on

event constructor;call super::constructor;inv_regexp = create pf_n_regexp

// set ib_ignorecase = true and ib_global = true
inv_regexp.of_initialize(true, true)

end event

event destructor;call super::destructor;destroy inv_regexp

end event

