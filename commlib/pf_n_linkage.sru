HA$PBExportHeader$pf_n_linkage.sru
$PBExportComments$$$HEX50$$70b374c730d108c7c4b3b0c6200061c558c120001cc144bea4c240c6200000adc4ac18b4b4c5200070b374c730d108c7c4b3b0c6200004ac58c72000f0c5c4ac200000adc4ac7cb92000f4b2f9b258d594b2200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
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

public function integer of_setuplinkeddatawindow (string as_uplinkeddw);// $$HEX19$$c1c004c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c67cb92000f1b45db85cd5e4b2$$ENDHEX$$
// $$HEX16$$f0c5c4ac1cb4200070b374c730d108c7b0c694b2200070c88cd61cc144bea4c2$$ENDHEX$$, $$HEX15$$00c8a5c71cc144bea4c22000acc0a9c6dcc2200074c7a9c629b4c8b2e4b2$$ENDHEX$$
// as_uplinkeddw: $$HEX16$$c1c004c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c6200085ba6dce$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: success=$$HEX4$$f1b45db831c1f5ac$$ENDHEX$$, failure=$$HEX4$$f1b45db8e4c228d3$$ENDHEX$$

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
	messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX24$$f0c5c4ac200024c115c85cd5200070b374c730d108c7c4b3b0c600ac200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$~r~n[' + as_uplinkeddw + ']')
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
		messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + ls_type + '] $$HEX23$$70b374c730d108c7c4b3b0c62000f0c5c4ac2000c0d085c740c72000c0c9d0c618b4c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$.~r~nSyntax Error!!')
		return failure
end choose

//messagebox('of_setuplinkeddatawindow', 'uplinked datawindow: ' + as_uplinkeddw + ', downlinked datawindow: ' + this.idw_target.classname() + ', linkage type: ' + is_linkagetype)
return success

end function

public function datawindow of_getuplinkeddatawindow ();// $$HEX20$$c1c004c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c67cb92000acb934d169d5c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX18$$c1c004c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c6200008b87cd3f0b7a4c2$$ENDHEX$$

datawindow ldw_empty

if not isvalid(idw_target) then
	return ldw_empty
else
	return idw_uplinked
end if

end function

public function integer of_checkifbothareusingthesametable (datawindow adw_uplinked);// $$HEX32$$50b420001cac58c7200070b374c730d108c7c4b3b0c600ac200019ac40c720004cd174c714be44c72000acc0a9c658d594b2c0c9200055d678c769d5c8b2e4b2$$ENDHEX$$($$HEX6$$04d6acc72000f8bbacc0a9c6$$ENDHEX$$)
// adw_uplinked: $$HEX18$$c1c004c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c6200008b87cd3f0b7a4c2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: success=$$HEX9$$19ac40c720004cd174c714be2000acc0a9c6$$ENDHEX$$, failure=$$HEX9$$e4b278b920004cd174c714be2000acc0a9c6$$ENDHEX$$

if not isvalid(idw_target) then return failure
if not isvalid(adw_uplinked) then return failure

string ls_2ndtable

ls_2ndtable = lower(idw_target.dynamic describe("DataWindow.Table.UpdateTable"))
choose case ls_2ndtable
	case '!', '?', ''
		return failure
end choose

// $$HEX20$$70b374c730d108c7c4b3b0c6200044be50ad5cb8c1c92000e4b2dcc2200091c731c160d5200083ac$$ENDHEX$$...
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

public function integer of_copydownlinkeditemstouplinked (long al_ul_row, long al_dl_row);// $$HEX41$$58d504c7200070b374c730d1200008c7c4b3b0c6200044c574c75cd1200012ac44c72000c1c004c7200070b374c730d1200008c7c4b3b0c65cb8200044c574c75cd13cc75cb82000f5bcacc069d5c8b2e4b2$$ENDHEX$$
// $$HEX22$$d9b37cc75cd52000eccefcb785ba44c7200016ac94b22000eccefcb712acccb92000f5bcacc069d5c8b2e4b2$$ENDHEX$$.
// al_ul_row: $$HEX15$$f5bcacc020b4200070b374c730d108c7c4b3b0c6200008b87cd3f0b7a4c2$$ENDHEX$$
// al_dl_row: $$HEX18$$f5bcacc060d520008cc1a4c2200070b374c730d108c7c4b3b0c6200008b87cd3f0b7a4c2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: success=$$HEX2$$31c1f5ac$$ENDHEX$$, failure=$$HEX2$$e4c228d3$$ENDHEX$$

if not isvalid(idw_uplinked) then return failure
if not isvalid(idw_target) then return failure

integer li_colcnt, i, li_copycnt
string ls_dbname, ls_colname
string ls_ul_colname, ls_dl_colname

// $$HEX15$$70b374c730d108c7c4b3b0c62000eccefcb7200015c8f4bc2000f4bc00ad$$ENDHEX$$
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

public function datawindow of_getrootdatawindow ();// idw_target$$HEX26$$44c7200030ae00c93cc75cb820005ccdc1c004c72000f0c5c4ac200070b374c730d108c7c4b3b0c67cb920006cad69d5c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX18$$5ccdc1c004c72000f0c5c4ac200070b374c730d108c7c4b3b0c6200008b87cd3f0b7a4c2$$ENDHEX$$

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

