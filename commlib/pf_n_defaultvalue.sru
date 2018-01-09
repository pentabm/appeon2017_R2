HA$PBExportHeader$pf_n_defaultvalue.sru
$PBExportComments$$$HEX35$$70b374c730d108c7c4b3b0c6200089d594cd00ac2000dcc2200030aef8bc200024c115c8200012ac44c72000f4b2f9b258d594b2200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
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

public function boolean of_containscolumn (string as_columnname);// as_columnname $$HEX29$$d0c5200074d5f9b258d594b22000eccefcb785ba74c7200070b374c730d108c7c4b3b0c6d0c5200088c794b2c0c9200055d678c769d5c8b2e4b2$$ENDHEX$$
// as_columnname: $$HEX14$$55d678c760d5200070b374c730d108c7c4b3b0c62000eccefcb785ba$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: true=$$HEX6$$eccefcb785ba200088c74cc7$$ENDHEX$$, false=$$HEX6$$eccefcb785ba2000c6c54cc7$$ENDHEX$$

if isnull(as_columnname) then return false
if len(trim(as_columnname)) = 0 then return false

integer i, li_columncnt

li_columncnt = long(idw_target.describe("Datawindow.Column.Count"))
for i = 1 to li_columncnt
	if idw_target.describe("#" + string(i) + ".Name") = as_columnname then return true
next

return false

end function

public function any of_getdefaultvalue (string as_columnname);// $$HEX20$$20c1b8c520001cb42000200044c5dcad3cbab8d258c72000200012ac44c7200020006cad5cd5e4b2$$ENDHEX$$
// as_columnname: $$HEX13$$12ac44c720006cad60d5200044c5dcad3cbab8d2200085ba6dce$$ENDHEX$$
// as_argvalue: $$HEX15$$12ac44c72000acb934d11bbc44c7200008b87cd3f0b7a4c22000c0bc18c2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX3$$30aef8bc12ac$$ENDHEX$$

any la_retval
integer li_retval

li_retval = this.of_getdefaultvalue(as_columnname, la_retval)
return la_retval

end function

public function integer of_getdefaultvalue (string as_columnname, ref any aa_argvalue);// $$HEX20$$20c1b8c520001cb42000200044c5dcad3cbab8d258c72000200012ac44c7200020006cad5cd5e4b2$$ENDHEX$$
// as_columnname: $$HEX13$$08cd30ae12ac44c720006cad60d52000eccefcb7200085ba6dce$$ENDHEX$$
// as_argvalue: $$HEX15$$12ac44c72000acb934d11bbc44c7200008b87cd3f0b7a4c22000c0bc18c2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: success=$$HEX2$$31c1f5ac$$ENDHEX$$, failure=$$HEX2$$e4c228d3$$ENDHEX$$

pf_s_argument lstr_value
string ls_result
integer li_retval

if not inv_initvalues.of_containskey(as_columnname) then
	messagebox(idw_target.classname(), '[' + as_columnname  + '] $$HEX22$$94b2200008cd30ae12ac200020c1b8c518b4c0c920004ac540c72000eccefcb7200085ba6dce85c7c8b2e4b2$$ENDHEX$$')
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
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + as_columnname  + '] $$HEX17$$94b2200020c1b8c518b4c0c920004ac540c72000eccefcb785ba200085c7c8b2e4b2$$ENDHEX$$')
//	return failure
//end if
//
//lstr_value = inv_initvalues.of_get(as_columnname)
//
//choose case lstr_value.ref_type[1]
//	case 'session'
//		if not gnv_session.of_containskey(lstr_value.ref_prop[1]) then
//			messagebox('[pf_n_defaultvalue] $$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + lstr_value.ref_prop[1] + '] $$HEX13$$94b22000200020c1b8c518b4c0c9200020004ac540c720002000$$ENDHEX$$SESSION $$HEX4$$12ac85c7c8b2e4b2$$ENDHEX$$')
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
//						messagebox('[' + idw_target.dynamic of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + string(ldw_ref.dynamic of_gettitle()) + '] $$HEX25$$d0c5200038cc70c860d5200018c2200088c794b2200070b374c730d100ac200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$(RowCount=0)')
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
//									messagebox("$$HEX2$$4cc5bcb9$$ENDHEX$$", "[" + ls_title + "] $$HEX16$$44d518c2200080acc9c0200070c874ac44c7200085c725b8200058d538c194c6$$ENDHEX$$")
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
//						messagebox("$$HEX2$$4cc5bcb9$$ENDHEX$$", "[" + ls_title + "] $$HEX16$$44d518c2200080acc9c0200070c874ac44c7200085c725b8200058d538c194c6$$ENDHEX$$")
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

