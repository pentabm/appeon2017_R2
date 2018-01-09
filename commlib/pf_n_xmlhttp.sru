HA$PBExportHeader$pf_n_xmlhttp.sru
$PBExportComments$XMLHTTP $$HEX14$$7cb9200074c7a9c65cd52000f9c698d374c7c0c9200038d69ccd2000$$ENDHEX$$($$HEX3$$1cac1cbc11c9$$ENDHEX$$)
forward
global type pf_n_xmlhttp from timing
end type
end forward

global type pf_n_xmlhttp from timing
event pfe_readystatechanged ( long al_readystate )
end type
global pf_n_xmlhttp pf_n_xmlhttp

type prototypes
//  Make application pause from running x number of thousands of a second
Subroutine Sleep (ulong millsecond) Library "Kernel32.dll"

end prototypes

type variables
constant string CRLF = "~r~n"

// ConnectModeEnum
constant integer adModeUnknown = 0
constant integer adModeRead = 1
constant integer adModeWrite = 2
constant integer adModeReadWrite = 3
constant integer adModeShareDenyRead = 4
constant integer adModeShareDenyWrite = 8
constant integer adModeShareExclusive = 12
constant integer adModeShareDenyNone = 16
constant integer adModeRecursive = 4194304

// StreamTypeEnum
constant integer adTypeBinary = 1
constant integer adTypeText = 2

// $$HEX9$$f5acb5d12000acb934d112ac2000c1c018c2$$ENDHEX$$
constant integer SUCCESS = 1
constant integer FAILURE = -1
constant integer NO_ACTION = 0

// $$HEX2$$c4ac8dc1$$ENDHEX$$,$$HEX9$$11c9c0c92000acb934d112ac2000c1c018c2$$ENDHEX$$
constant integer CONTINUE_ACTION = 1
constant integer PREVENT_ACTION = 0

// XMLHTTP Status
constant long SUCCEED = 200	// $$HEX2$$31c1f5ac$$ENDHEX$$
constant long ACCESS_DENIED = 403	// $$HEX4$$11c8fcad70ac80bd$$ENDHEX$$
constant long NOT_FOUND = 404	// $$HEX2$$0cd37cc7$$ENDHEX$$/$$HEX6$$98d374c7c0c92000c6c54cc7$$ENDHEX$$

// Timer $$HEX3$$78c730d18cbc$$ENDHEX$$
constant double DEFAULT_TIMING_INTERVAL = 0.1

// Request Timeout
constant long DEFAULT_TIMEOUT_SEC = 30

OLEObject iole_xmlhttp
OLEObject iole_stream

// $$HEX7$$c5c55cb8dcb42000c1c0dcd03dcc$$ENDHEX$$
pf_w_httpupload iw_progress

long il_readyState
long il_cputime

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_start ()
public function integer of_waituntilrequestfinished ()
public function long of_checkifurlexists (string as_url)
public function integer of_filedownload ()
public function string of_getmultipartboundary ()
public function string of_createhttptextrequestparam (readonly string as_boundary, string as_key, string as_value)
public function integer of_fileupload (string as_uploadfile)
public function string of_createhttptextrequestfileheader (readonly string as_boundary, string as_key, string as_value)
public function integer of_fileupload2 (string as_uploadfile)
end prototypes

event pfe_readystatechanged(long al_readystate);// status 	 $$HEX8$$1cc184bc58c7200098ccacb9b0acfcac$$ENDHEX$$
//200 : $$HEX2$$31c1f5ac$$ENDHEX$$
//403 : $$HEX4$$11c8fcad70ac80bd$$ENDHEX$$
//404 : $$HEX2$$0cd37cc7$$ENDHEX$$/$$HEX6$$98d374c7c0c92000c6c54cc7$$ENDHEX$$

if al_readystate = 4 then
	this.stop()
	messagebox('xmlhttp.status', long(iole_xmlhttp.Status))
end if

end event

public function string of_getclassname ();return 'pf_n_xmlhttp'

end function

public function integer of_start ();return this.start(DEFAULT_TIMING_INTERVAL)

end function

