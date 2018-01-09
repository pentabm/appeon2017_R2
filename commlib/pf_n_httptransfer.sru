HA$PBExportHeader$pf_n_httptransfer.sru
$PBExportComments$HTTP $$HEX9$$15d6dcd05cb820000cd37cc744c72000a1c1$$ENDHEX$$,$$HEX12$$18c2e0c258d594b2200024c60cbe1dc8b8d285c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_httptransfer from nonvisualobject
end type
end forward

global type pf_n_httptransfer from nonvisualobject
end type
global pf_n_httptransfer pf_n_httptransfer

type prototypes

end prototypes

type variables
constant integer TYPE_PARAM = 0
constant integer TYPE_FILE = 1
constant integer TYPE_PARAM_NONE_ESCAPE = 2

constant integer SIZE_UPLOAD = 0
constant integer SIZE_DOWNLOAD = 1

constant integer HTTP_OK = 0

// HTTP_GETINFO $$HEX9$$38cc70c8200000aca5b25cd520006dd5a9ba$$ENDHEX$$
constant int HTTPINFO_RESPONSE_CODE = 100
constant int HTTPINFO_HTTP_CONNECTCODE = 101
constant int HTTPINFO_FILETIME = 102
constant int HTTPINFO_REDIRECT_COUNT = 103
constant int HTTPINFO_HEADER_SIZE = 104
constant int HTTPINFO_REQUEST_SIZE = 105
constant int HTTPINFO_SSL_VERIFYRESULT = 106
constant int HTTPINFO_HTTPAUTH_AVAIL = 107
constant int HTTPINFO_PROXYAUTH_AVAIL = 108
constant int HTTPINFO_OS_ERRNO = 109
constant int HTTPINFO_NUM_CONNECTS = 110
constant int HTTPINFO_PRIMARY_PORT = 111
constant int HTTPINFO_LOCAL_PORT = 112
constant int HTTPINFO_LASTSOCKET = 113
constant int HTTPINFO_CONDITION_UNMET = 114
constant int HTTPINFO_RTSP_CLIENT_CSEQ = 115
constant int HTTPINFO_RTSP_SERVER_CSEQ = 116
constant int HTTPINFO_RTSP_CSEQ_RECV = 117

constant int HTTPINFO_TOTAL_TIME = 200
constant int HTTPINFO_NAMELOOKUP_TIME = 201
constant int HTTPINFO_CONNECT_TIME = 202
constant int HTTPINFO_APPCONNECT_TIME = 203
constant int HTTPINFO_PRETRANSFER_TIME = 204
constant int HTTPINFO_STARTTRANSFER_TIME = 205
constant int HTTPINFO_REDIRECT_TIME = 206
constant int HTTPINFO_SIZE_UPLOAD = 207
constant int HTTPINFO_SIZE_DOWNLOAD = 208
constant int HTTPINFO_SPEED_DOWNLOAD = 209
constant int HTTPINFO_SPEED_UPLOAD = 210
constant int HTTPINFO_CONTENT_LENGTH_DOWNLOAD = 211
constant int HTTPINFO_CONTENT_LENGTH_UPLOAD = 212

constant int HTTPINFO_EFFECTIVE_URL = 300
constant int HTTPINFO_REDIRECT_URL = 301
constant int HTTPINFO_CONTENT_TYPE = 302
constant int HTTPINFO_PRIVATE = 303
constant int HTTPINFO_PRIMARY_IP = 304
constant int HTTPINFO_LOCAL_IP = 305
constant int HTTPINFO_FTP_ENTRY_PATH = 306
constant int HTTPINFO_RTSP_SESSION_ID = 307

pf_w_httpupload iw_upload
pf_w_httpdownload iw_download

datastore ids_httpcode

public:
	string UPLOAD_URL = '' //as-is "http://localhost:9090/pfservices/FileUpload"
	string DOWNLOAD_URL= '' //as-is "http://localhost:9090/pfservices/FileDownload"
	boolean OVERWRITE_UPLOADEDFILE = true
	uint DEFAULT_TIMEOUT = 5

end variables

forward prototypes
public subroutine of_setuploadurl (string as_uploadurl)
public subroutine of_setdownloadurl (string as_downloadurl)
public subroutine of_setoverwriteuploadedfile (boolean ab_overwrite)
public function integer of_fileupload (ref string as_uploadfiles[], string as_uploadurl, string as_subdir, boolean ab_overwrite)
public function integer of_fileupload (ref string as_uploadfiles[], string as_uploadurl, string as_subdir)
public function integer of_fileupload (ref string as_uploadfiles[], string as_subdir)
public function integer of_fileupload (ref string as_uploadfiles[], string as_subdir, boolean ab_overwrite)
public function integer of_fileupload (ref string as_uploadfile, string as_subdir)
public function integer of_fileupload (ref string as_uploadfile, string as_subdir, boolean ab_overwrite)
public function integer of_fileupload (ref string as_uploadfile, string as_uploadurl, string as_subdir)
public function integer of_fileupload (ref string as_uploadfile, string as_uploadurl, string as_subdir, boolean ab_overwrite)
public function integer of_filedownload (string as_downloadfiles[], string as_downloadurl, string as_subdir, string as_downloadpath)
public function integer of_filedownload (string as_downloadfile, string as_subdir, ref string as_downloadpath)
public function boolean of_ping (string as_url, unsignedinteger aui_timeout)
public function boolean of_ping (string as_url)
public subroutine of_settimeout (unsignedinteger aui_timeout)
public function string of_getdescriptionofhttpcode (integer ai_httpcode)
public function string of_getmessageofhttpcode (integer ai_httpcode)
public function integer of_filedownload (string as_downloadfile, string as_subdir)
public function integer of_filedownload (string as_downloadfile, string as_downloadurl, string as_subdir, string as_downloadpath)
public function integer of_filedownload (string as_downloadfiles[], string as_subdir)
public function integer of_filedownload (string as_downloadfiles[], string as_subdir, string as_downloadpath)
public function integer of_sendmail (string as_server_url, string as_from_user_name, string as_from_addr, string as_to_addr, string as_subject, ref string as_content)
public function integer of_sendmail (string as_server_url, string as_from_user_name, string as_from_addr, string as_to_addr, string as_subject, ref string as_content, ref string as_uploadfiles[])
public function string of_urlencode (string as_text)
public function string of_ueldecode (string as_text)
end prototypes

public subroutine of_setuploadurl (string as_uploadurl);UPLOAD_URL = as_uploadurl

end subroutine

public subroutine of_setdownloadurl (string as_downloadurl);DOWNLOAD_URL = as_downloadurl

end subroutine

public subroutine of_setoverwriteuploadedfile (boolean ab_overwrite);OVERWRITE_UPLOADEDFILE = ab_overwrite

end subroutine

