HA$PBExportHeader$pf_w_window.srw
forward
global type pf_w_window from window
end type
type ln_templeft from line within pf_w_window
end type
type ln_tempright from line within pf_w_window
end type
type ln_temptop from line within pf_w_window
end type
type ln_tempbuttom from line within pf_w_window
end type
type ln_tempbutton from line within pf_w_window
end type
type ln_tempstart from line within pf_w_window
end type
end forward

global type pf_w_window from window
integer width = 4626
integer height = 2364
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
event pfe_postopen ( )
event pfe_delete ( )
event pfe_execute ( )
event pfe_insert ( )
event pfe_print ( )
event pfe_reset ( )
event pfe_retrieve ( )
event pfe_update ( )
event type integer pfe_predelete ( )
event type integer pfe_preinsert ( )
event type integer pfe_preretrieve ( )
event type integer pfe_preupdate ( )
event pfe_updateend ( )
event pfe_shortcutkey ( string as_shortcutkey )
ln_templeft ln_templeft
ln_tempright ln_tempright
ln_temptop ln_temptop
ln_tempbuttom ln_tempbuttom
ln_tempbutton ln_tempbutton
ln_tempstart ln_tempstart
end type
global pf_w_window pf_w_window

type variables
// $$HEX9$$f5acb5d12000acb934d112ac2000c1c018c2$$ENDHEX$$
constant integer SUCCESS = 1
constant integer FAILURE = -1
constant integer NO_ACTION = 0

private:
	// $$HEX12$$acb9acc074c788c9a9c6200008c7c4b3b0c620006cd030ae$$ENDHEX$$
	integer ii_width, ii_height
	
	// MDI $$HEX5$$08c7c4b3b0c658c72000$$ENDHEX$$Sheet $$HEX2$$15c8f4bc$$ENDHEX$$
	long il_tab_seq, il_tool_seq, il_sheet_seq
	
	// $$HEX14$$61c558c1200070b374c730d108c7c4b3b0c6200038cc70c8c0bc18c2$$ENDHEX$$
	pf_u_datawindow idw_target[]

public:
	// $$HEX10$$08c7c4b3b0c62000e8ceb8d264b8200038cc70c8$$ENDHEX$$
	windowobject iwo_control[]
	
	// $$HEX7$$0cd37cb7f8bb30d1200015c8f4bc$$ENDHEX$$
	pf_n_hashtable inv_param
	
	// $$HEX9$$80bda8ba200008c7c4b3b0c6200038cc70c8$$ENDHEX$$
	window iw_parent
	
	// $$HEX12$$e8ceb8d264b82000acb9acc074c788c920001cc144bea4c2$$ENDHEX$$
	pf_n_resize inv_resize
	
	// $$HEX10$$04d55cb8f8ada8b7200054ba74b2200015c8f4bc$$ENDHEX$$
	pf_n_menudata inv_menudata
	
	// $$HEX7$$84bcbcd28cad5cd5200015c8f4bc$$ENDHEX$$
	pf_n_buttonrole inv_buttonrole
	
	// $$HEX13$$61c558c1200018c289d560d5200070b374c730d108c7c4b3b0c6$$ENDHEX$$
	string TargetDatawindowForAction
	
	// $$HEX15$$08c7c4b3b0c6200085c8ccb8dcc22000c5c570b374c7b8d2200055d678c7$$ENDHEX$$
	boolean ConfirmUpdateOnClose = false

end variables

forward prototypes
public subroutine of_getcontrols (graphicobject a_control, ref graphicobject a_controls[])
public function integer of_setresizeservice (boolean ab_switch)
public function windowobject of_getwindowobjectbyname (string as_objname)
public function string of_getclassname ()
public function integer of_setbuttonauthority ()
public function integer of_setmenudata ()
public function integer of_setmessage (string as_message)
end prototypes

event pfe_postopen();// $$HEX5$$70c88cd670c874ac2000$$ENDHEX$$Datawindow $$HEX2$$d0c52000$$ENDHEX$$SetFocus $$HEX6$$98ccacb9200069d5c8b2e4b2$$ENDHEX$$
integer li_cnt
datawindow ldw_cond

for li_cnt = 1 to upperbound(iwo_control)
	if iwo_control[li_cnt].typeof() = datawindow! then
		if iwo_control[li_cnt].triggerevent("pfe_ispowerframecontrol") = 1 then
			if iwo_control[li_cnt].dynamic of_getclassname() = 'pf_u_datawindow' then
				if iwo_control[li_cnt].dynamic of_getservicepropertyvalue('isSearchCondition') = true then
					ldw_cond = iwo_control[li_cnt]
					ldw_cond.setfocus()
					exit
				end if
			end if
		end if
	end if
