HA$PBExportHeader$pf_w_pgm_mst_ent.srw
$PBExportComments$$$HEX24$$04d55cb8f8ada8b7200030aef8bc15c8f4bc7cb9200000adacb958d594b2200004d55cb8f8ada8b7200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_pgm_mst_ent from pf_w_sheet
end type
type p_close from pf_u_imagebutton within pf_w_pgm_mst_ent
end type
type tv_fullmenu from pf_u_treeview within pf_w_pgm_mst_ent
end type
type p_2 from picture within pf_w_pgm_mst_ent
end type
type st_2 from pf_u_statictext within pf_w_pgm_mst_ent
end type
type p_1 from picture within pf_w_pgm_mst_ent
end type
type st_1 from pf_u_statictext within pf_w_pgm_mst_ent
end type
type p_update from pf_u_imagebutton within pf_w_pgm_mst_ent
end type
type p_delete from pf_u_imagebutton within pf_w_pgm_mst_ent
end type
type p_add from pf_u_imagebutton within pf_w_pgm_mst_ent
end type
type dw_pgm from pf_u_datawindow within pf_w_pgm_mst_ent
end type
type cb_1 from pf_u_commandbutton within pf_w_pgm_mst_ent
end type
type cbx_expand from pf_u_checkbox within pf_w_pgm_mst_ent
end type
end forward

global type pf_w_pgm_mst_ent from pf_w_sheet
string title = "$$HEX9$$04d55cb8f8ada8b7200015c8f4bc00adacb9$$ENDHEX$$"
event ue_menu_notify ( string as_menu_name )
p_close p_close
tv_fullmenu tv_fullmenu
p_2 p_2
st_2 st_2
p_1 p_1
st_1 st_1
p_update p_update
p_delete p_delete
p_add p_add
dw_pgm dw_pgm
cb_1 cb_1
cbx_expand cbx_expand
end type
global pf_w_pgm_mst_ent pf_w_pgm_mst_ent

type variables
datastore ids_fullmenu
pf_m_pgm_mst im_pgm_mst
long il_parent, il_handle
treeviewitem itvi_item, itvi_parent
boolean ib_redraw = false

long il_DragSource, il_DragParent, il_DropTarget
treeviewitem itvi_Source

end variables

forward prototypes
public function integer of_set_pgm_fullmenu ()
public subroutine of_treeviewitem_move (long al_curr_handle, string as_direction)
public function integer of_expand_treeviewitem (long al_handle)
public function integer of_collapse_treeviewitem (long al_handle)
end prototypes

event ue_menu_notify(string as_menu_name);choose case as_menu_name
	case 'm_add'
		p_add.post event clicked()
	case 'm_delete'
		p_delete.post event clicked()
	case 'm_upper'
		of_treeviewitem_move(il_handle, 'upper')
	case 'm_lower'
		of_treeviewitem_move(il_handle, 'lower')
//	case 'm_left'
//		of_treeviewitem_move(il_handle, 'left')
//	case 'm_right'
//		of_treeviewitem_move(il_handle, 'right')
	case 'm_expand'
		of_expand_treeviewitem(il_handle)
	case 'm_collapse'
		of_collapse_treeviewitem(il_handle)
end choose

return

end event

public function integer of_set_pgm_fullmenu ();long ll_rowcnt, ll_handle, i, ll_roothndl
treeviewitem ltvi_item

tv_fullmenu.setredraw(false)
tv_fullmenu.post setredraw(true)

ll_handle = tv_fullmenu.finditem(roottreeitem!, 0)
do while ll_handle > 0
	tv_fullmenu.deleteitem(ll_handle)
	ll_handle = tv_fullmenu.finditem(roottreeitem!, ll_handle)
loop

ll_rowcnt = ids_fullmenu.retrieve(gnv_session.is_sys_id, 'ROOT')

for i = 1 to ll_rowcnt
	ltvi_item.data = ids_fullmenu.getitemstring(i, 'menu_id')
	ltvi_item.label = ids_fullmenu.getitemstring(i, 'pgm_name')
	
	ltvi_item.PictureIndex = 3
	ltvi_item.SelectedPictureIndex = 4
	
	if ids_fullmenu.getitemnumber(i, 'child_cnt') > 0 then
		ltvi_item.Children = true
	else
		ltvi_item.Children = false
	end if
	
	ll_handle = tv_fullmenu.InsertItemLast(0, ltvi_item)
next

// expand top level items only
ll_handle = tv_fullmenu.finditem(roottreeitem!, 0)
ll_roothndl = ll_handle
do while ll_handle > 0
	if cbx_expand.checked = true then
		tv_fullmenu.expandall(ll_handle)
	else
		tv_fullmenu.expanditem(ll_handle)
	end if
	ll_handle = tv_fullmenu.finditem(NextTreeItem!, ll_handle)
loop

// scroll back to top
tv_fullmenu.SetFirstVisible(ll_roothndl)

// select first treeviewitem
tv_fullmenu.post selectitem(ll_roothndl)

return ll_rowcnt

end function

public subroutine of_treeviewitem_move (long al_curr_handle, string as_direction);long ll_prev_handle
long ll_next_handle
long ll_new_handle
long ll_parent_handle

tv_fullmenu.setredraw(false)
tv_fullmenu.post setredraw(true)

treeviewitem ltvi_curr_item
treeviewitem ltvi_parent_item

if tv_fullmenu.getitem(al_curr_handle, ltvi_curr_item) = -1 then return
if ltvi_curr_item.PictureIndex > 2 then
	ltvi_curr_item.expanded = false
//	ltvi_curr_item.expandedonce = false
//	ltvi_curr_item.children = true
end if

