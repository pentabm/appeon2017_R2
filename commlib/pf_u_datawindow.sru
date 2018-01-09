HA$PBExportHeader$pf_u_datawindow.sru
$PBExportComments$$$HEX7$$70b374c730d108c7c4b3b0c62000$$ENDHEX$$Ancestor $$HEX3$$85c7c8b2e4b2$$ENDHEX$$. $$HEX52$$0cd3ccc604d508b884c7d0c51cc120001cc8f5ac18b494b2200070b374c730d108c7c4b3b0c6200030aea5b2e4b444c72000acc0a9c658d530ae200004c774d51cc194b2200074c72000e8ceb8d264b844c72000c1c08dc120001bbc44c57cc5200069d5c8b2e4b2$$ENDHEX$$.
forward
global type pf_u_datawindow from datawindow
end type
end forward

global type pf_u_datawindow from datawindow
integer width = 686
integer height = 400
boolean livescroll = true
event type boolean pfe_ispowerframecontrol ( )
event mousemove pbm_dwnmousemove
event pfe_mouseover ( long al_row,  dwobject ao_dwo )
event pfe_mouseleave ( )
event pfe_dataobjectchanged ( )
event move pbm_move
event pfe_keydown pbm_dwnkey
event pfe_visiblechanged pbm_showwindow
event pfe_syntaxmodified ( )
event pfe_dwowidthchanged ( )
event timer pbm_timer
event pfe_postopen ( )
event pfe_postretrieve ( long al_rowcount )
event type integer pfe_preretrieve ( )
event type integer pfe_preinsertrow ( )
event pfe_postinsertrow ( long al_new )
event type integer pfe_predeleterow ( )
event pfe_postdeleterow ( long al_deleted )
event type integer pfe_preupdate ( )
event type integer pfe_postupdate ( )
event pfe_processenter pbm_dwnprocessenter
event pfe_postprint ( )
event type integer pfe_preprint ( )
event type integer pfe_preexcel ( )
event pfe_postexcel ( )
event type integer ue_popup ( string as_column,  long al_row )
end type
global pf_u_datawindow pf_u_datawindow

type prototypes

end prototypes

type variables
// $$HEX9$$f5acb5d12000acb934d112ac2000c1c018c2$$ENDHEX$$
constant integer SUCCESS = 1
constant integer FAILURE = -1
constant integer NO_ACTION = 0

// $$HEX2$$c4ac8dc1$$ENDHEX$$/$$HEX9$$11c9c0c92000acb934d112ac2000c1c018c2$$ENDHEX$$
constant integer CONTINUE_ACTION = 1
constant integer PREVENT_ACTION = 0

// $$HEX18$$c0d074c7c0d220004dd1a4c2b8d240c6200070b374c730d108c7c4b3b0c6200004aca9ac$$ENDHEX$$(PIXEL)
constant integer INTERVAL_TITLE_AND_DW = pixelstounits(4, ypixelstounits!)
constant integer INTERVAL_ICON_AND_TITLE = pixelstounits(4, ypixelstounits!)

private:
	transaction itr_trans
	
	string is_PresentationStyle
	string is_backgroundimage
	
	boolean ib_isUpdatable = false
	boolean ib_isOpening = false
	boolean ib_OnceOpened = false
	boolean ib_isEditing = false
	
	// $$HEX16$$70b374c730d124c60cbe1dc8b8d2200000c8a5c78cc12000acc0a9c6ecc580bd$$ENDHEX$$
	boolean ib_useDataobjectRepo = false
	
	// mouseover checking
	pf_s_point istr_point
	pf_n_timing inv_timer
	boolean ib_mouseover
	string is_mouseover
	integer ii_mouseover = -1
	
	integer ii_beginxpos
	string is_beginband
	
	datawindow ldw_sync
	
	pf_u_statictext ist_dwtitle
	picture ip_dwtitle
	string PostTitleIcon = '..\img\datawindow\u_datawindow\dw_title_icon.gif'
	
	long il_orgwidth, il_orgheight
	pf_m_popmenu inv_popmenu
	
	dwobject idwo_getfocused
	dwobject idwo_clicked
	
public:
	// last modified dwobject
	dwobject idwo_lastmodified
	// parent window
	window iw_parent
	// stored dberror information
	pf_s_dwdberror istr_dberror
	
	// datawindow service
	pf_n_dwdesign inv_dwdesign
	pf_n_dwsort inv_dwsort
	pf_n_dwrowselect inv_dwrowselect
	pf_n_argument inv_args
	pf_n_linkage inv_link
	pf_n_required inv_required
	pf_n_dwaction inv_action
	pf_n_defaultvalue inv_defaultvalue
	pf_n_dataobjrepo inv_dataobjrepo
	pf_n_dwresize inv_dwresize
	
	// service properties
	//boolean TransparentBackground = False
	boolean ApplyDesign = True
	boolean SingleRowSelection = True
	boolean MultiRowSelection = False
	boolean AlternativeRowColor = True	
	boolean SortByHeader =  False
	boolean DWResize = False
	boolean PopupMenu = True
	boolean UseBorder = True
	boolean PasteClipboard = False
	boolean isSearchCondition = False
	boolean DisplayTitleOnTop = False
	boolean AddColumnPadding = True
	//boolean SetDisabledColumnBackColor = True
	boolean ConfirmUpdateOnRowChange = true
	boolean DatawindowAction = False
	string UpLinkedDatawindow
	string RetrievalArguments
	string DefaultValuesOnInsertRow
	
	// resize properties
	boolean FixedToRight
	boolean FixedToBottom
	boolean ScaleToRight
	boolean ScaleToBottom

end variables

forward prototypes
public subroutine of_resize ()
public function string of_getclassname ()
public function string of_getpresentationstyle ()
public function string of_getexpvalue (string as_exp, long al_row)
public function integer of_setbackgroundimage ()
public function integer settransobject (transaction t)
public function boolean of_issearchcondition ()
public function string of_gettitle ()
public function integer of_setdataobject (string as_dataobject)
public function integer of_displaytitleontop ()
public subroutine of_setvisible (boolean ab_visible)
public function string of_getlastcolumnname ()
public function boolean of_isupdatable ()
public function transaction of_gettransobject ()
public function integer of_setargumentservice (boolean ab_switch)
public function integer of_setdefaultvalueservice (boolean ab_switch)
public function integer of_setrequiredcolumnservice (boolean ab_switch)
public subroutine of_setdatawindowactionservice (boolean ab_switch)
public function integer of_setdwrowselectservice (boolean ab_switch)
public function integer of_setdwdesignservice (boolean ab_switch)
public function integer of_setdwsortservice (boolean ab_switch)
public function long of_getdberrorcode ()
public function string of_getdberrortext ()
public function boolean of_getservicepropertyvalue (string as_propertyname)
public function integer of_setdwresizeservice (boolean ab_switch)
public function long of_retrieve ()
public function integer of_insertrow (long al_row)
public function integer of_deleterow (long al_row)
public function integer of_update (boolean ab_commit)
public function integer of_setargument (string as_argname, any aa_argvalue)
public function integer of_setuplinkeddatawindow (string as_dwname)
public subroutine of_setlinkageservice (boolean ab_switch)
public function string of_getpropertyvalue (string as_columnname, string as_propname, long al_row)
public function long insertrow (long r)
end prototypes

event type boolean pfe_ispowerframecontrol();return true

end event

event mousemove;if ib_mouseover = false then
	ib_mouseover = true
	inv_timer.of_start()
end if

if ii_mouseover <> row or is_mouseover <> string(dwo.name) then
	this.event pfe_mouseover(row, dwo)
	ii_mouseover = row
	is_mouseover = string(dwo.name)
end if

end event

event pfe_mouseover(long al_row, dwobject ao_dwo);// mouseover event
if isvalid(inv_dwdesign) then
	inv_dwdesign.post event pfe_mouseover(al_row, ao_dwo)
end if

end event

event pfe_mouseleave();// mouseleave event
if ib_mouseover = true then
	ib_mouseover = false
	inv_timer.stop()
end if

ii_mouseover = -1
is_mouseover = ''

if isvalid(inv_dwdesign) then
	inv_dwdesign.post event pfe_mouseleave()
end if

end event

event pfe_dataobjectchanged();if isvalid(inv_dwdesign) then destroy inv_dwdesign
if isvalid(inv_dwsort) then destroy inv_dwsort
if isvalid(inv_dwrowselect) then destroy inv_dwrowselect
if isvalid(inv_dwresize) then destroy inv_dwresize

