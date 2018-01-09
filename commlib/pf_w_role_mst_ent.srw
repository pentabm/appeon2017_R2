HA$PBExportHeader$pf_w_role_mst_ent.srw
$PBExportComments$$$HEX37$$8cad5cd5c4bc5cb8200064ba84bc7cb920000fbc2000acc0a9c6200000aca5b25cd5200004d55cb8f8ada8b744c7200060d5f9b258d594b2200004d55cb8f8ada8b7200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_role_mst_ent from pf_w_sheet
end type
type st_1 from statictext within pf_w_role_mst_ent
end type
type p_2 from picture within pf_w_role_mst_ent
end type
type dw_role_mst from pf_u_datawindow within pf_w_role_mst_ent
end type
type p_role_add from pf_u_imagebutton within pf_w_role_mst_ent
end type
type p_role_modify from pf_u_imagebutton within pf_w_role_mst_ent
end type
type p_role_delete from pf_u_imagebutton within pf_w_role_mst_ent
end type
type p_close from pf_u_imagebutton within pf_w_role_mst_ent
end type
type p_1 from picture within pf_w_role_mst_ent
end type
type st_2 from statictext within pf_w_role_mst_ent
end type
type dw_role_memb from pf_u_datawindow within pf_w_role_mst_ent
end type
type tv_pgm from pf_u_treeview within pf_w_role_mst_ent
end type
type st_3 from statictext within pf_w_role_mst_ent
end type
type p_3 from picture within pf_w_role_mst_ent
end type
type dw_role_pgm from pf_u_datawindow within pf_w_role_mst_ent
end type
type dw_pgm_btn from pf_u_datawindow within pf_w_role_mst_ent
end type
type p_4 from picture within pf_w_role_mst_ent
end type
type st_4 from statictext within pf_w_role_mst_ent
end type
type p_memb_add from pf_u_imagebutton within pf_w_role_mst_ent
end type
type p_memb_delete from pf_u_imagebutton within pf_w_role_mst_ent
end type
type p_memb_update from pf_u_imagebutton within pf_w_role_mst_ent
end type
type cbx_hierachy from checkbox within pf_w_role_mst_ent
end type
type p_pgm_update from pf_u_imagebutton within pf_w_role_mst_ent
end type
type cbx_use_btn_yn from checkbox within pf_w_role_mst_ent
end type
type cb_btnscan from pf_u_commandbutton within pf_w_role_mst_ent
end type
type cb_1 from pf_u_commandbutton within pf_w_role_mst_ent
end type
type p_5 from picture within pf_w_role_mst_ent
end type
end forward

global type pf_w_role_mst_ent from pf_w_sheet
integer width = 4526
integer height = 2976
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
dw_role_pgm dw_role_pgm
dw_pgm_btn dw_pgm_btn
p_4 p_4
st_4 st_4
p_memb_add p_memb_add
p_memb_delete p_memb_delete
p_memb_update p_memb_update
cbx_hierachy cbx_hierachy
p_pgm_update p_pgm_update
cbx_use_btn_yn cbx_use_btn_yn
cb_btnscan cb_btnscan
cb_1 cb_1
p_5 p_5
end type
global pf_w_role_mst_ent pf_w_role_mst_ent

type variables
datastore ids_menu
datastore ids_role_pgm
datastore ids_role_cat

long il_current_handle
string	is_current_role_no
string is_current_role_name
string is_logging_yn = 'N'

end variables

forward prototypes
public function integer of_set_title_role_memb ()
public function integer of_set_popup_dddw_data ()
public function long of_retrieve_treeview (string as_role_no)
public function integer of_getbuttonlist (string as_pgm_id, ref windowobject awo_button[])
public function long of_getwindowcontrols (windowobject awo_input[], ref windowobject awo_output[])
public function integer of_add_role_pgm (string as_role_no, string as_menu_id)
public function long of_delete_role_pgm (string as_role_no, string as_menu_id)
public function long of_retrieve_treeview (string as_role_no, string as_work_gb)
public function integer of_set_role_memb_name (string as_column, long al_row)
end prototypes

public function integer of_set_title_role_memb ();integer i, il_role_cat_no
boolean lb_role_cat_yn[8]
string ls_modify, ls_search_type
string ls_role_cat_no, ls_role_cat_name
string ls_code_list_dwo

string ls_datacolumn, ls_displaycolumn
datastore lds_temp

lds_temp = create datastore

