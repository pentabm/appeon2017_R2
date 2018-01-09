$PBExportHeader$w_basic.srw
$PBExportComments$기본윈도우-상속용
forward
global type w_basic from pf_w_sheet
end type
type st_title from statictext within w_basic
end type
type pb_close from pf_u_imagebutton within w_basic
end type
type p_thelp from pf_u_imagebutton within w_basic
end type
type p_tfavor from pf_u_imagebutton within w_basic
end type
end forward

global type w_basic from pf_w_sheet
integer width = 3726
integer height = 2732
st_title st_title
pb_close pb_close
p_thelp p_thelp
p_tfavor p_tfavor
end type
global w_basic w_basic

type variables

end variables

on w_basic.create
int iCurrent
call super::create
this.st_title=create st_title
this.pb_close=create pb_close
this.p_thelp=create p_thelp
this.p_tfavor=create p_tfavor
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_title
this.Control[iCurrent+2]=this.pb_close
this.Control[iCurrent+3]=this.p_thelp
this.Control[iCurrent+4]=this.p_tfavor
end on

on w_basic.destroy
call super::destroy
destroy(this.st_title)
destroy(this.pb_close)
destroy(this.p_thelp)
destroy(this.p_tfavor)
end on

event pfe_postopen;call super::pfe_postopen;// Program Path를 표시 합니다
pf_n_rolemenu lnv_menu
lnv_menu = create pf_n_rolemenu
string ls_pgmno, ls_pgmpath

ls_pgmpath = lnv_menu.of_getpgmpath(this.of_getpgmno())
if isnull(ls_pgmpath) or ls_pgmpath = '' then
	ls_pgmpath = inv_menu.is_pgm_name
end if

st_title.text = ls_pgmpath + ' (' + this.classname() + ')'

end event

type ln_templeft from pf_w_sheet`ln_templeft within w_basic
integer beginx = 32
integer endx = 32
integer endy = 2640
end type

type ln_tempright from pf_w_sheet`ln_tempright within w_basic
integer beginx = 3662
integer endx = 3662
integer endy = 2640
end type

type ln_temptop from pf_w_sheet`ln_temptop within w_basic
integer beginy = 20
integer endy = 20
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within w_basic
integer beginy = 2596
integer endy = 2596
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within w_basic
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within w_basic
end type

type st_title from statictext within w_basic
integer x = 270
integer y = 36
integer width = 2254
integer height = 72
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 27040924
long backcolor = 16777215
boolean focusrectangle = false
end type

type pb_close from pf_u_imagebutton within w_basic
integer x = 3429
integer y = 28
integer width = 233
integer height = 88
integer taborder = 80
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)

end event

type p_thelp from pf_u_imagebutton within w_basic
integer x = 37
integer y = 28
integer width = 96
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_help.gif"
string powertiptext = "프로그램 도움말"
end type

event clicked;call super::clicked;openwithparm(pf_w_pgm_help_ent, inv_menu)

end event

type p_tfavor from pf_u_imagebutton within w_basic
integer x = 146
integer y = 28
integer width = 96
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_favor.gif"
string powertiptext = "즐겨찾기 추가"
end type

event clicked;call super::clicked;if not isvalid(inv_menu) then
	messagebox('알림', '메뉴 등록되지 않은 프로그램은 즐겨찾기 할 수 없습니다')
	return
end if

openwithparm(pf_w_favorite, inv_menu)
if message.stringparm = 'OK' then
	pf_n_hashtable lnvo_param
	lnvo_param = create pf_n_hashtable
	iw_parent.dynamic of_eventdispatcher('pf_u_mainframe_left_favorite', 'ue_refreshmenu', lnvo_param)
end if

end event

