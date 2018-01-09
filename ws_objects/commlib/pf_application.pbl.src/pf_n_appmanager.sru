$PBExportHeader$pf_n_appmanager.sru
$PBExportComments$파워빌더의 Application Object와 연계되어 어플리케이션 흐름을 관리합니다.
forward
global type pf_n_appmanager from pf_n_nonvisualobject
end type
end forward

global type pf_n_appmanager from pf_n_nonvisualobject
event pfe_applicationopen ( string commandline )
event pfe_applicationclose ( )
event pfe_afterloginprocess ( )
event pfe_loginprocess ( )
event pfe_applicationidle ( )
event pfe_logoutprocess ( )
event pfe_systemerror ( )
end type
global pf_n_appmanager pf_n_appmanager

type variables
// 기본 IDLE TIME 값
constant integer DEFAULT_IDLE_TIMEOUT_SEC = 0

public:
	// 현재 실행 중인 Application Object
	application inv_application
	
	// PIP 로그생성용 Object
	pf_n_logger inv_logger
	
	// Main MDI/Login 윈도우 참조변수
	window iw_mainframe
	window iw_login
	
	// CommandParameter 보관
	string is_commandparm
	
	// 시스템 ID
	string is_sys_id
	
	// 시스템 명칭
	string is_sys_name
	
	//  최초실행 경로명
	string is_currentdir

	// 실행모드
	string is_runningmode
	
	// IP Address
	string is_ipaddress
	
	// Mac Address
	string is_macaddress
	
end variables

forward prototypes
public function integer of_databaseconnect ()
public function integer of_checkpentalibrary ()
public function string of_getclassname ()
public function integer of_checkimagefiles ()
public function boolean of_checksinglesignon ()
private function boolean of_isrunningindebuggingmode ()
public function string of_getpbrunningmode ()
end prototypes

event pfe_applicationopen(string commandline);// Get Application
inv_application = GetApplication()
is_commandparm = commandline

// Transaction Pool 설정(필요한 경우 UnCommnet)
//powerframe.SetTransPool(1, 12, 10)

// 어플리케이션 환경정보 생성
gnv_appconf = Create pf_n_appconfig

// 세션 생성(=글로벌 변수 모음)
gnv_session = create pf_n_appsession 

// 어플리케이션 정보 설정, 어플리케이션이 여러개인 경우 is_sys_id 별로
// 기본정보, 권한관리 등 모든 데이터가 구분되어 동작합니다
this.is_sys_id = gnv_appconf.of_getprofile("powerframe.system.id", "PF2SYS")
this.is_sys_name = gnv_appconf.of_getprofile("powerframe.system.name", "파워프레임 어플리케이션")
gnv_session.of_put('sys_id', is_sys_id)

// 실행모드
is_runningmode = this.of_getpbrunningmode()

// 데이터베이스 연결
if this.of_DatabaseConnect() = FAILURE then
	halt close
end if

// Current Directory 보관
is_currentdir = getcurrentdirectory()

// PentaLibrary 체크
this.of_checkpentalibrary()

// 이미지파일 체크
this.of_checkimagefiles()

// 펜타라이브러리 생성(AutoInstantiate)
gnv_extfunc.event constructor()

// IDLE TIMEOUT 설정(0=무제한)
idle(DEFAULT_IDLE_TIMEOUT_SEC)

// IP Address
is_ipaddress = gnv_extfunc.of_getipaddress()

// Mac Address
is_macaddress = gnv_extfunc.of_getmacaddress()

// 로그 생성
inv_logger = create pf_n_logger

// 로그인 수행
This.Event pfe_LoginProcess()

end event

event pfe_applicationclose();// 글로벌 변수 삭제
if isvalid(gnv_appconf) then Destroy gnv_appconf
if isvalid(gnv_session) then Destroy gnv_session
if isvalid(inv_logger) then Destroy inv_logger

// 데이터베이스 연결 종료
Disconnect Using SQLCA;

end event

