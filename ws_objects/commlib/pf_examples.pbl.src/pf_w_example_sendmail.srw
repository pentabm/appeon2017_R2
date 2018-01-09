$PBExportHeader$pf_w_example_sendmail.srw
forward
global type pf_w_example_sendmail from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_sendmail
end type
type st_1 from statictext within pf_w_example_sendmail
end type
type sle_server from singlelineedit within pf_w_example_sendmail
end type
type st_4 from statictext within pf_w_example_sendmail
end type
type uo_editor from pf_u_webeditor within pf_w_example_sendmail
end type
type cb_reset from commandbutton within pf_w_example_sendmail
end type
type st_5 from statictext within pf_w_example_sendmail
end type
type sle_from_user_name from singlelineedit within pf_w_example_sendmail
end type
type sle_from_addr from singlelineedit within pf_w_example_sendmail
end type
type st_7 from statictext within pf_w_example_sendmail
end type
type sle_to_addr from singlelineedit within pf_w_example_sendmail
end type
type st_8 from statictext within pf_w_example_sendmail
end type
type sle_subject from singlelineedit within pf_w_example_sendmail
end type
type st_9 from statictext within pf_w_example_sendmail
end type
type mle_content from multilineedit within pf_w_example_sendmail
end type
type cb_send from commandbutton within pf_w_example_sendmail
end type
type rb_html from radiobutton within pf_w_example_sendmail
end type
type rb_text from radiobutton within pf_w_example_sendmail
end type
type sle_uploadfile from singlelineedit within pf_w_example_sendmail
end type
type cb_2 from commandbutton within pf_w_example_sendmail
end type
type sle_uploadfile2 from singlelineedit within pf_w_example_sendmail
end type
type cb_4 from commandbutton within pf_w_example_sendmail
end type
type st_2 from statictext within pf_w_example_sendmail
end type
end forward

global type pf_w_example_sendmail from pf_w_sheet
integer width = 4649
integer height = 2632
string title = "Mail 전송 예제"
cb_close cb_close
st_1 st_1
sle_server sle_server
st_4 st_4
uo_editor uo_editor
cb_reset cb_reset
st_5 st_5
sle_from_user_name sle_from_user_name
sle_from_addr sle_from_addr
st_7 st_7
sle_to_addr sle_to_addr
st_8 st_8
sle_subject sle_subject
st_9 st_9
mle_content mle_content
cb_send cb_send
rb_html rb_html
rb_text rb_text
sle_uploadfile sle_uploadfile
cb_2 cb_2
sle_uploadfile2 sle_uploadfile2
cb_4 cb_4
st_2 st_2
end type
global pf_w_example_sendmail pf_w_example_sendmail

type variables

end variables

on pf_w_example_sendmail.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_1=create st_1
this.sle_server=create sle_server
this.st_4=create st_4
this.uo_editor=create uo_editor
this.cb_reset=create cb_reset
this.st_5=create st_5
this.sle_from_user_name=create sle_from_user_name
this.sle_from_addr=create sle_from_addr
this.st_7=create st_7
this.sle_to_addr=create sle_to_addr
this.st_8=create st_8
this.sle_subject=create sle_subject
this.st_9=create st_9
this.mle_content=create mle_content
this.cb_send=create cb_send
this.rb_html=create rb_html
this.rb_text=create rb_text
this.sle_uploadfile=create sle_uploadfile
this.cb_2=create cb_2
this.sle_uploadfile2=create sle_uploadfile2
this.cb_4=create cb_4
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_server
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.uo_editor
this.Control[iCurrent+6]=this.cb_reset
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.sle_from_user_name
this.Control[iCurrent+9]=this.sle_from_addr
this.Control[iCurrent+10]=this.st_7
this.Control[iCurrent+11]=this.sle_to_addr
this.Control[iCurrent+12]=this.st_8
this.Control[iCurrent+13]=this.sle_subject
this.Control[iCurrent+14]=this.st_9
this.Control[iCurrent+15]=this.mle_content
this.Control[iCurrent+16]=this.cb_send
this.Control[iCurrent+17]=this.rb_html
this.Control[iCurrent+18]=this.rb_text
this.Control[iCurrent+19]=this.sle_uploadfile
this.Control[iCurrent+20]=this.cb_2
this.Control[iCurrent+21]=this.sle_uploadfile2
this.Control[iCurrent+22]=this.cb_4
this.Control[iCurrent+23]=this.st_2
end on

