HA$PBExportHeader$pf_w_mainframe_type1.srw
$PBExportComments$$$HEX9$$0cd3ccc604d508b884c7200030aef8bc2000$$ENDHEX$$MDI $$HEX6$$54d674ba200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_mainframe_type1 from pf_w_frame
end type
type p_logo from pf_u_picture within pf_w_mainframe_type1
end type
type p_topback from pf_u_picture within pf_w_mainframe_type1
end type
type p_home from pf_u_imagebutton within pf_w_mainframe_type1
end type
type p_logout from pf_u_imagebutton within pf_w_mainframe_type1
end type
type p_fullscreen from pf_u_imagebutton within pf_w_mainframe_type1
end type
type p_close from pf_u_imagebutton within pf_w_mainframe_type1
end type
type dw_logininfo from pf_u_datawindow within pf_w_mainframe_type1
end type
type p_favorite from pf_u_imagebutton within pf_w_mainframe_type1
end type
type dw_menutitle from pf_u_datawindow within pf_w_mainframe_type1
end type
type p_menu from pf_u_imagebutton within pf_w_mainframe_type1
end type
type st_vsplit from pf_u_splitbar_vertical within pf_w_mainframe_type1
end type
type uo_sheettab from pf_u_mdi_sheettab within pf_w_mainframe_type1
end type
type p_hide from pf_u_imagebutton within pf_w_mainframe_type1
end type
type uo_xpmenu from pf_u_mdi_xpmenu within pf_w_mainframe_type1
end type
type uo_favorite from pf_u_mdi_favorite within pf_w_mainframe_type1
end type
type dw_topmenu from pf_u_mdi_iconmenu within pf_w_mainframe_type1
end type
type uo_status from pf_u_mdi_statusbar within pf_w_mainframe_type1
end type
end forward

global type pf_w_mainframe_type1 from pf_w_frame
integer width = 5893
integer height = 3312
long backcolor = 13487565
p_logo p_logo
p_topback p_topback
p_home p_home
p_logout p_logout
p_fullscreen p_fullscreen
p_close p_close
dw_logininfo dw_logininfo
p_favorite p_favorite
dw_menutitle dw_menutitle
p_menu p_menu
st_vsplit st_vsplit
uo_sheettab uo_sheettab
p_hide p_hide
uo_xpmenu uo_xpmenu
uo_favorite uo_favorite
dw_topmenu dw_topmenu
uo_status uo_status
end type
global pf_w_mainframe_type1 pf_w_mainframe_type1

type variables
protected:
	string is_resized
	pf_n_animate inv_animate
	graphicobject igo_selected
	boolean ib_leftmenu_visible
	long il_vsplit_xpos, il_normalmenuwidth, il_hiddenmenuwidth
public:
	ulong MainFrameBackgroundColor = RGB(205,205,205)
	ulong MDIClientBackgroundColor = RGB(205,205,205)

end variables

forward prototypes
public function integer of_setresize (boolean ab_switch)
public function string of_getclassname ()
public subroutine of_logout_job ()
public function integer of_opensheet (string as_menu_id, string as_pgm_id, string as_pgm_name)
end prototypes

public function integer of_setresize (boolean ab_switch);integer	li_rc

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid (inv_resize) then
		inv_resize = create pf_n_resize
		inv_resize.of_SetOrigSize (long(gnv_appconf.of_getprofile("mdi.original.width", "0")), long(gnv_appconf.of_getprofile("mdi.original.height", "0")))
		inv_resize.of_SetMinSize(pixelstounits(800, xpixelstounits!), pixelstounits(600, ypixelstounits!))
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

public function string of_getclassname ();return 'pf_w_mainframe_type1'

end function

public subroutine of_logout_job ();// LEFT $$HEX13$$54ba74b2200028c240aec1c0dcd07cb92000f4bc00ad74d51cc1$$ENDHEX$$
// $$HEX21$$e4b24cc7200024c608d52000dcc22000d9b37cc75cd52000c1c0dcd07cb9200020c7c0c969d5c8b2e4b2$$ENDHEX$$.

