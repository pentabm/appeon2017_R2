HA$PBExportHeader$pf_w_pgm_help_ent.srw
$PBExportComments$$$HEX18$$04d55cb8f8ada8b72000c4b3c0c6d0b9200000adacb9200054d674ba200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_pgm_help_ent from pf_w_response
end type
type st_6 from statictext within pf_w_pgm_help_ent
end type
type st_5 from statictext within pf_w_pgm_help_ent
end type
type st_4 from statictext within pf_w_pgm_help_ent
end type
type p_2 from picture within pf_w_pgm_help_ent
end type
type p_save from pf_u_imagebutton within pf_w_pgm_help_ent
end type
type cb_modify from pf_u_commandbutton within pf_w_pgm_help_ent
end type
type dw_list from pf_u_datawindow within pf_w_pgm_help_ent
end type
type p_close from pf_u_imagebutton within pf_w_pgm_help_ent
end type
type dw_mast from pf_u_datawindow within pf_w_pgm_help_ent
end type
type rte_content from pf_u_richtextedit within pf_w_pgm_help_ent
end type
type st_3 from statictext within pf_w_pgm_help_ent
end type
type st_2 from statictext within pf_w_pgm_help_ent
end type
type st_1 from statictext within pf_w_pgm_help_ent
end type
type rr_border from roundrectangle within pf_w_pgm_help_ent
end type
end forward

global type pf_w_pgm_help_ent from pf_w_response
integer width = 4485
integer height = 2616
string title = "$$HEX11$$04d55cb8f8ada8b72000c4b3c0c6d0b92000f1b45db8$$ENDHEX$$"
st_6 st_6
st_5 st_5
st_4 st_4
p_2 p_2
p_save p_save
cb_modify cb_modify
dw_list dw_list
p_close p_close
dw_mast dw_mast
rte_content rte_content
st_3 st_3
st_2 st_2
st_1 st_1
rr_border rr_border
end type
global pf_w_pgm_help_ent pf_w_pgm_help_ent

type variables
pf_n_menudata inv_menuparam

end variables

on pf_w_pgm_help_ent.create
int iCurrent
call super::create
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.p_2=create p_2
this.p_save=create p_save
this.cb_modify=create cb_modify
this.dw_list=create dw_list
this.p_close=create p_close
this.dw_mast=create dw_mast
this.rte_content=create rte_content
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.rr_border=create rr_border
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_6
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.p_2
this.Control[iCurrent+5]=this.p_save
this.Control[iCurrent+6]=this.cb_modify
this.Control[iCurrent+7]=this.dw_list
this.Control[iCurrent+8]=this.p_close
this.Control[iCurrent+9]=this.dw_mast
this.Control[iCurrent+10]=this.rte_content
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.rr_border
end on

on pf_w_pgm_help_ent.destroy
call super::destroy
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.p_2)
destroy(this.p_save)
destroy(this.cb_modify)
destroy(this.dw_list)
destroy(this.p_close)
destroy(this.dw_mast)
destroy(this.rte_content)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rr_border)
end on

event open;if not isvalid(message.powerobjectparm) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX13$$98c7bbba1cb4200008c7c4b3b0c6200038d69ccd85c7c8b2e4b2$$ENDHEX$$')
	post close(this)
	return
end if

if message.powerobjectparm.classname() <> 'pf_n_menudata' then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX13$$98c7bbba1cb4200008c7c4b3b0c6200038d69ccd85c7c8b2e4b2$$ENDHEX$$')
	post close(this)
	return
end if

inv_menuparam = message.powerobjectparm

dw_mast.insertrow(0)
dw_mast.setitem(1, 'menu_id', inv_menuparam.is_menu_id)
dw_mast.setitem(1, 'pgm_id', inv_menuparam.is_pgm_id)
dw_mast.setitem(1, 'pgm_name', inv_menuparam.is_pgm_name)

dw_list.settransobject(sqlca)
dw_list.retrieve(gnv_session.is_sys_id, inv_menuparam.is_menu_id)

end event

