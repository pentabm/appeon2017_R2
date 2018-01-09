HA$PBExportHeader$pf_w_btn_role_ent_pgm.srw
$PBExportComments$$$HEX39$$04d55cb8f8ada8b72000c4bc20008cad5cd5f8adf9b858c72000f5acb5d1200084bcbcd220008cad5cd544c720007cc704ad2000f1b45db858d594b2200004d55cb8f8ada8b7200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_btn_role_ent_pgm from pf_w_sheet
end type
type dw_rolepgm from pf_u_datawindow within pf_w_btn_role_ent_pgm
end type
type st_1 from pf_u_splitbar_vertical within pf_w_btn_role_ent_pgm
end type
type p_3 from picture within pf_w_btn_role_ent_pgm
end type
type st_4 from pf_u_statictext within pf_w_btn_role_ent_pgm
end type
type tv_fullmenu from pf_u_treeview within pf_w_btn_role_ent_pgm
end type
type st_2 from statictext within pf_w_btn_role_ent_pgm
end type
type p_2 from picture within pf_w_btn_role_ent_pgm
end type
type p_retrieve from pf_u_imagebutton within pf_w_btn_role_ent_pgm
end type
type p_update from pf_u_imagebutton within pf_w_btn_role_ent_pgm
end type
type p_close from pf_u_imagebutton within pf_w_btn_role_ent_pgm
end type
end forward

global type pf_w_btn_role_ent_pgm from pf_w_sheet
dw_rolepgm dw_rolepgm
st_1 st_1
p_3 p_3
st_4 st_4
tv_fullmenu tv_fullmenu
st_2 st_2
p_2 p_2
p_retrieve p_retrieve
p_update p_update
p_close p_close
end type
global pf_w_btn_role_ent_pgm pf_w_btn_role_ent_pgm

type variables
pf_n_userrole inv_user_role
treeview itv_fullmenu

datastore ids_fullmenu

pf_m_treeview im_menu
long il_fullmenu_hndl
end variables

forward prototypes
public function integer of_getbuttonlist (string as_pgm_id, ref windowobject awo_button[])
public function long of_getwindowcontrols (windowobject awo_input[], ref windowobject awo_output[])
public subroutine of_set_com_btn_auth_yn ()
public function integer of_set_pgm_fullmenu ()
end prototypes

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

public subroutine of_set_com_btn_auth_yn ();// $$HEX9$$f5acb5d184bcbcd22000acc0a9c6ecc580bd$$ENDHEX$$(Y/N)$$HEX7$$44c7200024c115c869d5c8b2e4b2$$ENDHEX$$.

string ls_comm_btn_auth_yn
string ls_retrieve_auth_yn
string ls_input_auth_yn
string ls_delete_auth_yn
string ls_update_auth_yn
string ls_print_auth_yn
string ls_execute_auth_yn
string ls_cancel_auth_yn
string ls_excel_auth_yn
long ll_row

ll_row = dw_rolepgm.getrow()
if ll_row = 0 then return

ls_retrieve_auth_yn = dw_rolepgm.getitemstring(ll_row, 'retrieve_auth_yn')
ls_input_auth_yn = dw_rolepgm.getitemstring(ll_row, 'input_auth_yn')
ls_delete_auth_yn = dw_rolepgm.getitemstring(ll_row, 'delete_auth_yn')
ls_update_auth_yn = dw_rolepgm.getitemstring(ll_row, 'update_auth_yn')
ls_print_auth_yn = dw_rolepgm.getitemstring(ll_row, 'print_auth_yn')
ls_execute_auth_yn = dw_rolepgm.getitemstring(ll_row, 'execute_auth_yn')
ls_cancel_auth_yn = dw_rolepgm.getitemstring(ll_row, 'cancel_auth_yn')
ls_excel_auth_yn = dw_rolepgm.getitemstring(ll_row, 'excel_auth_yn')

if isnull(ls_retrieve_auth_yn) then ls_retrieve_auth_yn = ''
if isnull(ls_input_auth_yn) then ls_input_auth_yn = ''
if isnull(ls_delete_auth_yn) then ls_delete_auth_yn = ''
if isnull(ls_update_auth_yn) then ls_update_auth_yn = ''
if isnull(ls_print_auth_yn) then ls_print_auth_yn = ''
if isnull(ls_execute_auth_yn) then ls_execute_auth_yn = ''
if isnull(ls_cancel_auth_yn) then ls_cancel_auth_yn = ''
if isnull(ls_excel_auth_yn) then ls_excel_auth_yn = ''