public function integer of_waituntilrequestfinished ();// $$HEX4$$98ccacb9c1c0dcd0$$ENDHEX$$
//0 : open()$$HEX7$$54ba1cc1dcb4200018c289d504c8$$ENDHEX$$
//1 : $$HEX3$$5cb829b511c9$$ENDHEX$$
//2 : $$HEX4$$5cb829b544c6ccb8$$ENDHEX$$
//3 : $$HEX5$$1cc184bc98ccacb911c9$$ENDHEX$$
//4 : $$HEX5$$1cc184bc98ccacb95db0$$ENDHEX$$

long ll_readystate
long ll_cputime

setpointer(hourglass!)
post setpointer(arrow!)

ll_cputime = cpu()
ll_readystate = long(iole_xmlhttp.readyState)
do while ll_readystate < 4
	if (cpu() - ll_cputime) / 1000 > DEFAULT_TIMEOUT_SEC then return failure
	
	choose case ll_readystate
		case 1
			//iw_progress.st_msg.text = '$$HEX4$$5cb829b5200011c9$$ENDHEX$$...'
		case 2
			//iw_progress.st_msg.text = '$$HEX5$$5cb829b5200044c6ccb8$$ENDHEX$$'
		case 3
			//li_percent = (iole_xmlhttp.loaded / iole_xmlhttp.total) * 100
			//iw_progress.hpb_indiv.Position = li_percent
			//iw_progress.st_msg.text = '$$HEX7$$1cc184bc200098ccacb9200011c9$$ENDHEX$$...'
	end choose
	
	this.sleep(100)
	ll_readystate = long(iole_xmlhttp.readyState)
loop

return success

end function

public function long of_checkifurlexists (string as_url);// $$HEX3$$74d5f9b22000$$ENDHEX$$URL $$HEX13$$74c7200074c8acc758d594b2c0c9200055d678c769d5c8b2e4b2$$ENDHEX$$.
// $$HEX3$$acb934d112ac$$ENDHEX$$
// -1 : XMLHTTP $$HEX2$$c6c54cc7$$ENDHEX$$
// -9 : TimeOut
// 200 : $$HEX2$$31c1f5ac$$ENDHEX$$
// 403 : $$HEX4$$11c8fcad70ac80bd$$ENDHEX$$
// 404 : $$HEX2$$0cd37cc7$$ENDHEX$$/$$HEX6$$98d374c7c0c92000c6c54cc7$$ENDHEX$$

if not isvalid(iole_xmlhttp) then return -1

long ll_status

iole_xmlhttp.open("HEAD", as_url, false)
iole_xmlhttp.send()

//ll_readyState = iole_xmlhttp.readyState
//if ll_readystate = 4 then
//	ll_status = iole_xmlhttp.status
//	messagebox('ll_status', ll_status)
//end if

if this.of_waitUntilRequestFinished() = success then
	ll_status = iole_xmlhttp.Status
	return ll_status
else
	return -9	// TimeOut
end if

end function

public function integer of_filedownload ();return 0