if isvalid(inv_args) then destroy inv_args
if isvalid(inv_required) then destroy inv_required
if isvalid(inv_defaultvalue) then destroy inv_defaultvalue

if isvalid(inv_link) then destroy inv_link
if isvalid(inv_action) then destroy inv_action
if isvalid(inv_dataobjrepo) then destroy inv_dataobjrepo

// check if the datawindow is empty
if long(this.describe("datawindow.column.count")) = 0 then return

// get dwobject presentation style
is_presentationstyle = of_getpresentationstyle()

// use dw design service
this.of_setdwdesignservice(ApplyDesign)
if isvalid(inv_dwdesign) then
	if ib_useDataobjectRepo = true then
		if inv_dataobjrepo.of_applydesignedsyntax() <> 1 then
			inv_dwdesign.of_applydesign()
			inv_dataobjrepo.of_backupdesignedsyntax()
		end if
	else
		inv_dwdesign.of_applydesign()
	end if
end if

// use dw sort serivce
this.of_setdwsortservice(SortByHeader)

// use dw row-select serivce
this.of_setdwrowselectservice(MultiRowSelection)

// use dw resize service
this.of_setdwresizeservice(DWResize)

// set default transaction object
transaction lnv_trans
lnv_trans = this.of_gettransobject()
if not isvalid(lnv_trans) then
	this.settransobject(sqlca)
else
	this.settransobject(lnv_trans)
end if

// check if datawindow is updatable
choose case this.describe("DataWindow.Table.UpdateTable")
	case '!', '?', ''
		ib_isupdatable = false
	case else
		ib_isupdatable = true
end choose

// set argument service to true
this.of_setargumentservice(true)

// set defaultvalueservice to true
this.of_setdefaultvalueservice(true)

// set requiredcolumnservice to true
this.of_setrequiredcolumnservice(true)

// draw custom border
if UseBorder = true and this.titlebar = false and this.controlmenu = false then
	if not isvalid(inv_dwdesign) then
		this.of_setdwdesignservice(true)
	end if
	if isvalid(inv_dwdesign) then
		inv_dwdesign.of_drawcustomborder()
	end if
end if

// set datawindow linkage service(need rechecking)
//this.of_setlinkageservice(true)

// set datawindow action service
this.of_setdatawindowactionservice(DatawindowAction)

// dddw$$HEX3$$70c88cd62000$$ENDHEX$$& $$HEX12$$70c88cd670c874ac78c72000bdacb0c6200089d594cd00ac$$ENDHEX$$
if DatawindowAction = true then
	if is_presentationstyle = 'SearchCondition' then
		this.inv_action.of_retrievedddw()
		if this.rowcount() = 0 then
			this.insertrow(0)
		end if
	else
		this.inv_action.of_retrievedddw()
	end if
end if

end event

event move;long ll_xpos, ll_ypos

if isvalid(inv_dwdesign) then
	inv_dwdesign.event move(xpos, ypos)
end if

if isvalid(ip_dwtitle) then
	ll_xpos = xpos
	ll_ypos = ypos - ist_dwtitle.height - INTERVAL_TITLE_AND_DW + ((ist_dwtitle.height - ip_dwtitle .height) / 2)
	ip_dwtitle.move(ll_xpos, ll_ypos)
end if

if isvalid(ist_dwtitle) then
	ll_xpos = xpos + ip_dwtitle.width + INTERVAL_ICON_AND_TITLE
	ll_ypos = ypos - ist_dwtitle.height - INTERVAL_TITLE_AND_DW
	ist_dwtitle.move(ll_xpos, ll_ypos)
end if

end event

event pfe_keydown;// ESC$$HEX5$$a4d0200098ccacb92000$$ENDHEX$$= $$HEX15$$74d0adb920001cc21cc100b35cb8200085c725b8b4b0a9c62000e8cd8cc1$$ENDHEX$$, $$HEX14$$c1c004c7f0c5c4ac200070b374c730d108c7c4b3b0c6200074c7d9b3$$ENDHEX$$, $$HEX13$$70c88cd670c874ac200074c7d9b3200098ccacb969d5c8b2e4b2$$ENDHEX$$
if key = KeyEscape! then
	
	// 1. $$HEX10$$85c725b8b4b0a9c62000e8cd8cc1200098ccacb9$$ENDHEX$$
	if ib_isEditing = true then
		ib_isEditing = false
		return 0
	end if
	
	// 2. $$HEX15$$c1c004c7f0c5c4ac200070b374c730d108c7c4b3b0c65cb8200074c7d9b3$$ENDHEX$$
	if len(UpLinkedDatawindow) > 0 then
		if isvalid(inv_link) then
			datawindow ldw_uplinked
			ldw_uplinked = inv_link.of_getuplinkeddatawindow()
			if isvalid(ldw_uplinked) then
				ldw_uplinked.post setfocus()
				
				// $$HEX28$$c1c004c7200070b374c730d108c7c4b3b0c600ac2000edd098d374c7c0c9d0c5200088c794b22000bdacb0c62000edd098d374c7c0c92000$$ENDHEX$$Focus $$HEX2$$98ccacb9$$ENDHEX$$
				graphicobject lgo_parent
				lgo_parent = ldw_uplinked.getparent()
				if lgo_parent.typeof() = userobject! then
					if lgo_parent.getparent().typeof() = tab! then
						tab lt_parent
						lt_parent = lgo_parent.getparent()
						if lt_parent.control[lt_parent.selectedtab].classname() <> lgo_parent.classname() then
							lt_parent.post selecttab(lgo_parent)
						end if
					end if
				end if
				
				return 1
			end if
		end if
	end if
	
	// 3. $$HEX15$$70c88cd670c874ac200070b374c730d108c7c4b3b0c65cb8200074c7d9b3$$ENDHEX$$
	if this.classname() <> 'dw_cond' then
		datawindow ldw_cond
		ldw_cond = iw_parent.dynamic of_getwindowobjectbyname('dw_cond')
		if isvalid(ldw_cond) then
			ldw_cond.post setfocus()
			return 1
		end if
		
//	// 4. $$HEX8$$54d674ba2000ebb230ae200098ccacb9$$ENDHEX$$
//	else
//		post close(iw_parent)
//		return 1
	end if
end if

//// $$HEX2$$1dd3c5c5$$ENDHEX$$(F9) $$HEX3$$98ccacb92000$$ENDHEX$$= $$HEX21$$f5acb5d120001dd3c5c52000eccefcb778c72000bdacb0c620001dd3c5c508c7c4b3b0c6200038d69ccd$$ENDHEX$$
//if key = KeyF9! then
//	string ls_column, ls_objtype, ls_tag
//	long ll_row
//	
//	ll_row = this.getrow()
//	if ll_row < 1 then return 0
//	
//	ls_column = this.getcolumnname()
//	if ls_column = '' then return 0
//	
//	ls_objtype = this.describe(ls_column + '.Type')
//	if ls_objtype <> 'column' then return 0
//	
//	ls_tag = this.describe(ls_column + '.Tag')
//	if len(ls_tag) = 0 then return 0
//	
//	// $$HEX10$$1dd3c5c52000eccefcb778c72000bdacb0c62000$$ENDHEX$$ue_popup $$HEX6$$74c7a4bcb8d2200038d69ccd$$ENDHEX$$
//	if match(ls_tag, 'posticon *= *popup') = true then
//		if long(this.of_getpropertyvalue(ls_column, "Protect", ll_row)) = 0 then
//			this.post event ue_popup(ls_column, ll_row)
//		end if
//		
//	// $$HEX10$$ecb225b82000eccefcb778c72000bdacb0c62000$$ENDHEX$$Calendar $$HEX5$$1dd3c5c5200098ccacb9$$ENDHEX$$(YearMon)
//	elseif match(ls_tag, 'posticon *= *yearmonth') = true then
//		if long(this.of_getpropertyvalue(ls_column, "Protect", ll_row)) = 0 then
//			pf_f_setyearmonth_dw(this, this.object.__get_attribute(ls_column, true), ll_row)
//		end if
//	
//	// $$HEX10$$ecb225b82000eccefcb778c72000bdacb0c62000$$ENDHEX$$Calendar $$HEX5$$1dd3c5c5200098ccacb9$$ENDHEX$$(Day)
//	elseif match(ls_tag, 'posticon *= *calendar') = true then
//		if long(this.of_getpropertyvalue(ls_column, "Protect", ll_row)) = 0 then
//			pf_f_setcalendardate_dw(this, this.object.__get_attribute(ls_column, true), ll_row)
//		end if
//		
//	end if
//end if