if	ls_retrieve_auth_yn = 'Y' or &
	ls_input_auth_yn  = 'Y' or &
	ls_delete_auth_yn = 'Y' or &
	ls_update_auth_yn  = 'Y' or &
	ls_print_auth_yn  = 'Y' or &
	ls_execute_auth_yn  = 'Y' or &
	ls_cancel_auth_yn  = 'Y' or &
	ls_excel_auth_yn = 'Y' then
	ls_comm_btn_auth_yn = 'Y'
else
	ls_comm_btn_auth_yn = 'N'
end if

dw_rolepgm.setitem(ll_row, 'comm_btn_auth_yn', ls_comm_btn_auth_yn)

end subroutine

public function integer of_set_pgm_fullmenu ();long ll_rowcnt, ll_handle, i
treeviewitem ltvi_item
long ll_level, ll_parent[]

itv_fullmenu.setredraw(false)

ll_handle = itv_fullmenu.finditem(roottreeitem!, 0)
do while ll_handle > 0
	itv_fullmenu.deleteitem(ll_handle)
	ll_handle = itv_fullmenu.finditem(roottreeitem!, ll_handle)
loop

ll_rowcnt = ids_fullmenu.retrieve(gnv_session.is_sys_id, 'ROOT')
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
		ltvi_item.Children = true
	else
		ltvi_item.Children = false
	end if
	
	ltvi_item.HasFocus = false
	ltvi_item.selected = false
	
	ll_level = ids_fullmenu.getitemnumber(i, 'tree_level')
	ll_handle = itv_fullmenu.InsertItemLast(ll_parent[ll_level], ltvi_item)
	if ids_fullmenu.getitemstring(i, 'pgm_kind_code') = 'M' then
		ll_parent[ll_level + 1] = ll_handle
	end if
next

itv_fullmenu.ExpandAll(ll_parent[2])
itv_fullmenu.setredraw(true)

//itv_fullmenu.post selectitem(ll_parent[1])
return ll_rowcnt
return 0
end function

on pf_w_btn_role_ent_pgm.create
int iCurrent
call super::create
this.dw_rolepgm=create dw_rolepgm
this.st_1=create st_1
this.p_3=create p_3
this.st_4=create st_4
this.tv_fullmenu=create tv_fullmenu
this.st_2=create st_2
this.p_2=create p_2
this.p_retrieve=create p_retrieve
this.p_update=create p_update
this.p_close=create p_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_rolepgm
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.p_3
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.tv_fullmenu
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.p_2
this.Control[iCurrent+8]=this.p_retrieve
this.Control[iCurrent+9]=this.p_update
this.Control[iCurrent+10]=this.p_close
end on

on pf_w_btn_role_ent_pgm.destroy
call super::destroy
destroy(this.dw_rolepgm)
destroy(this.st_1)
destroy(this.p_3)
destroy(this.st_4)
destroy(this.tv_fullmenu)
destroy(this.st_2)
destroy(this.p_2)
destroy(this.p_retrieve)
destroy(this.p_update)
destroy(this.p_close)
end on

event open;call super::open;inv_user_role = create pf_n_userrole

itv_fullmenu = tv_fullmenu

ids_fullmenu = create datastore

choose case upper(left(sqlca.dbms, 3))
	// Oracle
	case 'O80', 'O90', 'O10', 'ORA'
		ids_fullmenu.dataobject = 'pf_d_role_search_04_oracle'
	// Else
	case else
		ids_fullmenu.dataobject = 'pf_d_role_search_04_asa'
end choose

ids_fullmenu.settransobject(sqlca)

im_menu = create pf_m_treeview

end event

event activate;call super::activate;tv_fullmenu.SetFocus()
end event

event pfe_postopen;call super::pfe_postopen;p_retrieve.post event clicked()


end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_btn_role_ent_pgm
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_btn_role_ent_pgm
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_btn_role_ent_pgm
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_btn_role_ent_pgm
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_btn_role_ent_pgm
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_btn_role_ent_pgm
end type