// modify header title
for i = 1 to ids_role_cat.rowcount()
	ls_role_cat_no = ids_role_cat.getitemstring(i, 'role_cat_no')
	il_role_cat_no = integer(ls_role_cat_no)
	lb_role_cat_yn[il_role_cat_no] = true
	ls_role_cat_name = ids_role_cat.getitemstring(i, 'role_cat_name')
	ls_search_type = ids_role_cat.getitemstring(i, 'search_type')
	ls_code_list_dwo = ids_role_cat.getitemstring(i, 'code_list_dwo')
	
	ls_modify += "memb_code" + string(il_role_cat_no) + "_t.text='" + ls_role_cat_name + "'~r~n"
	ls_modify += "memb_code" + string(il_role_cat_no) + ".tag='" + ls_code_list_dwo + "'~r~n"
	
	choose case ls_search_type
		case 'popup'
			ls_modify += "memb_code" + string(il_role_cat_no) + ".tabsequence='0'~r~n"
		case 'dddw'
			lds_temp.dataobject = ls_code_list_dwo
			ls_datacolumn = lds_temp.describe("#1.Name")
			ls_displaycolumn = lds_temp.describe("#2.Name")
			
			ls_modify += "memb_code" + string(il_role_cat_no) + ".dddw.Name='" + ls_code_list_dwo + "'~r~n"
			ls_modify += "memb_code" + string(il_role_cat_no) + ".dddw.DataColumn='" + ls_datacolumn + "'~r~n"
			ls_modify += "memb_code" + string(il_role_cat_no) + ".dddw.DisplayColumn='" + ls_displaycolumn + "'~r~n"
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
datawindowchild ldwc_1

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

public function long of_retrieve_treeview (string as_role_no);long ll_rowcnt, ll_handle, i
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

tv_pgm.ExpandAll(ll_parent[2])
tv_pgm.setredraw(true)

tv_pgm.post selectitem(ll_parent[2])
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

public function long of_retrieve_treeview (string as_role_no, string as_work_gb);long ll_rowcnt, ll_handle, i
treeviewitem ltvi_item
long ll_level, ll_parent[]

tv_pgm.setredraw(false)

ll_handle = tv_pgm.finditem(roottreeitem!, 0)
do while ll_handle > 0
	tv_pgm.deleteitem(ll_handle)
	ll_handle = tv_pgm.finditem(roottreeitem!, ll_handle)
loop

//if isnull(as_work_gb) or as_work_gb = '' then
//	ids_menu.dataobject = 'pf_d_role_mst_03_oracle'
//	ids_menu.settransobject(sqlca)
//	as_work_gb = 'ZZZZZ'
//else
//	ids_menu.dataobject = 'pf_d_role_mst_03_oracle_2nd'
//	ids_menu.settransobject(sqlca)
//end if

if isnull(as_work_gb) then as_work_gb = ''

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

tv_pgm.ExpandAll(ll_parent[2])
tv_pgm.setredraw(true)

tv_pgm.post selectitem(ll_parent[2])
return ll_rowcnt

end function

public function integer of_set_role_memb_name (string as_column, long al_row);string ls_name

ls_name = dw_role_memb.Describe("Evaluate('LookUpDisplay(" + as_column + ")'," + string(al_row) + ")")
dw_role_memb.setitem(al_row, 'memb_name' + mid(as_column, 10), ls_name)
return 1

end function

on pf_w_role_mst_ent.create
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
this.dw_role_pgm=create dw_role_pgm
this.dw_pgm_btn=create dw_pgm_btn
this.p_4=create p_4
this.st_4=create st_4
this.p_memb_add=create p_memb_add
this.p_memb_delete=create p_memb_delete
this.p_memb_update=create p_memb_update
this.cbx_hierachy=create cbx_hierachy
this.p_pgm_update=create p_pgm_update
this.cbx_use_btn_yn=create cbx_use_btn_yn
this.cb_btnscan=create cb_btnscan
this.cb_1=create cb_1
this.p_5=create p_5
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
this.Control[iCurrent+14]=this.dw_role_pgm
this.Control[iCurrent+15]=this.dw_pgm_btn
this.Control[iCurrent+16]=this.p_4
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.p_memb_add
this.Control[iCurrent+19]=this.p_memb_delete
this.Control[iCurrent+20]=this.p_memb_update
this.Control[iCurrent+21]=this.cbx_hierachy
this.Control[iCurrent+22]=this.p_pgm_update
this.Control[iCurrent+23]=this.cbx_use_btn_yn
this.Control[iCurrent+24]=this.cb_btnscan
this.Control[iCurrent+25]=this.cb_1
this.Control[iCurrent+26]=this.p_5
end on

on pf_w_role_mst_ent.destroy
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
destroy(this.dw_role_pgm)
destroy(this.dw_pgm_btn)
destroy(this.p_4)
destroy(this.st_4)
destroy(this.p_memb_add)
destroy(this.p_memb_delete)
destroy(this.p_memb_update)
destroy(this.cbx_hierachy)
destroy(this.p_pgm_update)
destroy(this.cbx_use_btn_yn)
destroy(this.cb_btnscan)
destroy(this.cb_1)
destroy(this.p_5)
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
dw_role_pgm.settransobject(sqlca)
dw_pgm_btn.settransobject(sqlca)

end event

event close;call super::close;destroy ids_menu
destroy ids_role_cat
destroy ids_role_pgm

end event

event pfe_postopen;call super::pfe_postopen;is_logging_yn = gnv_appconf.of_getprofile("pip.logging", "N")
messagebox('is_logging_yn', is_logging_yn)

