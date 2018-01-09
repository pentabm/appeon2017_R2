HA$PBExportHeader$pf_n_rolemenu.sru
$PBExportComments$$$HEX46$$5cb8f8ad78c75cd52000acc0a9c690c758c720008cad5cd5d0c5200030b57cb72000acc0a9c6200000aca5b25cd5200004d55cb8f8ada8b72000a9ba5db844c7200098ccacb958d594b2200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
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

public function integer of_getmenudata_by_pgmid (string as_pgm_id, ref pf_n_menudata anv_menudata);// ProgramID $$HEX10$$12ac3cc75cb8200054ba74b270b374c730d12000$$ENDHEX$$Structure $$HEX6$$12ac44c720006cad5cd5e4b2$$ENDHEX$$

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
		// pgm_id $$HEX12$$00ac2000ecc5ecb774ac2000f1b45db81cb42000bdacb0c6$$ENDHEX$$, $$HEX24$$acc0a9c620b4200004d55cb8f8ada8b744c72000acc0a9c690c7d0c58cac200020c1ddd058d5c4b35db820005cd5e4b2$$ENDHEX$$
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

public function string of_getpgmpath (string as_menu_id);// menu_id$$HEX14$$58c7200054ba74b22000bdac5cb87cb920006cad5cd5e4b2200008c6$$ENDHEX$$) $$HEX3$$59d5acc02000$$ENDHEX$$> $$HEX3$$85c7dcc22000$$ENDHEX$$> $$HEX4$$85c7dcc204c815d6$$ENDHEX$$

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

public function string of_getpgmname (string as_menu_id);// $$HEX27$$04d55cb8f8ada8b7200030aef8bc15c8f4bcd0c52000f1b45db81cb4200004d55cb8f8ada8b7200085ba44c720006cad69d5c8b2e4b2$$ENDHEX$$
// as_menu_id = $$HEX3$$54ba74b22000$$ENDHEX$$ID

string	ls_pgm_name

select		pgm_name
into		:ls_pgm_name
from		pf_pgm_mst
where	sys_id = :gnv_session.is_sys_id
and		menu_id = :as_menu_id
using		sqlca;

return ls_pgm_name

end function

public function long of_getmenudata (string as_itemtype, string as_menu_id);// $$HEX23$$5cb8f8ad78c72000acc0a9c690c7d0c58cac200060d5f9b21cb4200054ba74b27cb9200024c115c869d5c8b2e4b2$$ENDHEX$$
// $$HEX8$$24c115c81cb4200054ba74b294b22000$$ENDHEX$$ids_userrrole $$HEX13$$70b374c730d1a4c2a0d1b4c5d0c52000f4bc00ad29b4c8b2e4b2$$ENDHEX$$.

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

protected subroutine of_setplatformtype ();// $$HEX35$$0cd3ccc604d508b884c740c720000cd5abb7fcd32000c0d085c7d0c5200030b57cb7200054ba74b220006cad31c174c72000ecb27cb7c8c9200018c2200088c7b5c2c8b2e4b2$$ENDHEX$$.

// CS,  WEB,  MOBILE $$HEX2$$6cad84bd$$ENDHEX$$
choose case lower(AppeonGetClientType())
	case 'pb'
		is_platform_type = '1__'
	case 'web'
		is_platform_type = '_1_'
	case 'mobile'
		is_platform_type = '__1'
end choose

end subroutine

public function integer of_getmenudata_by_menuid (string as_menu_id, ref pf_n_menudata anv_menudata);// ProgramNo $$HEX10$$12ac3cc75cb8200054ba74b270b374c730d12000$$ENDHEX$$Structure $$HEX6$$12ac44c720006cad5cd5e4b2$$ENDHEX$$

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

// $$HEX21$$04d6acc72000b4c50cd5acb900cf74c758c158c72000e4c289d558d6bdac44c720006cad69d5c8b2e4b2$$ENDHEX$$
this.of_setplatformtype()

end event

event destructor;call super::destructor;if isvalid(ids_menudata) then
	destroy ids_menudata
end if

end event

