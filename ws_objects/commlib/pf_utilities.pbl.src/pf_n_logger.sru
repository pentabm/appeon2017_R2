$PBExportHeader$pf_n_logger.sru
$PBExportComments$개인정보보호 로그생성 NVO
forward
global type pf_n_logger from pf_n_nonvisualobject
end type
end forward

global type pf_n_logger from pf_n_nonvisualobject
event pfe_postopen ( )
end type
global pf_n_logger pf_n_logger

type prototypes
function long getip( ref string as_ip, long al_len ) library "getmacip.dll" alias for "getip;Ansi"
function long getmac( ref string as_mac, long al_len ) library "getmacip.dll" alias for "getmac;Ansi"
function long gethost( ref string as_host, long al_len ) library "getmacip.dll" alias for "gethost;Ansi"

end prototypes

type variables
constant string LOGGING_SERVLET_URL = "http://210.97.155.202:8080/pentadispatchers/LoggerServlet"
constant string LOGGING_TYPE = "info"

string is_ipaddress
string is_hostname

string is_user_id
string is_user_name

// XMLHttp Object Appeon 동작 안 함
// Inet Object로 대체합니다
//oleobject inv_xmlhttp

inet inv_inet
pf_n_internetresult inv_result

string ls_logging_yn = 'Y'

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_writelog (string as_post_variables)
public function integer of_writelog_login (string as_user_id, string as_user_name)
public function integer of_writelog_logout (string as_user_id, string as_user_name)
public function integer of_writelog_btnclk (string as_window_id, string as_window_name, string as_btn_id, string as_btn_name)
public function integer of_writelog_openwin (string as_window_id, string as_window_name)
public function integer of_writelog_closewin (string as_window_id, string as_window_name)
public function integer of_testlog (string as_filename, string as_message)
end prototypes

event pfe_postopen();// PIP  로그 생성 여부
ls_logging_yn = gnv_appconf.of_getprofile("pip.logging", "N")

if ls_logging_yn = 'Y' then
	integer li_rc
	
	// 실행중인 PC의 HostName 과 IP 주소를 가져옵니다
	
	is_hostname = space(50)
	gethost(is_hostname, lena(is_hostname))
	
	is_ipaddress = space(50)
	getip(is_ipaddress, lena(is_ipaddress))
	
	//// XMLHTTP OleObject 생성
	//inv_xmlhttp = CREATE oleobject
	//li_rc = inv_xmlhttp.ConnectToNewObject("Msxml2.XMLHTTP")
	//messagebox('li_rc', li_rc)
	//if li_rc > 0 then
	//	choose case li_rc
	//		case -1;  messagebox('[' + this.classname() + '] ConnectToObject', 'Invalid Call: the argument is the Object property of a control')
	//		case -2;  messagebox('[' + this.classname() + '] ConnectToObject', 'Class name not found')
	//		case -3;  messagebox('[' + this.classname() + '] ConnectToObject', 'Object could not be created')
	//		case -4;  messagebox('[' + this.classname() + '] ConnectToObject', 'Could not connect to object')
	//		case -9;  messagebox('[' + this.classname() + '] ConnectToObject', 'Other error')
	//		case -15;  messagebox('[' + this.classname() + '] ConnectToObject', 'COM+ is not loaded on this computer')
	//		case -16;  messagebox('[' + this.classname() + '] ConnectToObject', 'Invalid Call this function not applicable')
	//	end choose
	//end if
	
	li_rc = GetContextService( "Internet", inv_inet )
	if li_rc = success then
		inv_result = create pf_n_internetresult
	end if
end if

end event

public function string of_getclassname ();return 'pf_n_logger'

end function

public function integer of_writelog (string as_post_variables);blob lblb_post_data

if ls_logging_yn <> "Y" then return no_action
if isnull(as_post_variables) then return no_action

//include parameters on the URL here for get parameters
as_post_variables = "LogType=" + LOGGING_TYPE + "&LogMesg=호스트명=" + is_hostname + ", IP주소=" + is_ipaddress + ", " + as_post_variables

//as_post_variables
long ll_length
string ls_header
integer li_rc

lblb_post_data = blob(as_post_variables, EncodingUTF8!)
ll_length = len(lblb_post_data)

ls_header = "Content-Type: application/x-www-form-urlencoded; charset=UTF-8~n"
ls_header += "Content-Length: " + string(ll_length) + "~n~n"