public function integer of_fileupload (ref string as_uploadfiles[], string as_uploadurl, string as_subdir, boolean ab_overwrite);string ls_filepath, ls_filename
string ls_error
integer li_rc, li_running

if isnull(as_uploadfiles) then return -1
if upperbound(as_uploadfiles) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(pf_n_httptransfer)', '$$HEX19$$c5c55cb8dcb460d520000cd37cc774c72000c0c915c818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.')
	return - 1
end if

// $$HEX10$$c5c55cb8dcb42000c1c0dcd03dcc200024c608d5$$ENDHEX$$
open(iw_upload)
iw_upload.cb_close.text = 'Cancel'
iw_upload.st_msg.text = '$$HEX9$$c5c55cb8dcb4200008cd30ae54d6200011c9$$ENDHEX$$...'

// $$HEX10$$c5c55cb8dcb460d520000cd37cc7200024c115c8$$ENDHEX$$
long ll_new, i
long ll_filesize
long ll_total_sum, ll_sent_sum

iw_upload.dw_filelist.reset()

for i = 1 to upperbound(as_uploadfiles)
	ll_filesize = gnv_extfunc.pf_getfilesize(as_uploadfiles[i])
	if ll_filesize = -1 then
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + as_uploadfiles[i] + '] $$HEX16$$0cd37cc7200015c8f4bc7cb920007dc744c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
		close(iw_upload)
		return -1
	end if

	ll_new = iw_upload.dw_filelist.insertrow(0)
	iw_upload.dw_filelist.setitem(ll_new, 'filepath', as_uploadfiles[i])
	iw_upload.dw_filelist.setitem(ll_new, 'filename', gnv_extfunc.of_pathstrippath(as_uploadfiles[i]))
	iw_upload.dw_filelist.setitem(ll_new, 'filesize', ll_filesize)
next

ll_total_sum = iw_upload.dw_filelist.getitemnumber(1, 'compute_1')
iw_upload.st_bytestotal_sum.text = string(ll_total_sum, '#,##0')

// $$HEX7$$c5c55cb8dcb4200008cd30ae54d6$$ENDHEX$$
double ld_ultotal, ld_ulnow
double ld_ultotal_bef, ld_ulnow_bef
integer li_percent, li_percent_bef
string ls_resptext, ls_uploadedfile
string ls_httpmesg
long ll_httpcode

// HTTP $$HEX6$$a8bac8b4200008cd30ae54d6$$ENDHEX$$
gnv_extfunc.pf_http_globalinit()
iw_upload.st_msg.text = '$$HEX8$$0cd37cc72000c5c55cb8dcb4200011c9$$ENDHEX$$...'

// HTTP header $$HEX2$$24c115c8$$ENDHEX$$
//gnv_extfunc.pf_http_addhttpheader("User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.0.3705) ")
//gnv_extfunc.pf_http_addhttpheader("Content-Type: multipart/form-data; charset=euc-kr")
//gnv_extfunc.pf_http_addhttpheader("Content-Type: application/x-www-form-urlencoded")

for i = 1 to upperbound(as_uploadfiles)
	iw_upload.dw_filelist.scrolltorow(i)
	iw_upload.dw_filelist.setrow(i)
	
	yield()
	
	ls_filepath = iw_upload.dw_filelist.getitemstring(i, 'filepath')
	ls_filename = iw_upload.dw_filelist.getitemstring(i, 'filename')
	ll_filesize = iw_upload.dw_filelist.getitemnumber(i, 'filesize')
	
	gnv_extfunc.pf_http_addformfield(TYPE_PARAM, "filename", ls_filename)
	gnv_extfunc.pf_http_addformfield(TYPE_PARAM, "subdir", as_subdir)
	if ab_overwrite = true then
		gnv_extfunc.pf_http_addformfield(TYPE_PARAM, "overwrite", "true")
	else
		gnv_extfunc.pf_http_addformfield(TYPE_PARAM, "overwrite", "false")
	end if
	gnv_extfunc.pf_http_addformfield(TYPE_FILE, "file1", ls_filepath)
	
	// initialize http
	if gnv_extfunc.pf_http_openupload(as_uploadurl, ls_filepath) = -1 then
		close(iw_upload)
		return -1
	end if
	
	li_running = gnv_extfunc.pf_http_send()
	do while li_running = 1
		ld_ultotal = gnv_extfunc.pf_http_uploadprogress_total()
		ld_ulnow = gnv_extfunc.pf_http_uploadprogress_now()
		
		if ld_ultotal <> ld_ultotal_bef then
			iw_upload.st_bytestotal.text = string(ld_ultotal, '#,##0')
			ld_ultotal_bef = ld_ultotal
		end if
		
		if ld_ulnow <> ld_ulnow_bef then
			iw_upload.st_bytessent.text = string(ld_ulnow, '#,##0')
			iw_upload.st_bytessent_sum.text = string(ll_sent_sum + ld_ulnow, '#,##0')
			ld_ulnow_bef = ld_ulnow
		end if
		
		if ld_ulnow > 0 then
			li_percent = int((ld_ulnow / ld_ultotal) * 100)
			if li_percent <> li_percent_bef then
				iw_upload.hpb_file.position = li_percent
				iw_upload.hpb_total.position = int((ll_sent_sum + ld_ulnow) / ll_total_sum * 100)
				li_percent_bef = li_percent
			end if
		end if
		
		// Cancelling...
		if iw_upload.ib_cancel = true then
			gnv_extfunc.pf_http_abort()
			exit
		end if

		yield()
		li_running = gnv_extfunc.pf_http_checkrunningstatus()
	loop
	
	// check result code
	li_rc = gnv_extfunc.pf_http_getresultcode()
	if li_rc <> HTTP_OK then
		ls_error = gnv_extfunc.pf_http_geterrormessage(li_rc)
		gnv_extfunc.pf_http_close()
		gnv_extfunc.pf_http_globalcleanup()
		messagebox('HTTP $$HEX2$$4cc5bcb9$$ENDHEX$$(' + string(li_rc) + ')', ls_error)
		close(iw_upload)
		return -1
	end if
	
	// check http code
	ll_httpcode = gnv_extfunc.pf_http_getinfo_long(HTTPINFO_RESPONSE_CODE)
	if ll_httpcode >= 300 then
		ls_httpmesg = '$$HEX26$$0cd37cc72000c5c55cb8dcb4200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$~r~n~r~nHttp Code: ' + string(ll_httpcode) + '~r~nHttp Message: ' + &
		this.of_getmessageofhttpcode(ll_httpcode) + '~r~nHttp Description: ' + this.of_getdescriptionofhttpcode(ll_httpcode)
		gnv_extfunc.pf_http_close()
		gnv_extfunc.pf_http_globalcleanup()
		messagebox('$$HEX9$$0cd37cc72000c5c55cb8dcb4200024c658b9$$ENDHEX$$', ls_httpmesg)
		close(iw_upload)
		return -1
	end if
	
	// get response
	ls_resptext = gnv_extfunc.pf_http_getresponsefromupload()
	if left(ls_resptext, 9) = 'uploaded:' then
		ls_uploadedfile = mid(ls_resptext, 10)
		if ls_uploadedfile <> as_uploadfiles[i] then
			as_uploadfiles[i] = ls_uploadedfile
		end if
	end if
	
	gnv_extfunc.pf_http_close()
	
	// Check if cancel button was clicked
	if iw_upload.ib_cancel = true then
		exit
	end if
	
	ll_sent_sum += ll_filesize
	gnv_extfunc.sleep(10)