event pfe_afterloginprocess();// 로그인이 완료된 이후 프로세스를 기술한다
if gnv_session.is_login_yn = 'Y' then
	
	// 사용자 로그인 정보 로그 생성
	inv_logger.of_writelog_login(gnv_session.is_user_id, gnv_session.is_user_name)
	
	// 메인MDI 윈도우 오픈
	string ls_mdiwindow
	
	ls_mdiwindow = gnv_appconf.of_getprofile("mdi.window.name", "pf_w_mainframe_type1")
	Open(iw_mainframe, ls_mdiwindow)
end if

end event

event pfe_loginprocess();// 로그인 프로세스를 수행합니다
// 로그인 프로세스가 달라진 경우 이 이벤트를 수정하세요

if this.of_CheckSingleSignOn() = false then
	// LOGIN 윈도우 오픈
	string ls_loginwindow
	
	ls_loginwindow = gnv_appconf.of_getprofile("login.window.name", "pf_w_login_type1")
	Open(iw_login, ls_loginwindow)
else
	this.post event pfe_afterloginprocess()
end if

// 로그인 윈도우가 MDI 형태이기 때문에 윈도우 종료 후 현재 스크립트로 리턴되지 않음.
// 따라서, 이후 스크립트는 ue_afterloginprocess() 이벤트에서 기술한다.
// 로그인을 수행하는 오브젝트는 로그인 완료 후 gnv_session 에 is_login_yn='Y' (of_checkuserauthority 함수 참고)
// 항목을 추가 하고 ue_afterloginprocess() 이벤트를 반드시 호출해 줘야 함.

end event

event pfe_applicationidle();// Application Idle Timeout
MessageBox("알림", "장시간 프로그램을 사용하지 않아 프로그램을 종료합니다")
this.event pfe_LogoutProcess()

end event

event pfe_logoutprocess();// 로그아웃 프로세스를 기술합니다

// MDI 윈도우 CLOSE -> 로그인 페이지 이동
IF IsValid(iw_mainframe) THEN
	
	// 사용자 로그아웃 정보 로그 생성
	inv_logger.of_writelog_logout(gnv_session.is_user_id, gnv_session.is_user_name)

	// 기 로그인 정보 clear
	gnv_session.is_login_yn = 'N'
	gnv_session.idtm_login = datetime('1900-01-01 00:00:00')
	gnv_session.is_user_id = ''
	gnv_session.is_user_name = ''
	
	string ls_loginwindow
	ls_loginwindow = gnv_appconf.of_getprofile("login.window.name", "pf_w_login_type1")
	
	IF AppeonGetClientType() = 'PB' THEN
		Open(iw_login, ls_loginwindow)
		Close(iw_mainframe)
	ELSE
		Close(iw_mainframe)
		Open(iw_login, ls_loginwindow)
	END IF
END IF

end event

event pfe_systemerror();string	ls_title, ls_errmsg

ls_title = "SYSTEM ERROR"
ls_errmsg = "DATETIME : " + string(today(), "yyyy.mm.dd hh:mm:ss") + "~r~n"
ls_errmsg += "ERROR NUMBER : " + string(error.number) + "~r~n"
ls_errmsg += "ERROR MESSAGE : " + error.text + "~r~n"
ls_errmsg += "WINDOW/MENU : " + error.windowmenu + "~r~n"
ls_errmsg += "OBJECT : " + error.object + "~r~n"
ls_errmsg += "EVENT : " + error.objectevent + "~r~n"
ls_errmsg += "LINE : [" + string(error.line) + "]~r~n"
ls_errmsg += "~r~n"
ls_errmsg += "오류를 무시하고 작업을 계속 진행하시겠습니까?"

// ErrorMessage Logging 처리 추가

// 오류를 무시하고 작업 진행여부 확인
if messagebox(ls_title, ls_errmsg, StopSign!, YesNo!, 2) = 2 then
	halt close;
end if

end event

public function integer of_databaseconnect ();//Appeon Connection Cache
//SQLCA.setcachebyinfo( "JDB-ASA", "pfdemo")

// 데이터베이스 연결
SQLCA.DBMS = "ODBC"
SQLCA.AutoCommit = False
SQLCA.DBParm = "ConnectString='DSN=pf3base_asa9;UID=dba;PWD=sql';CacheName=''pf3base_asa9"