choose case as_direction
//	case 'left'
//		ll_parent_handle = tv_fullmenu.finditem(ParentTreeItem!, al_curr_handle)
//		if ll_parent_handle = -1 then return
//		
//		tv_fullmenu.getitem(ll_parent_handle, ltvi_parent_item)
//		if ltvi_parent_item.level = 1 then return
//		
//		ll_prev_handle = tv_fullmenu.finditem(PreviousTreeItem!, ll_parent_handle)
//		if ll_prev_handle = -1 then
//			ll_parent_handle = tv_fullmenu.finditem(ParentTreeItem!, ll_parent_handle)
//			ll_new_handle = tv_fullmenu.insertitemfirst(ll_parent_handle, ltvi_curr_item)
//		else
//			ll_parent_handle = tv_fullmenu.finditem(ParentTreeItem!, ll_prev_handle)
//			ll_new_handle = tv_fullmenu.insertitem(ll_parent_handle, ll_prev_handle, ltvi_curr_item)
//		end if
//		
//		tv_fullmenu.deleteitem(al_curr_handle)
//		tv_fullmenu.post selectitem(ll_new_handle)
		
	case 'upper'
		ll_prev_handle = tv_fullmenu.finditem(PreviousTreeItem!, al_curr_handle)
		if ll_prev_handle = -1 then return
		
		ll_prev_handle = tv_fullmenu.finditem(PreviousTreeItem!, ll_prev_handle)
		if ll_prev_handle = -1 then
			ll_parent_handle = tv_fullmenu.finditem(ParentTreeItem!, al_curr_handle)
			ll_new_handle = tv_fullmenu.insertitemfirst(ll_parent_handle, ltvi_curr_item)
		else
			ll_parent_handle = tv_fullmenu.finditem(ParentTreeItem!, ll_prev_handle)
			ll_new_handle = tv_fullmenu.insertitem(ll_parent_handle, ll_prev_handle, ltvi_curr_item)
		end if
		
		// $$HEX13$$f4d354b374ba200058d504c7200044c574c75cd1200074c7d9b3$$ENDHEX$$
		if ltvi_curr_item.PictureIndex > 2 then
			tv_fullmenu.of_movechildren(al_curr_handle, ll_new_handle)
		end if
		
		tv_fullmenu.deleteitem(al_curr_handle)
		tv_fullmenu.post selectitem(ll_new_handle)
		
	case 'lower'
		ll_next_handle = tv_fullmenu.finditem(NextTreeItem!, al_curr_handle)
		if ll_next_handle = -1 then return
		
		ll_parent_handle = tv_fullmenu.finditem(ParentTreeItem!, ll_next_handle)
		ll_new_handle = tv_fullmenu.insertitem(ll_parent_handle, ll_next_handle, ltvi_curr_item)
		
		// $$HEX13$$f4d354b374ba200058d504c7200044c574c75cd1200074c7d9b3$$ENDHEX$$
		if ltvi_curr_item.PictureIndex > 2 then
			tv_fullmenu.of_movechildren(al_curr_handle, ll_new_handle)
		end if

		tv_fullmenu.deleteitem(al_curr_handle)
		tv_fullmenu.post selectitem(ll_new_handle)
		
//	case 'right'
//		ll_next_handle = tv_fullmenu.finditem(NextTreeItem!, al_curr_handle)
//		do while ll_next_handle > 0
//			tv_fullmenu.getitem(ll_next_handle, ltvi_next_item)
//			if ltvi_next_item.pictureindex = 3 then
//				ll_new_handle = tv_fullmenu.insertitemfirst(ll_next_handle, ltvi_curr_item)
//				tv_fullmenu.deleteitem(al_curr_handle)
//				tv_fullmenu.post selectitem(ll_new_handle)
//				exit
//			end if
//			ll_next_handle = tv_fullmenu.finditem(NextTreeItem!, ll_next_handle)
//		loop
end choose

//if ltvi_curr_item.PictureIndex = 3 then
//	tv_fullmenu.expanditem(ll_new_handle)
//end if

// pf_pgm_mst $$HEX4$$4cd174c714be2000$$ENDHEX$$parent_menu $$HEX2$$18c215c8$$ENDHEX$$
string ls_menu_id
string ls_parent_menu

ll_parent_handle = tv_fullmenu.finditem(ParentTreeItem!, ll_new_handle)
tv_fullmenu.getitem(ll_parent_handle, ltvi_parent_item)

ls_menu_id = string(ltvi_curr_item.data)
ls_parent_menu = string(ltvi_parent_item.data)

update	pf_pgm_mst
set			parent_menu = :ls_parent_menu,
			tree_level = :ltvi_parent_item.level + 1
where	sys_id = :gnv_session.is_sys_id
and		menu_id = :ls_menu_id
using		sqlca;

//if sqlca.sqlcode = 0 then
//	commit using sqlca;
//else
//	ls_errtext = sqlca.sqlerrtext
//	rollback using sqlca;
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX13$$04d55cb8f8ada8b7200015c8f4bc200000c8a5c7200024c658b9$$ENDHEX$$!!~r~n' + sqlca.sqlerrtext)
//	return
//end if

// pf_pgm_mst $$HEX4$$4cd174c714be2000$$ENDHEX$$sort_order $$HEX2$$18c215c8$$ENDHEX$$
long ll_child_handle
long ll_sort_order
treeviewitem ltvi_child_item

ll_child_handle = tv_fullmenu.finditem(ChildTreeItem!, ll_parent_handle)
do while ll_child_handle > 0
	tv_fullmenu.getitem(ll_child_handle, ltvi_child_item)
	ls_menu_id = string(ltvi_child_item.data)
	ll_sort_order ++
	
	update	pf_pgm_mst
	set			sort_order = :ll_sort_order
	where	sys_id = :gnv_session.is_sys_id
	and		menu_id = :ls_menu_id
	using		sqlca;
	
