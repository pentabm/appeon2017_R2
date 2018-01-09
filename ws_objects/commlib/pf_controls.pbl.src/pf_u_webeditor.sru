$PBExportHeader$pf_u_webeditor.sru
forward
global type pf_u_webeditor from pf_u_webbrowser
end type
end forward

global type pf_u_webeditor from pf_u_webbrowser
end type
global pf_u_webeditor pf_u_webeditor

type variables
constant long TIMEOUT = 10000 // mSecs

string EDITOR_URL = 'http://localhost/smarteditor/SmartEditor2_editor.html'
string VIEWER_URL = 'http://localhost/smarteditor/SmartEditor2_viewer.html'

private:
	boolean ib_busy

end variables

forward prototypes
public function string of_getcontents ()
public function integer of_waituntildocumentisready ()
public subroutine of_openwebeditor ()
public subroutine of_resetcontents ()
public function integer of_setcontents (string as_innerhtml)
public subroutine of_seteditorurl (string as_url)
public subroutine of_setviewerurl (string as_url)
public function integer of_viewcontents (string as_innerhtml)
public function string of_getclassname ()
public function blob of_getcontents_blob ()
public subroutine of_openwebeditor (string as_contents)
public subroutine of_openwebviewer ()
public subroutine of_openwebviewer (string as_contents)
end prototypes

public function string of_getcontents ();string ls_return

if this.of_waituntildocumentisready() = -1 then return ''

ls_return = this.of_execscript("getContents();")
ls_return = pf_f_replaceall(ls_return, '~r', '')
ls_return = pf_f_replaceall(ls_return, '~n', '')

return ls_return

//String              ls_return
//ls_return = appeongetbrowserversion()
//ls_return = trim(Mid(ls_return, Pos(ls_return, "MSIE") + Len("MSIE")))
//ls_return = Left(ls_return, 1)
//
//Choose Case Long(ls_return)
//	Case Is < 9
//		ole_webeditor.Object.document.parentwindow.execScript("getHTMLContents();", "JavaScript")
//		ls_return = String(ole_webeditor.Object.document.getElementById("returnValue").value)
//	Case Else
//		ls_return = String(ole_webeditor.Object.document.parentwindow.eval("getHTMLContents();"))
//End Choose
//
//ls_return = pf_f_replaceall(ls_return, '~r~n', '')
//ls_return = pf_f_replaceall(ls_return, '~r', '')
//ls_return = pf_f_replaceall(ls_return, '~n', '')

end function

public function integer of_waituntildocumentisready ();long ll_start

ll_start = cpu()
do until this.of_getreadystate() = "complete"
	yield()
	// TimeOut
	if cpu() - ll_start > TIMEOUT then
		return -1
	end if
loop

return 1

end function

public subroutine of_openwebeditor ();// SmartEditor 페이지 오픈
this.of_navigate(EDITOR_URL)

end subroutine

public subroutine of_resetcontents ();if this.of_waituntildocumentisready() = -1 then return
this.of_execscript("resetContents();")

end subroutine

public function integer of_setcontents (string as_innerhtml);if this.of_waituntildocumentisready() = -1 then return -1

//as_innerhtml = pf_f_replaceall(as_innerhtml, "'", "\'")
//as_innerhtml = pf_f_replaceall(as_innerhtml, '"', '\"')

this.of_execscript("setContents('" + as_innerhtml + "');")
return 1

end function

public subroutine of_seteditorurl (string as_url);EDITOR_URL = as_url

end subroutine

public subroutine of_setviewerurl (string as_url);VIEWER_URL = as_url

end subroutine

public function integer of_viewcontents (string as_innerhtml);if this.of_waituntildocumentisready() = -1 then return -1

//as_innerhtml = pf_f_replaceall(as_innerhtml, "'", "\'")
//as_innerhtml = pf_f_replaceall(as_innerhtml, '"', '\"')

this.of_execscript("showPanel('" + as_innerHTML + "');")
return 1

end function

public function string of_getclassname ();return 'pf_u_webeditor'

end function

public function blob of_getcontents_blob ();blob lblb_null

if this.of_waituntildocumentisready() = -1 then return lblb_null

return Blob( this.of_execscript("getContents();"), EncodingUTF8! )

end function

public subroutine of_openwebeditor (string as_contents);// SmartEditor Editor 페이지 오픈
this.of_navigate(EDITOR_URL)

// HTML 컨텐츠 추가
this.of_execscript("setInitContents('" + as_contents + "');")

end subroutine

public subroutine of_openwebviewer ();// SmartEditor Viewer 페이지 오픈
this.of_navigate(VIEWER_URL)

end subroutine

public subroutine of_openwebviewer (string as_contents);// SmartEditor Viewer 페이지 오픈
this.of_navigate(VIEWER_URL)

// HTML 컨텐츠 추가
this.of_execscript("showPanel('" + as_contents + "');")

end subroutine

on pf_u_webeditor.create
call super::create
end on

on pf_u_webeditor.destroy
call super::destroy
end on

event constructor;call super::constructor;// 웹에디터 URL 설정
EDITOR_URL = gnv_appconf.of_getprofile("webeditor.editor_url", EDITOR_URL)
VIEWER_URL = gnv_appconf.of_getprofile("webeditor.viewer_url", EDITOR_URL)

end event