ids_role_cat.retrieve(gnv_session.is_sys_id)
this.of_set_title_role_memb()

dw_role_mst.retrieve(gnv_session.is_sys_id)
ids_role_pgm.sharedata(dw_role_pgm)

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_role_mst_ent
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_role_mst_ent
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_role_mst_ent
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_role_mst_ent
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_role_mst_ent
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_role_mst_ent
end type

type st_1 from statictext within pf_w_role_mst_ent
integer x = 2053
integer y = 64
integer width = 425
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX2$$cbb3c0c6$$ENDHEX$$"
long textcolor = 25123896
long backcolor = 16777215
string text = "$$HEX6$$8cad5cd52000acb9a4c2b8d2$$ENDHEX$$"
boolean focusrectangle = false
end type

type p_2 from picture within pf_w_role_mst_ent
integer x = 1993
integer y = 68
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type dw_role_mst from pf_u_datawindow within pf_w_role_mst_ent
integer x = 1989
integer y = 124
integer width = 2469
integer height = 948
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_role_mst_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean useborder = false
boolean scaletoright = true
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

type p_role_add from pf_u_imagebutton within pf_w_role_mst_ent
integer x = 3493
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;OpenWithParm(pf_w_role_mst_modify, '$$HEX2$$94cd00ac$$ENDHEX$$')
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

type p_role_modify from pf_u_imagebutton within pf_w_role_mst_ent
integer x = 3735
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
	OpenWithParm(pf_w_role_mst_modify, '$$HEX2$$18c215c8$$ENDHEX$$~t' + ls_role_no)
	
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

type p_role_delete from pf_u_imagebutton within pf_w_role_mst_ent
integer x = 3977
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
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX19$$00adacb990c7a9c620008cad5cd540c72000adc01cc860d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
		return
	end if
	
	if dw_role_memb.rowcount() > 0 then
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX15$$3cba00c820008cad5cd5200064ba84bc7cb92000adc01cc858d538c194c6$$ENDHEX$$')
		return
	end if
	
	if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX5$$20c1ddd058d5e0c22000$$ENDHEX$$' + ls_role_name + '[' + ls_role_no + '] $$HEX12$$8cad5cd544c72000adc01cc858d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Exclamation!, YesNo!, 2) = 1 then
		dw_role_mst.deleterow(ll_row)
		if dw_role_mst.update() = 1 then
		
			// $$HEX12$$30ae74c820008cad5cd504d55cb8f8ada8b72000adc01cc8$$ENDHEX$$
			delete		pf_role_pgm
			where	sys_id = :gnv_session.is_sys_id
			and		role_no = :ls_role_no
			using		sqlca;
	
			delete		pf_role_pgm_btn
			where	sys_id = :gnv_session.is_sys_id
			and		role_no = :ls_role_no
			using		sqlca;
			
			commit using sqlca;
			of_setmessage('$$HEX11$$8cad5cd5200015c8f4bc2000adc01cc8200044c6ccb8$$ENDHEX$$')
		else
			ls_errtext = sqlca.sqlerrtext
			rollback using sqlca;
			messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'Role $$HEX8$$15c8f4bc2000adc01cc82000e4c228d3$$ENDHEX$$!!~r~n' + 'Error Text: ' + ls_errtext)
			return
		end if
	end if
end if

end event

type p_close from pf_u_imagebutton within pf_w_role_mst_ent
integer x = 4219
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

type p_1 from picture within pf_w_role_mst_ent
integer x = 1993
integer y = 1100
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type st_2 from statictext within pf_w_role_mst_ent
integer x = 2053
integer y = 1096
integer width = 425
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX2$$cbb3c0c6$$ENDHEX$$"
long textcolor = 25123896
long backcolor = 16777215
string text = "$$HEX5$$8cad5cd5200064ba84bc$$ENDHEX$$"
boolean focusrectangle = false
end type

type dw_role_memb from pf_u_datawindow within pf_w_role_mst_ent
integer x = 1989
integer y = 1164
integer width = 2469
integer height = 596
integer taborder = 20
boolean bringtotop = true
string dataobject = "pf_d_role_mst_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorting = false
boolean useborder = false
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

event rowfocuschanging;call super::rowfocuschanging;//// $$HEX7$$c0bcbdacacc06dd5200055d678c7$$ENDHEX$$
//if	ids_role_pgm.modifiedcount() + ids_role_pgm.deletedcount() > 0 or &
//	idw_role_memb.modifiedcount() + idw_role_memb.deletedcount() > 0 then
//	if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX16$$18c215c8acc06dd574c7200000c8a5c718b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX13$$34bbdcc258d5e0ac2000c4c989d558d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 1 then
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

event clicked;call super::clicked;long	ll_new
string ls_column
string	ls_code_list_dwo
string	ls_rtn, ls_rtn_arr[]
datawindowchild ldwc_1

if row = 0 then return
if string(dwo.type) <> 'column' then return
ls_column = string(dwo.name)
if left(ls_column,9) = 'memb_code' and long(dwo.tabsequence) = 0 then
	if is_current_role_no = '' then return
	ls_code_list_dwo = string(dwo.tag)
	openwithparm(pf_w_role_mst_memb_select, ls_code_list_dwo)
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

