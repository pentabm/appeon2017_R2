HA$PBExportHeader$pf_n_hashtable.sru
$PBExportComments$$$HEX23$$74d5dcc24cd174c714be200030aea5b244c72000c0c9d0c658d594b2200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$. $$HEX8$$74d5dcc24cd174c714be74c780b72000$$ENDHEX$$Key $$HEX2$$40c62000$$ENDHEX$$Value $$HEX13$$7cb9200016ac94b2200090c7ccb86cad70c8200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_hashtable from pf_n_nonvisualobject
end type
end forward

global type pf_n_hashtable from pf_n_nonvisualobject
end type
global pf_n_hashtable pf_n_hashtable

type variables
constant string KEY_DWO_SYNTAX = 'release 8;table(column=(type=char(256) updatewhereclause=no name=keyname dbname="keyname" ) column=(type=number updatewhereclause=no name=itemrownum dbname="itemrownum" ))'

Constant Integer BinaryCompare = 0
Constant Integer TextCompare = 1
Constant Integer DatabaseCompare = 2

Protected:
	Datastore ids_Key
	OLEObject inv_HashKey
	String is_HashKey[]
	Any ia_HashItem[]

end variables

forward prototypes
public function string of_getclassname ()
public function any of_get (readonly string as_key)
public subroutine of_clear ()
public function integer of_remove (readonly string as_key)
public function integer of_put (readonly string as_key, readonly any aa_item)
public function blob of_getblob (readonly string as_key)
public function byte of_getbyte (readonly string as_key)
public function character of_getchar (readonly string as_key)
public function date of_getdate (readonly string as_key)
public function datetime of_getdatetime (readonly string as_key)
public function decimal of_getdecimal (readonly string as_key)
public function double of_getdouble (readonly string as_key)
public function integer of_getint (readonly string as_key)
public function long of_getlong (readonly string as_key)
public function boolean of_containskey (readonly string as_key)
public function boolean of_isempty ()
public function time of_gettime (readonly string as_key)
public function unsignedinteger of_getunsignedint (readonly string as_key)
public function unsignedlong of_getunsignedlong (readonly string as_key)
public function longlong of_getlonglong (readonly string as_key)
public function real of_getreal (readonly string as_key)
public function string of_getstring (readonly string as_key)
public function unsignedlong of_size ()
public function long of_keyset (ref string as_keys[])
public function long of_sortedkeyset (ref string as_keys[])
public function long of_find (string as_expression, long al_start, long al_end)
public function long of_find (string as_expression, long al_start)
public function string of_getkey (long al_row)
end prototypes

public function string of_getclassname ();return 'pf_n_hashtable'

end function

public function any of_get (readonly string as_key);// Returns the value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_null
ulong ll_index

setnull(la_null)
if isnull(as_key) then return la_null

any la_ret
blob lblb_ret
boolean lb_ret
byte lbt_ret
char lc_ret
date ldt_ret
datetime ldtm_ret
decimal ld_ret
double ldb_ret
integer li_ret
long ll_ret
real lr_ret
string ls_ret
time lt_ret
uint lui_ret
ulong lul_ret