next

end event

event pfe_shortcutkey(string as_shortcutkey);// $$HEX19$$e8b295cda4d0200085c725b8dcc2200038d69ccd18b494b2200074c7a4bcb8d285c7c8b2e4b2$$ENDHEX$$(from pf_m_empty_shortcutkey)

end event

public subroutine of_getcontrols (graphicobject a_control, ref graphicobject a_controls[]);// $$HEX20$$08c7c4b3b0c658c72000e8ceb8d264b844c7200030bcf4c515d6dcd05cb820006cad69d5c8b2e4b2$$ENDHEX$$. 
// Tab, UserObject $$HEX24$$e8ceb8d264b8fcac2000f8ad200048c5d0c5200004c758ce5cd52000e8ceb8d264b844c72000ecd368d569d5c8b2e4b2$$ENDHEX$$.
// a_controls[] $$HEX23$$94b2200018bcdcb4dcc2200008cd30ae54d61cb42000c1c0dcd05cb8200038d69ccd74d57cc5200069d5c8b2e4b2$$ENDHEX$$. 
// $$HEX6$$74c7200068d518c294b22000$$ENDHEX$$Recursive $$HEX29$$15d6dcd05cb820006cadd9b318b430ae20004cb538bbd0c52000b4b080bd01c83cc75cb8200008cd30ae54d658d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$.

window lw_current
tab ltab_current
userobject luo_current
long ll_previous_elements, ll_total_elements, i

ll_previous_elements = UpperBound(a_controls)
ll_total_elements = ll_previous_elements

choose case a_control.TypeOf()
	case Window!
		lw_current = a_control
		for i = 1 to UpperBound(lw_current.Control)
			choose case lw_current.Control[i].classname()
				case 'pf_u_statictext', 'pf_u_commandbutton_overlay'
				case else
					ll_total_elements++
					a_controls[ll_total_elements] = lw_current.Control[i]
			end choose
		next
	case Tab!
		ltab_current = a_control
		for i = 1 to UpperBound(ltab_current.Control)
			choose case ltab_current.Control[i].classname()
				case 'pf_u_statictext', 'pf_u_commandbutton_overlay'
				case else
					ll_total_elements++
					a_controls[ll_total_elements] = ltab_current.Control[i]
			end choose
		next
	case UserObject!
		luo_current = a_control
		for i = 1 to UpperBound(luo_current.Control)
			choose case luo_current.Control[i].classname()
				case 'pf_u_statictext', 'pf_u_commandbutton_overlay'
				case else
					ll_total_elements++
					a_controls[ll_total_elements] = luo_current.Control[i]
			end choose
		next
	case else
		return
end choose

for i = ll_previous_elements + 1 to ll_total_elements
	choose case a_controls[i].TypeOf()
		case Window!, Tab!, UserObject!
			this.of_getcontrols(a_controls[i], a_controls)
	end choose
next

end subroutine

public function integer of_setresizeservice (boolean ab_switch);integer	li_rc

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid (inv_resize) then
		inv_resize = create pf_n_resize
		inv_resize.of_SetOrigSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
		inv_resize.of_AutoResizeRegister(this)
		li_rc = 1
	end if
else
	if IsValid (inv_resize) then
		destroy inv_resize
		li_rc = 1
	end if
end If

return li_rc

end function

public function windowobject of_getwindowobjectbyname (string as_objname);// $$HEX19$$08c7c4b3b0c600ac2000ecd368d558d5e0ac88c794b22000e8ceb8d264b8200011c9d0c52000$$ENDHEX$$as_objname$$HEX5$$fcac2000d9b37cc75cd5$$ENDHEX$$
// $$HEX19$$85ba6dce44c7200000acc0c994b2200024c60cbe1dc8b8d27cb92000acb934d169d5c8b2e4b2$$ENDHEX$$.

integer i, li_cnter
windowobject lwo_ret

li_cnter = upperbound(iwo_control)
if li_cnter = 0 then
	this.of_getcontrols(this, iwo_control)
	li_cnter = upperbound(iwo_control)
end if

for i = 1 to li_cnter
	if iwo_control[i].classname() = as_objname then
		lwo_ret = iwo_control[i]
		exit
	end if
next

return lwo_ret

end function

public function string of_getclassname ();return 'pf_w_window'

end function