type tv_pgm from pf_u_treeview within pf_w_role_mst_ent
event ue_checkoutcbx ( long al_clicked,  long al_state )
event ue_checked ( long al_handle )
event ue_unchecked ( long al_handle )
integer x = 55
integer y = 124
integer width = 1911
integer height = 2716
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = hangeul!
long textcolor = 20132659
boolean hideselection = false
boolean checkboxes = true
string picturename[] = {"Application5!","ApplicationIcon!","Custom039!","Open!"}
long picturemaskcolor = 12632256
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

// $$HEX8$$58d504c7200078b1dcb4200020c1ddd0$$ENDHEX$$
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

// $$HEX8$$c1c004c7200078b1dcb4200020c1ddd0$$ENDHEX$$
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

p_pgm_update.event clicked()
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

p_pgm_update.event clicked()
return

end event

event clicked;call super::clicked;treeviewitem	ltvi_item

this.getitem(handle, ltvi_item)
this.post event ue_checkoutcbx(handle, ltvi_item.statepictureindex)

end event

event key;call super::key;choose case key
	case keyspacebar!
		treeviewitem	ltvi_item
		if this.getitem(il_current_handle, ltvi_item) > 0 then
			this.post event ue_checkoutcbx(il_current_handle, ltvi_item.statepictureindex)
		end if
end choose

return 0

end event

event selectionchanged;call super::selectionchanged;treeviewitem ltvi_item

if this.getitem(newhandle, ltvi_item) < 0 then return

long ll_find

ll_find = ids_role_pgm.find('pf_pgm_mst_menu_id="' + string(ltvi_item.data) + '"', 1, ids_role_pgm.rowcount())
if ll_find > 0 then
	dw_role_pgm.scrolltorow(ll_find)
	dw_role_pgm.setrow(ll_find)
	
	if pf_f_isemptystring(dw_role_pgm.getitemstring(ll_find, 'role_no')) = true then
		cbx_use_btn_yn.checked = false
		cbx_use_btn_yn.enabled = false
		cb_btnscan.enabled = false
	else
		if dw_role_pgm.getitemstring(ll_find, 'pgm_kind_code') = 'P' then
			if dw_role_pgm.getitemstring(ll_find, 'indiv_btn_auth_yn') = 'Y' then
				cbx_use_btn_yn.checked = true
				cb_btnscan.enabled = true
			else
				cbx_use_btn_yn.checked = false
				cb_btnscan.enabled = false
			end if
			
			cbx_use_btn_yn.enabled = true
		else
			cbx_use_btn_yn.checked = false
			cbx_use_btn_yn.enabled = false
			cb_btnscan.enabled = false
		end if
	end if
	
	dw_pgm_btn.retrieve(gnv_session.is_sys_id, is_current_role_no, string(ltvi_item.data))
end if

end event

event selectionchanging;call super::selectionchanging;// $$HEX7$$c0bcbdacb4b0edc5200055d678c7$$ENDHEX$$
if dw_role_pgm.getitemstatus(dw_role_pgm.getrow(), 'indiv_btn_auth_yn', primary!) = datamodified! then
	if messagebox('$$HEX2$$55d678c7$$ENDHEX$$', '$$HEX17$$18c215c82000acc06dd574c7200000c8a5c718b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX13$$34bbdcc258d5e0ac2000c4c989d558d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 1 then
		return 0
	else
		return 1
	end if
end if

return 0

end event

type st_3 from statictext within pf_w_role_mst_ent
integer x = 114
integer y = 64
integer width = 425
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX2$$cbb3c0c6$$ENDHEX$$"
long textcolor = 25123896
long backcolor = 16777215
string text = "$$HEX7$$04d55cb8f8ada8b720008cad5cd5$$ENDHEX$$"
boolean focusrectangle = false
end type

type p_3 from picture within pf_w_role_mst_ent
integer x = 55
integer y = 68
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type dw_role_pgm from pf_u_datawindow within pf_w_role_mst_ent
event ue_enter pbm_dwnprocessenter
integer x = 1989
integer y = 1852
integer width = 2469
integer height = 604
integer taborder = 20
boolean bringtotop = true
string dataobject = "pf_d_role_mst_05"
boolean hscrollbar = true
boolean useborder = false
boolean scaletoright = true
end type

event ue_enter;Send(Handle(this),256,9,Long(0,0))
Return 1

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

type dw_pgm_btn from pf_u_datawindow within pf_w_role_mst_ent
integer x = 1989
integer y = 2548
integer width = 2469
integer height = 292
integer taborder = 30
boolean bringtotop = true
string dataobject = "pf_d_role_mst_06"
boolean vscrollbar = true
boolean useborder = false
boolean scaletoright = true
boolean scaletobottom = true
end type

type p_4 from picture within pf_w_role_mst_ent
integer x = 1993
integer y = 1788
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type st_4 from statictext within pf_w_role_mst_ent
integer x = 2053
integer y = 1784
integer width = 425
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX2$$cbb3c0c6$$ENDHEX$$"
long textcolor = 25123896
string text = "$$HEX5$$84bcbcd220008cad5cd5$$ENDHEX$$"
boolean focusrectangle = false
end type

type p_memb_add from pf_u_imagebutton within pf_w_role_mst_ent
integer x = 3739
integer y = 1076
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long	ll_row, ll_new
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

type p_memb_delete from pf_u_imagebutton within pf_w_role_mst_ent
integer x = 3982
integer y = 1076
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long	ll_row

ll_row = dw_role_memb.getrow()
if ll_row > 0 then
	//ls_memb_code = dw_role_memb.getitemstring(ll_row, 'memb_code')
	//ls_memb_name = dw_role_memb.getitemstring(ll_row, 'memb_name')
	if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX5$$20c1ddd058d5e0c22000$$ENDHEX$$' + string(ll_row) + '$$HEX15$$88bcf8c9200064ba84bc7cb92000adc01cc858d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Exclamation!, YesNo!, 2) = 1 then
		dw_role_memb.deleterow(ll_row)
	end if