boolean lb_leftmenu_visible

if gnv_appconf.of_getprofile("mdi.leftmenu.visible", "true") = "true" then
	lb_leftmenu_visible = true
end if

if lb_leftmenu_visible <> ib_leftmenu_visible then
	if ib_leftmenu_visible = true then
		gnv_appconf.of_setprofile("mdi.leftmenu.visible", "true")
	else
		gnv_appconf.of_setprofile("mdi.leftmenu.visible", "false")
	end if
end if

end subroutine

public function integer of_opensheet (string as_menu_id, string as_pgm_id, string as_pgm_name);pf_n_menudata lnv_menu
window lw_child

// $$HEX14$$74c8acc758d5c0c94ac594b2200004d55cb8f8ada8b7200055d678c7$$ENDHEX$$
if appeongetclienttype() = 'PB' then
	classdefinition lcd_win
	lcd_win = FindClassDefinition(as_pgm_id)
	if isnull(lcd_win) then
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + as_pgm_name + '] $$HEX20$$20c1ddd058d5e0c2200004d55cb8f8ada8b740c7200004d6acc720001cac1cbc11c985c7c8b2e4b2$$ENDHEX$$~r~n$$HEX12$$98b011c9d0c52000e4b2dcc2200055d678c758d538c194c6$$ENDHEX$$')
		return -1
	end if
end if

// HourGlass $$HEX7$$98ccacb9200048c5200058d574ba$$ENDHEX$$, $$HEX9$$08c7c4b3b0c6200024c608d52000dcc2d0c5$$ENDHEX$$
// $$HEX18$$14bcd5d054d674ba74c7200074d0adb918b494b2200004d6c1c074c720001cbcddc028b4$$ENDHEX$$
setpointer(hourglass!)
post setpointer(arrow!)
if appeongetclienttype() = 'WEB' then
	this.setredraw(false)
	this.post setredraw(true)
end if

// $$HEX11$$08c7c4b3b0c620000cd37cb7f8bb30d1200024c115c8$$ENDHEX$$
lnv_menu = create pf_n_menudata
lnv_menu.is_menu_id = as_menu_id
lnv_menu.is_pgm_id = as_pgm_id
lnv_menu.is_pgm_name = as_pgm_name

// $$HEX9$$dcc2b8d2200008c7c4b3b0c6200024c608d5$$ENDHEX$$
if uo_sheettab.of_isOpenedSheet(as_menu_id) = false then
	gnv_session.of_put(upper(lnv_menu.is_pgm_id), lnv_menu)
	opensheet(lw_child, lnv_menu.is_pgm_id, this, 0, Original!)
else
	uo_sheettab.of_SheetSetfocus(as_menu_id)
end if

return 1

end function

on pf_w_mainframe_type1.create
int iCurrent
call super::create
this.p_logo=create p_logo
this.p_topback=create p_topback
this.p_home=create p_home
this.p_logout=create p_logout
this.p_fullscreen=create p_fullscreen
this.p_close=create p_close
this.dw_logininfo=create dw_logininfo
this.p_favorite=create p_favorite
this.dw_menutitle=create dw_menutitle
this.p_menu=create p_menu
this.st_vsplit=create st_vsplit
this.uo_sheettab=create uo_sheettab
this.p_hide=create p_hide
this.uo_xpmenu=create uo_xpmenu
this.uo_favorite=create uo_favorite
this.dw_topmenu=create dw_topmenu
this.uo_status=create uo_status
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_logo
this.Control[iCurrent+2]=this.p_topback
this.Control[iCurrent+3]=this.p_home
this.Control[iCurrent+4]=this.p_logout
this.Control[iCurrent+5]=this.p_fullscreen
this.Control[iCurrent+6]=this.p_close
this.Control[iCurrent+7]=this.dw_logininfo
this.Control[iCurrent+8]=this.p_favorite
this.Control[iCurrent+9]=this.dw_menutitle
this.Control[iCurrent+10]=this.p_menu
this.Control[iCurrent+11]=this.st_vsplit
this.Control[iCurrent+12]=this.uo_sheettab
this.Control[iCurrent+13]=this.p_hide
this.Control[iCurrent+14]=this.uo_xpmenu
this.Control[iCurrent+15]=this.uo_favorite
this.Control[iCurrent+16]=this.dw_topmenu
this.Control[iCurrent+17]=this.uo_status
end on