next

// HTTP $$HEX6$$a8bac8b4200074d0b0b9c5c5$$ENDHEX$$
gnv_extfunc.pf_http_globalcleanup()
iw_upload.cb_close.text = 'Close'

if iw_upload.ib_cancel = true then
	iw_upload.st_msg.text = '$$HEX8$$0cd37cc7200004c8a1c12000e8cd8cc1$$ENDHEX$$!!'
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX14$$0cd37cc7200004c8a1c174c72000e8cd8cc118b4c8c5b5c2c8b2e4b2$$ENDHEX$$.')
else
	iw_upload.st_msg.text = '$$HEX9$$0cd37cc72000c5c55cb8dcb4200044c6ccb8$$ENDHEX$$!!'
	//messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX14$$0cd37cc7200004c8a1c174c7200044c6ccb818b4c8c5b5c2c8b2e4b2$$ENDHEX$$.')
end if

close(iw_upload)
return li_rc

end function

public function integer of_fileupload (ref string as_uploadfiles[], string as_uploadurl, string as_subdir);return this.of_fileupload(as_uploadfiles, as_uploadurl, as_subdir, OVERWRITE_UPLOADEDFILE)

end function

public function integer of_fileupload (ref string as_uploadfiles[], string as_subdir);if isnull(UPLOAD_URL) then return -1
if len(trim(UPLOAD_URL)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'FILE UPLOAD$$HEX5$$a9c620001cc114bebfb9$$ENDHEX$$URL $$HEX12$$74c7200024c115c818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$')
	return -1
end if

return this.of_fileupload(as_uploadfiles, UPLOAD_URL, as_subdir, OVERWRITE_UPLOADEDFILE)

end function

public function integer of_fileupload (ref string as_uploadfiles[], string as_subdir, boolean ab_overwrite);if isnull(UPLOAD_URL) then return -1
if len(trim(UPLOAD_URL)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'FILE UPLOAD$$HEX5$$a9c620001cc114bebfb9$$ENDHEX$$URL $$HEX12$$74c7200024c115c818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$')
	return -1
end if

return this.of_fileupload(as_uploadfiles, UPLOAD_URL, as_subdir, ab_overwrite)

end function

public function integer of_fileupload (ref string as_uploadfile, string as_subdir);string ls_uploadfiles[]
integer li_rc

if isnull(UPLOAD_URL) then return -1
if len(trim(UPLOAD_URL)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'FILE UPLOAD$$HEX5$$a9c620001cc114bebfb9$$ENDHEX$$URL $$HEX12$$74c7200024c115c818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$')
	return -1
end if

ls_uploadfiles[1] = as_uploadfile
li_rc = this.of_fileupload(ls_uploadfiles, UPLOAD_URL, as_subdir, OVERWRITE_UPLOADEDFILE)
as_uploadfile = ls_uploadfiles[1]

return li_rc

end function

public function integer of_fileupload (ref string as_uploadfile, string as_subdir, boolean ab_overwrite);string ls_uploadfiles[]
integer li_rc

if isnull(UPLOAD_URL) then return -1
if len(trim(UPLOAD_URL)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'FILE UPLOAD$$HEX5$$a9c620001cc114bebfb9$$ENDHEX$$URL $$HEX12$$74c7200024c115c818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$')
	return -1
end if

ls_uploadfiles[1] = as_uploadfile
li_rc =  this.of_fileupload(ls_uploadfiles, UPLOAD_URL, as_subdir, ab_overwrite)
as_uploadfile = ls_uploadfiles[1]

return li_rc

end function

public function integer of_fileupload (ref string as_uploadfile, string as_uploadurl, string as_subdir);string ls_uploadfiles[]
integer li_rc

ls_uploadfiles[1] = as_uploadfile
li_rc =  this.of_fileupload(ls_uploadfiles, as_uploadurl, as_subdir, OVERWRITE_UPLOADEDFILE)
as_uploadfile = ls_uploadfiles[1]

return li_rc

end function

public function integer of_fileupload (ref string as_uploadfile, string as_uploadurl, string as_subdir, boolean ab_overwrite);string ls_uploadfiles[]
integer li_rc

ls_uploadfiles[1] = as_uploadfile
li_rc = this.of_fileupload(ls_uploadfiles, as_uploadurl, as_subdir, ab_overwrite)
as_uploadfile = ls_uploadfiles[1]

return li_rc

end function

public function integer of_filedownload (string as_downloadfiles[], string as_downloadurl, string as_subdir, string as_downloadpath);string ls_filepath
string ls_error
integer li_rc, li_running
integer i, li_filecnt

// $$HEX6$$e4b2b4c65cb8dcb460d52000$$ENDHEX$$($$HEX2$$1cc184bc$$ENDHEX$$)$$HEX6$$0cd37cc785ba200055d678c7$$ENDHEX$$
if isnull(as_downloadfiles) then return -1

li_filecnt = upperbound(as_downloadfiles)
if li_filecnt = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX20$$e4b2b4c65cb8dcb460d520000cd37cc774c72000c0c915c818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.')
	return - 1
end if

for i = 1 to li_filecnt
	if isnull(as_downloadfiles[i]) or len(trim(as_downloadfiles[i])) = 0 then
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX20$$e4b2b4c65cb8dcb460d520000cd37cc774c72000c0c915c818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.')
		return - 1
	end if
next

