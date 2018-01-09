$PBExportHeader$pf_w_login_type1.srw
$PBExportComments$로그인 시 오픈되는 윈도우입니다.
forward
global type pf_w_login_type1 from window
end type
type mdi_1 from mdiclient within pf_w_login_type1
end type
type p_close from pf_u_imagebutton within pf_w_login_type1
end type
type p_ok from pf_u_imagebutton within pf_w_login_type1
end type
type cbx_idcheck from checkbox within pf_w_login_type1
end type
type sle_password from singlelineedit within pf_w_login_type1
end type
type em_emp_code from editmask within pf_w_login_type1
end type
type p_background from picture within pf_w_login_type1
end type
end forward

global type pf_w_login_type1 from window
integer width = 4695
integer height = 2940
boolean titlebar = true
string title = "Powerframe LOGIN"
string menuname = "pf_m_empty"
boolean controlmenu = true
windowtype windowtype = mdi!
string icon = "AppIcon!"
boolean toolbarvisible = false
boolean center = true
event pfe_postopen ( )
mdi_1 mdi_1
p_close p_close
p_ok p_ok
cbx_idcheck cbx_idcheck
sle_password sle_password
em_emp_code em_emp_code
p_background p_background
end type
global pf_w_login_type1 pf_w_login_type1

type variables
constant string INI_FILE_NAME = ".\pf_profile.ini"

end variables

event pfe_postopen();// get ID from INI File

long ll_filehndl

// INI 파일 없으면 신규 생성
if not fileexists(INI_FILE_NAME) then
	ll_filehndl = fileopen(INI_FILE_NAME, textmode!, write!, lockwrite!, replace!)
	fileclose(ll_filehndl)
end if

// INI 파일의 값을 자동 세팅한다
string ls_idcheck
string ls_userid

ls_idcheck = profilestring(INI_FILE_NAME, "Login", "login.remember.id", "N")
if ls_idcheck = "Y" then
	ls_userid = profilestring(INI_FILE_NAME, "Login", "login.last.user.id", "")
	cbx_idcheck.checked = true
	em_emp_code.text = ls_userid
	sle_password.setfocus()
else
	cbx_idcheck.checked = false
	em_emp_code.setfocus()
end if

end event

on pf_w_login_type1.create
if this.MenuName = "pf_m_empty" then this.MenuID = create pf_m_empty
this.mdi_1=create mdi_1
this.p_close=create p_close
this.p_ok=create p_ok
this.cbx_idcheck=create cbx_idcheck
this.sle_password=create sle_password
this.em_emp_code=create em_emp_code
this.p_background=create p_background
this.Control[]={this.mdi_1,&
this.p_close,&
this.p_ok,&
this.cbx_idcheck,&
this.sle_password,&
this.em_emp_code,&
this.p_background}
end on

on pf_w_login_type1.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.p_close)
destroy(this.p_ok)
destroy(this.cbx_idcheck)
destroy(this.sle_password)
destroy(this.em_emp_code)
destroy(this.p_background)
end on

event resize;//Long	ll_wsw, ll_wsh
//Long	ll_diffw, ll_diffh
//
//ll_wsw = This.workspacewidth()
//ll_wsh = This.workspaceheight()
//
//if ll_wsw > p_background.width then
//	ll_diffw = (ll_wsw - p_background.width) / 2 - p_background.x
//end if
//
//if ll_wsh > p_background.height then
//	ll_diffh = (ll_wsh - p_background.height) / 2 - p_background.y
//end if
//
//// 바탕로고 
//p_background.x += ll_diffw
//p_background.y += ll_diffh
//
//// 클로즈
//p_close.x += ll_diffw
//p_close.y += ll_diffh
//
//// 아이디 입력 필드
//em_emp_code.x += ll_diffw
//em_emp_code.y += ll_diffh
//
//// 비밀번호 입력 필드
//sle_password.x += ll_diffw
//sle_password.y += ll_diffh
//
//// 아이디 저장하기 체크박스
//cbx_idcheck.x += ll_diffw
//cbx_idcheck.y += ll_diffh
//
//// OK 그림
//p_ok.x += ll_diffw
//p_ok.y += ll_diffh
//
end event

event key;choose case key
	case KeyEnter!
		p_ok.post event clicked()
		return 0