end if

end event

type p_memb_update from pf_u_imagebutton within pf_w_role_mst_ent
integer x = 4224
integer y = 1076
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;string	ls_errtext

long ll_modified, i, ll_memb_seq
string ls_role_no, ls_crud_type
datetime ldt_crud_dtm

// Delete History
if is_logging_yn = 'Y' then
	ldt_crud_dtm = pf_f_getdbmsdatetime()
	
	for i = 1 to dw_role_memb.deletedcount()
		ls_role_no = dw_role_memb.getitemstring(i, 'role_no', delete!, true)
		ll_memb_seq = dw_role_memb.getitemnumber(i, 'memb_seq', delete!, true)

		INSERT INTO "pf_role_memb_hist"  
				( "sys_id",   
				  "crud_dtm",   
				  "crud_type",   
				  "role_no",   
				  "memb_seq",   
				  "memb_code1",   
				  "memb_name1",   
				  "memb_code2",   
				  "memb_name2",   
				  "memb_code3",   
				  "memb_name3",   
				  "memb_code4",   
				  "memb_name4",   
				  "memb_code5",   
				  "memb_name5",   
				  "memb_code6",   
				  "memb_name6",   
				  "memb_code7",   
				  "memb_name7",   
				  "memb_code8",   
				  "memb_name8",   
				  "valid_dt_yn",   
				  "valid_dt_from",   
				  "valid_dt_to",   
				  "exclude_yn",   
				  "io_type",   
				  "create_dtm",   
				  "create_user",   
				  "update_dtm",   
				  "update_user" )  
	select		"sys_id",
				:ldt_crud_dtm
				'DEL',
				  "role_no",   
				  "memb_seq",   
				  "memb_code1",   
				  "memb_name1",   
				  "memb_code2",   
				  "memb_name2",   
				  "memb_code3",   
				  "memb_name3",   
				  "memb_code4",   
				  "memb_name4",   
				  "memb_code5",   
				  "memb_name5",   
				  "memb_code6",   
				  "memb_name6",   
				  "memb_code7",   
				  "memb_name7",   
				  "memb_code8",   
				  "memb_name8",   
				  "valid_dt_yn",   
				  "valid_dt_from",   
				  "valid_dt_to",   
				  "exclude_yn",   
				  "io_type",   
				  "create_dtm",   
				  "create_user",   
				  "update_dtm",   
				  "update_user" 	  
		from	pf_role_memb
		where	sys_id = :gnv_session.is_sys_id
		and		role_no = :ls_role_no
		and		memb_seq = :ll_memb_seq;
		
		if sqlca.sqlcode <> 0 then
			messagebox('pf_role_memb_hist error', sqlca.SQLErrText)
		end if
	next
end if