// $$HEX5$$e4b2b4c65cb8dcb42000$$ENDHEX$$URL $$HEX2$$55d678c7$$ENDHEX$$
if isnull(as_downloadurl) then return -1
if len(trim(as_downloadurl)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX5$$e4b2b4c65cb8dcb42000$$ENDHEX$$URL$$HEX12$$74c7200024c115c818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.')
	return - 1
end if

// $$HEX5$$e4b2b4c65cb8dcb42000$$ENDHEX$$SUBDIR $$HEX2$$55d678c7$$ENDHEX$$
if isnull(as_subdir) then return -1
if len(trim(as_subdir)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX5$$e4b2b4c65cb8dcb42000$$ENDHEX$$SUBDIR($$HEX2$$1cc184bc$$ENDHEX$$_$$HEX4$$58d504c7bdac5cb8$$ENDHEX$$)$$HEX12$$74c7200024c115c818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.')
	return - 1
end if

// DownloadPath $$HEX19$$00ac2000f8bb24c115c81cb42000bdacb0c62000acc0a9c690c7200024c115c8200098ccacb9$$ENDHEX$$
if isnull(as_downloadpath) or len(trim(as_downloadpath)) = 0 then
	if getfolder("$$HEX19$$a8cc80bd0cd37cc744c7200000c8a5c760d52000f4d354b37cb9200020c1ddd058d538c194c6$$ENDHEX$$", as_downloadpath) < 1 then return 0
end if

// $$HEX11$$e4b2b4c65cb8dcb42000c1c0dcd03dcc200024c608d5$$ENDHEX$$
open(iw_download)
iw_download.cb_close.text = 'Cancel'
iw_download.st_msg.text = '$$HEX10$$e4b2b4c65cb8dcb4200008cd30ae54d6200011c9$$ENDHEX$$...'

// $$HEX8$$e4b2b4c65cb8dcb4200008cd30ae54d6$$ENDHEX$$
double ld_dltotal, ld_dlnow
double ld_dltotal_bef, ld_dlnow_bef
double ld_bytespersec
long ll_total_sum, ll_recv_sum
integer li_percent, li_percent_bef

iw_download.st_msg.text = '$$HEX9$$0cd37cc72000e4b2b4c65cb8dcb4200011c9$$ENDHEX$$...'

long ll_new, ll_lastpos
long ll_filesize
string ls_extension
string ls_fileext

// $$HEX9$$e4b2b4c65cb8dcb460d520000cd37cc72000$$ENDHEX$$DW $$HEX2$$5cd4dcc2$$ENDHEX$$
iw_download.dw_filelist.reset()
for i = 1 to li_filecnt
	
	// $$HEX11$$0cd37cc785ba20007cc728b888bc38d620001cc870ac$$ENDHEX$$
	ls_filepath = as_downloadfiles[i]
	ll_lastpos = lastpos(ls_filepath, '.')
	if ll_lastpos > 0 then
		ls_fileext = mid(ls_filepath, ll_lastpos + 1)
		if isnumber(ls_fileext) then
			ls_filepath = mid(ls_filepath, 1, ll_lastpos - 1)
		end if
	end if
	
	// $$HEX12$$30ae200074c8acc758d594b220000cd37cc7200055d678c7$$ENDHEX$$
	if fileexists(as_downloadpath + '\' + ls_filepath) then
		li_rc = messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + as_downloadpath + '\' + ls_filepath + ']~r~n$$HEX20$$e4b2b4c65cb8dcb420001bbc44c720000cd37cc774c7200074c7f8bb200074c8acc769d5c8b2e4b2$$ENDHEX$$.~r~n$$HEX18$$74d5f9b220000cd37cc744c720006eb3b4c5f0c430ae200058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNoCancel!, 2)
		choose case li_rc
			case 2
				continue
			case 3
				close(iw_download)
				return -1
		end choose
	end if
	
	ll_new = iw_download.dw_filelist.insertrow(0)
	iw_download.dw_filelist.setitem(ll_new, 'filepath', as_downloadpath + '\' + ls_filepath)
	iw_download.dw_filelist.setitem(ll_new, 'filename', ls_filepath)
	iw_download.dw_filelist.setitem(ll_new, 'filesize', 0)
next

//for i = 1 to upperbound(as_downloadfiles)
//	iw_download.dw_filelist.scrolltorow(i)
//	iw_download.dw_filelist.setrow(i)
//	
//	ls_filepath = as_downloadpath + '\' + iw_download.dw_filelist.getitemstring(i, 'ls_filename') //as_downloadfiles[i]
//	ls_filename = as_downloadfiles[i]
//	
//	if gnv_extfunc.pf_http_opendownload(as_downloadurl, ls_filepath) = -1 then
//		return -1
//	end if

// HTTP $$HEX6$$a8bac8b4200008cd30ae54d6$$ENDHEX$$
gnv_extfunc.pf_http_globalinit()

// $$HEX7$$0cd37cc72000e4b2b4c65cb8dcb4$$ENDHEX$$
for i = 1 to li_filecnt
	iw_download.dw_filelist.scrolltorow(i)
	iw_download.dw_filelist.setrow(i)
	
	ls_filepath = iw_download.dw_filelist.getitemstring(i, 'filepath')
	
	// $$HEX5$$e4b2b4c65cb8dcb42000$$ENDHEX$$URL $$HEX12$$0fbc20005cb8ecce20000cd37cc7bdac5cb8200024c115c8$$ENDHEX$$
	if gnv_extfunc.pf_http_opendownload(as_downloadurl, ls_filepath) = -1 then
		gnv_extfunc.pf_http_globalcleanup()
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'pf_http_opendownload() $$HEX9$$38d69ccd200024c658b9200085c7c8b2e4b2$$ENDHEX$$~r~nas_downloadurl=' + string(as_downloadurl) + ', as_downloadpath=' + string(ls_filepath))
		return -1
	end if
	
	// $$HEX17$$18c2e0c220000cd37cc785ba20000fbc20001cc10cbe2000bdac5cb8200024c115c8$$ENDHEX$$
	//gnv_extfunc.pf_http_setpostfields("filename=" + as_downloadfiles[i] + "&subdir=" + as_subdir)
	gnv_extfunc.pf_http_setpostfields("filename=" + this.of_urlencode(as_downloadfiles[i]) + "&subdir=" + this.of_urlencode(as_subdir))
	if gnv_extfunc.pf_http_send() <> 1 then
		gnv_extfunc.pf_http_globalcleanup()
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'pf_http_send() $$HEX9$$38d69ccd200024c658b9200085c7c8b2e4b2$$ENDHEX$$')
		return -1
	end if
	
	// $$HEX7$$c4c989d5c1c0dcd0200010c880ac$$ENDHEX$$
	li_running = gnv_extfunc.pf_http_checkrunningstatus()
	do while li_running = 1
		yield()
		
		ld_dlnow = gnv_extfunc.pf_http_downloadprogress_now()
		ld_dltotal = gnv_extfunc.pf_http_downloadprogress_total()
		
		if ld_dltotal <> ld_dltotal_bef then
			iw_download.st_bytestotal.text = string(ld_dltotal, '#,##0')
			iw_download.st_bytestotal_sum.text = string(ll_recv_sum + ld_dltotal, '#,##0')
			ld_dltotal_bef = ld_dltotal
		end if	
		
		if ld_dlnow <> ld_dlnow_bef then
			iw_download.st_bytesrecv.text = string(ld_dlnow, '#,##0')
			iw_download.st_bytesrecv_sum.text = string(ll_recv_sum + ld_dlnow, '#,##0')
			ld_dlnow_bef = ld_dlnow
		end if
		
		if ld_dlnow > 0 then
			li_percent = int((ld_dlnow / ld_dltotal) * 100)
			if li_percent <> li_percent_bef then
				iw_download.hpb_file.position = li_percent
				li_percent_bef = li_percent
			end if
		end if
		
		// $$HEX10$$e4b2b4c65cb8dcb42000e8cd8cc1200055d678c7$$ENDHEX$$
		if iw_download.ib_cancel = true then
			gnv_extfunc.pf_http_abort()
			gnv_extfunc.pf_http_globalcleanup()
			exit
		end if
		
		li_running = gnv_extfunc.pf_http_checkrunningstatus()
	loop
	
	// $$HEX7$$b0acfcac54cfdcb4200098ccacb9$$ENDHEX$$
	li_rc = gnv_extfunc.pf_http_getresultcode()
	if li_rc <> HTTP_OK then
		ls_error = gnv_extfunc.pf_http_geterrormessage(li_rc)
		gnv_extfunc.pf_http_close()
		gnv_extfunc.pf_http_globalcleanup()
		messagebox('HTTP $$HEX2$$4cc5bcb9$$ENDHEX$$(' + string(li_rc) + ')', ls_error)
		close(iw_download)
		return -1
	end if
	
	// $$HEX11$$c8b9c0c9c9b92000c4c989d5c1c069d6200098ccacb9$$ENDHEX$$
	ld_dlnow = gnv_extfunc.pf_http_downloadprogress_now()
	if ld_dltotal > 0 then li_percent = int((ld_dlnow / ld_dltotal) * 100)
	iw_download.st_bytesrecv.text = string(ld_dlnow, '#,##0')
	iw_download.st_bytesrecv_sum.text = string(ll_recv_sum + ld_dlnow, '#,##0')
	iw_download.hpb_file.position = li_percent
	iw_download.hpb_total.position = li_percent
	ll_recv_sum += ld_dltotal
	
	// $$HEX10$$e4b2b4c65cb8dcb4200004c8a1c120008dc1c4b3$$ENDHEX$$
	//ld_bytespersec = gnv_extfunc.pf_http_getinfo_double(HTTPINFO_SPEED_DOWNLOAD)
	//iw_download.st_msg.text = string(ld_bytespersec / 1000, '#,##0') + ' Kbytes/sec'
	
	// HTTP Code $$HEX2$$55d678c7$$ENDHEX$$
	long ll_httpcode
	string ls_httpmesg
	ll_httpcode = gnv_extfunc.pf_http_getinfo_long(HTTPINFO_RESPONSE_CODE)
	if ll_httpcode >= 300 then
		ls_httpmesg = '$$HEX27$$0cd37cc72000e4b2b4c65cb8dcb4200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$~r~n~r~nHttp Code: ' + string(ll_httpcode) + '~r~nHttp Message: ' + &
		this.of_getmessageofhttpcode(ll_httpcode) + '~r~nHttp Description: ' + this.of_getdescriptionofhttpcode(ll_httpcode)
		gnv_extfunc.pf_http_close()
		gnv_extfunc.pf_http_globalcleanup()
		messagebox('$$HEX10$$0cd37cc72000e4b2b4c65cb8dcb4200024c658b9$$ENDHEX$$', ls_httpmesg)
		close(iw_download)
		return -1
	end if

	// HTTP $$HEX5$$04c8a1c1200085c8ccb8$$ENDHEX$$
	gnv_extfunc.pf_http_close()
	
	// $$HEX6$$24c608d504c8200000b330ae$$ENDHEX$$
	gnv_extfunc.sleep(10)