end choose

return 1

end event

event open;this.event pfe_postopen()

end event

type mdi_1 from mdiclient within pf_w_login_type1
long BackColor=268435456
end type

type p_close from pf_u_imagebutton within pf_w_login_type1
integer x = 4590
integer y = 40
integer width = 55
integer height = 48
string picturename = "..\img\controls\u_tab\closetab.gif"
end type

event clicked;call super::clicked;close(parent)
return

end event

type p_ok from pf_u_imagebutton within pf_w_login_type1
integer x = 1426
integer y = 932
integer width = 215
integer height = 188
integer taborder = 30
string picturename = "..\img\mainframe\w_login_type1\login_ok.gif"
end type

event clicked;call super::clicked;string	ls_uid, ls_pwd
integer i

ls_uid = em_emp_code.text
ls_pwd = sle_password.text

// VALIDATION 처리
if isnull(ls_uid) or len(trim(ls_uid)) = 0 then
	messagebox('알림', 'ID를 입력하세요')
	em_emp_code.post setfocus()
	return
end if

if isnull(ls_pwd) or len(trim(ls_pwd)) = 0 then
	messagebox('알림', 'Password를 입력하세요')
	sle_password.post setfocus()
	return
end if

// 사용자 권한 체크
pf_n_userrole lnv_userrole
lnv_userrole = create pf_n_userrole

choose case lnv_userrole.of_checkUserAuthority(ls_uid, ls_pwd)
	case -1
		messagebox('알림', '해당 시스템을 사용할 수 있는 권한이 없습니다.')
		closewithreturn(parent, 'failure')
		return
	case 0
		return
end choose

// 로그인 정보 Session 보관
// 1. 사용자 권한정보 보관
gnv_session.of_put("userrole", lnv_userrole)

// 2. System_ID 설정
gnv_session.is_sys_id = gnv_appmgr.is_sys_id

// 3. 로그인 여부
gnv_session.is_login_yn = 'Y'

// 4. 로그인 시간
gnv_session.idtm_login = pf_f_getdbmsdatetime()

// 5. 사용자 ID
gnv_session.is_user_id = lnv_userrole.of_getuserinfo('user_id')

// 6. 사용자 명
gnv_session.is_user_name = lnv_userrole.of_getuserinfo('user_name')

// 7. Administrator 여부 확인
for i = 1 to upperbound(lnv_userrole.is_userrole)
	if lnv_userrole.is_userrole[i] = '00001' then
		gnv_session.is_admin_yn = 'Y'
		exit
	end if
next

// 아이디 저장
string ls_lastuser

if cbx_idcheck.checked then
	ls_lastuser = profilestring(INI_FILE_NAME, "Login", "login.last.user.id", "")
	if ls_lastuser <> ls_uid then
		setprofilestring(INI_FILE_NAME, "Login", "login.last.user.id", ls_uid)
	end if
end if

// 로그인 완료 후 프로세스 수행
if appeongetclienttype() = "PB" then
	gnv_appmgr.event pfe_afterloginprocess()
	close(parent)
else
	close(parent)
	gnv_appmgr.event pfe_afterloginprocess()
end if

return

end event

type cbx_idcheck from checkbox within pf_w_login_type1
integer x = 1339
integer y = 1172
integer width = 78
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;// 아이디 저장 여부
string ls_checked

if this.checked then
	ls_checked = 'Y'
else
	ls_checked = 'N'
end if

setprofilestring(INI_FILE_NAME, "Login", "login.remember.id", ls_checked)
return

end event

type sle_password from singlelineedit within pf_w_login_type1
integer x = 818
integer y = 1044
integer width = 562
integer height = 68
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "admin"
boolean border = false
boolean password = true
end type

type em_emp_code from editmask within pf_w_login_type1
integer x = 818
integer y = 948
integer width = 562
integer height = 68
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "admin"
boolean border = false
maskdatatype maskdatatype = stringmask!
string mask = "XXXXXXXXXXXX"
end type

type p_background from picture within pf_w_login_type1
integer width = 4681
integer height = 2880
boolean originalsize = true
string picturename = "..\img\mainframe\w_login_type1\login_penta.jpg"
boolean focusrectangle = false
end type

