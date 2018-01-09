$PBExportHeader$pf_w_role_mst_ent_v1.srw
$PBExportComments$권한별로 멤버를 및 사용 가능한 프로그램을 할당하는 프로그램 입니다.
forward
global type pf_w_role_mst_ent_v1 from pf_w_sheet
end type
type st_1 from pf_u_statictext within pf_w_role_mst_ent_v1
end type
type p_2 from pf_u_picture within pf_w_role_mst_ent_v1
end type
type dw_role_mst from pf_u_datawindow within pf_w_role_mst_ent_v1
end type
type p_role_add from pf_u_imagebutton within pf_w_role_mst_ent_v1
end type
type p_role_modify from pf_u_imagebutton within pf_w_role_mst_ent_v1
end type
type p_role_delete from pf_u_imagebutton within pf_w_role_mst_ent_v1
end type
type p_close from pf_u_imagebutton within pf_w_role_mst_ent_v1
end type
type p_1 from pf_u_picture within pf_w_role_mst_ent_v1
end type
type st_2 from pf_u_statictext within pf_w_role_mst_ent_v1
end type
type dw_role_memb from pf_u_datawindow within pf_w_role_mst_ent_v1
end type
type tv_pgm from pf_u_treeview within pf_w_role_mst_ent_v1
end type
type st_3 from pf_u_statictext within pf_w_role_mst_ent_v1
end type
type p_3 from pf_u_picture within pf_w_role_mst_ent_v1
end type
type p_memb_add from pf_u_imagebutton within pf_w_role_mst_ent_v1
end type
type p_memb_delete from pf_u_imagebutton within pf_w_role_mst_ent_v1
end type
type p_memb_update from pf_u_imagebutton within pf_w_role_mst_ent_v1
end type
type cbx_hierachy from pf_u_checkbox within pf_w_role_mst_ent_v1
end type
type cb_1 from pf_u_commandbutton within pf_w_role_mst_ent_v1
end type
type st_4 from pf_u_splitbar_vertical within pf_w_role_mst_ent_v1
end type
type cbx_expand from pf_u_checkbox within pf_w_role_mst_ent_v1
end type
end forward

global type pf_w_role_mst_ent_v1 from pf_w_sheet
integer height = 2368
event ue_menu_notify ( string as_menu_name )
st_1 st_1
p_2 p_2
dw_role_mst dw_role_mst
p_role_add p_role_add
p_role_modify p_role_modify
p_role_delete p_role_delete
p_close p_close
p_1 p_1
st_2 st_2
dw_role_memb dw_role_memb
tv_pgm tv_pgm
st_3 st_3
p_3 p_3
p_memb_add p_memb_add
p_memb_delete p_memb_delete
p_memb_update p_memb_update
cbx_hierachy cbx_hierachy
cb_1 cb_1
st_4 st_4
cbx_expand cbx_expand
end type
global pf_w_role_mst_ent_v1 pf_w_role_mst_ent_v1

type variables
datastore ids_menu
datastore ids_role_pgm
datastore ids_role_cat

long il_current_handle
string	is_current_role_no
string is_current_role_name
string is_logging_yn = 'N'

pf_m_pgm_mst im_treemenu

end variables

forward prototypes
public function integer of_set_title_role_memb ()
public function integer of_set_popup_dddw_data ()
public function long of_retrieve_treeview (string as_role_no)
public function integer of_getbuttonlist (string as_pgm_id, ref windowobject awo_button[])
public function long of_getwindowcontrols (windowobject awo_input[], ref windowobject awo_output[])
public function integer of_add_role_pgm (string as_role_no, string as_menu_id)
public function long of_delete_role_pgm (string as_role_no, string as_menu_id)
public function integer of_set_role_memb_name (string as_column, long al_row)
public subroutine of_set_status_tvi_checkbox (treeviewitem atvi_item, boolean ab_switch)
public function boolean of_get_status_tvi_checkbox (treeviewitem atvi_item)
end prototypes

event ue_menu_notify(string as_menu_name);if il_current_handle <= 0 then return

choose case as_menu_name
	// Expand TreeViewItem
	case 'm_expand'
		tv_pgm.ExpandAll(il_current_handle)
		tv_pgm.SetFirstVisible(il_current_handle)

	// Collapse TreeVewItem
	case 'm_collapse'
		tv_pgm.CollapseItem(il_current_handle)
end choose

return

end event

public function integer of_set_title_role_memb ();integer i, j, il_role_cat_no
boolean lb_role_cat_yn[8]
string ls_modify, ls_search_type
string ls_role_cat_no, ls_role_cat_name
string ls_code_list_dwo, ls_code_list_sql

string ls_datacolumn, ls_displaycolumn
pf_n_datastore lds_temp
datawindowchild ldwc_1
long ll_rowcnt

lds_temp = create pf_n_datastore
lds_temp.settransobject(sqlca)

