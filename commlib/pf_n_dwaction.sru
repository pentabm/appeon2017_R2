HA$PBExportHeader$pf_n_dwaction.sru
$PBExportComments$$$HEX28$$70b374c730d108c7c4b3b0c6200061c558c120001cc144bea4c27cb920001cc8f5ac58d594b2200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
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
	// $$HEX11$$04d6acc72000e4c289d511c978c7200061c558c185ba$$ENDHEX$$
	string is_RunningAction
	
	// RowFocusChange $$HEX2$$29bcc0c9$$ENDHEX$$
	boolean ib_PreventRowFocusChange
	
	// Retrieve $$HEX5$$1cb4200089d5200018c2$$ENDHEX$$
	long il_RowsRetrieved
	
	// INSERTROW $$HEX3$$29bca5d52000$$ENDHEX$$= $$HEX2$$58d5e8b2$$ENDHEX$$
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

event type long pfe_rowfocuschanged(long currentrow);// $$HEX12$$f0c5c4ac200070b374c730d108c7c4b3b0c6200070c88cd6$$ENDHEX$$

if not isvalid(idw_target) then return 0
if this.of_getrunningaction() <> '' then return 0
if currentrow = 0 then return 0

integer li_synccnt, li_linkcnt
integer i, j
pf_u_datawindow ldw_synced[], ldw_ulink, ldw_dlink[]

// Synced Datawindow $$HEX2$$70c88cd6$$ENDHEX$$
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

// Linked Datawindow $$HEX2$$70c88cd6$$ENDHEX$$
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

event type long pfe_rowfocuschanging(long currentrow, long newrow);// $$HEX27$$f0c5c4ac1cb4200070b374c730d1200008c7c4b3b0c62000c0bcbdacecc580bd7cb92000b4cc6cd058d5e0ac200000c8a5c75cd5e4b2$$ENDHEX$$
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

//// $$HEX39$$58d504c72000f0c5c4ac200070b374c730d108c7c4b3b0c600ac200074c8acc758d594b22000bdacb0c6ccb9200070b374c730d12000c0bcbdacecc580bd7cb92000b4cc6cd0200069d5c8b2e4b2$$ENDHEX$$
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
	choose case messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX17$$c0bcbdac2000b4b0edc574c7200000c8a5c718b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX16$$c0bcbdac2000b4b0edc544c7200000c8a5c7200058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNoCancel!, 3)
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


//// $$HEX39$$58d504c72000f0c5c4ac200070b374c730d108c7c4b3b0c600ac200074c8acc758d594b22000bdacb0c6ccb9200070b374c730d12000c0bcbdacecc580bd7cb92000b4cc6cd0200069d5c8b2e4b2$$ENDHEX$$
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
//	choose case messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX16$$70b374c730d12000c0bcbdac2000b4b0edc574c7200074c8acc769d5c8b2e4b2$$ENDHEX$$.~r~n$$HEX16$$c0bcbdac2000b4b0edc544c7200000c8a5c7200058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNoCancel!, 3)
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
//		choose case messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX16$$70b374c730d12000c0bcbdac2000b4b0edc574c7200074c8acc769d5c8b2e4b2$$ENDHEX$$.~r~n$$HEX16$$c0bcbdac2000b4b0edc544c7200000c8a5c7200058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNoCancel!, 3)
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

event type long pfe_itemchanged(long row, dwobject dwo, string data);// $$HEX13$$f0c5c4ac1cb4200070b374c730d108c7c4b3b0c62000c0bcbdac$$ENDHEX$$

if not isvalid(idw_target) then return 0
if this.of_getrunningaction() <> '' then return 0
if row = 0 then return 0

integer li_synccnt
integer i, j
pf_u_datawindow ldw_synced[]
dwitemstatus ll_itemstatus
string ls_colname

// $$HEX13$$f0c5c4ac1cb4200070b374c730d108c7c4b3b0c62000c0bcbdac$$ENDHEX$$
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

public function integer of_setprocessorder ();//// $$HEX35$$08c7c4b3b0c624c60cbe1dc8b8d200ac200000acc0c9e0ac200088c794b2200070b374c730d108c7c4b3b0c658c7200098ccacb920001cc21cc17cb9200024c115c85cd5e4b2$$ENDHEX$$
//// $$HEX11$$98ccacb920001cc21cc194b2200008c7c4b3b0c62000$$ENDHEX$$TABORDER$$HEX11$$7cb9200030ae00c93cc75cb82000c4c989d518b470ba$$ENDHEX$$,
//// UPLINKED_DATAWINDOW$$HEX31$$00ac200020c1b8c51cb42000bdacb0c62000c1c004c7200070b374c730d108c7c4b3b0c67cb9200098ccacb95cd52000e4b24cc72000c4c989d51cb4e4b2$$ENDHEX$$
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

public function string of_excel ();// $$HEX11$$70b374c730d108c7c4b3b0c62000b4b0a9c644c72000$$ENDHEX$$SAVEAS $$HEX3$$69d5c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: SAVEAS$$HEX5$$1cb420000cd37cc785ba$$ENDHEX$$

if not isvalid(idw_target) then return ''
this.of_setrunningaction('excel')

pf_n_saveas lnv_save
string ls_filename

ls_filename = lnv_save.of_saveas(idw_target, true)

this.of_setrunningaction('')
return ls_filename

end function

public function integer of_update ();// $$HEX16$$70b374c730d12000c0bcbdacacc06dd544c7200000c8a5c7200069d5c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=1, $$HEX2$$e4c228d3$$ENDHEX$$=-1

if not isvalid(idw_target) then return no_action

this.of_setrunningaction('update')

// AcceptText $$HEX2$$18c289d5$$ENDHEX$$
if this.of_accepttext() = failure then
	this.of_setrunningaction('')
	return failure
end if

// $$HEX23$$c0bcbdacacc06dd574c7200074c8acc758d594b2200070b374c730d108c7c4b3b0c67cb920006cad69d5c8b2e4b2$$ENDHEX$$
integer li_modifiedcnt
pf_u_datawindow ldw_modified[]

li_modifiedcnt = this.of_getmodified(ldw_modified)
if li_modifiedcnt = 0 then
	messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX12$$00c8a5c760d52000b4b0a9c674c72000c6c5b5c2c8b2e4b2$$ENDHEX$$')
	this.of_setrunningaction('')
	return failure
end if

// $$HEX34$$c0bcbdacacc06dd574c7200074c8acc758d594b2200070b374c730d108c7c4b3b0c658c72000b8d29cb71dc858c1200024c60cbe1dc8b8d27cb920006cad69d5c8b2e4b2$$ENDHEX$$
transaction ltr_trans[]
integer li_transcnt, i, j

