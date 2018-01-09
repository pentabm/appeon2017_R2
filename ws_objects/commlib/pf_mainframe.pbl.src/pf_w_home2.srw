$PBExportHeader$pf_w_home2.srw
$PBExportComments$로그인 후 메인 화면에 최초 디스플레이 되는 화면 입니다. 주로 공지사항 등 로그인한 사용자에게 알려줄 사항 위주로 화면이 구성됩니다.
forward
global type pf_w_home2 from pf_w_sheet
end type
type p_header from pf_u_picture within pf_w_home2
end type
type uo_notice from pf_u_board_ret_rte within pf_w_home2
end type
end forward

global type pf_w_home2 from pf_w_sheet
string title = "WELCOME"
p_header p_header
uo_notice uo_notice
end type
global pf_w_home2 pf_w_home2

on pf_w_home2.create
int iCurrent
call super::create
this.p_header=create p_header
this.uo_notice=create uo_notice
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_header
this.Control[iCurrent+2]=this.uo_notice
end on

on pf_w_home2.destroy
call super::destroy
destroy(this.p_header)
destroy(this.uo_notice)
end on

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_home2
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_home2
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_home2
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_home2
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_home2
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_home2
end type

type p_header from pf_u_picture within pf_w_home2
integer x = 87
integer y = 64
integer width = 4434
integer height = 688
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\mainframe\w_home1\w_home_header.jpg"
end type

event resize;call super::resize;//p_header.x = (parent.width - p_header.width) / 2

end event

type uo_notice from pf_u_board_ret_rte within pf_w_home2
integer x = 50
integer y = 804
integer width = 4498
integer height = 1416
integer taborder = 30
boolean bringtotop = true
boolean scaletoright = true
boolean scaletobottom = true
end type

on uo_notice.destroy
call pf_u_board_ret_rte::destroy
end on