choose case appeongetclienttype()
	case 'PB'
		if not isvalid(inv_hashkey) then return la_null
		
		if inv_hashkey.exists(as_key) then
			ll_index = inv_hashkey.item(as_key)
			return ia_hashitem[ll_index]
		end if
		
	case 'WEB'
		if not isvalid(inv_hashkey) then return la_null
		
		if inv_hashkey.exists(as_key) then
			ll_index = inv_hashkey.item(as_key)
			
			choose case classname(ia_hashitem[ll_index])
				case 'blob'
					lblb_ret = ia_hashitem[ll_index]
					return lblb_ret
				case 'boolean'
					lb_ret = ia_hashitem[ll_index]
					return lb_ret
				case 'byte'
					lbt_ret = ia_hashitem[ll_index]
					return lbt_ret
				case 'character', 'char'
					lc_ret = ia_hashitem[ll_index]
					return lc_ret
				case 'date'
					ldt_ret = ia_hashitem[ll_index]
					return ldt_ret
				case 'datetime'
					ldtm_ret = ia_hashitem[ll_index]
					return ldtm_ret
				case 'decimal', 'dec'
					ld_ret = ia_hashitem[ll_index]
					return ld_ret
				case 'double'
					ldb_ret = ia_hashitem[ll_index]
					return ldb_ret
				case 'integer', 'int'
					li_ret = ia_hashitem[ll_index]
					return li_ret
				case 'long'
					ll_ret = ia_hashitem[ll_index]
					return ll_ret
				case 'real'
					lr_ret = ia_hashitem[ll_index]
					return lr_ret
				case 'string'
					ls_ret = ia_hashitem[ll_index]
					return ls_ret
				case 'time'
					lt_ret = ia_hashitem[ll_index]
					return lt_ret
				case 'unsignedinteger', 'unsignedint', 'uint'
					lui_ret = ia_hashitem[ll_index]
					return lui_ret
				case 'unsignedlong', 'ulong'
					lul_ret = ia_hashitem[ll_index]
					return lul_ret
				case 'number'
					ld_ret = ia_hashitem[ll_index]
					return ld_ret
				case else
					return ia_hashitem[ll_index]
			end choose
		end if
		
	case 'MOBILE'
		if not isvalid(ids_key) then return la_null
		
		long ll_find
		ll_find = ids_key.find("keyname='" + trim(as_key) + "'", 1, ids_key.rowcount())
		if ll_find > 0 then
			ll_index = ids_key.getitemnumber(ll_find, 'itemrownum')
			
			choose case classname(ia_hashitem[ll_index])
				case 'blob'
					lblb_ret = ia_hashitem[ll_index]
					return lblb_ret
				case 'boolean'
					lb_ret = ia_hashitem[ll_index]
					return lb_ret
				case 'byte'
					lbt_ret = ia_hashitem[ll_index]
					return lbt_ret
				case 'character', 'char'
					lc_ret = ia_hashitem[ll_index]
					return lc_ret
				case 'date'
					ldt_ret = ia_hashitem[ll_index]
					return ldt_ret
				case 'datetime'
					ldtm_ret = ia_hashitem[ll_index]
					return ldtm_ret
				case 'decimal', 'dec'
					ld_ret = ia_hashitem[ll_index]
					return ld_ret
				case 'double'
					ldb_ret = ia_hashitem[ll_index]
					return ldb_ret
				case 'integer', 'int'
					li_ret = ia_hashitem[ll_index]
					return li_ret
				case 'long'
					ll_ret = ia_hashitem[ll_index]
					return ll_ret
				case 'real'
					lr_ret = ia_hashitem[ll_index]
					return lr_ret
				case 'string'
					ls_ret = ia_hashitem[ll_index]
					return ls_ret
				case 'time'
					lt_ret = ia_hashitem[ll_index]
					return lt_ret
				case 'unsignedinteger', 'unsignedint', 'uint'
					lui_ret = ia_hashitem[ll_index]
					return lui_ret
				case 'unsignedlong', 'ulong'
					lul_ret = ia_hashitem[ll_index]
					return lul_ret
				case 'number'
					ld_ret = ia_hashitem[ll_index]
					return ld_ret
				case else
					return ia_hashitem[ll_index]
			end choose
		end if
end choose

return la_null

end function

public subroutine of_clear ();// Clears this hashtable so that it contains no keys.
any la_empty[]
string ls_empty[]

choose case appeongetclienttype()
	case 'PB', 'WEB'
		if not isvalid(inv_hashkey) then return
		
		ia_hashitem = la_empty
		is_hashkey = ls_empty
		inv_hashkey.RemoveAll()
	case 'MOBILE'
		if not isvalid(ids_Key) then return
		
		ia_hashitem = la_empty
		ids_key.reset()
