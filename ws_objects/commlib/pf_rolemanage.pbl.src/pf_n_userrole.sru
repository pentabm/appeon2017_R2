$PBExportHeader$pf_n_userrole.sru
$PBExportComments$로그인 가능한 사용자를 확인하는 기능 및 로그인한 사용자의 권한을 확인하는 기능을 담당하는 오브젝트 입니다.
forward
global type pf_n_userrole from pf_n_nonvisualobject
end type
end forward

global type pf_n_userrole from pf_n_nonvisualobject
end type
global pf_n_userrole pf_n_userrole

type variables
public:
	datastore ids_rolecat
	datastore ids_userinfo
	string is_userrole[]
	string is_memb_code[]

end variables

forward prototypes
public function integer of_checkuserauthority (string as_user_id, string as_user_pwd)
public function long of_setuserinfo (string as_user_id)
public function string of_getuserinfo (string as_columnname)
public function integer of_setuserrole (string as_user_id)
public function string of_getclassname ()
end prototypes

public function integer of_checkuserauthority (string as_user_id, string as_user_pwd);// 사용자 권한 확인 및 사용자 정보 설정

string ls_user_id, ls_user_name, ls_user_pwd

select		a.user_id,
			a.user_name,
			a.user_pwd
into		:ls_user_id,
			:ls_user_name,
			:ls_user_pwd
from		pf_user_mst a
where	a.user_id = :as_user_id
using		sqlca;

choose case sqlca.sqlcode
	case -1
		messagebox('알림', '데이터베이스 오류로 로그인 과정을 진행할 수 없습니다~r~n' + sqlca.sqlerrtext)
		return FAILURE
	case 100
		messagebox('알림', '로그인 아이디 또는 비밀번호가 일치하지 않습니다')
		return NO_ACTION
end choose

if ls_user_pwd <> as_user_pwd then
	messagebox('알림', '로그인 아이디 또는 비밀번호가 일치하지 않습니다')
	return NO_ACTION
end if

// USER_MST 테이블 조회
if this.of_SetUserInfo(ls_user_id) < 0 then
	return FAILURE
end if

// 사용자 권한 설정
if this.of_SetUserRole(ls_user_id) < 0 then
	return FAILURE
end if

return SUCCESS

end function

public function long of_setuserinfo (string as_user_id);// pf_user_mst 사용자 정보를 보관한다

string	ls_syntax
string ls_query
string ls_errmsg
long ll_rtn

if isvalid(ids_userinfo) then
	destroy ids_userinfo
end if

ls_query = "select * from pf_user_mst where user_id = '" + as_user_id + "'"

ls_syntax = sqlca.syntaxfromsql(ls_query, "Style(Type=Grid)" + &
                                                            " Text(Background.Color=13160660" + &
                                                            " Background.Mode=0" + &
                                                            " Border=6" + &
                                                            " Color=0) "  &
                                                            , ls_errmsg)

if len(ls_errmsg) > 0 then
	messagebox('알림', '사용자 정보 읽기 오류~r~n' + ls_errmsg)
	return -1
end if

ids_userinfo = create datastore
ids_userinfo.create(ls_syntax, ls_errmsg)

if len(ls_errmsg) > 0 then
	messagebox('알림', '사용자 정보 읽기 오류~r~n' + ls_errmsg)
	return -1
end if

ids_userinfo.settransobject(sqlca)
ll_rtn = ids_userinfo.retrieve()

return ll_rtn

end function

public function string of_getuserinfo (string as_columnname);string ls_coltype
string ls_retval

setnull(ls_retval)
if ids_userinfo.rowcount() = 0 then return ls_retval

ls_coltype = ids_userinfo.describe(as_columnname + '.coltype')
choose case left(ls_coltype, 5)
	case 'char('
		ls_retval = ids_userinfo.getitemstring(1, as_columnname)
	case 'date'
		ls_retval = string(ids_userinfo.getitemDate(1, as_columnname), 'yyyy-mm-dd')
	case 'datet'
		ls_retval = string(ids_userinfo.getitemDateTime(1, as_columnname), 'yyyy-mm-dd hh:mm:ss')
	case 'decim'
		ls_retval = string(ids_userinfo.getitemDecimal(1, as_columnname))
	case 'int', 'long', 'ulong', 'numbe', 'real'
		ls_retval = string(ids_userinfo.getitemnumber(1, as_columnname))
	case 'time', 'times'
		ls_retval = string(ids_userinfo.getitemTime(1, as_columnname), 'hh:mm:ss')
	case '!', '?'
		messagebox('of_getuserinfo()', '[' + as_columnname + '] 존재하지 않는 컬럼명 입니다')
