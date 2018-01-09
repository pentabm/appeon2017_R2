HA$PBExportHeader$pf_w_home1.srw
$PBExportComments$$$HEX31$$5cb8f8ad78c72000c4d6200054ba78c7200054d674bad0c520005ccd08cd200014b5a4c20cd508b874c7200018b494b2200054d674ba200085c7c8b2e4b2$$ENDHEX$$. $$HEX41$$fcc85cb82000f5acc0c9acc06dd52000f1b420005cb8f8ad78c75cd52000acc0a9c690c7d0c58cac20004cc524b804c92000acc06dd5200004c7fcc85cb8200054d674ba74c720006cad31c129b4c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_home1 from pf_w_sheet
end type
type p_header from pf_u_picture within pf_w_home1
end type
type uo_notice from pf_u_board_ret_rte within pf_w_home1
end type
end forward

global type pf_w_home1 from pf_w_sheet
string title = "NOTICE"
p_header p_header
uo_notice uo_notice
end type
global pf_w_home1 pf_w_home1

on pf_w_home1.create
int iCurrent
call super::create
this.p_header=create p_header
this.uo_notice=create uo_notice
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_header
this.Control[iCurrent+2]=this.uo_notice
end on

on pf_w_home1.destroy
call super::destroy
destroy(this.p_header)
destroy(this.uo_notice)
end on

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_home1
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_home1
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_home1
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_home1
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_home1
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_home1
end type

type p_header from pf_u_picture within pf_w_home1
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

type uo_notice from pf_u_board_ret_rte within pf_w_home1
integer x = 50
integer y = 804
integer width = 4498
integer height = 1416
integer taborder = 20
boolean bringtotop = true
boolean scaletoright = true
boolean scaletobottom = true
end type

on uo_notice.destroy
call pf_u_board_ret_rte::destroy
end on

