$PBExportHeader$pf_w_httpupload.srw
$PBExportComments$HTTP 파일 업로드 윈도우
forward
global type pf_w_httpupload from window
end type
type st_bytessent_sum from statictext within pf_w_httpupload
end type
type st_bytestotal_sum from statictext within pf_w_httpupload
end type
type st_3 from statictext within pf_w_httpupload
end type
type cb_close from commandbutton within pf_w_httpupload
end type
type st_4 from statictext within pf_w_httpupload
end type
type st_2 from statictext within pf_w_httpupload
end type
type hpb_file from hprogressbar within pf_w_httpupload
end type
type st_1 from statictext within pf_w_httpupload
end type
type st_bytestotal from statictext within pf_w_httpupload
end type
type st_bytessent from statictext within pf_w_httpupload
end type
type st_msg from statictext within pf_w_httpupload
end type
type hpb_total from hprogressbar within pf_w_httpupload
end type
type st_title from statictext within pf_w_httpupload
end type
type dw_filelist from pf_u_datawindow within pf_w_httpupload
end type
end forward

global type pf_w_httpupload from window
integer width = 1614
integer height = 1672
boolean titlebar = true
string title = "HTTP File Transfer"
boolean minbox = true
windowtype windowtype = popup!
boolean center = true
st_bytessent_sum st_bytessent_sum
st_bytestotal_sum st_bytestotal_sum
st_3 st_3
cb_close cb_close
st_4 st_4
st_2 st_2
hpb_file hpb_file
st_1 st_1
st_bytestotal st_bytestotal
st_bytessent st_bytessent
st_msg st_msg
hpb_total hpb_total
st_title st_title
dw_filelist dw_filelist
end type
global pf_w_httpupload pf_w_httpupload

type variables
public:
	boolean ib_cancel

end variables

on pf_w_httpupload.create
this.st_bytessent_sum=create st_bytessent_sum
this.st_bytestotal_sum=create st_bytestotal_sum
this.st_3=create st_3
this.cb_close=create cb_close
this.st_4=create st_4
this.st_2=create st_2
this.hpb_file=create hpb_file
this.st_1=create st_1
this.st_bytestotal=create st_bytestotal
this.st_bytessent=create st_bytessent
this.st_msg=create st_msg
this.hpb_total=create hpb_total
this.st_title=create st_title
this.dw_filelist=create dw_filelist
this.Control[]={this.st_bytessent_sum,&
this.st_bytestotal_sum,&
this.st_3,&
this.cb_close,&
this.st_4,&
this.st_2,&
this.hpb_file,&
this.st_1,&
this.st_bytestotal,&
this.st_bytessent,&
this.st_msg,&
this.hpb_total,&
this.st_title,&
this.dw_filelist}
end on

on pf_w_httpupload.destroy
destroy(this.st_bytessent_sum)
destroy(this.st_bytestotal_sum)
destroy(this.st_3)
destroy(this.cb_close)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.hpb_file)
destroy(this.st_1)
destroy(this.st_bytestotal)
destroy(this.st_bytessent)
destroy(this.st_msg)
destroy(this.hpb_total)
destroy(this.st_title)
destroy(this.dw_filelist)
end on

type st_bytessent_sum from statictext within pf_w_httpupload
integer x = 827
integer y = 312
integer width = 343
integer height = 56
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
alignment alignment = right!
boolean focusrectangle = false
end type

type st_bytestotal_sum from statictext within pf_w_httpupload
integer x = 1243
integer y = 312
integer width = 343
integer height = 56
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within pf_w_httpupload
integer x = 1166
integer y = 312
integer width = 82
integer height = 56
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_close from commandbutton within pf_w_httpupload
integer x = 1312
integer y = 24
integer width = 274
integer height = 108
integer taborder = 10
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "Close"
end type

event clicked;choose case this.text
	case 'Close'
		close(parent)
	case 'Cancel'
		ib_cancel = true
end choose

end event

type st_4 from statictext within pf_w_httpupload
integer x = 37
integer y = 160
integer width = 457
integer height = 64
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "File Progress"
boolean focusrectangle = false
end type

type st_2 from statictext within pf_w_httpupload
integer x = 37
integer y = 308
integer width = 475
integer height = 64
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "Total Progress"
boolean focusrectangle = false
end type

type hpb_file from hprogressbar within pf_w_httpupload
integer x = 32
integer y = 228
integer width = 1554
integer height = 68
unsignedinteger minposition = 1
unsignedinteger maxposition = 100
integer setstep = 1
boolean smoothscroll = true
end type

type st_1 from statictext within pf_w_httpupload
integer x = 1166
integer y = 164
integer width = 82
integer height = 56
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_bytestotal from statictext within pf_w_httpupload
integer x = 1243
integer y = 164
integer width = 343
integer height = 56
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
alignment alignment = right!
boolean focusrectangle = false
end type

type st_bytessent from statictext within pf_w_httpupload
integer x = 827
integer y = 164
integer width = 343
integer height = 56
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
alignment alignment = right!
boolean focusrectangle = false
end type

type st_msg from statictext within pf_w_httpupload
integer x = 32
integer y = 1500
integer width = 1554
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
long backcolor = 32896501
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type hpb_total from hprogressbar within pf_w_httpupload
integer x = 32
integer y = 376
integer width = 1554
integer height = 68
unsignedinteger minposition = 1
unsignedinteger maxposition = 100
integer setstep = 1
boolean smoothscroll = true
end type

type st_title from statictext within pf_w_httpupload
integer x = 32
integer y = 24
integer width = 1554
integer height = 108
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 20066866
long backcolor = 32896501
string text = "UPLOAD Status"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_filelist from pf_u_datawindow within pf_w_httpupload
integer x = 32
integer y = 468
integer width = 1554
integer height = 1020
integer taborder = 10
string dataobject = "pf_d_httptransfer"
boolean vscrollbar = true
end type