li_transcnt = this.of_gettransobject(ldw_modified, ltr_trans)

// $$HEX19$$00c8a5c7200004c8200018c289d520b42000acc0a9c690c7200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
for i = 1 to li_modifiedcnt
	if ldw_modified[i].event pfe_preupdate() = failure then
		this.of_setrunningaction('')
		return failure
	end if
next

// $$HEX11$$44d518c2200085c725b820006dd5a9ba2000b4cc6cd0$$ENDHEX$$
for i = 1 to li_modifiedcnt
	if isvalid(ldw_modified[i].inv_required) then
		if ldw_modified[i].inv_required.of_checkrequiredcolumn() > 0 then
			this.of_setrunningaction('')
			return failure
		end if
	end if
next

// $$HEX2$$38cce0ac$$ENDHEX$$) Foreign Key $$HEX16$$00ac20006cad04d61cb420004cd174c714be20006cad70c858c72000bdacb0c6$$ENDHEX$$
// UPDATE$$HEX23$$dcc22000adc01cc8b4b0edc5ccb92000c4bcc4b35cb82000edc51cc23cc75cb8200000c8a5c774d57cc5200068d5$$ENDHEX$$

// UPDATE $$HEX2$$18c289d5$$ENDHEX$$
pf_n_datastore lds_deleted
long ll_delcnt