public function integer of_setbuttonauthority ();// $$HEX14$$04d55cb8f8ada8b7200084bcbcd22000acc0a9c620008cad5cd52000$$ENDHEX$$- $$HEX16$$f1b45db81cb42000b4b0a9c6d0c5200030b57cb71cc1200084bcbcd244c72000$$ENDHEX$$Enable/Disable $$HEX6$$98ccacb9200069d5c8b2e4b2$$ENDHEX$$.
if not isvalid(inv_buttonrole) then
	inv_buttonrole = create pf_n_buttonrole
end if

inv_buttonrole.of_registerparent(this)

// $$HEX13$$8cad5cd500adacb960d5200084bcbcd285ba6dce2000f1b45db8$$ENDHEX$$
inv_buttonrole.of_registerbuttonarr('retrieve', { 'cb_retrieve', 'cb_ret', 'cb_inq', 'p_retrieve', 'p_ret', 'p_inq' })
inv_buttonrole.of_registerbuttonarr('insert', { 'cb_insert', 'cb_ins', 'cb_input', 'cb_insertrow', 'cb_add', 'p_insert', 'p_ins', 'p_input', 'p_insertrow', 'p_add' })
inv_buttonrole.of_registerbuttonarr('delete', { 'cb_delete', 'cb_del', 'p_delete', 'p_del' })
inv_buttonrole.of_registerbuttonarr('update', { 'cb_update', 'cb_upd', 'cb_save', 'cb_modify', 'p_update', 'p_upd', 'p_save', 'p_modify' })
inv_buttonrole.of_registerbuttonarr('print', { 'cb_print', 'cb_prt', 'cb_printer', 'p_print', 'p_prt', 'p_printer' })

// $$HEX8$$84bcbcd220008cad5cd5200001c8a9c6$$ENDHEX$$
inv_buttonrole.of_authorize()

return 0

end function

public function integer of_setmenudata ();// $$HEX23$$18b1a8ac1bbc40c7200054ba74b2200070b374c730d100ac200088c73cc774ba2000f8ad00b35cb82000acc0a9c6$$ENDHEX$$
if gnv_session.of_containskey(upper(this.classname())) = true then
	inv_menudata = gnv_session.of_get(upper(this.classname()))
	gnv_session.of_remove(upper(this.classname()))
end if

// $$HEX23$$18b1a8ac1bbc40c7200054ba74b270b374c730d100ac2000c6c594b22000bdacb0c62000c1c911c82000ddc031c1$$ENDHEX$$
// =$$HEX8$$1cac1cbc90c700ac2000c1c911c82000$$ENDHEX$$OpenSheet $$HEX6$$24c608d55cd52000bdacb0c6$$ENDHEX$$
if not isvalid(inv_menudata) then
	pf_n_rolemenu lnv_rolemenu
	lnv_rolemenu = create pf_n_rolemenu
	inv_menudata = create pf_n_menudata
	
	if lnv_rolemenu.of_getmenudata_by_pgmid(upper(this.classname()), inv_menudata) = 0 then
		inv_menudata.is_pgm_id = this.classname()
		inv_menudata.is_menu_id = inv_menudata.is_pgm_id
		inv_menudata.is_pgm_name = this.title
	end if
end if

return 0

end function

public function integer of_setmessage (string as_message);// MDI $$HEX4$$08c7c4b3b0c62000$$ENDHEX$$Status Bar $$HEX8$$d0c5200054badcc2c0c920005cd4dcc2$$ENDHEX$$

if isvalid(iw_parent) then
	inv_param.of_clear()
	inv_param.of_put('message', as_message)
	iw_parent.dynamic of_eventdispatcher('pf_u_mdi_statusbar', 'pfe_setmessage', inv_param)
end if

return 0

end function

on pf_w_window.create
this.ln_templeft=create ln_templeft
this.ln_tempright=create ln_tempright
this.ln_temptop=create ln_temptop
this.ln_tempbuttom=create ln_tempbuttom
this.ln_tempbutton=create ln_tempbutton
this.ln_tempstart=create ln_tempstart
this.Control[]={this.ln_templeft,&
this.ln_tempright,&
this.ln_temptop,&
this.ln_tempbuttom,&
this.ln_tempbutton,&
this.ln_tempstart}
end on

on pf_w_window.destroy
destroy(this.ln_templeft)
destroy(this.ln_tempright)
destroy(this.ln_temptop)
destroy(this.ln_tempbuttom)
destroy(this.ln_tempbutton)
destroy(this.ln_tempstart)
end on

