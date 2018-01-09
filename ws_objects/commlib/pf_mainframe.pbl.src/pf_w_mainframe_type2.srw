$PBExportHeader$pf_w_mainframe_type2.srw
$PBExportComments$파워프레임 기본 MDI 화면 입니다.
forward
global type pf_w_mainframe_type2 from pf_w_frame
end type
type p_logo from pf_u_picture within pf_w_mainframe_type2
end type
type p_favorite from pf_u_imagebutton within pf_w_mainframe_type2
end type
type p_menu from pf_u_imagebutton within pf_w_mainframe_type2
end type
type st_vsplit from pf_u_splitbar_vertical within pf_w_mainframe_type2
end type
type uo_sheettab from pf_u_mdi_sheettab within pf_w_mainframe_type2
end type
type st_1 from statictext within pf_w_mainframe_type2
end type
type st_leftbar from pf_u_statictext within pf_w_mainframe_type2
end type
type p_top_delimiter from pf_u_picture within pf_w_mainframe_type2
end type
type dw_userinfo from pf_u_mdi_userinfo within pf_w_mainframe_type2
end type
type p_vline from pf_u_picture within pf_w_mainframe_type2
end type
type p_hide from pf_u_picture within pf_w_mainframe_type2
end type
type st_mainborder from pf_u_statictext within pf_w_mainframe_type2
end type
type p_search from pf_u_imagebutton within pf_w_mainframe_type2
end type
type uo_xpmenu from pf_u_mdi_xpmenu within pf_w_mainframe_type2
end type
type uo_favorite from pf_u_mdi_favorite within pf_w_mainframe_type2
end type
type uo_treemenu from pf_u_mdi_treemenu within pf_w_mainframe_type2
end type
type uo_topmenu from pf_u_mdi_menubar within pf_w_mainframe_type2
end type
type uo_submenu from pf_u_mdi_menubar within pf_w_mainframe_type2
end type
end forward

global type pf_w_mainframe_type2 from pf_w_frame
integer width = 5893
integer height = 3312
long backcolor = 32896501
p_logo p_logo
p_favorite p_favorite
p_menu p_menu
st_vsplit st_vsplit
uo_sheettab uo_sheettab
st_1 st_1
st_leftbar st_leftbar
p_top_delimiter p_top_delimiter
dw_userinfo dw_userinfo
p_vline p_vline
p_hide p_hide
st_mainborder st_mainborder
p_search p_search
uo_xpmenu uo_xpmenu
uo_favorite uo_favorite
uo_treemenu uo_treemenu
uo_topmenu uo_topmenu
uo_submenu uo_submenu
end type
global pf_w_mainframe_type2 pf_w_mainframe_type2

type variables
protected:
	string is_resized
	pf_n_animate inv_animate
	graphicobject igo_selected
	long il_vsplit_xpos, il_normalmenuwidth, il_hiddenmenuwidth
	boolean ib_leftmenu_visible
	pf_m_setup im_setup
	
public:
	ulong MainFrameBackgroundColor = RGB(205,205,205)
	ulong MDIClientBackgroundColor = RGB(205,205,205)

end variables

forward prototypes
public function integer of_setresize (boolean ab_switch)
public subroutine of_openhomewindow ()
public function integer of_opensheet (string as_menu_id, string as_pgm_id, string as_pgm_name)
public subroutine of_logout_job ()
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

public subroutine of_openhomewindow ();window lw_child
pf_n_menudata lnv_menu
lnv_menu = create pf_n_menudata

lnv_menu.is_menu_id = 'PF_W_HOME'
lnv_menu.is_pgm_id = 'pf_w_home2'
lnv_menu.is_pgm_name = 'WELCOME'

if uo_sheettab.of_isOpenedSheet(lnv_menu.is_menu_id) = false then
	gnv_session.of_put(lnv_menu.is_pgm_id, lnv_menu)
	OpenSheet(lw_child, lnv_menu.is_pgm_id, this, 0, Original!)
else
	uo_sheettab.of_SheetSetfocus(lnv_menu.is_pgm_id)
end if

end subroutine

public function integer of_opensheet (string as_menu_id, string as_pgm_id, string as_pgm_name);pf_n_menudata lnv_menu
window lw_child

// 존재하지않는 프로그램 확인
if appeongetclienttype() = 'PB' then
	classdefinition lcd_win
	lcd_win = FindClassDefinition(as_pgm_id)
	if isnull(lcd_win) then
		messagebox('알림', '[' + as_pgm_name + '] 선택하신 프로그램은 현재 개발중입니다~r~n나중에 다시 확인하세요')
		return -1
	end if
