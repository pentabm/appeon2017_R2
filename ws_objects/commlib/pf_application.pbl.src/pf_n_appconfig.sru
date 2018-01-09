$PBExportHeader$pf_n_appconfig.sru
$PBExportComments$프레임워크용 어플리케이션 환경설정 관리용 사용자 오브젝트
forward
global type pf_n_appconfig from pf_n_nonvisualobject
end type
end forward

global type pf_n_appconfig from pf_n_nonvisualobject
end type
global pf_n_appconfig pf_n_appconfig

type variables
constant string PF_PROFILE = ".\pf_profile.ini"

//// ***** Login Section:
//// login_type={normal|sso}
//// login_rememberid ={Y|N}
//string login_type = 'normal'
//string login_object = 'pf_n_login'
//string login_lastloginuser = ''
//string login_rememberid = 'Y'
//
//// ***** Mainframe Section:
//// mainframe_topmenu_type={iconmenu|textmenu}
//// mainframe_leftmenu_type = {treemenu|xpmenu}
//long mainframe_resolution_width = 1024
//long mainframe_resolution_height = 768
//long mainframe_backcolor = 14606046
//long mainframe_midclient_backcolor = 16777215
//string mainframe_use_submenu = 'N'
//
//string mainframe_logo_image_file = '..\img\top\top_logo.gif'
//string mainframe_topmenu_type = 'textmenu'
//string mainframe_leftmenu_type = 'xpmenu'
//long mainframe_leftmenu_backcolor = 14606046
//long mainframe_wintab_backcolor = 12763842
//long mainframe_wintab_normal_font_color = 6643037
//long mainframe_wintab_selected_font_color = 5720472

end variables

forward prototypes
public function string of_getprofile (string as_key, string as_default)
public function string of_getsection (string as_key)
public function integer of_setprofile (string as_key, string as_value)
end prototypes

public function string of_getprofile (string as_key, string as_default);// 파워프레임 환경설정 값을 가져옵니다
// as_key=설정값을 가져올 키값
// as_default=키값이 없을 경우 기본 값
// 리턴값=환경설정 값

string ls_section
string ls_retval

ls_section = this.of_getsection(as_key)
ls_retval  = profilestring(PF_PROFILE, ls_section, as_key, as_default)

return ls_retval

end function

public function string of_getsection (string as_key);// 넘거받은 키값으로 ini파일의 섹션값을 구합니다 
// 검색된 섹션값이 없으면 '.'로 구분되어진 좌측 값을 사용합니다(예:mdi.backcolor = mdi 섹션)
// as_key=섹션값을 구할 키값
// 리턴=검색된 키값

long ll_pos
string ls_section

ll_pos = pos(as_key, '.')
if ll_pos > 0 then
	ls_section = left(as_key, ll_pos - 1)
	choose case ls_section
		case 'pf', 'powerframe'
			ls_section = 'PowerFrame'
		case 'mdi'
			ls_section = 'MDIWindow'
		case 'pip'
			ls_section = 'PIPLogging'
		case 'log'
			ls_section = 'Logger'
		case 'user'
			ls_section = 'UserSettings'
	end choose
else
	ls_section = 'PowerFrame'
end if

return ls_section

end function

public function integer of_setprofile (string as_key, string as_value);// 파워프레임 환경설정 값을 저장합니다
// as_key=ini 파일에 저장할 키값
// as_default=ini 파일에 저장할 값
// 리턴값=성공:1, 실패:-1

string ls_section
integer li_retcd

ls_section = this.of_getsection(as_key)
li_retcd  = setprofilestring(PF_PROFILE, ls_section, as_key, as_value)

return li_retcd

end function

on pf_n_appconfig.create
call super::create
end on

on pf_n_appconfig.destroy
call super::destroy
end on