event open;// $$HEX13$$a8bae0b4200008c7c4b3b0c62000e8ceb8d264b82000f4bc00ad$$ENDHEX$$
this.of_getcontrols(this, iwo_control[])

// $$HEX12$$acb9acc074c788c920001cc144bea4c220005cd631c154d6$$ENDHEX$$
this.of_setresizeservice(true)

// $$HEX10$$80bda8ba200008c7c4b3b0c620006cad58d530ae$$ENDHEX$$
iw_parent = this.parentwindow()

// $$HEX10$$54ba74b2200015c8f4bc200024c115c858d530ae$$ENDHEX$$
this.of_setmenudata()

// $$HEX10$$08c7c4b3b0c62000c0d074c7c0d2200024c115c8$$ENDHEX$$
if inv_menudata.is_pgm_name <> this.title then
	this.title = inv_menudata.is_pgm_name
end if

// $$HEX16$$08c7c4b3b0c62000c0d085c7d0c5200030b578b9200094cd00ac200091c7c5c5$$ENDHEX$$
choose case this.windowtype
	case main!
		// SHEET $$HEX12$$08c7c4b3b0c6200030aef8bc20008dc131c1200055d678c7$$ENDHEX$$
		if this.controlmenu <> false then this.controlmenu = false
		if this.maxbox <> true then this.maxbox = true
		if this.minbox <> true then this.minbox = true
		if this.windowstate <> maximized! then this.windowstate = maximized!
		
		// MDI $$HEX14$$08c7c4b3b0c62000e8ceb8d264b8200074c7a4bcb8d2200038d69ccd$$ENDHEX$$
		inv_param = create pf_n_hashtable
		inv_param.of_put('menu_id', inv_menudata.is_menu_id)
		inv_param.of_put('pgm_id', inv_menudata.is_pgm_id)
		inv_param.of_put('pgm_name', inv_menudata.is_pgm_name)
		inv_param.of_put('sheet_ref', this)
		
		// sheet_tab_bar $$HEX6$$e8ceb8d264b8200024c115c8$$ENDHEX$$
		il_tab_seq = iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheettab', 'pfe_addsheettab', inv_param)
		
		// tool_bar $$HEX6$$e8ceb8d264b8200024c115c8$$ENDHEX$$
		il_tool_seq = iw_parent.dynamic of_eventdispatcher('pf_u_mdi_toolbar', 'pfe_addsheet', inv_param)
		
		// sheet_navi_bar $$HEX6$$e8ceb8d264b8200024c115c8$$ENDHEX$$
		il_sheet_seq = iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheetnavi', 'pfe_setwindowname', inv_param)
end choose

// $$HEX3$$84bcbcd22000$$ENDHEX$$Enable/Disable $$HEX2$$98ccacb9$$ENDHEX$$
this.of_setbuttonauthority()

// pfe_PostEvent $$HEX2$$38d69ccd$$ENDHEX$$
This.Post Event pfe_postopen()

end event

event activate;// CurrentDirectory $$HEX7$$c0bcbdacecc580bd200055d678c7$$ENDHEX$$, $$HEX12$$14b5f4d3b8d22000f4d354b35cb82000d0c6f5bc98ccacb9$$ENDHEX$$
if appeongetclienttype() = 'PB' then
	if getcurrentdirectory() <> gnv_appmgr.is_currentdir then
		changedirectory(gnv_appmgr.is_currentdir)
	end if
end if

// $$HEX16$$08c7c4b3b0c62000c0d085c7d0c5200030b578b9200094cd00ac200091c7c5c5$$ENDHEX$$
choose case this.windowtype
	case main!
		if isvalid(iw_parent) then
			if il_tab_seq > 0 then
				// sheettab $$HEX3$$e8ceb8d264b8$$ENDHEX$$
				inv_param.of_clear()
				inv_param.of_put('tab_seq', il_tab_seq)
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheettab', 'pfe_selectsheettab', inv_param)
				
				// toolbar $$HEX3$$e8ceb8d264b8$$ENDHEX$$
				inv_param.of_clear()
				inv_param.of_put('tool_seq', il_tool_seq)
				inv_param.of_put('button_role', inv_buttonrole)
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_toolbar', 'pfe_selectsheet', inv_param)
				
				// sheetnavi $$HEX3$$e8ceb8d264b8$$ENDHEX$$
				inv_param.of_clear()
				inv_param.of_put('sheet_seq', il_sheet_seq)
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheetnavi', 'pfe_selectsheet', inv_param)
				
				// statusbar $$HEX3$$e8ceb8d264b8$$ENDHEX$$
				inv_param.of_clear()
				inv_param.of_put('window_id', this.classname())
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_statusbar', 'pfe_setwindowname', inv_param)
			end if
		end if