// $$HEX2$$80acc9c0$$ENDHEX$$(Ctrl + F) $$HEX3$$98ccacb92000$$ENDHEX$$= $$HEX17$$70b374c730d108c7c4b3b0c62000b4b0a9c644c7200080acc9c0200069d5c8b2e4b2$$ENDHEX$$
if (keyflags = 2 and key = KeyF!) then
	choose case this.of_getpresentationstyle()
		case 'Grid', 'Tabular'
			openwithparm(pf_w_popmenusearch, this)			
		case else
			messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX28$$74d5f9b2200070b374c730d1200091c5ddc240c7200080acc9c0200030aea5b244c72000acc0a9c660d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$.')
	end choose
	
	return 0
end if

// $$HEX5$$99bdecc523b130ae2000$$ENDHEX$$(Ctrl + V) $$HEX3$$98ccacb92000$$ENDHEX$$= $$HEX26$$74d0bdb9f4bcdcb4200070b374c730d17cb9200070b374c730d108c7c4b3b0c6d0c5200099bdecc523b130ae200069d5c8b2e4b2$$ENDHEX$$
if PasteClipboard = true then
	if keyflags = 2 and key = KeyV! then

		string ls_rows[], ls_fields[]
		string ls_data, ls_columnname
		long ll_rowcnt, ll_currrow
		long ll_fieldcnt, i, j
		
		// get current row
		ll_currrow = this.getrow()
		if ll_currrow = 0 then return 0
		
		// get current column
		ls_columnname = this.getcolumnname()
		if ls_columnname = "" then return 0
		
		// get data from clipboard
		ls_data = trim(::clipboard())
		if len(ls_data) = 0 then return 0
		if right(ls_data, 2) = "~r~n" then ls_data = left(ls_data, len(ls_data) - 2)
		
		// parse the clipboard data into row
		ll_rowcnt = pf_f_parsetoarray(ls_data, "~r~n", ls_rows[])
		for i = 1 to ll_rowcnt
			
			// parse the row data into field
			ll_fieldcnt = pf_f_parsetoarray(ls_rows[i], "~t", ls_fields[])
			for j = 1 to ll_fieldcnt
				// paste data
				this.settext(ls_fields[j])
				// move focus to the next column
				if j < ll_fieldcnt then
					send(handle(this), 256, 9, long(0,0))
				end if
			next
			
			// move focus to the next row
			if i < ll_rowcnt then
				ll_currrow ++
				if ll_currrow > this.rowcount() then
					this.insertrow(0)
				end if
				
				this.scrolltorow(ll_currrow)
				this.setrow(ll_currrow)
				this.setcolumn(ls_columnname)
			end if
		next
	end if
end if

return 0

end event

event pfe_visiblechanged;// visible changed
if isvalid(inv_dwdesign) then
	inv_dwdesign.post event pfe_visiblechanged()
end if

if isvalid(ip_dwtitle) then
	ip_dwtitle.visible = this.visible
end if

if isvalid(ist_dwtitle) then
	ist_dwtitle.visible = this.visible
end if

end event

event pfe_dwowidthchanged();// dwo width modified
if isvalid(inv_dwdesign) then
	inv_dwdesign.event pfe_dwowidthchanged()
end if

end event

event timer;if gnv_extfunc.GetCursorPos(istr_point) then
	if gnv_extfunc.ScreenToClient(handle(this), istr_point) then
		if istr_point.xpos >= 0 and istr_point.ypos >= 0 and istr_point.xpos <= unitstopixels(this.width, xunitstopixels!) and istr_point.ypos <= unitstopixels(this.height, yunitstopixels!) then
		else
			ib_mouseover = false
			inv_timer.stop()
			this.post event pfe_mouseleave()
		end if
	end if
end if

end event

event pfe_postopen();// $$HEX23$$60d5f9b21cb4200070b374c730d108c7c4b3b0c6200024c60cbe1dc8b8d200ac2000c6c53cc774ba2000acb934d1$$ENDHEX$$
if this.dataobject = '' then return

//// $$HEX15$$31bcf8ad7cb7b4c6dcb4200074c7f8bbc0c97cb9200024c115c85cd5e4b2$$ENDHEX$$($$HEX3$$f8bbacc0a9c6$$ENDHEX$$)
//if TransparentBackground then
//	this.of_setbackgroundimage()
//	this.visible = true
//end if

ib_isOpening = false

//// DDDW$$HEX5$$70c88cd620000fbc2000$$ENDHEX$$Freeform $$HEX14$$a4c2c0d07cc7200070b374c730d108c7c4b3b0c6200089d594cd00ac$$ENDHEX$$
//if this.DatawindowAction = true then
//	choose case this.of_getpresentationstyle()
//		case 'SearchCondition'
//			this.inv_action.of_retrievedddw()
//			if this.rowcount() = 0 then
//				this.inv_action.of_insertrow(0)
//			end if
//		case 'Freeform'
//			this.inv_action.post of_retrievedddw()
//			//if this.rowcount() = 0 then
//			//	this.inv_action.post of_insertrow(0)
//			//end if
//		case else
//			this.inv_action.post of_retrievedddw()
//	end choose
//end if

end event

event pfe_postretrieve(long al_rowcount);// Post Retrieve Event

end event

event type integer pfe_preretrieve();// Pre Retrieve Event

Return 1

end event

event type integer pfe_preinsertrow();// Pre InsertRow Event

Return 1

end event

event pfe_postinsertrow(long al_new);// Post InsertRow Event

end event

event type integer pfe_predeleterow();// Pre DeleteRow Event

Return 1

end event

event pfe_postdeleterow(long al_deleted);// Post DeleteRow Event

end event

event type integer pfe_preupdate();// Pre Update Event

Return 1

end event

event type integer pfe_postupdate();// Post Update Event

Return 1

end event

event pfe_processenter;string ls_tag, ls_column

ls_column = this.getcolumnname()
if ls_column = '' then return 0
ls_tag = this.describe(ls_column + ".Tag")

// $$HEX14$$d4c530d1a4d0200085c725b82000dcc2200070c88cd6200098ccacb9$$ENDHEX$$
if match(ls_tag, 'processenter *= *retrieve') = true then
	if this.accepttext() = 1 then
		// $$HEX20$$eccefcb712ac2000c0bcbdac74c7200088c794b22000bdacb0c6ccb920001dd3c5c5200098ccacb9$$ENDHEX$$
		if isvalid(idwo_lastmodified) then
			if string(idwo_lastmodified.name) = ls_column then
				// $$HEX17$$85c725b812ac74c7200088c794b22000bdacb0c6ccb9200070c88cd6200098ccacb9$$ENDHEX$$
				if len(this.gettext()) > 0 then
					dragobject ldo_retrieve
					ldo_retrieve = iw_parent.dynamic of_getwindowobjectbyname('cb_retrieve')
					if not isvalid(ldo_retrieve) then return 0
					// $$HEX23$$1dd3c5c52000eccefcb758c72000bdacb0c620001dd3c5c508c7c4b3b0c6200024c608d52000c4d6200070c88cd6$$ENDHEX$$
					if match(ls_tag, 'posticon *= *popup') = true then
						// $$HEX7$$eccefcb720008dc131c174c72000$$ENDHEX$$Protect $$HEX16$$44c5ccb22000bdacb0c620001dd3c5c5200098ccacb92000c4d6200070c88cd6$$ENDHEX$$(ue_popup()=1$$HEX9$$44c72000acb934d15cd52000bdacb0c6ccb9$$ENDHEX$$)
						if long(this.of_getpropertyvalue(ls_column, "Protect", this.getrow())) = 0 then
							if this.event ue_popup(ls_column, this.getrow()) = 1 then
								ldo_retrieve.post dynamic event clicked()
								setnull(idwo_lastmodified)
								return 1
							end if
						end if
					// $$HEX15$$7cc718bc2000eccefcb740c7200014bc5cb8200070c88cd6200098ccacb9$$ENDHEX$$
					else
						ldo_retrieve.post dynamic event clicked()
						setnull(idwo_lastmodified)
						return 1
					end if
				end if
			end if
		end if
	end if
end if

