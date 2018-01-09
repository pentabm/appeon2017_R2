$PBExportHeader$w_test2.srw
forward
global type w_test2 from pf_w_sheet
end type
type cb_16 from commandbutton within w_test2
end type
type cb_15 from commandbutton within w_test2
end type
type cb_14 from commandbutton within w_test2
end type
type cb_13 from commandbutton within w_test2
end type
type dw_1 from datawindow within w_test2
end type
type st_3 from statictext within w_test2
end type
type st_2 from statictext within w_test2
end type
type cb_12 from commandbutton within w_test2
end type
type cb_11 from commandbutton within w_test2
end type
type cb_10 from commandbutton within w_test2
end type
type st_bytessent from statictext within w_test2
end type
type st_bytestotal from statictext within w_test2
end type
type cb_9 from commandbutton within w_test2
end type
type st_running from statictext within w_test2
end type
type st_1 from statictext within w_test2
end type
type cb_8 from commandbutton within w_test2
end type
type cb_7 from commandbutton within w_test2
end type
type cb_6 from commandbutton within w_test2
end type
type cb_5 from commandbutton within w_test2
end type
type cb_4 from commandbutton within w_test2
end type
type cb_3 from commandbutton within w_test2
end type
type cb_2 from commandbutton within w_test2
end type
type cb_1 from commandbutton within w_test2
end type
type p_1 from picture within w_test2
end type
type cb_17 from commandbutton within w_test2
end type
type cb_18 from commandbutton within w_test2
end type
end forward

global type w_test2 from pf_w_sheet
integer width = 4754
integer height = 1980
string title = "Untitled"
boolean controlmenu = true
long backcolor = 67108864
string icon = "AppIcon!"
cb_16 cb_16
cb_15 cb_15
cb_14 cb_14
cb_13 cb_13
dw_1 dw_1
st_3 st_3
st_2 st_2
cb_12 cb_12
cb_11 cb_11
cb_10 cb_10
st_bytessent st_bytessent
st_bytestotal st_bytestotal
cb_9 cb_9
st_running st_running
st_1 st_1
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
p_1 p_1
cb_17 cb_17
cb_18 cb_18
end type
global w_test2 w_test2

forward prototypes
public function string of_convertbytetobinarystring (byte ab_byte)
end prototypes

public function string of_convertbytetobinarystring (byte ab_byte);integer li_dec, li_mod
string ls_binary

li_dec = ab_byte
do while li_dec > 1
	li_mod = mod(li_dec, 2)
	ls_binary = string(li_mod) + ls_binary
	li_dec = truncate(li_dec / 2, 0)
loop

ls_binary = string(li_dec) + ls_binary
ls_binary = fill('0', 8 - len(ls_binary)) + ls_binary
ls_binary = left(ls_binary, 7)

return ls_binary

end function

on w_test2.create
int iCurrent
call super::create
this.cb_16=create cb_16
this.cb_15=create cb_15
this.cb_14=create cb_14
this.cb_13=create cb_13
this.dw_1=create dw_1
this.st_3=create st_3
this.st_2=create st_2
this.cb_12=create cb_12
this.cb_11=create cb_11
this.cb_10=create cb_10
this.st_bytessent=create st_bytessent
this.st_bytestotal=create st_bytestotal
this.cb_9=create cb_9
this.st_running=create st_running
this.st_1=create st_1
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.p_1=create p_1
this.cb_17=create cb_17
this.cb_18=create cb_18
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_16
this.Control[iCurrent+2]=this.cb_15
this.Control[iCurrent+3]=this.cb_14
this.Control[iCurrent+4]=this.cb_13
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.cb_12
this.Control[iCurrent+9]=this.cb_11
this.Control[iCurrent+10]=this.cb_10
this.Control[iCurrent+11]=this.st_bytessent
this.Control[iCurrent+12]=this.st_bytestotal
this.Control[iCurrent+13]=this.cb_9
this.Control[iCurrent+14]=this.st_running
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.cb_8
this.Control[iCurrent+17]=this.cb_7
this.Control[iCurrent+18]=this.cb_6
this.Control[iCurrent+19]=this.cb_5
this.Control[iCurrent+20]=this.cb_4
this.Control[iCurrent+21]=this.cb_3
this.Control[iCurrent+22]=this.cb_2
this.Control[iCurrent+23]=this.cb_1
this.Control[iCurrent+24]=this.p_1
this.Control[iCurrent+25]=this.cb_17
this.Control[iCurrent+26]=this.cb_18
end on