type dw_rolepgm from pf_u_datawindow within pf_w_btn_role_ent_pgm
integer x = 1499
integer y = 220
integer width = 3063
integer height = 2000
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_btn_role_05"
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorting = false
boolean scaletoright = true
boolean scaletobottom = true
end type

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'retrieve_auth_yn', 'input_auth_yn', 'delete_auth_yn', 'update_auth_yn', &
		'print_auth_yn', 'execute_auth_yn', 'cancel_auth_yn', 'excel_auth_yn'
	parent.post of_set_com_btn_auth_yn()
end choose

end event

type st_1 from pf_u_splitbar_vertical within pf_w_btn_role_ent_pgm
integer x = 1481
integer y = 208
integer height = 2016
boolean bringtotop = true
string leftdragobject = "tv_fullmenu"
string rightdragobject = "dw_rolepgm; p_3; st_4"
end type

type p_3 from picture within pf_w_btn_role_ent_pgm
integer x = 1499
integer y = 168
integer width = 46
integer height = 40
boolean bringtotop = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type st_4 from pf_u_statictext within pf_w_btn_role_ent_pgm
string tag = "onVSplitScroll=NoResize"
integer x = 1568
integer y = 172
integer width = 553
integer height = 44
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = hangeul!
string facename = "$$HEX2$$cbb3c0c6$$ENDHEX$$"
long textcolor = 25123896
long backcolor = 16777215
string text = "$$HEX8$$f5acb5d1200084bcbcd220008cad5cd5$$ENDHEX$$"
end type

type tv_fullmenu from pf_u_treeview within pf_w_btn_role_ent_pgm
integer x = 50
integer y = 220
integer width = 1431
integer height = 2000
integer taborder = 40
boolean bringtotop = true
long textcolor = 20132659
boolean linesatroot = true
string picturename[] = {"Application5!","ApplicationIcon!","Custom039!","Open!"}
long picturemaskcolor = 12632256
boolean scaletobottom = true
end type

event rightclicked;call super::rightclicked;treeviewitem ltvi_item

if this.getitem(handle, ltvi_item) = -1 then return

choose case ltvi_item.PictureIndex
	case 3, 4
		il_fullmenu_hndl = handle
		im_menu.popmenu(iw_parent.pointerx(), iw_parent.pointery())
	case 1, 2
end choose

end event

event selectionchanged;treeviewitem ltvi_item
string ls_menu_id

if this.getitem(newhandle, ltvi_item) > 0 then
	ls_menu_id = ltvi_item.data

	dw_rolepgm.reset()
	dw_rolepgm.retrieve(gnv_session.is_sys_id, ls_menu_id)
end if

end event

type st_2 from statictext within pf_w_btn_role_ent_pgm
integer x = 114
integer y = 164
integer width = 549
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX2$$cbb3c0c6$$ENDHEX$$"
long textcolor = 25123896
string text = "$$HEX10$$04c8b4cc200004d55cb8f8ada8b7200054ba74b2$$ENDHEX$$"
boolean focusrectangle = false
end type

type p_2 from picture within pf_w_btn_role_ent_pgm
integer x = 50
integer y = 168
integer width = 46
integer height = 40
boolean bringtotop = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type p_retrieve from pf_u_imagebutton within pf_w_btn_role_ent_pgm
integer x = 3831
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_retrieve.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;parent.of_set_pgm_fullmenu()

end event

type p_update from pf_u_imagebutton within pf_w_btn_role_ent_pgm
integer x = 4073
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX10$$84bcbcd2200030aef8bc15c8f4bc200000c8a5c7$$ENDHEX$$

if dw_rolepgm.accepttext() = -1 then return

if dw_rolepgm.modifiedcount() + dw_rolepgm.deletedcount() = 0 then
	return
end if

if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX14$$c0bcbdacacc06dd544c7200000c8a5c758d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 2 then return

string ls_errtext

if dw_rolepgm.update(true, false) = 1 then
	commit using sqlca;
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX7$$00c8a5c718b4c8c5b5c2c8b2e4b2$$ENDHEX$$')
else
	ls_errtext = sqlca.sqlerrtext
	rollback using sqlca;
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX25$$44c598b740c6200019ac40c7200074c720c75cb8200090c7ccb8200000c8a5c7d0c52000e4c228d358d500c6b5c2c8b2e4b2$$ENDHEX$$~r~n' + ls_errtext)
end if

end event

type p_close from pf_u_imagebutton within pf_w_btn_role_ent_pgm
integer x = 4315
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)

end event

