HA$PBExportHeader$pf_u_mdi_treemenu.sru
forward
global type pf_u_mdi_treemenu from pf_u_userobject
end type
type em_findstr from pf_u_editmask within pf_u_mdi_treemenu
end type
type st_title from pf_u_statictext within pf_u_mdi_treemenu
end type
type tv_menu from pf_u_treeview within pf_u_mdi_treemenu
end type
type p_search from pf_u_imagebutton within pf_u_mdi_treemenu
end type
end forward

global type pf_u_mdi_treemenu from pf_u_userobject
integer width = 1029
integer height = 2704
event pfe_menuclicked ( string as_menu_id,  string as_pgm_id,  string as_pgm_name )
event pfe_nomouseover ( )
em_findstr em_findstr
st_title st_title
tv_menu tv_menu
p_search p_search
end type
global pf_u_mdi_treemenu pf_u_mdi_treemenu

type variables
datastore ids_menu
pf_n_propertywatcher inv_propmon

end variables

forward prototypes
public function integer of_drawmenu ()
end prototypes

event pfe_nomouseover();this.visible = false
this.border = false
inv_propmon.of_unregister('nomouseover')
inv_propmon.of_stop()

end event

public function integer of_drawmenu ();long ll_rowcnt, ll_handle, i
treeviewitem ltvi_item
long ll_level, ll_parent[]
pf_s_treedata lstr_data

tv_menu.setredraw(false)
tv_menu.post setredraw(true)

ll_handle = tv_menu.finditem(roottreeitem!, 0)
do while ll_handle > 0
	tv_menu.deleteitem(ll_handle)
	ll_handle = tv_menu.finditem(roottreeitem!, ll_handle)
loop

pf_n_userrole lnv_userrole
lnv_userrole = gnv_session.of_get("userrole")
if not isvalid(lnv_userrole) then
	messagebox("$$HEX2$$4cc5bcb9$$ENDHEX$$", "$$HEX17$$5cb8f8ad78c7200015c8f4bc00ac20002cc614bc74b9c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$")
	return -1
end if

ll_rowcnt = ids_menu.retrieve(gnv_session.is_sys_id, gnv_session.of_getstring("login_dt"), &
				lnv_userrole.is_memb_code[1], lnv_userrole.is_memb_code[2], lnv_userrole.is_memb_code[3], lnv_userrole.is_memb_code[4], &
				lnv_userrole.is_memb_code[5], lnv_userrole.is_memb_code[6], lnv_userrole.is_memb_code[7], lnv_userrole.is_memb_code[8])

ll_parent[1] = 0

for i = 1 to ll_rowcnt
	lstr_data.menu_id = ids_menu.getitemstring(i, 'menu_id')
	lstr_data.pgm_id = ids_menu.getitemstring(i, 'pgm_id')
	lstr_data.pgm_kc = ids_menu.getitemstring(i, 'pgm_kind_code')
	lstr_data.pgm_nm = ids_menu.getitemstring(i, 'pgm_name')
	lstr_data.parent_menu = ids_menu.getitemstring(i, 'parent_menu')
	
	ltvi_item.data = lstr_data
	ltvi_item.label = lstr_data.pgm_nm
	
	choose case lstr_data.pgm_kc
		case 'M'
			ltvi_item.PictureIndex = 3
			ltvi_item.SelectedPictureIndex = 4
			ltvi_item.Children = true
		case 'P'
			ltvi_item.PictureIndex = 1
			ltvi_item.SelectedPictureIndex = 2
			ltvi_item.Children = false
	end choose
	
//	if ids_menu.getitemnumber(i, 'child_cnt') > 0 then
//		ltvi_item.Children = true
//	else
//		ltvi_item.Children = false
//	end if
	
	ltvi_item.HasFocus = false
	ltvi_item.selected = false
	
