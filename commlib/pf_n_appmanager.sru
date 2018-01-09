HA$PBExportHeader$pf_n_appmanager.sru
$PBExportComments$$$HEX6$$0cd3ccc64cbe54b358c72000$$ENDHEX$$Application Object$$HEX23$$40c62000f0c5c4ac18b4b4c52000b4c50cd5acb900cf74c758c1200050d784b944c7200000adacb969d5c8b2e4b2$$ENDHEX$$.
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
// $$HEX3$$30aef8bc2000$$ENDHEX$$IDLE TIME $$HEX1$$12ac$$ENDHEX$$
constant integer DEFAULT_IDLE_TIMEOUT_SEC = 0

public:
	// $$HEX9$$04d6acc72000e4c289d5200011c978c72000$$ENDHEX$$Application Object
	application inv_application
	
	// PIP $$HEX6$$5cb8f8adddc031c1a9c62000$$ENDHEX$$Object
	pf_n_logger inv_logger
	
	// Main MDI/Login $$HEX8$$08c7c4b3b0c6200038cc70c8c0bc18c2$$ENDHEX$$
	window iw_mainframe
	window iw_login
	
	// CommandParameter $$HEX2$$f4bc00ad$$ENDHEX$$
	string is_commandparm
	
	// $$HEX4$$dcc2a4c25cd12000$$ENDHEX$$ID
	string is_sys_id
	
	// $$HEX6$$dcc2a4c25cd1200085ba6dce$$ENDHEX$$
	string is_sys_name
	
	//  $$HEX8$$5ccd08cde4c289d52000bdac5cb885ba$$ENDHEX$$
	string is_currentdir

	// $$HEX4$$e4c289d5a8badcb4$$ENDHEX$$
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

// Transaction Pool $$HEX2$$24c115c8$$ENDHEX$$($$HEX7$$44d594c65cd52000bdacb0c62000$$ENDHEX$$UnCommnet)
//powerframe.SetTransPool(1, 12, 10)

// $$HEX14$$b4c50cd5acb900cf74c758c1200058d6bdac15c8f4bc2000ddc031c1$$ENDHEX$$
gnv_appconf = Create pf_n_appconfig

// $$HEX5$$38c158c12000ddc031c1$$ENDHEX$$(=$$HEX9$$00ae5cb88cbc2000c0bc18c22000a8ba4cc7$$ENDHEX$$)
gnv_session = create pf_n_appsession 

// $$HEX12$$b4c50cd5acb900cf74c758c1200015c8f4bc200024c115c8$$ENDHEX$$, $$HEX16$$b4c50cd5acb900cf74c758c174c72000ecc5ecb71cac78c72000bdacb0c62000$$ENDHEX$$is_sys_id $$HEX2$$c4bc5cb8$$ENDHEX$$
// $$HEX4$$30aef8bc15c8f4bc$$ENDHEX$$, $$HEX25$$8cad5cd500adacb92000f1b42000a8bae0b4200070b374c730d100ac20006cad84bd18b4b4c52000d9b391c769d5c8b2e4b2$$ENDHEX$$
this.is_sys_id = gnv_appconf.of_getprofile("powerframe.system.id", "PF2SYS")
this.is_sys_name = gnv_appconf.of_getprofile("powerframe.system.name", "$$HEX12$$0cd3ccc604d508b884c72000b4c50cd5acb900cf74c758c1$$ENDHEX$$")
gnv_session.of_put('sys_id', is_sys_id)

// $$HEX4$$e4c289d5a8badcb4$$ENDHEX$$
is_runningmode = this.of_getpbrunningmode()

// $$HEX9$$70b374c730d1a0bc74c7a4c22000f0c5b0ac$$ENDHEX$$
if this.of_DatabaseConnect() = FAILURE then
	halt close
end if

// Current Directory $$HEX2$$f4bc00ad$$ENDHEX$$
is_currentdir = getcurrentdirectory()

// PentaLibrary $$HEX2$$b4cc6cd0$$ENDHEX$$
this.of_checkpentalibrary()

// $$HEX8$$74c7f8bbc0c90cd37cc72000b4cc6cd0$$ENDHEX$$
this.of_checkimagefiles()

// $$HEX10$$9cd3c0d07cb774c70cbeecb7acb92000ddc031c1$$ENDHEX$$(AutoInstantiate)
gnv_extfunc.event constructor()

// IDLE TIMEOUT $$HEX2$$24c115c8$$ENDHEX$$(0=$$HEX3$$34bb1cc85cd5$$ENDHEX$$)
idle(DEFAULT_IDLE_TIMEOUT_SEC)

// IP Address
is_ipaddress = gnv_extfunc.of_getipaddress()

// Mac Address
is_macaddress = gnv_extfunc.of_getmacaddress()

// $$HEX5$$5cb8f8ad2000ddc031c1$$ENDHEX$$
inv_logger = create pf_n_logger