// $$HEX14$$d4c530d1a4d0200085c725b82000dcc220001dd3c5c5200098ccacb9$$ENDHEX$$
if match(ls_tag, 'processenter *= *popup') = true then
	if this.accepttext() = 1 then
		// $$HEX20$$eccefcb712ac2000c0bcbdac74c7200088c794b22000bdacb0c6ccb920001dd3c5c5200098ccacb9$$ENDHEX$$
		if isvalid(idwo_lastmodified) then
			if string(idwo_lastmodified.name) = ls_column then
				// $$HEX17$$85c725b812ac74c7200088c794b22000bdacb0c6ccb920001dd3c5c5200098ccacb9$$ENDHEX$$
				if len(this.gettext()) > 0 then
					// $$HEX7$$eccefcb720008dc131c174c72000$$ENDHEX$$Protect $$HEX11$$44c5ccb22000bdacb0c620001dd3c5c5200098ccacb9$$ENDHEX$$
					if long(this.of_getpropertyvalue(ls_column, "Protect", this.getrow())) = 0 then
						this.post event ue_popup(ls_column, this.getrow())
						setNull(idwo_lastmodified)
						return 1
					end if
				end if
			end if
		end if
	end if
end if

// Enter Key $$HEX5$$85c725b82000dcc22000$$ENDHEX$$Tab Key $$HEX8$$5cb82000c0bc58d6200069d5c8b2e4b2$$ENDHEX$$.
// Multi-Line $$HEX7$$eccefcb758c72000bdacb0c62000$$ENDHEX$$VerticalScrollBar = True$$HEX14$$5cb8200024c115c81cb42000c1c0dcd0ecc57cc5200069d5c8b2e4b2$$ENDHEX$$.
if this.describe(this.getcolumnname() + ".Edit.VScrollBar") = 'yes' then
	return 0
else
	send(handle(this), 256, 9, long(0, 0))
	return 1
end if

end event

event pfe_postprint();// Post Print Event

end event

event type integer pfe_preprint();// Pre Print Event

Return 1

end event

event type integer pfe_preexcel();// Pre Excel Event

Return 1

end event

event pfe_postexcel();// Post Excel Event

end event

event type integer ue_popup(string as_column, long al_row);/*******************************************************************/
// $$HEX7$$98ccacb9b4b0a9c6200020000900$$ENDHEX$$: 	$$HEX26$$1dd3c5c5200084bcbcd274c7200074d0adb91cb42000bdacb0c6200038d69ccd18b494b2200074c7a4bcb8d2200085c7c8b2e4b2$$ENDHEX$$
// Arguments 	: 	as_column = $$HEX11$$1dd3c5c5200098ccacb920b42000eccefcb785ba6dce$$ENDHEX$$
// 						al_row = $$HEX10$$1dd3c5c5200098ccacb920b4200089d588bc38d6$$ENDHEX$$
// Return    	: 1 = $$HEX2$$31c1f5ac$$ENDHEX$$, 0 = $$HEX2$$e8cd8cc1$$ENDHEX$$, -1 = $$HEX2$$e4c228d3$$ENDHEX$$
// $$HEX6$$c0bcbdac74c725b800adacb9$$ENDHEX$$
//==================================================================   
//   $$HEX7$$91c731c190c731c185ba20000900$$ENDHEX$$:	$$HEX14$$5cd5a5c7b0c62000200020002000090091c7200031c120007cc72000$$ENDHEX$$:	2016.02.19 
//   $$HEX7$$91c731c15cb8c1c9200009000900$$ENDHEX$$:	$$HEX33$$1dd3c5c5200084bcbcd274c7200074d0adb920b42000bdacb0c6200018c289d574d57cc560d520005cb8c1c944c72000ecc530aed0c5200091c731c169d5c8b2e4b2$$ENDHEX$$.
//                   $$HEX12$$1dd3c5c574c7200015c8c1c0200085c8ccb818b474ba2000$$ENDHEX$$1$$HEX7$$44c72000acb934d169d5c8b2e4b2$$ENDHEX$$. $$HEX8$$44be15c8c1c0200085c8ccb894b22000$$ENDHEX$$1 $$HEX9$$74c7200044c5ccb2200012ac2000acb934d1$$ENDHEX$$.
//==================================================================   
//   $$HEX7$$c0bcbdac90c731c185ba20000900$$ENDHEX$$:    				$$HEX6$$c0bc2000bdac20007cc72000$$ENDHEX$$:  
//   $$HEX7$$c0bcbdac5cb8c1c9200009000900$$ENDHEX$$:
/*******************************************************************/

return 0

end event

public subroutine of_resize ();
end subroutine

public function string of_getclassname ();return 'pf_u_datawindow'

end function

public function string of_getpresentationstyle ();// $$HEX13$$70b374c730d108c7c4b3b0c6200024c60cbe1dc8b8d258c72000$$ENDHEX$$Presentation Style$$HEX6$$44c72000acb934d15cd5e4b2$$ENDHEX$$

// $$HEX5$$70c88cd670c874ac2000$$ENDHEX$$Datawindow
if isSearchCondition = true then
	return 'SearchCondition'
end if

// Preview Datawindow
choose case lower(this.describe("DataWindow.Print.Preview"))
	case 'yes', '1'
		return 'PrintPreview'
end choose

string ls_processing, ls_style

ls_processing = this.describe("datawindow.processing")
choose case long(ls_processing)
	case 0
		//FreeForm$$HEX5$$78c72000bdacb0c62000$$ENDHEX$$: detail band height$$HEX2$$00ac2000$$ENDHEX$$dw control$$HEX2$$58c72000$$ENDHEX$$height$$HEX2$$58c72000$$ENDHEX$$2.0$$HEX4$$30bc2000f8bbccb9$$ENDHEX$$($$HEX3$$ccb97dc52000$$ENDHEX$$Header$$HEX10$$00ac200088c794b2bdacb0c67cb9200000b344be$$ENDHEX$$)
		long ll_detailheight, ll_dwcontrolheight, ll_headerheight
		
		ll_headerheight = long(this.describe("Datawindow.Header.Height"))
		ll_detailheight = long(this.describe("Datawindow.Detail.Height"))
		ll_dwcontrolheight = This.Height
		
		if ll_headerheight > pixelstounits(10, ypixelstounits!) then
			ls_style = "Tabular"
		elseif ll_detailheight * 2.0 < ll_dwcontrolheight then
			ls_style = "Tabular"
		else
			ls_style = "Freeform"
		end if
	case 1
		ls_style = 'Grid'
	case 2
		ls_style = 'Label'
	case 3
		ls_style = 'Graph'
	case 4
		ls_style = 'Crosstab'
	case 5
		ls_style = 'Composite'
	case 6
		ls_style = 'OLE'
	case 7
		ls_style = 'RichText'
	case 8
		ls_style = 'TreeView'
	case 9
		ls_style = 'TreeViewWithGrid'
	Case Else
		ls_style = 'Etc'
end choose

return ls_style

end function

public function string of_getexpvalue (string as_exp, long al_row);String ls_quote = '"', ls_exp

If Pos( as_exp, '"' ) > 0 Then ls_quote = "'"
ls_exp = 'evaluate(' + ls_quote + as_exp + ls_quote + ',' + String( al_row ) + ')'

return string(this.describe(ls_exp))

end function

public function integer of_setbackgroundimage ();string ls_backgroundimage
string ls_band, ls_syntax, ls_errmsg

// background $$HEX2$$a9c62000$$ENDHEX$$bitmap $$HEX2$$ddc031c1$$ENDHEX$$
ls_backgroundimage = this.describe("pf_background.Filename")
if ls_backgroundimage = '!' then
	ls_backgroundimage = gnv_extfunc.of_getpowerframetemppath() + gnv_extfunc.of_getuniqpicturename(this) + "_background.jpg"
	if gnv_extfunc.of_getpbcontrolbackgroundimage(this, ls_backgroundimage) = false then
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX10$$30bcbdac54d674ba2000ddc031c12000e4c228d3$$ENDHEX$$!')
		return -1
	end if
	
	// appeon$$HEX2$$40c72000$$ENDHEX$$background/foreground band$$HEX6$$8dc131c12000f8bbc0c9d0c6$$ENDHEX$$
	if appeongetclienttype() = 'WEB' then
		if long(this.describe("datawindow.header.height")) > 0 then
			ls_band = 'header'
		else
			ls_band = 'detail'
		end if
	else
		ls_band = 'background'
	end if
	
	ls_syntax = 'bitmap(band=' + ls_band + ' filename="' + ls_backgroundimage + '" x="0" y="0" height="' + string(this.height) + '" width="' + string(this.width) + '" border="0"  name=pf_background visible="1" )'
	
	// Appeon$$HEX2$$40c72000$$ENDHEX$$SetPosition $$HEX6$$68d518c22000f8bbc0c9d0c6$$ENDHEX$$, background $$HEX5$$74c7f8bbc0c97cb92000$$ENDHEX$$syntax 
	// $$HEX13$$e8b9200004c75cb820002cc624b81cc12000c8c06db88cac2000$$ENDHEX$$create $$HEX3$$74d57cc568d5$$ENDHEX$$
	if appeongetclienttype() = 'WEB' then
		string ls_dwsyntax
		long ll_pos
		
		ls_dwsyntax = this.describe("datawindow.syntax")
		ll_pos = pos(ls_dwsyntax, '~r~n)~r~n')
		if ll_pos > 0 then
			ls_dwsyntax = replace(ls_dwsyntax, ll_pos + 5, 0, ls_syntax + '~r~n')
			if this.create(ls_dwsyntax, ls_errmsg) = -1 then
				::clipboard(ls_dwsyntax)
				messagebox('create error', 'of_registerparent()=' + ls_errmsg)
				return -1
			end if
		end if
	else
		ls_errmsg = this.modify('create ' + ls_syntax)
		if len(ls_errmsg) > 0 then
			::clipboard(ls_syntax)
			messagebox('modify error', 'of_registerparent()=' + ls_errmsg)
			return -1
		end if
	end if
