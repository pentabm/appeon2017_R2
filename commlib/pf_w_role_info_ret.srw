HA$PBExportHeader$pf_w_role_info_ret.srw
$PBExportComments$$$HEX17$$04d6acc72000f1b45db81cb420008cad5cd515c8f4bc7cb92000acc0a9c690c7c4bc$$ENDHEX$$, $$HEX20$$04d55cb8f8ada8b7c4bc5cb8200070c88cd658d594b2200004d55cb8f8ada8b7200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_role_info_ret from pf_w_sheet
end type
type tab_1 from tab within pf_w_role_info_ret
end type
type tabpage_1 from userobject within tab_1
end type
type cb_2 from pf_u_commandbutton within tabpage_1
end type
type cb_1 from pf_u_commandbutton within tabpage_1
end type
type dw_role_list from pf_u_datawindow within tabpage_1
end type
type p_2 from picture within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type tv_menu from pf_u_treeview within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type p_1 from picture within tabpage_1
end type
type dw_user_list from pf_u_datawindow within tabpage_1
end type
type p_search from pf_u_imagebutton within tabpage_1
end type
type dw_user_list_cond from pf_u_datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_2 cb_2
cb_1 cb_1
dw_role_list dw_role_list
p_2 p_2
st_2 st_2
tv_menu tv_menu
st_1 st_1
p_1 p_1
dw_user_list dw_user_list
p_search p_search
dw_user_list_cond dw_user_list_cond
end type
type tabpage_2 from userobject within tab_1
end type
type dw_pgm_user from pf_u_datawindow within tabpage_2
end type
type dw_pgm_role from pf_u_datawindow within tabpage_2
end type
type tv_fullmenu from pf_u_treeview within tabpage_2
end type
type st_5 from statictext within tabpage_2
end type
type st_4 from statictext within tabpage_2
end type
type p_5 from picture within tabpage_2
end type
type p_4 from picture within tabpage_2
end type
type p_3 from picture within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_pgm_user dw_pgm_user
dw_pgm_role dw_pgm_role
tv_fullmenu tv_fullmenu
st_5 st_5
st_4 st_4
p_5 p_5
p_4 p_4
p_3 p_3
st_3 st_3
end type
type tab_1 from tab within pf_w_role_info_ret
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type p_close from pf_u_imagebutton within pf_w_role_info_ret
end type
type uo_1 from pf_u_tab within pf_w_role_info_ret
end type
end forward

global type pf_w_role_info_ret from pf_w_sheet
string title = "Role $$HEX2$$70c88cd6$$ENDHEX$$"
tab_1 tab_1
p_close p_close
uo_1 uo_1
end type
global pf_w_role_info_ret pf_w_role_info_ret

type variables
datawindow	idw_user_list_cond
datawindow idw_user_list
datawindow idw_role_list
treeview itv_menu

treeview itv_fullmenu
datawindow idw_pgm_role
datawindow idw_pgm_user

pf_n_userrole inv_user_role
datastore ids_menu
datastore ids_fullmenu
datastore ids_role_cat

end variables

forward prototypes
public function integer of_set_user_menu ()
public function integer of_set_pgm_fullmenu ()
public subroutine of_clearusermenu ()
public function integer of_set_title_role_memb ()
end prototypes

public function integer of_set_user_menu ();long ll_rowcnt, ll_handle
integer i
treeviewitem ltvi_item
long ll_level, ll_parent[]

itv_menu.setredraw(false)
itv_menu.post setredraw(true)

ll_handle = itv_menu.finditem(roottreeitem!, 0)
do while ll_handle > 0
	itv_menu.deleteitem(ll_handle)
	ll_handle = itv_menu.finditem(roottreeitem!, ll_handle)
loop

ll_rowcnt = ids_menu.retrieve(gnv_session.is_sys_id, gnv_session.of_getstring("login_dt"), &
				inv_user_role.is_memb_code[1], inv_user_role.is_memb_code[2], inv_user_role.is_memb_code[3], inv_user_role.is_memb_code[4], &
				inv_user_role.is_memb_code[5], inv_user_role.is_memb_code[6], inv_user_role.is_memb_code[7], inv_user_role.is_memb_code[8])