// $$HEX6$$5cb8f8ad78c7200018c289d5$$ENDHEX$$
This.Event pfe_LoginProcess()

end event

event pfe_applicationclose();// $$HEX9$$00ae5cb88cbc2000c0bc18c22000adc01cc8$$ENDHEX$$
if isvalid(gnv_appconf) then Destroy gnv_appconf
if isvalid(gnv_session) then Destroy gnv_session
if isvalid(inv_logger) then Destroy inv_logger

// $$HEX12$$70b374c730d1a0bc74c7a4c22000f0c5b0ac200085c8ccb8$$ENDHEX$$
Disconnect Using SQLCA;

end event

event pfe_afterloginprocess();// $$HEX22$$5cb8f8ad78c774c7200044c6ccb81cb4200074c7c4d6200004d55cb838c1a4c27cb9200030ae20c25cd5e4b2$$ENDHEX$$
if gnv_session.is_login_yn = 'Y' then
	
	// $$HEX16$$acc0a9c690c720005cb8f8ad78c7200015c8f4bc20005cb8f8ad2000ddc031c1$$ENDHEX$$
	inv_logger.of_writelog_login(gnv_session.is_user_id, gnv_session.is_user_name)
	
	// $$HEX2$$54ba78c7$$ENDHEX$$MDI $$HEX6$$08c7c4b3b0c6200024c608d5$$ENDHEX$$
	string ls_mdiwindow
	
	ls_mdiwindow = gnv_appconf.of_getprofile("mdi.window.name", "pf_w_mainframe_type1")
	Open(iw_mainframe, ls_mdiwindow)
end if

end event

event pfe_loginprocess();// $$HEX15$$5cb8f8ad78c7200004d55cb838c1a4c27cb9200018c289d569d5c8b2e4b2$$ENDHEX$$
// $$HEX29$$5cb8f8ad78c7200004d55cb838c1a4c200ac2000ecb27cb7c4c92000bdacb0c6200074c7200074c7a4bcb8d27cb9200018c215c858d538c194c6$$ENDHEX$$

if this.of_CheckSingleSignOn() = false then
	// LOGIN $$HEX6$$08c7c4b3b0c6200024c608d5$$ENDHEX$$
	string ls_loginwindow
	
	ls_loginwindow = gnv_appconf.of_getprofile("login.window.name", "pf_w_login_type1")
	Open(iw_login, ls_loginwindow)
else
	this.post event pfe_afterloginprocess()
end if

// $$HEX9$$5cb8f8ad78c7200008c7c4b3b0c600ac2000$$ENDHEX$$MDI $$HEX34$$15d6dcd074c730ae20004cb538bbd0c5200008c7c4b3b0c6200085c8ccb82000c4d6200004d6acc72000a4c26cd0bdb9b8d25cb82000acb934d118b4c0c920004ac54cc7$$ENDHEX$$.
// $$HEX3$$30b57cb71cc1$$ENDHEX$$, $$HEX9$$74c7c4d62000a4c26cd0bdb9b8d294b22000$$ENDHEX$$ue_afterloginprocess() $$HEX10$$74c7a4bcb8d2d0c51cc1200030ae20c25cd5e4b2$$ENDHEX$$.
// $$HEX25$$5cb8f8ad78c744c7200018c289d558d594b2200024c60cbe1dc8b8d294b220005cb8f8ad78c7200044c6ccb82000c4d62000$$ENDHEX$$gnv_session $$HEX2$$d0c52000$$ENDHEX$$is_login_yn='Y' (of_checkuserauthority $$HEX5$$68d518c2200038cce0ac$$ENDHEX$$)
// $$HEX10$$6dd5a9ba44c7200094cd00ac200058d5e0ac2000$$ENDHEX$$ue_afterloginprocess() $$HEX17$$74c7a4bcb8d27cb9200018bcdcb4dcc2200038d69ccd74d5200018c97cc5200068d5$$ENDHEX$$.

end event

event pfe_applicationidle();// Application Idle Timeout
MessageBox("$$HEX2$$4cc5bcb9$$ENDHEX$$", "$$HEX29$$a5c7dcc204ac200004d55cb8f8ada8b744c72000acc0a9c658d5c0c920004ac544c5200004d55cb8f8ada8b744c7200085c8ccb869d5c8b2e4b2$$ENDHEX$$")
this.event pfe_LogoutProcess()

end event

event pfe_logoutprocess();// $$HEX16$$5cb8f8ad44c5c3c6200004d55cb838c1a4c27cb9200030ae20c269d5c8b2e4b2$$ENDHEX$$