on pf_w_mainframe_type1.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_logo)
destroy(this.p_topback)
destroy(this.p_home)
destroy(this.p_logout)
destroy(this.p_fullscreen)
destroy(this.p_close)
destroy(this.dw_logininfo)
destroy(this.p_favorite)
destroy(this.dw_menutitle)
destroy(this.p_menu)
destroy(this.st_vsplit)
destroy(this.uo_sheettab)
destroy(this.p_hide)
destroy(this.uo_xpmenu)
destroy(this.uo_favorite)
destroy(this.dw_topmenu)
destroy(this.uo_status)
end on

event open;call super::open;// Background Color $$HEX2$$24c115c8$$ENDHEX$$
this.backcolor = MainFrameBackgroundColor
mdi_1.backcolor = MainFrameBackgroundColor

// MDI $$HEX6$$c0d074c7c0d2200024c115c8$$ENDHEX$$
//this.title = gnv_appmgr.is_sys_name

// $$HEX8$$60c5c8b254ba74c758c12000a8d6fcac$$ENDHEX$$
inv_animate = create pf_n_animate

end event

event pfe_postopen;call super::pfe_postopen;// $$HEX7$$a4c20cd5bfb914bc200024c115c8$$ENDHEX$$
st_vsplit.of_set_leftobject(dw_menutitle)
st_vsplit.of_set_leftobject(uo_xpmenu)
st_vsplit.of_set_leftobject(uo_favorite)
st_vsplit.of_set_rightobject(st_mdiclient)
st_vsplit.of_set_rightobject(uo_sheettab)
st_vsplit.of_set_minsize(250, 250)

// $$HEX9$$5cb8f8ad78c7200015c8f4bc200024c115c8$$ENDHEX$$
pf_n_userrole lnv_user
lnv_user = gnv_session.of_get("userrole")

dw_logininfo.settransobject(sqlca)
dw_logininfo.insertrow(0)
dw_logininfo.modify('username_t.text="' + gnv_session.is_user_name + '"')
dw_logininfo.modify('logindtm_t.text="$$HEX3$$5cb8f8ad78c7$$ENDHEX$$:' + string(gnv_session.idtm_login, 'YYYY/MM/DD') + " " + string(gnv_session.idtm_login, 'HH:MM:SS') + '"')
//dw_logininfo.setitem(1, 'dept_cd', lnv_user.of_getuserinfo("dept_cd"))

// Top $$HEX5$$54ba74b2200070c88cd6$$ENDHEX$$
dw_topmenu.of_drawtopmenu()

// HOME $$HEX6$$08c7c4b3b0c6200024c608d5$$ENDHEX$$
p_home.event clicked()

// $$HEX11$$90c9a8ac3ecc30ae200054ba74b220005cd631c154d6$$ENDHEX$$
if gnv_appconf.of_getprofile("mdi.leftmenu.visible", "true") = "true" then
	ib_leftmenu_visible = true
else
	ib_leftmenu_visible = false
end if

il_normalmenuwidth = uo_favorite.width
il_hiddenmenuwidth = uo_favorite.width

//uo_favorite.hide()
uo_favorite.of_drawleftmenu(gnv_session.is_user_id)
p_favorite.event clicked()

// LEFT $$HEX7$$54ba74b22000c1c0dcd024c115c8$$ENDHEX$$
if ib_leftmenu_visible = false then
	ib_leftmenu_visible = true
	uo_xpmenu.visible = false
	p_hide.event clicked()