//	if sqlca.sqlcode = 0 then
//		commit using sqlca;
//	else
//		ls_errtext = sqlca.sqlerrtext
//		rollback using sqlca;
//		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX13$$04d55cb8f8ada8b7200015c8f4bc200000c8a5c7200024c658b9$$ENDHEX$$(Sort_Order)!!~r~n' + sqlca.sqlerrtext)
//		return
//	end if
	
	ll_child_handle = tv_fullmenu.finditem(NextTreeItem!, ll_child_handle)
loop

commit using sqlca;
return

end subroutine

public function integer of_expand_treeviewitem (long al_handle);// Expand TreeViewItem
long ll_rc

ll_rc = tv_fullmenu.ExpandAll(al_handle)
tv_fullmenu.SetFirstVisible(al_handle)

return ll_rc

end function

public function integer of_collapse_treeviewitem (long al_handle);return tv_fullmenu.CollapseItem(al_handle)

end function

on pf_w_pgm_mst_ent.create
int iCurrent
call super::create
this.p_close=create p_close
this.tv_fullmenu=create tv_fullmenu
this.p_2=create p_2
this.st_2=create st_2
this.p_1=create p_1
this.st_1=create st_1
this.p_update=create p_update
this.p_delete=create p_delete
this.p_add=create p_add
this.dw_pgm=create dw_pgm
this.cb_1=create cb_1
this.cbx_expand=create cbx_expand
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_close
this.Control[iCurrent+2]=this.tv_fullmenu
this.Control[iCurrent+3]=this.p_2
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.p_update
this.Control[iCurrent+8]=this.p_delete
this.Control[iCurrent+9]=this.p_add
this.Control[iCurrent+10]=this.dw_pgm
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.cbx_expand
end on

on pf_w_pgm_mst_ent.destroy
call super::destroy
destroy(this.p_close)
destroy(this.tv_fullmenu)
destroy(this.p_2)
destroy(this.st_2)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.p_update)
destroy(this.p_delete)
destroy(this.p_add)
destroy(this.dw_pgm)
destroy(this.cb_1)
destroy(this.cbx_expand)
end on

event open;call super::open;ids_fullmenu = create datastore
ids_fullmenu.dataobject = 'pf_d_pgm_mst_01'
ids_fullmenu.settransobject(sqlca)

im_pgm_mst = create pf_m_pgm_mst

dw_pgm.settransobject(sqlca)

end event

event pfe_postopen;call super::pfe_postopen;post of_set_pgm_fullmenu()

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_pgm_mst_ent
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_pgm_mst_ent
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_pgm_mst_ent
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_pgm_mst_ent
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_pgm_mst_ent
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_pgm_mst_ent
end type

type p_close from pf_u_imagebutton within pf_w_pgm_mst_ent
integer x = 4315
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)

end event

type tv_fullmenu from pf_u_treeview within pf_w_pgm_mst_ent
integer x = 50
integer y = 232
integer width = 1413
integer height = 1988
integer taborder = 10
boolean dragauto = true
boolean bringtotop = true
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 20132659
boolean disabledragdrop = false
string picturename[] = {"Application5!","ApplicationIcon!","Custom039!","Open!","Close!","CrossTab!"}
long picturemaskcolor = 12632256
boolean scaletobottom = true
end type

event itemexpanding;treeviewitem ltvi_item
string ls_menu_id
long ll_rowcnt, ll_child, i

this.getitem(handle, ltvi_item)
if ltvi_item.ExpandedOnce and not ib_redraw then return 0
if this.finditem(ChildTreeItem!, handle) > 0 then return 0

ls_menu_id = ltvi_item.data
ll_rowcnt = ids_fullmenu.retrieve(gnv_session.is_sys_id, ls_menu_id)

for i = 1 to ll_rowcnt
	ltvi_item.data = ids_fullmenu.getitemstring(i, 'menu_id')
	ltvi_item.label = ids_fullmenu.getitemstring(i, 'pgm_name')
	
	choose case ids_fullmenu.getitemstring(i, 'pgm_kind_code')
		case 'M'
			ltvi_item.PictureIndex = 3
			ltvi_item.SelectedPictureIndex = 4
		case 'P'
			if ids_fullmenu.getitemstring(i, 'pgm_use_yn') = 'N' then
				ltvi_item.PictureIndex = 5
				ltvi_item.SelectedPictureIndex = 5
			elseif 	ids_fullmenu.getitemstring(i, 'menu_use_yn') = 'N' then
				ltvi_item.PictureIndex = 6
				ltvi_item.SelectedPictureIndex = 6
			else
				ltvi_item.PictureIndex = 1
				ltvi_item.SelectedPictureIndex = 2
			end if				
	end choose
	
	if ids_fullmenu.getitemnumber(i, 'child_cnt') > 0 then
		ltvi_item.Children = true
	else
		ltvi_item.Children = false
	end if
	
	ltvi_item.HasFocus = false
	ltvi_item.selected = false
	
	ll_child = this.InsertItemLast(handle, ltvi_item)
next

ib_redraw = false
return 0

end event

event rightclicked;treeviewitem ltvi_item

if this.selectitem(handle) = -1 then return
if this.getitem(handle, ltvi_item) = -1 then return

choose case ltvi_item.PictureIndex
	case 3, 4
		im_pgm_mst.m_add.enabled = true
	case 1, 2
		im_pgm_mst.m_add.enabled = false
end choose

im_pgm_mst.popmenu(iw_parent.pointerx(), iw_parent.pointery())

end event

event selectionchanged;string ls_menu_id

il_handle = newhandle
this.getitem(il_handle, itvi_item)

choose case itvi_item.PictureIndex
	case 3, 4
		il_parent = il_handle
		itvi_parent = itvi_item
	case else
		il_parent = this.finditem(ParentTreeItem!, il_handle)
		this.getitem(il_parent, itvi_parent)
