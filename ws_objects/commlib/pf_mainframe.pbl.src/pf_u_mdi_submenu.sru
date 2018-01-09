$PBExportHeader$pf_u_mdi_submenu.sru
forward
global type pf_u_mdi_submenu from pf_u_userobject
end type
type dw_submenu from datawindow within pf_u_mdi_submenu
end type
type p_submenu_bkg from picture within pf_u_mdi_submenu
end type
end forward

global type pf_u_mdi_submenu from pf_u_userobject
integer width = 3163
integer height = 120
event pfe_menuclicked ( string as_menu_id,  string as_pgm_id,  string as_pgm_nm )
dw_submenu dw_submenu
p_submenu_bkg p_submenu_bkg
end type
global pf_u_mdi_submenu pf_u_mdi_submenu

type prototypes

end prototypes

type variables
private:
	pf_n_rolemenu inv_menuauth
	long il_max_width
	long ITEM_HGAP = 50

end variables

forward prototypes
public function integer of_drawsubmenu (string as_parent_menu)
public function string of_getclassname ()
end prototypes

event pfe_menuclicked(string as_menu_id, string as_pgm_id, string as_pgm_nm);// Add script to the MDI frame

end event

public function integer of_drawsubmenu (string as_parent_menu);string	ls_pgm_nm, ls_menu_id
string	ls_col_nm, ls_error
pf_s_size lstr_size
pf_n_syntaxbuffer ln_buffer
pf_s_point lstr_point
integer i, li_xpos

ln_buffer = create pf_n_syntaxbuffer

this.setredraw(false)
this.post setredraw(true)

dw_submenu.reset()
dw_submenu.insertrow(0)

inv_menuauth.of_getmenudata('parent', as_parent_menu)
//inv_menuauth.ids_menudata.retrieve(gnv_session.is_sys_id, gnv_session.inv_userauth.is_userrole[], 'parent', as_parent_menu, gnv_session.of_getstring("login_dt"))

for i = 1 to inv_menuauth.ids_menudata.rowcount()
	ls_col_nm = "pgm_name"+ string(i)
	
	ls_menu_id = inv_menuauth.ids_menudata.getitemstring(i, 'menu_id')
	ls_pgm_nm = inv_menuauth.ids_menudata.getitemstring(i, 'pgm_name')
	
	dw_submenu.setitem(1, 'pgm_name' + string(i), ls_pgm_nm)
	dw_submenu.setitem(1, 'menu_id' + string(i), ls_menu_id)
	
	//gnv_extfunc.of_gettextsizew(handle(this), ls_pgm_nm, dw_submenu.describe(ls_col_nm + ".Font.Face"), -long(dw_submenu.describe(ls_col_nm + ".Font.Height")), long(dw_submenu.describe(ls_col_nm + ".Font.Weight")), lstr_size)
	//gnv_extfunc.of_gettextsize(handle(this), ls_pgm_nm, dw_submenu.describe(ls_col_nm + ".Font.Face"), -long(dw_submenu.describe(ls_col_nm + ".Font.Height")), long(dw_submenu.describe(ls_col_nm + ".Font.Weight")), lstr_size)
	
	ln_buffer.of_append(ls_col_nm + ".x='" + string(li_xpos) + "'")
	ln_buffer.of_append(ls_col_nm + ".width='" + string(pixelstounits(lstr_size.width, xpixelstounits!)) + "'")
	
	li_xpos += pixelstounits(lstr_size.width, xpixelstounits!) + ITEM_HGAP
next

ls_error = dw_submenu.modify(ln_buffer.of_tostring())
if len(ls_error) > 0 then
	messagebox('Datawindow.Modify Error', ls_error)
	return -1
end if

// get maximum dwo width
if inv_menuauth.ids_menudata.rowcount() > 0 then
	il_max_width = long(dw_submenu.describe("pgm_name"+ string(inv_menuauth.ids_menudata.rowcount()) + ".x")) + long(dw_submenu.describe("pgm_name"+ string(inv_menuauth.ids_menudata.rowcount()) + ".width"))
else
	il_max_width = 0
end if

dw_submenu.width = il_max_width

// set the submenu xposition
if gnv_extfunc.getcursorpos(lstr_point) = true then
	dw_submenu.x = iw_parent.pointerx()
	
	if this.width - pixelstounits(10, xpixelstounits!) < dw_submenu.x + dw_submenu.width then
		dw_submenu.x = this.width - dw_submenu.width - pixelstounits(10, xpixelstounits!)
	end if
end if

// program full path 출력용
gnv_session.of_put('submenu_pgm_name', '')

return 0

end function

public function string of_getclassname ();return 'pf_u_mdi_submenu'

end function

on pf_u_mdi_submenu.create
int iCurrent
call super::create
this.dw_submenu=create dw_submenu
this.p_submenu_bkg=create p_submenu_bkg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_submenu
this.Control[iCurrent+2]=this.p_submenu_bkg
end on

on pf_u_mdi_submenu.destroy
call super::destroy
destroy(this.dw_submenu)
destroy(this.p_submenu_bkg)
end on

event resize;call super::resize;p_submenu_bkg.width = this.width + 100

end event

event destructor;call super::destructor;//destroy ids_menudata
destroy inv_menuauth

end event

event pfe_postopen;call super::pfe_postopen;inv_menuauth = create pf_n_rolemenu

dw_submenu.insertrow(0)

end event

type p_background from pf_u_userobject`p_background within pf_u_mdi_submenu
end type

type dw_submenu from datawindow within pf_u_mdi_submenu
integer x = 1582
integer y = 4
integer width = 1413
integer height = 120
integer taborder = 10
string title = "none"
string dataobject = "pf_d_mdi_submenu"
boolean border = false
boolean livescroll = true
end type

event clicked;string	ls_menu_id, ls_pgm_nm, ls_seq

choose case string(dwo.type)
	case 'column'
		ls_seq = mid(dwo.name, 9)
		
		ls_menu_id = this.getitemstring(row, 'menu_id' + ls_seq)
		ls_pgm_nm = this.getitemstring(row, 'pgm_name' + ls_seq)
		
		// program full path 출력용
		gnv_session.of_put('submenu_pgm_name', ls_pgm_nm)
		
		parent.post event pfe_menuclicked(ls_menu_id, '', ls_pgm_nm)
	case else
		return 0
end choose

return 0

end event

type p_submenu_bkg from picture within pf_u_mdi_submenu
integer y = 4
integer width = 6002
integer height = 120
string picturename = "..\img\mainframe\u_mdi_submenu\top_submenu_bg.gif"
boolean focusrectangle = false
end type

