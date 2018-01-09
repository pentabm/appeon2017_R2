HA$PBExportHeader$pf_n_argument.sru
$PBExportComments$$$HEX34$$70b374c730d108c7c4b3b0c6200070c88cd62000dcc2200044c5dcad3cbab8d2200024c115c844c72000f4b2f9b258d594b2200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
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

public function integer of_checknotassignedargument ();// $$HEX14$$70b374c730d108c7c4b3b0c6200044c5dcad3cbab8d2200011c92000$$ENDHEX$$SetArgument $$HEX24$$24c115c818b4c0c9200020004ac540c7200020006dd5a9ba74c72000200088c794b2c0c92000200010c880ac5cd5e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: success=$$HEX9$$a8ba50b4200024c115c81cb42000c1c0dcd0$$ENDHEX$$, failure=$$HEX17$$24c115c818b4c0c9200020004ac540c7200020006dd5a9ba74c72000200088c74cc7$$ENDHEX$$

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
	this.of_displayerrormessage(ipo_target, '[' + ls_notassigned + '] $$HEX8$$24c115c818b4c0c920004ac540c72000$$ENDHEX$$RetrievalArgument $$HEX6$$00ac200088c7b5c2c8b2e4b2$$ENDHEX$$')
	return failure
end if

return success

end function

public function integer of_getallargumentvalue (ref any as_argvalue[]);// $$HEX22$$20c1b8c520001cb42000a8bae0b4200044c5dcad3cbab8d258c72000200012ac44c7200020006cad5cd5e4b2$$ENDHEX$$
// as_argvalue: $$HEX15$$12ac44c72000acb934d11bbc44c7200008b87cd3f0b7a4c22000c0bc18c2$$ENDHEX$$($$HEX2$$30bcf4c5$$ENDHEX$$)
// $$HEX3$$acb934d112ac$$ENDHEX$$: success=$$HEX2$$31c1f5ac$$ENDHEX$$, failure=$$HEX2$$e4c228d3$$ENDHEX$$

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

protected function any of_converttoargumenttype (string as_strval, string as_argtype);// $$HEX27$$44c5dcad3cbab8d22000c0d085c7d0c52000deb9b0cd1cc12000200038bb90c7f4c544c72000200015d6c0bc58d6200020005cd5e4b2$$ENDHEX$$
// $$HEX21$$30bcf4c5c0d085c72000200044c5dcad3cbab8d294b220002000c0c9d0c618b4c0c9200020004ac54cc7$$ENDHEX$$
// as_strval: $$HEX9$$15d6c0bc58d660d52000200038bb90c7f4c5$$ENDHEX$$
// as_argtype: $$HEX8$$15d6c0bc58d660d520002000c0d085c7$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX7$$15d6c0bc58d61cb42000200012ac$$ENDHEX$$

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
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX22$$30bcf4c5c0d085c7200044c5dcad3cbab8d294b220002000c0c9d0c618b4c0c9200020004ac5b5c2c8b2e4b2$$ENDHEX$$')
end choose

return la_retval

end function

public function integer of_setargument (string as_argname, any aa_argvalue);// $$HEX26$$70b374c730d108c7c4b3b0c6d0c5200020c1b8c51cb4200044c5dcad3cbab8d258c7200012ac44c7200024c115c869d5c8b2e4b2$$ENDHEX$$
// $$HEX28$$acc0a9c690c700ac2000c1c911c8200044c5dcad3cbab8d2200012ac44c7200024c115c8200060d520004cb5200038d69ccd29b4c8b2e4b2$$ENDHEX$$
// as_argname: $$HEX18$$24c115c860d5200070b374c730d108c7c4b3b0c6200044c5dcad3cbab8d2200085ba6dce$$ENDHEX$$
// aa_argvalue: $$HEX12$$24c115c860d5200070b374c730d108c7c4b3b0c6200012ac$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: success=$$HEX2$$31c1f5ac$$ENDHEX$$, failure=$$HEX2$$e4c228d3$$ENDHEX$$