//String ls_get_url, ls_post_url
//String ls_post_variables, ls_response
//String ls_response_text, ls_status_text
//long   ll_status_code
//OleObject loo_xmlhttp
//
////include parameters on the URL here for get parameters
//ls_get_url = "https://encrypted.google.com/"
//
//try
//  //Create an instance of our COM object
//  loo_xmlhttp = CREATE oleobject
//  loo_xmlhttp.ConnectToNewObject("Msxml2.XMLHTTP.4.0")
//
//  //First lets do a GET request 
//  //All request parameters should be included in the URL
//  loo_xmlhttp.open ("GET",ls_get_url, false)
//  loo_xmlhttp.send()
//
//  //Get our response
//  ls_status_text = loo_xmlhttp.StatusText
//  ll_status_code =  loo_xmlhttp.Status
//
//  //Check HTTP Response code for errors
//  //http://kbs.cs.tu-berlin.de/~jutta/ht/responses.html
//  if ll_status_code >= 300 then
//    MessageBox("HTTP GET Request Failed", ls_response_text)
//  else
//    //Get the response we received from the web server
//    ls_response_text = loo_xmlhttp.ResponseText
//
//    MessageBox("GET Request Succeeded", ls_response_text)
//  end if
//
//  //Lets do a POST now, We would pass a String
//  //in the send() call that contains the post data in the 
//  //format name1=value1&name2=value2&...
//  ls_post_url = "https://encrypted.google.com/"
//  ls_post_variables = ""
//
//  loo_xmlhttp.open ("POST",ls_post_url, false)
//  loo_xmlhttp.send(ls_post_variables)
//
//  //Get our response
//  ls_status_text = loo_xmlhttp.StatusText
//  ll_status_code =  loo_xmlhttp.Status
//
//  //Check HTTP Response code for errors
//  //http://kbs.cs.tu-berlin.de/~jutta/ht/responses.html
//  if ll_status_code >= 300 then
//    MessageBox("HTTP POST Request Failed", ls_response_text)
//  else
//    //Get the response we received from the web server
//    ls_response_text = loo_xmlhttp.ResponseText
//
//    MessageBox("POST Request Succeeded", ls_response_text)
//  end if
//
//  //Done so cleanup
//  loo_xmlhttp.DisconnectObject()
//
//catch (RuntimeError rte)
//
//  MessageBox("Error", "RuntimeError - " + rte.getMessage())
//
//end try
//
//end subroutine

end function

public function string of_getmultipartboundary ();// Contnet-Type : MultiPart Post Request $$HEX2$$a9c62000$$ENDHEX$$Boundary $$HEX4$$ddc031c168d518c2$$ENDHEX$$
// 70$$HEX13$$90c7acb9200074c758d55cb82000ddc031c174d57cc5200068d5$$ENDHEX$$($$HEX3$$f4bcb5d12000$$ENDHEX$$40$$HEX2$$90c7acb9$$ENDHEX$$)

Constant Integer BoundaryLength = 13
Constant String UsableChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

string ls_boundary
integer i, li_usableLen, li_index

// $$HEX9$$9cb764b3200068d518c2200008cd30ae54d6$$ENDHEX$$
randomize(cpu())

// $$HEX10$$9cb764b35cd5200038bb90c7f4c52000ddc031c1$$ENDHEX$$
li_usablelen = len(UsableChars)
for i = 1 to BoundaryLength
	li_index = Rand(li_usablelen)
	ls_boundary += mid(UsableChars, li_index, 1)
next

ls_boundary = fill('-', 27) + ls_boundary
return ls_boundary

end function

public function string of_createhttptextrequestparam (readonly string as_boundary, string as_key, string as_value);// $$HEX18$$4dd1a4c2b8d220000cd37cb7f8bb30d1200039c158c144c72000ddc031c169d5c8b2e4b2$$ENDHEX$$

string ls_section

ls_section = "--" + as_boundary + CRLF + "Content-Disposition: form-data; name=~"" + as_key + "~"" + &
				CRLF + CRLF + as_value + CRLF

return ls_section

end function

public function integer of_fileupload (string as_uploadfile);string ls_filepath, ls_filename, ls_boundary
string ls_requestbody, ls_requestend

if isnull(as_uploadfile) then return -1
if not fileexists(as_uploadfile) then 
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(pf_n_xmlhttp.of_fileupload)', '[' + as_uploadfile + '] $$HEX18$$c5c55cb8dcb460d520000cd37cc774c7200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$')
	return - 1
end if

// $$HEX10$$c5c55cb8dcb42000c1c0dcd03dcc200024c608d5$$ENDHEX$$
//open(iw_progress)

ls_filepath = gnv_extfunc.of_pathremovefilespec(as_uploadfile)
ls_filename = gnv_extfunc.of_pathstrippath(as_uploadfile)

// Post MultiPart Form-Data$$HEX2$$a9c62000$$ENDHEX$$Boundary $$HEX9$$38bb90c7f4c544c720006cad69d5c8b2e4b2$$ENDHEX$$
ls_boundary = this.of_getmultipartboundary()