end choose

ls_menu_id = itvi_item.data
if dw_pgm.retrieve(gnv_session.is_sys_id, ls_menu_id) > 0 then
	string ls_platform
	ls_platform = dw_pgm.getitemstring(1, 'platform_type')
	dw_pgm.setitem(1, 'platform_type1', mid(ls_platform, 1, 1))
	dw_pgm.setitem(1, 'platform_type2', mid(ls_platform, 2, 1))
	dw_pgm.setitem(1, 'platform_type3', mid(ls_platform, 3, 1))
	dw_pgm.setitemstatus(1, 0, primary!, notmodified!)
end if

return 0

end event

event key;if keyflags = 2 then
	choose case key
		case KeyUpArrow!
			of_treeviewitem_move(il_handle, 'upper')
		case KeyDownArrow!
			of_treeviewitem_move(il_handle, 'lower')
//		case KeyLeftArrow!
//			of_treeviewitem_move(il_handle, 'left')
//		case KeyRightArrow!
//			of_treeviewitem_move(il_handle, 'right')
	end choose
end if

choose case key
	case KeyDelete!
		p_delete.post event clicked()
	case KeyInsert!
		p_add.post event clicked()
end choose

return 1

end event

event begindrag;call super::begindrag;// $$HEX25$$dcb498b7f8ad20b4200044c574c75cd1fcac2000f8ad200080bda8ba44c574c75cd144c72000f4bc00ad200069d5c8b2e4b2$$ENDHEX$$
il_DragSource = handle
this.getitem(il_DragSource, itvi_Source)
il_DragParent = FindItem(ParentTreeItem!, handle)

end event

event dragdrop;call super::dragdrop;long ll_newitem
TreeViewItem ltvi_Source, ltvi_Target, ltvi_Parent, ltvi_NewItem

//this.setredraw(false)
//this.post setredraw(true)

if this.getitem(il_DragSource, ltvi_Source) = -1 then return
if this.getitem(il_DropTarget, ltvi_Target) = -1 then return

// $$HEX12$$54ba74b22000c0bcbdac2000acc0a9c690c7200055d678c7$$ENDHEX$$
if this.getitem(il_DragParent, ltvi_Parent) = -1 then
	ltvi_Parent.Label = 'ROOT'
end if