li_rc = inv_inet.PostURL(LOGGING_SERVLET_URL, lblb_post_data, ls_header, inv_result)
if li_rc < 0 then
	choose case li_rc
		case -1;  messagebox('PostURL', 'General error')
		case -2;  messagebox('PostURL', 'Invalid URL')
		case -4;  messagebox('PostURL', 'Cannot connect to the Internet')
		case -5;  messagebox('PostURL', 'Unsupported secure (HTTPS) connection attempted')
		case -6;  messagebox('PostURL', 'Internet request failed')
		case else; messagebox('PostURL', 'Unknown error')
	end choose
	return failure
end if

////First lets do a POST request 
//inv_xmlhttp.Open("POST", LOGGING_SERVLET_URL, true)
//inv_xmlhttp.SetRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8")
//inv_xmlhttp.Send(lblb_post_data)

// no need to check the result, cuase http calling is in async mode.

//Get our response
//ls_status_text = inv_xmlhttp.StatusText
//ll_status_code =  inv_xmlhttp.Status

////Check HTTP Response code for errors
//if ll_status_code >= 300 then
//	MessageBox("HTTP POST Request Failed", ls_response_text)
//else
//	//Get the response we received from the web server
//	ls_response_text = inv_xmlhttp.ResponseText
//	MessageBox("POST Request Succeeded", ls_response_text)
//end if

 return success
 
end function

public function integer of_writelog_login (string as_user_id, string as_user_name);// 로그인 내역을 Write 합니다

if ls_logging_yn <> "Y" then return no_action

string ls_variables

ls_variables = "작업종류=로그인"
ls_variables += ", 사용자ID=" + as_user_id
ls_variables += ", 사용자명=" + as_user_name

is_user_id = as_user_id
is_user_name = as_user_name

return this.of_writelog(ls_variables)

end function

public function integer of_writelog_logout (string as_user_id, string as_user_name);// 로그아웃 내역을 Write 합니다

if ls_logging_yn <> "Y" then return no_action

string ls_variables

ls_variables = "작업종류=로그아웃"
ls_variables += ", 사용자ID=" + as_user_id
ls_variables += ", 사용자명=" + as_user_name

is_user_id = ''
is_user_name = ''

return this.of_writelog(ls_variables)

end function

public function integer of_writelog_btnclk (string as_window_id, string as_window_name, string as_btn_id, string as_btn_name);// 버튼 클릭 내역을 Write 합니다

if ls_logging_yn <> "Y" then return no_action

string ls_variables

ls_variables = "작업종류=버튼클릭"
ls_variables += ", 사용자ID=" + is_user_id
ls_variables += ", 사용자명=" + is_user_name
ls_variables += ", 윈도우ID=" + as_window_id
ls_variables += ", 윈도우명=" + as_window_name
ls_variables += ", 버튼ID=" + as_btn_id
ls_variables += ", 버튼명=" + as_btn_name

return this.of_writelog(ls_variables)

end function

public function integer of_writelog_openwin (string as_window_id, string as_window_name);// 윈도우 오픈 로그인 내역을 Write 합니다

if ls_logging_yn <> "Y" then return no_action

string ls_variables

ls_variables = "작업종류=윈도우시작"
ls_variables += ", 사용자ID=" + is_user_id
ls_variables += ", 사용자명=" + is_user_name
ls_variables += ", 윈도우ID=" + as_window_id
ls_variables += ", 윈도우명=" + as_window_name

return this.of_writelog(ls_variables)

end function

public function integer of_writelog_closewin (string as_window_id, string as_window_name);// 윈도우 종료 로그인 내역을 Write 합니다

if ls_logging_yn <> "Y" then return no_action

string ls_variables

ls_variables = "작업종류=윈도우종료"
ls_variables += ", 사용자ID=" + is_user_id
ls_variables += ", 사용자명=" + is_user_name
ls_variables += ", 윈도우ID=" + as_window_id
ls_variables += ", 윈도우명=" + as_window_name

return this.of_writelog(ls_variables)

end function

public function integer of_testlog (string as_filename, string as_message);// 내부 프로그램 테스트용 임시 함수
integer li_filenum

li_filenum = fileopen(as_filename, LineMode!, Write!, LockWrite!, Append!)
if li_filenum > 0 then
	filewrite(li_filenum, as_message)
	fileclose(li_filenum)
end if

return li_filenum

end function

on pf_n_logger.create
call super::create
end on

on pf_n_logger.destroy
call super::destroy
end on

event constructor;call super::constructor;// Call Post Open Event
this.post event pfe_postopen()

end event

event destructor;call super::destructor;//if isvalid(inv_xmlhttp) then
//	inv_xmlhttp.disconnectserver()
//end if

if isvalid(inv_inet) then
	destroy inv_inet
end if

if isvalid(inv_result) then
	destroy (inv_result)
end if

end event