end if

return 1

end function

public function integer settransobject (transaction t);this.itr_trans = t
return super::settransobject(t)

end function

public function boolean of_issearchcondition ();// $$HEX24$$70c88cd670c874ac200085c725b8a9c6200070b374c730d108c7c4b3b0c62000ecc580bd7cb92000acb934d15cd5e4b2$$ENDHEX$$.
// $$HEX3$$acb934d112ac$$ENDHEX$$: true=$$HEX12$$70c88cd670c874aca9c6200070b374c730d108c7c4b3b0c6$$ENDHEX$$, false=$$HEX8$$70c88cd670c874aca9c6200044c5d8b2$$ENDHEX$$

return isSearchCondition

end function

public function string of_gettitle ();// $$HEX17$$70b374c730d108c7c4b3b0c62000c0d074c7c0d244c72000acb934d169d5c8b2e4b2$$ENDHEX$$
// $$HEX15$$c0d074c7c0d274c7200024c115c818b4c0c94ac540c72000bdacb0c62000$$ENDHEX$$Classname() $$HEX9$$12ac44c72000acb934d1200069d5c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX10$$70b374c730d108c7c4b3b0c62000c0d074c7c0d2$$ENDHEX$$

string ls_title

ls_title = string(this.title)
if len(trim(ls_title)) = 0 then
	ls_title = string(this.classname())
end if

return ls_title

end function

public function integer of_setdataobject (string as_dataobject);// $$HEX23$$70b374c730d108c7c4b3b0c6200024c60cbe1dc8b8d27cb92000c0bcbdac58d594b2200068d518c285c7c8b2e4b2$$ENDHEX$$
// as_dataobject: $$HEX17$$c0bcbdac60d5200070b374c730d108c7c4b3b0c6200024c60cbe1dc8b8d2200085ba$$ENDHEX$$
// $$HEX2$$acb934d1$$ENDHEX$$: success=$$HEX2$$31c1f5ac$$ENDHEX$$, failure=$$HEX2$$e4c228d3$$ENDHEX$$

// $$HEX23$$60d5f9b21cb4200070b374c730d108c7c4b3b0c6200024c60cbe1dc8b8d200ac2000c6c53cc774ba2000acb934d1$$ENDHEX$$
this.dataobject = as_dataobject
this.event pfe_dataobjectchanged()

return success

end function

public function integer of_displaytitleontop ();if len(trim(this.title)) = 0 then return no_action

// backup message object before OpenUserObject()
message lm_backup
lm_backup = create message
lm_backup.Handle = message.Handle
lm_backup.Number = message.Number
lm_backup.WordParm = message.WordParm
lm_backup.LongParm = message.LongParm
lm_backup.DoubleParm = message.DoubleParm
lm_backup.StringParm = message.StringParm
lm_backup.PowerObjectParm = message.PowerObjectParm
lm_backup.Processed = message.Processed
lm_backup.ReturnValue = message.ReturnValue

long ll_xpos, ll_ypos
long ll_height
pf_s_size lstr_iconsize
pf_s_size lstr_textsize
string ls_text
string ls_fontface
long ll_fontheight
long ll_fontweight

// Get Text Size
ls_text = this.title + space(8)
ls_fontface = '$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$'
ll_fontheight = -9
ll_fontweight = 700

gnv_extfunc.pf_GetTextSizeW(handle(this), ls_text, ls_fontface, ll_fontheight * -1, ll_fontweight, lstr_textsize)

lstr_textsize.width = pixelstounits(lstr_textsize.width, xpixelstounits!)
lstr_textsize.height = pixelstounits(lstr_textsize.height, ypixelstounits!)

// Get Icon Size
if AppeonGetClientType() = 'WEB' then
	PostTitleIcon = pf_f_getimagepathappeon(PostTitleIcon)
end if

gnv_extfunc.pf_getimagesize(PostTitleIcon, lstr_iconsize)
lstr_iconsize.width = pixelstounits(lstr_iconsize.width, xpixelstounits!)
lstr_iconsize.height = pixelstounits(lstr_iconsize.height, ypixelstounits!)

ll_xpos = this.x 
ll_ypos = this.y 

if lstr_iconsize.height > lstr_textsize.height then
	lstr_iconsize.height = lstr_textsize.height
end if

ll_height = lstr_textsize.height + INTERVAL_TITLE_AND_DW
this.height = this.height - ll_height
this.y = this.y + ll_height

// Create Icon
iw_parent.OpenUserObject(ip_dwtitle, ll_xpos, ll_ypos + (lstr_textsize.height - lstr_iconsize.height) / 2)
if parent.typeof() = userobject! then
	gnv_extfunc.setparent(handle(ip_dwtitle), handle(parent))
end if

ip_dwtitle.picturename = PostTitleIcon
ip_dwtitle.originalsize = true
ip_dwtitle.visible = this.visible
if this.bringtotop = true then
	this.bringtotop = false
	this.setposition(behind!, ip_dwtitle)
end if

// Create StaticText
ll_xpos += lstr_iconsize.width + INTERVAL_ICON_AND_TITLE

if ls_fontface = '$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$' then
	ll_ypos -= pixelstounits(1, ypixelstounits!)
end if

iw_parent.OpenUserObject(ist_dwtitle, ll_xpos, ll_ypos)

if parent.typeof() = userobject! then
	gnv_extfunc.setparent(handle(ist_dwtitle), handle(parent))
end if

ist_dwtitle.Text = ls_text
ist_dwtitle.Weight = ll_fontweight
ist_dwtitle.TextColor = 7893093
ist_dwtitle.BackColor = 16777215
ist_dwtitle.TextSize = ll_fontheight
ist_dwtitle.Width = lstr_textsize.width
ist_dwtitle.Height = lstr_textsize.height
ist_dwtitle.FocusRectangle = false
ist_dwtitle.visible = this.visible

if this.bringtotop = true then
	this.bringtotop = false
	this.setposition(behind!, ist_dwtitle)
end if

// restore message object
message.Handle = lm_backup.Handle
message.Number = lm_backup.Number
message.WordParm = lm_backup.WordParm
message.LongParm = lm_backup.LongParm
message.DoubleParm = lm_backup.DoubleParm
message.StringParm = lm_backup.StringParm
message.PowerObjectParm = lm_backup.PowerObjectParm
message.Processed = lm_backup.Processed
message.ReturnValue = lm_backup.ReturnValue

return 0

end function

public subroutine of_setvisible (boolean ab_visible);// $$HEX7$$70b374c730d108c7c4b3b0c62000$$ENDHEX$$Visible $$HEX9$$8dc131c144c7200024c115c869d5c8b2e4b2$$ENDHEX$$

if this.visible <> ab_visible then
	this.visible = ab_visible
	if appeongetclienttype() = 'WEB' then
		this.event pfe_visiblechanged(ab_visible, 0)
	end if
end if

end subroutine

public function string of_getlastcolumnname ();// $$HEX17$$70b374c730d108c7c4b3b0c658c7200000aca5c72000c8b9c0c9c9b92000eccefcb7$$ENDHEX$$(=Max TabOrder)$$HEX6$$7cb920003eccb5c2c8b2e4b2$$ENDHEX$$.
// $$HEX4$$eccefcb774c72000$$ENDHEX$$Visible = false $$HEX4$$74c770ac98b02000$$ENDHEX$$Protect = true $$HEX12$$78c72000bdacb0c694b220001cc878c6200029b4c8b2e4b2$$ENDHEX$$.
// Appeon $$HEX3$$d0c51cc12000$$ENDHEX$$pbm_dwntabout $$HEX22$$74c7a4bcb8d27cb92000c0c9d0c658d5c0c920004ac530ae20004cb538bbd0c5200074c7200068d518c25cb8$$ENDHEX$$
// $$HEX13$$c8b9c0c9c9b92000eccefcb744c7200055d678c769d5c8b2e4b2$$ENDHEX$$.