// modify header title
for i = 1 to ids_role_cat.rowcount()
	ls_role_cat_no = ids_role_cat.getitemstring(i, 'role_cat_no')
	il_role_cat_no = integer(ls_role_cat_no)
	lb_role_cat_yn[il_role_cat_no] = true
	ls_role_cat_name = ids_role_cat.getitemstring(i, 'role_cat_name')
	ls_search_type = ids_role_cat.getitemstring(i, 'search_type')
	ls_code_list_dwo = ids_role_cat.getitemstring(i, 'code_list_dwo')
	ls_code_list_sql = ids_role_cat.getitemstring(i, 'code_list_sql')
	
	ls_modify += "memb_code" + string(il_role_cat_no) + "_t.text='" + ls_role_cat_name + "'~r~n"
	
	if not pf_f_isemptystring(ls_code_list_dwo) then
		ls_modify += "memb_code" + string(il_role_cat_no) + ".tag='dwo:" + ls_code_list_dwo + "'~r~n"
	elseif not pf_f_isemptystring(ls_code_list_sql) then
		ls_modify += "memb_code" + string(il_role_cat_no) + ".tag='sql:" + pf_f_replaceall(ls_code_list_sql, "'", "~~'") + "'~r~n"
	else
		messagebox('알림', '권한 유형정보가 올바르게 설정되지 않았습니다')
		return -1
	end if
	
	choose case ls_search_type
		case 'popup'
			ls_modify += "memb_code" + string(il_role_cat_no) + ".tabsequence='0'~r~n"
		case 'dddw'
			if not pf_f_isemptystring(ls_code_list_dwo) then
				lds_temp.dataobject = ls_code_list_dwo
				ls_datacolumn = lds_temp.describe("#1.Name")
				ls_displaycolumn = lds_temp.describe("#2.Name")
				
				ls_modify += "memb_code" + string(il_role_cat_no) + ".dddw.Name='" + ls_code_list_dwo + "'~r~n"
				ls_modify += "memb_code" + string(il_role_cat_no) + ".dddw.DataColumn='" + ls_datacolumn + "'~r~n"
				ls_modify += "memb_code" + string(il_role_cat_no) + ".dddw.DisplayColumn='" + ls_displaycolumn + "'~r~n"
			elseif not pf_f_isemptystring(ls_code_list_sql) then
				if dw_role_memb.getchild("memb_code" + string(il_role_cat_no), ldwc_1) = 1 then
					ll_rowcnt = lds_temp.of_retrievefromsql(ls_code_list_sql)
					for j = 1 to ll_rowcnt
						ldwc_1.insertrow(j)
						ldwc_1.setitem(j, 1, lds_temp.getitemstring(j, 1))
						ldwc_1.setitem(j, 2, lds_temp.getitemstring(j, 2))
					next
				end if
			end if
	end choose
next

// hide unused columns
for i = 1 to upperbound(lb_role_cat_yn)
	if lb_role_cat_yn[i] = false then
		ls_modify += 'memb_code' + string(i) + '_t.visible="0"~r~n'
		ls_modify += 'memb_code' + string(i) + '.visible="0"~r~n'
	end if
next

// do moidfy
string ls_error

ls_error = dw_role_memb.Modify(ls_modify)
if len(ls_error) > 0 then
	::clipboard(dw_role_memb.classname() + "~r~n" + ls_modify)
	messagebox("Error", dw_role_memb.classname() + " Syntax Modification Failure!! : " + ls_error)
	return -1
end if

dw_role_memb.event pfe_dwowidthchanged()

// remove header of dddw columns
for i = 1 to ids_role_cat.rowcount()
	ls_role_cat_no = ids_role_cat.getitemstring(i, 'role_cat_no')
	il_role_cat_no = integer(ls_role_cat_no)
	ls_search_type = ids_role_cat.getitemstring(i, 'search_type')
	
	if ls_search_type = 'dddw' then
		if dw_role_memb.getchild("memb_code" + string(il_role_cat_no), ldwc_1) = 1 then
			ldwc_1.insertrow(1)
			ldwc_1.setitem(1, 1, '')
			ldwc_1.setitem(1, 2, "All")
			ldwc_1.modify("Datawindow.Header.Height=0")
		end if
	end if
next

return 1

end function

public function integer of_set_popup_dddw_data ();integer i, j, il_role_cat_no
string ls_search_type, ls_role_cat_no
string ls_code, ls_name
long ll_new
datawindowchild ldwc_1

dw_role_memb.setredraw(false)

for i = 1 to ids_role_cat.rowcount()
	ls_role_cat_no = ids_role_cat.getitemstring(i, 'role_cat_no')
	il_role_cat_no = integer(ls_role_cat_no)
	ls_search_type = ids_role_cat.getitemstring(i, 'search_type')
	
	if ls_search_type = 'popup' then
		if dw_role_memb.getchild("memb_code" + string(il_role_cat_no), ldwc_1) = 1 then
			ldwc_1.reset()
			ldwc_1.insertrow(1)
			ldwc_1.setitem(1, 1, '')
			ldwc_1.setitem(1, 2, 'All')
			
			for j = 1 to dw_role_memb.rowcount()
				ls_code = dw_role_memb.getitemstring(j, 'memb_code' + string(il_role_cat_no))
				ls_name = dw_role_memb.getitemstring(j, 'memb_name' + string(il_role_cat_no))
				if not isnull(ls_code) and ls_code <> '' then
					ll_new = ldwc_1.insertrow(0)
					ldwc_1.setitem(ll_new, 1, ls_code)
					ldwc_1.setitem(ll_new, 2, ls_name)
				end if
			next
		end if
	end if
next

dw_role_memb.setredraw(true)
return 1

end function

public function long of_retrieve_treeview (string as_role_no);long ll_rowcnt, ll_handle, i, ll_roothndl
treeviewitem ltvi_item
long ll_level, ll_parent[]

tv_pgm.setredraw(false)

ll_handle = tv_pgm.finditem(roottreeitem!, 0)
do while ll_handle > 0
	tv_pgm.deleteitem(ll_handle)
	ll_handle = tv_pgm.finditem(roottreeitem!, ll_handle)
loop

ll_rowcnt = ids_menu.retrieve(gnv_session.is_sys_id, as_role_no, 'ROOT')
ll_parent[1] = 0

for i = 1 to ll_rowcnt
	ltvi_item.data = ids_menu.getitemstring(i, 'menu_id')
	ltvi_item.label = ids_menu.getitemstring(i, 'pgm_name')
	
	choose case ids_menu.getitemstring(i, 'pgm_kind_code')
		case 'M'
			ltvi_item.PictureIndex = 3
			ltvi_item.SelectedPictureIndex = 4
		case 'P'
			ltvi_item.PictureIndex = 1
			ltvi_item.SelectedPictureIndex = 2
	end choose
	
	if ids_menu.getitemnumber(i, 'child_cnt') > 0 then
		ltvi_item.Children = true
	else
		ltvi_item.Children = false
	end if
	
	ltvi_item.HasFocus = false
	ltvi_item.selected = false
	
	if ids_menu.getitemstring(i, 'pgm_chk') = 'Y' then
		ltvi_item.statepictureindex = 2
	else
		ltvi_item.statepictureindex = 1
	end if
	
	ll_level = ids_menu.getitemnumber(i, 'tree_level')
	ll_handle = tv_pgm.InsertItemLast(ll_parent[ll_level], ltvi_item)
	if ids_menu.getitemstring(i, 'pgm_kind_code') = 'M' then
		ll_parent[ll_level + 1] = ll_handle
	end if