for i = 1 to li_modifiedcnt
	// $$HEX12$$adc01cc8200084bc7cd3200030aea5b2200048c5200000c5$$ENDHEX$$.
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
//				messagebox('[' + ldw_modified[i].of_gettitle() + '] $$HEX2$$d0c5ecb7$$ENDHEX$$!!', '$$HEX29$$70b374c730d17cb9200000c8a5c758d594b2200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$.~r~n' + '~r~n* LINE = ' + string(lds_deleted.istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(lds_deleted.istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + lds_deleted.istr_dberror.sqlerrtext)
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
		messagebox('[' + ldw_modified[i].of_gettitle() + '] $$HEX2$$d0c5ecb7$$ENDHEX$$!!', '$$HEX29$$70b374c730d17cb9200000c8a5c758d594b2200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$.~r~n' + '~r~n* LINE = ' + string(ldw_modified[i].istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(ldw_modified[i].istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + ldw_modified[i].istr_dberror.sqlerrtext)
		this.of_setrunningaction('')
		return failure
	end if
next

// $$HEX19$$00c8a5c72000c4d6200018c289d520b42000acc0a9c690c7200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
// $$HEX5$$acb934d112ac74c72000$$ENDHEX$$Failure(-1) $$HEX5$$78c72000bdacb0c62000$$ENDHEX$$Update$$HEX6$$1cb42000b4b0edc544c72000$$ENDHEX$$Rollback $$HEX2$$5cd5e4b2$$ENDHEX$$
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

// Update $$HEX6$$b4b0a9c62000c1c004c72000$$ENDHEX$$Sync $$HEX10$$70b374c730d108c7c4b3b0c6d0c5200018bc01c6$$ENDHEX$$
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

// $$HEX11$$00c8a5c7200044c6ccb8200054badcc2c0c97cb92000$$ENDHEX$$Display $$HEX3$$69d5c8b2e4b2$$ENDHEX$$
//if this.of_getrunningaction() = 'update' then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX5$$00c8a5c7200044c6ccb8$$ENDHEX$$!')
//end if

// $$HEX12$$00c8a5c7200044c6ccb8200054badcc2c0c920005cd4dcc2$$ENDHEX$$
if left(iw_parent.dynamic of_getclassname(), 2) = 'w_' then
	iw_parent.dynamic of_setmessage('$$HEX14$$15c8c1c001c83cc75cb8200000c8a5c7200018b4c8c5b5c2c8b2e4b2$$ENDHEX$$')
end if

this.of_setrunningaction('')
return success

end function

public function integer of_accepttext ();// $$HEX12$$f0c5c4ac1cb4200070b374c730d108c7c4b3b0c6d0c52000$$ENDHEX$$AcceptText$$HEX6$$7cb9200018c289d55cd5e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=1, $$HEX2$$e4c228d3$$ENDHEX$$=-1

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

public function boolean of_checkmodified ();// $$HEX17$$70b374c730d108c7c4b3b0c62000c0bcbdacecc580bd7cb9200055d678c75cd5e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX6$$c0bcbdacacc06dd588c74cc7$$ENDHEX$$=true, $$HEX7$$c0bcbdacacc06dd52000c6c54cc7$$ENDHEX$$=false

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

public function long of_retrieve ();// $$HEX18$$f1b45db81cb42000200070b374c730d108c7c4b3b0c67cb9200070c88cd669d5c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=$$HEX13$$70b374c730d108c7c4b3b0c6200070c88cd6200089d5200018c2$$ENDHEX$$, $$HEX2$$e4c228d3$$ENDHEX$$=-1

pointer lt_pointer
long ll_rowcnt

if not isvalid(idw_target) then return failure

this.of_setrunningaction('retrieve')
//this.post of_setrunningaction('')

lt_pointer = setpointer(hourglass!)

// $$HEX12$$f0c5c4ac1cb4200070b374c730d108c7c4b3b0c658c72000$$ENDHEX$$AcceptText$$HEX7$$7cb9200018c289d569d5c8b2e4b2$$ENDHEX$$
if this.of_accepttext() = -1 then
	this.of_setrunningaction('')
	return failure
end if

// $$HEX28$$f0c5c4ac1cb4200070b374c730d108c7c4b3b0c658c7200070b374c730d12000c0bcbdacecc580bd7cb9200055d678c7200069d5c8b2e4b2$$ENDHEX$$
if this.of_checkmodified() = true then
	choose case messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX17$$c0bcbdac2000b4b0edc574c7200000c8a5c718b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX14$$00c8a5c72000c4d6200070c88cd6200058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNoCancel!, 3)
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
 
// $$HEX5$$70c88cd62000c4d62000$$ENDHEX$$RowFocuschanged $$HEX6$$74c7a4bcb8d2200038d69ccd$$ENDHEX$$
ll_rowcnt = this.of_retrieve(idw_target)
if  ll_rowcnt > 0 then
	idw_target.post event rowfocuschanged(1)
else
	idw_target.post event rowfocuschanged(0)
end if

if left(iw_parent.dynamic of_getclassname(), 2) = 'w_' then
	if ll_rowcnt > 0 then
		iw_parent.dynamic of_setmessage(string(ll_rowcnt, '#,##0') + ' $$HEX15$$74ac58c7200090c7ccb800ac200070c88cd6200018b4c8c5b5c2c8b2e4b2$$ENDHEX$$')
	else
		iw_parent.dynamic of_setmessage('$$HEX17$$70c88cd660d5200090c7ccb800ac200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$')
	end if
end if

//// $$HEX18$$f0c5c4ac1cb4200070b374c730d108c7c4b3b0c67cb9200070c88cd6200069d5c8b2e4b2$$ENDHEX$$
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

public function integer of_resetupdate ();// UPDATE $$HEX9$$b4b0edc544c72000acb94bc169d5c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: success=$$HEX2$$31c1f5ac$$ENDHEX$$, failure=$$HEX2$$e4c228d3$$ENDHEX$$

if not isvalid(idw_target) then return failure

pf_u_datawindow ldw_synced[], ldw_dlinked[]
integer li_linkcnt, li_synccnt, i, j
blob lblb_empty[]

// sync $$HEX11$$f0c5c4ac200070b374c730d1200008c7c4b3b0c62000$$ENDHEX$$reset
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

public function integer of_insertrow (long al_row);// $$HEX19$$74d5f9b2200070b374c730d108c7c4b3b0c6d0c5200089d544c7200094cd00ac69d5c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=$$HEX7$$94cd00ac1cb4200089d588bc38d6$$ENDHEX$$, $$HEX2$$e4c228d3$$ENDHEX$$=-1

if not isvalid(idw_target) then return failure

this.of_setrunningaction('insertrow')

long ll_new
integer i, j
pf_u_datawindow ldw_ulink

// $$HEX31$$c1c004c7200070b374c730d108c7c4b3b0c658c7200070b374c730d100ac200074c8acc758d5c0c920004ac53cc774ba200089d594cd00ac200088bd00ac$$ENDHEX$$
ldw_ulink = idw_target.inv_link.of_getuplinkeddatawindow()
if isvalid(ldw_ulink) and idw_target.inv_link.of_getlinkagetype() <> 'syncable' then
	if idw_target.of_isupdatable() = true then
		if ldw_ulink.getrow() = 0 then
			messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX21$$c1c004c720006dd5a9ba58c7200070b374c730d100ac200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX3$$3cba00c82000$$ENDHEX$$[' + ldw_ulink.of_gettitle() + '] $$HEX13$$58c7200070b374c730d17cb9200085c725b8200058d538c194c6$$ENDHEX$$.')
			this.of_setrunningaction('')
			return no_action
		end if
	end if
end if

// $$HEX12$$f0c5c4ac1cb4200070b374c730d108c7c4b3b0c658c72000$$ENDHEX$$AcceptText$$HEX7$$7cb9200018c289d569d5c8b2e4b2$$ENDHEX$$
if this.of_accepttext() = -1 then
	this.of_setrunningaction('')
	return failure
end if

// $$HEX28$$89d594cd00ac200004c8200058d504c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c658c72000c0bcbdacb4b0edc5200055d678c7$$ENDHEX$$
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
	choose case messagebox('[' + ldw_dlink[i].of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX17$$c0bcbdac2000b4b0edc574c7200000c8a5c718b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX14$$00c8a5c72000c4d6200094cd00ac200058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNoCancel!, 3)
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

// $$HEX20$$89d594cd00ac200004c8200018c289d520b42000acc0a9c690c7200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
for i = 1 to li_synccnt
	if ldw_synced[i].event pfe_preinsertrow() = failure then
		this.of_setrunningaction('')
		return failure
	end if
next

// $$HEX18$$90c7b4cc200070b374c730d108c7c4b3b0c67cb9200089d594cd00ac200069d5c8b2e4b2$$ENDHEX$$
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

//// $$HEX20$$89d594cd00ac2000c4d6200018c289d520b42000acc0a9c690c7200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
//for i = 1 to li_synccnt
//	if ldw_synced[i].event pfe_postinsertrow() = failure then return failure
//next

// SetFocus
idw_target.setfocus()

this.of_setrunningaction('')
return success

end function

public function long of_retrievedddw (string as_column);// DDDW $$HEX14$$eccefcb758c7200070b374c730d17cb9200070c88cd669d5c8b2e4b2$$ENDHEX$$
// DDDW $$HEX4$$eccefcb758c72000$$ENDHEX$$Tag $$HEX19$$12ac44c720007dc7b4c51cc1200044c5dcad3cbab8d25cb8200098ccacb9200069d5c8b2e4b2$$ENDHEX$$
// as_columnname: DDDW $$HEX3$$eccefcb785ba$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX10$$70c88cd61cb4200070b374c730d1200089d518c2$$ENDHEX$$

if not isvalid(idw_target) then return -1
if not isnumber(idw_target.describe(as_column + ".ID")) then return -1
if idw_target.describe(as_column + ".Edit.Style") <> "dddw" then return -1

datawindowchild ldwc_dddw

if idw_target.getchild(as_column, ldwc_dddw) = -1 then
	messagebox('[' + idw_target.dynamic of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + as_column + '] DDDW $$HEX14$$eccefcb744c7200000ac38c82cc6200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
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
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX24$$70b374c730d108c7c4b3b0c6d0c52000b8d29cb7adc758c174c7200060d5f9b218b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$')
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

// $$HEX10$$d0c5ecb7dcc2200054badcc2c0c920009ccd25b8$$ENDHEX$$
if ll_rowcnt = -1 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(' + string(ltr_args.sqldbcode) + ')', '[' + as_column + '] DDDW $$HEX28$$70c88cd67cb9200018c289d558d594b2200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$~r~n' + ltr_args.sqlerrtext)
end if

// $$HEX4$$89d594cd00ac2000$$ENDHEX$$TAG $$HEX2$$98ccacb9$$ENDHEX$$
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

public function integer of_retrievedddw ();//  $$HEX3$$a8bae0b42000$$ENDHEX$$DDDW $$HEX14$$eccefcb758c7200070b374c730d17cb9200070c88cd669d5c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: 1=$$HEX2$$31c1f5ac$$ENDHEX$$, -1=$$HEX2$$e4c228d3$$ENDHEX$$

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

public function long of_retrieve (datawindow adw_target);// adw_target $$HEX17$$70b374c730d108c7c4b3b0c67cb920001cacc4bc200070c88cd6200069d5c8b2e4b2$$ENDHEX$$
// adw_target: $$HEX15$$70c88cd660d5200070b374c730d108c7c4b3b0c6200008b87cd3f0b7a4c2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=$$HEX10$$70c88cd61cb4200070b374c730d1200074ac18c2$$ENDHEX$$, $$HEX2$$e4c228d3$$ENDHEX$$=-1

pf_u_datawindow ldw_target

if isnull(adw_target) then return failure
if not isvalid(adw_target) then return failure

ldw_target = adw_target
ldw_target.inv_action.of_setrunningaction('retrieve')
//ldw_target.inv_action.post of_setrunningaction('')

any la_args[], la_empty[]
long ll_rowcnt

// $$HEX15$$70c88cd6200004c82000acc0a9c690c7200074c7a4bcb8d2200018c289d5$$ENDHEX$$
if ldw_target.event pfe_preretrieve() = failure then
	ldw_target.inv_action.of_setrunningaction('')
	return failure
end if

if isvalid(ldw_target.inv_args) then
	// $$HEX25$$44c5c1c9200060d5f9b218b4c0c94ac540c7200044c5dcad3cbab8d200ac200088c794b2c0c9200055d678c769d5c8b2e4b2$$ENDHEX$$
	if ldw_target.inv_args.of_checknotassignedargument() = failure then
		ldw_target.inv_action.of_setrunningaction('')
		return failure
	end if

	// $$HEX15$$44c5dcad3cbab8d2200012ace4b444c72000b0c09ccd200069d5c8b2e4b2$$ENDHEX$$
	la_args = la_empty
	if ldw_target.inv_args.of_getallargumentvalue(la_args) = failure then
		ldw_target.inv_action.of_setrunningaction('')
		return failure
	end if
end if

// $$HEX14$$70c88cd6200004c8200070b374c730d108c7c4b3b0c62000acb94bc1$$ENDHEX$$
ldw_target.reset()

// $$HEX10$$70b374c730d17cb9200070c88cd669d5c8b2e4b2$$ENDHEX$$
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

// $$HEX10$$d0c5ecb7dcc2200054badcc2c0c920009ccd25b8$$ENDHEX$$
if ll_rowcnt = -1 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(DBCode=' + string(ldw_target.dynamic of_getlasterrorcode()) + ')', '$$HEX28$$70c88cd67cb9200018c289d558d594b2200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$~r~n' + string(ldw_target.dynamic of_getlasterrortext()))
	ldw_target.inv_action.of_setrunningaction('')
	return failure
end if

// $$HEX14$$70c88cd6c4d62000acc0a9c690c7200074c7a4bcb8d2200018c289d5$$ENDHEX$$
ldw_target.event pfe_postretrieve(ll_rowcnt)

// $$HEX10$$70c88cd61cb4200089d5200018c22000f4bc00ad$$ENDHEX$$
il_RowsRetrieved = ll_rowcnt

//// RowFocusChanged $$HEX6$$74c7a4bcb8d2200018c289d5$$ENDHEX$$
//if ll_currentrow = 1 and ldw_target.getrow() = 1 then
//	ldw_target.event rowfocuschanged(1)
//end if

ldw_target.inv_action.of_setrunningaction('')
return ll_rowcnt

end function

public function integer of_insertrow (ref datawindow adw_target, long al_row);// adw_target $$HEX16$$70b374c730d108c7c4b3b0c6d0c5200089d544c7200094cd00ac69d5c8b2e4b2$$ENDHEX$$($$HEX9$$e8b27cc7200070b374c730d108c7c4b3b0c6$$ENDHEX$$)
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=$$HEX7$$94cd00ac1cb4200089d588bc38d6$$ENDHEX$$, $$HEX2$$e4c228d3$$ENDHEX$$=-1

if isnull(adw_target) then return failure
if not isvalid(adw_target) then return failure

long ll_new
string ls_keyset[]
integer li_keycnt, i
pf_u_datawindow ldw_target

ldw_target = adw_target
ldw_target.inv_action.of_setrunningaction('insertrow')

// $$HEX23$$89d594cd00ac200004c82000e4c289d560d5200070b374c730d108c7c4b3b0c6200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
//if ldw_target.event pfe_preinsertrow() = failure then return failure

// $$HEX27$$04d5acb9fcd32000a4c2c0d07cc758c72000bdacb0c6200089d594cd00ac200004c8200070b374c730d108c7c4b3b0c62000acb94bc1$$ENDHEX$$
if ldw_target.of_getpresentationstyle() = 'Freeform' then
	ldw_target.reset()
else
	if al_row = 0 then
		if ib_InsertRowOnTop = true then
			al_row = 1
		end if
	end if
end if

// $$HEX11$$70b374c730d108c7c4b3b0c6200089d5200094cd00ac$$ENDHEX$$
ll_new = ldw_target.insertrow(al_row)

//// $$HEX16$$89d594cd00ac2000c4d6200030aef8bc12ac44c7200024c115c869d5c8b2e4b2$$ENDHEX$$(INSERTROW $$HEX12$$dcc2200090c7d9b3200098ccacb95cb82000c0bcbdac28b4$$ENDHEX$$)
//if isvalid(ldw_target.inv_defaultvalue) then
//	li_keycnt = ldw_target.inv_defaultvalue.inv_initvalues.of_keyset(ls_keyset)
//	for i = 1 to li_keycnt
//		ldw_target.inv_defaultvalue.of_setdefaultvalue(ll_new, ls_keyset[i])
//	next
//end if

// $$HEX23$$89d594cd00ac2000c4d62000e4c289d560d5200070b374c730d108c7c4b3b0c6200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
ldw_target.event pfe_postinsertrow(ll_new)

// $$HEX8$$94cd00ac5cd5200089d53cc75cb82000$$ENDHEX$$Focus $$HEX2$$c0bcbdac$$ENDHEX$$
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

public function integer of_deleterow (ref datawindow adw_target, long al_row);// adw_target $$HEX8$$70b374c730d108c7c4b3b0c658c72000$$ENDHEX$$al_row $$HEX8$$89d544c72000adc01cc869d5c8b2e4b2$$ENDHEX$$
// adw_target : $$HEX20$$89d5adc01cc87cb9200018c289d560d5200070b374c730d108c7c4b3b0c6200008b87cd3f0b7a4c2$$ENDHEX$$
// al_row: $$HEX5$$adc01cc860d5200089d5$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=1, $$HEX2$$e4c228d3$$ENDHEX$$=-1

if not isvalid(idw_target) then return failure
if not isvalid(adw_target) then return failure

pf_u_datawindow ldw_target
long ll_rc

ldw_target = adw_target
ldw_target.inv_action.of_setrunningaction('deleterow')

// $$HEX6$$89d5adc01cc8200018c289d5$$ENDHEX$$
ll_rc = ldw_target.deleterow(al_row)

ldw_target.inv_action.of_setrunningaction('')
return ll_rc

end function

public function integer of_deleterow (long al_row);// $$HEX21$$74d5f9b2200070b374c730d108c7c4b3b0c658c7200004d6acc789d544c72000adc01cc869d5c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=1, $$HEX2$$e4c228d3$$ENDHEX$$=-1

if not isvalid(idw_target) then return failure

this.of_setrunningaction('deleterow')

// $$HEX27$$58d504c7200070b374c730d104c7c4b3b0c658c7200070b374c730d100ac200074c8acc758d574ba200089d5adc01cc8200088bd00ac$$ENDHEX$$
integer li_synccnt, li_linkcnt, i, j
pf_u_datawindow ldw_synced[], ldw_dlink[]
long ll_row, ll_rc

li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
for i = 1 to li_synccnt
	li_linkcnt = ldw_synced[i].inv_link.of_getdownlinkeddatawindow(ldw_dlink)
	for j = 1 to li_linkcnt
		if ldw_dlink[j].rowcount() > 0 then
			messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + ldw_dlink[j].of_gettitle() + '] $$HEX26$$d0c5200070b374c730d100ac200074c8acc758d530ae20004cb538bbd0c52000adc01cc860d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX3$$3cba00c82000$$ENDHEX$$[' + ldw_dlink[j].of_gettitle() + '] $$HEX18$$70b374c730d17cb92000adc01cc82000c4d62000e4b2dcc22000dcc2c4b358d538c194c6$$ENDHEX$$.')
			this.of_setrunningaction('')
			return failure
		end if
	next
next

// $$HEX13$$adc01cc860d5200089d574c72000c6c53cc774ba2000acb934d1$$ENDHEX$$
ll_row = idw_target.getrow()
if ll_row = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX13$$adc01cc860d5200070b374c730d100ac2000c6c5b5c2c8b2e4b2$$ENDHEX$$')
	this.of_setrunningaction('')
	return no_action
end if

// $$HEX10$$89d5adc01cc82000acc0a9c690c7200055d678c7$$ENDHEX$$
choose case idw_target.getitemstatus(ll_row, 0, primary!)
	case new!, newmodified!
		ll_rc = 1
	case datamodified!, notmodified!
		ll_rc = messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX18$$20c1ddd01cb4200070b374c730d17cb92000adc01cc8200058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2)
