$PBExportHeader$pf_w_pgm_mst_ent.srw
$PBExportComments$프로그램 기본정보를 관리하는 프로그램 입니다.
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
string title = "프로그램 정보관리"
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
		
		// 폴더면 하위 아이템 이동
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
		
		// 폴더면 하위 아이템 이동
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

// pf_pgm_mst 테이블 parent_menu 수정
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
//	messagebox('알림', '프로그램 정보 저장 오류!!~r~n' + sqlca.sqlerrtext)
//	return
//end if

// pf_pgm_mst 테이블 sort_order 수정
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
//		messagebox('알림', '프로그램 정보 저장 오류(Sort_Order)!!~r~n' + sqlca.sqlerrtext)
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

event begindrag;call super::begindrag;// 드래그될 아이템과 그 부모아이템을 보관 합니다
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

// 메뉴 변경 사용자 확인
if this.getitem(il_DragParent, ltvi_Parent) = -1 then
	ltvi_Parent.Label = 'ROOT'
end if

if messagebox('메뉴 변경', ltvi_Parent.Label + '의 [' + ltvi_Source.Label + '] 메뉴를 ' + ltvi_Target.Label + ' 하위로 이동하시겠습니까?', Question!, YesNo!, 2) = 2 then
	SetDropHighlight(0)
	il_DropTarget = 0
	return
end if

// 타겟메뉴 펼침
if ltvi_Target.expanded = false then
	this.expanditem(il_DropTarget)
end if

// 신규 메뉴 생성
SetNull(ltvi_Source.ItemHandle)
ll_newitem = this.InsertItemFirst(il_DropTarget, ltvi_source)
this.getitem(ll_newitem, ltvi_newitem)

// 하위 메뉴 이동
this.of_movechildren(il_DragSource, ll_NewItem)

// 기존 메뉴 삭제
this.deleteitem(il_DragSource)

// 하이라이트 취소
this.SetDropHighlight(0)

// pf_pgm_mst 테이블 parent_menu 수정
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

// 하위 아이템 treelevel 수정
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

// pf_pgm_mst 테이블 sort_order 수정
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

// 옮겨진 메뉴 선택
this.SelectItem(ll_NewItem)

end event

event dragwithin;call super::dragwithin;long ll_Parent
TreeViewItem ltvi_Over

// 부모 노드는 선택 안 함
if handle = il_DragParent then return

If GetItem(handle, ltvi_Over) = -1 Then
	SetDropHighlight(0)
	il_DropTarget = 0
	Return
End If

// 타겟은 폴더만 선택 가능
if ltvi_Over.PictureIndex < 3 then
	SetDropHighlight(0)
	il_DropTarget = 0
	return
end if

// 타겟과 소스가 동일
if il_DragSource = handle then 
	SetDropHighlight(0)
	il_DropTarget = 0
	return
end if

// 폴더는 자신의 하위 노드로 이동 불가
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

// MouseOver 하이라이트 처리
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
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "전체 프로그램 메뉴"
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
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "프로그램  상세"
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

event clicked;call super::clicked;// 저장
if dw_pgm.accepttext() = -1 then return
if dw_pgm.rowcount() = 0 then return

// 필수입력사항
string ls_pgm_kind_code
string ls_pgm_id

ls_pgm_kind_code = dw_pgm.getitemstring(1, 'pgm_kind_code')
if isnull(ls_pgm_kind_code) or len(trim(ls_pgm_kind_code)) = 0 then
	messagebox('알림', '폴더/프로그램 구분을 입력하세요')
	return 0
end if

if ls_pgm_kind_code = 'P' then
	ls_pgm_id = dw_pgm.getitemstring(1, 'pgm_id')
	if isnull(ls_pgm_id) or len(trim(ls_pgm_id)) = 0 then
		messagebox('알림', '프로그램ID 를 입력하세요')
		return 0
	end if
end if

string ls_pgm_name
ls_pgm_name = dw_pgm.getitemstring(1, 'pgm_name')
if isnull(ls_pgm_name) or len(trim(ls_pgm_name)) = 0 then
	messagebox('알림', '프로그램 명칭을 입력하세요')
	return 0
end if

string ls_parent_menu
ls_parent_menu = dw_pgm.getitemstring(1, 'parent_menu')
if isnull(ls_parent_menu) or len(trim(ls_parent_menu)) = 0 then
	messagebox('알림', '먼저 상위메뉴를 선택 하세요')
	return 0
end if