next

ll_handle = tv_pgm.finditem(roottreeitem!, 0)
ll_roothndl = ll_handle
do while ll_handle > 0
	if cbx_expand.checked = true then
		tv_pgm.expandall(ll_handle)
	else
		tv_pgm.expanditem(ll_handle)
	end if
	ll_handle = tv_pgm.finditem(NextTreeItem!, ll_handle)
loop

// scroll back to top
tv_pgm.SetFirstVisible(ll_roothndl)

tv_pgm.setredraw(true)
return ll_rowcnt

end function

public function integer of_getbuttonlist (string as_pgm_id, ref windowobject awo_button[]);window lw_window
lw_window = create using as_pgm_id
if isnull(lw_window) then return -1
if not isvalid(lw_window) then return -1

long i, ll_objcnt, ll_btncnt
windowobject lw_object[]
ll_objcnt = of_getwindowcontrols(lw_window.control[], lw_object[])

for i = 1 to ll_objcnt
	choose case lw_object[i].typeof()
		case commandbutton!, picturebutton!
			ll_btncnt ++
			awo_button[ll_btncnt] = lw_object[i]
		case picture!
			picture lp_object
			lp_object = lw_object[i]
			if lp_object.triggerevent('pfe_ispowerframecontrol') = 1 then
				if lp_object.dynamic of_getclassname() = 'pf_u_imagebutton' then
					ll_btncnt ++
					awo_button[ll_btncnt] = lw_object[i]
				end if
			end if
	end choose
next

return ll_btncnt

end function

public function long of_getwindowcontrols (windowobject awo_input[], ref windowobject awo_output[]);long ll_Input, ll_InputCount, ll_OutputCount, ll_Sub, ll_SubCount
userobject luo_UserObject
tab ltb_Tab
windowobject lwo_Empty[], lwo_Sub[]

awo_Output = lwo_Empty

ll_InputCount = UpperBound (awo_Input)
FOR ll_Input = 1 TO ll_InputCount
    ll_OutputCount ++
    awo_Output[ll_OutputCount] = awo_Input[ll_Input]

    CHOOSE CASE awo_Input[ll_Input].TypeOf()
        CASE UserObject!
            luo_UserObject = awo_Input[ll_Input]
            ll_SubCount = of_getwindowcontrols (luo_UserObject.Control, lwo_Sub)
            FOR ll_Sub = 1 TO ll_SubCount
                ll_OutputCount ++
                awo_Output[ll_OutputCount] = lwo_Sub[ll_Sub]
            NEXT

        CASE Tab!
            ltb_Tab = awo_Input[ll_Input]
            ll_SubCount = of_getwindowcontrols (ltb_Tab.Control, lwo_Sub)
            FOR ll_Sub = 1 TO ll_SubCount
                ll_OutputCount ++
                awo_Output[ll_OutputCount] = lwo_Sub[ll_Sub]
            NEXT
    END CHOOSE
NEXT

RETURN ll_OutputCount

end function

public function integer of_add_role_pgm (string as_role_no, string as_menu_id);long ll_find

ll_find = ids_role_pgm.find('pf_pgm_mst_menu_id="' + as_menu_id + '"', 1, ids_role_pgm.rowcount())
if ll_find > 0 then
	ids_role_pgm.setitem(ll_find, 'sys_id', gnv_session.is_sys_id)
	ids_role_pgm.setitem(ll_find, 'role_no', as_role_no)
	ids_role_pgm.setitem(ll_find, 'menu_id', as_menu_id)
end if

return ll_find

end function

public function long of_delete_role_pgm (string as_role_no, string as_menu_id);long ll_find

ll_find = ids_role_pgm.find("role_no = '" + as_role_no + "' and menu_id = '"  + as_menu_id + "'", 1, ids_role_pgm.rowcount())
if ll_find > 0 then
	ids_role_pgm.setitem(ll_find, 'sys_id', '')
	ids_role_pgm.setitem(ll_find, 'role_no', '')
	ids_role_pgm.setitem(ll_find, 'menu_id', '')
end if

return ll_find

end function

public function integer of_set_role_memb_name (string as_column, long al_row);string ls_name

ls_name = dw_role_memb.Describe("Evaluate('LookUpDisplay(" + as_column + ")'," + string(al_row) + ")")
dw_role_memb.setitem(al_row, 'memb_name' + mid(as_column, 10), ls_name)
return 1

end function

public subroutine of_set_status_tvi_checkbox (treeviewitem atvi_item, boolean ab_switch);// 트리뷰 아이템의 체크박스 선택 여부 설정 합니다.
if not isvalid(atvi_item) then return

choose case ab_switch
	case false
		atvi_item.statepictureindex = 1
	case true
		atvi_item.statepictureindex = 2
end choose

end subroutine

public function boolean of_get_status_tvi_checkbox (treeviewitem atvi_item);// 트리뷰 아이템의 체크박스 선택 여부를 리턴 합니다.
if not isvalid(atvi_item) then return false

boolean lb_rv

choose case atvi_item.statepictureindex
	// check box is not choosed
	case 0, 1
		lb_rv = false
	// check box is choosed
	case 2
		lb_rv = true
end choose

return lb_rv

end function