if isnull(this) then return ''
if not isvalid(this) then return ''

integer li_columncnt, i
integer li_tabseq, li_maxtabseq
long ll_pos
string ls_maxcolumn, ls_columnname
string ls_visible, ls_protect

li_columncnt = integer(this.describe("datawindow.column.count"))
for i = 1 to li_columncnt
	li_tabseq = integer(this.Describe("#" + string(i) + ".TabSequence"))
	ls_columnname = this.describe("#" + string(i) + ".Name")
	
	ls_protect = this.describe(ls_columnname + ".Protect")
	ll_pos = pos(ls_protect, '~t')
	
	// Expression $$HEX6$$ecd368d51cb42000bdacb0c6$$ENDHEX$$
	If ll_pos > 0 Then
		ls_protect = mid(ls_protect, ll_pos + 1, len(ls_protect) - ll_pos - 1)
		ls_protect = this.describe("Evaluate(~"" + ls_protect + "~", " + string(this.getrow()) + ")")
	End If	
	
	ls_visible = this.describe(ls_columnname + ".visible")
	ll_pos = pos(ls_visible, '~t')
	// Expression $$HEX6$$ecd368d51cb42000bdacb0c6$$ENDHEX$$
	If ll_pos > 0 Then
		ls_visible = mid(ls_visible, ll_pos + 1, len(ls_visible) - ll_pos - 1)
		ls_visible = this.describe("Evaluate(~"" + ls_visible + "~", " + string(this.getrow()) + ")")
	End If	
	
	// Visible=0 $$HEX3$$10b694b22000$$ENDHEX$$Protect=1 $$HEX5$$78c72000bdacb0c62000$$ENDHEX$$Skip
	if ls_visible = '0' or ls_protect = '1' then continue
	
	if li_tabseq > li_maxtabseq then
		li_maxtabseq = li_tabseq
		ls_maxcolumn = ls_columnname
	end if
next

if li_maxtabseq = 0 then
	// $$HEX17$$eccefcb774c72000c6c570ac98b0200085c725b8200000aca5b25cd52000eccefcb7$$ENDHEX$$(TabSequence>0) $$HEX4$$74c72000c6c54cc7$$ENDHEX$$?
	return ''
else
	return ls_maxcolumn
end if

end function

public function boolean of_isupdatable ();return ib_isUpdatable

end function

public function transaction of_gettransobject ();return itr_trans

end function

public function integer of_setargumentservice (boolean ab_switch);// RetrievalArgument $$HEX6$$1cc144bea4c2200024c115c8$$ENDHEX$$
if ab_switch = true then
	if not isvalid(inv_args) then
		inv_args = create pf_n_argument
		inv_args.of_initialize(this, iw_parent)
		if not pf_f_isemptystring(RetrievalArguments) then
			inv_args.of_parsearguments(RetrievalArguments)
		end if
	end if
else
	if isvalid(inv_args) then
		destroy inv_args
	end if
end if
		
return 1

end function

public function integer of_setdefaultvalueservice (boolean ab_switch);// DefaultValuesOnInsertRow $$HEX6$$1cc144bea4c2200024c115c8$$ENDHEX$$
if ab_switch = true then
	if not isvalid(inv_defaultvalue) then
		inv_defaultvalue = create pf_n_defaultvalue
		inv_defaultvalue.of_initialize(this, iw_parent)
		if not pf_f_isemptystring(DefaultValuesOnInsertRow) then
			inv_defaultvalue.of_parsedefaultvalues(DefaultValuesOnInsertRow)
		end if
	end if
else
	if isvalid(inv_defaultvalue) then
		destroy inv_defaultvalue
	end if
end if
		
return 1

end function

public function integer of_setrequiredcolumnservice (boolean ab_switch);// $$HEX18$$44d518c2200085c725b820006dd5a9ba2000b4cc6cd020001cc144bea4c2200024c115c8$$ENDHEX$$
if ib_isupdatable = false then
	if isSearchCondition = false then
		return 0
	end if
end if

if ab_switch = true then
	if not isvalid(inv_required) then
		inv_required = create pf_n_required
		inv_required.of_initialize(this, iw_parent)
	end if
else
	if isvalid(inv_required) then
		destroy inv_required
	end if
end if

return 1

end function

public subroutine of_setdatawindowactionservice (boolean ab_switch);if ab_switch = true then
	if not isvalid(inv_link) then
		inv_link = create pf_n_linkage
		inv_link.of_initialize(this, iw_parent)
		inv_link.of_setuplinkeddatawindow(UpLinkedDatawindow)
		inv_link.of_setdownlinkeddatawindowall()
	end if
	
	if not isvalid(inv_action) then
		inv_action = create pf_n_dwaction
		inv_action.of_initialize(this, iw_parent)
	end if
else
	if isvalid(inv_action) then
		destroy inv_action
	end if
	
	if isvalid(inv_link) then
		destroy inv_link
	end if
end if

end subroutine

public function integer of_setdwrowselectservice (boolean ab_switch);// Grid, Tabular $$HEX5$$a4c2c0d07cc7ccb92000$$ENDHEX$$RowSelect $$HEX2$$00aca5b2$$ENDHEX$$
choose case is_PresentationStyle
	case 'Grid', 'Tabular'
	case else
		return 0
end choose

if ab_switch = true then
	if not isvalid(inv_dwrowselect) then
		inv_dwrowselect = create pf_n_dwrowselect
		inv_dwrowselect.of_initialize(this)
	end if
else
	if isvalid(inv_dwrowselect) then
		destroy inv_dwrowselect
	end if
end if

return 1

end function

public function integer of_setdwdesignservice (boolean ab_switch);if ab_switch = true then
	if not isvalid(inv_dwdesign) then
		choose case lower(is_presentationstyle)
			case 'grid'
				inv_dwdesign = create pf_n_dwdesign_grid
			case 'tabular'
				inv_dwdesign = create pf_n_dwdesign_tabular
			case 'freeform'
				inv_dwdesign = create pf_n_dwdesign_freeform
			case 'searchcondition'
				inv_dwdesign = create pf_n_dwdesign_searchcondition
			case else
				return 0
		end choose
		
		inv_dwdesign.of_initialize(this, iw_parent)
		
		inv_dataobjrepo = create pf_n_dataobjrepo
		inv_dataobjrepo.of_initialize(this, iw_parent, inv_dwdesign.classname())
	end if
else
	if isvalid(inv_dwdesign) then
		destroy inv_dwdesign
	end if
	
	if isvalid(inv_dataobjrepo) then
		destroy inv_dataobjrepo
	end if
end if

return 1
end function

public function integer of_setdwsortservice (boolean ab_switch);// Grid, Tabular $$HEX5$$a4c2c0d07cc7ccb92000$$ENDHEX$$Sort $$HEX2$$00aca5b2$$ENDHEX$$
choose case is_PresentationStyle
	case 'Grid', 'Tabular'
	case else
		return 0
end choose

if ab_switch = true then
	if not isvalid(inv_dwsort) then
		inv_dwsort = create pf_n_dwsort
		inv_dwsort.of_initialize(this)
	end if
else
	if isvalid(inv_dwsort) then
		destroy inv_dwsort
	end if
end if

return 1

end function

public function long of_getdberrorcode ();return istr_dberror.sqldbcode

end function

public function string of_getdberrortext ();return istr_dberror.sqlerrtext

end function

public function boolean of_getservicepropertyvalue (string as_propertyname);// $$HEX24$$70b374c730d108c7c4b3b0c620001cc144bea4c2200004d55cb87cd3f0d2200012ac44c72000acb934d169d5c8b2e4b2$$ENDHEX$$.
boolean lb_null

choose case as_propertyname
	//case 'TransparentBackground'
	//	return TransparentBackground
	case 'ApplyDesign'
		return ApplyDesign
	case 'SingleRowSelection'
		return SingleRowSelection
	case 'MultiRowSelection'
		return MultiRowSelection
	case 'AlternativeRowColor'
		return AlternativeRowColor		
	case 'SortByHeader'
		return SortByHeader
	case 'UseBorder'
		return UseBorder
	case 'PasteClipboard'
		return PasteClipboard
	case 'isSearchCondition'
		return isSearchCondition
	case 'DisplayTitleOnTop'
		return DisplayTitleOnTop
	case 'AddColumnPadding'
		return AddColumnPadding
	case 'DatawindowAction'
		return DatawindowAction
	//case 'SetDisabledColumnBackColor'
		//return SetDisabledColumnBackColor
	case 'ConfirmUpdateOnRowChange'
		return ConfirmUpdateOnRowChange