//	if ids_menu.getitemstring(i, 'pgm_chk') = 'Y' then
//		ltvi_item.statepictureindex = 2
//	else
//		ltvi_item.statepictureindex = 1
//	end if
	
	ll_level = ids_menu.getitemnumber(i, 'tree_level')
	
	// $$HEX3$$c1c004c72000$$ENDHEX$$Parent Node$$HEX8$$00ac2000c6c594b22000bdacb0c62000$$ENDHEX$$Skip $$HEX2$$98ccacb9$$ENDHEX$$
	if upperbound(ll_parent) < ll_level then continue
	
	ll_handle = tv_menu.InsertItemLast(ll_parent[ll_level], ltvi_item)
	if lstr_data.pgm_kc = 'M' then
		ll_parent[ll_level + 1] = ll_handle
	end if
next

// child item$$HEX5$$74c72000c6c594b22000$$ENDHEX$$node$$HEX2$$adc01cc8$$ENDHEX$$
long ll_tvi, ll_nochild[]

ll_rowcnt = 0
ll_tvi = tv_menu.FindItem(RootTreeItem!, 0)

do while ll_tvi > 0
	tv_menu.getitem(ll_tvi, ltvi_item)
	if ltvi_item.pictureindex = 3 then
		if tv_menu.FindItem(ChildTreeItem!, ll_tvi) = -1 then
			ll_rowcnt ++
			ll_nochild[ll_rowcnt] = ll_tvi
		end if
	end if
	ll_tvi = tv_menu.FindItem(NextVisibleTreeItem!, ll_tvi)
loop

for i = 1 to upperbound(ll_nochild)
	tv_menu.deleteitem(ll_nochild[i])
next

//$$HEX10$$04c8b4cc2000200054ba74b22000bcd358ce30ae$$ENDHEX$$
long ll_root[]

ll_rowcnt = 0
ll_tvi = tv_menu.FindItem(RootTreeItem!, 0)
do while ll_tvi > 0
	ll_rowcnt ++
	ll_root[ll_rowcnt] = ll_tvi
	ll_tvi = tv_menu.FindItem(NextVisibleTreeItem!, ll_tvi)
loop

for i = 1 to ll_rowcnt
	tv_menu.expandall(ll_root[i])
next

if upperbound(ll_root) > 0 then
	tv_menu.post selectitem(ll_root[1])
end if

return ll_rowcnt

end function

on pf_u_mdi_treemenu.create
int iCurrent
call super::create
this.em_findstr=create em_findstr
this.st_title=create st_title
this.tv_menu=create tv_menu
this.p_search=create p_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_findstr
this.Control[iCurrent+2]=this.st_title
this.Control[iCurrent+3]=this.tv_menu
this.Control[iCurrent+4]=this.p_search
end on

on pf_u_mdi_treemenu.destroy
call super::destroy
destroy(this.em_findstr)
destroy(this.st_title)
destroy(this.tv_menu)
destroy(this.p_search)
end on

event destructor;call super::destructor;if isvalid(ids_menu) then
	destroy ids_menu
end if

if isvalid(inv_propmon) then
	inv_propmon.of_stop()
	destroy inv_propmon
end if

end event

event pfe_postopen;call super::pfe_postopen;ids_menu = create datastore

choose case upper(left(sqlca.dbms, 3))
	// Oracle
	case 'O80', 'O90', 'O10', 'ORA'
		ids_menu.dataobject = 'pf_d_role_search_07_oracle'	
	// Else
	case else
		ids_menu.dataobject = 'pf_d_role_search_07_asa'	
end choose

ids_menu.settransobject(sqlca)

// register porps watcher
inv_propmon = create pf_n_propertywatcher
inv_propmon.of_registerparent(this)
inv_propmon.of_setvisibletime(2500)

end event

event resize;call super::resize;//dw_menu.width = this.width
//dw_menu.height = this.height

end event