on pf_w_role_mst_ent_v1.create
int iCurrent
call super::create
this.st_1=create st_1
this.p_2=create p_2
this.dw_role_mst=create dw_role_mst
this.p_role_add=create p_role_add
this.p_role_modify=create p_role_modify
this.p_role_delete=create p_role_delete
this.p_close=create p_close
this.p_1=create p_1
this.st_2=create st_2
this.dw_role_memb=create dw_role_memb
this.tv_pgm=create tv_pgm
this.st_3=create st_3
this.p_3=create p_3
this.p_memb_add=create p_memb_add
this.p_memb_delete=create p_memb_delete
this.p_memb_update=create p_memb_update
this.cbx_hierachy=create cbx_hierachy
this.cb_1=create cb_1
this.st_4=create st_4
this.cbx_expand=create cbx_expand
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_2
this.Control[iCurrent+3]=this.dw_role_mst
this.Control[iCurrent+4]=this.p_role_add
this.Control[iCurrent+5]=this.p_role_modify
this.Control[iCurrent+6]=this.p_role_delete
this.Control[iCurrent+7]=this.p_close
this.Control[iCurrent+8]=this.p_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.dw_role_memb
this.Control[iCurrent+11]=this.tv_pgm
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.p_3
this.Control[iCurrent+14]=this.p_memb_add
this.Control[iCurrent+15]=this.p_memb_delete
this.Control[iCurrent+16]=this.p_memb_update
this.Control[iCurrent+17]=this.cbx_hierachy
this.Control[iCurrent+18]=this.cb_1
this.Control[iCurrent+19]=this.st_4
this.Control[iCurrent+20]=this.cbx_expand
end on

on pf_w_role_mst_ent_v1.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_2)
destroy(this.dw_role_mst)
destroy(this.p_role_add)
destroy(this.p_role_modify)
destroy(this.p_role_delete)
destroy(this.p_close)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.dw_role_memb)
destroy(this.tv_pgm)
destroy(this.st_3)
destroy(this.p_3)
destroy(this.p_memb_add)
destroy(this.p_memb_delete)
destroy(this.p_memb_update)
destroy(this.cbx_hierachy)
destroy(this.cb_1)
destroy(this.st_4)
destroy(this.cbx_expand)
end on

event open;call super::open;ids_menu = create datastore

choose case upper(left(sqlca.dbms, 3))
	// Oracle
	case 'O80', 'O90', 'O10', 'ORA'
		ids_menu.dataobject = 'pf_d_role_mst_03_oracle'
	// Unknown
	case else
		ids_menu.dataobject = 'pf_d_role_mst_03_asa'
end choose

ids_menu.settransobject(sqlca)

ids_role_cat = create datastore
ids_role_cat.dataobject = 'pf_d_role_cat_mst'
ids_role_cat.settransobject(sqlca)

ids_role_pgm = create datastore
ids_role_pgm.dataobject = 'pf_d_role_mst_04'
ids_role_pgm.settransobject(sqlca)

dw_role_mst.settransobject(sqlca)
dw_role_memb.settransobject(sqlca)
//dw_role_pgm.settransobject(sqlca)
//dw_pgm_btn.settransobject(sqlca)

// create popup menu
im_treemenu = create pf_m_pgm_mst
im_treemenu.m_add.visible = false
im_treemenu.m_delete.visible = false
im_treemenu.m_0.visible = false
im_treemenu.m_upper.visible = false
im_treemenu.m_lower.visible = false
im_treemenu.m_1.visible = false

end event

event close;call super::close;destroy ids_menu
destroy ids_role_cat
destroy ids_role_pgm

end event

event pfe_postopen;call super::pfe_postopen;is_logging_yn = gnv_appconf.of_getprofile("pip.logging", "N")

ids_role_cat.retrieve(gnv_session.is_sys_id)
this.of_set_title_role_memb()

dw_role_mst.retrieve(gnv_session.is_sys_id)
//ids_role_pgm.sharedata(dw_role_pgm)

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_role_mst_ent_v1
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_role_mst_ent_v1
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_role_mst_ent_v1
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_role_mst_ent_v1
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_role_mst_ent_v1
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_role_mst_ent_v1
end type

type st_1 from pf_u_statictext within pf_w_role_mst_ent_v1
integer x = 114
integer y = 172
integer width = 425
integer height = 48
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = hangeul!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "권한 리스트"
end type

type p_2 from pf_u_picture within pf_w_role_mst_ent_v1
integer x = 55
integer y = 176
integer width = 46
integer height = 40
boolean bringtotop = true
string picturename = "..\img\commonuse\front_title_img.gif"
end type

type dw_role_mst from pf_u_datawindow within pf_w_role_mst_ent_v1
integer x = 50
integer y = 236
integer width = 2597
integer height = 1036
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_role_mst_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean useborder = false
boolean scaletoright = true
boolean scaletobottom = true
end type

event rowfocuschanged;call super::rowfocuschanged;if currentrow = 0 then
	is_current_role_no = ''
	is_current_role_name = ''
	return
end if

is_current_role_no = this.getitemstring(currentrow, 'role_no')
is_current_role_name = this.getitemstring(currentrow, 'role_name')

dw_role_memb.retrieve(gnv_session.is_sys_id, is_current_role_no)
parent.of_set_popup_dddw_data()

ids_role_pgm.retrieve(gnv_session.is_sys_id, is_current_role_no)
parent.of_retrieve_treeview(is_current_role_no)

this.selectrow(0, false)
this.selectrow(currentrow, true)

end event

type p_role_add from pf_u_imagebutton within pf_w_role_mst_ent_v1
integer x = 3346
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;OpenWithParm(pf_w_role_mst_modify, '추가')
if left(message.stringparm,2) = 'OK' then
	string ls_retval, ls_parm[]
	long ll_new
	
	ls_retval = mid(message.stringparm, 4)
	pf_f_parsetoarray(ls_retval, '~t', ls_parm[])
	
	ll_new = dw_role_mst.insertrow(0)
	dw_role_mst.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
	dw_role_mst.setitem(ll_new, 'role_no', ls_parm[1])
	dw_role_mst.setitem(ll_new, 'role_name', ls_parm[2])
	dw_role_mst.setitem(ll_new, 'role_desc', ls_parm[3])
	dw_role_mst.setitemstatus(ll_new, 0, primary!, notmodified!)
	dw_role_mst.scrolltorow(ll_new)
	dw_role_mst.setrow(ll_new)

	//dw_role_mst.retrieve(gnv_session.is_sys_id)