end choose

if isnull(ls_retval) then ls_retval = ''
return ls_retval

end function

public function integer of_setuserrole (string as_user_id);integer i
long ll_role_cat_no, ll_row_cnt
string ls_user_tbl_col, ls_user_tbl_data
string ls_temp[8]

is_memb_code = ls_temp

ids_rolecat = create datastore
ids_rolecat.dataobject = 'pf_d_userrole_cat'
ids_rolecat.settransobject(sqlca)
ll_row_cnt = ids_rolecat.retrieve(gnv_appmgr.is_sys_id)

for i = 1 to ll_row_cnt
	ll_role_cat_no = long(ids_rolecat.getitemstring(i, 'role_cat_no'))
	ls_user_tbl_col = ids_rolecat.getitemstring(i, 'user_tbl_col')
	ls_user_tbl_data = of_getuserinfo(ls_user_tbl_col)
	if isnull(ls_user_tbl_data) then ls_user_tbl_data = ''
	is_memb_code[ll_role_cat_no] = ls_user_tbl_data
next

string ls_userrole[]
datastore lds_role_info
lds_role_info = create datastore
lds_role_info.dataobject = 'pf_d_userinfo_role'
lds_role_info.settransobject(sqlca)
ll_row_cnt = lds_role_info.retrieve(gnv_appmgr.is_sys_id, string(pf_f_getdbmsdatetime(), 'YYYYMMDD'), is_memb_code[1], is_memb_code[2], &
					is_memb_code[3], is_memb_code[4], is_memb_code[5], is_memb_code[6], is_memb_code[7], is_memb_code[8])

for i = 1 to ll_row_cnt
	ls_userrole[i] = lds_role_info.getitemstring(i, 'role_no')
next

is_userrole = ls_userrole
destroy lds_role_info

if ll_row_cnt = 0 then
	//messagebox('알림', '해당 시스템을 사용할 수 있는 권한이 없습니다')
	return -1
end if

//return ll_row_cnt
//
//integer i
//long ll_role_cat_no, ll_row_cnt
//string ls_user_tbl_col, ls_user_tbl_data
//string ls_memb_code[8]
//
//ids_rolecat = create datastore
//ids_rolecat.dataobject = 'pf_d_userrole_cat'
//ids_rolecat.settransobject(sqlca)
//ll_row_cnt = ids_rolecat.retrieve(gnv_appmgr.is_sys_id)
//
//for i = 1 to ll_row_cnt
//	ll_role_cat_no = long(ids_rolecat.getitemstring(i, 'role_cat_no'))
//	ls_user_tbl_col = ids_rolecat.getitemstring(i, 'user_tbl_col')
//	ls_user_tbl_data = of_getuserinfo(ls_user_tbl_col)
//	ls_memb_code[ll_role_cat_no] = ls_user_tbl_data
//next
//
//string ls_userrole[]
//datastore lds_role_info
//lds_role_info = create datastore
//lds_role_info.dataobject = 'pf_d_userinfo_role'
//lds_role_info.settransobject(sqlca)
//ll_row_cnt = lds_role_info.retrieve(gnv_appmgr.is_sys_id, gnv_session.of_getstring("login_dt"), ls_memb_code[1], ls_memb_code[2], &
//					ls_memb_code[3], ls_memb_code[4], ls_memb_code[5], ls_memb_code[6], ls_memb_code[7], ls_memb_code[8])
//
//for i = 1 to ll_row_cnt
//	ls_userrole[i] = lds_role_info.getitemstring(i, 'role_no')
//next
//
//is_userrole = ls_userrole
//destroy lds_role_info
//
//if ll_row_cnt = 0 then
//	messagebox('알림', '해당 시스템을 사용할 수 있는 권한이 없습니다')
//	return -1
//end if
//
//return ll_row_cnt

end function

public function string of_getclassname ();return 'pf_n_userauthority'

end function

on pf_n_userrole.create
call super::create
end on

on pf_n_userrole.destroy
call super::destroy
end on