end choose

end subroutine

public function integer of_remove (readonly string as_key);// Removes the key (and its corresponding value) from this hashtable.
integer li_retval
ulong ll_index
any la_empty

setnull(li_retval)
if isnull(as_key) then return li_retval

choose case appeongetclienttype()
	case 'PB'
		if not isvalid(inv_hashkey) then return li_retval
		
		if inv_hashkey.exists(as_key) then
			ll_index = inv_hashkey.item(as_key)
			ia_hashitem[ll_index] = la_empty
			inv_hashkey.remove(as_key)
			li_retval = 1
		else
			li_retval = 0
		end if
	case 'WEB'
		if not isvalid(inv_hashkey) then return li_retval
		
		if inv_hashkey.exists(as_key) then
			ll_index = inv_hashkey.item(as_key)
			ia_hashitem[ll_index] = la_empty
			is_hashkey[ll_index] = ''
			inv_hashkey.remove(as_key)
			li_retval = 1
		else
			li_retval = 0
		end if
	case 'MOBILE'
		if not isvalid(ids_key) then return li_retval
		
		long ll_find
		ll_find = ids_key.find("keyname='" + trim(as_key) + "'", 1, ids_key.rowcount())
		if ll_find > 0 then
			ll_index = ids_key.getitemnumber(ll_find, 'itemrownum')
			ia_hashitem[ll_index] = la_empty
			ids_key.deleterow(ll_find)
			li_retval = 1
		else
			li_retval = 0
		end if
end choose

return li_retval

end function

public function integer of_put (readonly string as_key, readonly any aa_item);// Maps the specified key to the specified value in this hashtable.
ulong ll_index
integer li_retval

setnull(li_retval)
if isnull(as_key) then return li_retval
if isnull(aa_item) then return li_retval

choose case appeongetclienttype()
	case 'PB', 'WEB'
		if not isvalid(inv_hashkey) then return li_retval
		
		if inv_hashkey.exists(as_key) then
			ll_index = inv_hashkey.item(as_key)
		else
			ll_index = upperbound(ia_hashitem) + 1
			inv_hashkey.add(as_key, ll_index)
		end if
	case 'MOBILE'
		if not isvalid(ids_key) then return li_retval
		
		long ll_find, ll_new
		ll_find = ids_key.find("keyname='" + trim(as_key) + "'", 1, ids_key.rowcount())
		if ll_find > 0 then
			ll_index = ids_key.getitemnumber(ll_find, 'itemrownum')
		else
			ll_index = upperbound(ia_hashitem) + 1
			ll_new = ids_key.insertrow(0)
			ids_key.setitem(ll_new, 'keyname', as_key)
			ids_key.setitem(ll_new, 'itemrownum', ll_index)
		end if
end choose

if appeongetclienttype() = 'WEB' then is_hashkey[ll_index] = as_key
ia_hashitem[ll_index] = aa_item
return 1

end function

public function blob of_getblob (readonly string as_key);// Returns the blob value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_retval
blob lb_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	lb_retval = blob(la_retval)
end if

return lb_retval

end function

public function byte of_getbyte (readonly string as_key);// Returns the byte value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_retval
byte lbt_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	lbt_retval = byte(la_retval)
end if

return lbt_retval

end function

public function character of_getchar (readonly string as_key);// Returns the char value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_retval
char lc_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	lc_retval = char(la_retval)
end if

return lc_retval

end function

public function date of_getdate (readonly string as_key);// Returns the date value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_retval
date ld_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	ld_retval = date(la_retval)
end if

return ld_retval

end function

public function datetime of_getdatetime (readonly string as_key);// Returns the datetime value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_retval
datetime ldt_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	ldt_retval = datetime(la_retval)
end if

return ldt_retval

end function

public function decimal of_getdecimal (readonly string as_key);// Returns the decimal value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_retval
decimal ld_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	ld_retval = dec(la_retval)
end if