// $$HEX16$$60d5f9b21cb4200004d55cb8f8ada8b774c72000c6c53cc774ba2000acb934d1$$ENDHEX$$
if ll_rowcnt = 0 then
	return	 0
end if

ll_parent[1] = 0

for i = 1 to ll_rowcnt
	ltvi_item.data = ids_menu.getitemstring(i, 'menu_id')
	ltvi_item.label = ids_menu.getitemstring(i, 'pgm_name')
	
	choose case ids_menu.getitemstring(i, 'pgm_kind_code')
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
	
	ll_handle = itv_menu.InsertItemLast(ll_parent[ll_level], ltvi_item)
	if ids_menu.getitemstring(i, 'pgm_kind_code') = 'M' then
		ll_parent[ll_level + 1] = ll_handle
	end if
next

// expand treeview items
ll_handle = itv_menu.finditem(roottreeitem!, 0)
if ll_handle > 0 then
	// expand the root treeviewitem
	itv_menu.expandall(ll_handle)

	// scroll back to top
	itv_menu.SetFirstVisible(ll_handle)

	// select first treeviewitem
	itv_menu.post selectitem(ll_handle)
end if

//itv_menu.ExpandAll(ll_parent[2])

//// child item$$HEX5$$74c72000c6c594b22000$$ENDHEX$$node$$HEX2$$adc01cc8$$ENDHEX$$
//long ll_tvi, ll_nochild[]
//
//ll_rowcnt = 0
//ll_tvi = itv_menu.FindItem(RootTreeItem!, 0)
//do while ll_tvi > 0
//	itv_menu.getitem(ll_tvi, ltvi_item)
//	if ltvi_item.pictureindex = 3 then
//		if itv_menu.FindItem(ChildTreeItem!, ll_tvi) = -1 then
//			ll_rowcnt ++
//			ll_nochild[ll_rowcnt] = ll_tvi
//		end if
//	end if
//	ll_tvi = itv_menu.FindItem(NextVisibleTreeItem!, ll_tvi)
//loop
//
//for i = 1 to upperbound(ll_nochild)
//	itv_menu.deleteitem(ll_nochild[i])
//next

//// expand treeview items
//ll_handle = itv_menu.finditem(roottreeitem!, 0)
//ll_roothndl = ll_handle
//do while ll_handle > 0
//	if tab_1.tabpage_1.cbx_expand.checked = true then
//		itv_menu.expandall(ll_handle)
//	else
//		itv_menu.expanditem(ll_handle)
//	end if
//	ll_handle = itv_menu.finditem(NextTreeItem!, ll_handle)
//loop

//itv_menu.post selectitem(ll_parent[2])
return ll_rowcnt

end function

public function integer of_set_pgm_fullmenu ();long ll_rowcnt, ll_handle
integer i
treeviewitem ltvi_item
long ll_level, ll_parent[]

itv_fullmenu.setredraw(false)
itv_fullmenu.post setredraw(true)

ll_handle = itv_fullmenu.finditem(roottreeitem!, 0)
do while ll_handle > 0
	itv_fullmenu.deleteitem(ll_handle)
	ll_handle = itv_fullmenu.finditem(roottreeitem!, ll_handle)
loop

ll_rowcnt = ids_fullmenu.retrieve(gnv_session.is_sys_id, 'ROOT')

// $$HEX15$$60d5f9b21cb4200004d55cb8f8ada8b72000c6c53cc774ba2000acb934d1$$ENDHEX$$
if ll_rowcnt = 0 then
	return 0
end if

ll_parent[1] = 0
for i = 1 to ll_rowcnt
	ltvi_item.data = ids_fullmenu.getitemstring(i, 'menu_id')
	ltvi_item.label = ids_fullmenu.getitemstring(i, 'pgm_name')
	
	choose case ids_fullmenu.getitemstring(i, 'pgm_kind_code')
		case 'M'
			ltvi_item.PictureIndex = 3
			ltvi_item.SelectedPictureIndex = 4
		case 'P'
			ltvi_item.PictureIndex = 1
			ltvi_item.SelectedPictureIndex = 2
	end choose
	
	if ids_fullmenu.getitemnumber(i, 'child_cnt') > 0 then
		ltvi_item.children = true
	else
		ltvi_item.children = false
	end if
	
	ltvi_item.hasfocus = false
	ltvi_item.selected = false
	
	ll_level = ids_fullmenu.getitemnumber(i, 'tree_level')
	ll_handle = itv_fullmenu.InsertItemLast(ll_parent[ll_level], ltvi_item)
	if ids_fullmenu.getitemstring(i, 'pgm_kind_code') = 'M' then
		ll_parent[ll_level + 1] = ll_handle
	end if
