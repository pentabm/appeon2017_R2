$PBExportHeader$pf_w_example_fileupdownload.srw
forward
global type pf_w_example_fileupdownload from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_fileupdownload
end type
type cb_1 from commandbutton within pf_w_example_fileupdownload
end type
type st_1 from statictext within pf_w_example_fileupdownload
end type
type sle_uploadurl from singlelineedit within pf_w_example_fileupdownload
end type
type st_2 from statictext within pf_w_example_fileupdownload
end type
type sle_uploadsubdir from singlelineedit within pf_w_example_fileupdownload
end type
type st_3 from statictext within pf_w_example_fileupdownload
end type
type sle_uploadfile from singlelineedit within pf_w_example_fileupdownload
end type
type cb_2 from commandbutton within pf_w_example_fileupdownload
end type
type st_4 from statictext within pf_w_example_fileupdownload
end type
type st_5 from statictext within pf_w_example_fileupdownload
end type
type st_6 from statictext within pf_w_example_fileupdownload
end type
type sle_downloadurl from singlelineedit within pf_w_example_fileupdownload
end type
type st_7 from statictext within pf_w_example_fileupdownload
end type
type sle_downloadsubdir from singlelineedit within pf_w_example_fileupdownload
end type
type st_8 from statictext within pf_w_example_fileupdownload
end type
type sle_downloadfile from singlelineedit within pf_w_example_fileupdownload
end type
type cb_3 from commandbutton within pf_w_example_fileupdownload
end type
end forward

global type pf_w_example_fileupdownload from pf_w_sheet
string title = "파일 업/다운로드 샘플 윈도우"
cb_close cb_close
cb_1 cb_1
st_1 st_1
sle_uploadurl sle_uploadurl
st_2 st_2
sle_uploadsubdir sle_uploadsubdir
st_3 st_3
sle_uploadfile sle_uploadfile
cb_2 cb_2
st_4 st_4
st_5 st_5
st_6 st_6
sle_downloadurl sle_downloadurl
st_7 st_7
sle_downloadsubdir sle_downloadsubdir
st_8 st_8
sle_downloadfile sle_downloadfile
cb_3 cb_3
end type
global pf_w_example_fileupdownload pf_w_example_fileupdownload

type variables

end variables

on pf_w_example_fileupdownload.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_uploadurl=create sle_uploadurl
this.st_2=create st_2
this.sle_uploadsubdir=create sle_uploadsubdir
this.st_3=create st_3
this.sle_uploadfile=create sle_uploadfile
this.cb_2=create cb_2
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.sle_downloadurl=create sle_downloadurl
this.st_7=create st_7
this.sle_downloadsubdir=create sle_downloadsubdir
this.st_8=create st_8
this.sle_downloadfile=create sle_downloadfile
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_uploadurl
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.sle_uploadsubdir
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.sle_uploadfile
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.sle_downloadurl
this.Control[iCurrent+14]=this.st_7
this.Control[iCurrent+15]=this.sle_downloadsubdir
this.Control[iCurrent+16]=this.st_8
this.Control[iCurrent+17]=this.sle_downloadfile
this.Control[iCurrent+18]=this.cb_3
end on

on pf_w_example_fileupdownload.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_uploadurl)
destroy(this.st_2)
destroy(this.sle_uploadsubdir)
destroy(this.st_3)
destroy(this.sle_uploadfile)
destroy(this.cb_2)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.sle_downloadurl)
destroy(this.st_7)
destroy(this.sle_downloadsubdir)
destroy(this.st_8)
destroy(this.sle_downloadfile)
destroy(this.cb_3)
end on

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_fileupdownload
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_fileupdownload
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_fileupdownload
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_fileupdownload
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_fileupdownload
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_fileupdownload
end type

type cb_close from pf_u_commandbutton within pf_w_example_fileupdownload
integer x = 4279
integer y = 32
integer width = 274
integer height = 96
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = hangeul!
string text = "닫기"
string powertiptext = "해당 화면을 닫습니다."
boolean applydesign = false
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)
end event

type cb_1 from commandbutton within pf_w_example_fileupdownload
integer x = 457
integer y = 1348
integer width = 430
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "Upload"
end type

event clicked;string ls_serverurl, ls_subdir, ls_filename

ls_serverurl = sle_uploadurl.text
ls_subdir = sle_uploadsubdir.text
ls_filename = sle_uploadfile.text

if pf_f_isemptystring(ls_serverurl) then
	messagebox('알림', '서버 URL 정보를 입력하세요')
	return
end if

if pf_f_isemptystring(ls_subdir) then
	messagebox('알림', '업로드 SUbDirectory 정보를 입력하세요')
	return