end if
end event

type p_role_modify from pf_u_imagebutton within pf_w_role_mst_ent_v1
integer x = 3589
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_adjust.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long	ll_row
string	ls_role_no

ll_row = dw_role_mst.getrow()
if ll_row > 0 then
	ls_role_no = dw_role_mst.getitemstring(ll_row, 'role_no')
	OpenWithParm(pf_w_role_mst_modify, '수정~t' + ls_role_no)
	
	if left(message.stringparm,2) = 'OK' then
		string ls_retval, ls_parm[]
		
		ls_retval = mid(message.stringparm, 4)
		pf_f_parsetoarray(ls_retval, '~t', ls_parm[])
		
		dw_role_mst.setitem(ll_row, 'role_no', ls_parm[1])
		dw_role_mst.setitem(ll_row, 'role_name', ls_parm[2])
		dw_role_mst.setitem(ll_row, 'role_desc', ls_parm[3])
		dw_role_mst.setitemstatus(ll_row, 0, primary!, notmodified!)
		
		//dw_role_mst.retrieve(gnv_session.is_sys_id)
	end if
end if

end event

type p_role_delete from pf_u_imagebutton within pf_w_role_mst_ent_v1
integer x = 3831
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long	ll_row
string	ls_role_no, ls_role_name
string	ls_errtext

ll_row = dw_role_mst.getrow()
if ll_row > 0 then
	ls_role_no = dw_role_mst.getitemstring(ll_row, 'role_no')
	ls_role_name = dw_role_mst.getitemstring(ll_row, 'role_name')
	
	if ls_role_no = '00001' then 
		messagebox('알림', '관리자용 권한은 삭제할 수 없습니다')
		return
	end if
	
	if dw_role_memb.rowcount() > 0 then
		messagebox('알림', '먼저 권한 멤버를 삭제하세요')
		return
	end if
	
	if messagebox('알림', '선택하신 ' + ls_role_name + '[' + ls_role_no + '] 권한을 삭제하시겠습니까?', Exclamation!, YesNo!, 2) = 1 then
		dw_role_mst.deleterow(ll_row)
		if dw_role_mst.update() = 1 then
		
			// 기존 권한프로그램 삭제
			delete		pf_role_pgm
			where	sys_id = :gnv_session.is_sys_id
			and		role_no = :ls_role_no
			using		sqlca;
	
			delete		pf_role_pgm_btn
			where	sys_id = :gnv_session.is_sys_id
			and		role_no = :ls_role_no
			using		sqlca;
			
			commit using sqlca;
			of_setmessage('권한 정보 삭제 완료')
		else
			ls_errtext = sqlca.sqlerrtext
			rollback using sqlca;
			messagebox('알림', 'Role 정보 삭제 실패!!~r~n' + 'Error Text: ' + ls_errtext)
			return
		end if
	end if
end if

end event

type p_close from pf_u_imagebutton within pf_w_role_mst_ent_v1
integer x = 4315
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)

end event

type p_1 from pf_u_picture within pf_w_role_mst_ent_v1
integer x = 55
integer y = 1308
integer width = 46
integer height = 40
boolean bringtotop = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean fixedtobottom = true
end type

type st_2 from pf_u_statictext within pf_w_role_mst_ent_v1
integer x = 114
integer y = 1304
integer width = 425
integer height = 48
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = hangeul!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "권한 멤버"
boolean fixedtobottom = true
end type

type dw_role_memb from pf_u_datawindow within pf_w_role_mst_ent_v1
integer x = 50
integer y = 1372
integer width = 2597
integer height = 848
integer taborder = 20
boolean bringtotop = true
string dataobject = "pf_d_role_mst_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean useborder = false
boolean fixedtobottom = true
boolean scaletoright = true
end type

event rowfocuschanged;call super::rowfocuschanged;this.selectrow(0, false)
this.selectrow(currentrow, true)

//if currentrow = 0 then return
//
//string	ls_role_no, ls_role_name
//
//ls_role_no = this.getitemstring(currentrow, 'role_no')
//ls_role_name = this.getitemstring(currentrow, 'role_name')
//
//is_current_role_no = ls_role_no
//is_current_role_name = ls_role_name
//
//idw_role_memb.retrieve(gnv_session.is_sys_id, ls_role_no)
//ids_role_pgm.retrieve(gnv_session.is_sys_id, ls_role_no)
//
//parent.post function wf_retrieve_treeview(ls_role_no)

end event

event rowfocuschanging;call super::rowfocuschanging;//// 변경사항 확인
//if	ids_role_pgm.modifiedcount() + ids_role_pgm.deletedcount() > 0 or &
//	idw_role_memb.modifiedcount() + idw_role_memb.deletedcount() > 0 then
//	if messagebox('알림', '수정사항이 저장되지 않았습니다.~r~n무시하고 진행하시겠습니까?', Question!, YesNo!, 2) = 1 then
//		return 0
//	else
//		return 1
//	end if
//end if
//
//return 0

end event

event rbuttondown;call super::rbuttondown;choose case dwo.name
	case 'valid_dt_from', 'valid_dt_to'
		string ls_date
		ls_date = string(this.getitemstring(row, string(dwo.name)), '@@@@/@@/@@')
		//if gf_dwsetdate(this, string(dwo.name), ls_date) then
		//	this.setitem(row, string(dwo.name), string(date(ls_date), 'yyyymmdd'))
		//end if
end choose

end event