next




//itv_menu.ExpandAll(ll_parent[2])

// expand treeview items
ll_handle = itv_fullmenu.finditem(roottreeitem!, 0)
if ll_handle > 0 then
	// expand the root treeviewitem
	itv_fullmenu.expandall(ll_handle)

	// scroll back to top
	itv_fullmenu.SetFirstVisible(ll_handle)

	// select first treeviewitem
	itv_fullmenu.post selectitem(ll_handle)

	//ll_roothndl = ll_handle
	//do while ll_handle > 0
	//	if tab_1.tabpage_2.cbx_expand2.checked = true then
	//		itv_fullmenu.expandall(ll_handle)
	//	else
	//		itv_fullmenu.expanditem(ll_handle)
	//	end if
	//	ll_handle = itv_fullmenu.finditem(NextTreeItem!, ll_handle)
	//loop
end if

return ll_rowcnt

end function

public subroutine of_clearusermenu ();long ll_handle

ll_handle = itv_menu.finditem(roottreeitem!, 0)
do while ll_handle > 0
	itv_menu.deleteitem(ll_handle)
	ll_handle = itv_menu.finditem(roottreeitem!, ll_handle)
loop

end subroutine

public function integer of_set_title_role_memb ();integer i, li_role_cat_no
boolean lb_role_cat_yn[8]
string ls_search_type
string ls_role_cat_no, ls_role_cat_name
string ls_code_list_dwo

datastore lds_temp
pf_n_syntaxbuffer lnv_syntax

lnv_syntax = create pf_n_syntaxbuffer
lds_temp = create datastore

// modify header title
for i = 1 to ids_role_cat.rowcount()
	ls_role_cat_no = ids_role_cat.getitemstring(i, 'role_cat_no')
	li_role_cat_no = integer(ls_role_cat_no)
	lb_role_cat_yn[li_role_cat_no] = true
	ls_role_cat_name = ids_role_cat.getitemstring(i, 'role_cat_name')
	ls_search_type = ids_role_cat.getitemstring(i, 'search_type')
	ls_code_list_dwo = ids_role_cat.getitemstring(i, 'code_list_dwo')
	
	lnv_syntax.of_append("memb_code" + string(li_role_cat_no) + ".visible=0")
	lnv_syntax.of_append("memb_name" + string(li_role_cat_no) + "_t.text='" + ls_role_cat_name + "'")
	lnv_syntax.of_append("memb_name" + string(li_role_cat_no) + ".tag='" + ls_code_list_dwo + "'")
next

// hide unused columns
for i = 1 to upperbound(lb_role_cat_yn)
	if lb_role_cat_yn[i] = false then
		lnv_syntax.of_append("memb_code" + string(i) + "_t.visible=0")
		lnv_syntax.of_append("memb_code" + string(i) + ".visible=0")
		lnv_syntax.of_append("memb_name" + string(i) + "_t.visible=0")
		lnv_syntax.of_append("memb_name" + string(i) + ".visible=0")
	end if
next

// do moidfy
string ls_error

ls_error = idw_pgm_user.Modify(lnv_syntax.of_toString())
if len(ls_error) > 0 then
	::clipboard(lnv_syntax.of_toString())
	messagebox("Error", idw_pgm_user.classname() + " Syntax Modification Failure!! : " + ls_error)
	return -1
end if

//idw_pgm_user.event ue_dwowidthchanged()
return 1

end function

on pf_w_role_info_ret.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.p_close=create p_close
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.p_close
this.Control[iCurrent+3]=this.uo_1
end on

on pf_w_role_info_ret.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.p_close)
destroy(this.uo_1)
end on

event open;call super::open;inv_user_role = create pf_n_userrole

