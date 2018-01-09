$PBExportHeader$pf_n_rolemenu.sru
$PBExportComments$로그인한 사용자의 권한에 따라 사용 가능한 프로그램 목록을 처리하는 오브젝트 입니다.
forward
global type pf_n_rolemenu from pf_n_nonvisualobject
end type
end forward

global type pf_n_rolemenu from pf_n_nonvisualobject
end type
global pf_n_rolemenu pf_n_rolemenu

type variables
public:
	datastore ids_menudata
	string is_platform_type

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_getmenudata_by_pgmid (string as_pgm_id, ref pf_n_menudata anv_menudata)
public function string of_getpgmpath (string as_menu_id)
public function string of_getpgmname (string as_menu_id)
public function long of_getmenudata (string as_itemtype, string as_menu_id)
protected subroutine of_setplatformtype ()
public function integer of_getmenudata_by_menuid (string as_menu_id, ref pf_n_menudata anv_menudata)
end prototypes

public function string of_getclassname ();return 'pf_n_rolemenu'

end function

public function integer of_getmenudata_by_pgmid (string as_pgm_id, ref pf_n_menudata anv_menudata);// ProgramID 값으로 메뉴데이터 Structure 값을 구한다

if isnull(as_pgm_id) or as_pgm_id = '' then return -1
if isnull(anv_menudata) or not isvalid(anv_menudata) then return -1

datastore lds_pgm
long ll_row

lds_pgm = create datastore
lds_pgm.dataobject = 'pf_d_menudata_pgmid'
lds_pgm.settransobject(sqlca)

ll_row = lds_pgm.retrieve(gnv_appmgr.is_sys_id, upper(as_pgm_id))
choose case ll_row
	case 1
		anv_menudata.is_menu_id = lds_pgm.getitemstring(1, 'menu_id')
		anv_menudata.is_pgm_id = lds_pgm.getitemstring(1, 'pgm_id')
		anv_menudata.is_pgm_name = lds_pgm.getitemstring(1, 'pgm_name')
	case is > 1
		anv_menudata.is_menu_id = lds_pgm.getitemstring(1, 'menu_id')
		anv_menudata.is_pgm_id = lds_pgm.getitemstring(1, 'pgm_id')
		anv_menudata.is_pgm_name = lds_pgm.getitemstring(1, 'pgm_name')
		/*
		// pgm_id 가 여러건 등록된 경우, 사용될 프로그램을 사용자에게 선택하도록 한다
		openwithparm(pf_w_select_menu_id, lds_pgm)
		ll_row = long(message.stringparm)
		if ll_row > 0 then
			anv_menudata.is_menu_id = lds_pgm.getitemstring(ll_row, 'menu_id')
			anv_menudata.is_pgm_id = lds_pgm.getitemstring(ll_row, 'pgm_id')
			anv_menudata.is_pgm_name = lds_pgm.getitemstring(ll_row, 'pgm_name')
		end if
		*/
	case else
		anv_menudata.is_menu_id = ''
		anv_menudata.is_pgm_id = ''
		anv_menudata.is_pgm_name = ''
end choose

destroy lds_pgm
return ll_row

end function

public function string of_getpgmpath (string as_menu_id);// menu_id의 메뉴 경로를 구한다 예) 학사 > 입시 > 입시전형

string ls_pgm_path
string ls_pgm_name, ls_parent_menu

select		pgm_name,
			parent_menu
into		:ls_pgm_name,
			:ls_parent_menu
from		pf_pgm_mst
where	sys_id = :gnv_session.is_sys_id
and		menu_id = :as_menu_id
using		sqlca;

do while sqlca.sqlcode = 0 and ls_parent_menu <> 'ROOT'
	if ls_pgm_path = '' then
		ls_pgm_path = ls_pgm_name
	else
		ls_pgm_path = ls_pgm_name + ' > ' + ls_pgm_path
	end if

	select		pgm_name,
				parent_menu
	into		:ls_pgm_name,
				:ls_parent_menu
	from		pf_pgm_mst
	where	sys_id = :gnv_session.is_sys_id
	and		menu_id = :ls_parent_menu
	using		sqlca;