event clicked;call super::clicked;long ll_new
string ls_column
string	ls_column_tag
string	ls_rtn, ls_rtn_arr[]
datawindowchild ldwc_1

if row = 0 then return
if string(dwo.type) <> 'column' then return
ls_column = string(dwo.name)
if left(ls_column,9) = 'memb_code' and long(dwo.tabsequence) = 0 then
	if is_current_role_no = '' then return
	ls_column_tag = string(dwo.tag)
	openwithparm(pf_w_role_mst_memb_select, ls_column_tag)
	ls_rtn = message.stringparm
	if isnull(ls_rtn) or len(trim(ls_rtn)) = 0 then return
	pf_f_parsetoarray(ls_rtn, '~t', ls_rtn_arr)
	if ls_rtn_arr[1] = 'OK' then
		this.getchild(ls_column, ldwc_1)
		ll_new = ldwc_1.insertrow(0)
		ldwc_1.setitem(ll_new, 'code', ls_rtn_arr[2])
		ldwc_1.setitem(ll_new, 'name', ls_rtn_arr[3])
		this.setitem(row, ls_column, ls_rtn_arr[2])
		this.setitem(row, 'memb_name' + mid(ls_column, 10), ls_rtn_arr[3])
	end if
end if

return 0

end event

event itemchanged;call super::itemchanged;string ls_column

if row = 0 then return 0
if string(dwo.type) <> 'column' then return 0
ls_column = string(dwo.name)
if left(ls_column,9) = 'memb_code' and long(dwo.tabsequence) > 0 then
	if is_current_role_no = '' then return 0
	if isnull(data) or data = '' then
		this.setitem(row, 'memb_name' + mid(ls_column, 10), '')
	else
		post of_set_role_memb_name(ls_column, row)
	end if
end if

return 0

end event

type tv_pgm from pf_u_treeview within pf_w_role_mst_ent_v1
event ue_checkoutcbx ( long al_clicked,  long al_state )
event ue_checked ( long al_handle )
event ue_unchecked ( long al_handle )
integer x = 2665
integer y = 236
integer width = 1883
integer height = 1984
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = hangeul!
long textcolor = 20132659
boolean hideselection = false
boolean checkboxes = true
string picturename[] = {"Application5!","ApplicationIcon!","Custom039!","Open!"}
long picturemaskcolor = 12632256
boolean fixedtoright = true
boolean scaletobottom = true
end type

event ue_checkoutcbx(long al_clicked, long al_state);treeviewitem	ltvi_item

this.getitem(al_clicked, ltvi_item)
if al_state = 1 and ltvi_item.statepictureindex = 2 then
	this.event ue_checked(al_clicked)
elseif al_state = 2 and ltvi_item.statepictureindex = 1 then
	this.event ue_unchecked(al_clicked)
end if

return

end event

event ue_checked(long al_handle);treeviewitem ltvi_parent, ltvi_child
long ll_nextitem, ll_previtem

if this.getitem(al_handle, ltvi_parent) < 0 then return

// 하위 노드 선택
if cbx_hierachy.checked = true then
	ll_nextitem = this.finditem(nextvisibletreeitem!, al_handle)
	
	do while ll_nextitem > 0
		this.getitem(ll_nextitem, ltvi_child)
		if ltvi_child.level <= ltvi_parent.level then exit
		
		if ltvi_child.statepictureindex = 1 then
			ltvi_child.statepictureindex = 2
			this.setitem(ll_nextitem, ltvi_child)
			this.selectitem(ll_nextitem)
			of_add_role_pgm(is_current_role_no, string(ltvi_child.data))
		end if
		
		ll_nextitem = this.finditem(nextvisibletreeitem!, ll_nextitem)
	loop
end if

// 상위 노드 선택
ll_previtem = this.finditem(ParentTreeItem!, al_handle)
do while ll_previtem > 0
	this.getitem(ll_previtem, ltvi_child)
	if ltvi_child.level < 1 then exit
	if ltvi_child.statepictureindex = 1 then
		ltvi_child.statepictureindex = 2
		this.setitem(ll_previtem, ltvi_child)
		this.selectitem(ll_previtem)
		of_add_role_pgm(is_current_role_no, string(ltvi_child.data))
	end if
	ll_previtem = this.finditem(ParentTreeItem!, ll_previtem)
loop

this.selectitem(al_handle)
of_add_role_pgm(is_current_role_no, string(ltvi_parent.data))

//p_pgm_update.event clicked()
return

end event

event ue_unchecked(long al_handle);treeviewitem ltvi_parent, ltvi_child
long ll_nextitem

if this.getitem(al_handle, ltvi_parent) < 0 then return

if cbx_hierachy.checked = true then
	ll_nextitem = this.finditem(nextvisibletreeitem!, al_handle)
	
	do while ll_nextitem > 0
		this.getitem(ll_nextitem, ltvi_child)
		if ltvi_child.level <= ltvi_parent.level then exit
		
		if ltvi_child.statepictureindex = 2 then
			ltvi_child.statepictureindex = 1
			this.setitem(ll_nextitem, ltvi_child)
			this.selectitem(ll_nextitem)
			of_delete_role_pgm(is_current_role_no, string(ltvi_child.data))
		end if
		
		ll_nextitem = this.finditem(nextvisibletreeitem!, ll_nextitem)
	loop
end if

this.selectitem(al_handle)
of_delete_role_pgm(is_current_role_no, string(ltvi_parent.data))

//p_pgm_update.event clicked()
return

end event

event clicked;call super::clicked;treeviewitem	ltvi_item

this.getitem(handle, ltvi_item)
this.post event ue_checkoutcbx(handle, ltvi_item.statepictureindex)

end event

event key;call super::key;treeviewitem ltvi_item

choose case key
	case keyspacebar!
		if this.getitem(il_current_handle, ltvi_item) > 0 then
			this.post event ue_checkoutcbx(il_current_handle, ltvi_item.statepictureindex)
		end if
end choose

return 0