end choose

setnull(lb_null)
return lb_null

end function

public function integer of_setdwresizeservice (boolean ab_switch);integer	li_rc

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid (inv_dwresize) then
		inv_dwresize = create pf_n_dwresize
		inv_dwresize.of_SetRequestor(this)
		inv_dwresize.of_SetOrigSize (this.width, this.height)
		inv_dwresize.of_AutoResizeRegister()
		li_rc = 1
	end if
else
	if IsValid (inv_dwresize) then
		destroy inv_dwresize
		li_rc = 1
	end if
end If

return li_rc

end function

public function long of_retrieve ();// $$HEX22$$70b374c730d108c7c4b3b0c67cb9200070c88cd620001cc144bea4c27cb92000e4c289d5200069d5c8b2e4b2$$ENDHEX$$

if not isvalid(inv_action) then return FAILURE
return inv_action.of_retrieve()

end function

public function integer of_insertrow (long al_row);// $$HEX21$$70b374c730d108c7c4b3b0c6200089d594cd00ac20001cc144bea4c27cb92000e4c289d569d5c8b2e4b2$$ENDHEX$$

if not isvalid(inv_action) then return FAILURE
return inv_action.of_insertrow(al_row)

end function

public function integer of_deleterow (long al_row);// $$HEX21$$70b374c730d108c7c4b3b0c6200089d5adc01cc820001cc144bea4c27cb92000e4c289d569d5c8b2e4b2$$ENDHEX$$

if not isvalid(inv_action) then return FAILURE
return inv_action.of_deleterow(al_row)

end function

public function integer of_update (boolean ab_commit);// $$HEX22$$70b374c730d108c7c4b3b0c62000c5c570b374c7b8d220001cc144bea4c27cb92000e4c289d569d5c8b2e4b2$$ENDHEX$$

if not isvalid(inv_action) then return FAILURE
return inv_action.of_commitupdate()

end function

public function integer of_setargument (string as_argname, any aa_argvalue);// $$HEX31$$70b374c730d108c7c4b3b0c6200070c88cd61cc144bea4c27cb9200004c774d5200070c88cd6200044c5dcad3cbab8d27cb9200024c115c869d5c8b2e4b2$$ENDHEX$$

if isnull(as_argname) then return NO_ACTION
if isnull(aa_argvalue) then return NO_ACTION
if not isvalid(inv_args) then return FAILURE

return inv_args.of_setargument(as_argname, aa_argvalue)

end function

public function integer of_setuplinkeddatawindow (string as_dwname);if not isvalid(inv_link) then return FAILURE
return inv_link.of_setUpLinkedDatawindow(as_dwname)

end function

public subroutine of_setlinkageservice (boolean ab_switch);if ab_switch = true then
	if not isvalid(inv_link) then
		inv_link = create pf_n_linkage
		inv_link.of_initialize(this, iw_parent)
		inv_link.of_setuplinkeddatawindow(UpLinkedDatawindow)
	end if
else
	if isvalid(inv_link) then
		destroy inv_link
	end if
end if

end subroutine

public function string of_getpropertyvalue (string as_columnname, string as_propname, long al_row);// $$HEX20$$eccefcb720008dc131c158c72000e4c21cc8200012ac44c720006cad74d535c6c8b2e4b2200008c6$$ENDHEX$$) emp_id.protect

string ls_expression

ls_expression = this.describe(as_columnname + '.' + as_propname)
if pos(ls_expression, '~t') > 0 then
	if al_row <= 0 or this.rowcount( ) = 0 then 	return mid(ls_expression, 1, pos(ls_expression, '~t' ) - 1)
	ls_expression = '"' + mid(ls_expression, pos(ls_expression, '~t' ) + 1)
	ls_expression = "evaluate(" + ls_expression + ", " + string(al_row) + ")"
else
	ls_expression = as_columnname + '.' + as_propname
end if

return this.describe(ls_expression)

end function

public function long insertrow (long r);// $$HEX6$$89d594cd00ac2000c4d62000$$ENDHEX$$DefaultValue$$HEX5$$00ac200088c73cc774ba$$ENDHEX$$, $$HEX12$$74d5f9b2200012ac3cc75cb8200024c115c869d5c8b2e4b2$$ENDHEX$$.

long ll_rc

ll_rc = super::insertrow(r)

if ll_rc > 0 and isvalid(inv_defaultvalue) then
	inv_defaultvalue.of_setalldefaultvalue(ll_rc)
end if

return ll_rc

end function

on pf_u_datawindow.create
end on

on pf_u_datawindow.destroy
end on

event constructor;if appeongetclienttype() <> 'PB' then
	if ib_OnceOpened = true then return
end if

ib_isOpening = true

// get parent window
iw_parent = pf_f_getparentwindow(this)

//if TransparentBackground then
//	this.visible = false
//end if

// properties monitor
inv_timer = create pf_n_timing
inv_timer.of_initialize(this)

// arrange controls
this.event resize(0, this.width, this.height)

// draw datawindow title
if DisplayTitleOnTop = true then
	this.of_displaytitleontop()
end if

// init dataobject
this.event pfe_dataobjectchanged()

if appeongetclienttype() <> 'PB' then
	ib_OnceOpened = true
end if

// post event
this.post event pfe_postopen()

end event

event resize;if il_orgwidth = newwidth and il_orgheight = newheight then return

// Resize Design Object
if isvalid(inv_dwdesign) then
	inv_dwdesign.event resize(sizetype, newwidth, newheight)
end if

// Resize DWObject
If IsValid (inv_dwresize) Then
	inv_dwresize.Event ue_Resize(sizetype, this.width, this.height)
END IF

// $$HEX12$$58d5e8b2200030bcbdac200074c7f8bbc0c9200098ccacb9$$ENDHEX$$($$HEX12$$8dc1c4b338bb1cc85cb82000acc0a9c6200048c5200068d5$$ENDHEX$$)
//if isvalid(inv_behind) then
//	inv_behind.of_setbehindbackground()
//end if

il_orgwidth = newwidth
il_orgheight = newheight

end event

event destructor;this.of_setdwdesignservice(false)
this.of_setdwsortservice(false)
this.of_setdwrowselectservice(false)
this.of_setargumentservice(false)
this.of_setdefaultvalueservice(false)
this.of_setrequiredcolumnservice(false)

// Appeon2016Build1119 $$HEX4$$84bc04c840c72000$$ENDHEX$$CloseUserObject $$HEX12$$38d69ccd200048c558d574ba200024c658b91cbcddc028b4$$ENDHEX$$
if isvalid(ip_dwtitle) then
	//if appeongetclienttype() = 'PB' then
		if parent.typeof() = userobject! then gnv_extfunc.setparent(handle(ip_dwtitle), handle(iw_parent))
		iw_parent.CloseUserObject(ip_dwtitle)
	//end if
	destroy ip_dwtitle
end if

if isvalid(ist_dwtitle) then
	//if appeongetclienttype() = 'PB' then
		if parent.typeof() = userobject! then gnv_extfunc.setparent(handle(ist_dwtitle), handle(iw_parent))
		iw_parent.CloseUserObject(ist_dwtitle)
	//end if
	destroy ist_dwtitle
end if

if isvalid(inv_timer) then
	destroy inv_timer
end if

end event

event rowfocuschanged;if isvalid(inv_dwdesign) then
	inv_dwdesign.event rowfocuschanged(currentrow)
end if

if this.singlerowselection = true then
	choose case this.of_getpresentationstyle()
		case 'Grid', 'Tabular'
			this.SelectRow(0, False)
			this.SelectRow(currentrow, True)
	end choose
end if

if isvalid(inv_action) then
	inv_action.event pfe_rowfocuschanged(currentrow)
end if

this.post setredraw(true)
return 0

end event

event dberror;// $$HEX8$$d0c5ecb7200015c8f4bc2000f4bc00ad$$ENDHEX$$
istr_dberror.sqldbcode = sqldbcode
istr_dberror.sqlerrtext = sqlerrtext
istr_dberror.sqlsyntax = sqlsyntax
istr_dberror.errorrow = row

// Display the error message
return 0