loop

return ls_pgm_path

end function

public function string of_getpgmname (string as_menu_id);// 프로그램 기본정보에 등록된 프로그램 명을 구합니다
// as_menu_id = 메뉴 ID

string	ls_pgm_name

select		pgm_name
into		:ls_pgm_name
from		pf_pgm_mst
where	sys_id = :gnv_session.is_sys_id
and		menu_id = :as_menu_id
using		sqlca;

return ls_pgm_name

end function

public function long of_getmenudata (string as_itemtype, string as_menu_id);// 로그인 사용자에게 할당된 메뉴를 설정합니다
// 설정된 메뉴는 ids_userrrole 데이터스토어에 보관됩니다.

long ll_retval

if isnull(as_itemtype) or as_itemtype = '' then return -1
if isnull(as_menu_id) or as_menu_id = '' then return -1
if as_itemtype <> 'parent' and as_itemtype <> 'self' then return -1

pf_n_userrole lnv_userrole
lnv_userrole = gnv_session.of_get("userrole")
if isvalid(lnv_userrole) then
	ll_retval = ids_menudata.retrieve(gnv_session.is_sys_id, as_itemtype, as_menu_id, string(gnv_session.idtm_login, 'YYYYMMDD'), &
				lnv_userrole.is_memb_code[1], lnv_userrole.is_memb_code[2], lnv_userrole.is_memb_code[3], lnv_userrole.is_memb_code[4], &
				lnv_userrole.is_memb_code[5], lnv_userrole.is_memb_code[6], lnv_userrole.is_memb_code[7], lnv_userrole.is_memb_code[8], &
				is_platform_type)
end if

return ll_retval

end function

protected subroutine of_setplatformtype ();// 파워프레임은 플랫폼 타입에 따라 메뉴 구성이 달라질 수 있습니다.

// CS,  WEB,  MOBILE 구분
choose case lower(AppeonGetClientType())
	case 'pb'
		is_platform_type = '1__'
	case 'web'
		is_platform_type = '_1_'
	case 'mobile'
		is_platform_type = '__1'
end choose

end subroutine

public function integer of_getmenudata_by_menuid (string as_menu_id, ref pf_n_menudata anv_menudata);// ProgramNo 값으로 메뉴데이터 Structure 값을 구한다

long ll_retval

if isnull(as_menu_id) or as_menu_id = '' then return -1

datastore lds_menudata
lds_menudata = create datastore
lds_menudata.dataobject = 'pf_d_rolemenu'
lds_menudata.settransobject(sqlca)

pf_n_userrole lnv_userrole
lnv_userrole = gnv_session.of_get("userrole")
if isvalid(lnv_userrole) then
	ll_retval = lds_menudata.retrieve(gnv_session.is_sys_id, 'self', as_menu_id, string(gnv_session.idtm_login, 'YYYYMMDD'), &
				lnv_userrole.is_memb_code[1], lnv_userrole.is_memb_code[2], lnv_userrole.is_memb_code[3], lnv_userrole.is_memb_code[4], &
				lnv_userrole.is_memb_code[5], lnv_userrole.is_memb_code[6], lnv_userrole.is_memb_code[7], lnv_userrole.is_memb_code[8], &
				is_platform_type)
end if

if ll_retval > 0 then
	anv_menudata.is_menu_id = lds_menudata.getitemstring(1, 'menu_id')
	anv_menudata.is_pgm_id = lds_menudata.getitemstring(1, 'pgm_id')
	anv_menudata.is_pgm_name = lds_menudata.getitemstring(1, 'pgm_name')
end if

destroy lds_menudata
return ll_retval

end function

on pf_n_rolemenu.create
call super::create
end on

on pf_n_rolemenu.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_menudata = create datastore
ids_menudata.dataobject = 'pf_d_rolemenu'
ids_menudata.settransobject(sqlca)

// 현재 어플리케이션의 실행환경을 구합니다
this.of_setplatformtype()

end event

event destructor;call super::destructor;if isvalid(ids_menudata) then
	destroy ids_menudata
end if

end event