if dw_role_memb.update(true, false) = 1 then
	if is_logging_yn = 'Y' then
		// Insert, Update History
		ll_modified = dw_role_memb.getnextmodified(0, primary!)
		do while ll_modified > 0
			
			ls_role_no = dw_role_memb.getitemstring(ll_modified, 'role_no')
			ll_memb_seq = dw_role_memb.getitemnumber(ll_modified, 'memb_seq')
			
			choose case dw_role_memb.getitemstatus(ll_modified, 0, primary!)
				case newmodified!
					ls_crud_type = "INS"
				case datamodified!
					ls_crud_type = "UPD"
			end choose
			
			INSERT INTO "pf_role_memb_hist"  
					( "sys_id",   
					  "crud_dtm",   
					  "crud_type",   
					  "role_no",   
					  "memb_seq",   
					  "memb_code1",   
					  "memb_name1",   
					  "memb_code2",   
					  "memb_name2",   
					  "memb_code3",   
					  "memb_name3",   
					  "memb_code4",   
					  "memb_name4",   
					  "memb_code5",   
					  "memb_name5",   
					  "memb_code6",   
					  "memb_name6",   
					  "memb_code7",   
					  "memb_name7",   
					  "memb_code8",   
					  "memb_name8",   
					  "valid_dt_yn",   
					  "valid_dt_from",   
					  "valid_dt_to",   
					  "exclude_yn",   
					  "io_type",   
					  "create_dtm",   
					  "create_user",   
					  "update_dtm",   
					  "update_user" )  
		select		"sys_id",
					:ldt_crud_dtm
					:ls_crud_type,
					  "role_no",   
					  "memb_seq",   
					  "memb_code1",   
					  "memb_name1",   
					  "memb_code2",   
					  "memb_name2",   
					  "memb_code3",   
					  "memb_name3",   
					  "memb_code4",   
					  "memb_name4",   
					  "memb_code5",   
					  "memb_name5",   
					  "memb_code6",   
					  "memb_name6",   
					  "memb_code7",   
					  "memb_name7",   
					  "memb_code8",   
					  "memb_name8",   
					  "valid_dt_yn",   
					  "valid_dt_from",   
					  "valid_dt_to",   
					  "exclude_yn",   
					  "io_type",   
					  "create_dtm",   
					  "create_user",   
					  "update_dtm",   
					  "update_user" 	  
			from	pf_role_memb
			where	sys_id = :gnv_session.is_sys_id
			and		role_no = :ls_role_no
			and		memb_seq = :ll_memb_seq;

			if sqlca.sqlcode <> 0 then
				messagebox('pf_role_memb_hist error', sqlca.SQLErrText)
			end if
			
			ll_modified = dw_role_memb.getnextmodified(ll_modified, primary!)
		loop
	end if
	
	dw_role_memb.resetupdate()
	commit using sqlca;
	of_setmessage('$$HEX11$$8cad5cd5200064ba84bc200000c8a5c7200044c6ccb8$$ENDHEX$$!!')
else
	ls_errtext = sqlca.sqlerrtext
	rollback using sqlca;
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX11$$8cad5cd5200064ba84bc200000c8a5c72000e4c228d3$$ENDHEX$$!!~r~n' + 'Error Text: ' + ls_errtext)
end if

end event

type cbx_hierachy from checkbox within pf_w_role_mst_ent
integer x = 1381
integer y = 44
integer width = 576
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 8421504
string text = "$$HEX9$$58d504c76dd5a9ba20007cc704ad20c1ddd0$$ENDHEX$$"
boolean checked = true
end type

type p_pgm_update from pf_u_imagebutton within pf_w_role_mst_ent
integer x = 4219
integer y = 1764
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;string	ls_errtext

if dw_pgm_btn.accepttext() = -1 then return

long ll_row, ll_modified, i
string ls_org_role_no
string ls_role_no, ls_menu_id, ls_crud_type
datetime ldt_crud_dtm

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
		end if
	end if
	
	ll_row = ids_role_pgm.getnextmodified(ll_row, primary!)
loop

if is_logging_yn = 'Y' then
	ldt_crud_dtm = pf_f_getdbmsdatetime()
	
	// Delete History
	for i = 1 to ids_role_pgm.deletedcount()
		ls_role_no = ids_role_pgm.getitemstring(i, 'role_no', delete!, true)
		ls_menu_id = ids_role_pgm.getitemstring(i, 'menu_id', delete!, true)
		
		  INSERT INTO "pf_role_pgm_hist"
				( "sys_id",   
				crud_dtm,
				crud_type,
				  "role_no",   
				  "menu_id",   
				  "valid_dt_yn",   
				  "valid_dt_from",   
				  "valid_dt_to",   
				  "comm_btn_auth_yn",   
				  "retrieve_auth_yn",   
				  "input_auth_yn",   
				  "delete_auth_yn",   
				  "update_auth_yn",   
				  "print_auth_yn",   
				  "execute_auth_yn",   
				  "cancel_auth_yn",   
				  "excel_auth_yn",   
				  "indiv_btn_auth_yn",   
				  "create_dtm",   
				  "create_user",   
				  "update_dtm",   
				  "update_user" )  
		select 
				"sys_id", 
				:ldt_crud_dtm,
				'DEL',
				  "role_no",   
				  "menu_id",   
				  "valid_dt_yn",   
				  "valid_dt_from",   
				  "valid_dt_to",   
				  "comm_btn_auth_yn",   
				  "retrieve_auth_yn",   
				  "input_auth_yn",   
				  "delete_auth_yn",   
				  "update_auth_yn",   
				  "print_auth_yn",   
				  "execute_auth_yn",   
				  "cancel_auth_yn",   
				  "excel_auth_yn",   
				  "indiv_btn_auth_yn",   
				  "create_dtm",   
				  "create_user",   
				  "update_dtm",   
				  "update_user"	
		from pf_role_pgm
		where sys_id = :gnv_session.is_sys_id
		and	role_no = :ls_role_no
		and	menu_id = :ls_menu_id;
		
		if sqlca.sqlcode <> 0 then
			messagebox('pf_role_pgm_hist error', sqlca.SQLErrText)
		end if
	next