// Primary Key 생성
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
	
	// TreeView Item 생성
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

	// 신규등록된 프로그램은 관리자 권한에 자동 등록
	ls_io_type = dw_pgm.getitemstring(1, 'io_type')
	
	// 기본버튼 설정 프로그램 타입에 따라 자동 설정
	choose case ls_io_type
		case 'Q'	// 조회
			ls_comm_btn_auth_yn = 'Y'
			ls_retrieve_auth_yn = 'Y'
			ls_input_auth_yn = 'N'
			ls_delete_auth_yn = 'N'
			ls_update_auth_yn = 'N'
			ls_print_auth_yn = 'N'
			ls_execute_auth_yn = 'N'
			ls_cancel_auth_yn = 'Y'
			ls_excel_auth_yn = 'N'
		case 'P'	// 출력
			ls_comm_btn_auth_yn = 'Y'
			ls_retrieve_auth_yn = 'Y'
			ls_input_auth_yn = 'N'
			ls_delete_auth_yn = 'N'
			ls_update_auth_yn = 'N'
			ls_print_auth_yn = 'Y'
			ls_execute_auth_yn = 'N'
			ls_cancel_auth_yn = 'Y'
			ls_excel_auth_yn = 'N'
		case 'M'	// 입력
			ls_comm_btn_auth_yn = 'Y'
			ls_retrieve_auth_yn = 'Y'
			ls_input_auth_yn = 'Y'
			ls_delete_auth_yn = 'Y'
			ls_update_auth_yn = 'Y'
			ls_print_auth_yn = 'N'
			ls_execute_auth_yn = 'N'
			ls_cancel_auth_yn = 'Y'
			ls_excel_auth_yn = 'N'
		case 'B'	// 배치
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
			messagebox('알림', '프로그램 기본정보 저장 실패~r~nSQLCODE: ' + string(sqlca.sqldbcode) + '~r~nSQLERRTEXT: ' + sqlca.sqlerrtext)
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

// menu_id 가 변경된 경우 관련된 테이블을 모두 수정해 줍니다
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

// 저장
string ls_errmsg

if dw_pgm.update() = 1 then
	commit using sqlca;
	of_setmessage("자료 저장 완료!!")
else
	ls_errmsg = sqlca.sqlerrtext
	rollback using sqlca;
	messagebox('알림', '자료 저장 실패했습니다!!~r~n' + ls_errmsg)
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

event clicked;call super::clicked;// 삭제
string ls_menu_id, ls_pgm_name
long ll_child_cnt

if dw_pgm.rowcount() = 0 then return

choose case dw_pgm.getitemstatus(1, 0, primary!)
	case new!, newmodified!
		if messagebox('알림', '현재 편집중인 내용을 삭제하시겠습니까?', Question!, YesNo!, 2) = 1 then
			dw_pgm.deleterow(1)
		end if
	case else
		ls_menu_id = dw_pgm.getitemstring(1, 'menu_id')
		ls_pgm_name = dw_pgm.getitemstring(1, 'pgm_name')
		
		if not isvalid(itvi_item) then
			messagebox('알림', '현재 선택된 항목이 없습니다')
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
				messagebox('알림', '하위 항목이 존재하기 때문에 삭제할 수 없습니다.~r~n먼저 하위 항목을 삭제해 주세요.')
				return
			end if
		end if
		
		if messagebox('알림', '선택하신 ' + ls_pgm_name + '[' + ls_menu_id + '] 항목을 삭제하시겠습니까?', Question!, YesNo!, 2) = 1 then
			dw_pgm.deleterow(1)
			tv_fullmenu.post deleteitem(il_handle)
			if dw_pgm.update() = 1 then
				// 삭제된 프로그램과 연계된 정보를 삭제합니다.
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
				of_setmessage("자료 삭제 완료!!")
			else
				string ls_errmsg
				ls_errmsg = sqlca.sqlerrtext
				rollback using sqlca;
				messagebox('알림', '자료 삭제 실패했습니다!!~r~n' + ls_errmsg)
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

event clicked;call super::clicked;// 항목추가
long ll_sort_order
string ls_parent_menu, ls_parent_name

dw_pgm.reset()
dw_pgm.insertrow(0)

if isvalid(itvi_parent) then
	ls_parent_menu = string(itvi_parent.data)
	ls_parent_name = itvi_parent.label
	
	if isnull(ls_parent_menu) or len(trim(ls_parent_menu)) = 0 then
		messagebox('알림', '먼저 상위 폴더를 선택하세요')
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
			messagebox('알림', '입력하신 메뉴 ID [' + ls_menu_id + '] 는 기 존재하는 번호 입니다.')
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
string text = "권한할당"
boolean fixedtoright = true
end type

event clicked;call super::clicked;string ls_menu_id

ls_menu_id = dw_pgm.getitemstring(1, 'menu_id')
if isnull(ls_menu_id) or len(ls_menu_id) = 0 then
	messagebox('알림', '먼저 프로그램 정보를 저장하세요')
	return
end if

openwithparm(pf_w_pgm_mst_role_pgm, ls_menu_id)

end event

type cbx_expand from pf_u_checkbox within pf_w_pgm_mst_ent
integer x = 809
integer y = 148
integer width = 320
boolean bringtotop = true
string text = "열린 메뉴"
boolean checked = true
end type