end event

event selectionchanged;call super::selectionchanged;il_current_handle = newhandle

end event

event rightclicked;call super::rightclicked;treeviewitem ltvi_item

if this.selectitem(handle) = -1 then return
if this.getitem(handle, ltvi_item) = -1 then return

choose case ltvi_item.PictureIndex
	case 3, 4
		im_treemenu.popmenu(iw_parent.pointerx(), iw_parent.pointery())
end choose

end event

type st_3 from pf_u_statictext within pf_w_role_mst_ent_v1
integer x = 2729
integer y = 172
integer width = 425
integer height = 48
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = hangeul!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "프로그램 권한"
boolean fixedtoright = true
end type

type p_3 from pf_u_picture within pf_w_role_mst_ent_v1
integer x = 2670
integer y = 180
integer width = 46
integer height = 40
boolean bringtotop = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean fixedtoright = true
end type

type p_memb_add from pf_u_imagebutton within pf_w_role_mst_ent_v1
integer x = 2158
integer y = 1280
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
boolean fixedtoright = true
boolean fixedtobottom = true
end type

event clicked;call super::clicked;long ll_row, ll_new
string	ls_role_no
string ls_memb_seq

ll_row = dw_role_mst.getrow()
if ll_row < 1 then return

ls_role_no = dw_role_mst.getitemstring(ll_row, 'role_no')
ls_memb_seq = dw_role_memb.describe("evaluate('max (memb_seq for all)',0)")
if ls_memb_seq = '!' then return

ll_new = dw_role_memb.insertrow(0)
dw_role_memb.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
dw_role_memb.setitem(ll_new, 'role_no', ls_role_no)
dw_role_memb.setitem(ll_new, 'memb_seq', long(ls_memb_seq) + 1)
dw_role_memb.setitem(ll_new, 'valid_dt_yn', 'N')

end event

type p_memb_delete from pf_u_imagebutton within pf_w_role_mst_ent_v1
integer x = 2400
integer y = 1280
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
boolean fixedtoright = true
boolean fixedtobottom = true
end type

event clicked;call super::clicked;long	ll_row

ll_row = dw_role_memb.getrow()
if ll_row > 0 then
	//ls_memb_code = dw_role_memb.getitemstring(ll_row, 'memb_code')
	//ls_memb_name = dw_role_memb.getitemstring(ll_row, 'memb_name')
	if messagebox('알림', '선택하신 ' + string(ll_row) + '번째 멤버를 삭제하시겠습니까?', Exclamation!, YesNo!, 2) = 1 then
		dw_role_memb.deleterow(ll_row)
	end if
end if

end event

type p_memb_update from pf_u_imagebutton within pf_w_role_mst_ent_v1
integer x = 4073
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;string	ls_errtext
long ll_row, ll_hndl, ll_parent_hndl
string ls_org_role_no, ls_role_no
string ls_pgm_kind_code
treeviewitem ltvi_item, ltvi_parent_item

setpointer(hourglass!)
post setpointer(arrow!)

tv_pgm.setredraw(false)
tv_pgm.post setredraw(true)

ll_row = dw_role_mst.getrow()
if ll_row = 0 then
	messagebox('알림', '현재 선택된 권한이 없습니다')
	return
end if

ls_role_no = dw_role_mst.getitemstring(ll_row, 'role_no')

// 상위 폴더 선택 안된 경우 체크
ll_hndl = tv_pgm.finditem(RootTreeItem!, 0)
if ll_hndl > 0 then tv_pgm.expandall(ll_hndl)

do while ll_hndl > 0
	tv_pgm.getitem(ll_hndl, ltvi_item)
	choose case ltvi_item.PictureIndex
		case 1, 2
			ls_pgm_kind_code = 'P'
		case 3, 4
			ls_pgm_kind_code = 'M'
		case else
			continue
	end choose
	
	if parent.of_get_status_tvi_checkbox(ltvi_item) = true and ls_pgm_kind_code = 'P' then
		ll_parent_hndl = tv_pgm.finditem(ParentTreeItem!, ll_hndl)
		do while ll_parent_hndl > 0
			tv_pgm.getitem(ll_parent_hndl, ltvi_parent_item)
			if parent.of_get_status_tvi_checkbox(ltvi_parent_item) = false then
				parent.of_set_status_tvi_checkbox(ltvi_parent_item, true)
				parent.of_add_role_pgm(ls_role_no, string(ltvi_parent_item.data))
			end if
			ll_parent_hndl = tv_pgm.finditem(ParentTreeItem!, ll_parent_hndl)
		loop
	end if
	
	ll_hndl = tv_pgm.finditem(NextVisibleTreeItem!, ll_hndl)
loop

// 변경 사항에 대해서 입력, 삭제할 아이템 구분
ll_row = ids_role_pgm.getnextmodified(0, primary!)
do while ll_row > 0
	if ids_role_pgm.getitemstatus(ll_row, 'role_no', primary!) = Datamodified! then
		ls_org_role_no = ids_role_pgm.getitemstring(ll_row, 'role_no', primary!, true)
		ls_role_no = ids_role_pgm.getitemstring(ll_row, 'role_no')
		
		// insert
		if pf_f_isemptystring(ls_org_role_no) = true and pf_f_isemptystring(ls_role_no) = false then
			ids_role_pgm.setitemstatus(ll_row, 0, primary!, newmodified!)
		
		// delete
		elseif pf_f_isemptystring(ls_org_role_no) = false and pf_f_isemptystring(ls_role_no) = true then
			ids_role_pgm.deleterow(ll_row)
			ll_row = ll_row - 1
			
		// case else
		else
			ids_role_pgm.setitemstatus(ll_row, 0, primary!, notmodified!)
		end if
	end if
	
	ll_row = ids_role_pgm.getnextmodified(ll_row, primary!)
loop