string ls_name, ls_value
string ls_obj, ls_prop
long ll_row, ll_pos, ll_lastpos
windowobject lwo_ref
pf_s_argument lstr_arg

// $$HEX7$$44c5dcad3cbab8d2200085ba6dce$$ENDHEX$$
if isnull(as_argname) then return no_action
if isnull(aa_argvalue) then return no_action

ls_name = trim(as_argname)
if not inv_args.of_containskey(ls_name) then
	// $$HEX29$$20c1b8c51cb4200044c5dcad3cbab8d200ac2000c6c53cc774ba200024c658b9200054badcc2c0c920005cd4dcc258d5c0c920004ac5e0ac2000$$ENDHEX$$failure(-1) $$HEX3$$acb934d12000$$ENDHEX$$
	//this.of_displayerrormessage(ipo_target, '[' + ls_name + '] $$HEX19$$40c7200020c1b8c518b4c0c920004ac540c7200044c5dcad3cbab8d2200085ba85c7c8b2e4b2$$ENDHEX$$')
	return failure
end if

lstr_arg = inv_args.of_get(ls_name)
ls_value = string(aa_argvalue)

choose case classname(aa_argvalue)
	case 'string'
		if (left(ls_value, 1) = "'" and right(ls_value, 1) = '"') or (left(ls_value, 1) = "'" and right(ls_value, 1) = "'") then
			lstr_arg.arg_exp = ls_value
		else
			// $$HEX7$$24c60cbe1dc8b8d2200085ba6dce$$ENDHEX$$
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
								this.of_displayerrormessage(ipo_target, '[' + ls_obj + '] $$HEX24$$94b2200020c1b8c518b4c0c920004ac540c7200008c7c4b3b0c62000e8ceb8d264b8200085ba6dce200085c7c8b2e4b2$$ENDHEX$$')
								return failure
							end if
						else
							// $$HEX4$$89d588bc38d62000$$ENDHEX$$GET
							ll_pos = pos(ls_prop, '[')
							if ll_pos > 0 then
								ll_lastpos = pos(ls_prop, ']', ll_pos + 1)
								if ll_lastpos = 0 then
									this.of_displayerrormessage(ipo_target, '$$HEX4$$98c7bbba1cb42000$$ENDHEX$$Syntax $$HEX3$$85c7c8b2e4b2$$ENDHEX$$~r~n' + '[' + ls_prop + ']')
									return failure
								end if
								ll_row = long(mid(ls_prop, ll_pos + 1, ll_lastpos - ll_pos - 1))
								ls_prop = left(ls_prop, ll_pos - 1)
							else
								ll_row = 0
							end if
							
							// $$HEX13$$08c7c4b3b0c62000e8ceb8d264b8200085ba6dce200055d678c7$$ENDHEX$$
							lwo_ref = iw_parent.dynamic of_getwindowobjectbyname(ls_obj)
							if not isvalid(lwo_ref) then
								this.of_displayerrormessage(ipo_target, '[' + ls_obj + '] $$HEX24$$94b2200020c1b8c518b4c0c920004ac540c7200008c7c4b3b0c62000e8ceb8d264b8200085ba6dce200085c7c8b2e4b2$$ENDHEX$$')
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

public function integer of_displayerrormessage (readonly powerobject apo_mesgobj, readonly string as_mesgtext);// $$HEX37$$24c658b900ac20001cbcddc05cd5200024c60cbe1dc8b8d285ba44c72000ecd368d55cd52000d0c5ecb7200054badcc2c0c97cb9200014b5a4c20cd508b874c7200069d5c8b2e4b22000$$ENDHEX$$
// apo_mesgobj : $$HEX12$$24c658b900ac20001cbcddc05cd5200024c60cbe1dc8b8d2$$ENDHEX$$
// as_mesgtext : $$HEX6$$24c658b9200054badcc2c0c9$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$
// messagebox$$HEX6$$58c72000acb934d1200012ac$$ENDHEX$$