//// Profile pces_test
//SQLCA.DBMS = "O10 Oracle10g (10.1.0)"
//SQLCA.LogPass = "erp00"
//SQLCA.ServerName = "ORAERP01"
//SQLCA.LogId = "erpdev"
//SQLCA.AutoCommit = False
//SQLCA.DBParm = "PBCatalogOwner='erpdev'"

Connect Using SQLCA;
IF SQLCA.SqlCode <> 0 THEN
	Messagebox("Error", "데이터 베이스 연결에 실패했습니다!~r~n잠시 후 다시 시도해 보세요~r~nConnect Database Failed = " + sqlca.sqlerrtext)
	Return FAILURE
END IF

Return SUCCESS

end function

public function integer of_checkpentalibrary ();// Symantec Endpoint Protection 회피용
string ls_checkdir
integer li_retval

if appeongetclienttype() = 'WEB' then
	ls_checkdir = appeongetcachedir() + '\plugin\'
	if fileexists(ls_checkdir + 'pentalib.dll.tmp') then
		li_retval = filemove(ls_checkdir + 'pentalib.dll.tmp', ls_checkdir + 'pentalib.dll')
	end if
end if

return li_retval

end function

public function string of_getclassname ();return 'pf_n_appmanager'

end function

public function integer of_checkimagefiles ();// 동적으로 생성되는 오브젝트에서 사용되는 이미지들은 에이피온 서버에서 자동으로
// 내려받지 못하기 때문에 어플리케이션 시작 시 체크 및 수동 다운로드 처리함.

if appeongetclienttype() = "PB" then return 0

string ls_check_img[] = {  &
		"..\img\controls\u_commandbutton\grey_btn.png", &
		"..\img\controls\u_commandbutton\grey_btn_clicked.png", &
		"..\img\controls\u_commandbutton\grey_btn_disabled.png", &
		"..\img\controls\u_commandbutton\grey_btn_hover.png", &
		"..\img\controls\u_commandbutton\grey_btn_icon\gbicon_check.png", &
		"..\img\controls\u_commandbutton\sub_btn.png", &
		"..\img\controls\u_commandbutton\sub_btn_clicked.png", &
		"..\img\controls\u_commandbutton\sub_btn_disabled.png", &
		"..\img\controls\u_commandbutton\sub_btn_hover.png", &
		"..\img\controls\u_commandbutton\sub_btn_icon\sub_btn_ico_01.png", &
		"..\img\controls\u_commandbutton\webst_btn.gif", &
		"..\img\controls\u_commandbutton\webst_btn_hover.gif", &
		"..\img\controls\u_commandbutton\webst_btn_clicked.gif", &
		"..\img\controls\u_commandbutton\webst_btn_disabled.gif", &
		"..\img\mainframe\u_mdi_sheettab\sheettab_normal.gif", &
		"..\img\mainframe\u_mdi_sheettab\sheettab_selected.gif", &
		"..\img\mainframe\u_mdi_sheettab\sheettab2_normal.png", &
		"..\img\mainframe\u_mdi_sheettab\sheettab2_selected.png", &
		"..\img\mainframe\u_mdi_sheettab\sheettab3_normal.png", &
		"..\img\mainframe\u_mdi_sheettab\sheettab3_selected.png", &
		"..\img\controls\u_tab\tab1_selected.jpg", &
		"..\img\controls\u_tab\tab1_disabled.jpg", &
		"..\img\controls\u_tab\tab1_normal.jpg", &
		"..\img\controls\u_tab\tab2_selected.jpg", &
		"..\img\controls\u_tab\tab2_disabled.jpg", &
		"..\img\controls\u_tab\tab2_normal.jpg", &
		"..\img\controls\u_tab\tab3_selected.png", &
		"..\img\controls\u_tab\tab3_disabled.png", &
		"..\img\controls\u_tab\tab3_normal.png" &
		}

string ls_cachedir
string ls_url, ls_localfile
integer i