return ld_retval

end function

public function double of_getdouble (readonly string as_key);// Returns the double value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_retval
double ld_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	ld_retval = double(la_retval)
end if

return ld_retval

end function

public function integer of_getint (readonly string as_key);// Returns the int value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_retval
integer li_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	li_retval = integer(la_retval)
end if

return li_retval

end function

public function long of_getlong (readonly string as_key);// Returns the long value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_retval
long ll_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	ll_retval = long(la_retval)
end if

return ll_retval

end function

public function boolean of_containskey (readonly string as_key);// Tests if the specified object is a key in this hashtable.
boolean lb_retval
setnull(lb_retval)

choose case appeongetclienttype()
	case 'PB', 'WEB'
		if not isvalid(inv_hashkey) then return lb_retval
		if isnull(as_key) then return lb_retval
		
		lb_retval = inv_hashkey.exists(as_key)
		return lb_retval
	case 'MOBILE'
		if not isvalid(ids_Key) then return lb_retval
		
		long ll_find
		ll_find = ids_key.find("keyname='" + trim(as_key) + "'", 1, ids_key.rowcount())
		if ll_find > 0 then
			return true
		else
			return false
		end if
end choose

end function

public function boolean of_isempty ();// Tests if this hashtable maps no keys to values.

boolean lb_null
setnull(lb_null)

choose case appeongetclienttype()
	case 'PB', 'WEB'
		if not isvalid(inv_hashkey) then return lb_null
		
		if long(inv_hashkey.count) = 0 then
			return true
		else
			return false
		end if
	case 'MOBILE'
		if not isvalid(ids_key) then return lb_null
		
		if ids_key.rowcount() = 0 then
			return true
		else
			return false
		end if
end choose

end function

public function time of_gettime (readonly string as_key);// Returns the time value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_retval
time ltm_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	ltm_retval = time(la_retval)
end if

return ltm_retval

end function

public function unsignedinteger of_getunsignedint (readonly string as_key);// Returns the unsignedint value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_retval
uint lui_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	lui_retval = int(la_retval)
end if

return lui_retval

end function

public function unsignedlong of_getunsignedlong (readonly string as_key);// Returns the unsignedlong value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.

any la_retval
ulong lul_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	lul_retval = long(la_retval)
end if

return lul_retval

end function

public function longlong of_getlonglong (readonly string as_key);// Returns the longlong value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
// $$HEX2$$fcc858c7$$ENDHEX$$) Appeon$$HEX8$$d0c51cc12000acc0a9c658d574ba2000$$ENDHEX$$(Appeon $$HEX5$$e4c289d5200048baa4cd$$ENDHEX$$) $$HEX6$$24c658b920001cbcddc028b4$$ENDHEX$$.

any la_retval
longlong lll_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	lll_retval = longlong(la_retval)
end if

return lll_retval

end function

public function real of_getreal (readonly string as_key);// Returns the real value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_retval
real lr_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	lr_retval = real(la_retval)
end if

return lr_retval

end function

public function string of_getstring (readonly string as_key);// Returns the string value to which the specified key is mapped, 
// or null if this map contains no mapping for the key.
any la_retval
string ls_retval

la_retval = this.of_get(as_key)
if not isnull(la_retval) then
	ls_retval = string(la_retval)
end if

return ls_retval

end function

public function unsignedlong of_size ();// Returns the number of keys in this hashtable.
choose case appeongetclienttype()
	case 'PB', 'WEB'
		if not isvalid(inv_hashkey) then return -1
		return long(inv_hashkey.count)
	case 'MOBILE'
		if not isvalid(ids_key) then return -1
		return ids_key.rowcount()
end choose

end function

public function long of_keyset (ref string as_keys[]);// Returns a Set view of the keys contained in this map.