next

iw_download.cb_close.text = 'Close'
gnv_extfunc.pf_http_globalcleanup()

// $$HEX9$$b0acfcac200054badcc2c0c920005cd4dcc2$$ENDHEX$$
if len(ls_httpmesg) > 0 then
	li_rc = -1
	iw_download.st_msg.text = '$$HEX8$$0cd37cc7200004c8a1c1200024c658b9$$ENDHEX$$!'
elseif iw_download.ib_cancel = true then
	li_rc = -1
	iw_download.st_msg.text = '$$HEX11$$04c8a1c174c72000e8cd8cc118b4c8c5b5c2c8b2e4b2$$ENDHEX$$!'
else
	iw_download.st_msg.text = '$$HEX10$$0cd37cc72000e4b2b4c65cb8dcb4200044c6ccb8$$ENDHEX$$!'
end if

close(iw_download)
return li_rc


end function

public function integer of_filedownload (string as_downloadfile, string as_subdir, ref string as_downloadpath);integer li_rc

li_rc =  this.of_filedownload(as_downloadfile, DOWNLOAD_URL, as_subdir, as_downloadpath)
return li_rc

end function

public function boolean of_ping (string as_url, unsignedinteger aui_timeout);// as_url $$HEX12$$74c7200020c7a8d65cd5c0c9200080acacc069d5c8b2e4b2$$ENDHEX$$
// as_url : $$HEX5$$4cd1a4c2b8d260d52000$$ENDHEX$$URL $$HEX2$$fcc88cc1$$ENDHEX$$
// aui_timeout : $$HEX8$$4cd1a4c2b8d22000c0d084c744c5c3c6$$ENDHEX$$($$HEX1$$08cd$$ENDHEX$$)

boolean lb_rv

if isnull(as_url) or len(trim(as_url)) = 0 then
	messagebox('of_ping $$HEX2$$4cc5bcb9$$ENDHEX$$', 'URL $$HEX8$$15c8f4bc00ac2000c6c5b5c2c8b2e4b2$$ENDHEX$$')
	return false
end if

// Time Out $$HEX17$$08cd00ac200024c115c818b4c0c920004ac540c72000bdacb0c6200030aef8bc2000$$ENDHEX$$5$$HEX4$$08cd200024c115c8$$ENDHEX$$
if aui_timeout <= 0  then
	aui_timeout = DEFAULT_TIMEOUT
end if

lb_rv = gnv_extfunc.pf_http_ping(as_url, aui_timeout)
return lb_rv

end function

public function boolean of_ping (string as_url);// as_url $$HEX12$$74c7200020c7a8d65cd5c0c9200080acacc069d5c8b2e4b2$$ENDHEX$$
// as_url : $$HEX5$$4cd1a4c2b8d260d52000$$ENDHEX$$URL $$HEX2$$fcc88cc1$$ENDHEX$$

uint lui_timeout

lui_timeout = DEFAULT_TIMEOUT
return this.of_ping(as_url, lui_timeout)

end function

public subroutine of_settimeout (unsignedinteger aui_timeout);DEFAULT_TIMEOUT = aui_timeout

end subroutine

public function string of_getdescriptionofhttpcode (integer ai_httpcode);// HTTPCODE$$HEX23$$d0c5200074d5f9b258d594b22000c1c038c12000d0c5ecb7200054badcc2c0c97cb92000acb934d169d5c8b2e4b2$$ENDHEX$$.

long ll_find
string ls_errmsg