string ls_title

choose case apo_mesgobj.typeof()
	case datawindow!
		ls_title = '[' + apo_mesgobj.dynamic of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$'
	case datastore!
		ls_title = '[' + apo_mesgobj.classname() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$'
	case datawindowchild!
		ls_title = '[' + idw_parent.classname() + '.' + is_dwobject + '] dddw $$HEX2$$4cc5bcb9$$ENDHEX$$'
end choose

return messagebox(ls_title, as_mesgtext)

end function

public function integer of_getrefobjinfo (string as_ref_str, ref string as_ref_type, ref windowobject awo_ref_obj, ref string as_ref_prop, ref long al_ref_row);// $$HEX27$$44c5dcad3cbab8d22000c0d085c7c4bc5cb8200038cc70c860d5200024c60cbe1dc8b8d2200015c8f4bc7cb920006cad69d5c8b2e4b2$$ENDHEX$$.
// $$HEX9$$04d6acc72000acc0a9c6200048c5200068d5$$ENDHEX$$. $$HEX12$$38cc70c8200024c60cbe1dc8b8d2200015c8f4bc94b22000$$ENDHEX$$pf_n_expression $$HEX5$$d0c51cc1200098ccacb9$$ENDHEX$$.

string ls_obj, ls_prop
long ll_pos, ll_lastpos, ll_row
windowobject lwo_ref

// $$HEX7$$24c60cbe1dc8b8d2200085ba6dce$$ENDHEX$$
ll_pos = pos(as_ref_str, '.')
if ll_pos = 0 then
	this.of_displayerrormessage(ipo_target, 'RetrievalArgument$$HEX6$$58c7200015d6dcd094b22000$$ENDHEX$$"$$HEX5$$44c5dcad3cbab8d285ba$$ENDHEX$$=$$HEX5$$24c60cbe1dc8b8d285ba$$ENDHEX$$.$$HEX4$$04d55cb87cd3f0d2$$ENDHEX$$" $$HEX3$$85c7c8b2e4b2$$ENDHEX$$')
	return failure
end if

ls_obj = trim(left(as_ref_str, ll_pos - 1))
ls_prop = trim(mid(as_ref_str, ll_pos + 1))

if right(ls_prop, 2) = '()' then
	ls_prop = ls_prop
end if