idw_user_list_cond = tab_1.tabpage_1.dw_user_list_cond
idw_user_list = tab_1.tabpage_1.dw_user_list
idw_role_list = tab_1.tabpage_1.dw_role_list
itv_menu = tab_1.tabpage_1.tv_menu

idw_user_list.settransobject(sqlca)
idw_role_list.settransobject(sqlca)

itv_fullmenu = tab_1.tabpage_2.tv_fullmenu
idw_pgm_role = tab_1.tabpage_2.dw_pgm_role
idw_pgm_user = tab_1.tabpage_2.dw_pgm_user

idw_pgm_role.settransobject(sqlca)
idw_pgm_user.settransobject(sqlca)

ids_menu = create datastore
ids_fullmenu = create datastore

choose case pf_f_getdbmstype(sqlca)
	case 'Oracle'
		ids_menu.dataobject = 'pf_d_role_search_07_oracle'	
		ids_fullmenu.dataobject = 'pf_d_role_search_04_oracle'
	case 'Sybase'
		ids_menu.dataobject = 'pf_d_role_search_07_asa'	
		ids_fullmenu.dataobject = 'pf_d_role_search_04_asa'
	case 'SQLServer'
		ids_menu.dataobject = 'pf_d_role_search_07_mssql'	
		ids_fullmenu.dataobject = 'pf_d_role_search_04_mssql'
end choose

ids_menu.settransobject(sqlca)
ids_fullmenu.settransobject(sqlca)

ids_role_cat = create datastore
ids_role_cat.dataobject = 'pf_d_role_cat_mst'
ids_role_cat.settransobject(sqlca)

end event

event close;call super::close;destroy inv_user_role

end event

event pfe_postopen;call super::pfe_postopen;ids_role_cat.retrieve(gnv_session.is_sys_id)
this.of_set_title_role_memb()

idw_user_list_cond.insertrow(0)
of_set_pgm_fullmenu()

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_role_info_ret
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_role_info_ret
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_role_info_ret
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_role_info_ret
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_role_info_ret
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_role_info_ret
end type

type tab_1 from tab within pf_w_role_info_ret
integer x = 50
integer y = 164
integer width = 4498
integer height = 2056
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4462
integer height = 1936
string text = " $$HEX9$$acc0a9c690c7c4bc20008cad5cd570c88cd6$$ENDHEX$$"
long tabtextcolor = 25123896
long tabbackcolor = 1073741824
string picturename = "..\img\commonuse\front_title_img.gif"
long picturemaskcolor = 536870912
cb_2 cb_2
cb_1 cb_1
dw_role_list dw_role_list
p_2 p_2
st_2 st_2
tv_menu tv_menu
st_1 st_1
p_1 p_1
dw_user_list dw_user_list
p_search p_search
dw_user_list_cond dw_user_list_cond
end type

on tabpage_1.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_role_list=create dw_role_list
this.p_2=create p_2
this.st_2=create st_2
this.tv_menu=create tv_menu
this.st_1=create st_1
this.p_1=create p_1
this.dw_user_list=create dw_user_list
this.p_search=create p_search
this.dw_user_list_cond=create dw_user_list_cond
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_role_list,&
this.p_2,&
this.st_2,&
this.tv_menu,&
this.st_1,&
this.p_1,&
this.dw_user_list,&
this.p_search,&
this.dw_user_list_cond}
end on

on tabpage_1.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_role_list)
destroy(this.p_2)
destroy(this.st_2)
destroy(this.tv_menu)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.dw_user_list)
destroy(this.p_search)
destroy(this.dw_user_list_cond)
end on

type cb_2 from pf_u_commandbutton within tabpage_1
integer x = 4032
integer y = 4
integer width = 421
integer taborder = 30
string text = "$$HEX6$$1cacc4bc8cad5cd5adc01cc8$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX15$$acc0a9c690c7d0c58cac200060d5f9b21cb420008cad5cd520001cc870ac$$ENDHEX$$
// $$HEX21$$1cac78c7c4bc5cb8200060d5f9b21cb420008cad5cd5ccb920001cc870ac200000aca5b269d5c8b2e4b2$$ENDHEX$$.

string ls_user_id, ls_user_name
string ls_role_no, ls_role_name
long ll_userrow, ll_rolerow, ll_membcnt