end event

event itemfocuschanged;//if long(describe(dwo.name + "_rect.x")) > 0 then
//	long ll_xpos, ll_ypos, ll_width, ll_height
//	string ls_syntax
//	
//	ll_xpos = long(this.describe(dwo.name + "_rect.x"))
//	ll_ypos = long(this.describe(dwo.name + "_rect.y"))
//	ll_width = long(this.describe(dwo.name + "_rect.width"))
//	ll_height = long(this.describe(dwo.name + "_rect.height"))
//	
//	ll_xpos += pixelstounits(2, xpixelstounits!)
//	ll_ypos += pixelstounits(2, ypixelstounits!)
//	ll_width -= pixelstounits(4, xpixelstounits!)
//	ll_height -= pixelstounits(4, ypixelstounits!)
//	
//	ls_syntax += "r_getfocused.x='" + string(ll_xpos) + "'~r~n"
//	ls_syntax += "r_getfocused.y='" + string(ll_ypos) + "'~r~n"
//	ls_syntax += "r_getfocused.width='" + string(ll_width) + "'~r~n"
//	ls_syntax += "r_getfocused.height='" + string(ll_height) + "'~r~n"
//	ls_syntax += "r_getfocused.visible='1'"
//	
//	this.modify(ls_syntax)
//end if

//	//this.modify(dwo.name + "_rect.pen.color='" + string(4477149) + "'")
//	this.modify(dwo.name + "_rect.brush.color='" + string(12774911) + "'")
//	
//	if isvalid(idwo_getfocused) then
//		
//		
//		this.modify(idwo_getfocused.name + "_rect.brush.color='" + string(12774911) + "'")
//end if

//choose case describe(dwo.name + '.background.color')
//	case '553648127', '536870912'
//		this.modify(dwo.name + ".background.mode='0'")
//		this.modify(dwo.name + ".background.color='16711680'")
//	case else
//		messagebox('color', describe(dwo.name + '.background.color'))
//end choose

IF IsValid(inv_dwdesign) THEN 
	inv_dwdesign.Event itemfocuschanged(row, dwo)
END IF

end event

event clicked;if not isvalid(dwo) then return 0

long ll_sorted
string ls_filename, ls_column
dwobject ldwo_param

// $$HEX18$$70b374c730d108c7c4b3b0c6200048be2000f5ac31bc200074d0adb9dcc22000acb934d1$$ENDHEX$$
ls_column = string(dwo.name)
if ls_column = 'datawindow' then return 0

this.setredraw(false)
this.post setredraw(true)

if isvalid(inv_dwdesign) then
	inv_dwdesign.event clicked(xpos, ypos, row, dwo)
end if

if isvalid(inv_dwsort) then
	if isvalid(dwo) then
		if string(dwo.band) = 'header' and string(dwo.type) = 'text' then
			ll_sorted = inv_dwsort.event pfe_clicked(xpos, ypos, row, dwo)
		end if
	end if
end if

// backup clicked dwobject
idwo_clicked = dwo

// rowselect service
if isvalid(inv_dwrowselect) then
	inv_dwrowselect.event pfe_clicked(xpos, ypos, row, dwo)
end if

// set row when clicked protected column
if row > 0 and this.of_getpresentationstyle() <> 'Freeform' then
	this.setrow(row)
end if

//// disable vertical column selection
//if ll_sorted = success then
//	return 1
//end if

// Popup $$HEX15$$44c574c758cf200074d0adb92000dcc2200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
ls_filename = string(dwo.name)
if left(ls_filename, 2) = 'p_' and right(ls_filename, 9) = '_compopup' then
	if this.accepttext() = -1 then return 0
	ls_column = mid(ls_filename, 3, len(ls_filename) - 11)

	if long(this.of_getpropertyvalue(ls_column, "Protect", row)) = 0 then
		this.post event ue_popup(ls_column, row)
	end if

// Calendar $$HEX15$$44c574c758cf200074d0adb92000dcc2200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
elseif left(ls_filename, 2) = 'p_' and right(ls_filename, 12) = '_comcalendar' then
	
	if this.accepttext() = -1 then return 0
	ls_column = mid(ls_filename, 3, len(ls_filename) - 14)
	
	if long(this.of_getpropertyvalue(ls_column, "Protect", row)) = 0 then
		if appeongetclienttype() = 'PB' then
			pf_f_setcalendardate_dw(this, this.object.__get_attribute(ls_column, true), row)
		else
			gnv_session.of_put('appeon.pf_w_calendar.dwo.name', ls_column)
			gnv_session.of_put('appeon.pf_w_calendar.dwo.x', long(this.describe(ls_column + ".x")))
			gnv_session.of_put('appeon.pf_w_calendar.dwo.y', long(this.describe(ls_column + ".y")))
			gnv_session.of_put('appeon.pf_w_calendar.dwo.width', long(this.describe(ls_column + ".width")))
			gnv_session.of_put('appeon.pf_w_calendar.dwo.height', long(this.describe(ls_column + ".height")))
			
			pf_f_setcalendardate_dw(this, dwo, row)
		end if
	end if

// YearMonth $$HEX15$$44c574c758cf200074d0adb92000dcc2200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
elseif left(ls_filename, 2) = 'p_' and right(ls_filename, 13) = '_comyearmonth' then
	if this.accepttext() = -1 then return 0
	ls_column = mid(ls_filename, 3, len(ls_filename) - 15)
	
	if long(this.of_getpropertyvalue(ls_column, "Protect", row)) = 0 then
		if appeongetclienttype() = 'PB' then
			pf_f_setyearmonth_dw(this, this.object.__get_attribute(ls_column, true), row)
		else
			gnv_session.of_put('appeon.pf_w_calendar.dwo.name', ls_column)
			gnv_session.of_put('appeon.pf_w_calendar.dwo.x', long(this.describe(ls_column + ".x")))
			gnv_session.of_put('appeon.pf_w_calendar.dwo.y', long(this.describe(ls_column + ".y")))
			gnv_session.of_put('appeon.pf_w_calendar.dwo.width', long(this.describe(ls_column + ".width")))
			gnv_session.of_put('appeon.pf_w_calendar.dwo.height', long(this.describe(ls_column + ".height")))

			pf_f_setyearmonth_dw(this, dwo, row)
		end if
	end if
end if

return 0

end event

event itemerror;//Set the return code to affect the outcome of the event:
//
//0  (Default) Reject the data value and show an error message box
//1  Reject the data value with no message box
//2  Accept the data value
//3  Reject the data value but allow focus to change

return 1

end event

event rowfocuschanging;if isvalid(inv_action) then
	return inv_action.event pfe_rowfocuschanging(currentrow, newrow)
end if

end event

event itemchanged;long ll_rc

// Itemchanged event of datawindow action
if isvalid(inv_action) then
	ll_rc = inv_action.event pfe_itemchanged(row, dwo, data)
end if

// Remember the last modified dwobject
idwo_lastmodified = dwo

// Reset editing flag
ib_isediting = false

return ll_rc

end event

event rbuttondown;//if this.rowcount() = 0 or row = 0 then return
if not isvalid(iw_parent) then return
if not isvalid(gnv_appmgr.iw_mainframe) then return
if POPUPMENU = false then return

inv_popmenu = create pf_m_popmenu
inv_popmenu.idw_target = this

// $$HEX10$$8cad5cd5d0c5200030b578b9200054ba74b22000$$ENDHEX$$Visible $$HEX2$$98ccacb9$$ENDHEX$$
if gnv_session.is_admin_yn = 'Y' then
	inv_popmenu.m_datawindowinfo.visible = true
end if

// $$HEX7$$1dd3c5c554ba74b2200024c608d5$$ENDHEX$$
if iw_parent.windowtype = response! or iw_parent.windowtype = popup! then
	inv_popmenu.PopMenu(iw_parent.PointerX(), iw_parent.PointerY())
else
	inv_popmenu.PopMenu(gnv_appmgr.iw_mainframe.PointerX(), gnv_appmgr.iw_mainframe.PointerY())
end if

destroy inv_popmenu

end event

event getfocus;IF IsValid(inv_dwdesign) THEN 
	inv_dwdesign.Event getfocus()
END IF

end event

event losefocus;IF IsValid(inv_dwdesign) THEN 
	inv_dwdesign.Event losefocus()
END IF

end event

event editchanged;// $$HEX21$$acc0a9c690c700ac200070b374c730d17cb92000b8d3d1c911c978c7c0c920005cd4dcc258d594b22000$$ENDHEX$$flag
ib_isediting = true

end event