end if

if ids_role_pgm.update(true, false) = 1 then
	if dw_pgm_btn.update(true, false) = 1 then
		
		if is_logging_yn = 'Y' then
			// Insert, Update History
			ll_modified = ids_role_pgm.getnextmodified(0, primary!)
			do while ll_modified > 0
				
				ls_role_no = ids_role_pgm.getitemstring(ll_modified, 'role_no')
				ls_menu_id = ids_role_pgm.getitemstring(ll_modified, 'menu_id')
				
				choose case ids_role_pgm.getitemstatus(ll_modified, 0, primary!)
					case newmodified!
						ls_crud_type = "INS"
					case datamodified!
						ls_crud_type = "UPD"
				end choose
				
				  INSERT INTO "pf_role_pgm_hist"
						( "sys_id",   
						crud_dtm,
						crud_type,
						  "role_no",   
						  "menu_id",   
						  "valid_dt_yn",   
						  "valid_dt_from",   
						  "valid_dt_to",   
						  "comm_btn_auth_yn",   
						  "retrieve_auth_yn",   
						  "input_auth_yn",   
						  "delete_auth_yn",   
						  "update_auth_yn",   
						  "print_auth_yn",   
						  "execute_auth_yn",   
						  "cancel_auth_yn",   
						  "excel_auth_yn",   
						  "indiv_btn_auth_yn",   
						  "create_dtm",   
						  "create_user",   
						  "update_dtm",   
						  "update_user" )  
				select 
						"sys_id",   
						:ldt_crud_dtm,
						:ls_crud_type,
						  "role_no",   
						  "menu_id",   
						  "valid_dt_yn",   
						  "valid_dt_from",   
						  "valid_dt_to",   
						  "comm_btn_auth_yn",   
						  "retrieve_auth_yn",   
						  "input_auth_yn",   
						  "delete_auth_yn",   
						  "update_auth_yn",   
						  "print_auth_yn",   
						  "execute_auth_yn",   
						  "cancel_auth_yn",   
						  "excel_auth_yn",   
						  "indiv_btn_auth_yn",   
						  "create_dtm",   
						  "create_user",   
						  "update_dtm",   
						  "update_user"	
				from pf_role_pgm
				where sys_id = :gnv_session.is_sys_id
				and	role_no = :ls_role_no
				and	menu_id = :ls_menu_id;
				
				if sqlca.sqlcode <> 0 then
					messagebox('pf_role_pgm_hist error', sqlca.SQLErrText)
				end if
				
				ll_modified = ids_role_pgm.getnextmodified(ll_modified, primary!)
			loop
		end if
		
		ids_role_pgm.resetupdate()
		dw_pgm_btn.resetupdate()
		commit using sqlca;
		of_setmessage('Role $$HEX10$$04d55cb8f8ada8b7200000c8a5c7200044c6ccb8$$ENDHEX$$!!')
	else
		ls_errtext = sqlca.sqlerrtext
		rollback using sqlca;
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'dw_pgm_btn $$HEX8$$15c8f4bc200000c8a5c72000e4c228d3$$ENDHEX$$!!~r~n' + 'Error Code: ' + string(sqlca.sqldbcode) + ', Error Text: ' + ls_errtext)
		return
	end if
else
	ls_errtext = sqlca.sqlerrtext
	rollback using sqlca;
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'ids_role_pgm $$HEX8$$15c8f4bc200000c8a5c72000e4c228d3$$ENDHEX$$!!~r~n' + 'Error Text: ' + ls_errtext)
	return
end if

ll_row = dw_role_pgm.getrow()
ids_role_pgm.retrieve(gnv_session.is_sys_id, is_current_role_no)
dw_role_pgm.scrolltorow(ll_row)
dw_role_pgm.setrow(ll_row)

end event

type cbx_use_btn_yn from checkbox within pf_w_role_mst_ent
integer x = 2053
integer y = 2460
integer width = 613
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX2$$cbb3c0c6$$ENDHEX$$"
long textcolor = 25123896
string text = "$$HEX9$$1cacc4bc84bcbcd220008cad5cd524c115c8$$ENDHEX$$"
boolean lefttext = true
end type

event clicked;boolean lb_btnscan
long ll_row

ll_row = dw_role_pgm.getrow()
if ll_row = 0 then return

lb_btnscan = this.checked
cb_btnscan.enabled = lb_btnscan

if pf_f_isemptystring(dw_role_pgm.getitemstring(ll_row, 'role_no')) = true then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX21$$04d55cb8f8ada8b72000acc0a9c68cad5cd574c72000b4cc6cd018b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$')
	this.checked = false
	return
end if

if lb_btnscan = true then
	dw_role_pgm.setitem(ll_row, 'indiv_btn_auth_yn', 'Y')
else
	dw_role_pgm.setitem(ll_row, 'indiv_btn_auth_yn', 'N')
end if

end event