end if

if pf_f_isemptystring(ls_filename) then
	messagebox('알림', '업로드할 파일을 선택하세요')
	return
end if

pf_n_httptransfer lnv_http
string ls_uploaded
integer li_rc

ls_uploaded = ls_filename

lnv_http = create pf_n_httptransfer
li_rc = lnv_http.of_fileupload(ls_uploaded, ls_serverurl, ls_subdir, false)
if li_rc < 0 then
	messagebox('알림', '업로드 실패~r~nRetCode=' + string(li_rc))
else
	sle_downloadfile.text = ls_uploaded
end if

destroy lnv_http

end event

type st_1 from statictext within pf_w_example_fileupdownload
integer x = 384
integer y = 700
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "▶ Server URL : "
boolean focusrectangle = false
end type

type sle_uploadurl from singlelineedit within pf_w_example_fileupdownload
integer x = 457
integer y = 776
integer width = 1298
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string text = "http://localhost:8080/pfservices/FileUpload"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within pf_w_example_fileupdownload
integer x = 384
integer y = 900
integer width = 475
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "▶ Sub Directory : "
boolean focusrectangle = false
end type

type sle_uploadsubdir from singlelineedit within pf_w_example_fileupdownload
integer x = 457
integer y = 976
integer width = 1079
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string text = "example/phase1"
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within pf_w_example_fileupdownload
integer x = 384
integer y = 1108
integer width = 750
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "▶ Filename to be uploaded : "
boolean focusrectangle = false
end type

type sle_uploadfile from singlelineedit within pf_w_example_fileupdownload
integer x = 457
integer y = 1188
integer width = 1687
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
long backcolor = 67108864
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within pf_w_example_fileupdownload
integer x = 2153
integer y = 1180
integer width = 110
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "..."
end type

event clicked;string ls_path, ls_file

if GetFileOpenName ("Open", ls_path, ls_file, "*",  "All Files (*.*),*.*" , "", 512) < 1 then return
sle_uploadfile.text = ls_path
return

end event

type st_4 from statictext within pf_w_example_fileupdownload
integer x = 389
integer y = 544
integer width = 581
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "HTTP 파일 업로드"
boolean focusrectangle = false
end type

type st_5 from statictext within pf_w_example_fileupdownload
integer x = 2496
integer y = 544
integer width = 649
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "HTTP 파일 다운로드"
boolean focusrectangle = false
end type

type st_6 from statictext within pf_w_example_fileupdownload
integer x = 2496
integer y = 700
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "▶ Server URL : "
boolean focusrectangle = false
end type

type sle_downloadurl from singlelineedit within pf_w_example_fileupdownload
integer x = 2569
integer y = 776
integer width = 1298
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string text = "http://localhost:8080/pfservices/FileDownload"
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within pf_w_example_fileupdownload
integer x = 2496
integer y = 900
integer width = 475
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "▶ Sub Directory : "
boolean focusrectangle = false
end type

type sle_downloadsubdir from singlelineedit within pf_w_example_fileupdownload
integer x = 2569
integer y = 976
integer width = 1079
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string text = "example/phase1"
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within pf_w_example_fileupdownload
integer x = 2496
integer y = 1108
integer width = 773
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "▶ Filename to be downloaded"
boolean focusrectangle = false
end type

type sle_downloadfile from singlelineedit within pf_w_example_fileupdownload
integer x = 2569
integer y = 1188
integer width = 1298
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within pf_w_example_fileupdownload
integer x = 2569
integer y = 1348
integer width = 430
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "Download"
end type

event clicked;string ls_serverurl, ls_subdir, ls_filename
integer li_rc

ls_serverurl = sle_downloadurl.text
ls_subdir = sle_downloadsubdir.text
ls_filename = sle_downloadfile.text

if pf_f_isemptystring(ls_serverurl) then
	messagebox('알림', '다운로드 서버 URL 정보를 입력하세요')
	return
end if

if pf_f_isemptystring(ls_subdir) then
	messagebox('알림', '다운로드 SUbDirectory 정보를 입력하세요')
	return
end if

if pf_f_isemptystring(ls_filename) then
	messagebox('알림', '다운로드할 파일명을 입력하세요')
	return
end if

pf_n_httptransfer lnv_http

lnv_http = create pf_n_httptransfer
li_rc = lnv_http.of_filedownload(ls_filename, ls_serverurl, ls_subdir, '')
if li_rc < 0 then
	messagebox('알림', '다운로드 실패~r~nRetCode=' + string(li_rc))
end if

destroy lnv_http

end event