choose case lower(ls_obj)
	// gnv_session $$HEX6$$00ae5cb88cbc2000c0bc18c2$$ENDHEX$$
	case 'session'
		as_ref_type = 'session'
		awo_ref_obj = lwo_ref
		as_ref_prop = ls_prop
		al_ref_row = 0
	// $$HEX2$$c1c018c2$$ENDHEX$$
	case 'constant'
		as_ref_type = 'constant'
		awo_ref_obj = lwo_ref
		as_ref_prop = ls_prop
		al_ref_row = 0
	case else
		// getter $$HEX2$$68d518c2$$ENDHEX$$
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
						this.of_displayerrormessage(ipo_target, '[' + ls_obj + '] $$HEX24$$94b2200020c1b8c518b4c0c920004ac540c7200008c7c4b3b0c62000e8ceb8d264b8200085ba6dce200085c7c8b2e4b2$$ENDHEX$$')
						return failure
					end if
			end choose
		else
			// $$HEX4$$89d588bc38d62000$$ENDHEX$$GET
			ll_pos = pos(ls_prop, '[')
			if ll_pos > 0 then
				ll_lastpos = pos(ls_prop, ']', ll_pos + 1)
				if ll_lastpos = 0 then
					this.of_displayerrormessage(ipo_target, '$$HEX4$$98c7bbba1cb42000$$ENDHEX$$Syntax $$HEX3$$85c7c8b2e4b2$$ENDHEX$$~r~n' + '[' + ls_prop + ']')
					return failure
				end if
				ll_row = long(mid(ls_prop, ll_pos + 1, ll_lastpos - ll_pos - 1))
				ls_prop = left(ls_prop, ll_pos - 1)
			else
				ll_row = 0
			end if
			
			// $$HEX13$$08c7c4b3b0c62000e8ceb8d264b8200085ba6dce200055d678c7$$ENDHEX$$
			lwo_ref = iw_parent.dynamic of_getwindowobjectbyname(ls_obj)
			if not isvalid(lwo_ref) then
				this.of_displayerrormessage(ipo_target, '[' + ls_obj + '] $$HEX24$$94b2200020c1b8c518b4c0c920004ac540c7200008c7c4b3b0c62000e8ceb8d264b8200085ba6dce200085c7c8b2e4b2$$ENDHEX$$')
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
				this.of_displayerrormessage(ipo_target, '[' + string(lw_ref.dynamic of_gettitle()) + '] $$HEX25$$d0c5200038cc70c860d5200018c2200088c794b2200070b374c730d100ac200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$(RowCount=0)')
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
						this.of_displayerrormessage(ipo_target, "[" + ls_title + "] $$HEX16$$44d518c2200080acc9c0200070c874ac44c7200085c725b8200058d538c194c6$$ENDHEX$$")
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
				this.of_displayerrormessage(ipo_target, '$$HEX22$$30bcf4c5c0d085c7200044c5dcad3cbab8d294b220002000c0c9d0c618b4c0c9200020004ac5b5c2c8b2e4b2$$ENDHEX$$')
				return failure
		end choose
		
		if lb_required = true then
			if isnull(aa_argvalue) then
				ls_title = trim(lw_ref.describe(as_ref_prop + "_t.text"))
				if ls_title = '!' or ls_title = '?' or ls_title = '' then ls_title = as_ref_prop
				this.of_displayerrormessage(ipo_target, "[" + ls_title + "] $$HEX16$$44d518c2200080acc9c0200070c874ac44c7200085c725b8200058d538c194c6$$ENDHEX$$")
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

public function integer of_getargumentvalue (string as_argname, ref any aa_argvalue);// $$HEX20$$20c1b8c520001cb42000200044c5dcad3cbab8d258c72000200012ac44c7200020006cad5cd5e4b2$$ENDHEX$$
// as_argname: $$HEX13$$12ac44c720006cad60d5200044c5dcad3cbab8d2200085ba6dce$$ENDHEX$$
// as_argvalue: $$HEX15$$12ac44c72000acb934d11bbc44c7200008b87cd3f0b7a4c22000c0bc18c2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: success=$$HEX2$$31c1f5ac$$ENDHEX$$, failure=$$HEX2$$e4c228d3$$ENDHEX$$

pf_s_argument lstr_arg
string ls_result
integer li_retval

if not inv_args.of_containskey(as_argname) then
	this.of_displayerrormessage(ipo_target, '[' + as_argname  + '] $$HEX20$$94b2200020c1b8c518b4c0c920004ac540c7200044c5dcad3cbab8d2200085ba6dce85c7c8b2e4b2$$ENDHEX$$')
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

public subroutine of_initialize (powerobject apo_target, window awo_parent);// $$HEX18$$44c5dcad3cbab8d220001cc144bea4c27cb9200008cd30ae54d658d594b2200068d518c2$$ENDHEX$$
// adw_datawindow: $$HEX20$$44c5dcad3cbaa4c220001cc144bea4c27cb920001cc8f5ac60d5200070b374c730d108c7c4b3b0c6$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$c6c54cc7$$ENDHEX$$

if not isvalid(apo_target) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX16$$2cc614bc74b9c0c920004ac540c7200068d518c238d69ccd200085c7c8b2e4b2$$ENDHEX$$.~r~npf_n_argument.of_registertarget()')
	return