// Request Parameter $$HEX5$$39c158c12000ddc031c1$$ENDHEX$$
ls_requestbody = this.of_createHTTPTextRequestParam(ls_boundary, "user", "jwhan")
ls_requestbody += this.of_createHTTPTextRequestParam(ls_boundary, "password", "welcome")
ls_requestbody += this.of_createHTTPTextRequestParam(ls_boundary, "destSubPath", "/sub_1")

// $$HEX14$$c5c55cb8dcb460d5200014bc74c708b1acb90cd37cc72000e4d554b3$$ENDHEX$$
ls_requestbody += this.of_createHTTPTextRequestFileHeader(ls_boundary, "uploadFile", ls_filename)

// Request $$HEX8$$58c72000c8b9c0c9c9b920007cb778c7$$ENDHEX$$
ls_requestend = CRLF + "--" + ls_boundary + "--" + CRLF

// $$HEX16$$c5c55cb8dcb460d5200014bc74c708b1acb9200074c7f8bbc0c920005cb8dcb4$$ENDHEX$$
blob lb_requestbody
blob lb_binary
integer li_file

lb_requestbody = blob(ls_requestbody, EncodingAnsi!)

li_file = FileOpen(as_uploadfile, StreamMode!, Read!, LockRead!)
FileReadEx(li_file, lb_binary)
FileClose(li_file)

lb_requestbody += lb_binary
lb_requestbody += blob(ls_requestend, EncodingAnsi!)

//lole_requestbody = create OLEObject
//lole_requestbody.connectToNewObject("ADODB.Stream")
//lole_requestbody.Mode = adModeRead
//lole_requestbody.Type = adTypeBinary
//lole_requestbody.Open()
//lole_requestbody.LoadFromFile(as_uploadfile)
//lb_binary = lole_requestbody.Read()
//lole_requestbody.close()
//
////integer li_file
////li_file = FileOpen(as_uploadfile, StreamMode!, Read!, LockRead!)
////FileReadEx(li_file, lb_binary)
////FileClose(li_file)
//
//// Form $$HEX6$$70b374c730d12000ddc031c1$$ENDHEX$$
//blob lb_formdata
//
//lb_formdata += blob(ls_requestbody, EncodingAnsi!)
//lb_formdata += lb_binary
//lb_formdata += blob(ls_requestend, EncodingAnsi!)

//OLEObject lole_requestbody, lole_uploadfile
//
//lole_requestbody = create OLEObject
//lole_requestbody.connectToNewObject("ADODB.Stream")
//lole_requestbody.Mode = adModeReadWrite
//lole_requestbody.Type = adTypeBinary
//lole_requestbody.Open()
//
//lole_requestbody.Write(blob(ls_requestbody, EncodingAnsi!))
//
////lole_uploadfile = create OLEObject
////lole_uploadfile.connectToNewObject("ADODB.Stream")
////lole_uploadfile.Mode = adModeReadWrite
////lole_uploadfile.Type = adTypeBinary
////lole_uploadfile.Open()
////lole_uploadfile.LoadFromFile(as_uploadfile)
////lole_requestbody.Write(lole_uploadfile.Read())
////lole_uploadfile.Close()
//
//integer li_file
//blob lb_binary
//
//li_file = FileOpen(as_uploadfile, StreamMode!, Read!, LockRead!)
//FileReadEx(li_file, lb_binary)
//FileClose(li_file)
//lole_requestbody.Write(lb_binary)
//
//lole_requestbody.Write(blob(ls_requestend, EncodingAnsi!))
//lole_requestbody.Position = 0





//integer li_FileNum
//li_FileNum = FileOpen("C:\temp\temp.txt", StreamMode!, Write!, LockWrite!, Replace!)
//FileWriteEx(li_FileNum, lb_formdata)
//FileClose(li_FileNum)

// Request $$HEX2$$04c8a1c1$$ENDHEX$$
//iole_xmlhttp.Open("POST", "http://10.1.99.102/fileupload/uploadFile", false)

//any la_null
//setnull(la_null)
iole_xmlhttp.Open("POST", "http://10.1.99.102/powerframe/FileUpload", False)