end choose

if ll_rc = 2 then
	this.of_setrunningaction('')
	return no_action
end if

// $$HEX23$$89d5adc01cc8200004c82000e4c289d560d5200070b374c730d108c7c4b3b0c6200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
for i = li_synccnt to 1 step -1
	if ldw_synced[i].event pfe_predeleterow() = failure then
		this.of_setrunningaction('')
		return failure
	end if
next

// $$HEX4$$f0c5c4ac1cb42000$$ENDHEX$$Sync $$HEX8$$70b374c730d108c7c4b3b0c67cb92000$$ENDHEX$$DeleteRow $$HEX6$$98ccacb9200069d5c8b2e4b2$$ENDHEX$$
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

// $$HEX7$$c0bcbdacb4b0edc5200000c8a5c7$$ENDHEX$$
for i = li_synccnt to 1 step -1
	if ldw_synced[i].of_isupdatable() = true then
		ll_rc = ldw_synced[i].update(true, false)
		if ll_rc = 1 then
			commit using ldw_synced[i].of_gettransobject();
			ldw_synced[i].resetupdate();
		else
			rollback using ldw_synced[i].of_gettransobject();
			messagebox('[' + ldw_synced[i].of_gettitle() + '] $$HEX2$$d0c5ecb7$$ENDHEX$$!!', '$$HEX29$$70b374c730d17cb9200000c8a5c758d594b2200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$.~r~n' + '~r~n* LINE = ' + string(ldw_synced[i].istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(ldw_synced[i].istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + ldw_synced[i].istr_dberror.sqlerrtext)
			this.of_setrunningaction('')
			return failure
		end if	
	end if
next

// $$HEX23$$89d5adc01cc82000c4d62000e4c289d560d5200070b374c730d108c7c4b3b0c6200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
for i = li_synccnt to 1 step -1
	ldw_synced[i].event pfe_postdeleterow(al_row)
next

// $$HEX12$$adc01cc8200044c6ccb8200054badcc2c0c920005cd4dcc2$$ENDHEX$$
if left(iw_parent.dynamic of_getclassname(), 2) = 'w_' then
	iw_parent.dynamic of_setmessage('$$HEX14$$15c8c1c001c83cc75cb82000adc01cc8200018b4c8c5b5c2c8b2e4b2$$ENDHEX$$')
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

public function integer of_deleterow_multi ();// $$HEX26$$74d5f9b2200070b374c730d108c7c4b3b0c658c72000e4b211c9200020c1ddd01cb4200089d544c72000adc01cc869d5c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=1, $$HEX2$$e4c228d3$$ENDHEX$$=-1

if not isvalid(idw_target) then return failure

// $$HEX23$$f0c5c4ac1cb4200070b374c730d104c7c4b3b0c600ac200074c8acc758d574ba200089d5adc01cc8200088bd00ac$$ENDHEX$$
integer li_synccnt, li_linkcnt, i
pf_u_datawindow ldw_synced[], ldw_dlink[]
long ll_row, ll_rc

li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
if li_synccnt > 1 then
	messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', 'Sync $$HEX34$$f0c5c4ac1cb4200070b374c730d108c7c4b3b0c600ac200074c8acc758d594b22000bdacb0c694b220007cc704ad2000adc01cc860d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$.')
	return failure
end if

li_linkcnt = idw_target.inv_link.of_getdownlinkeddatawindow(ldw_dlink)
if li_linkcnt > 0 then
	messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX37$$58d504c72000f0c5c4ac1cb4200070b374c730d108c7c4b3b0c600ac200074c8acc758d594b22000bdacb0c694b220007cc704ad2000adc01cc860d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$.')
	return failure
end if

// $$HEX13$$20c1ddd01cb4200089d574c72000c6c53cc774ba2000acb934d1$$ENDHEX$$
long ll_selectedcnt, ll_selectedrow[]

ll_row = idw_target.getselectedrow(0)
do while ll_row > 0
	ll_selectedcnt ++
	ll_selectedrow[ll_selectedcnt] = ll_row
	ll_row = idw_target.getselectedrow(ll_row)
loop

if ll_selectedcnt = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX11$$20c1ddd01cb4200089d574c72000c6c5b5c2c8b2e4b2$$ENDHEX$$')
	return no_action
end if

// $$HEX10$$89d5adc01cc82000acc0a9c690c7200055d678c7$$ENDHEX$$
ll_rc = messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX18$$20c1ddd01cb4200070b374c730d17cb92000adc01cc8200058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2)
if ll_rc = 2 then return no_action

// $$HEX8$$70b374c730d108c7c4b3b0c67cb92000$$ENDHEX$$DeleteRow $$HEX6$$98ccacb9200069d5c8b2e4b2$$ENDHEX$$
for i = ll_selectedcnt to 1 step -1
	if this.of_deleterow(idw_target, ll_selectedrow[i]) = failure then return failure
next

// $$HEX7$$c0bcbdacb4b0edc5200000c8a5c7$$ENDHEX$$
if idw_target.of_isupdatable() = true then
	if idw_target.deletedcount() > 0 then
		ll_rc = idw_target.update(true, false)
		if ll_rc = 1 then
			commit using idw_target.of_gettransobject();
			idw_target.resetupdate()
		else
			rollback using idw_target.of_gettransobject();
			messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$d0c5ecb7$$ENDHEX$$!!', '$$HEX29$$70b374c730d17cb9200000c8a5c758d594b2200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$.~r~n' + '~r~n* LINE = ' + string(idw_target.istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(idw_target.istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + idw_target.istr_dberror.sqlerrtext)
			return failure
		end if
	end if
end if

// RowFocusChanged $$HEX6$$74c7a4bcb8d2200038d69ccd$$ENDHEX$$
ll_row = idw_target.getrow()
idw_target.post event rowfocuschanged(ll_row)

// $$HEX12$$00c8a5c7200044c6ccb8200054badcc2c0c920005cd4dcc2$$ENDHEX$$
if left(iw_parent.dynamic of_getclassname(), 2) = 'w_' then
	iw_parent.dynamic of_setmessage('$$HEX14$$15c8c1c001c83cc75cb8200000c8a5c7200018b4c8c5b5c2c8b2e4b2$$ENDHEX$$')
end if

return success

end function

public function integer of_gettransobject (readonly datawindow adw_target[], ref transaction atr_result[]);// $$HEX4$$68d518c224c185ba$$ENDHEX$$
//   $$HEX23$$70b374c730d108c7c4b3b0c658c72000b8d29cb71dc858c1200024c60cbe1dc8b8d27cb920006cad69d5c8b2e4b2$$ENDHEX$$
// $$HEX4$$0cd37cb7f8bb30d1$$ENDHEX$$
//   adw_target[] : $$HEX19$$60d5f9b21cb42000b8d29cb71dc858c144c720006cad60d5200070b374c730d108c7c4b3b0c6$$ENDHEX$$
//   atr_result[] : $$HEX33$$70b374c730d108c7c4b3b0c6e4b474c7200016ac94b22000b8d29cb71dc858c1200024c60cbe1dc8b8d27cb92000f4b244c7200008b87cd3f0b7a4c22000c0bc18c2$$ENDHEX$$
// $$HEX3$$b0acfcac12ac$$ENDHEX$$
//   $$HEX12$$b8d29cb71dc858c1200024c60cbe1dc8b8d220002fac18c2$$ENDHEX$$

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

public subroutine of_initialize (datawindow adw_target, window awo_parent);// $$HEX16$$70c88cd620001cc144bea4c27cb9200008cd30ae54d658d594b2200068d518c2$$ENDHEX$$
// aw_window: $$HEX20$$70c88cd620001cc144bea4c27cb920001cc8f5ac60d5200008c7c4b3b0c6200024c60cbe1dc8b8d2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$c6c54cc7$$ENDHEX$$

// $$HEX12$$80bda8ba200070b374c730d108c7c4b3b0c62000f1b45db8$$ENDHEX$$
if not isvalid(adw_target) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX16$$2cc614bc74b9c0c920004ac540c7200068d518c238d69ccd200085c7c8b2e4b2$$ENDHEX$$.~r~npf_n_crudservice.of_initialize()')
	return
end if

idw_target = adw_target
iw_parent = awo_parent

return

end subroutine

public function integer of_getmodified (ref datawindow adw_modified[]);// $$HEX42$$f0c5c4ac1cb4200070b374c730d108c7c4b3b0c6200011c92000c0bcbdac200010b694b22000adc01cc81cb42000b4b0edc574c7200088c794b2200070b374c730d108c7c4b3b0c67cb920006cad69d5c8b2e4b2$$ENDHEX$$
// adw_modified[]: $$HEX30$$c0bcbdacacc06dd574c7200074c8acc758d594b2200070b374c730d108c7c4b3b0c6200008b87cd3f0b7a4c27cb9200000c8a5c760d52000c0bc18c2$$ENDHEX$$($$HEX2$$30bcf4c5$$ENDHEX$$)
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX20$$c0bcbdacacc06dd574c7200074c8acc758d594b2200070b374c730d108c7c4b3b0c620002fac18c2$$ENDHEX$$

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

public function integer of_commitupdate ();// $$HEX15$$70b374c730d12000c0bcbdacacc06dd544c7200000c8a5c72000c4d62000$$ENDHEX$$COMMIT $$HEX3$$69d5c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=1, $$HEX2$$e4c228d3$$ENDHEX$$=-1

if not isvalid(idw_target) then return no_action

this.of_setrunningaction('update')

// AcceptText $$HEX2$$18c289d5$$ENDHEX$$
if this.of_accepttext() = failure then 
	this.of_setrunningaction('')
	return failure
end if

// $$HEX23$$c0bcbdacacc06dd574c7200074c8acc758d594b2200070b374c730d108c7c4b3b0c67cb920006cad69d5c8b2e4b2$$ENDHEX$$
integer li_modifiedcnt
pf_u_datawindow ldw_modified[]

li_modifiedcnt = this.of_getmodified(ldw_modified)
if li_modifiedcnt = 0 then
	messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX12$$00c8a5c760d52000b4b0a9c674c72000c6c5b5c2c8b2e4b2$$ENDHEX$$')
	this.of_setrunningaction('')
	return failure
end if

// $$HEX34$$c0bcbdacacc06dd574c7200074c8acc758d594b2200070b374c730d108c7c4b3b0c658c72000b8d29cb71dc858c1200024c60cbe1dc8b8d27cb920006cad69d5c8b2e4b2$$ENDHEX$$
transaction ltr_trans[]
integer li_transcnt, i, j

li_transcnt = this.of_gettransobject(ldw_modified, ltr_trans)

// $$HEX19$$00c8a5c7200004c8200018c289d520b42000acc0a9c690c7200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
for i = 1 to li_modifiedcnt
	if ldw_modified[i].event pfe_preupdate() = failure then
		this.of_setrunningaction('')
		return failure
	end if
next

// $$HEX11$$44d518c2200085c725b820006dd5a9ba2000b4cc6cd0$$ENDHEX$$
for i = 1 to li_modifiedcnt
	if isvalid(ldw_modified[i].inv_required) then
		if ldw_modified[i].inv_required.of_checkrequiredcolumn() > 0 then
			this.of_setrunningaction('')
			return failure
		end if
	end if
next

// $$HEX2$$38cce0ac$$ENDHEX$$) Foreign Key $$HEX16$$00ac20006cad04d61cb420004cd174c714be20006cad70c858c72000bdacb0c6$$ENDHEX$$
// UPDATE$$HEX23$$dcc22000adc01cc8b4b0edc5ccb92000c4bcc4b35cb82000edc51cc23cc75cb8200000c8a5c774d57cc5200068d5$$ENDHEX$$

// UPDATE $$HEX2$$18c289d5$$ENDHEX$$
pf_n_datastore lds_deleted
long ll_delcnt

for i = 1 to li_modifiedcnt
	// $$HEX12$$adc01cc8200084bc7cd3200030aea5b2200048c5200000c5$$ENDHEX$$.
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
//				messagebox('[' + ldw_modified[i].of_gettitle() + '] $$HEX2$$d0c5ecb7$$ENDHEX$$!!', '$$HEX29$$70b374c730d17cb9200000c8a5c758d594b2200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$.~r~n' + '~r~n* LINE = ' + string(lds_deleted.istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(lds_deleted.istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + lds_deleted.istr_dberror.sqlerrtext)
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
		messagebox('[' + ldw_modified[i].of_gettitle() + '] $$HEX2$$d0c5ecb7$$ENDHEX$$!!', '$$HEX29$$70b374c730d17cb9200000c8a5c758d594b2200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$.~r~n' + '~r~n* LINE = ' + string(ldw_modified[i].istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(ldw_modified[i].istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + ldw_modified[i].istr_dberror.sqlerrtext)
		this.of_setrunningaction('')
		return failure
	end if
next

// Commit Transactions
for i = 1 to li_transcnt
	commit using ltr_trans[i];
	if ltr_trans[i].sqlcode <> 0 then
		messagebox('[' + ldw_modified[i].of_gettitle() + '] Commit $$HEX2$$d0c5ecb7$$ENDHEX$$!!', '$$HEX29$$70b374c730d17cb9200000c8a5c758d594b2200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$.~r~n' + '~r~n* LINE = ' + string(ldw_modified[i].istr_dberror.errorrow) + '~r~n* SQLDBCODE = ' + string(ldw_modified[i].istr_dberror.sqldbcode) + '~r~n* SQLERRTEXT = ' + ldw_modified[i].istr_dberror.sqlerrtext)
		this.of_setrunningaction('')
		return failure
	end if
next

// Update $$HEX6$$b4b0a9c62000c1c004c72000$$ENDHEX$$Sync $$HEX10$$70b374c730d108c7c4b3b0c6d0c5200018bc01c6$$ENDHEX$$
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

// $$HEX19$$00c8a5c72000c4d6200018c289d520b42000acc0a9c690c7200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
for i = 1 to li_modifiedcnt
	if ldw_modified[i].event pfe_postupdate() = failure then
		this.of_setrunningaction('')
		return failure
	end if
next

// $$HEX11$$00c8a5c7200044c6ccb8200054badcc2c0c97cb92000$$ENDHEX$$Display $$HEX3$$69d5c8b2e4b2$$ENDHEX$$
//if this.of_getrunningaction() = 'update' then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX5$$00c8a5c7200044c6ccb8$$ENDHEX$$!')
//end if

// $$HEX12$$00c8a5c7200044c6ccb8200054badcc2c0c920005cd4dcc2$$ENDHEX$$
if left(iw_parent.dynamic of_getclassname(), 2) = 'w_' then
	iw_parent.dynamic of_setmessage('$$HEX14$$15c8c1c001c83cc75cb8200000c8a5c7200018b4c8c5b5c2c8b2e4b2$$ENDHEX$$')
end if

this.of_setrunningaction('')
return success

end function

public function long of_datawindowaction (string as_action);// $$HEX7$$70b374c730d108c7c4b3b0c62000$$ENDHEX$$CRUD $$HEX13$$1cc144bea4c2200030aea5b244c7200038d69ccd69d5c8b2e4b2$$ENDHEX$$
// as_function: $$HEX9$$38d69ccd60d520001cc144bea4c2200085ba$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: success=$$HEX2$$31c1f5ac$$ENDHEX$$, failure=$$HEX2$$e4c228d3$$ENDHEX$$

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
		messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + as_action + '] $$HEX1$$40c7$$ENDHEX$$($$HEX1$$94b2$$ENDHEX$$) $$HEX16$$98c7bbba1cb4200070b374c730d108c7c4b3b0c6200061c558c185c7c8b2e4b2$$ENDHEX$$')
		return no_action
end choose

return ll_rc

end function

public function long of_print ();// $$HEX17$$9ccd25b8a9c62000f8bbacb9f4bc30ae20003dcc44c72000f4bcecc50dc9c8b2e4b2$$ENDHEX$$

if not isvalid(idw_target) then return failure

integer li_rc

this.of_setrunningaction('print')

// PrePrint Event $$HEX2$$18c289d5$$ENDHEX$$
li_rc = idw_target.event pfe_preprint()
if li_rc <> success then
	this.of_setrunningaction('')
	return li_rc
end if

openwithparm(pf_w_printpreview, idw_target)

// PostPrint Event $$HEX2$$18c289d5$$ENDHEX$$
idw_target.event pfe_postprint()

this.of_setrunningaction('')
return success

end function

public function integer of_logicaldelete (long al_row);
//// $$HEX24$$74d5f9b2200070b374c730d108c7c4b3b0c658c7200004d6acc789d544c720007cb1acb92000adc01cc869d5c8b2e4b2$$ENDHEX$$
//// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$31c1f5ac$$ENDHEX$$=1, $$HEX2$$e4c228d3$$ENDHEX$$=-1
//
//if not isvalid(idw_target) then return failure
//
//this.of_setrunningaction('deleterow')
//this.post of_setrunningaction('')
//
//// $$HEX13$$adc01cc860d5200089d574c72000c6c53cc774ba2000acb934d1$$ENDHEX$$
//long ll_row
//
//if al_row = 0 then
//	ll_row = idw_target.getrow()
//else
//	ll_row = al_row
//end if
//
//if 1 > ll_row or idw_target.rowcount() < ll_row then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX13$$adc01cc860d5200070b374c730d100ac2000c6c5b5c2c8b2e4b2$$ENDHEX$$')
//	return no_action
//end if
//
//// $$HEX27$$58d504c7200070b374c730d104c7c4b3b0c658c7200070b374c730d100ac200074c8acc758d574ba200089d5adc01cc8200088bd00ac$$ENDHEX$$
//integer li_synccnt, li_linkcnt, i, j
//pf_u_datawindow ldw_synced[], ldw_dlink[]
//long ll_rc
//
//li_synccnt = idw_target.inv_link.of_getsynceddatawindow(ldw_synced)
//for i = 1 to li_synccnt
//	li_linkcnt = ldw_synced[i].inv_link.of_getdownlinkeddatawindow(ldw_dlink)
//	for j = 1 to li_linkcnt
//		if ldw_dlink[j].rowcount() > 0 then
//			messagebox('[' + idw_target.of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + ldw_dlink[j].of_gettitle() + '] $$HEX26$$d0c5200070b374c730d100ac200074c8acc758d530ae20004cb538bbd0c52000adc01cc860d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX3$$3cba00c82000$$ENDHEX$$[' + ldw_dlink[j].of_gettitle() + '] $$HEX18$$70b374c730d17cb92000adc01cc82000c4d62000e4b2dcc22000dcc2c4b358d538c194c6$$ENDHEX$$.')
//			return failure
//		end if
//	next
//next
//
//// $$HEX10$$89d5adc01cc82000acc0a9c690c7200055d678c7$$ENDHEX$$
//choose case idw_target.getitemstatus(ll_row, 0, primary!)
//	case new!, newmodified!
//		ll_rc = 1
//	case datamodified!, notmodified!
//		ll_rc = messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX18$$20c1ddd01cb4200070b374c730d17cb92000adc01cc8200058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2)
//end choose
//
//if ll_rc = 2 then return no_action
//
//// $$HEX23$$89d5adc01cc8200004c82000e4c289d560d5200070b374c730d108c7c4b3b0c6200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
//for i = li_synccnt to 1 step -1
//	if ldw_synced[i].event pfe_predeleterow() = failure then return failure
//next
//
//// $$HEX4$$f0c5c4ac1cb42000$$ENDHEX$$Sync $$HEX20$$70b374c730d108c7c4b3b0c67cb920007cb1acb92000adc01cc8200098ccacb9200069d5c8b2e4b2$$ENDHEX$$
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
//					messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'Transaction Object$$HEX16$$00ac20002cc614bc5cb8200024c115c818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$')
//					return failure
//				end if
//				
//				lds_deltemp.dataobject = idw_target.dataobject
//				lds_deltemp.settransobject(ltr_sql)
//				
//				// del_reason $$HEX2$$24c115c8$$ENDHEX$$
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
//							messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX21$$adc01cc8acc020c7200085c725b82000e8cd8cc15cb82000adc01cc87cb9200011c9e8b269d5c8b2e4b2$$ENDHEX$$.')
//							return no_action
//						end if
//					else
//						messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX21$$adc01cc8acc020c7200085c725b82000e8cd8cc15cb82000adc01cc87cb9200011c9e8b269d5c8b2e4b2$$ENDHEX$$.')
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
//				// del_yn $$HEX2$$24c115c8$$ENDHEX$$
//				ls_colname = lds_deltemp.of_getcolumnnamebydbname('del_yn', true)
//				if len(ls_colname) > 0 then
//					lds_deltemp.setitem(lds_deltemp.rowcount(), ls_colname, 'Y')
//				else
//					messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'DEL_YN $$HEX21$$eccefcb744c720003ecc44c7200018c22000c6c5b4c52000adc01cc87cb9200011c9e8b269d5c8b2e4b2$$ENDHEX$$.')
//					return failure
//				end if
//				
//				ldtm_now = pf_f_getdbmsdatetime()
//				
//				// del_dtime $$HEX2$$24c115c8$$ENDHEX$$
//				ls_colname = lds_deltemp.of_getcolumnnamebydbname('del_dtime', true)
//				if len(ls_colname) > 0 then
//					lds_deltemp.setitem(lds_deltemp.rowcount(), ls_colname, ldtm_now)
//				end if
//				
//				// mod_dtime $$HEX2$$24c115c8$$ENDHEX$$
//				ls_colname = lds_deltemp.of_getcolumnnamebydbname('mod_dtime', true)
//				if len(ls_colname) > 0 then
//					lds_deltemp.setitem(lds_deltemp.rowcount(), ls_colname, ldtm_now)
//				end if
//				
//				// mod_empno $$HEX2$$24c115c8$$ENDHEX$$
//				ls_colname = lds_deltemp.of_getcolumnnamebydbname('mod_empno', true)
//				if len(ls_colname) > 0 then
//					lds_deltemp.setitem(lds_deltemp.rowcount(), ls_colname, gnv_session.is_user_id)
//				end if
//				
//				// mod_ip $$HEX2$$24c115c8$$ENDHEX$$
//				ls_colname = lds_deltemp.of_getcolumnnamebydbname('mod_ip', true)
//				if len(ls_colname) > 0 then
//					lds_deltemp.setitem(lds_deltemp.rowcount(), ls_colname, gnv_appmgr.is_ipaddress)
//				end if
//				
//				// del_reason $$HEX2$$24c115c8$$ENDHEX$$
//				ls_colname = lds_deltemp.of_getcolumnnamebydbname('del_reason', true)
//				if len(ls_delreason) > 0 then
//					lds_deltemp.setitem(lds_deltemp.rowcount(), ls_colname, lstr_parm.astring[3])
//				end if
//				
//				if lds_deltemp.update() = -1 then
//					rollback using ltr_sql;
//					messagebox('$$HEX3$$4cc52000bcb9$$ENDHEX$$', '$$HEX24$$7cb1acb92000adc01cc87cb9200018c289d558d594b2200011c9200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$:~r~n' + ltr_sql.SQLErrText)
//					return failure
//				end if
//				
//				if ltr_sql.sqlnrows = 0 then
//					messagebox('$$HEX3$$4cc52000bcb9$$ENDHEX$$', '$$HEX25$$70b374c730d1a0bc74c7a4c2d0c52000adc01cc860d5200090c7ccb87cb920003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
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
//// $$HEX23$$89d5adc01cc82000c4d62000e4c289d560d5200070b374c730d108c7c4b3b0c6200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
//for i = li_synccnt to 1 step -1
//	ldw_synced[i].event pfe_postdeleterow(al_row)
//next
//
//// $$HEX12$$adc01cc8200044c6ccb8200054badcc2c0c920005cd4dcc2$$ENDHEX$$
//if left(iw_parent.dynamic of_getclassname(), 2) = 'w_' then
//	iw_parent.dynamic of_setmessage('$$HEX14$$15c8c1c001c83cc75cb82000adc01cc8200018b4c8c5b5c2c8b2e4b2$$ENDHEX$$')
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

public subroutine of_setnewrowdirection (string as_direction);// InsertRow $$HEX23$$00ac2000e4c289d520b420004cb5200089d594cd00ac60d5200029bca5d544c7200024c115c8200069d5c8b2e4b2$$ENDHEX$$
// upper = $$HEX14$$70b374c730d108c7c4b3b0c62000c1c0e8b2d0c5200089d594cd00ac$$ENDHEX$$
// lower = $$HEX14$$70b374c730d108c7c4b3b0c6200058d5e8b2d0c5200089d594cd00ac$$ENDHEX$$

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