choose case appeongetclienttype()
	case 'PB'
		as_keys = inv_HashKey.Keys()
	case 'WEB'
		long ll_keycnt, i, j
		string ls_empty[]
		
		as_keys = ls_empty
		ll_keycnt = upperbound(is_hashkey)
		
		for i = 1 to ll_keycnt
			if is_hashkey[i] = '' then continue
			j += 1
			as_keys[j] = is_hashkey[i]
		next

	case 'MOBILE'
		if not isvalid(ids_key) then return -1
		as_keys = ids_key.object.keyname.current
end choose

return upperbound(as_keys)

end function

public function long of_sortedkeyset (ref string as_keys[]);// Returns a Set view of the sorted keys contained in this map.
datastore lds_temp
string ls_error
long ll_keycnt, i, ll_new

// check the size of hash
choose case appeongetclienttype()
	case 'PB', 'WEB'
		if long(inv_hashkey.count) = 0 then return no_action
	case 'MOBILE'
		if ids_key.rowcount() = 0 then return no_action
end choose

lds_temp = create datastore
lds_temp.create(KEY_DWO_SYNTAX, ls_error)
if len(ls_error) > 0 then
	messagebox('Error!!', '$$HEX12$$70b374c730d108c7c4b3b0c62000ddc031c12000d0c5ecb7$$ENDHEX$$~r~n' + ls_error)
	return -1
end if

choose case appeongetclienttype()
	case 'PB'
		lds_temp.object.keyname.current = inv_HashKey.Keys()
	case 'WEB'
		ll_keycnt = upperbound(is_hashkey)
		for i = 1 to ll_keycnt
			if is_hashkey[ll_keycnt] = '' then continue
			ll_new = lds_temp.insertrow(0)
			lds_temp.setitem(ll_new, 'keyname', is_hashkey[i])
		next
	case 'MOBILE'
		lds_temp.object.data = ids_key.object.data
end choose

// put the array in the datastore
lds_temp.SetSort("keyname asc")
lds_temp.Sort()

// get back the array
ll_keycnt = lds_temp.rowcount()
as_keys = lds_temp.object.keyname.current

destroy lds_temp
return ll_keycnt

end function

public function long of_find (string as_expression, long al_start, long al_end);// Finds the next row in a DataWindow or DataStore in which data meets a specified condition.
// Arguments>
// as_expression: A string whose value is the text pattern
// al_start: A value identifying the row location at which to begin the search.
// al_end: A value identifying the row location at which to end the search.
// Return Value>
// Returns the number of the first row that meets the search criteria within the search range.
// Returns 0 if no rows are found.

string ls_keys[]
long ll_start, ll_end, i

choose case appeongetclienttype()
	case 'PB'
		if not isvalid(inv_HashKey) then return -1
		
		ls_keys = inv_HashKey.Keys()
		
		if ll_start = 0 then ll_start = 1
		if ll_end = 0 then ll_end = long(inv_HashKey.Count)
		
		for i = ll_start to ll_end
			if match(ls_keys[i], as_expression) then
				return i
			end if
		next
	case 'WEB'
		if not isvalid(inv_HashKey) then return -1
		
		ls_keys = is_HashKey
		
		if ll_start = 0 then ll_start = 1
		if ll_end = 0 then ll_end = upperbound(is_HashKey)
		
		for i = ll_start to ll_end
			if ls_keys[i] <> '' then
				if match(ls_keys[i], as_expression) then
					return i
				end if
			end if
		next
	case 'MOBILE'
		if not isvalid(ids_key) then return -1
		if ll_start = 0 then ll_start = 1
		if ll_end = 0 then ll_end = ids_key.rowcount()
		
		for i = ll_start to ll_end
			if match(ids_key.getitemstring(i, 'keyname'), as_expression) then
				return i
			end if
		next
end choose

return 0

end function

public function long of_find (string as_expression, long al_start);// Finds the next row in a DataWindow or DataStore in which data meets a specified condition.
// Arguments>
// as_expression: A string whose value is the text pattern
// al_start: A value identifying the row location at which to begin the search.
// Return Value>
// Returns the number of the first row that meets the search criteria within the search range.
// Returns 0 if no rows are found.