// $$HEX13$$8cad5cd52000adc01cc860d52000acc0a9c690c7200055d678c7$$ENDHEX$$
ll_userrow = idw_user_list.getrow()
if ll_userrow = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX18$$3cba00c820008cad5cd544c72000adc01cc860d52000acc0a9c690c77cb9200070c88cd6$$ENDHEX$$/$$HEX5$$20c1ddd058d538c194c6$$ENDHEX$$')
	return
end if

ls_user_id = idw_user_list.getitemstring(ll_userrow, 'user_id')
ls_user_name = idw_user_list.getitemstring(ll_userrow, 'user_name')

// $$HEX9$$adc01cc860d520008cad5cd5200055d678c7$$ENDHEX$$
ll_rolerow = idw_role_list.getrow()
if ll_rolerow = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX13$$adc01cc860d520008cad5cd544c7200020c1ddd058d538c194c6$$ENDHEX$$')
	return
end if

ls_role_no = idw_role_list.getitemstring(ll_rolerow, 'role_no')
ls_role_name = idw_role_list.getitemstring(ll_rolerow, 'role_name')

// $$HEX16$$1cac78c7c4bc5cb8200060d5f9b21cb420008cad5cd578c7c0c9200055d678c7$$ENDHEX$$
select		count(1)
into		:ll_membcnt
from		pf_role_memb
where	sys_id = :gnv_session.is_sys_id
and		role_no = :ls_role_no
and		memb_code1 = :ls_user_id;

if ll_membcnt = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX27$$1cac78c7c4bc5cb8200060d5f9b21cb420008cad5cd5d0c5200000b374d51cc1ccb92000adc01cc8200000aca5b2200069d5c8b2e4b2$$ENDHEX$$.~r~n$$HEX3$$f8adf9b8c4bc$$ENDHEX$$($$HEX1$$08c6$$ENDHEX$$:$$HEX3$$80bd1cc1c4bc$$ENDHEX$$, $$HEX3$$c1c909aec4bc$$ENDHEX$$)$$HEX27$$5cb8200060d5f9b21cb420008cad5cd540c72000b9d215c820001cac78c7ccb92000adc01cc860d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$.')
	return
end if

// $$HEX9$$adc01cc82000ecc580bd7cb9200055d678c7$$ENDHEX$$
if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', ls_user_name + ' $$HEX10$$acc0a9c690c7d0c58cac200060d5f9b21cb42000$$ENDHEX$$~'' + ls_role_name + '[' + ls_role_no + ']~' $$HEX13$$8cad5cd544c72000adc01cc8200058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 2 then return

// $$HEX9$$60d5f9b21cb420008cad5cd52000adc01cc8$$ENDHEX$$
string ls_errtext

delete		pf_role_memb
where	sys_id = :gnv_session.is_sys_id
and		role_no = :ls_role_no
and		memb_code1 = :ls_user_id;

if sqlca.sqlcode = -1 then
	ls_errtext = sqlca.sqlerrtext
	rollback using sqlca;
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX39$$acc0a9c690c7d0c58cac200060d5f9b21cb420008cad5cd544c72000adc01cc858d594b2200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc018b4c8c5b5c2c8b2e4b2$$ENDHEX$$.~r~n' + ls_errtext)
	return
end if

commit using sqlca;
messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX20$$acc0a9c690c7d0c58cac200060d5f9b21cb420008cad60d544c72000adc01cc888d5b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX18$$b8d2acb9200054ba74b2200070b374c730d17cb92000acc770c88cd6200069d5c8b2e4b2$$ENDHEX$$.')

// $$HEX20$$b8d2acb9200054ba74b220000fbc20008cad5cd5200070b374c730d12000acc7200070c88cd62000$$ENDHEX$$
idw_user_list.post event rowfocuschanged(ll_userrow)

end event

type cb_1 from pf_u_commandbutton within tabpage_1
integer x = 3611
integer y = 4
integer width = 421
integer taborder = 20
string text = "$$HEX6$$1cacc4bc8cad5cd594cd00ac$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;string ls_user_id, ls_user_name
long ll_userrow

