HA$PBExportHeader$pf_n_expression.sru
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

public function integer of_evaluate (string as_expression, ref string as_result);// $$HEX4$$fcc8b4c5c4c92000$$ENDHEX$$expression $$HEX13$$58c72000b0acfcac200012ac44c72000b0c09ccd69d5c8b2e4b2$$ENDHEX$$
// format1 : dw_name.evaluate(expression)
// format2 : expression only

string ls_objref[]
string ls_object, ls_property, ls_result
string ls_describe, ls_quote = '"'
string ls_eventname
long ll_refcnt, i, ll_pos
windowobject lwo_refobj

// Evaluate $$HEX9$$68d518c22000acc0a9c65cd52000bdacb0c6$$ENDHEX$$
ll_pos = pos(as_expression, '.evaluate')
if ll_pos > 0 then
	string ls_objtmp, ls_exptmp
	
	ls_objtmp = left(as_expression, ll_pos - 1)
	lwo_refobj = iw_parent.dynamic of_getwindowobjectbyname(ls_objtmp)
	if not isvalid(lwo_refobj) then
		messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$[pf_n_Expression.of_Evaluate]', '[' + ls_objtmp + '] $$HEX24$$94b2200020c1b8c518b4c0c920004ac540c7200008c7c4b3b0c62000e8ceb8d264b8200085ba6dce200085c7c8b2e4b2$$ENDHEX$$')
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
		// gnv_session $$HEX2$$38cc70c8$$ENDHEX$$
		case 'session'
			any la_result
			
			if not gnv_session.of_containskey(ls_property) then
				messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$', '[' + ls_property + '] $$HEX13$$94b22000200020c1b8c518b4c0c9200020004ac540c720002000$$ENDHEX$$SESSION $$HEX4$$12ac85c7c8b2e4b2$$ENDHEX$$')
				return failure
			end if
			
			la_result = gnv_session.of_get(ls_property)
			ls_result = string(la_result)
			if classname(la_result) = "string" then
				ls_result = "'" + ls_result + "'"
			end if
		// constant $$HEX2$$98ccacb9$$ENDHEX$$
		case 'constant'
			if (left(ls_property, 1) = "'" and right(ls_property, 1) = "'") or (left(ls_property, 1) = '"' and right(ls_property, 1) = '"') then
				ls_result = ls_property
			else
				ls_result = "'" + ls_property + "'"
			end if
		// Datawindow GetItem $$HEX2$$98ccacb9$$ENDHEX$$
		case else
			if this.of_getobjectproperty(ls_object, ls_property, ls_result) = failure then
				return failure
			end if
	end choose
	
	as_expression = pf_f_replaceall(as_expression, ls_objref[i], ls_result)
next

//string ls_temp
//ls_temp = inv_regexp.of_replaceall(as_expression, "\'([^\'\\\\]|\\\\.)*\'", "@STR")

// $$HEX4$$68d518c238d69ccd$$ENDHEX$$
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

// $$HEX6$$89d588bc38d620000cd3f1c2$$ENDHEX$$
ll_pos = pos(as_property, '[')
if ll_pos > 0 then
	ll_lastpos = pos(as_property, ']', ll_pos + 1)
	if ll_lastpos = 0 then
		messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$[pf_n_Expression.of_GetObjectProperty]', '$$HEX4$$98c7bbba1cb42000$$ENDHEX$$Syntax $$HEX3$$85c7c8b2e4b2$$ENDHEX$$~r~n' + '[' + as_property + ']')
		return failure
	end if
	ll_row = long(mid(as_property, ll_pos + 1, ll_lastpos - ll_pos - 1))
	as_property = left(as_property, ll_pos - 1)
else
	ll_row = 0
end if

// $$HEX11$$08c7c4b3b0c6200038cc70c8200024c60cbe1dc8b8d2$$ENDHEX$$
windowobject lwo_refobj

lwo_refobj = iw_parent.dynamic of_getwindowobjectbyname(as_object)
if not isvalid(lwo_refobj) then
	messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$[pf_n_Expression.of_GetObjectProperty]', '[' + as_object + '] $$HEX24$$94b2200020c1b8c518b4c0c920004ac540c7200008c7c4b3b0c62000e8ceb8d264b8200085ba6dce200085c7c8b2e4b2$$ENDHEX$$')
	return failure
end if