// 권한 데이터 저장
if dw_role_memb.update(true, false) = 1 then
	if ids_role_pgm.update(true, false) = 1 then
		commit using sqlca;
		
		dw_role_memb.resetupdate()
		ids_role_pgm.resetupdate()
		of_setmessage('권한 설정 저장 완료!!')
		
		// 삭제된 ROW 재조회
		ids_role_pgm.retrieve(gnv_session.is_sys_id, is_current_role_no)
	else
		ls_errtext = sqlca.sqlerrtext
		rollback using sqlca;
		messagebox('알림', '권한 설정 저장 실패!!~r~n' + 'Error Text: ' + ls_errtext)
	end if
else
	ls_errtext = sqlca.sqlerrtext
	rollback using sqlca;
	messagebox('알림', '권한 설정 저장 실패!!~r~n' + 'Error Text: ' + ls_errtext)
end if

end event

type cbx_hierachy from pf_u_checkbox within pf_w_role_mst_ent_v1
integer x = 3982
integer y = 160
integer width = 567
integer height = 72
boolean bringtotop = true
fontcharset fontcharset = hangeul!
long textcolor = 8421504
string text = "하위항목 일괄선택"
boolean checked = true
boolean fixedtoright = true
end type

type cb_1 from pf_u_commandbutton within pf_w_role_mst_ent_v1
integer x = 2830
integer y = 32
integer width = 512
integer height = 96
integer taborder = 20
boolean bringtotop = true
string text = "프로그램 권한복사"
boolean fixedtoright = true
end type

event clicked;call super::clicked;if is_current_role_no = '' then
	messagebox('알림', '먼저 복사될 권한을 선택하세요')
	return
end if

if is_current_role_no = '00001' then
	messagebox('알림', '관리자 권한에 대한 프로그램 권한정보는 복사(Overwrite)될 수 없습니다')
	return
end if

string ls_rtn, ls_rtn_arr[]
string ls_role_no, ls_role_name
string ls_errmsg

open(pf_w_role_mst_select)
ls_rtn = message.stringparm
if isnull(ls_rtn) or len(trim(ls_rtn)) = 0 then return

pf_f_parsetoarray(ls_rtn, '~t', ls_rtn_arr)
if ls_rtn_arr[1] = 'OK' then
	ls_role_no = ls_rtn_arr[2]
	ls_role_name = ls_rtn_arr[3]
	
	if is_current_role_no = ls_role_no then
		messagebox('알림', '현재 권한과 같은 권한을 선택하셨습니다')
		return
	end if
	
	if messagebox('알림', '프로그램 권한복사를 하게되면 현재 권한에 설정된 프로그램 정보가 Overwrite 됩니다. 진행하시겠습니까?', Exclamation!, YesNo!, 2) = 2 then return
	
	// 기존 권한프로그램 삭제
	delete		pf_role_pgm
	where	sys_id = :gnv_session.is_sys_id
	and		role_no = :is_current_role_no
	using		sqlca;
	
	delete		pf_role_pgm_btn
	where	sys_id = :gnv_session.is_sys_id
	and		role_no = :is_current_role_no
	using		sqlca;
	
	// 권한 프로그램 카피
	insert into pf_role_pgm
				( sys_id,
				role_no,
				menu_id,
				valid_dt_yn,
				valid_dt_from,
				valid_dt_to,
				comm_btn_auth_yn,
				retrieve_auth_yn,
				input_auth_yn,
				delete_auth_yn,
				update_auth_yn,
				print_auth_yn,
				execute_auth_yn,
				cancel_auth_yn,
				excel_auth_yn,
				indiv_btn_auth_yn )
	select		sys_id,
				:is_current_role_no,
				menu_id,
				valid_dt_yn,
				valid_dt_from,
				valid_dt_to,
				comm_btn_auth_yn,
				retrieve_auth_yn,
				input_auth_yn,
				delete_auth_yn,
				update_auth_yn,
				print_auth_yn,
				execute_auth_yn,
				cancel_auth_yn,
				excel_auth_yn,
				indiv_btn_auth_yn
	from		pf_role_pgm
	where	sys_id = :gnv_session.is_sys_id
	and		role_no = :ls_role_no
	using		sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_errmsg = sqlca.sqlerrtext
		rollback using sqlca;
		messagebox('알림', '프로그램 권한을 복사하는 중 오류가 발생하였습니다~r~n' + ls_errmsg)
		return
	end if
	
	insert into pf_role_pgm_btn
				( sys_id,
				role_no,
				menu_id,
				btn_id,
				btn_name,
				btn_use_yn )
	select		sys_id,
				:is_current_role_no,
				menu_id,
				btn_id,
				btn_name,
				btn_use_yn
	from		pf_role_pgm_btn
	where	sys_id = :gnv_session.is_sys_id
	and		role_no = :ls_role_no
	using		sqlca;
	
	if sqlca.sqlcode <> 0 then
		ls_errmsg = sqlca.sqlerrtext
		rollback using sqlca;
		messagebox('알림', '프로그램 권한을 복사하는 중 오류가 발생하였습니다~r~n' + ls_errmsg)
		return
	end if
	
	commit using sqlca;
	messagebox('알림', '권한 프로그램을 복사했습니다')
	
	dw_role_mst.post event rowfocuschanged(dw_role_mst.getrow())
end if

end event

type st_4 from pf_u_splitbar_vertical within pf_w_role_mst_ent_v1
integer x = 2647
integer y = 224
integer height = 1996
boolean bringtotop = true
boolean fixedtoright = true
string leftdragobject = "dw_role_mst; dw_role_memb;p_memb_add;p_memb_delete"
string rightdragobject = "tv_pgm; p_3; st_3"
end type

type cbx_expand from pf_u_checkbox within pf_w_role_mst_ent_v1
integer x = 3378
integer y = 160
integer width = 379
integer height = 72
boolean bringtotop = true
fontcharset fontcharset = hangeul!
long textcolor = 8421504
string text = "열린 메뉴"
boolean checked = true
boolean fixedtoright = true
end type