//pf_n_xmlhttphandler lnv_handler
//lnv_handler = create pf_n_xmlhttphandler
//iole_xmlhttp.onreadystatechange = lnv_handler

//iole_xmlhttp.setRequestHeader("Accept", "text/html, application/xhtml+xml, */*")
//iole_xmlhttp.setRequestHeader("Referer", "http://10.1.99.102/fileupload/uploadFile")
iole_xmlhttp.setRequestHeader("Accept-Language", "ko-KR")
iole_xmlhttp.setRequestHeader("User-Agent", "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)")
iole_xmlhttp.setRequestHeader("Content-Type", "multipart/form-data; boundary=" + ls_boundary)
iole_xmlhttp.setRequestHeader("Accept-Encoding", "gzip, deflate")
//iole_xmlhttp.setRequestHeader("Host", "10.1.99.102")
//iole_xmlhttp.setRequestHeader("Content-Length", len(lb_formdata))

//iole_xmlhttp.setRequestHeader("Content-Length", lole_requestbody.Size())
iole_xmlhttp.setRequestHeader("Content-Length", len(lb_requestbody))

//iole_xmlhttp.setRequestHeader("Proxy-Connection", "Keep-Alive")
//iole_xmlhttp.setRequestHeader("Pragma", "no-cache")

//iole_xmlhttp.send(lole_requestbody.Read())
iole_xmlhttp.send(lb_requestbody)

//iole_xmlhttp.setRequestHeader("Content-Length", string(lole_requestbody.Size))
//iole_xmlhttp.setRequestHeader("Content-Disposition", "form-data; name=~"file~"; filename=~"" + ls_filename + "~"")
//iole_xmlhttp.setRequestHeader("Content-Disposition", "form-data; type=~"file~"; name=~"" + ls_filename + "~"")
//iole_xmlhttp.setRequestHeader("Content-Disposition", "form-data; type=~"file~"; name=~"" + ls_filename + "~"")
//iole_xmlhttp.setRequestHeader("Content-Disposition", "attachment; filename=~"" + ls_filename + "~"")
//iole_xmlhttp.send(lole_requestbody.Read(lole_requestbody.Size))

if this.of_waitUntilRequestFinished() = success then
	messagebox('readystate', string(iole_xmlhttp.readystate))
	messagebox('status', string(iole_xmlhttp.status))
	messagebox('ResponseText', string(iole_xmlhttp.responseText))
	//ll_status = iole_xmlhttp.Status
	//return ll_status
else
	//return -9	// TimeOut
end if

//lole_requestbody.close()
//close(iw_progress)

return 0

end function

public function string of_createhttptextrequestfileheader (readonly string as_boundary, string as_key, string as_value);// $$HEX21$$14bc74c708b1acb920000cd37cc7a9c62000e4d554b3200039c158c144c72000ddc031c169d5c8b2e4b2$$ENDHEX$$

string ls_section

ls_section = "--" + as_boundary + CRLF + &
				"Content-Disposition: form-data; name=~"" + as_key + "~"" + &
              	"; filename=~"" + as_value + "~"" + CRLF + &
				"Content-Type: application/octet-stream" + CRLF + CRLF

return ls_section

end function

public function integer of_fileupload2 (string as_uploadfile);string ls_filepath, ls_filename

if isnull(as_uploadfile) then return -1
if not fileexists(as_uploadfile) then 
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(pf_n_xmlhttp.of_fileupload)', '[' + as_uploadfile + '] $$HEX18$$c5c55cb8dcb460d520000cd37cc774c7200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$')
	return - 1
end if

ls_filepath = gnv_extfunc.of_pathremovefilespec(as_uploadfile)
ls_filename = gnv_extfunc.of_pathstrippath(as_uploadfile)

oleobject lole_ie

lole_ie = create OLEObject
lole_ie.ConnectToNewObject("InternetExplorer.Application")
lole_ie.Visible = 1
lole_ie.navigate("http://localhost/powerframe/upload3.html")

// Wait for Document to finish loading
do while lole_ie.Busy
	yield()
loop