end if

// HourGlass 처리 안 하면, 윈도우 오픈 시에
// 바탕화면이 클릭되는 현상이 발생됨
setpointer(hourglass!)
post setpointer(arrow!)
if appeongetclienttype() = 'WEB' then
	this.setredraw(false)
	this.post setredraw(true)
end if

// 윈도우 파라미터 설정
lnv_menu = create pf_n_menudata
lnv_menu.is_menu_id = as_menu_id
lnv_menu.is_pgm_id = as_pgm_id
lnv_menu.is_pgm_name = as_pgm_name

// 시트 윈도우 오픈
if uo_sheettab.of_isOpenedSheet(as_menu_id) = false then
	gnv_session.of_put(upper(lnv_menu.is_pgm_id), lnv_menu)
	opensheet(lw_child, lnv_menu.is_pgm_id, this, 0, Original!)
else
	uo_sheettab.of_SheetSetfocus(as_menu_id)
end if

return 1

end function

public subroutine of_logout_job ();// LEFT 메뉴 숨김상태를 보관해서
// 다음 오픈 시 동일한 상태를 유지합니다.
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

on pf_w_mainframe_type2.create
int iCurrent
call super::create
this.p_logo=create p_logo
this.p_favorite=create p_favorite
this.p_menu=create p_menu
this.st_vsplit=create st_vsplit
this.uo_sheettab=create uo_sheettab
this.st_1=create st_1
this.st_leftbar=create st_leftbar
this.p_top_delimiter=create p_top_delimiter
this.dw_userinfo=create dw_userinfo
this.p_vline=create p_vline
this.p_hide=create p_hide
this.st_mainborder=create st_mainborder
this.p_search=create p_search
this.uo_xpmenu=create uo_xpmenu
this.uo_favorite=create uo_favorite
this.uo_treemenu=create uo_treemenu
this.uo_topmenu=create uo_topmenu
this.uo_submenu=create uo_submenu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_logo
this.Control[iCurrent+2]=this.p_favorite
this.Control[iCurrent+3]=this.p_menu
this.Control[iCurrent+4]=this.st_vsplit
this.Control[iCurrent+5]=this.uo_sheettab
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_leftbar
this.Control[iCurrent+8]=this.p_top_delimiter
this.Control[iCurrent+9]=this.dw_userinfo
this.Control[iCurrent+10]=this.p_vline
this.Control[iCurrent+11]=this.p_hide
this.Control[iCurrent+12]=this.st_mainborder
this.Control[iCurrent+13]=this.p_search
this.Control[iCurrent+14]=this.uo_xpmenu
this.Control[iCurrent+15]=this.uo_favorite
this.Control[iCurrent+16]=this.uo_treemenu
this.Control[iCurrent+17]=this.uo_topmenu
this.Control[iCurrent+18]=this.uo_submenu
end on

on pf_w_mainframe_type2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_logo)
destroy(this.p_favorite)
destroy(this.p_menu)
destroy(this.st_vsplit)
destroy(this.uo_sheettab)
destroy(this.st_1)
destroy(this.st_leftbar)
destroy(this.p_top_delimiter)
destroy(this.dw_userinfo)
destroy(this.p_vline)
destroy(this.p_hide)
destroy(this.st_mainborder)
destroy(this.p_search)
destroy(this.uo_xpmenu)
destroy(this.uo_favorite)
destroy(this.uo_treemenu)
destroy(this.uo_topmenu)
destroy(this.uo_submenu)
end on

event open;call super::open;// Background Color 설정
//this.backcolor = MainFrameBackgroundColor
//mdi_1.backcolor = MainFrameBackgroundColor

// MDI 타이틀 설정
//this.title = gnv_appmgr.is_sys_name

// 고객정보 설정
dw_userinfo.insertrow(0)
dw_userinfo.setitem(1, 'user_name', gnv_session.is_user_name)

// 애니메이션 오브젝트
inv_animate = create pf_n_animate

// Setup 용 팝업메뉴
im_setup = create pf_m_setup

end event

event pfe_postopen;call super::pfe_postopen;// 로그인 정보 설정
pf_n_userrole lnv_user
lnv_user = gnv_session.of_get("userrole")

// Top 메뉴 조회
uo_topmenu.of_drawmenu('')

// 메뉴검색 창 조회
uo_treemenu.of_drawmenu()