public function integer of_getsynceddatawindow (ref datawindow adw_syncable[]);// $$HEX24$$90c7e0c2fcac2000d9b330ae54d62000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c67cb920006cad69d5c8b2e4b2$$ENDHEX$$($$HEX5$$90c7e0c22000ecd368d5$$ENDHEX$$)
// adw_syncable: $$HEX32$$80acc9c01cb42000d9b330ae54d62000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c67cb92000acb934d11bbc44c7200008b87cd3f0b7a4c22000c0bc18c2$$ENDHEX$$($$HEX2$$30bcf4c5$$ENDHEX$$)
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=$$HEX13$$80acc9c01cb4200070b374c730d108c7c4b3b0c620002fac18c2$$ENDHEX$$, $$HEX2$$e4c228d3$$ENDHEX$$=-1

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

public subroutine of_initialize (datawindow adw_datawindow, window aw_parent);// $$HEX18$$44c5dcad3cbab8d220001cc144bea4c27cb9200008cd30ae54d658d594b2200068d518c2$$ENDHEX$$
// adw_datawindow: $$HEX20$$44c5dcad3cbaa4c220001cc144bea4c27cb920001cc8f5ac60d5200070b374c730d108c7c4b3b0c6$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$c6c54cc7$$ENDHEX$$

// $$HEX12$$80bda8ba200070b374c730d108c7c4b3b0c62000f1b45db8$$ENDHEX$$
if not isvalid(adw_datawindow) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX16$$2cc614bc74b9c0c920004ac540c7200068d518c238d69ccd200085c7c8b2e4b2$$ENDHEX$$.~r~npf_n_argument.of_registertarget()')
	return
end if

idw_target = adw_datawindow
iw_parent = aw_parent

// $$HEX13$$f0c5c4ac200070b374c730d108c7c4b3b0c6200008cd30ae54d6$$ENDHEX$$
pf_u_datawindow ldw_empty, ldw_emptys[]

idw_uplinked = ldw_empty
idw_downlinked = ldw_emptys

end subroutine

public function integer of_getdownlinkeddatawindow (ref pf_u_datawindow adw_linked[]);// $$HEX25$$58d504c72000f0c5c4ac1cb42000a8bae0b4200070b374c730d108c7c4b3b0c67cb9200000ac38c824c694b2200068d518c2$$ENDHEX$$
// adw_linked[] : $$HEX24$$58d504c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c67cb92000acb934d11bbc44c7200008b87cd3f0b7a4c2$$ENDHEX$$
// $$HEX4$$acb934d112ac2000$$ENDHEX$$: $$HEX16$$58d504c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c620002fac18c2$$ENDHEX$$

long ll_linkcnt

if not isvalid(idw_target) then return no_action
pf_u_datawindow ldw_empty[]

adw_linked = ldw_empty
ll_linkcnt = this.of_getdownlinkeddatawindow(idw_target, adw_linked)

return ll_linkcnt

end function

public function integer of_getdownlinkeddatawindow (readonly pf_u_datawindow adw_basenode, ref pf_u_datawindow adw_linked[]);// $$HEX22$$58d504c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c67cb9200000ac38c824c694b2200068d518c2$$ENDHEX$$
// $$HEX34$$f0c5b0ac1cb42000a8bae0b4200058d504c7200070b374c730d108c7c4b3b0c67cb920006cad58d530ae200004c774d52000acc7c0ad38d69ccd44c7200069d5c8b2e4b2$$ENDHEX$$.
// adw_basenode: $$HEX23$$58d504c7f0c5c4ac1cb4200070b374c730d104c7c4b3b0c67cb920003ecc44c7200070b374c730d108c7c4b3b0c6$$ENDHEX$$
// adw_linked[] : $$HEX24$$58d504c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c67cb92000acb934d11bbc44c7200008b87cd3f0b7a4c2$$ENDHEX$$
// $$HEX4$$acb934d112ac2000$$ENDHEX$$: $$HEX16$$58d504c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c620002fac18c2$$ENDHEX$$

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

public function integer of_setdownlinkeddatawindow (ref string as_linkeddw);// $$HEX19$$58d504c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c67cb92000f1b45db85cd5e4b2$$ENDHEX$$
// adw_linkeddw: $$HEX13$$f0c5c4ac20b4200070b374c730d108c7c4b3b0c6200085ba6dce$$ENDHEX$$

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

public function integer of_setdownlinkeddatawindow (ref datawindow adw_linkeddw);// $$HEX19$$58d504c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c67cb92000f1b45db85cd5e4b2$$ENDHEX$$
// adw_linkeddw: $$HEX15$$f0c5c4ac20b4200070b374c730d108c7c4b3b0c6200008b87cd3f0b7a4c2$$ENDHEX$$

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

public function integer of_setdownlinkeddatawindowall ();// $$HEX20$$58d504c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c67cb92000f1b45db869d5c8b2e4b2$$ENDHEX$$.
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