end if

// $$HEX14$$98ccacb900b3c1c0200070b374c730d108c7c4b3b0c62000f4bc00ad$$ENDHEX$$
ipo_target = apo_target

// $$HEX9$$80bda8ba200008c7c4b3b0c62000f4bc00ad$$ENDHEX$$
iw_parent = awo_parent

// $$HEX17$$70b374c730d108c7c4b3b0c6200044c5dcad3cbab8d2200015c8f4bc2000f4bc00ad$$ENDHEX$$
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

// Expression Object $$HEX2$$24c115c8$$ENDHEX$$
inv_exp.of_initialize(ipo_target, iw_parent)

end subroutine

public subroutine of_initialize (powerobject apo_target, window awo_parent, datawindow adw_parent, string as_dwobject);// DDDW$$HEX13$$a9c6200044c5dcad3cbab8d2200008cd30ae54d6200068d518c2$$ENDHEX$$
this.of_initialize(apo_target, awo_parent)

this.idw_parent = adw_parent
this.is_dwobject = as_dwobject

return

end subroutine

public function integer of_parsearguments (string as_arguments);// as_argumentss $$HEX26$$12ac44c7200070b374c730d108c7c4b3b0c6200044c5dcad3cbab8d2200024c115c8d0c5200030b57cb720000cd3f1c25cd5e4b2$$ENDHEX$$
// as_argumentss $$HEX4$$15d6dcd094b22000$$ENDHEX$$'$$HEX5$$44c5dcad3cbab8d285ba$$ENDHEX$$=$$HEX4$$24c60cbe1dc8b8d2$$ENDHEX$$.$$HEX3$$38cc70c812ac$$ENDHEX$$' $$HEX5$$15d6dcd085c7c8b2e4b2$$ENDHEX$$
// $$HEX16$$38cc70c8200000aca5b25cd5200024c60cbe1dc8b8d22000c0d085c740c72000$$ENDHEX$${ session, datawindow, statictext } $$HEX3$$85c7c8b2e4b2$$ENDHEX$$
// $$HEX14$$44c5dcad3cbab8d200ac2000ecc5ecb71cac7cc72000bdacb0c62000$$ENDHEX$$';' $$HEX9$$3cc75cb820006cad84bd200069d5c8b2e4b2$$ENDHEX$$
// as_argumentss: $$HEX8$$44c5dcad3cbab8d2200015c858c712ac$$ENDHEX$$($$HEX1$$08c6$$ENDHEX$$: "sys_id=session.sys_id; dept_cd=dw_cond.dept_cd")
// $$HEX3$$acb934d112ac$$ENDHEX$$: success $$HEX3$$10b694b22000$$ENDHEX$$failure

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
		this.of_displayerrormessage(ipo_target, 'RetrievalArgument$$HEX6$$58c7200015d6dcd094b22000$$ENDHEX$$"$$HEX5$$44c5dcad3cbab8d285ba$$ENDHEX$$=$$HEX5$$24c60cbe1dc8b8d285ba$$ENDHEX$$.$$HEX4$$04d55cb87cd3f0d2$$ENDHEX$$" $$HEX3$$85c7c8b2e4b2$$ENDHEX$$')
		return failure
	end if
	
	ls_name = trim(left(ls_linebuf[i], ll_pos - 1))
	
	// Argument $$HEX11$$b4b0a9c6200011c9200008c67dc5b4c520001cc870ac$$ENDHEX$$
	choose case lower(ls_name)
		case 'required', 'verticalcenter', 'posticon', 'dddwinsertrow'
			continue
	end choose
	
	if not inv_args.of_containskey(ls_name) then
		this.of_displayerrormessage(ipo_target, '[' + ls_name + '] $$HEX19$$40c7200020c1b8c518b4c0c920004ac540c7200044c5dcad3cbab8d2200085ba85c7c8b2e4b2$$ENDHEX$$')
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