return this.of_find(as_expression, al_start, 0)

end function

public function string of_getkey (long al_row);// al_row $$HEX3$$88bcf8c92000$$ENDHEX$$Key $$HEX8$$12ac44c72000acb934d169d5c8b2e4b2$$ENDHEX$$

string ls_keys[]
string ls_null
integer i, j
setnull(ls_null)

if isnull(al_row) then
	return ls_null
end if

choose case appeongetclienttype()
	case 'PB'
		if al_row <= 0 or al_row > long(inv_HashKey.Count) then
			messagebox('pf_f_HashTable.of_getKey()', '$$HEX13$$98c7bbba1cb4200044c5dcad3cbab8d2200012ac85c7c8b2e4b2$$ENDHEX$$.~r~nal_row = ' + string(al_row))
			return ls_null
		end if
		
		ls_keys = inv_HashKey.Keys()
		return ls_keys[al_row]
	case 'WEB'
		if al_row <= 0 or al_row > long(inv_HashKey.Count) then
			messagebox('pf_f_HashTable.of_getKey()', '$$HEX13$$98c7bbba1cb4200044c5dcad3cbab8d2200012ac85c7c8b2e4b2$$ENDHEX$$.~r~nal_row = ' + string(al_row))
			return ls_null
		end if
		
		for i = 1 to upperbound(is_hashkey)
			if is_hashkey[i] = '' then continue
			j ++
			if j = al_row then
				return is_hashkey[i]
			end if
		next
		
	case 'MOBILE'
		if al_row <=0 or al_row > ids_key.rowcount() then
			messagebox('pf_f_HashTable_appeon.of_getKey()', '$$HEX13$$98c7bbba1cb4200044c5dcad3cbab8d2200012ac85c7c8b2e4b2$$ENDHEX$$.~r~nal_row = ' + string(al_row))
			return ls_null
		end if
	
		return ids_key.getitemstring(al_row, 'keyname')
end choose

end function

on pf_n_hashtable.create
call super::create
end on

on pf_n_hashtable.destroy
call super::destroy
end on

event constructor;call super::constructor;choose case appeongetclienttype()
	case 'PB', 'WEB'
		integer li_retval
		
		inv_hashkey = create oleobject
		li_retval = inv_hashkey.connecttonewobject("Scripting.Dictionary")
		if li_retval = 0 then
			inv_hashkey.CompareMode = BinaryCompare
		else
			choose case li_retval
				case -1;  messagebox("Creating Hashtable Failure!", "Invalid Call: the argument is the Object property of a control")
				case -2;  messagebox("Creating Hashtable Failure!", "Class name not found")
				case -3;  messagebox("Creating Hashtable Failure!", "Object could not be created")
				case -4;  messagebox("Creating Hashtable Failure!", "Could not connect to object")
				case -9;  messagebox("Creating Hashtable Failure!", "Other error")
				case -15;  messagebox("Creating Hashtable Failure!", "COM+ is not loaded on this computer")
				case -16;  messagebox("Creating Hashtable Failure!", "Invalid Call: this function not applicable")
				case else; messagebox("Creating Hashtable Failure!", "Unknown Error")
			end choose
		end if
	case 'MOBILE'
		string ls_error
		
		ids_key = create datastore
		ids_key.create(KEY_DWO_SYNTAX, ls_error)
		if len(ls_error) > 0 then
			messagebox('pf_n_hashtable_appeon.constructor() Failure!!', '$$HEX12$$70b374c730d108c7c4b3b0c62000ddc031c12000d0c5ecb7$$ENDHEX$$~r~n' + ls_error)
		end if
end choose

end event

event destructor;call super::destructor;if isvalid(inv_hashkey) then
	inv_hashkey.disconnectobject()
	destroy inv_hashkey
end if

if isvalid(ids_key) then
	destroy ids_key
end if

end event

