HA$PBExportHeader$pf_w_login_type1.srw
$PBExportComments$$$HEX17$$5cb8f8ad78c72000dcc2200024c608d518b494b2200008c7c4b3b0c685c7c8b2e4b2$$ENDHEX$$.
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

// INI $$HEX12$$0cd37cc72000c6c53cc774ba2000e0c2dcad2000ddc031c1$$ENDHEX$$
if not fileexists(INI_FILE_NAME) then
	ll_filehndl = fileopen(INI_FILE_NAME, textmode!, write!, lockwrite!, replace!)
	fileclose(ll_filehndl)
end if

// INI $$HEX14$$0cd37cc758c7200012ac44c7200090c7d9b3200038c105d35cd5e4b2$$ENDHEX$$
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
//// $$HEX5$$14bcd5d05cb8e0ac2000$$ENDHEX$$
//p_background.x += ll_diffw
//p_background.y += ll_diffh
//
//// $$HEX3$$74d05cb888c9$$ENDHEX$$
//p_close.x += ll_diffw
//p_close.y += ll_diffh
//
//// $$HEX9$$44c574c714b5200085c725b8200044d5dcb4$$ENDHEX$$
//em_emp_code.x += ll_diffw
//em_emp_code.y += ll_diffh
//
//// $$HEX10$$44be00bc88bc38d6200085c725b8200044d5dcb4$$ENDHEX$$
//sle_password.x += ll_diffw
//sle_password.y += ll_diffh
//
//// $$HEX13$$44c574c714b5200000c8a5c758d530ae2000b4cc6cd015bca4c2$$ENDHEX$$
//cbx_idcheck.x += ll_diffw
//cbx_idcheck.y += ll_diffh
//
//// OK $$HEX2$$f8adbcb9$$ENDHEX$$
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

// VALIDATION $$HEX2$$98ccacb9$$ENDHEX$$
if isnull(ls_uid) or len(trim(ls_uid)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'ID$$HEX7$$7cb9200085c725b858d538c194c6$$ENDHEX$$')
	em_emp_code.post setfocus()
	return
end if

if isnull(ls_pwd) or len(trim(ls_pwd)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'Password$$HEX7$$7cb9200085c725b858d538c194c6$$ENDHEX$$')
	sle_password.post setfocus()
	return
end if

// $$HEX9$$acc0a9c690c720008cad5cd52000b4cc6cd0$$ENDHEX$$
pf_n_userrole lnv_userrole
lnv_userrole = create pf_n_userrole

choose case lnv_userrole.of_checkUserAuthority(ls_uid, ls_pwd)
	case -1
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX25$$74d5f9b22000dcc2a4c25cd144c72000acc0a9c660d5200018c2200088c794b220008cad5cd574c72000c6c5b5c2c8b2e4b2$$ENDHEX$$.')
		closewithreturn(parent, 'failure')
		return
	case 0
		return
end choose

// $$HEX7$$5cb8f8ad78c7200015c8f4bc2000$$ENDHEX$$Session $$HEX2$$f4bc00ad$$ENDHEX$$
// 1. $$HEX11$$acc0a9c690c720008cad5cd515c8f4bc2000f4bc00ad$$ENDHEX$$
gnv_session.of_put("userrole", lnv_userrole)

// 2. System_ID $$HEX2$$24c115c8$$ENDHEX$$
gnv_session.is_sys_id = gnv_appmgr.is_sys_id

// 3. $$HEX6$$5cb8f8ad78c72000ecc580bd$$ENDHEX$$
gnv_session.is_login_yn = 'Y'

// 4. $$HEX6$$5cb8f8ad78c72000dcc204ac$$ENDHEX$$
gnv_session.idtm_login = pf_f_getdbmsdatetime()

// 5. $$HEX4$$acc0a9c690c72000$$ENDHEX$$ID
gnv_session.is_user_id = lnv_userrole.of_getuserinfo('user_id')

// 6. $$HEX5$$acc0a9c690c7200085ba$$ENDHEX$$
gnv_session.is_user_name = lnv_userrole.of_getuserinfo('user_name')

// 7. Administrator $$HEX5$$ecc580bd200055d678c7$$ENDHEX$$
for i = 1 to upperbound(lnv_userrole.is_userrole)
	if lnv_userrole.is_userrole[i] = '00001' then
		gnv_session.is_admin_yn = 'Y'
		exit
	end if
next

// $$HEX6$$44c574c714b5200000c8a5c7$$ENDHEX$$
string ls_lastuser

if cbx_idcheck.checked then
	ls_lastuser = profilestring(INI_FILE_NAME, "Login", "login.last.user.id", "")
	if ls_lastuser <> ls_uid then
		setprofilestring(INI_FILE_NAME, "Login", "login.last.user.id", ls_uid)
	end if
end if

// $$HEX16$$5cb8f8ad78c7200044c6ccb82000c4d6200004d55cb838c1a4c2200018c289d5$$ENDHEX$$
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

event clicked;// $$HEX9$$44c574c714b5200000c8a5c72000ecc580bd$$ENDHEX$$
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

