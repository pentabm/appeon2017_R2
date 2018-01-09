HA$PBExportHeader$pf_w_webpage_link.srw
$PBExportComments$URL$$HEX21$$15c8f4bc5cb82000f9c698d374c7c0c97cb92000f0c5c4ac58d594b2200054d674ba200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_webpage_link from pf_w_sheet
end type
type ole_ie from olecustomcontrol within pf_w_webpage_link
end type
type p_close from pf_u_imagebutton within pf_w_webpage_link
end type
end forward

global type pf_w_webpage_link from pf_w_sheet
string title = "PageLink"
ole_ie ole_ie
p_close p_close
end type
global pf_w_webpage_link pf_w_webpage_link

type prototypes
FUNCTION boolean SetForegroundWindow( long hWnd ) LIBRARY "USER32"

end prototypes

forward prototypes
public function integer of_post_url (string as_url)
end prototypes

public function integer of_post_url (string as_url);long ll_rc

ll_rc = long(ole_ie.object.navigate2(as_url))

// Wait for Document to finish loading
do while ole_ie.Object.Busy
	yield()
loop

return ll_rc

// ===============================================
// $$HEX21$$44c598b794b22000f9c62000b4c50cd5acb900cf74c758c1200038c158c12000ddc031c12000c4d62000$$ENDHEX$$AS_URL $$HEX15$$f9c698d374c7c0c9200038d69ccd58d594b22000d8c00cd585c7c8b2e4b2$$ENDHEX$$.
// ===============================================
//string ls_forward
//string ls_parm[]
//string	ls_js
//
//// SESSION $$HEX5$$ddc031c120000fbc2000$$ENDHEX$$AS_URL$$HEX21$$5cb8200074c7d9b358d530ae200004c774d5200074d5f9b220002000f9c6b4c50cd5acb900cf74c758c1$$ENDHEX$$
//// $$HEX8$$d0c51cc120001cc8f5ac18b494b22000$$ENDHEX$$JSP $$HEX3$$98d374c7c0c9$$ENDHEX$$
//ls_forward = 'http://info.sewc.ac.kr/cc/student/s_forward.jsp'
//ls_parm[1] = ''
//ls_parm[2] = gnv_session.is_user_id
//ls_parm[3] = gnv_session.of_getstring('login_pwd')
//ls_parm[4] = as_url
//
//if AppeonGetClientType() = "PB" then
//	ole_ie.object.navigate2('about:blank')
//	
//	// Wait for Document to finish loading
//	do while ole_ie.Object.Busy
//		yield()
//	loop
//	
//	ole_ie.object.document.Open()
//	ole_ie.object.document.WriteLn("<HTML><HEAD>")
//	ole_ie.object.document.WriteLn("<SCRIPT>")
//	ole_ie.object.document.WriteLn("function go() {")
//	ole_ie.object.document.WriteLn("  document.myform.submit()")
//	ole_ie.object.document.WriteLn("  }")
//	ole_ie.object.document.WriteLn("</SCRIPT>")
//	ole_ie.object.document.WriteLn("</HEAD>")
//	ole_ie.object.document.WriteLn("<BODY onload='go();'>")
//	ole_ie.object.document.WriteLn("<FORM name='myform' ")
//	ole_ie.object.document.WriteLn("METHOD='POST' ACTION='" + ls_forward + "'>")
//	ole_ie.object.document.WriteLn("<INPUT NAME='kubun' TYPE=HIDDEN VALUE='" + ls_parm[1] + "'>")
//	ole_ie.object.document.WriteLn("<INPUT NAME='userid' TYPE=HIDDEN VALUE='" + ls_parm[2] + "'>")
//	ole_ie.object.document.WriteLn("<INPUT NAME='passwd' TYPE=HIDDEN VALUE='" + ls_parm[3] + "'>")
//	ole_ie.object.document.WriteLn("<INPUT NAME='forward' TYPE=HIDDEN VALUE='" + ls_parm[4] + "'>")
//	ole_ie.object.document.WriteLn("</FORM>")
//	ole_ie.object.document.WriteLn("</BODY>")
//	ole_ie.object.document.WriteLn("</HTML>")
//	ole_ie.object.document.Close()
//else
//	string ls_url, ls_oldurl
//	
//	ls_OldURL = ole_ie.Object.LocationURL
//	ls_url = AppeonGetIEURL()
//	ls_url += 'plugin/empty.html'
//	
//	if ls_oldurl = ls_url then
//		// do nothing
//	else
//		ole_ie.object.navigate2(ls_url)
//		// Wait for Document to start loading
//		do while ls_OldURL = ole_ie.Object.LocationURL
//			Yield()
//		loop
//	end if
//	
//	// Wait for Document to finish loading
//	do while ole_ie.Object.Busy
//		yield()
//	loop
//	
//	ls_js += 'var submitForm = document.createElement("FORM");~r~n'
//	ls_js += 'document.body.appendChild(submitForm);~r~n'
//	ls_js += 'submitForm.method="POST";~r~n'
//	ls_js += 'var newElement = document.createElement("<input name=~'' + 'kubun' + '~' type=~'hidden~' value=~'' + ls_parm[1] + '~'>");~r~n'
//	ls_js += 'submitForm.appendChild(newElement);~r~n'
//	ls_js += 'var newElement = document.createElement("<input name=~'' + 'userid' + '~' type=~'hidden~' value=~'' + ls_parm[2] + '~'>");~r~n'
//	ls_js += 'submitForm.appendChild(newElement);~r~n'
//	ls_js += 'var newElement = document.createElement("<input name=~'' + 'passwd' + '~' type=~'hidden~' value=~'' + ls_parm[3] + '~'>");~r~n'
//	ls_js += 'submitForm.appendChild(newElement);~r~n'
//	ls_js += 'var newElement = document.createElement("<input name=~'' + 'forward' + '~' type=~'hidden~' value=~'' + ls_parm[4] + '~'>");~r~n'
//	ls_js += 'submitForm.appendChild(newElement);~r~n'
//	ls_js += 'submitForm.action="' + ls_forward + '";~r~n'
//	ls_js += 'submitForm.submit();'
//
//	ole_ie.object.document.parentwindow.execScript(ls_js, "JavaScript");
//end if
//
//return 0