public function integer of_setdefaultvalue (long al_row, string as_column);// $$HEX16$$eccefcb7200030aef8bc12ac44c7200070b374c730d108c7c4b3b0c6d0c52000$$ENDHEX$$SetItem $$HEX6$$98ccacb9200069d5c8b2e4b2$$ENDHEX$$.
// al_row: SetItem $$HEX9$$44c7200018c289d560d5200089d5200018c2$$ENDHEX$$
// as_column: $$HEX15$$eccefcb7200030aef8bc12ac44c7200024c115c85cd52000eccefcb785ba$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=1, $$HEX2$$e4c228d3$$ENDHEX$$=-1

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

public subroutine of_initialize (datawindow adw_datawindow, window awo_parent);// $$HEX17$$30aef8bc12ac20001cc144bea4c27cb9200008cd30ae54d658d594b2200068d518c2$$ENDHEX$$
// adw_datawindow: $$HEX20$$44c5dcad3cbaa4c220001cc144bea4c27cb920001cc8f5ac60d5200070b374c730d108c7c4b3b0c6$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$c6c54cc7$$ENDHEX$$

// $$HEX12$$80bda8ba200070b374c730d108c7c4b3b0c62000f1b45db8$$ENDHEX$$
if not isvalid(adw_datawindow) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX16$$2cc614bc74b9c0c920004ac540c7200068d518c238d69ccd200085c7c8b2e4b2$$ENDHEX$$.~r~npf_n_defaultvalue.of_initialize()')
	return
end if

idw_target = adw_datawindow
iw_parent = awo_parent

// Expression Object $$HEX2$$24c115c8$$ENDHEX$$
inv_exp.of_initialize(idw_target, iw_parent)

end subroutine

public function integer of_parsedefaultvalues (string as_defaultvalues);// as_argumentss $$HEX25$$12ac44c7200070b374c730d108c7c4b3b0c6200030aef8bc12ac200024c115c8d0c5200030b57cb720000cd3f1c25cd5e4b2$$ENDHEX$$
// as_argumentss $$HEX4$$15d6dcd094b22000$$ENDHEX$$'$$HEX3$$eccefcb785ba$$ENDHEX$$=$$HEX4$$24c60cbe1dc8b8d2$$ENDHEX$$.$$HEX3$$38cc70c812ac$$ENDHEX$$' $$HEX5$$15d6dcd085c7c8b2e4b2$$ENDHEX$$
// $$HEX16$$38cc70c8200000aca5b25cd5200024c60cbe1dc8b8d22000c0d085c740c72000$$ENDHEX$${ session, constant, datawindow, statictext... $$HEX2$$f1b42000$$ENDHEX$$} $$HEX3$$85c7c8b2e4b2$$ENDHEX$$
// $$HEX13$$30aef8bc12ac74c72000ecc5ecb71cac7cc72000bdacb0c62000$$ENDHEX$$';' $$HEX9$$3cc75cb820006cad84bd200069d5c8b2e4b2$$ENDHEX$$
// as_defaultvalues: $$HEX10$$30aef8bc12ac200015c858c7200038bb90c7f4c5$$ENDHEX$$($$HEX1$$08c6$$ENDHEX$$: "sys_id=session.sys_id; dept_cd=dw_cond.dept_cd")
// $$HEX3$$acb934d112ac$$ENDHEX$$: success $$HEX3$$10b694b22000$$ENDHEX$$failure

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
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(pf_n_defaultvalue.of_setDefaultValues)', 'DefaultValue $$HEX6$$58c7200015d6dcd094b22000$$ENDHEX$$"$$HEX3$$eccefcb785ba$$ENDHEX$$=$$HEX5$$24c60cbe1dc8b8d285ba$$ENDHEX$$.$$HEX4$$04d55cb87cd3f0d2$$ENDHEX$$" $$HEX3$$85c7c8b2e4b2$$ENDHEX$$')
		return failure
	end if
	
	ls_colname = trim(left(ls_linebuf[i], ll_pos - 1))
	
	if not this.of_containscolumn(ls_colname) then
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(pf_n_defaultvalue.of_setDefaultValues)', '[' + ls_colname + '] $$HEX17$$40c7200020c1b8c518b4c0c920004ac540c72000eccefcb785ba200085c7c8b2e4b2$$ENDHEX$$')
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

public function integer of_setalldefaultvalue (long al_row);// $$HEX19$$a8bae0b42000eccefcb7200030aef8bc12ac44c7200070b374c730d108c7c4b3b0c6d0c52000$$ENDHEX$$al_row$$HEX2$$d0c52000$$ENDHEX$$SetItem $$HEX6$$98ccacb9200069d5c8b2e4b2$$ENDHEX$$.
// al_row: SetItem $$HEX9$$44c7200018c289d560d5200089d5200018c2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=1, $$HEX2$$e4c228d3$$ENDHEX$$=-1

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