// MDI $$HEX4$$08c7c4b3b0c62000$$ENDHEX$$CLOSE -> $$HEX10$$5cb8f8ad78c7200098d374c7c0c9200074c7d9b3$$ENDHEX$$
IF IsValid(iw_mainframe) THEN
	
	// $$HEX17$$acc0a9c690c720005cb8f8ad44c5c3c6200015c8f4bc20005cb8f8ad2000ddc031c1$$ENDHEX$$
	inv_logger.of_writelog_logout(gnv_session.is_user_id, gnv_session.is_user_name)

	// $$HEX9$$30ae20005cb8f8ad78c7200015c8f4bc2000$$ENDHEX$$clear
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
ls_errmsg += "$$HEX24$$24c658b97cb9200034bbdcc258d5e0ac200091c7c5c544c72000c4ac8dc12000c4c989d558d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?"

// ErrorMessage Logging $$HEX5$$98ccacb9200094cd00ac$$ENDHEX$$

// $$HEX19$$24c658b97cb9200034bbdcc258d5e0ac200091c7c5c52000c4c989d5ecc580bd200055d678c7$$ENDHEX$$
if messagebox(ls_title, ls_errmsg, StopSign!, YesNo!, 2) = 2 then
	halt close;
end if

end event

public function integer of_databaseconnect ();//Appeon Connection Cache
//SQLCA.setcachebyinfo( "JDB-ASA", "pfdemo")

// $$HEX9$$70b374c730d1a0bc74c7a4c22000f0c5b0ac$$ENDHEX$$
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
	Messagebox("Error", "$$HEX18$$70b374c730d12000a0bc74c7a4c22000f0c5b0acd0c52000e4c228d388d5b5c2c8b2e4b2$$ENDHEX$$!~r~n$$HEX15$$a0c7dcc22000c4d62000e4b2dcc22000dcc2c4b374d52000f4bc38c194c6$$ENDHEX$$~r~nConnect Database Failed = " + sqlca.sqlerrtext)
	Return FAILURE
END IF

Return SUCCESS

end function

public function integer of_checkpentalibrary ();// Symantec Endpoint Protection $$HEX3$$8cd63cd5a9c6$$ENDHEX$$
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

public function integer of_checkimagefiles ();// $$HEX42$$d9b301c83cc75cb82000ddc031c118b494b2200024c60cbe1dc8b8d2d0c51cc12000acc0a9c618b494b2200074c7f8bbc0c9e4b440c72000d0c574c73cd528c620001cc184bcd0c51cc1200090c7d9b33cc75cb8$$ENDHEX$$
// $$HEX41$$b4b024b81bbcc0c92000bbba58d530ae20004cb538bbd0c52000b4c50cd5acb900cf74c758c12000dcc291c72000dcc22000b4cc6cd020000fbc200018c2d9b32000e4b2b4c65cb8dcb4200098ccacb968d5$$ENDHEX$$.

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

public function boolean of_checksinglesignon ();// SSO $$HEX12$$5cb8f8ad78c7200015c8f4bc200055d678c720005cb8c1c9$$ENDHEX$$
// SSO $$HEX28$$1cc888d4d0c5200030b57cb720001cc8f5ac18b494b22000d8c00cd520005cb8c1c944c7200038cce0ac5cb8200091c731c158d538c194c6$$ENDHEX$$
// $$HEX29$$44c598b720005cb8c1c940c7200050ad21c7fcac59d530ae20c280bd200004c8acc01cc185ba78c79dc9a9c62000d8c00cd5200085c7c8b2e4b2$$ENDHEX$$

/*
// $$HEX14$$78c79dc91cc120005cb8f8ad78c7200098d374c7c0c9200038d69ccd$$ENDHEX$$
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

// $$HEX11$$74d07cb774c7b8c5b8d2200024c158ce200055d678c7$$ENDHEX$$
String CheckEPKIWcJTl

CheckEPKIWcJTl = wf_CallJSFunction(ole_ie, "CheckEPKIWcJTl();")
if CheckEPKIWcJTl = "false" then
	ole_ie.x = 91
end if

// $$HEX10$$78c79dc91cc1200020c1ddd03dcc200024c608d5$$ENDHEX$$
String ls_SignResult

ls_SignResult = wf_CallJSFunction(ole_ie, "Sign(1, '', '');")

choose case ls_SignResult
	case ''
		ole_ie.object.document.parentwindow.execScript("ECTErrorInfo();", "JavaScript")
		return
	case '100'
		MessageBox('', "$$HEX3$$e8cd8cc128b4$$ENDHEX$$..")
		return
end choose

// $$HEX8$$78c79dc998d374c7c0c9200038d69ccd$$ENDHEX$$
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

// $$HEX6$$b0acfcac12ac200055d678c7$$ENDHEX$$(Authority Key ID)
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
				// $$HEX2$$31c1f5ac$$ENDHEX$$
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
$$HEX15$$5cb8f8ad78c7200044c6ccb8c4d6200030aef8bc15c8f4bc200024c115c8$$ENDHEX$$
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