end choose

end event

event resize;// Width, Height $$HEX27$$08c7c4b3b0c62000acc074c788c900ac2000c0bcbdac1cb42000bdacb0c62000acb9acc074c788c920001cc144bea4c2200018c289d5$$ENDHEX$$
If ii_width <> newwidth Or ii_height <> newheight Then
	If IsValid (inv_resize) Then
		inv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
		ii_width = newwidth
		ii_height = newheight
	End If
End If

end event

event deactivate;choose case this.windowtype
	case main!
		if isvalid(iw_parent) then
			if il_tab_seq > 0 then
				// sheettab $$HEX3$$e8ceb8d264b8$$ENDHEX$$
				inv_param.of_clear()
				inv_param.of_put('tab_seq', il_tab_seq)
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheettab', 'pfe_deselectsheettab', inv_param)
				
				// toolbar $$HEX3$$e8ceb8d264b8$$ENDHEX$$
				inv_param.of_clear()
				inv_param.of_put('tool_seq', il_tool_seq)
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_toolbar', 'pfe_deselectsheet', inv_param)
				
				// sheetnavi $$HEX3$$e8ceb8d264b8$$ENDHEX$$
				inv_param.of_clear()
				inv_param.of_put('sheet_seq', il_sheet_seq)
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheetnavi', 'pfe_deselectsheet', inv_param)
				
				// statusbar $$HEX3$$e8ceb8d264b8$$ENDHEX$$
				inv_param.of_clear()
				inv_param.of_put('window_id', '')
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_statusbar', 'pfe_setwindowname', inv_param)
			end if
		end if
end choose

end event

event close;if isvalid(iw_parent) then
	if this.windowtype = main! then
		if il_tab_seq > 0 then
			// sheettab $$HEX3$$e8ceb8d264b8$$ENDHEX$$
			inv_param.of_clear()
			inv_param.of_put('tab_seq', il_tab_seq)
			iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheettab', 'pfe_closesheettab', inv_param)
			
			// toolbar $$HEX3$$e8ceb8d264b8$$ENDHEX$$
			inv_param.of_clear()
			inv_param.of_put('tool_seq', il_tool_seq)
			iw_parent.dynamic of_eventdispatcher('pf_u_mdi_toolbar', 'pfe_closesheet', inv_param)

			// sheetnavi $$HEX3$$e8ceb8d264b8$$ENDHEX$$
			inv_param.of_clear()
			inv_param.of_put('sheet_seq', il_sheet_seq)
			iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheetnavi', 'pfe_closesheet', inv_param)

			// Clear Message
			of_setmessage('')
		end if
		
		// appeon $$HEX7$$58d6bdac78c72000bdacb0c62000$$ENDHEX$$sheet $$HEX5$$85c8ccb82000c4d62000$$ENDHEX$$mdi_1.border$$HEX5$$00ac2000f5bcd0c628b4$$ENDHEX$$
		if appeongetclienttype() = 'WEB' then
			iw_parent.post dynamic of_setmdiclientborder(3)
		end if
		
		// $$HEX4$$08c7c4b3b0c62000$$ENDHEX$$Open$$HEX2$$dcc22000$$ENDHEX$$Close(This) $$HEX9$$85ba39b874c7200018c289d518b474ba2000$$ENDHEX$$WindowState$$HEX2$$00ac2000$$ENDHEX$$Maximized -> Normal $$HEX7$$c1c0dcd05cb82000c0bcbdac28b4$$ENDHEX$$
		iw_parent.dynamic post of_checkactivesheetstate()
	end if
end if			

end event

type ln_templeft from line within pf_w_window
boolean visible = false
long linecolor = 134217857
integer linethickness = 2
integer beginx = 46
integer beginy = 24
integer endx = 46
integer endy = 2272
end type

type ln_tempright from line within pf_w_window
boolean visible = false
long linecolor = 134217857
integer linethickness = 2
integer beginx = 4549
integer beginy = 24
integer endx = 4549
integer endy = 2272
end type

type ln_temptop from line within pf_w_window
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 36
integer endx = 4590
integer endy = 36
end type

type ln_tempbuttom from line within pf_w_window
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 2220
integer endx = 4590
integer endy = 2220
end type

type ln_tempbutton from line within pf_w_window
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 120
integer endx = 4590
integer endy = 120
end type

type ln_tempstart from line within pf_w_window
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 160
integer endx = 4590
integer endy = 160
end type