event pfe_postopen;call super::pfe_postopen;//dw_mast.settransobject(sqlca)
//dw_attach.settransobject(sqlca)
//
//blob lb_content
//long ll_read_seq
//string ls_user_id, ls_errtext
//
//if dw_mast.retrieve(gnv_session.is_sys_id, is_board_no, is_docu_no) > 0 then
//	selectblob	docu_content
//	into		:lb_content
//	from		pf_docu_mst
//	where	sys_id = :gnv_session.is_sys_id
//	and		board_no = :is_board_no
//	and		docu_no = :is_docu_no
//	using		sqlca;
//	
//	if sqlca.sqlcode = 0 then
//		if is_log_yn = 'Y' then
//			select		max(read_seq)
//			into		:ll_read_seq
//			from		pf_docu_log
//			where	sys_id = :gnv_session.is_sys_id
//			and		board_no = :is_board_no
//			and		docu_no = :is_docu_no
//			using		sqlca;
//			
//			if isnull(ll_read_seq) then ll_read_seq = 0
//			ll_read_seq += 1
//			
//			ls_user_id = gnv_session.of_getstring('user_id')
//			
//			insert into pf_docu_log  ( sys_id, board_no, docu_no, read_seq, read_user, read_dtm )
//			values ( :gnv_session.is_sys_id, :is_board_no, :is_docu_no, :ll_read_seq, :ls_user_id, sysdate )
//			using sqlca;
//			
//			if sqlca.sqlcode = 0 then
//				commit using sqlca;
//			else
//				ls_errtext = sqlca.sqlerrtext
//				rollback using sqlca;
//				messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX12$$8cacdcc200ae20005cb8f8ad2000ddc031c1200024c658b9$$ENDHEX$$~r~n' + ls_errtext)
//				return
//			end if
//		end if
//		
//		rte_content.pastertf(string(lb_content))
//		rte_content.scrolltorow(0)
//	else
//		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX9$$8cacdcc200ae20007dc730ae2000e4c228d3$$ENDHEX$$!')
//		return
//	end if
//end if
//
//dw_attach.retrieve(gnv_session.is_sys_id, is_board_no, is_docu_no)
//
end event

type st_6 from statictext within pf_w_pgm_help_ent
integer x = 1504
integer y = 1608
integer width = 2597
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 268435456
string text = "~'$$HEX7$$b4b0a9c62000b8d3d1c958d530ae$$ENDHEX$$~' $$HEX24$$84bcbcd244c7200074d0adb974d51cc1200004d55cb8f8ada8b72000c4b3c0c6d0b944c7200000adacb958d538c194c6$$ENDHEX$$"
boolean focusrectangle = false
end type

type st_5 from statictext within pf_w_pgm_help_ent
integer x = 1504
integer y = 1244
integer width = 2597
integer height = 172
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 268435456
string text = "$$HEX17$$30aec0d0200038cce0ac60d52000acc06dd5f1b444c72000f4bc00ad58d594b22000$$ENDHEX$$"
boolean focusrectangle = false
end type

type st_4 from statictext within pf_w_pgm_help_ent
integer x = 114
integer y = 304
integer width = 517
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX2$$cbb3c0c6$$ENDHEX$$"
long textcolor = 25123896
long backcolor = 16777215
string text = "$$HEX7$$b8d3d1c9200088d7a4c2a0d1acb9$$ENDHEX$$"
boolean focusrectangle = false
end type

type p_2 from picture within pf_w_pgm_help_ent
integer x = 55
integer y = 308
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type p_save from pf_u_imagebutton within pf_w_pgm_help_ent
integer x = 3968
integer y = 24
integer width = 233
integer height = 88
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
end type

event clicked;call super::clicked;long ll_help_seq
string ls_menu_id

setpointer(hourglass!)
post setpointer(arrow!)

// set the primary key
ls_menu_id = dw_list.getitemstring(1, 'menu_id')

if dw_list.getitemstatus(1, 0, primary!) = newmodified! then
	select		max(help_seq)
	into		:ll_help_seq
	from		pf_pgm_help
	where	sys_id = :gnv_session.is_sys_id
	and		menu_id = :ls_menu_id
	using		sqlca;
	
	if isnull(ll_help_seq) then ll_help_seq = 0
	ll_help_seq += 1
	
	dw_list.setitem(1, 'help_seq', ll_help_seq)
else
	ll_help_seq = dw_list.getitemnumber(1, 'help_seq')
end if

// update datawindow and content
blob lb_content
string ls_errtext

if dw_list.update(true, false) = 1 then
	lb_content = blob(rte_content.copyrtf(false))
	
	updateblob	pf_pgm_help
	set			help_content = :lb_content
	where	sys_id = :gnv_session.is_sys_id
	and		menu_id = :ls_menu_id
	and		help_seq = :ll_help_seq;
	
	if sqlca.sqlcode <> 0 then
		ls_errtext = sqlca.sqlerrtext
		rollback using sqlca;
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$1', '$$HEX12$$90c7ccb8200000c8a5c72000e4c228d388d5b5c2c8b2e4b2$$ENDHEX$$!!~r~n' + ls_errtext)
		return
	end if
else
	rollback using sqlca;
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$2', '$$HEX12$$90c7ccb8200000c8a5c72000e4c228d388d5b5c2c8b2e4b2$$ENDHEX$$!!~r~n' + dw_list.istr_dberror.sqlerrtext)
	return
end if

rte_content.statusbar = false
rte_content.toolbar = false
rte_content.displayonly = true

commit using sqlca;
messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX5$$00c8a5c7200044c6ccb8$$ENDHEX$$!!')
return

end event

type cb_modify from pf_u_commandbutton within pf_w_pgm_help_ent
integer x = 3506
integer y = 20
integer width = 453
integer height = 92
integer taborder = 10
string text = "$$HEX7$$b4b0a9c62000b8d3d1c958d530ae$$ENDHEX$$"
end type