ll_userrow = idw_user_list.getrow()
if ll_userrow = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX18$$3cba00c820008cad5cd544c7200060d5f9b260d52000acc0a9c690c77cb9200070c88cd6$$ENDHEX$$/$$HEX5$$20c1ddd058d538c194c6$$ENDHEX$$')
	return
end if

ls_user_id = idw_user_list.getitemstring(ll_userrow, 'user_id')
ls_user_name = idw_user_list.getitemstring(ll_userrow, 'user_name')

open(pf_w_select_rolemst)
if len(message.stringparm) = 0 then return

string ls_retval[]
string ls_role_no, ls_role_name
long ll_membcnt

pf_f_parsetoarray(message.stringparm, '~t', ls_retval[])

ls_role_no = ls_retval[1]
ls_role_name = ls_retval[2]

// $$HEX14$$74c7f8bb2000f1b45db81cb420008cad5cd578c7c0c9200055d678c7$$ENDHEX$$
select		count(1)
into		:ll_membcnt
from		pf_role_memb
where	sys_id = :gnv_session.is_sys_id
and		role_no = :ls_role_no
and		memb_code1 = :ls_user_id;

if ll_membcnt > 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '($$HEX5$$11c9f5bc2000f1b45db8$$ENDHEX$$)$$HEX18$$74c7f8bb2000acc0a9c690c7d0c58cac200060d5f9b21cb420008cad5cd585c7c8b2e4b2$$ENDHEX$$.')
	return
end if

// $$HEX9$$f1b45db82000ecc580bd7cb9200055d678c7$$ENDHEX$$
if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '~'' + ls_role_name + '[' + ls_role_no + ']~' $$HEX4$$8cad5cd544c72000$$ENDHEX$$' + ls_user_name + ' $$HEX15$$acc0a9c690c7d0c58cac200060d5f9b2200058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 2 then return

// $$HEX5$$8cad5cd52000f1b45db8$$ENDHEX$$
string ls_errtext
long ll_membseq
datetime ldtm_now

select		max(memb_seq)
into		:ll_membseq
from		pf_role_memb
where	sys_id = :gnv_session.is_sys_id
and		role_no = :ls_role_no;

if isnull(ll_membseq) then ll_membseq = 0
ll_membseq ++
ldtm_now = pf_f_getdbmsdatetime()

insert into pf_role_memb
( sys_id, role_no, memb_seq, memb_code1, memb_name1, valid_dt_yn, create_dtm, create_user )
values ( :gnv_session.is_sys_id, :ls_role_no, :ll_membseq, :ls_user_id, :ls_user_name, 'N', :ldtm_now, :gnv_session.is_user_id);

if sqlca.sqlcode = -1 then
	ls_errtext = sqlca.sqlerrtext
	rollback using sqlca;
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX35$$acc0a9c690c7d0c58cac20008cad5cd544c7200060d5f9b258d594b2200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc018b4c8c5b5c2c8b2e4b2$$ENDHEX$$.~r~n' + ls_errtext)
	return
end if

commit using sqlca;
messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX16$$acc0a9c690c7d0c58cac20008cad5cd544c7200094cd00ac88d5b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX18$$b8d2acb9200054ba74b2200070b374c730d17cb92000acc770c88cd6200069d5c8b2e4b2$$ENDHEX$$.')

// $$HEX20$$b8d2acb9200054ba74b220000fbc20008cad5cd5200070b374c730d12000acc7200070c88cd62000$$ENDHEX$$
idw_user_list.post event rowfocuschanged(ll_userrow)

end event

type dw_role_list from pf_u_datawindow within tabpage_1
integer x = 3136
integer y = 120
integer width = 1330
integer height = 1800
integer taborder = 20
string dataobject = "pf_d_role_search_03"
boolean scaletoright = true
boolean scaletobottom = true
end type

event rowfocuschanged;call super::rowfocuschanged;this.selectrow(0, false)
this.selectrow(currentrow, true)

end event

type p_2 from picture within tabpage_1
integer x = 3141
integer y = 52
integer width = 46
integer height = 40
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_1
integer x = 3205
integer y = 44
integer width = 315
integer height = 56
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 25123896
string text = "$$HEX5$$acc0a9c620008cad5cd5$$ENDHEX$$"
boolean focusrectangle = false
end type

