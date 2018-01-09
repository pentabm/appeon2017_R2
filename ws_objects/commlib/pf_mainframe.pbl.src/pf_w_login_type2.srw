$PBExportHeader$pf_w_login_type2.srw
$PBExportComments$로그인 시 오픈되는 윈도우입니다.
forward
global type pf_w_login_type2 from window
end type
type mdi_1 from mdiclient within pf_w_login_type2
end type
type p_close from pf_u_imagebutton within pf_w_login_type2
end type
type p_ok from pf_u_imagebutton within pf_w_login_type2
end type
type cbx_idcheck from checkbox within pf_w_login_type2
end type
type sle_password from singlelineedit within pf_w_login_type2
end type
type em_user_id from editmask within pf_w_login_type2
end type
type p_login_bg from picture within pf_w_login_type2
end type
end forward

global type pf_w_login_type2 from window
integer width = 5893
integer height = 3312
boolean titlebar = true
string title = "LOGIN"
string menuname = "pf_m_empty"
boolean controlmenu = true
boolean resizable = true
windowtype windowtype = mdi!
long backcolor = 16777243
string icon = "AppIcon!"
boolean toolbarvisible = false
boolean center = true
event pfe_postopen ( )
mdi_1 mdi_1
p_close p_close
p_ok p_ok
cbx_idcheck cbx_idcheck
sle_password sle_password
em_user_id em_user_id
p_login_bg p_login_bg
end type
global pf_w_login_type2 pf_w_login_type2

type variables

end variables

event pfe_postopen();string ls_user_id

ls_user_id = gnv_appconf.of_getprofile("login.last.user.id", "")
if ls_user_id <> "" then
	em_user_id.text = ls_user_id
	sle_password.setfocus()
else
	em_user_id.setfocus()
end if

end event

on pf_w_login_type2.create
if this.MenuName = "pf_m_empty" then this.MenuID = create pf_m_empty
this.mdi_1=create mdi_1
this.p_close=create p_close
this.p_ok=create p_ok
this.cbx_idcheck=create cbx_idcheck
this.sle_password=create sle_password
this.em_user_id=create em_user_id
this.p_login_bg=create p_login_bg
this.Control[]={this.mdi_1,&
this.p_close,&
this.p_ok,&
this.cbx_idcheck,&
this.sle_password,&
this.em_user_id,&
this.p_login_bg}
end on

on pf_w_login_type2.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.p_close)
destroy(this.p_ok)
destroy(this.cbx_idcheck)
destroy(this.sle_password)
destroy(this.em_user_id)
destroy(this.p_login_bg)
end on

event resize;long ll_width, ll_height
long ll_xpos, ll_ypos
long ll_xposdiff, ll_yposdiff

ll_width = this.workspacewidth()
ll_height = this.workspaceheight()

ll_xpos = p_login_bg.x
ll_ypos = p_login_bg.y

p_login_bg.x = (ll_width - p_login_bg.width) / 2
p_login_bg.y = (ll_height - p_login_bg.height) / 2

ll_xposdiff = ll_xpos - p_login_bg.x
ll_yposdiff = ll_ypos - p_login_bg.y

em_user_id.x -= ll_xposdiff
em_user_id.y -= ll_yposdiff

sle_password.x -= ll_xposdiff
sle_password.y -= ll_yposdiff

p_ok.x -= ll_xposdiff
p_ok.y -= ll_yposdiff


//Long	ll_wsw, ll_wsh
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

event open;// LOGIN 윈도우 타이틀 설정
this.title = gnv_appconf.of_getprofile("powerframe.system.id", "") + " " + this.title

this.event pfe_postopen()

end event

type mdi_1 from mdiclient within pf_w_login_type2
long BackColor=268435456
end type

type p_close from pf_u_imagebutton within pf_w_login_type2
boolean visible = false
integer x = 4590
integer y = 40
integer width = 55
integer height = 48
string picturename = "..\img\controls\u_tab\closetab.gif"
end type

event clicked;call super::clicked;close(parent)
return

end event

type p_ok from pf_u_imagebutton within pf_w_login_type2
integer x = 2862
integer y = 1384
integer width = 379
integer height = 268
integer taborder = 30
boolean originalsize = true
string picturename = "..\img\mainframe\w_login_type2\login_button.jpg"
end type

event clicked;call super::clicked;string	ls_user_id, ls_password
integer i

ls_user_id = em_user_id.text
ls_password = sle_password.text

// VALIDATION 처리
if isnull(ls_user_id) or len(trim(ls_user_id)) = 0 then
	messagebox('알림', 'ID를 입력하세요')
	em_user_id.post setfocus()
	return
end if

if isnull(ls_password) or len(trim(ls_password)) = 0 then
	messagebox('알림', 'Password를 입력하세요')
	sle_password.post setfocus()
	return
end if

// 사용자 권한 체크
pf_n_userrole lnv_userrole
lnv_userrole = create pf_n_userrole

choose case lnv_userrole.of_checkUserAuthority(ls_user_id, ls_password)
	case -1
		closewithreturn(parent, 'failure')
		return
	case 0
		return
end choose

// 로그인 정보 Session 보관
// 1. 사용자 권한정보 보관
gnv_session.of_put("userrole", lnv_userrole)

// 2. System ID
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
if cbx_idcheck.checked then
	if ls_user_id <> gnv_appconf.of_getprofile("login.last.user.id", "") then
		gnv_appconf.of_setprofile("login.last.user.id", ls_user_id)
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

type cbx_idcheck from checkbox within pf_w_login_type2
boolean visible = false
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

type sle_password from singlelineedit within pf_w_login_type2
event ue_keydown pbm_keydown
integer x = 1993
integer y = 1548
integer width = 782
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

event ue_keydown;if key = KeyEnter! then
	p_ok.post event clicked()
end if

end event

event getfocus;this.selecttext(1, 256)

end event

type em_user_id from editmask within pf_w_login_type2
event ue_keydown pbm_keydown
integer x = 1993
integer y = 1408
integer width = 782
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

event ue_keydown;if key = KeyEnter! then
	sle_password.SetFocus()
end if

end event

type p_login_bg from picture within pf_w_login_type2
integer x = 1815
integer y = 1012
integer width = 1426
integer height = 640
boolean originalsize = true
string picturename = "..\img\mainframe\w_login_type2\penta_login.jpg"
boolean focusrectangle = false
end type