on w_test2.destroy
call super::destroy
destroy(this.cb_16)
destroy(this.cb_15)
destroy(this.cb_14)
destroy(this.cb_13)
destroy(this.dw_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_12)
destroy(this.cb_11)
destroy(this.cb_10)
destroy(this.st_bytessent)
destroy(this.st_bytestotal)
destroy(this.cb_9)
destroy(this.st_running)
destroy(this.st_1)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.cb_17)
destroy(this.cb_18)
end on

event open;gnv_extfunc.pf_http_globalinit()

end event

type ln_templeft from pf_w_sheet`ln_templeft within w_test2
end type

type ln_tempright from pf_w_sheet`ln_tempright within w_test2
end type

type ln_temptop from pf_w_sheet`ln_temptop within w_test2
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within w_test2
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within w_test2
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within w_test2
end type

type cb_16 from commandbutton within w_test2
integer x = 2789
integer y = 856
integer width = 457
integer height = 132
integer taborder = 90
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;OLEObject IE
string ls_ie
string ls_url

IE = CREATE OLEObject
IE.ConnectToNewObject("InternetExplorer.Application")

ls_ie = IE.Fullname ()

ls_url = "http://localhost:8080/powerframe"
Run (ls_ie + " -nosessionmerging " + ls_url)

end event

type cb_15 from commandbutton within w_test2
integer x = 2025
integer y = 988
integer width = 457
integer height = 132
integer taborder = 70
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "multipart"
end type

event clicked;
//pf_n_httptransfer lnv_http
//lnv_http = create pf_n_httptransfer
//lnv_http.of_multipart_upload("http://localhost:8080/powerframe/FileUpload", "filename=APB-2013R2-OE-X32-UNX-AP-001.zip", "D:\Downloads\APB-2013R2-OE-X32-UNX-AP-001.zip")
//destroy lnv_http

end event

type cb_14 from commandbutton within w_test2
integer x = 2025
integer y = 836
integer width = 457
integer height = 132
integer taborder = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "download post"
end type

event clicked;//gnv_extfunc.pf_http_filedownload_post("http://211.39.220.218/powerframe/DownloadFile", "/SyncProject/iCerp", "common.pbd.z", "c:\temp\common.pbd.z")

end event

type cb_13 from commandbutton within w_test2
integer x = 343
integer y = 1604
integer width = 480
integer height = 132
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "w_download"
end type

event clicked;pf_n_httptransfer lnv_download

lnv_download = create pf_n_httptransfer
//lnv_download.of_http_upload("C:\Users\haan\Downloads\Penta - Appeon 2015 Keynote.pptx")
//lnv_download.of_http_download("APB-2013R2-OE-X32-UNX-AP-001.zip")

end event

type dw_1 from datawindow within w_test2
integer x = 1842
integer y = 112
integer width = 1303
integer height = 568
integer taborder = 30
string title = "none"
string dataobject = "d_code_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_test2
integer x = 896
integer y = 892
integer width = 507
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "rc="
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_test2
integer x = 1403
integer y = 892
integer width = 485
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_12 from commandbutton within w_test2
integer x = 366
integer y = 1276
integer width = 457
integer height = 132
integer taborder = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "close"
end type

event clicked;gnv_extfunc.pf_http_close()
gnv_extfunc.pf_http_globalcleanup()

end event

type cb_11 from commandbutton within w_test2
integer x = 366
integer y = 1124
integer width = 457
integer height = 132
integer taborder = 70
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "abort"
end type

event clicked;gnv_extfunc.pf_http_abort()

end event

type cb_10 from commandbutton within w_test2
integer x = 955
integer y = 1356
integer width = 457
integer height = 132
integer taborder = 70
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "download"
end type

event clicked;string ls_dl = "c:\temp\1.zip"

integer li_running, li_rc
long ll_cnter
double ld_dltotal, ld_dlnow
string ls_error

// item type of form field
constant int TYPE_PARAM = 0
constant int TYPE_FILE = 1
constant int HTTP_OK = 0

gnv_extfunc.pf_http_opendownload("http://localhost:8080/powerframe/FileDownload", "c:\temp\111.zip")
gnv_extfunc.pf_http_setpostfields("fileName=APB-2013R2-OE-X32-UNX-AP-001.zip")

li_running = gnv_extfunc.pf_http_send()
do while li_running = 1
	ld_dltotal = gnv_extfunc.pf_http_downloadprogress_total()
	ld_dlnow = gnv_extfunc.pf_http_downloadprogress_now()

	ll_cnter ++
	if mod(ll_cnter, 1000) = 0 then
		st_bytestotal.text = string(ld_dltotal, '#,##0')
		st_bytessent.text = string(ld_dlnow, '#,##0')
	end if
	
	yield()
	li_running = gnv_extfunc.pf_http_checkrunningstatus()
	st_running.text = string(li_running)
loop

li_rc = gnv_extfunc.pf_http_getresultcode()
if li_rc <> HTTP_OK then
	ls_error = gnv_extfunc.pf_http_geterrormessage(li_rc)
	messagebox('HTTP 알림(' + string(li_rc) + ')', ls_error)
end if

gnv_extfunc.pf_http_close()

end event

type st_bytessent from statictext within w_test2
integer x = 1417
integer y = 1172
integer width = 485
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_bytestotal from statictext within w_test2
integer x = 1417
integer y = 1076
integer width = 485
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_9 from commandbutton within w_test2
integer x = 343
integer y = 1440
integer width = 480
integer height = 132
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "w_upload"
end type

event clicked;pf_n_httptransfer lnv_upload

lnv_upload = create pf_n_httptransfer
//lnv_upload.of_http_upload("C:\Users\haan\Downloads\Penta - Appeon 2015 Keynote.pptx")
//lnv_upload.of_http_upload("D:\Downloads\APB-2013R2-OE-X32-UNX-AP-001.zip")

end event

type st_running from statictext within w_test2
integer x = 1417
integer y = 980
integer width = 485
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_1 from statictext within w_test2
integer x = 896
integer y = 980
integer width = 507
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "runningstatus="
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_8 from commandbutton within w_test2
integer x = 366
integer y = 964
integer width = 457
integer height = 132
integer taborder = 60
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "upload"
end type

event clicked;integer li_running, li_rc
long ll_cnter, ll_row
double ld_ultotal, ld_ulnow
string ls_error

constant int TYPE_PARAM = 0
constant int TYPE_FILE = 1
constant int HTTP_OK = 0

gnv_extfunc.pf_http_addformfield(TYPE_PARAM, "filename", "APB-2013R2-OE-X32-UNX-AP-001.zip")
gnv_extfunc.pf_http_addformfield(TYPE_FILE, "file1", "D:\Downloads\APB-2013R2-OE-X32-UNX-AP-001.zip")
gnv_extfunc.pf_http_openupload("http://localhost:8080/powerframe/FileUpload", "D:\Downloads\APB-2013R2-OE-X32-UNX-AP-001.zip")

li_running = gnv_extfunc.pf_http_send()
do while li_running = 1
	ld_ultotal = gnv_extfunc.pf_http_uploadprogress_total()
	ld_ulnow = gnv_extfunc.pf_http_uploadprogress_now()

	ll_cnter ++
	if mod(ll_cnter, 1000) = 0 then
		st_bytestotal.text = string(ld_ultotal, '#,##0')
		st_bytessent.text = string(ld_ulnow, '#,##0')
	end if
	
	yield()
	li_running = gnv_extfunc.pf_http_checkrunningstatus()
	st_running.text = string(li_running)
loop

li_rc = gnv_extfunc.pf_http_getresultcode()
if li_rc <> HTTP_OK then
	ls_error = gnv_extfunc.pf_http_geterrormessage(li_rc)
	messagebox('HTTP 알림(' + string(li_rc) + ')', ls_error)
end if

gnv_extfunc.pf_http_close()

end event

type cb_7 from commandbutton within w_test2
integer x = 366
integer y = 796
integer width = 457
integer height = 132
integer taborder = 60
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "upload"
end type

event clicked;//long ll_rc
//
//ll_rc = gnv_extfunc.pf_http_fileupload_post("http://localhost:8080/powerframe/FileUpload", "D:\Downloads\APB-2013R2-OE-X32-UNX-AP-001.zip")
//messagebox('done', ll_rc)


end event

type cb_6 from commandbutton within w_test2
integer x = 366
integer y = 644
integer width = 457
integer height = 132
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "download"
end type

event clicked;gnv_extfunc.pf_http_filedownload("http://localhost:8080/powerframe/FileDownload?fileName=NAS.png", "c:\temp\nas.png")

//gnv_extfunc.pf_http_filedownload("http://localhost:8080/images/prod_logo.png", "c:\temp\nas.png")
//gnv_extfunc.pf_http_filedownload("http://localhost:8080/images/prod_name.png", "c:\temp\prod_name.png")

gnv_extfunc.pf_http_filedownload("http://localhost:8080/powerframe/FileDownload?fileName=NAS.png", "c:\temp\nas.png")

end event

type cb_5 from commandbutton within w_test2
integer x = 1143
integer y = 692
integer width = 457
integer height = 132
integer taborder = 50
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "screen size"
end type

event clicked;constant int SM_CXVIRTUALSCREEN = 78
constant int SM_CYVIRTUALSCREEN = 79

long ll_width, ll_height

// The width of the virtual screen in pixels. The virtual screen is the bounding rectangle of all display monitors.
ll_width = gnv_extfunc.GetSystemMetrics(SM_CXVIRTUALSCREEN)

// The height of the virtual screen in pixels.
ll_height = gnv_extfunc.GetSystemMetrics(SM_CYVIRTUALSCREEN)

messagebox('The virtual screen size', 'Width=' + string(ll_width) + ", Height=" + string(ll_height))

end event

type cb_4 from commandbutton within w_test2
integer x = 1143
integer y = 540
integer width = 512
integer height = 132
integer taborder = 40
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "center popup"
end type

event clicked;open(w_resp01, parent)

end event

type cb_3 from commandbutton within w_test2
integer x = 1143
integer y = 388
integer width = 457
integer height = 132
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "date"
end type

event clicked;date ld_date

messagebox('ld_date', string(ld_date, 'yyyy-mm-dd'))


end event

type cb_2 from commandbutton within w_test2
integer x = 1143
integer y = 236
integer width = 457
integer height = 132
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "clipboard"
end type

event clicked;string ls_filename = 'c:\temp\clipboard.bmp'

if gnv_extfunc.pf_ClipboardToBitmap(ls_filename) > 0 then
	p_1.picturename = ls_filename
end if

end event

type cb_1 from commandbutton within w_test2
integer x = 1143
integer y = 68
integer width = 457
integer height = 132
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "SignPad"
end type

event clicked;//pf_n_clipboard lnv_clipboard
//lnv_clipboard = create pf_n_clipboard
//lnv_clipboard.of_getclipboardimage(p_1)

integer li_file, i
blob lb_contents
byte lb_byte
string ls_contents

li_file = fileopen("C:\파라다이스\UI디자인\oledata.bmp", StreamMode!, Read!, LockRead!)
filereadex(li_file, lb_contents)
fileclose(li_file)

for i = 1 to len(lb_contents)
	getbyte(lb_contents, i, lb_byte)
	ls_contents += of_convertbytetobinarystring(lb_byte)
	if mod(i, 50) = 0 then
		ls_contents += '~r~n'
	end if
next

::clipboard(ls_contents)

end event

type p_1 from picture within w_test2
integer x = 87
integer y = 56
integer width = 937
integer height = 484
boolean originalsize = true
boolean focusrectangle = false
end type

type cb_17 from commandbutton within w_test2
boolean visible = false
integer x = 2025
integer y = 1140
integer width = 457
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "RegularExp"
end type

event clicked;pf_n_regexp lnv_exp
string ls_exp[]

lnv_exp = create pf_n_regexp

messagebox('', lnv_exp.of_validate_email("zhaan@naver.com"))
messagebox('', lnv_exp.of_validate_url("https://eas.penta.co.kr/bbs"))
messagebox('', lnv_exp.of_validate_phonenumber("(010)3251-7212"))
messagebox('', lnv_exp.of_replaceall("dw_cond.table_name + '%'", "(\w+\.\w+)", "{$1}"))
messagebox('', lnv_exp.of_findmatches("dw_cond.table_name + '%'", "(\w+\.\w+)", ls_exp[]))
messagebox('', ls_exp[1])
//messagebox('', lnv_exp.of_replaceall("dw_cond.table_name + '%' + ", "(\w+\.\w+)", "{$1}"))
//messagebox('', lnv_exp.of_findmatches("dw_cond.table_name + '%' + ", "(\w+\.\w+)"))
//messagebox('', lnv_exp.of_replaceall("https://eas.penta.co.kr/bbs", "(\w+)", "[$1]"))
//messagebox('', lnv_exp.of_replaceall("https://eas.penta.co.kr/bbs", "\.[a-zA-Z]+", "$1"))

end event

type cb_18 from commandbutton within w_test2
integer x = 2025
integer y = 1316
integer width = 457
integer height = 132
integer taborder = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Toggle"
end type

event clicked;//gnv_extfunc.of_toggle_koreng('K')

end event