// $$HEX15$$38cc70c8200024c60cbe1dc8b8d22000c0d085c7c4bc20008dc131c112ac$$ENDHEX$$
choose case lwo_refobj.typeof()
	case datawindow!
		datawindow ldw_ref
		ldw_ref = lwo_refobj
		if ldw_ref.accepttext() <> 1 then return failure
		
		if ll_row = 0 then
			ll_row = ldw_ref.getrow()
			if ll_row = 0 then
				messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$[pf_n_Expression.of_GetObjectProperty]', '[' + string(ldw_ref.dynamic of_gettitle()) + '] $$HEX25$$d0c5200038cc70c860d5200018c2200088c794b2200070b374c730d100ac200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$(RowCount=0)')
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
						messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', "[" + ls_title + "] $$HEX16$$44d518c2200080acc9c0200070c874ac44c7200085c725b8200058d538c194c6$$ENDHEX$$")
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
				messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$[pf_n_Expression.of_GetObjectProperty]', '[' + string(ldw_ref.dynamic of_gettitle()) + '] $$HEX3$$d0c51cc12000$$ENDHEX$$' + as_property + ' $$HEX13$$eccefcb744c720003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
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
				messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$[pf_n_Expression.of_GetObjectProperty]', '[' + lst_ref.classname() + '] $$HEX5$$24c60cbe1dc8b8d22000$$ENDHEX$$' + as_property + ' $$HEX13$$8dc131c144c720003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
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
				messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$[pf_n_Expression.of_GetObjectProperty]', '[' + lsle_ref.classname() + '] $$HEX5$$24c60cbe1dc8b8d22000$$ENDHEX$$' + as_property + ' $$HEX13$$8dc131c144c720003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
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
				messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$[pf_n_Expression.of_GetObjectProperty]', '[' + lmle_ref.classname() + '] $$HEX5$$24c60cbe1dc8b8d22000$$ENDHEX$$' + as_property + ' $$HEX13$$8dc131c144c720003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
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
				messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$[pf_n_Expression.of_GetObjectProperty]', '[' + lem_ref.classname() + '] $$HEX5$$24c60cbe1dc8b8d22000$$ENDHEX$$' + as_property + ' $$HEX13$$8dc131c144c720003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
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
				messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$[pf_n_Expression.of_GetObjectProperty]', '[' + lrb_ref.classname() + '] $$HEX5$$24c60cbe1dc8b8d22000$$ENDHEX$$' + as_property + ' $$HEX13$$8dc131c144c720003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
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
				messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$[pf_n_Expression.of_GetObjectProperty]', '[' + lcb_ref.classname() + '] $$HEX5$$24c60cbe1dc8b8d22000$$ENDHEX$$' + as_property + ' $$HEX13$$8dc131c144c720003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
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
				messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$[pf_n_Expression.of_GetObjectProperty]', '[' + llb_ref.classname() + '] $$HEX5$$24c60cbe1dc8b8d22000$$ENDHEX$$' + as_property + ' $$HEX13$$8dc131c144c720003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
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
				messagebox('$$HEX10$$44c5dcad3cbab8d2200024c115c8200024c658b9$$ENDHEX$$[pf_n_Expression.of_GetObjectProperty]', '[' + lddlb_ref.classname() + '] $$HEX5$$24c60cbe1dc8b8d22000$$ENDHEX$$' + as_property + ' $$HEX13$$8dc131c144c720003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
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

public subroutine of_initialize (powerobject apo_target, window awo_parent);// $$HEX18$$44c5dcad3cbab8d220001cc144bea4c27cb9200008cd30ae54d658d594b2200068d518c2$$ENDHEX$$
// adw_datawindow: $$HEX20$$44c5dcad3cbaa4c220001cc144bea4c27cb920001cc8f5ac60d5200070b374c730d108c7c4b3b0c6$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$c6c54cc7$$ENDHEX$$

// $$HEX12$$80bda8ba200070b374c730d108c7c4b3b0c62000f1b45db8$$ENDHEX$$
if not isvalid(apo_target) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX16$$2cc614bc74b9c0c920004ac540c7200068d518c238d69ccd200085c7c8b2e4b2$$ENDHEX$$.~r~npf_n_expression.of_initialize()')
	return
end if

// $$HEX14$$98ccacb900b3c1c0200070b374c730d108c7c4b3b0c62000f4bc00ad$$ENDHEX$$
ipo_target = apo_target

// $$HEX12$$80bda8ba200070b374c730d108c7c4b3b0c62000f4bc00ad$$ENDHEX$$
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