on pf_w_example_sendmail.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.sle_server)
destroy(this.st_4)
destroy(this.uo_editor)
destroy(this.cb_reset)
destroy(this.st_5)
destroy(this.sle_from_user_name)
destroy(this.sle_from_addr)
destroy(this.st_7)
destroy(this.sle_to_addr)
destroy(this.st_8)
destroy(this.sle_subject)
destroy(this.st_9)
destroy(this.mle_content)
destroy(this.cb_send)
destroy(this.rb_html)
destroy(this.rb_text)
destroy(this.sle_uploadfile)
destroy(this.cb_2)
destroy(this.sle_uploadfile2)
destroy(this.cb_4)
destroy(this.st_2)
end on

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_sendmail
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_sendmail
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_sendmail
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_sendmail
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_sendmail
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_sendmail
end type

type cb_close from pf_u_commandbutton within pf_w_example_sendmail
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

type st_1 from statictext within pf_w_example_sendmail
integer x = 727
integer y = 56
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

type sle_server from singlelineedit within pf_w_example_sendmail
integer x = 1125
integer y = 40
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
string text = "http://localhost:8080/pfservices/SendMailServlet"
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within pf_w_example_sendmail
integer x = 64
integer y = 44
integer width = 581
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "Mail 전송 예제"
boolean focusrectangle = false
end type

type uo_editor from pf_u_webeditor within pf_w_example_sendmail
event destroy ( )
integer x = 137
integer y = 716
integer width = 4425
integer height = 1804
integer taborder = 30
boolean bringtotop = true
string binarykey = "pf_w_example_sendmail.win"
boolean scaletoright = true
boolean scaletobottom = true
string editor_url = "http://localhost:8080/smarteditor/SmartEditor2_editor.html"
string viewer_url = "http://localhost:8080/smarteditor/SmartEditor2_viewer.html"
end type

on uo_editor.destroy
call pf_u_webeditor::destroy
end on

event pfe_postopen;call super::pfe_postopen;// Editor 페이지 오픈
//uo_editor.of_seteditorurl("http://hrin.skhystec.com/smarteditor/SmartEditor2_editor.html")
uo_editor.of_seteditorurl("http://localhost:8080/smarteditor/SmartEditor2_editor.html")
uo_editor.of_openwebeditor()
end event

type cb_reset from commandbutton within pf_w_example_sendmail
integer x = 4279
integer y = 600
integer width = 247
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "Reset"
end type

event clicked;uo_editor.of_resetcontents()

end event

type st_5 from statictext within pf_w_example_sendmail
integer x = 82
integer y = 192
integer width = 439
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "▶ 보내는 사람 : "
boolean focusrectangle = false
end type

type sle_from_user_name from singlelineedit within pf_w_example_sendmail
integer x = 539
integer y = 176
integer width = 823
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
string text = "BM팀"
borderstyle borderstyle = stylelowered!
end type

type sle_from_addr from singlelineedit within pf_w_example_sendmail
integer x = 1362
integer y = 176
integer width = 1170
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
string text = "bm@penta.co.kr"
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within pf_w_example_sendmail
integer x = 82
integer y = 300
integer width = 439
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "▶ 받는 사람 ... : "
boolean focusrectangle = false
end type

type sle_to_addr from singlelineedit within pf_w_example_sendmail
integer x = 539
integer y = 284
integer width = 3895
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
string text = "jwchoi@penta.co.kr"
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within pf_w_example_sendmail
integer x = 82
integer y = 408
integer width = 439
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "▶ 제목 : "
boolean focusrectangle = false
end type

type sle_subject from singlelineedit within pf_w_example_sendmail
integer x = 539
integer y = 392
integer width = 3890
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
string text = "메일 테스트 입니다"
borderstyle borderstyle = stylelowered!
end type

type st_9 from statictext within pf_w_example_sendmail
integer x = 82
integer y = 624
integer width = 439
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "▶ 내용 : "
boolean focusrectangle = false
end type

type mle_content from multilineedit within pf_w_example_sendmail
boolean visible = false
integer x = 142
integer y = 724
integer width = 4398
integer height = 1740
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string text = "테스트 메일 본문 입니다."
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_send from commandbutton within pf_w_example_sendmail
integer x = 3867
integer y = 32
integer width = 402
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "전송"
end type