ls_cachedir = appeongetcachedir() + "\images\"
for i = 1 to upperbound(ls_check_img)
	ls_localfile = ls_cachedir + gnv_extfunc.of_pathstrippath(ls_check_img[i])
	if not fileexists(ls_localfile) then
		ls_url = appeongetieurl() + "images/" + gnv_extfunc.of_pathstrippath(ls_check_img[i])
		gnv_extfunc.of_urldownloadtofile(ls_url, ls_localfile)
	end if
next

return 1

end function

public function boolean of_checksinglesignon ();// SSO 로그인 정보 확인 로직
// SSO 제품에 따라 제공되는 샘플 로직을 참고로 작성하세요
// 아래 로직은 교육과학기술부 전사서명인증용 샘플 입니다

/*
// 인증서 로그인 페이지 호출
constant string FormURL = "http://test.ac.kr/epki/CertInfo_Demo1.jsp"

string	ls_OldURL

if ole_ie.visible = false then ole_ie.Visible = True
ls_OldURL = ole_ie.Object.LocationURL

if ls_OldURL = FormURL then
	// Do nothing
else
	ole_ie.Object.Navigate2(FormURL);
	
	// Wait for Document to start loading
	do while ls_OldURL = ole_ie.Object.LocationURL
		Yield()
	loop
end if

// Wait for Document to finish loading
do while ole_ie.Object.Busy
	yield()
loop

// 클라이언트 설치 확인
String CheckEPKIWcJTl

CheckEPKIWcJTl = wf_CallJSFunction(ole_ie, "CheckEPKIWcJTl();")
if CheckEPKIWcJTl = "false" then
	ole_ie.x = 91
end if

// 인증서 선택창 오픈
String ls_SignResult

ls_SignResult = wf_CallJSFunction(ole_ie, "Sign(1, '', '');")

choose case ls_SignResult
	case ''
		ole_ie.object.document.parentwindow.execScript("ECTErrorInfo();", "JavaScript")
		return
	case '100'
		MessageBox('', "취소됨..")
		return
end choose

// 인증페이지 호출
String ls_script

ls_script = "document.forms[0].SignedData.value = '" + ls_SignResult + "';~r~n"
ls_script += "document.forms[0].submit();"

ole_ie.object.document.parentwindow.execScript(ls_script, "JavaScript")
ls_OldURL = ole_ie.Object.LocationURL

// Wait for Document to start loading
do while ls_OldURL = ole_ie.Object.LocationURL
	Yield()
loop

// Wait for Document to finish loading
do while ole_ie.Object.Busy
	yield()
loop

// 결과값 확인(Authority Key ID)
Integer li_form_ctr, li_elem_ctr
Integer i, j
Any la_name, la_type, la_value
String ls_value
Integer li_pos

// Search thru Forms
li_form_ctr = ole_ie.Object.Document.Forms.Length
FOR i = 0 TO li_form_ctr - 1
	// Search thru Elements
	li_elem_ctr = ole_ie.Object.Document.Forms[i].Elements.All.Length
	 FOR j = 0 TO li_elem_ctr - 1
		la_Name = ole_ie.Object.Document.Forms[i].Elements.All[j].GetAttribute("name")
		la_Type = ole_ie.Object.Document.Forms[i].Elements.All[j].GetAttribute("type")
		la_Value = ole_ie.Object.Document.Forms[i].Elements.All[j].GetAttribute("value")
		ls_value = String(la_value)
		li_pos = Pos(ls_value, "KeyID=")
		IF li_pos > 0 THEN
			li_pos = Pos(ls_value, "cn=")
			IF  li_pos > 0 THEN
				// 성공
				ls_value = mid(ls_value, li_pos)
				Messagebox(String(la_name), ls_value)
			END IF
		END IF
	NEXT
NEXT
*/