// HOME 윈도우 오픈
this.of_openhomewindow()

// 즐겨찾기 메뉴 활성화
if gnv_appconf.of_getprofile("mdi.leftmenu.visible", "true") = "true" then
	ib_leftmenu_visible = true
else
	ib_leftmenu_visible = false
end if

il_normalmenuwidth = uo_favorite.width
il_hiddenmenuwidth = uo_favorite.width

uo_favorite.of_drawleftmenu(gnv_session.is_user_id)
p_favorite.event clicked()

// LEFT 메뉴 상태설정
if ib_leftmenu_visible = false then
	uo_xpmenu.visible = false
	uo_treemenu.visible = false
	ib_leftmenu_visible = true
	p_hide.event clicked()
end if

end event

event close;call super::close;this.of_logout_job()

if isvalid(inv_animate) then
	destroy inv_animate
end if

if isvalid(im_setup) then
	destroy im_setup
end if

end event

event closequery;call super::closequery;// Return Values
// 0 Allow the window to be closed
// 1 Prevent the window from closing

integer li_rc

li_rc = messagebox('알림', '시스템을 종료하시겠습니까?', Question!, YesNo!, 2)
if li_rc = 1 then
	return 0
else
	return 1
end if

end event

type st_mdiclient from pf_w_frame`st_mdiclient within pf_w_mainframe_type2
integer x = 1271
integer y = 472
integer width = 4544
integer height = 2620
end type

type p_logo from pf_u_picture within pf_w_mainframe_type2
integer x = 82
integer y = 192
integer width = 631
integer height = 60
boolean bringtotop = true
string pointer = "Arrow!"
boolean originalsize = false
string picturename = "..\img\mainframe\w_mainframe_type2\penta_ci.jpg"
end type

event clicked;call super::clicked;//inet lnv_inet
//
//GetContextService("Internet", lnv_inet)
//lnv_inet.HyperlinkToURL("http://www.penta.co.kr")

end event

type p_favorite from pf_u_imagebutton within pf_w_mainframe_type2
integer y = 708
integer width = 123
integer height = 292
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\mainframe\w_mainframe_type2\\favorit_btn.jpg"
end type

event clicked;call super::clicked;if ib_leftmenu_visible = true then
	uo_favorite.border = false
	uo_xpmenu.visible = false
	uo_favorite.visible = true
	uo_treemenu.visible = false
else
	if uo_favorite.visible = true then
		uo_favorite.border = false
		if appeongetclienttype() = 'PB' then 
			inv_animate.of_hide(uo_favorite, inv_animate.lefttoright)
		end if
		uo_favorite.width = il_hiddenmenuwidth
		uo_favorite.visible = false
		
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

igo_selected = uo_favorite

end event

type p_menu from pf_u_imagebutton within pf_w_mainframe_type2
integer y = 444
integer width = 123
integer height = 264
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\mainframe\w_mainframe_type2\menu_btn.jpg"
end type

event clicked;call super::clicked;if ib_leftmenu_visible = true then
	uo_xpmenu.border = false
	uo_xpmenu.visible = true
	uo_favorite.visible = false
	uo_treemenu.visible = false
else
	if uo_xpmenu.visible = true then
		uo_xpmenu.border = false
		if appeongetclienttype() = 'PB' then 
			inv_animate.of_hide(uo_xpmenu, inv_animate.lefttoright)
		end if
		uo_xpmenu.width = il_hiddenmenuwidth
		uo_xpmenu.visible = false
		
		uo_xpmenu.inv_propmon.of_unregister('nomouseover')
		uo_xpmenu.inv_propmon.of_stop()
	else
		uo_xpmenu.border = true
		uo_xpmenu.width = il_normalmenuwidth
		if appeongetclienttype() = 'PB' then 
			inv_animate.of_show(uo_xpmenu, inv_animate.lefttoright)
		end if
		uo_xpmenu.visible = true
		uo_xpmenu.setredraw(true)
		
		uo_xpmenu.inv_propmon.of_register('nomouseover', 'pfe_nomouseover')
		uo_xpmenu.inv_propmon.of_start()
	end if
end if

igo_selected = uo_xpmenu

end event

type st_vsplit from pf_u_splitbar_vertical within pf_w_mainframe_type2
integer x = 1189
integer y = 316
integer width = 23
integer height = 2816
boolean bringtotop = true
string leftdragobject = "dw_userinfo; uo_xpmenu; uo_treemenu; uo_favorite"
string rightdragobject = "uo_sheettab; st_mdiclient; st_mainborder"
end type

event move;call super::move;p_vline.x = this.x - pixelstounits(1, xpixelstounits!)
p_vline.setposition(totop!)

p_hide.x = this.x - pixelstounits(1, xpixelstounits!)
p_hide.setposition(totop!)

end event

type uo_sheettab from pf_u_mdi_sheettab within pf_w_mainframe_type2
integer x = 1266
integer y = 348
integer width = 4553
integer height = 124
integer taborder = 50
boolean scaletoright = true
long normaltabtextcolor = 3946295
long selectedtabtextcolor = 7893092
boolean showunderline = true
long underlinepencolor = 7958629
long underlinepenwidth = 2
end type

on uo_sheettab.destroy
call pf_u_mdi_sheettab::destroy
end on

type st_1 from statictext within pf_w_mainframe_type2
integer y = 136
integer width = 800
integer height = 156
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
boolean focusrectangle = false
end type

type st_leftbar from pf_u_statictext within pf_w_mainframe_type2
integer y = 436
integer width = 123
integer height = 2692
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 23954581
boolean scaletobottom = true
end type

type p_top_delimiter from pf_u_picture within pf_w_mainframe_type2
integer y = 308
integer width = 5865
integer height = 8
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\mainframe\w_mainframe_type2\top_delimiter.jpg"
boolean scaletoright = true
end type

type dw_userinfo from pf_u_mdi_userinfo within pf_w_mainframe_type2
integer y = 316
integer width = 1152
integer taborder = 60
boolean applydesign = false
boolean singlerowselection = false
boolean useborder = false
end type

event clicked;call super::clicked;// SETUP 메뉴

choose case dwo.name
	case 'p_setup'
		im_setup.popmenu(parent.pointerx(), parent.pointery())
	case 'p_logout'
		close(parent)
end choose

end event

type p_vline from pf_u_picture within pf_w_mainframe_type2
integer x = 1184
integer y = 316
integer width = 5
integer height = 2816
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\mainframe\w_mainframe_type2\vertical_line.jpg"
boolean scaletobottom = true
end type

type p_hide from pf_u_picture within pf_w_mainframe_type2
event type string ue_getmenustatus ( )
integer x = 1184
integer y = 1668
integer width = 59
integer height = 124
boolean bringtotop = true
string pointer = "HyperLink!"
boolean originalsize = false
string picturename = "..\img\mainframe\w_mainframe_type2\hide_btn.jpg"
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
	
	this.picturename = "..\img\mainframe\w_mainframe_type2\view_btn.jpg"
	
	il_vsplit_xpos = st_vsplit.x
	st_vsplit.x = st_leftbar.x + st_leftbar.width + pixelstounits(1, xpixelstounits!)
	st_vsplit.of_arrange_objects()
	st_vsplit.visible = false
	
	dw_userinfo.width += pixelstounits(9, xpixelstounits!)
	dw_userinfo.setredraw(true)
	
	ib_leftmenu_visible = false
else
	luo_temp = igo_selected
	il_hiddenmenuwidth = luo_temp.width
	
	dw_userinfo.width -= pixelstounits(9, xpixelstounits!)
	dw_userinfo.setredraw(true)
	
	st_vsplit.visible = true
	st_vsplit.x = il_vsplit_xpos
	st_vsplit.of_arrange_objects()
	
	this.picturename = "..\img\mainframe\w_mainframe_type2\hide_btn.jpg"
	inv_animate.of_show(igo_selected, inv_animate.lefttoright)
	igo_selected.visible = true
	igo_selected.dynamic setredraw(true)
	
	ib_leftmenu_visible = true
end if

end event

type st_mainborder from pf_u_statictext within pf_w_mainframe_type2
integer x = 1266
integer y = 468
integer width = 4553
integer height = 2628
boolean border = true
long bordercolor = 30067402
boolean scaletoright = true
boolean scaletobottom = true
end type

type p_search from pf_u_imagebutton within pf_w_mainframe_type2
integer y = 1000
integer width = 123
integer height = 292
boolean bringtotop = true
string picturename = "..\img\mainframe\w_mainframe_type2\\search_btn.jpg"
end type

event clicked;call super::clicked;if ib_leftmenu_visible = true then
	uo_treemenu.border = false
	uo_xpmenu.visible = false
	uo_favorite.visible = false
	uo_treemenu.visible = true
else
	if uo_treemenu.visible = true then
		uo_treemenu.border = false
		if appeongetclienttype() = 'PB' then 
			inv_animate.of_hide(uo_treemenu, inv_animate.lefttoright)
		end if
		uo_treemenu.width = il_hiddenmenuwidth
		uo_treemenu.visible = false
		
		uo_treemenu.inv_propmon.of_unregister('nomouseover')
		uo_treemenu.inv_propmon.of_stop()
	else
		uo_treemenu.border = true
		uo_treemenu.width = il_normalmenuwidth
		if appeongetclienttype() = 'PB' then 
			inv_animate.of_show(uo_treemenu, inv_animate.lefttoright)
		end if
		uo_treemenu.visible = true
		uo_treemenu.setredraw(true)
		
		uo_treemenu.inv_propmon.of_register('nomouseover', 'pfe_nomouseover')
		uo_treemenu.inv_propmon.of_start()
	end if
end if

igo_selected = uo_treemenu

end event

type uo_xpmenu from pf_u_mdi_xpmenu within pf_w_mainframe_type2
integer x = 123
integer y = 436
integer width = 1029
integer height = 2692
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

type uo_favorite from pf_u_mdi_favorite within pf_w_mainframe_type2
integer x = 123
integer y = 436
integer width = 1029
integer height = 2692
integer taborder = 90
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

type uo_treemenu from pf_u_mdi_treemenu within pf_w_mainframe_type2
integer x = 123
integer y = 436
integer height = 2692
integer taborder = 80
boolean scaletobottom = true
end type

event pfe_menuclicked;call super::pfe_menuclicked;parent.of_opensheet(as_menu_id, as_pgm_id, as_pgm_name)

if ib_leftmenu_visible = false then
	p_search.post event clicked()
end if

end event

on uo_treemenu.destroy
call pf_u_mdi_treemenu::destroy
end on

type uo_topmenu from pf_u_mdi_menubar within pf_w_mainframe_type2
integer width = 5865
integer height = 136
integer taborder = 20
boolean bringtotop = true
end type

event pfe_menuselected;call super::pfe_menuselected;//gnv_appmgr.iw_mainframe.setredraw(false)
//gnv_appmgr.iw_mainframe.post setredraw(true)

// 하위메뉴 조회
gnv_session.of_put("AppTitle", as_menu_id)
uo_submenu.of_drawmenu(as_menu_id)

end event

on uo_topmenu.destroy
call pf_u_mdi_menubar::destroy
end on

type uo_submenu from pf_u_mdi_menubar within pf_w_mainframe_type2
integer x = 800
integer y = 136
integer width = 5056
integer height = 168
integer taborder = 30
boolean bringtotop = true
long menubarbackgroundcolor = 16777215
integer menutextfontsize = -12
long menutextfontcolor = 534
long menutextclickedcolor = 160200
long menutextbackcolor = 16777215
string menudelimiterimage = "..\img\mainframe\u_mdi_menubar\menu_delimiter2.jpg"
long menudelimiterheight = 16
long selectedmenufontcolor = 160200
long selectedmenubackcolor = 16777215
end type

event constructor;call super::constructor;// Appeon 환경은 상속 후 프로퍼티 변경사항이 적용 안 됨...
if appeongetclienttype() = 'WEB' then
	this.MenuBarBackgroundColor = 16777215
	this.MenuTextFontColor = 534
	this.MenuTextClickedColor = 160200
	this.menutextbackcolor = 16777215
	this.menudelimiterimage = '..\img\mainframe\u_mdi_menubar\menu_delimiter2.jpg'
	this.menudelimiterheight = 16
	this.selectedmenufontcolor = 160200
	this.selectedmenubackcolor = 16777215
end if

end event

event pfe_menuselected;call super::pfe_menuselected;//gnv_appmgr.iw_mainframe.setredraw(false)
//gnv_appmgr.iw_mainframe.post setredraw(true)

// 하위메뉴여부를 파악해서 3 or 4레벨로 메뉴 레벨 설정
long ll_submenu

select		count(1)
into		:ll_submenu
from		pf_pgm_mst
where	sys_id = :gnv_session.is_sys_id
and		parent_menu = :as_menu_id
and		pgm_kind_code = 'M'
;

if ll_submenu > 0 then
	uo_xpmenu.of_setmenudepth(2)
else	
	uo_xpmenu.of_setmenudepth(1)
end if

// 하위메뉴 조회
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

end event

on uo_submenu.destroy
call pf_u_mdi_menubar::destroy
end on