ll_find = ids_httpcode.find("httpcode='" + string(ai_httpcode) + "'", 1, ids_httpcode.rowcount())
if ll_find > 0 then
	ls_errmsg = ids_httpcode.getitemstring(ll_find, 'httpcode_desc')
end if

return ls_errmsg

end function

public function string of_getmessageofhttpcode (integer ai_httpcode);// HTTPCODE$$HEX20$$d0c5200074d5f9b258d594b22000d0c5ecb7200054badcc2c0c97cb92000acb934d169d5c8b2e4b2$$ENDHEX$$.

long ll_find
string ls_errmsg

ll_find = ids_httpcode.find("httpcode='" + string(ai_httpcode) + "'", 1, ids_httpcode.rowcount())
if ll_find > 0 then
	ls_errmsg = ids_httpcode.getitemstring(ll_find, 'httpcode_mesg')
end if

return ls_errmsg

end function

public function integer of_filedownload (string as_downloadfile, string as_subdir);integer li_rc
string ls_downloadpath

li_rc =  this.of_filedownload(as_downloadfile, DOWNLOAD_URL, as_subdir, ls_downloadpath)
return li_rc

end function

public function integer of_filedownload (string as_downloadfile, string as_downloadurl, string as_subdir, string as_downloadpath);string ls_filepath, ls_filename
string ls_error
integer li_rc, li_running