event clicked;call super::clicked;//
if rte_content.displayonly = false then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX11$$04d6acc72000b8d3d1c92000a8badcb485c7c8b2e4b2$$ENDHEX$$.')
	return
end if

long ll_new
string ls_user_id, ls_user_name

ls_user_id = gnv_session.is_user_id

select		user_name
into		:ls_user_name
from		pf_user_mst
where	user_id = :ls_user_id
using 		sqlca;

ll_new = dw_list.insertrow(1)
dw_list.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
dw_list.setitem(ll_new, 'menu_id', inv_menuparam.is_menu_id)
dw_list.setitem(ll_new, 'create_dtm', now())
dw_list.setitem(ll_new, 'create_user', ls_user_id)
dw_list.setitem(ll_new, 'user_name', ls_user_name)

if rte_content.visible = false then rte_content.visible = true
rte_content.statusbar = true
//rte_content.toolbar = true
rte_content.displayonly = false
rte_content.setfocus()

end event

type dw_list from pf_u_datawindow within pf_w_pgm_help_ent
integer x = 46
integer y = 368
integer width = 1102
integer height = 2132
integer taborder = 50
string dataobject = "pf_d_pgm_help_ent_02"
end type

event rowfocuschanged;call super::rowfocuschanged;//
if currentrow = 0 then return

string ls_menu_id, ls_create_user
blob lb_content
long ll_help_seq
datetime ldtm_create

ls_menu_id = this.getitemstring(currentrow, 'menu_id')
ll_help_seq = this.getitemnumber(currentrow, 'help_seq')
ldtm_create = this.getitemdatetime(currentrow, 'create_dtm')
ls_create_user = this.getitemstring(currentrow, 'create_user')

selectblob
			help_content
into		:lb_content
from		pf_pgm_help
where	sys_id = :gnv_session.is_sys_id
and		menu_id = :ls_menu_id
and		help_seq = :ll_help_seq
using		sqlca;

rte_content.SelectTextAll()
rte_content.Clear()
rte_content.statusbar = false
rte_content.toolbar = false

// $$HEX22$$f8bc78c774c7200091c731c15cd5200000ae40c720007cc7fcc87cc7d9b348c5200018c215c8200000aca5b2$$ENDHEX$$
if ls_create_user = gnv_session.is_user_id and &
   DaysAfter (date(ldtm_create), today()) <= 7 then
	cb_modify.of_setenabled(false)
	rte_content.displayonly = false
else
	cb_modify.of_setenabled(true)
	rte_content.displayonly = true
end if

if rte_content.visible = false then rte_content.visible = true
rte_content.pastertf(string(lb_content))
rte_content.scrolltorow(1)

end event

type p_close from pf_u_imagebutton within pf_w_pgm_help_ent
integer x = 4215
integer y = 24
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
end type

event clicked;call super::clicked;close(parent)

end event

type dw_mast from pf_u_datawindow within pf_w_pgm_help_ent
integer x = 46
integer y = 120
integer width = 4398
integer height = 168
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_pgm_help_ent_01"
boolean issearchcondition = true
boolean scaletoright = true
end type

type rte_content from pf_u_richtextedit within pf_w_pgm_help_ent
boolean visible = false
integer x = 1193
integer y = 332
integer width = 3227
integer height = 2144
integer taborder = 40
boolean bringtotop = true
boolean init_vscrollbar = true
boolean init_wordwrap = true
boolean init_displayonly = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean scaletoright = true
boolean scaletobottom = true
end type

type st_3 from statictext within pf_w_pgm_help_ent
integer x = 1504
integer y = 1416
integer width = 2597
integer height = 172
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 268435456
string text = "$$HEX9$$a9c6c4b35cb82000acc0a9c629b4c8b2e4b2$$ENDHEX$$."
boolean focusrectangle = false
end type

type st_2 from statictext within pf_w_pgm_help_ent
integer x = 1504
integer y = 1072
integer width = 2597
integer height = 172
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 268435456
string text = "$$HEX18$$10b694b2200004d55cb8f8ada8b72000acc0a9c6dcc22000fcc858c760d52000acc06dd5$$ENDHEX$$, "
boolean focusrectangle = false
end type

type st_1 from statictext within pf_w_pgm_help_ent
integer x = 1504
integer y = 900
integer width = 2597
integer height = 172
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 268435456
string text = "$$HEX23$$74c7200054d674ba40c7200004d55cb8f8ada8b72000acc0a9c6200029bc95bcd0c5200000b35cd52000b4b0a9c6$$ENDHEX$$"
boolean focusrectangle = false
end type

type rr_border from roundrectangle within pf_w_pgm_help_ent
long linecolor = 268435456
integer linethickness = 4
long fillcolor = 1073741824
integer x = 1166
integer y = 308
integer width = 3278
integer height = 2192
integer cornerheight = 40
integer cornerwidth = 55
end type