type p_background from pf_u_userobject`p_background within pf_u_mdi_treemenu
end type

type em_findstr from pf_u_editmask within pf_u_mdi_treemenu
integer x = 293
integer y = 28
integer width = 603
integer taborder = 10
boolean bringtotop = true
long textcolor = 20395836
maskdatatype maskdatatype = stringmask!
boolean scaletoright = true
end type

event modified;call super::modified;if len(this.text) > 0 then
	p_search.event clicked()
end if

end event

type st_title from pf_u_statictext within pf_u_mdi_treemenu
integer x = 27
integer y = 32
integer width = 261
integer height = 80
boolean bringtotop = true
string text = "$$HEX5$$54ba74b2200080acc9c0$$ENDHEX$$"
alignment alignment = center!
end type

type tv_menu from pf_u_treeview within pf_u_mdi_treemenu
integer x = 32
integer y = 136
integer width = 965
integer height = 2540
integer taborder = 20
boolean bringtotop = true
long textcolor = 20395836
string picturename[] = {"Application5!","ApplicationIcon!","Custom039!","Open!"}
long picturemaskcolor = 12632256
boolean scaletoright = true
boolean scaletobottom = true
end type

event key;call super::key;choose case key
	case keyEnter!
		p_search.post event clicked()
end choose

end event

event doubleclicked;call super::doubleclicked;treeviewitem ltvi_item
pf_s_treedata lstr_data

if this.getitem(handle, ltvi_item) = -1 then return

lstr_data = ltvi_item.data
if lstr_data.pgm_kc = 'M' then return

parent.post event pfe_menuclicked(lstr_data.menu_id, lstr_data.pgm_id, lstr_data.pgm_nm)

end event

type p_search from pf_u_imagebutton within pf_u_mdi_treemenu
integer x = 905
integer y = 28
integer width = 91
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_searchicon.gif"
string powertiptext = "$$HEX19$$80acc9c060d5200004d55cb8f8ada8b7200085ba6dce200010b694b2200008c7c4b3b0c62000$$ENDHEX$$ID$$HEX12$$7cb9200085c725b82000c4d6200074d0adb958d538c194c6$$ENDHEX$$."
boolean fixedtoright = true
end type

event clicked;call super::clicked;string ls_findstr
long ll_pos

ls_findstr = em_findstr.text
if isnull(ls_findstr) or len(ls_findstr) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX22$$54ba74b27cb9200080acc9c060d5200004d55cb8f8ada8b7200085ba6dce200010b694b2200008c7c4b3b0c6$$ENDHEX$$ID$$HEX7$$7cb9200085c725b858d538c194c6$$ENDHEX$$')
	em_findstr.setfocus()
	return
end if

// $$HEX16$$80acc9c070c874acd0c5200074d5f9b258d594b2200054ba74b2200080acc9c0$$ENDHEX$$
long ll_tvi
treeviewitem ltvi_item
pf_s_treedata lstr_data

ll_tvi = tv_menu.FindItem(CurrentTreeItem!, 0)
if ll_tvi = -1 then return

ll_tvi = tv_menu.FindItem(NextVisibleTreeItem!, ll_tvi)
do while ll_tvi > 0
	tv_menu.getitem(ll_tvi, ltvi_item)
	lstr_data = ltvi_item.data
	
	ll_pos = pos(lstr_data.menu_id, upper(ls_findstr))
	ll_pos += pos(lstr_data.pgm_id, upper(ls_findstr))
	ll_pos += pos(lstr_data.pgm_nm, ls_findstr)
	
	if ll_pos > 0 then
		tv_menu.selectitem(ll_tvi)
		tv_menu.setfocus()
		return
	end if

	ll_tvi = tv_menu.FindItem(NextVisibleTreeItem!, ll_tvi)
loop

if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX18$$7cc758ce58d594b220006dd5a9ba74c7200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX16$$98cc4cc780bd30d12000e4b2dcc2200080acc9c058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 1 then
	ll_tvi = tv_menu.finditem(RootTreeItem!, 0)
	if ll_tvi > 0 then
		tv_menu.finditem(NextVisibleTreeItem!, ll_tvi)
		tv_menu.selectitem(ll_tvi)
		this.post event clicked()
	end if
end if

end event