// $$HEX6$$e4b2b4c65cb8dcb460d52000$$ENDHEX$$($$HEX2$$1cc184bc$$ENDHEX$$)$$HEX6$$0cd37cc785ba200055d678c7$$ENDHEX$$
if isnull(as_downloadfile) then return -1
if len(trim(as_downloadfile)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX20$$e4b2b4c65cb8dcb460d520000cd37cc774c72000c0c915c818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.')
	return - 1
end if

// $$HEX5$$e4b2b4c65cb8dcb42000$$ENDHEX$$URL $$HEX2$$55d678c7$$ENDHEX$$
if isnull(as_downloadurl) then return -1
if len(trim(as_downloadurl)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX5$$e4b2b4c65cb8dcb42000$$ENDHEX$$URL$$HEX12$$74c7200024c115c818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.')
	return - 1
end if

// $$HEX5$$e4b2b4c65cb8dcb42000$$ENDHEX$$SUBDIR $$HEX2$$55d678c7$$ENDHEX$$
if isnull(as_subdir) then return -1
if len(trim(as_subdir)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX5$$e4b2b4c65cb8dcb42000$$ENDHEX$$SUBDIR($$HEX2$$1cc184bc$$ENDHEX$$_$$HEX4$$58d504c7bdac5cb8$$ENDHEX$$)$$HEX12$$74c7200024c115c818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.')
	return - 1
end if

// DownloadPath $$HEX19$$00ac2000f8bb24c115c81cb42000bdacb0c62000acc0a9c690c7200024c115c8200098ccacb9$$ENDHEX$$
long ll_lastpos
string ls_fileext

ls_filepath = as_downloadfile
ll_lastpos = lastpos(ls_filepath, '.')
if ll_lastpos > 0 then
	ls_fileext = mid(ls_filepath, ll_lastpos + 1)
	if isnumber(ls_fileext) then
		ls_filepath = mid(ls_filepath, 1, ll_lastpos - 1)
	end if
end if

if isnull(as_downloadpath) or len(trim(as_downloadpath)) = 0 then
	ls_filename = ls_filepath
	if getfilesavename("$$HEX19$$a8cc80bd0cd37cc744c7200000c8a5c760d5200004c758ce7cb9200024c115c858d538c194c6$$ENDHEX$$", ls_filepath, ls_filename) <= 0 then return 0
	as_downloadpath = ls_filepath
end if

// $$HEX11$$e4b2b4c65cb8dcb42000c1c0dcd03dcc200024c608d5$$ENDHEX$$
open(iw_download)
iw_download.cb_close.text = 'Cancel'
iw_download.st_msg.text = '$$HEX10$$e4b2b4c65cb8dcb4200008cd30ae54d6200011c9$$ENDHEX$$...'

// $$HEX8$$e4b2b4c65cb8dcb4200008cd30ae54d6$$ENDHEX$$
double ld_dltotal, ld_dlnow
double ld_dltotal_bef, ld_dlnow_bef
double ld_bytespersec
long ll_total_sum, ll_recv_sum
integer li_percent, li_percent_bef
long ll_filecnt, i

iw_download.st_msg.text = '$$HEX9$$0cd37cc72000e4b2b4c65cb8dcb4200011c9$$ENDHEX$$...'

long ll_new
long ll_filesize
string ls_extension

// $$HEX12$$30ae200074c8acc758d594b220000cd37cc7200055d678c7$$ENDHEX$$
if fileexists(as_downloadpath) then
	if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + as_downloadpath + ']~r~n$$HEX20$$e4b2b4c65cb8dcb420001bbc44c720000cd37cc774c7200074c7f8bb200074c8acc769d5c8b2e4b2$$ENDHEX$$.~r~n$$HEX18$$74d5f9b220000cd37cc744c720006eb3b4c5f0c430ae200058d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 2 then
		close(iw_download)
		return -1
	end if
end if

// $$HEX9$$e4b2b4c65cb8dcb460d520000cd37cc72000$$ENDHEX$$DW $$HEX2$$5cd4dcc2$$ENDHEX$$
iw_download.dw_filelist.reset()
ll_new = iw_download.dw_filelist.insertrow(0)
iw_download.dw_filelist.setitem(ll_new, 'filepath', as_downloadpath)
iw_download.dw_filelist.setitem(ll_new, 'filename', gnv_extfunc.of_pathstrippath(as_downloadpath))
iw_download.dw_filelist.setitem(ll_new, 'filesize', 0)
iw_download.dw_filelist.scrolltorow(ll_new)
iw_download.dw_filelist.setrow(ll_new)

// HTTP $$HEX6$$a8bac8b4200008cd30ae54d6$$ENDHEX$$
gnv_extfunc.pf_http_globalinit()

// HTTP header $$HEX2$$24c115c8$$ENDHEX$$
gnv_extfunc.pf_http_addhttpheader("User-Agent: Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.0.3705) ")
gnv_extfunc.pf_http_addhttpheader("Content-Type: application/x-www-form-urlencoded; charset=euc-kr")
//gnv_extfunc.pf_http_addhttpheader("Content-Type: multipart/form-data; charset=euc-kr")

// $$HEX5$$e4b2b4c65cb8dcb42000$$ENDHEX$$URL $$HEX12$$0fbc20005cb8ecce20000cd37cc7bdac5cb8200024c115c8$$ENDHEX$$
if gnv_extfunc.pf_http_opendownload(as_downloadurl, as_downloadpath) = -1 then
	gnv_extfunc.pf_http_globalcleanup()
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'pf_http_opendownload() $$HEX9$$38d69ccd200024c658b9200085c7c8b2e4b2$$ENDHEX$$~r~nas_downloadurl=' + string(as_downloadurl) + ', as_downloadpath=' + string(as_downloadpath))
	return -1
end if

// $$HEX17$$18c2e0c220000cd37cc785ba20000fbc20001cc10cbe2000bdac5cb8200024c115c8$$ENDHEX$$
as_downloadfile = this.of_urlencode(as_downloadfile)
//gnv_extfunc.pf_http_setpostfields("filename=" + as_downloadfile + "&subdir=" + as_subdir)
gnv_extfunc.pf_http_setpostfields("filename=" + this.of_urlencode(as_downloadfile) + "&subdir=" + this.of_urlencode(as_subdir))

if gnv_extfunc.pf_http_send() <> 1 then
	gnv_extfunc.pf_http_globalcleanup()
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'pf_http_send() $$HEX9$$38d69ccd200024c658b9200085c7c8b2e4b2$$ENDHEX$$')
	return -1
end if

// $$HEX7$$c4c989d5c1c0dcd0200010c880ac$$ENDHEX$$
li_running = gnv_extfunc.pf_http_checkrunningstatus()
do while li_running = 1
	yield()
	
	ld_dlnow = gnv_extfunc.pf_http_downloadprogress_now()
	ld_dltotal = gnv_extfunc.pf_http_downloadprogress_total()
	
	if ld_dltotal <> ld_dltotal_bef then
		iw_download.st_bytestotal.text = string(ld_dltotal, '#,##0')
		iw_download.st_bytestotal_sum.text = string(ll_recv_sum + ld_dltotal, '#,##0')
		ld_dltotal_bef = ld_dltotal
	end if	
	
	if ld_dlnow <> ld_dlnow_bef then
		iw_download.st_bytesrecv.text = string(ld_dlnow, '#,##0')
		iw_download.st_bytesrecv_sum.text = string(ll_recv_sum + ld_dlnow, '#,##0')
		ld_dlnow_bef = ld_dlnow
	end if
	
	if ld_dlnow > 0 then
		li_percent = int((ld_dlnow / ld_dltotal) * 100)
		if li_percent <> li_percent_bef then
			iw_download.hpb_file.position = li_percent
			li_percent_bef = li_percent
		end if
	end if
	
	// $$HEX10$$e4b2b4c65cb8dcb42000e8cd8cc1200055d678c7$$ENDHEX$$
	if iw_download.ib_cancel = true then
		gnv_extfunc.pf_http_abort()
		exit
	end if
	
	li_running = gnv_extfunc.pf_http_checkrunningstatus()
loop

// $$HEX7$$b0acfcac54cfdcb4200098ccacb9$$ENDHEX$$
li_rc = gnv_extfunc.pf_http_getresultcode()
if li_rc <> HTTP_OK then
	ls_error = gnv_extfunc.pf_http_geterrormessage(li_rc)
	gnv_extfunc.pf_http_close()
	gnv_extfunc.pf_http_globalcleanup()
	messagebox('HTTP $$HEX2$$4cc5bcb9$$ENDHEX$$(' + string(li_rc) + ')', ls_error)
	close(iw_download)
	return -1
end if

// $$HEX11$$c8b9c0c9c9b92000c4c989d5c1c069d6200098ccacb9$$ENDHEX$$
ld_dlnow = gnv_extfunc.pf_http_downloadprogress_now()
if ld_dltotal > 0 then li_percent = int((ld_dlnow / ld_dltotal) * 100)
iw_download.st_bytesrecv.text = string(ld_dlnow, '#,##0')
iw_download.st_bytesrecv_sum.text = string(ll_recv_sum + ld_dlnow, '#,##0')
iw_download.hpb_file.position = li_percent
iw_download.hpb_total.position = li_percent
ll_recv_sum += ld_dltotal

// $$HEX10$$e4b2b4c65cb8dcb4200004c8a1c120008dc1c4b3$$ENDHEX$$
//ld_bytespersec = gnv_extfunc.pf_http_getinfo_double(HTTPINFO_SPEED_DOWNLOAD)
//iw_download.st_msg.text = string(ld_bytespersec / 1000, '#,##0') + ' Kbytes/sec'

// HTTP Code $$HEX2$$55d678c7$$ENDHEX$$
long ll_httpcode
string ls_httpmesg
ll_httpcode = gnv_extfunc.pf_http_getinfo_long(HTTPINFO_RESPONSE_CODE)
if ll_httpcode >= 300 then
	ls_httpmesg = '$$HEX27$$0cd37cc72000e4b2b4c65cb8dcb4200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$~r~n~r~nHttp Code: ' + string(ll_httpcode) + '~r~nHttp Message: ' + &
	this.of_getmessageofhttpcode(ll_httpcode) + '~r~nHttp Description: ' + this.of_getdescriptionofhttpcode(ll_httpcode)
	gnv_extfunc.pf_http_close()	
	gnv_extfunc.pf_http_globalcleanup()
	messagebox('$$HEX10$$0cd37cc72000e4b2b4c65cb8dcb4200024c658b9$$ENDHEX$$', ls_httpmesg)
	close(iw_download)
	return -1
end if

// HTTP $$HEX5$$04c8a1c1200085c8ccb8$$ENDHEX$$
gnv_extfunc.pf_http_close()
gnv_extfunc.pf_http_globalcleanup()
iw_download.cb_close.text = 'Close'

// $$HEX9$$b0acfcac200054badcc2c0c920005cd4dcc2$$ENDHEX$$
if len(ls_httpmesg) > 0 then
	li_rc = -1
	iw_download.st_msg.text = '$$HEX8$$0cd37cc7200004c8a1c1200024c658b9$$ENDHEX$$!'
elseif iw_download.ib_cancel = true then
	li_rc = -1
	iw_download.st_msg.text = '$$HEX11$$04c8a1c174c72000e8cd8cc118b4c8c5b5c2c8b2e4b2$$ENDHEX$$!'
else
	iw_download.st_msg.text = '$$HEX10$$0cd37cc72000e4b2b4c65cb8dcb4200044c6ccb8$$ENDHEX$$!'
end if

close(iw_download)
return li_rc

end function

public function integer of_filedownload (string as_downloadfiles[], string as_subdir);integer li_rc
string ls_downloadpath

li_rc =  this.of_filedownload(as_downloadfiles, DOWNLOAD_URL, as_subdir, ls_downloadpath)
return li_rc

end function

public function integer of_filedownload (string as_downloadfiles[], string as_subdir, string as_downloadpath);integer li_rc

li_rc =  this.of_filedownload(as_downloadfiles, DOWNLOAD_URL, as_subdir, as_downloadpath)
return li_rc

end function

public function integer of_sendmail (string as_server_url, string as_from_user_name, string as_from_addr, string as_to_addr, string as_subject, ref string as_content);String		ls_DummyFiles[]

return This.of_sendmail( as_server_url, as_from_user_name, as_from_addr, as_to_addr, as_subject, as_content, ls_DummyFiles )
end function

public function integer of_sendmail (string as_server_url, string as_from_user_name, string as_from_addr, string as_to_addr, string as_subject, ref string as_content, ref string as_uploadfiles[]);
//string ls_filepath, ls_filename
string ls_error
integer li_rc, li_running

// $$HEX7$$c5c55cb8dcb4200008cd30ae54d6$$ENDHEX$$
double ld_ultotal, ld_ulnow
double ld_ultotal_bef, ld_ulnow_bef
integer li_percent, li_percent_bef
string ls_resptext, ls_uploadedfile
string ls_httpmesg
long ll_httpcode

// HTTP $$HEX6$$a8bac8b4200008cd30ae54d6$$ENDHEX$$
gnv_extfunc.pf_http_globalinit()

string ls_serverurl, ls_from_user_name, ls_from_addr, ls_to_addr
string ls_subject, ls_content
		  
gnv_extfunc.pf_http_addformfield(TYPE_PARAM, "from_user_name", as_from_user_name)
gnv_extfunc.pf_http_addformfield(TYPE_PARAM, "from_addr", as_from_addr)
gnv_extfunc.pf_http_addformfield(TYPE_PARAM, "to_addr", as_to_addr)
gnv_extfunc.pf_http_addformfield(TYPE_PARAM, "subject", as_subject)
gnv_extfunc.pf_http_addformfield(TYPE_PARAM_NONE_ESCAPE, "content", as_content)

long	i, li_cnt
string	ls_filename
string	ls_add_files[10]	// $$HEX8$$a8cc80bd0cd37cc720005ccd00b32000$$ENDHEX$$10$$HEX5$$1cac5cb82000c0c915c8$$ENDHEX$$.($$HEX4$$94cd00acdcc22000$$ENDHEX$$dll $$HEX5$$18c215c8200044d594c6$$ENDHEX$$.)

li_cnt = UpperBound(as_uploadfiles)
if li_cnt > 0 then
	for i=1 to li_cnt
		ls_add_files[i] = as_uploadfiles[i]
		if pf_f_isemptystring(ls_add_files[i]) then
			messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX14$$a8cc80bd20000cd37cc774c7200060be38c8200088c7b5c2c8b2e4b2$$ENDHEX$$!')
			return -1
		end if
	//  dll$$HEX5$$d0c51cc1200018c289d5$$ENDHEX$$.	
	//	ls_filename =  gnv_extfunc.of_pathstrippath(ls_add_files[i])
	//	gnv_extfunc.pf_http_addformfield(TYPE_PARAM, "filename", ls_filename)	
	//	gnv_extfunc.pf_http_addformfield(TYPE_FILE, "file1", as_uploadfiles[i])
	next
end if

// initialize http
if gnv_extfunc.pf_http_sendmail(as_server_url, ls_add_files, li_cnt ) = -1 then
	return -1
end if

li_running = gnv_extfunc.pf_http_send()
do while li_running = 1
//		ld_ultotal = gnv_extfunc.pf_http_uploadprogress_total()
//		ld_ulnow = gnv_extfunc.pf_http_uploadprogress_now()
//		

	yield();yield();yield();yield();
	li_running = gnv_extfunc.pf_http_checkrunningstatus()
loop

// check result code
li_rc = gnv_extfunc.pf_http_getresultcode()
if li_rc <> HTTP_OK then
	ls_error = gnv_extfunc.pf_http_geterrormessage(li_rc)
	gnv_extfunc.pf_http_close()
	gnv_extfunc.pf_http_globalcleanup()
	messagebox('HTTP $$HEX2$$4cc5bcb9$$ENDHEX$$(' + string(li_rc) + ')', ls_error)
	return -1
end if

// check http code
ll_httpcode = gnv_extfunc.pf_http_getinfo_long(HTTPINFO_RESPONSE_CODE)
if ll_httpcode >= 300 then
	ls_httpmesg = '$$HEX25$$54ba7cc7200004c8a1c1200011c9200044c598b740c6200019ac40c7200024c658b900ac20001cbcddc088d5b5c2c8b2e4b2$$ENDHEX$$~r~n~r~nHttp Code: ' + string(ll_httpcode) + '~r~nHttp Message: ' + &
	this.of_getmessageofhttpcode(ll_httpcode) + '~r~nHttp Description: ' + this.of_getdescriptionofhttpcode(ll_httpcode)
	gnv_extfunc.pf_http_close()
	gnv_extfunc.pf_http_globalcleanup()
	messagebox('$$HEX8$$54ba7cc7200004c8a1c1200024c658b9$$ENDHEX$$', ls_httpmesg)
	return -1
end if


gnv_extfunc.pf_http_close()


// HTTP $$HEX6$$a8bac8b4200074d0b0b9c5c5$$ENDHEX$$
gnv_extfunc.pf_http_globalcleanup()

//messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX14$$54ba7cc7200004c8a1c174c7200044c6ccb818b4c8c5b5c2c8b2e4b2$$ENDHEX$$.')

return li_rc

end function

public function string of_urlencode (string as_text);OleObject wsh
Integer  li_rc
string ls_temp

wsh = CREATE OleObject
li_rc = wsh.ConnectToNewObject( "MSScriptControl.ScriptControl" )
wsh.language = "javascript"

as_text = pf_f_replaceall(as_text, "'", "\'")
ls_temp = wsh.Eval("encodeURIComponent('" + as_text + "')")

//MessageBox('ls_temp', ls_temp)
Destroy wsh
Return ls_temp

end function

public function string of_ueldecode (string as_text);OleObject wsh
Integer  li_rc
string ls_temp

wsh = CREATE OleObject
li_rc = wsh.ConnectToNewObject( "MSScriptControl.ScriptControl" )
wsh.language = "javascript"

ls_temp = wsh.Eval("unescape('" + as_text + "')")
return ls_temp

end function

on pf_n_httptransfer.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pf_n_httptransfer.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// $$HEX1$$c5c5$$ENDHEX$$, $$HEX9$$e4b2b4c65cb8dcb420001cc114bebfb92000$$ENDHEX$$URL $$HEX2$$24c115c8$$ENDHEX$$
UPLOAD_URL = gnv_appconf.of_getprofile("httptransfer.upload_url", UPLOAD_URL)
DOWNLOAD_URL = gnv_appconf.of_getprofile("httptransfer.download_url", DOWNLOAD_URL)

// HTTPCODE $$HEX11$$54badcc2c0c9a9c6200070b374c730d108c7c4b3b0c6$$ENDHEX$$
ids_httpcode = create datastore
ids_httpcode.dataobject = 'pf_d_httpcode'

end event

event destructor;if isvalid(ids_httpcode) then
	destroy ids_httpcode
end if

end event