type tv_menu from pf_u_treeview within tabpage_1
integer x = 1527
integer y = 120
integer width = 1595
integer height = 1800
integer taborder = 30
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 20132659
string picturename[] = {"Application5!","ApplicationIcon!","Custom039!","Open!"}
long picturemaskcolor = 12632256
boolean scaletobottom = true
end type

type st_1 from statictext within tabpage_1
integer x = 1600
integer y = 40
integer width = 411
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 25123896
string text = "$$HEX7$$acc0a9c6200004d55cb8f8ada8b7$$ENDHEX$$"
boolean focusrectangle = false
end type

type p_1 from picture within tabpage_1
integer x = 1536
integer y = 52
integer width = 46
integer height = 40
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type dw_user_list from pf_u_datawindow within tabpage_1
integer x = 18
integer y = 304
integer width = 1490
integer height = 1616
integer taborder = 20
string dataobject = "pf_d_role_search_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean scaletobottom = true
end type

event rowfocuschanged;call super::rowfocuschanged;if currentrow = 0 then return

this.selectrow(0, false)
this.selectrow(currentrow, true)

string ls_user_id

ls_user_id = this.getitemstring(currentrow, 'user_id')

if inv_user_role.of_SetUserInfo(ls_user_id) < 0 then return
if inv_user_role.of_SetUserRole(ls_user_id) < 0 then
	of_clearusermenu()
	dw_role_list.reset()
	of_setmessage('$$HEX25$$74d5f9b22000dcc2a4c25cd144c72000acc0a9c660d5200018c2200088c794b220008cad5cd574c72000c6c5b5c2c8b2e4b2$$ENDHEX$$')
	//messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX25$$74d5f9b22000dcc2a4c25cd144c72000acc0a9c660d5200018c2200088c794b220008cad5cd574c72000c6c5b5c2c8b2e4b2$$ENDHEX$$')
	return
end if

of_set_user_menu()
dw_role_list.reset()
dw_role_list.retrieve(gnv_session.is_sys_id, gnv_session.of_getstring('login_dt'), &
			inv_user_role.is_memb_code[1], inv_user_role.is_memb_code[2], inv_user_role.is_memb_code[3], inv_user_role.is_memb_code[4], &
			inv_user_role.is_memb_code[5], inv_user_role.is_memb_code[6], inv_user_role.is_memb_code[7], inv_user_role.is_memb_code[8])

end event

type p_search from pf_u_imagebutton within tabpage_1
integer x = 1266
integer y = 16
integer width = 233
integer height = 88
string picturename = "..\img\controls\u_imagebutton\topBtn_search.gif"
end type

event clicked;call super::clicked;if dw_user_list_cond.accepttext() = -1 then return

string ls_code, ls_name

ls_code = dw_user_list_cond.getitemstring(1, 'code')
ls_name = dw_user_list_cond.getitemstring(1, 'name')

if isnull(ls_code) or len(trim(ls_code)) = 0 then
	ls_code = '%'
else
	ls_code = '%' + ls_code + '%'
end if

if isnull(ls_name) or len(trim(ls_name)) = 0 then
	ls_name = '%'
else
	ls_name = '%' + ls_name + '%'
end if

//if ls_code = '%' and ls_name = '%' then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX3$$acc0a9c690c7$$ENDHEX$$ID $$HEX14$$10b694b22000acc0a9c690c785ba44c7200085c725b858d538c194c6$$ENDHEX$$')
//	return
//end if

dw_user_list.retrieve(ls_code, ls_name)
return

end event

type dw_user_list_cond from pf_u_datawindow within tabpage_1
integer x = 18
integer y = 120
integer width = 1490
integer height = 164
integer taborder = 20
string dataobject = "pf_d_role_search_01"
boolean issearchcondition = true
end type

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'code', 'name'
		p_search.post event clicked()
end choose

return 0

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4462
integer height = 1936
string text = " $$HEX10$$04d55cb8f8ada8b7c4bc20008cad5cd570c88cd6$$ENDHEX$$"
long tabtextcolor = 25123896
long tabbackcolor = 1073741824
string picturename = "..\img\commonuse\front_title_img.gif"
long picturemaskcolor = 536870912
dw_pgm_user dw_pgm_user
dw_pgm_role dw_pgm_role
tv_fullmenu tv_fullmenu
st_5 st_5
st_4 st_4
p_5 p_5
p_4 p_4
p_3 p_3
st_3 st_3
end type