messagebox("syntax", "add_input('file', 'file', '" + as_uploadfile + "');")
lole_ie.document.parentwindow.execScript("add_input('file', 'file', '" + as_uploadfile + "'); multiform.submit();", "JavaScript")
//lole_ie.document.parentwindow.execScript("multiform.submit();", "JavaScript")

lole_ie.disconnectobject()
destroy lole_ie
return 0


//iole_stream = create OLEObject
//iole_stream.connectToNewObject("ADODB.Stream")
//iole_stream.Mode = 3		// Read & Write
//iole_stream.Type = 1		// adTypeBinary
//iole_stream.Open()
//iole_stream.LoadFromFile(as_uplaodfile)
//iole_stream.Position = 0
//
//iole_xmlhttp.Open("POST", "http://localhost/powerframe/FileUpload", false)
//iole_xmlhttp.setRequestHeader("Content-Type", "content=application/octet-stream")
////iole_xmlhttp.setRequestHeader("Content-Type", "application/octet-stream")
//iole_xmlhttp.setRequestHeader("Content-Disposition", "attachment; filename=~"" + ls_filename + "~"")
//iole_xmlhttp.setRequestHeader("Content-Length", string(iole_stream.Size))
//
////iole_xmlhttp.setRequestHeader("Content-Disposition", "form-data; name=~"file~"; filename=~"" + ls_filename + "~"")
////iole_xmlhttp.setRequestHeader("Content-Disposition", "form-data; type=~"file~"; name=~"" + ls_filename + "~"")
////iole_xmlhttp.setRequestHeader("Content-Disposition", "form-data; type=~"file~"; name=~"" + ls_filename + "~"")
//
//iole_xmlhttp.send(iole_stream.Read(iole_stream.Size))
//
//messagebox('readystate', string(iole_xmlhttp.readystate))
//messagebox('status', string(iole_xmlhttp.status))
//messagebox('ResponseText', string(iole_xmlhttp.responseText))
//
//iole_stream.close()
//iole_stream.disconnectobject()
//destroy iole_stream
//
//return 0

end function

on pf_n_xmlhttp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pf_n_xmlhttp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;integer li_retval

iole_xmlhttp = create oleobject
li_retval = iole_xmlhttp.connecttonewobject("MSXML2.ServerXMLHTTP")

if li_retval < 0 then
	choose case li_retval
		case -1;  messagebox("Creating XMLHTTP Failure!", "Invalid Call: the argument is the Object property of a control")
		case -2;  messagebox("Creating XMLHTTP Failure!", "Class name not found")
		case -3;  messagebox("Creating XMLHTTP Failure!", "Object could not be created")
		case -4;  messagebox("Creating XMLHTTP Failure!", "Could not connect to object")
		case -9;  messagebox("Creating XMLHTTP Failure!", "Other error")
		case -15;  messagebox("Creating XMLHTTP Failure!", "COM+ is not loaded on this computer")
		case -16;  messagebox("Creating XMLHTTP Failure!", "Invalid Call: this function not applicable")
		case else; messagebox("Creating XMLHTTP Failure!", "Unknown Error")
	end choose
end if

end event

event destructor;if this.running = true then
	this.stop()
end if

if isvalid(iole_xmlhttp) then
	iole_xmlhttp.disconnectobject()
	destroy iole_xmlhttp
end if

end event

event timer;// $$HEX4$$98ccacb9c1c0dcd0$$ENDHEX$$
//0 : open()$$HEX7$$54ba1cc1dcb4200018c289d504c8$$ENDHEX$$
//1 : $$HEX3$$5cb829b511c9$$ENDHEX$$
//2 : $$HEX4$$5cb829b544c6ccb8$$ENDHEX$$
//3 : $$HEX5$$1cc184bc98ccacb911c9$$ENDHEX$$
//4 : $$HEX5$$1cc184bc98ccacb95db0$$ENDHEX$$

if il_readyState <> long(iole_xmlhttp.readyState) then
	il_readyState = long(iole_xmlhttp.readyState)
	this.event pfe_readyStateChanged(il_readyState)
end if

end event