if messagebox('$$HEX5$$54ba74b22000c0bcbdac$$ENDHEX$$', ltvi_Parent.Label + '$$HEX2$$58c72000$$ENDHEX$$[' + ltvi_Source.Label + '] $$HEX4$$54ba74b27cb92000$$ENDHEX$$' + ltvi_Target.Label + ' $$HEX12$$58d504c75cb8200074c7d9b358d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 2 then
	SetDropHighlight(0)
	il_DropTarget = 0
	return
end if

// $$HEX7$$c0d09fac54ba74b22000bcd368ce$$ENDHEX$$
if ltvi_Target.expanded = false then
	this.expanditem(il_DropTarget)
end if

// $$HEX8$$e0c2dcad200054ba74b22000ddc031c1$$ENDHEX$$
SetNull(ltvi_Source.ItemHandle)
ll_newitem = this.InsertItemFirst(il_DropTarget, ltvi_source)
this.getitem(ll_newitem, ltvi_newitem)

// $$HEX8$$58d504c7200054ba74b2200074c7d9b3$$ENDHEX$$
this.of_movechildren(il_DragSource, ll_NewItem)

// $$HEX8$$30ae74c8200054ba74b22000adc01cc8$$ENDHEX$$
this.deleteitem(il_DragSource)

// $$HEX8$$58d574c77cb774c7b8d22000e8cd8cc1$$ENDHEX$$
this.SetDropHighlight(0)

// pf_pgm_mst $$HEX4$$4cd174c714be2000$$ENDHEX$$parent_menu $$HEX2$$18c215c8$$ENDHEX$$
string ls_menu_id
string ls_parent_menu

ls_menu_id = string(ltvi_Source.data)
ls_parent_menu = string(ltvi_Target.data)

update	pf_pgm_mst
set			parent_menu = :ls_parent_menu,
			tree_level = :ltvi_Target.level + 1
where	sys_id = :gnv_session.is_sys_id
and		menu_id = :ls_menu_id
using		sqlca;

// $$HEX7$$58d504c7200044c574c75cd12000$$ENDHEX$$treelevel $$HEX2$$18c215c8$$ENDHEX$$
long ll_nextitem
treeviewitem ltvi_next

if ltvi_newitem.level <> ltvi_source.level then
	if ltvi_newitem.pictureindex > 2 then
		this.expandall(ll_newitem)
		
		ll_nextitem = this.finditem(nextvisibletreeitem!, ll_newitem)
		do while ll_nextitem > 0
			this.getitem(ll_nextitem, ltvi_next)
			if ltvi_next.level <= ltvi_newitem.level then exit
			
			ls_menu_id = string(ltvi_next.data)
			
			update	pf_pgm_mst
			set			tree_level = :ltvi_next.level
			where	sys_id = :gnv_session.is_sys_id
			and		menu_id = :ls_menu_id
			using		sqlca;
			
			ll_nextitem = this.finditem(nextvisibletreeitem!, ll_nextitem)
		loop
	end if
end if

// pf_pgm_mst $$HEX4$$4cd174c714be2000$$ENDHEX$$sort_order $$HEX2$$18c215c8$$ENDHEX$$
long ll_child, ll_sort_order
treeviewitem ltvi_child

ll_child = this.finditem(ChildTreeItem!, il_DropTarget)
do while ll_child > 0
	this.getitem(ll_child, ltvi_child)
	ls_menu_id = string(ltvi_child.data)
	ll_sort_order ++
	
	update	pf_pgm_mst
	set			sort_order = :ll_sort_order
	where	sys_id = :gnv_session.is_sys_id
	and		menu_id = :ls_menu_id
	using		sqlca;
	
	ll_child = this.finditem(NextTreeItem!, ll_child)
loop

commit using sqlca;

// $$HEX9$$2ec6a8acc4c9200054ba74b2200020c1ddd0$$ENDHEX$$
this.SelectItem(ll_NewItem)

end event

event dragwithin;call super::dragwithin;long ll_Parent
TreeViewItem ltvi_Over

// $$HEX13$$80bda8ba200078b1dcb494b2200020c1ddd0200048c5200068d5$$ENDHEX$$
if handle = il_DragParent then return

If GetItem(handle, ltvi_Over) = -1 Then
	SetDropHighlight(0)
	il_DropTarget = 0
	Return
End If

// $$HEX13$$c0d09fac40c72000f4d354b3ccb9200020c1ddd0200000aca5b2$$ENDHEX$$
if ltvi_Over.PictureIndex < 3 then
	SetDropHighlight(0)
	il_DropTarget = 0
	return
end if

// $$HEX10$$c0d09facfcac20008cc1a4c200ac2000d9b37cc7$$ENDHEX$$
if il_DragSource = handle then 
	SetDropHighlight(0)
	il_DropTarget = 0
	return
end if

// $$HEX20$$f4d354b394b2200090c7e0c258c7200058d504c7200078b1dcb45cb8200074c7d9b3200088bd00ac$$ENDHEX$$
if itvi_Source.PictureIndex > 2 then
	ll_Parent = FindItem(ParentTreeItem!, handle)
	do while ll_Parent > 0
		if ll_Parent = il_DragSource then
			SetDropHighlight(0)
			il_DropTarget = 0
			return
		end if
		ll_Parent = FindItem(ParentTreeItem!, ll_Parent)
	loop
end if

// MouseOver $$HEX8$$58d574c77cb774c7b8d2200098ccacb9$$ENDHEX$$
il_DropTarget = handle
SetDropHighlight(il_DropTarget)
return

end event

type p_2 from picture within pf_w_pgm_mst_ent
integer x = 50
integer y = 172
integer width = 46
integer height = 40
boolean bringtotop = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type st_2 from pf_u_statictext within pf_w_pgm_mst_ent
integer x = 123
integer y = 168
integer width = 553
integer height = 48
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = hangeul!
string facename = "$$HEX2$$cbb3c0c6$$ENDHEX$$"
long textcolor = 25123896
long backcolor = 16777215
string text = "$$HEX10$$04c8b4cc200004d55cb8f8ada8b7200054ba74b2$$ENDHEX$$"
end type

type p_1 from picture within pf_w_pgm_mst_ent
integer x = 1495
integer y = 172
integer width = 46
integer height = 40
boolean bringtotop = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type st_1 from pf_u_statictext within pf_w_pgm_mst_ent
integer x = 1568
integer y = 168
integer width = 553
integer height = 48
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = hangeul!
string facename = "$$HEX2$$cbb3c0c6$$ENDHEX$$"
long textcolor = 25123896
long backcolor = 16777215
string text = "$$HEX8$$04d55cb8f8ada8b720002000c1c038c1$$ENDHEX$$"
end type

type p_update from pf_u_imagebutton within pf_w_pgm_mst_ent
integer x = 4069
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX2$$00c8a5c7$$ENDHEX$$
if dw_pgm.accepttext() = -1 then return
if dw_pgm.rowcount() = 0 then return

// $$HEX6$$44d518c285c725b8acc06dd5$$ENDHEX$$
string ls_pgm_kind_code
string ls_pgm_id

ls_pgm_kind_code = dw_pgm.getitemstring(1, 'pgm_kind_code')
if isnull(ls_pgm_kind_code) or len(trim(ls_pgm_kind_code)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX2$$f4d354b3$$ENDHEX$$/$$HEX14$$04d55cb8f8ada8b720006cad84bd44c7200085c725b858d538c194c6$$ENDHEX$$')
	return 0
end if

if ls_pgm_kind_code = 'P' then
	ls_pgm_id = dw_pgm.getitemstring(1, 'pgm_id')
	if isnull(ls_pgm_id) or len(trim(ls_pgm_id)) = 0 then
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX4$$04d55cb8f8ada8b7$$ENDHEX$$ID $$HEX7$$7cb9200085c725b858d538c194c6$$ENDHEX$$')
		return 0
	end if
end if

string ls_pgm_name
ls_pgm_name = dw_pgm.getitemstring(1, 'pgm_name')
if isnull(ls_pgm_name) or len(trim(ls_pgm_name)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX14$$04d55cb8f8ada8b7200085ba6dce44c7200085c725b858d538c194c6$$ENDHEX$$')
	return 0
end if

string ls_parent_menu
ls_parent_menu = dw_pgm.getitemstring(1, 'parent_menu')
if isnull(ls_parent_menu) or len(trim(ls_parent_menu)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX15$$3cba00c82000c1c004c754ba74b27cb9200020c1ddd0200058d538c194c6$$ENDHEX$$')
	return 0
end if

// Primary Key $$HEX2$$ddc031c1$$ENDHEX$$
string ls_menu_id, ls_io_type
treeviewitem ltvi_item
long ll_newhandle, ll_role_cnt
string ls_comm_btn_auth_yn = 'N'
string ls_retrieve_auth_yn, ls_input_auth_yn, ls_delete_auth_yn, ls_update_auth_yn
string ls_print_auth_yn, ls_execute_auth_yn, ls_cancel_auth_yn, ls_excel_auth_yn

if dw_pgm.getitemstatus(1, 0, primary!) = newmodified! then
	ls_menu_id = dw_pgm.getitemstring(1, 'menu_id')
	if isnull(ls_menu_id) or len(ls_menu_id) = 0 then
		choose case upper(left(sqlca.dbms, 3))
			// Oracle
			case 'O80', 'O90', 'O10', 'ORA'
				select		max(to_number(translate(menu_id, '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ.-=','1234567890')))
				into		:ls_menu_id
				from		pf_pgm_mst
				where	sys_id = :gnv_session.is_sys_id
				using		sqlca;
			// Else
			case else
				select		max(case isnumeric(menu_id) when 1 then convert(integer, menu_id) else 0 end)
				into		:ls_menu_id
				from		pf_pgm_mst
				where	sys_id = :gnv_session.is_sys_id
				using		sqlca;
		end choose
		
		if isnull(ls_menu_id	) then ls_menu_id = '0'
		ls_menu_id = string(long(ls_menu_id) + 1, '00000')
		
		dw_pgm.setitem(1, 'menu_id', ls_menu_id)
	end if
	
	// TreeView Item $$HEX2$$ddc031c1$$ENDHEX$$
	ltvi_item.data = ls_menu_id
	ltvi_item.label = ls_pgm_name
	
	choose case ls_pgm_kind_code
		case 'M'
			ltvi_item.PictureIndex = 3
			ltvi_item.SelectedPictureIndex = 4
			ltvi_item.Children = false
			ltvi_item.expandedonce = true
		case 'P'
			ltvi_item.PictureIndex = 1
			ltvi_item.SelectedPictureIndex = 2
			ltvi_item.Children = false
	end choose
	
	ltvi_item.HasFocus = false
	ltvi_item.selected = false
	
	ll_newhandle = tv_fullmenu.InsertItemLast(il_parent, ltvi_item)
	if itvi_parent.Expanded = false then
		itvi_parent.ExpandedOnce = true
		tv_fullmenu.ExpandItem(il_parent)
	end if

	// $$HEX25$$e0c2dcadf1b45db81cb4200004d55cb8f8ada8b740c7200000adacb990c720008cad5cd5d0c5200090c7d9b32000f1b45db8$$ENDHEX$$
	ls_io_type = dw_pgm.getitemstring(1, 'io_type')
	
	// $$HEX25$$30aef8bc84bcbcd2200024c115c8200004d55cb8f8ada8b72000c0d085c7d0c5200030b57cb7200090c7d9b3200024c115c8$$ENDHEX$$
	choose case ls_io_type
		case 'Q'	// $$HEX2$$70c88cd6$$ENDHEX$$
			ls_comm_btn_auth_yn = 'Y'
			ls_retrieve_auth_yn = 'Y'
			ls_input_auth_yn = 'N'
			ls_delete_auth_yn = 'N'
			ls_update_auth_yn = 'N'
			ls_print_auth_yn = 'N'
			ls_execute_auth_yn = 'N'
			ls_cancel_auth_yn = 'Y'
			ls_excel_auth_yn = 'N'
		case 'P'	// $$HEX2$$9ccd25b8$$ENDHEX$$
			ls_comm_btn_auth_yn = 'Y'
			ls_retrieve_auth_yn = 'Y'
			ls_input_auth_yn = 'N'
			ls_delete_auth_yn = 'N'
			ls_update_auth_yn = 'N'
			ls_print_auth_yn = 'Y'
			ls_execute_auth_yn = 'N'
			ls_cancel_auth_yn = 'Y'
			ls_excel_auth_yn = 'N'
		case 'M'	// $$HEX2$$85c725b8$$ENDHEX$$
			ls_comm_btn_auth_yn = 'Y'
			ls_retrieve_auth_yn = 'Y'
			ls_input_auth_yn = 'Y'
			ls_delete_auth_yn = 'Y'
			ls_update_auth_yn = 'Y'
			ls_print_auth_yn = 'N'
			ls_execute_auth_yn = 'N'
			ls_cancel_auth_yn = 'Y'
			ls_excel_auth_yn = 'N'
		case 'B'	// $$HEX2$$30bc58ce$$ENDHEX$$
			ls_comm_btn_auth_yn = 'Y'
			ls_retrieve_auth_yn = 'Y'
			ls_input_auth_yn = 'N'
			ls_delete_auth_yn = 'N'
			ls_update_auth_yn = 'N'
			ls_print_auth_yn = 'N'
			ls_execute_auth_yn = 'Y'
			ls_cancel_auth_yn = 'Y'
			ls_excel_auth_yn = 'N'
	end choose
	
	select		count(1)
	into		:ll_role_cnt
	from		pf_role_pgm
	where	sys_id = :gnv_session.is_sys_id
	and		role_no = '00001'
	and		menu_id = :ls_menu_id;
	
	if ll_role_cnt = 0 then
		datetime ldtm_now
		
		ldtm_now = pf_f_getdbmsdatetime()
		
		insert into pf_role_pgm
				( sys_id, role_no, menu_id, valid_dt_yn, comm_btn_auth_yn, retrieve_auth_yn, input_auth_yn, delete_auth_yn, update_auth_yn,
				print_auth_yn, execute_auth_yn, cancel_auth_yn, excel_auth_yn, indiv_btn_auth_yn, create_dtm, create_user )
		values ( :gnv_session.is_sys_id, '00001', :ls_menu_id, 'N', :ls_comm_btn_auth_yn, :ls_retrieve_auth_yn, :ls_input_auth_yn, :ls_delete_auth_yn, :ls_update_auth_yn,
				:ls_print_auth_yn, :ls_execute_auth_yn, :ls_cancel_auth_yn, :ls_excel_auth_yn, 'N', :ldtm_now, :gnv_session.is_user_id );
				
		if sqlca.sqlcode <> 0 then
			messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX15$$04d55cb8f8ada8b7200030aef8bc15c8f4bc200000c8a5c72000e4c228d3$$ENDHEX$$~r~nSQLCODE: ' + string(sqlca.sqldbcode) + '~r~nSQLERRTEXT: ' + sqlca.sqlerrtext)
			rollback using sqlca;
			return
		end if
	end if
	
	//tv_fullmenu.post selectitem(ll_newhandle)
else
	tv_fullmenu.getitem(il_handle, ltvi_item)
	ltvi_item.label = ls_pgm_name
	tv_fullmenu.setitem(il_handle, ltvi_item)
end if

// menu_id $$HEX28$$00ac2000c0bcbdac1cb42000bdacb0c6200000ad28b81cb420004cd174c714be44c72000a8ba50b4200018c215c874d520000dc9c8b2e4b2$$ENDHEX$$
string ls_org_menu_id, ls_new_menu_id

choose case dw_pgm.getitemstatus(1, 0, primary!)
	case datamodified!
		if dw_pgm.getitemstatus(1, 'menu_id', primary!) = datamodified! then
			ls_org_menu_id = dw_pgm.getitemstring(1, 'menu_id', primary!, true)
			ls_new_menu_id = dw_pgm.getitemstring(1, 'menu_id', primary!, false)
			
			if len(ls_org_menu_id) > 0 and len(ls_new_menu_id) > 0 and ls_org_menu_id <> ls_new_menu_id then
				// pf_pgm_mst
				update	pf_pgm_mst
				set			parent_menu = :ls_new_menu_id
				where	sys_id = :gnv_session.is_sys_id
				and		parent_menu = :ls_org_menu_id;
				
				// pf_role_pgm
				update	pf_role_pgm
				set			menu_id = :ls_new_menu_id
				where	sys_id = :gnv_session.is_sys_id
				and		menu_id = :ls_org_menu_id;
				
				// pf_role_pgm_btn
				update	pf_role_pgm_btn
				set			menu_id = :ls_new_menu_id
				where	sys_id = :gnv_session.is_sys_id
				and		menu_id = :ls_org_menu_id;
				
				// pf_user_favor
				update	pf_user_favor
				set			menu_id = :ls_new_menu_id
				where	sys_id = :gnv_session.is_sys_id
				and		menu_id = :ls_org_menu_id;
				
				// pf_docu_mst
				update	pf_docu_mst
				set			linked_menu_id = :ls_new_menu_id
				where	sys_id = :gnv_session.is_sys_id
				and		linked_menu_id = :ls_org_menu_id;
				
				// pf_pgm_help
				update	pf_pgm_help
				set			menu_id = :ls_new_menu_id
				where	sys_id = :gnv_session.is_sys_id
				and		menu_id = :ls_org_menu_id;
				
				tv_fullmenu.getitem(il_handle, ltvi_item)
				ltvi_item.data = ls_new_menu_id
				tv_fullmenu.setitem(il_handle, ltvi_item)
			end if
		end if
	case newmodified!
end choose

// $$HEX2$$00c8a5c7$$ENDHEX$$
string ls_errmsg

if dw_pgm.update() = 1 then
	commit using sqlca;
	of_setmessage("$$HEX8$$90c7ccb8200000c8a5c7200044c6ccb8$$ENDHEX$$!!")
else
	ls_errmsg = sqlca.sqlerrtext
	rollback using sqlca;
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX12$$90c7ccb8200000c8a5c72000e4c228d388d5b5c2c8b2e4b2$$ENDHEX$$!!~r~n' + ls_errmsg)
end if

end event

type p_delete from pf_u_imagebutton within pf_w_pgm_mst_ent
integer x = 3822
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX2$$adc01cc8$$ENDHEX$$
string ls_menu_id, ls_pgm_name
long ll_child_cnt

if dw_pgm.rowcount() = 0 then return

choose case dw_pgm.getitemstatus(1, 0, primary!)
	case new!, newmodified!
		if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX20$$04d6acc72000b8d3d1c911c978c72000b4b0a9c644c72000adc01cc858d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 1 then
			dw_pgm.deleterow(1)
		end if
	case else
		ls_menu_id = dw_pgm.getitemstring(1, 'menu_id')
		ls_pgm_name = dw_pgm.getitemstring(1, 'pgm_name')
		
		if not isvalid(itvi_item) then
			messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX15$$04d6acc7200020c1ddd01cb420006dd5a9ba74c72000c6c5b5c2c8b2e4b2$$ENDHEX$$')
			return
		end if
		
		if itvi_item.PictureIndex = 3 then
			select		count(1)
			into		:ll_child_cnt
			from		pf_pgm_mst
			where	sys_id = :gnv_session.is_sys_id
			and		parent_menu = :ls_menu_id
			using		sqlca;
			
			if ll_child_cnt > 0 then
				messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX26$$58d504c720006dd5a9ba74c7200074c8acc758d530ae20004cb538bbd0c52000adc01cc860d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX17$$3cba00c8200058d504c720006dd5a9ba44c72000adc01cc874d52000fcc838c194c6$$ENDHEX$$.')
				return
			end if
		end if
		
		if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX5$$20c1ddd058d5e0c22000$$ENDHEX$$' + ls_pgm_name + '[' + ls_menu_id + '] $$HEX12$$6dd5a9ba44c72000adc01cc858d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 1 then
			dw_pgm.deleterow(1)
			tv_fullmenu.post deleteitem(il_handle)
			if dw_pgm.update() = 1 then
				// $$HEX23$$adc01cc81cb4200004d55cb8f8ada8b7fcac2000f0c5c4ac1cb4200015c8f4bc7cb92000adc01cc869d5c8b2e4b2$$ENDHEX$$.
				// pf_role_pgm
				delete		pf_role_pgm
				where	sys_id = :gnv_session.is_sys_id
				and		menu_id = :ls_menu_id;
				
				// pf_role_pgm_btn
				delete		pf_role_pgm_btn
				where	sys_id = :gnv_session.is_sys_id
				and		menu_id = :ls_menu_id;
				
				// pf_user_favor
				delete		pf_user_favor
				where	sys_id = :gnv_session.is_sys_id
				and		menu_id = :ls_menu_id;
				
				// pf_pgm_help
				delete		pf_pgm_help
				where	sys_id = :gnv_session.is_sys_id
				and		menu_id = :ls_menu_id;
				
				commit using sqlca;
				of_setmessage("$$HEX8$$90c7ccb82000adc01cc8200044c6ccb8$$ENDHEX$$!!")
			else
				string ls_errmsg
				ls_errmsg = sqlca.sqlerrtext
				rollback using sqlca;
				messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX12$$90c7ccb82000adc01cc82000e4c228d388d5b5c2c8b2e4b2$$ENDHEX$$!!~r~n' + ls_errmsg)
			end if
		end if
end choose

end event

type p_add from pf_u_imagebutton within pf_w_pgm_mst_ent
integer x = 3575
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX4$$6dd5a9ba94cd00ac$$ENDHEX$$
long ll_sort_order
string ls_parent_menu, ls_parent_name

dw_pgm.reset()
dw_pgm.insertrow(0)

if isvalid(itvi_parent) then
	ls_parent_menu = string(itvi_parent.data)
	ls_parent_name = itvi_parent.label
	
	if isnull(ls_parent_menu) or len(trim(ls_parent_menu)) = 0 then
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX15$$3cba00c82000c1c004c72000f4d354b37cb9200020c1ddd058d538c194c6$$ENDHEX$$')
		return
	end if
	
	dw_pgm.setitem(1, 'parent_menu', ls_parent_menu)
	dw_pgm.setitem(1, 'parent_menu_name', ls_parent_name)
	
	select		max(sort_order)
	into		:ll_sort_order
	from		pf_pgm_mst
	where	sys_id = :gnv_session.is_sys_id
	and		parent_menu = :ls_parent_menu
	using		sqlca;
	
	if isnull(ll_sort_order) then ll_sort_order = 0
	ll_sort_order += 1
	
	dw_pgm.setitem(1, 'sys_id', gnv_session.is_sys_id)
	dw_pgm.setitem(1, 'sort_order', ll_sort_order)
	dw_pgm.setitem(1, 'pgm_kind_code', 'P')
	dw_pgm.setitem(1, 'pgm_use_yn', 'Y')
	dw_pgm.setitem(1, 'menu_use_yn', 'Y')
	dw_pgm.setitem(1, 'tree_level', itvi_parent.level + 1)	
	dw_pgm.event itemchanged(1, dw_pgm.object.pgm_kind_code, 'P')
	dw_pgm.setitemstatus(1, 0, primary!, notmodified!)
	
	dw_pgm.setfocus()
end if

end event

type dw_pgm from pf_u_datawindow within pf_w_pgm_mst_ent
integer x = 1490
integer y = 232
integer width = 3058
integer height = 1988
integer taborder = 20
string dataobject = "pf_d_pgm_mst_02"
boolean singlerowselection = false
boolean scaletoright = true
boolean scaletobottom = true
end type

event itemchanged;call super::itemchanged;string ls_platform_type
string ls_menu_id		
long ll_rowcnt

choose case dwo.name
	case 'menu_use_yn'
		if data = 'Y' then
			modify('pgm_name.tabsequence="0"')
		else
			modify('pgm_name.tabsequence="10"')
		end if
	case 'platform_type1'
		ls_platform_type = data + this.getitemstring(row, 'platform_type2') + this.getitemstring(row, 'platform_type3')
		this.setitem(row, 'platform_type', ls_platform_type)
	case 'platform_type2'
		ls_platform_type = this.getitemstring(row, 'platform_type1') + data + this.getitemstring(row, 'platform_type3')
		this.setitem(row, 'platform_type', ls_platform_type)
	case 'platform_type3'
		ls_platform_type = this.getitemstring(row, 'platform_type1') + this.getitemstring(row, 'platform_type2') + data
		this.setitem(row, 'platform_type', ls_platform_type)
	case 'menu_id'
		ls_menu_id = string(data)
		select nvl(count(1), 0) into :ll_rowcnt from pf_pgm_mst where sys_id = :gnv_session.is_sys_id and menu_id = :ls_menu_id;
		
		if ll_rowcnt > 0 then
			messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX8$$85c725b858d5e0c2200054ba74b22000$$ENDHEX$$ID [' + ls_menu_id + '] $$HEX15$$94b2200030ae200074c8acc758d594b2200088bc38d6200085c7c8b2e4b2$$ENDHEX$$.')
			return 1
		end if
	case 'url_link_yn'
		this.setitem(row, 'pgm_id', 'PF_W_WEBPAGE_LINK')
end choose

return 0

end event

type cb_1 from pf_u_commandbutton within pf_w_pgm_mst_ent
integer x = 3273
integer y = 36
integer width = 293
integer height = 92
integer taborder = 10
boolean bringtotop = true
string text = "$$HEX4$$8cad5cd560d5f9b2$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;string ls_menu_id

ls_menu_id = dw_pgm.getitemstring(1, 'menu_id')
if isnull(ls_menu_id) or len(ls_menu_id) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX17$$3cba00c8200004d55cb8f8ada8b7200015c8f4bc7cb9200000c8a5c758d538c194c6$$ENDHEX$$')
	return
end if

openwithparm(pf_w_pgm_mst_role_pgm, ls_menu_id)

end event

type cbx_expand from pf_u_checkbox within pf_w_pgm_mst_ent
integer x = 809
integer y = 148
integer width = 320
boolean bringtotop = true
string text = "$$HEX5$$f4c5b0b9200054ba74b2$$ENDHEX$$"
boolean checked = true
end type