on tabpage_2.create
this.dw_pgm_user=create dw_pgm_user
this.dw_pgm_role=create dw_pgm_role
this.tv_fullmenu=create tv_fullmenu
this.st_5=create st_5
this.st_4=create st_4
this.p_5=create p_5
this.p_4=create p_4
this.p_3=create p_3
this.st_3=create st_3
this.Control[]={this.dw_pgm_user,&
this.dw_pgm_role,&
this.tv_fullmenu,&
this.st_5,&
this.st_4,&
this.p_5,&
this.p_4,&
this.p_3,&
this.st_3}
end on

on tabpage_2.destroy
destroy(this.dw_pgm_user)
destroy(this.dw_pgm_role)
destroy(this.tv_fullmenu)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.p_5)
destroy(this.p_4)
destroy(this.p_3)
destroy(this.st_3)
end on

type dw_pgm_user from pf_u_datawindow within tabpage_2
integer x = 3141
integer y = 112
integer width = 1307
integer height = 1808
integer taborder = 10
string dataobject = "pf_d_role_search_06"
boolean hscrollbar = true
boolean vscrollbar = true
boolean scaletoright = true
boolean scaletobottom = true
end type

type dw_pgm_role from pf_u_datawindow within tabpage_2
integer x = 1527
integer y = 112
integer width = 1595
integer height = 1808
integer taborder = 30
string dataobject = "pf_d_role_search_05"
boolean hscrollbar = true
boolean vscrollbar = true
boolean scaletobottom = true
end type

event rowfocuschanged;this.selectrow(0, false)
this.selectrow(currentrow, true)

if currentrow = 0 then return

string ls_role_no

ls_role_no = this.getitemstring(currentrow, 'role_no')

dw_pgm_user.reset()
dw_pgm_user.retrieve(gnv_session.is_sys_id, ls_role_no)

end event

type tv_fullmenu from pf_u_treeview within tabpage_2
integer x = 18
integer y = 112
integer width = 1490
integer height = 1808
integer taborder = 30
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 20132659
string picturename[] = {"Application5!","ApplicationIcon!","Custom039!","Open!"}
long picturemaskcolor = 12632256
boolean scaletobottom = true
end type

event selectionchanged;treeviewitem ltvi_item
string ls_menu_id

if this.getitem(newhandle, ltvi_item) > 0 then
	ls_menu_id = ltvi_item.data

	dw_pgm_role.reset()
	dw_pgm_role.retrieve(gnv_session.is_sys_id, ls_menu_id)
end if

end event

type st_5 from statictext within tabpage_2
integer x = 3227
integer y = 36
integer width = 466
integer height = 56
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 25123896
string text = "$$HEX8$$acc0a9c620008cad5cd5200064ba84bc$$ENDHEX$$"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_2
integer x = 1531
integer y = 36
integer width = 402
integer height = 56
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 25123896
string text = "$$HEX5$$acc0a9c620008cad5cd5$$ENDHEX$$"
boolean focusrectangle = false
end type

type p_5 from picture within tabpage_2
integer x = 3163
integer y = 44
integer width = 46
integer height = 40
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type p_4 from picture within tabpage_2
integer x = 1467
integer y = 44
integer width = 46
integer height = 40
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type p_3 from picture within tabpage_2
integer x = 18
integer y = 44
integer width = 46
integer height = 40
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_2
integer x = 78
integer y = 36
integer width = 549
integer height = 56
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 25123896
string text = "$$HEX10$$04c8b4cc200004d55cb8f8ada8b7200054ba74b2$$ENDHEX$$"
boolean focusrectangle = false
end type

type p_close from pf_u_imagebutton within pf_w_role_info_ret
integer x = 4311
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)

end event

type uo_1 from pf_u_tab within pf_w_role_info_ret
integer x = 343
integer y = 32
integer taborder = 20
boolean bringtotop = true
boolean scaletoright = true
boolean scaletobottom = true
string referencedtab = "tab_1"
end type

on uo_1.destroy
call pf_u_tab::destroy
end on