end if

end event

event close;call super::close;this.of_logout_job()

if isvalid(inv_animate) then
	destroy inv_animate
end if

end event

type st_mdiclient from pf_w_frame`st_mdiclient within pf_w_mainframe_type1
integer x = 1248
integer y = 452
integer width = 4562
integer height = 2568
end type

type p_logo from pf_u_picture within pf_w_mainframe_type1
integer x = 41
integer y = 16
integer width = 1042
integer height = 156
boolean bringtotop = true
string pointer = "HyperLink!"
boolean originalsize = false
string picturename = "..\img\mainframe\w_mainframe_type1\logo_penta.png"
boolean transparentbackground = true
end type

event clicked;call super::clicked;inet lnv_inet

GetContextService("Internet", lnv_inet)
lnv_inet.HyperlinkToURL("http://www.penta.co.kr")

end event

type p_topback from pf_u_picture within pf_w_mainframe_type1
integer width = 5856
integer height = 324
boolean originalsize = false
string picturename = "..\img\mainframe\w_mainframe_type1\top_mid.jpg"
boolean scaletoright = true
end type

type p_home from pf_u_imagebutton within pf_w_mainframe_type1
integer x = 4338
integer y = 12
integer width = 421
integer height = 84
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\mainframe\w_mainframe_type1\home.jpg"
boolean fixedtoright = true
end type

event clicked;call super::clicked;window lw_child
pf_n_menudata lnv_menu
lnv_menu = create pf_n_menudata

lnv_menu.is_menu_id = 'PF_W_HOME1'
lnv_menu.is_pgm_id = 'PF_W_HOME1'
lnv_menu.is_pgm_name = '$$HEX5$$f5acc0c92000acc06dd5$$ENDHEX$$'

if uo_sheettab.of_isOpenedSheet(lnv_menu.is_menu_id) = false then
	gnv_session.of_put(lnv_menu.is_pgm_id, lnv_menu)
	OpenSheet(lw_child, lnv_menu.is_pgm_id, parent, 0, Original!)
else
	uo_sheettab.of_SheetSetfocus(lnv_menu.is_pgm_id)
end if

end event

type p_logout from pf_u_imagebutton within pf_w_mainframe_type1
integer x = 4759
integer y = 12
integer width = 398
integer height = 84
boolean bringtotop = true
string picturename = "..\img\mainframe\w_mainframe_type1\logout.jpg"
boolean fixedtoright = true
end type

event clicked;call super::clicked;IF MessageBox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX11$$5cb8f8ad44c5c3c6200058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 1 THEN
	gnv_appmgr.post event pfe_logoutprocess()
END IF

end event

type p_fullscreen from pf_u_imagebutton within pf_w_mainframe_type1
integer x = 5157
integer y = 12
integer width = 416
integer height = 84
boolean bringtotop = true
string picturename = "..\img\mainframe\w_mainframe_type1\fullscreen.jpg"
boolean fixedtoright = true
end type

event clicked;call super::clicked;IF Parent.WindowState = Maximized! THEN
	Parent.WindowState = Normal!
ELSE
	Parent.WindowState = Maximized!
END IF

end event

type p_close from pf_u_imagebutton within pf_w_mainframe_type1
integer x = 5573
integer y = 12
integer width = 283
integer height = 84
boolean bringtotop = true
string picturename = "..\img\mainframe\w_mainframe_type1\close.jpg"
boolean fixedtoright = true
end type

event clicked;call super::clicked;IF MessageBox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX16$$b4c50cd5acb900cf74c758c144c7200085c8ccb858d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 1 THEN
	Close(Parent)
END IF

end event

type dw_logininfo from pf_u_datawindow within pf_w_mainframe_type1
integer x = 2414
integer y = 24
integer width = 1925
integer height = 80
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_mdi_logininfo"
boolean border = false
boolean applydesign = false
boolean singlerowselection = false
boolean useborder = false
boolean fixedtoright = true
end type

type p_favorite from pf_u_imagebutton within pf_w_mainframe_type1
integer y = 976
integer width = 73
integer height = 412
boolean bringtotop = true
string picturename = "..\img\mainframe\w_mainframe_type1\favor.gif"
end type

event clicked;call super::clicked;if ib_leftmenu_visible = true then
	uo_favorite.border = false
	uo_xpmenu.visible = false
	uo_favorite.visible = true
else
	if uo_favorite.visible = true then
		uo_favorite.border = false
		if appeongetclienttype() = 'PB' then
			inv_animate.of_hide(uo_favorite, inv_animate.lefttoright)
		end if
		uo_favorite.width = il_hiddenmenuwidth
		uo_favorite.visible = false
		uo_favorite.setredraw(true)
		
		uo_favorite.inv_propmon.of_unregister('nomouseover')
		uo_favorite.inv_propmon.of_stop()
	else
		uo_favorite.border = true
		uo_favorite.width = il_normalmenuwidth
		if appeongetclienttype() = 'PB' then
			inv_animate.of_show(uo_favorite, inv_animate.lefttoright)
		end if
		uo_favorite.visible = true
		uo_favorite.setredraw(true)
		
		uo_favorite.inv_propmon.of_register('nomouseover', 'pfe_nomouseover')
		uo_favorite.inv_propmon.of_start()
	end if
end if

dw_menutitle.modify('title_t.text="FAVORITE"')
dw_menutitle.modify("topmenu_t.visible=0")
igo_selected = uo_favorite

end event

type dw_menutitle from pf_u_datawindow within pf_w_mainframe_type1
integer x = 73
integer y = 344
integer width = 1125
integer height = 164
integer taborder = 50
boolean bringtotop = true
string dataobject = "pf_d_mdi_menutitle"
boolean border = false
boolean applydesign = false
boolean singlerowselection = false
boolean useborder = false
boolean confirmupdateonrowchange = false
end type

event resize;call super::resize;this.modify("p_1.width='" + string(this.width) + "'")

end event

type p_menu from pf_u_imagebutton within pf_w_mainframe_type1
integer y = 564
integer width = 73
integer height = 412
boolean bringtotop = true
string picturename = "..\img\mainframe\w_mainframe_type1\menu.gif"
end type

event clicked;call super::clicked;if ib_leftmenu_visible = true then
	uo_xpmenu.border = false
	uo_xpmenu.visible = true
	uo_favorite.visible = false
else
	if uo_xpmenu.visible = true then
		uo_xpmenu.border = false
		if appeongetclienttype() = "PB" then
			inv_animate.of_hide(uo_xpmenu, inv_animate.lefttoright)
		end if
		uo_xpmenu.width = il_hiddenmenuwidth
		uo_xpmenu.visible = false
		uo_xpmenu.setredraw(true)
		
		uo_xpmenu.inv_propmon.of_unregister('nomouseover')
		uo_xpmenu.inv_propmon.of_stop()
	else
		uo_xpmenu.border = true
		uo_xpmenu.width = il_normalmenuwidth
		if appeongetclienttype() = "PB" then
			inv_animate.of_show(uo_xpmenu, inv_animate.lefttoright)
		end if
		uo_xpmenu.visible = true
		uo_xpmenu.setredraw(true)
		
		uo_xpmenu.inv_propmon.of_register('nomouseover', 'pfe_nomouseover')
		uo_xpmenu.inv_propmon.of_start()
	end if
end if

dw_menutitle.modify('title_t.text="MENU"')
dw_menutitle.modify("topmenu_t.visible=1")
igo_selected = uo_xpmenu

end event

type st_vsplit from pf_u_splitbar_vertical within pf_w_mainframe_type1
integer x = 1207
integer y = 340
integer width = 27
integer height = 2684
boolean bringtotop = true
string leftdragobject = "dw_menutitle; uo_xpmenu; uo_favorite"
string rightdragobject = "uo_sheettab; st_mdiclient"
end type

event move;call super::move;p_hide.x = this.x - pixelstounits(1, xpixelstounits!)
p_hide.setposition(totop!)

end event

type uo_sheettab from pf_u_mdi_sheettab within pf_w_mainframe_type1
integer x = 1248
integer y = 344
integer width = 4562
integer height = 108
integer taborder = 50
boolean scaletoright = true
string normaltabimagefile = "..\img\mainframe\u_mdi_sheettab\sheettab3_normal.png"
string selectedtabimagefile = "..\img\mainframe\u_mdi_sheettab\sheettab3_selected.png"
long tabcontrolbackcolor = 13487565
end type

event constructor;call super::constructor;if appeongetclienttype() = 'WEB' then
	this.normaltabtextcolor = 8684676
	this.selectedtabtextcolor = 13328682
	this.tabcontrolbackcolor = 13487565
end if

end event

on uo_sheettab.destroy
call pf_u_mdi_sheettab::destroy
end on

type p_hide from pf_u_imagebutton within pf_w_mainframe_type1
event type string ue_getmenustatus ( )
integer x = 1207
integer y = 1408
integer width = 27
integer height = 280
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\mainframe\w_mainframe_type1\hidemenu.gif"
end type

event type string ue_getmenustatus();if pos(this.picturename, 'hidemenu') > 0 then return 'visible'
if pos(this.picturename, 'showmenu') > 0 then return 'hidden'

return ''

end event

event clicked;call super::clicked;if not isvalid(igo_selected) then return

userobject luo_temp
if ib_leftmenu_visible = true then
	inv_animate.of_hide(igo_selected, inv_animate.lefttoright)
	igo_selected.visible = false
	
	luo_temp = igo_selected
	il_normalmenuwidth = luo_temp.width
	
	this.picturename = "..\img\mainframe\w_mainframe_type1\showmenu.gif"
	
	il_vsplit_xpos = st_vsplit.x
	st_vsplit.x = p_menu.x + p_menu.width + pixelstounits(1, xpixelstounits!)
	st_vsplit.of_arrange_objects()
	st_vsplit.visible = false
	
	this.x = pixelstounits(1, xpixelstounits!)
	
	dw_menutitle.visible = false
	dw_menutitle.setredraw(true)
	
	ib_leftmenu_visible = false
else
	luo_temp = igo_selected
	il_hiddenmenuwidth = luo_temp.width
	
	dw_menutitle.visible = true
	dw_menutitle.setredraw(true)
	
	st_vsplit.visible = true
	st_vsplit.x = il_vsplit_xpos
	st_vsplit.of_arrange_objects()
	
	this.picturename = "..\img\mainframe\w_mainframe_type1\hidemenu.gif"
	inv_animate.of_show(igo_selected, inv_animate.lefttoright)
	igo_selected.visible = true
	igo_selected.dynamic setredraw(true)
	
	ib_leftmenu_visible = true
end if

//parent.setredraw(false)
//
//p_hide.x = this.x + this.width - p_hide.width
//p_hide.setposition(totop!)
//
//if uo_xpmenu.visible = true or uo_favorite.visible = true then
//	dw_menutitle.visible = false
//	igo_selected.visible = false
//
//	//uo_xpmenu.visible = false
//	//uo_favorite.visible = false
//	//uo_xpmenu.of_hide()
//	//uo_xpmenu.visible = false
//	
//	this.x = 0
//	this.picturename = '..\img\mainframe\showmenu.gif'
//
//	st_vsplit.x = this.x + this.width - st_vsplit.width
//	st_vsplit.of_arrange_objects()
//	st_vsplit.visible = false
//	
////	mdi_1.x = st_mdiclient.x
////	mdi_1.y = st_mdiclient.y
////	mdi_1.width = st_mdiclient.width
////	mdi_1.height = st_mdiclient.height
//	
//	p_hide.setposition(totop!)
//else
//	//uo_xpmenu.of_show()
//	dw_menutitle.visible = true
//	igo_selected.visible = true
//	
//	//uo_xpmenu.visible = true
//	//uo_favorite.visible = false
//	//uo_xpmenu.visible = true
//	
//	this.x = uo_xpmenu.x + uo_xpmenu.width
//	this.picturename = '..\img\mainframe\hidemenu.gif'
//	
//	st_vsplit.visible = true
//	st_vsplit.x = this.x + this.width - st_vsplit.width
//	st_vsplit.of_arrange_objects()
//	
////	mdi_1.x = st_mdiclient.x
////	mdi_1.y = st_mdiclient.y
////	mdi_1.width = st_mdiclient.width
////	mdi_1.height = st_mdiclient.height
//	
//	p_hide.setposition(totop!)
//end if
//
//parent.setredraw(true)

end event

type uo_xpmenu from pf_u_mdi_xpmenu within pf_w_mainframe_type1
integer x = 73
integer y = 508
integer width = 1125
integer height = 2512
integer taborder = 70
boolean scaletobottom = true
end type

event pfe_menuclicked;call super::pfe_menuclicked;parent.of_opensheet(as_menu_id, as_pgm_id, as_pgm_name)

if ib_leftmenu_visible = false then
	p_menu.post event clicked()
end if

end event

on uo_xpmenu.destroy
call pf_u_mdi_xpmenu::destroy
end on

type uo_favorite from pf_u_mdi_favorite within pf_w_mainframe_type1
integer x = 73
integer y = 508
integer width = 1125
integer height = 2512
integer taborder = 80
boolean scaletobottom = true
end type

event pfe_menuclicked;call super::pfe_menuclicked;parent.of_opensheet(as_menu_id, as_pgm_id, as_pgm_nm)

if ib_leftmenu_visible = false then
	p_favorite.post event clicked()
end if

end event

on uo_favorite.destroy
call pf_u_mdi_favorite::destroy
end on

type dw_topmenu from pf_u_mdi_iconmenu within pf_w_mainframe_type1
boolean visible = false
integer x = 142
integer y = 176
integer width = 5678
integer height = 140
integer taborder = 10
boolean bringtotop = true
boolean scaletoright = true
end type

event ue_menuclicked;call super::ue_menuclicked;//2014.04.07 By KYJ $$HEX16$$54ba74b2200074d0adb9dcc22000ecd378c730d1200054d7e4b4bcb918c215c8$$ENDHEX$$
pointer lp_oldpointer
lp_oldpointer = SetPointer(HourGlass!)

//This.SetRedraw(False)

//choose case as_pgm_nm
//	case '$$HEX5$$dcc2a4c25cd100adacb9$$ENDHEX$$'
//		uo_xpmenu.of_setmenudepth(1)
//	case else
//		uo_xpmenu.of_setmenudepth(2)
//end choose

uo_xpmenu.of_setmenudepth(2)
uo_xpmenu.DisplayHeaderBand = false
gnv_session.of_put('topmenu_pgm_name', as_pgm_nm)
dw_menutitle.modify('topmenu_t.text="' + as_pgm_nm + '"')

// $$HEX7$$58d504c754ba74b2200070c88cd6$$ENDHEX$$
uo_xpmenu.of_drawmenu(as_menu_id)

if igo_selected.dynamic of_getclassname() <> 'uo_xpmenu' then
	if uo_xpmenu.visible = false then
		p_menu.post event clicked()
	else
		if ib_leftmenu_visible = false then
			uo_xpmenu.inv_propmon.of_start()
		end if
	end if
end if

//uo_xpmenu.of_drawmenu(as_menu_id)
//p_menu.post event clicked()

//This.SetRedraw(True)
SetPointer(lp_oldpointer)

end event

type uo_status from pf_u_mdi_statusbar within pf_w_mainframe_type1
integer y = 3040
integer width = 5856
integer taborder = 80
boolean bringtotop = true
boolean fixedtobottom = true
boolean scaletoright = true
end type

on uo_status.destroy
call pf_u_mdi_statusbar::destroy
end on

