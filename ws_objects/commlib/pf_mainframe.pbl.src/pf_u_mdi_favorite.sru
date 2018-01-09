$PBExportHeader$pf_u_mdi_favorite.sru
$PBExportComments$MDI화면 위에 사용자가 등록한 즐겨찾기 메뉴를 표시해 주는 사용자 오브젝트 입니다.
forward
global type pf_u_mdi_favorite from pf_u_userobject
end type
type dw_menu from pf_u_datawindow within pf_u_mdi_favorite
end type
end forward

global type pf_u_mdi_favorite from pf_u_userobject
integer width = 928
integer height = 1516
event pfe_menuclicked ( string as_menu_id,  string as_pgm_id,  string as_pgm_nm )
event pfe_refreshmenu ( )
event pfe_nomouseover ( )
dw_menu dw_menu
end type
global pf_u_mdi_favorite pf_u_mdi_favorite

type variables
public:
	integer menudepth = 2
	pf_n_propertywatcher inv_propmon

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_drawleftmenu (string as_user_id)
public function integer of_del_favorite (string as_menu_id, string as_favor_name)
public function integer of_rename_favorite (string as_menu_id, string as_pgm_name)
end prototypes

event pfe_refreshmenu();this.of_drawleftmenu(gnv_session.is_user_id)

end event

event pfe_nomouseover();this.visible = false
this.border = false
inv_propmon.of_unregister('nomouseover')
inv_propmon.of_stop()

end event

public function string of_getclassname ();return 'pf_u_mdi_favorite'

end function

public function integer of_drawleftmenu (string as_user_id);return dw_menu.retrieve(gnv_session.is_sys_id, as_user_id)

end function

public function integer of_del_favorite (string as_menu_id, string as_favor_name);if isnull(as_menu_id) or len(as_menu_id) = 0 then return -1
if isnull(as_favor_name) or len(as_favor_name) = 0 then return -1

if messagebox('알림', '선택하신 [' + as_favor_name + '] 즐겨찾기 항목을 삭제하시겠습니까?', Question!, YesNo!, 2) <> 1 then return 0

string ls_user_id
string ls_errtext

ls_user_id = gnv_session.is_user_id

delete		pf_user_favor
where	sys_id = :gnv_session.is_sys_id
and		user_id = :ls_user_id
and		menu_id = :as_menu_id
using		sqlca;

if sqlca.sqlcode = 0 then
	commit using sqlca;
else
	ls_errtext = sqlca.sqlerrtext
	rollback using sqlca;
	messagebox('알림', '즐겨찾기 항목을 삭제하는중 오류가 발생했습니다!~r~n' + ls_errtext)
	return -1
end if

this.post of_drawleftmenu(ls_user_id)
return 1

end function

public function integer of_rename_favorite (string as_menu_id, string as_pgm_name);pf_n_menudata lnv_menu

lnv_menu = create pf_n_menudata
lnv_menu.is_menu_id = as_menu_id
lnv_menu.is_pgm_name = as_pgm_name

openwithparm(pf_w_favorite_rename, lnv_menu)
if message.stringparm = 'OK' then
	pf_n_hashtable lnvo_param
	lnvo_param = create pf_n_hashtable
	iw_parent.dynamic of_eventdispatcher('pf_u_mdi_favorite', 'pfe_refreshmenu', lnvo_param)
end if

return 1
end function

on pf_u_mdi_favorite.create
int iCurrent
call super::create
this.dw_menu=create dw_menu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_menu
end on

on pf_u_mdi_favorite.destroy
call super::destroy
destroy(this.dw_menu)
end on

event resize;call super::resize;dw_menu.x = -100
dw_menu.y = 0
dw_menu.width = this.width + 100
dw_menu.height = this.height

end event

event destructor;call super::destructor;if isvalid(inv_propmon) then
	inv_propmon.of_stop()
	destroy inv_propmon
end if

end event

event pfe_postopen;call super::pfe_postopen;dw_menu.settransobject(sqlca)

this.of_drawleftmenu(gnv_session.is_user_id)

// register porps watcher
inv_propmon = create pf_n_propertywatcher
inv_propmon.of_registerparent(this)
inv_propmon.of_setvisibletime(2500)

end event

type p_background from pf_u_userobject`p_background within pf_u_mdi_favorite
end type

type dw_menu from pf_u_datawindow within pf_u_mdi_favorite
integer width = 901
integer height = 1488
integer taborder = 10
string title = "none"
string dataobject = "pf_d_mdi_favorite"
boolean vscrollbar = true
boolean border = false
end type

event clicked;String		ls_level, ls_data
Long		ll_row, ll_level

Choose Case row
	Case 0
		this.setRedRaw(false)
		ls_data 	= this.GetBandAtPointer()
		ls_level 	= LEFT(ls_data, Pos(ls_data, "~t") - 1)
		ll_row 	= Long(Mid(ls_data, Pos(ls_data, "~t") + Len("~t")))
		ll_level 	= Long(Mid(ls_level, LastPos(ls_level, ".") + Len(".")))

		IF IsExpanded(ll_Row, ll_level) THEN
			this.Collapse(ll_row, ll_level)
		ELSE
			this.Expand(ll_row, ll_level)
		END IF
		this.setRedRaw(true)
	Case Is > 0
		string ls_menu_id, ls_pgm_id
		string ls_pgm_name, ls_pgm_path
		pf_n_rolemenu lnv_menu
		
		ls_menu_id = this.getitemstring(row, 'menu_id')

		lnv_menu = create pf_n_rolemenu
		if lnv_menu.of_getmenudata('self', ls_menu_id) =  0 then
			messagebox('알림', '이 프로그램을 사용할 권한이 없습니다')
			return
		end if
		
		ls_pgm_id = lnv_menu.ids_menudata.getitemstring(1, 'pgm_id')
		ls_pgm_name = lnv_menu.ids_menudata.getitemstring(1, 'pgm_name')
		ls_pgm_path = lnv_menu.of_getpgmpath(ls_menu_id)
		gnv_session.of_put('leftmenu_pgm_name', ls_pgm_path)
		
		parent.post event pfe_menuclicked(ls_menu_id, ls_pgm_id, ls_pgm_name)		
End CHoose

end event

event rbuttondown;if row = 0 then return

// 즐겨찾기 메뉴
pf_m_favorite lm_popup
string ls_menu_id, ls_favor_name

ls_menu_id = this.getitemstring(row, 'menu_id')
ls_favor_name = this.getitemstring(row, 'favor_name')

lm_popup = create pf_m_favorite
lm_popup.of_setparent(parent, ls_menu_id, ls_favor_name)
lm_popup.m_favorite.PopMenu(PointerX(iw_parent), PointerY(iw_parent))

end event

event pfe_mouseover;call super::pfe_mouseover;if al_row > 0 then
	this.setrow(al_row)
end if

end event