/*
String wf_calljsfunction(ref olecustomcontrol aole_ie, string as_expr)

String ls_script
String ls_retval

if not isvalid(aole_ie) then return ''

ls_script = "var newElement = document.createElement(~"<input id='APBReturnValue' type='hidden'>~");~r~n"
ls_script += "document.body.appendChild(newElement);~r~n"
ls_script += "newElement.value = " + as_expr
aole_ie.object.document.parentwindow.execScript(ls_script, "JavaScript")

ls_retval = String(aole_ie.object.document.getElementByID("APBReturnValue").value)
ls_script = "var delElement = document.getElementById('APBReturnValue');~r~n"
ls_script += "(delElement.parentNode).removeChild(delElement);"
aole_ie.object.document.parentwindow.execScript(ls_script, "JavaScript")

return ls_retval
*/

/*
로그인 완료후 기본정보 설정
gnv_session.is_login_yn = 'Y'
gnv_session.idtm_login = pf_f_getdbmsdatetime()
gnv_session.is_user_id = ls_value
gnv_session.is_user_name = string(la_name)
*/

Return false

end function

private function boolean of_isrunningindebuggingmode ();//Find out if the application is being run in PowerBuilder debugger. We
//look for a PowerBuilder MDI frame.
//If found, look for MDIClient. If found, look for window with title
//beginning with "Debugger" If found -> Debug!

long ll_Desktop,ll_Child, ll_child2, ll_child3

string ls_ClassName, ls_WindowName

Constant long GW_HWNDFIRST = 0
Constant long GW_HWNDLAST = 1
Constant long GW_HWNDNEXT = 2
Constant long GW_HWNDPREV = 3
Constant long GW_OWNER = 4
Constant long GW_CHILD = 5
Constant long GW_MAX = 5

Constant long MAX_WIDTH = 255

ll_Desktop = gnv_extfunc.GetDesktopWindow()

ll_Child = gnv_extfunc.GetWindow( ll_Desktop, GW_CHILD )

DO WHILE (ll_Child > 0)
	ls_ClassName = Space(MAX_WIDTH)
	gnv_extfunc.GetClassNameA( ll_Child, ls_ClassName, MAX_WIDTH )
	
	// PowerBuilder Main window. The whole name would be for PB11 "PBFRAME110".
	IF Left(ls_classname, 7) = "PBFRAME" THEN
		// PowerBuilder Main window found. Now look for MDI client
		ll_Child2 = gnv_extfunc.GetWindow( ll_Child, GW_CHILD )
		DO WHILE (ll_Child2 > 0)
			ls_ClassName = Space(MAX_WIDTH)
			gnv_extfunc.GetClassNameA( ll_Child2, ls_ClassName, MAX_WIDTH )
			IF ls_classname = "MDIClient" THEN
				// We get closer, the MDI Client was found. Now look for the debugger sheet; use the Window title, not the class
				ll_Child3 = gnv_extfunc.GetWindow( ll_Child2, GW_CHILD )
				DO WHILE (ll_Child3 > 0)
					ls_WindowName = Space(MAX_WIDTH)
					gnv_extfunc.GetWindowTextA( ll_Child3, ls_WindowName, MAX_WIDTH )
					IF Left(ls_WindowName, 8) = "Debugger" THEN
						RETURN true
					END IF
					ll_Child3 = gnv_extfunc.GetWindow( ll_Child3, GW_HWNDNEXT )
				LOOP
			END IF
			ll_Child2 = gnv_extfunc.GetWindow( ll_Child2, GW_HWNDNEXT )
		LOOP
	END IF
	ll_Child = gnv_extfunc.GetWindow( ll_Child, GW_HWNDNEXT )
LOOP

RETURN false

end function

public function string of_getpbrunningmode ();CONSTANT String IS_ENV_EXE = "exe"
CONSTANT String IS_ENV_PB = "pb"
CONSTANT String IS_ENV_DEBUG = "debug"

String ls_enviroment

// Finf out the environment.
IF Handle(GetApplication()) = 0 THEN
	IF of_isrunningindebuggingmode() THEN
		ls_enviroment = IS_ENV_DEBUG
	ELSE
		ls_enviroment = IS_ENV_PB
	END IF
ELSE
	ls_enviroment = IS_ENV_EXE
END IF

RETURN ls_enviroment

end function

on pf_n_appmanager.create
call super::create
end on

on pf_n_appmanager.destroy
call super::destroy
end on