end function

on pf_w_webpage_link.create
int iCurrent
call super::create
this.ole_ie=create ole_ie
this.p_close=create p_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_ie
this.Control[iCurrent+2]=this.p_close
end on

on pf_w_webpage_link.destroy
call super::destroy
destroy(this.ole_ie)
destroy(this.p_close)
end on

event open;call super::open;// Resize $$HEX2$$f1b45db8$$ENDHEX$$
inv_Resize.of_Register(p_close, "FixedToRight")
inv_Resize.of_Register(ole_ie, "ScaleToRight&Bottom")

end event

event resize;call super::resize;ole_ie.x = -8
ole_ie.y = -8
ole_ie.width = newwidth
ole_ie.height = newheight

end event

event pfe_postopen;call super::pfe_postopen;string	ls_url_link_yn, ls_linked_url

select		url_link_yn,
			linked_url
into		:ls_url_link_yn,
			:ls_linked_url
from		pf_pgm_mst
where	sys_id = :gnv_session.is_sys_id
and		menu_id = :inv_menudata.is_menu_id
using		sqlca;

if ls_url_link_yn = 'Y' then
	if not isnull(ls_linked_url) and len(trim(ls_linked_url)) > 0 then
		post of_post_url(ls_linked_url)
	end if
end if

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_webpage_link
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_webpage_link
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_webpage_link
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_webpage_link
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_webpage_link
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_webpage_link
end type

type ole_ie from olecustomcontrol within pf_w_webpage_link
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( boolean activedocument,  ref boolean cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
event setphishingfilterstatus ( long phishingfilterstatus )
event newprocess ( long lcauseflag,  oleobject pwb2,  ref boolean cancel )
event redirectxdomainblocked ( oleobject pdisp,  any starturl,  any redirecturl,  any frame,  any statuscode )
integer x = 46
integer y = 160
integer width = 4507
integer height = 2064
integer taborder = 10
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "pf_w_webpage_link.win"
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "$$HEX3$$74adbcb9b4cc$$ENDHEX$$"
long textcolor = 33554432
end type

event error;action = ExceptionIgnore!

end event

type p_close from pf_u_imagebutton within pf_w_webpage_link
boolean visible = false
integer x = 4315
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
end type

event clicked;call super::clicked;close(parent)

end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Apf_w_webpage_link.bin 
2B00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000ea92deb001d2721100000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000ea92deb001d27211ea92deb001d27211000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
22ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c000065e8000035550000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c000065e8000035550000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Apf_w_webpage_link.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