type cb_btnscan from pf_u_commandbutton within pf_w_role_mst_ent
integer x = 4151
integer y = 2460
integer width = 306
integer height = 88
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string text = "$$HEX4$$84bcbcd2a4c294ce$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long ll_row

ll_row = dw_role_pgm.getrow()
if ll_row = 0 then return -1

string ls_menu_id, ls_pgm_id
string ls_btn_id, ls_btn_name
windowobject lwo_button[]
integer i, li_btncnt
long ll_find, ll_new

ls_menu_id = dw_role_pgm.getitemstring(ll_row, 'menu_id')
if pf_f_isemptystring(ls_menu_id) = true then return -1

ls_pgm_id = dw_role_pgm.getitemstring(ll_row, 'pgm_id')
if pf_f_isemptystring(ls_pgm_id) = true then return -1

li_btncnt = of_getbuttonlist(ls_pgm_id, lwo_button)

for i = 1 to li_btncnt
	ls_btn_id = lwo_button[i].classname()
	
	ll_find = dw_pgm_btn.find('btn_id="' + ls_btn_id + '"', 1, dw_pgm_btn.rowcount())
	if ll_find = 0 then
		choose case lwo_button[i].typeof()
			case commandbutton!
				commandbutton lcb_button
				lcb_button = lwo_button[i]
				ls_btn_name = lcb_button.text
			case picturebutton!
				picturebutton lpb_button
				lpb_button = lwo_button[i]
				ls_btn_name = lpb_button.text
			case else
				ls_btn_name = ''
		end choose
		
		ll_new = dw_pgm_btn.insertrow(0)
		
		dw_pgm_btn.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
		dw_pgm_btn.setitem(ll_new, 'role_no', is_current_role_no)
		dw_pgm_btn.setitem(ll_new, 'menu_id', ls_menu_id)
		dw_pgm_btn.setitem(ll_new, 'btn_id', ls_btn_id)
		dw_pgm_btn.setitem(ll_new, 'btn_use_yn', 'Y')
		dw_pgm_btn.setitem(ll_new, 'btn_name', ls_btn_name)
	end if
next

end event

type cb_1 from pf_u_commandbutton within pf_w_role_mst_ent
integer x = 850
integer y = 28
integer width = 512
integer height = 96
integer taborder = 20
boolean bringtotop = true
string text = "$$HEX9$$04d55cb8f8ada8b720008cad5cd5f5bcacc0$$ENDHEX$$"
end type

event clicked;call super::clicked;if is_current_role_no = '' then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX16$$3cba00c82000f5bcacc020b420008cad5cd544c7200020c1ddd058d538c194c6$$ENDHEX$$')
	return
end if

if is_current_role_no = '00001' then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX24$$00adacb990c720008cad5cd5d0c5200000b35cd5200004d55cb8f8ada8b720008cad5cd515c8f4bc94b22000f5bcacc0$$ENDHEX$$(Overwrite)$$HEX8$$20b4200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
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
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX21$$04d6acc720008cad5cd5fcac200019ac40c720008cad5cd544c7200020c1ddd058d568c1b5c2c8b2e4b2$$ENDHEX$$')
		return
	end if
	
	if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX36$$04d55cb8f8ada8b720008cad5cd5f5bcacc07cb9200058d58cac18b474ba200004d6acc720008cad5cd5d0c5200024c115c81cb4200004d55cb8f8ada8b7200015c8f4bc00ac2000$$ENDHEX$$Overwrite $$HEX3$$29b4c8b2e4b2$$ENDHEX$$. $$HEX8$$c4c989d558d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Exclamation!, YesNo!, 2) = 2 then return
	
	// $$HEX12$$30ae74c820008cad5cd504d55cb8f8ada8b72000adc01cc8$$ENDHEX$$
	delete		pf_role_pgm
	where	sys_id = :gnv_session.is_sys_id
	and		role_no = :is_current_role_no
	using		sqlca;
	
	delete		pf_role_pgm_btn
	where	sys_id = :gnv_session.is_sys_id
	and		role_no = :is_current_role_no
	using		sqlca;
	
	// $$HEX10$$8cad5cd5200004d55cb8f8ada8b7200074ce3cd5$$ENDHEX$$
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
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX27$$04d55cb8f8ada8b720008cad5cd544c72000f5bcacc058d594b2200011c9200024c658b900ac20001cbcddc058d500c6b5c2c8b2e4b2$$ENDHEX$$~r~n' + ls_errmsg)
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
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX27$$04d55cb8f8ada8b720008cad5cd544c72000f5bcacc058d594b2200011c9200024c658b900ac20001cbcddc058d500c6b5c2c8b2e4b2$$ENDHEX$$~r~n' + ls_errmsg)
		return
	end if
	
	commit using sqlca;
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX15$$8cad5cd5200004d55cb8f8ada8b744c72000f5bcacc088d5b5c2c8b2e4b2$$ENDHEX$$')
	
	dw_role_mst.post event rowfocuschanged(dw_role_mst.getrow())
end if

end event

type p_5 from picture within pf_w_role_mst_ent
integer x = 1993
integer y = 2480
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