event clicked;
string ls_serverurl, ls_from_user_name, ls_from_addr, ls_to_addr
string ls_subject, ls_content

ls_serverurl			= sle_server.text
ls_from_user_name	= sle_from_user_name.text
ls_from_addr			= sle_from_addr.text
ls_to_addr				= sle_to_addr.text
ls_subject				= sle_subject.text

pf_n_cryptoapi 		lnv_crypto

if rb_html.checked = true then
	ls_content			= lnv_crypto.of_encode64( uo_editor.of_getcontents_blob() )
else
	ls_content			= lnv_crypto.of_encode64( blob( mle_content.text, EncodingUTF8! ) )
end if

//::clipboard( ls_content )

if pf_f_isemptystring(ls_serverurl) then
	messagebox('알림', '서버 URL 정보를 입력하세요')
	return
end if

// 파일 첨부.
string ls_filename
string	ls_upload_files[]

ls_filename = sle_uploadfile.text
if pf_f_isemptystring(ls_filename) then
//	messagebox('알림', '업로드할 파일을 선택하세요')
//	return
else
	ls_upload_files[1] = ls_filename
end if

ls_filename = sle_uploadfile2.text
if pf_f_isemptystring(ls_filename) then
	//messagebox('알림', '업로드할 파일을 선택하세요')
	//return
else
	ls_upload_files[2] = ls_filename
end if


//pf_n_httptransfer lnv_http
//string ls_uploaded
//integer li_rc
//
//
//lnv_http = create pf_n_httptransfer
//li_rc = lnv_http.of_fileupload( ls_upload_files, ls_serverurl, ls_subdir, true)
//if li_rc < 0 then
//////////////////////////////////



pf_n_httptransfer lnv_http
integer li_rc


lnv_http = create pf_n_httptransfer

if UpperBound( ls_upload_files ) > 0 then
	li_rc = lnv_http.of_sendmail( ls_serverurl, ls_from_user_name, ls_from_addr, ls_to_addr, ls_subject, ls_content, ls_upload_files )
else
	li_rc = lnv_http.of_sendmail( ls_serverurl, ls_from_user_name, ls_from_addr, ls_to_addr, ls_subject, ls_content )
end if
//li_rc = lnv_http.of_fileupload(ls_uploaded, ls_serverurl, ls_subdir, false)
if li_rc < 0 then
	messagebox('알림', '메일 전송 실패~r~nRetCode=' + string(li_rc))
else
	messagebox('알림', '메일 전송 성공')
end if

destroy lnv_http

end event

type rb_html from radiobutton within pf_w_example_sendmail
integer x = 553
integer y = 616
integer width = 265
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "HTML"
boolean checked = true
end type

event clicked;
uo_editor.Visible = True
cb_reset.Visible = True
mle_content.Visible = False
end event

type rb_text from radiobutton within pf_w_example_sendmail
integer x = 841
integer y = 616
integer width = 265
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "TEXT"
end type

event clicked;
uo_editor.Visible = False
cb_reset.Visible = False
mle_content.Visible = True


end event

type sle_uploadfile from singlelineedit within pf_w_example_sendmail
integer x = 539
integer y = 492
integer width = 1792
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
long backcolor = 67108864
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within pf_w_example_sendmail
integer x = 2336
integer y = 492
integer width = 110
integer height = 92
integer taborder = 50
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

if GetFileOpenName ("Open", ls_path, ls_file, "*",  "All Files (*.*),*.*" , "", 18) < 1 then return
sle_uploadfile.text = ls_path
return

end event

type sle_uploadfile2 from singlelineedit within pf_w_example_sendmail
integer x = 2473
integer y = 492
integer width = 1842
integer height = 92
integer taborder = 60
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

type cb_4 from commandbutton within pf_w_example_sendmail
integer x = 4315
integer y = 492
integer width = 110
integer height = 92
integer taborder = 60
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

if GetFileOpenName ("Open", ls_path, ls_file, "*",  "All Files (*.*),*.*" , "", 18) < 1 then return
sle_uploadfile2.text = ls_path
return

end event

type st_2 from statictext within pf_w_example_sendmail
integer x = 82
integer y = 488
integer width = 439
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "▶ 파일첨부 : "
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Apf_w_example_sendmail.bin 
2000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000d16712f001d265a800000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000d16712f001d265a8d16712f001d265a8000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Affffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c0000640c00002e9d0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c0000640c00002e9d0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Apf_w_example_sendmail.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
