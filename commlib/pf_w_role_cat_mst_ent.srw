HA$PBExportHeader$pf_w_role_cat_mst_ent.srw
$PBExportComments$$$HEX6$$8cad5cd558c7200020c715d6$$ENDHEX$$($$HEX4$$74ce4cd1e0acacb9$$ENDHEX$$)$$HEX15$$7cb9200000adacb958d594b2200004d55cb8f8ada8b7200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_role_cat_mst_ent from pf_w_sheet
end type
type st_1 from statictext within pf_w_role_cat_mst_ent
end type
type p_2 from picture within pf_w_role_cat_mst_ent
end type
type dw_role_cat_mst from pf_u_datawindow within pf_w_role_cat_mst_ent
end type
type p_add from pf_u_imagebutton within pf_w_role_cat_mst_ent
end type
type p_modify from pf_u_imagebutton within pf_w_role_cat_mst_ent
end type
type p_delete from pf_u_imagebutton within pf_w_role_cat_mst_ent
end type
type p_close from pf_u_imagebutton within pf_w_role_cat_mst_ent
end type
type p_retrieve from pf_u_imagebutton within pf_w_role_cat_mst_ent
end type
end forward

global type pf_w_role_cat_mst_ent from pf_w_sheet
string title = "$$HEX6$$8cad5cd520c715d600adacb9$$ENDHEX$$"
st_1 st_1
p_2 p_2
dw_role_cat_mst dw_role_cat_mst
p_add p_add
p_modify p_modify
p_delete p_delete
p_close p_close
p_retrieve p_retrieve
end type
global pf_w_role_cat_mst_ent pf_w_role_cat_mst_ent

on pf_w_role_cat_mst_ent.create
int iCurrent
call super::create
this.st_1=create st_1
this.p_2=create p_2
this.dw_role_cat_mst=create dw_role_cat_mst
this.p_add=create p_add
this.p_modify=create p_modify
this.p_delete=create p_delete
this.p_close=create p_close
this.p_retrieve=create p_retrieve
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_2
this.Control[iCurrent+3]=this.dw_role_cat_mst
this.Control[iCurrent+4]=this.p_add
this.Control[iCurrent+5]=this.p_modify
this.Control[iCurrent+6]=this.p_delete
this.Control[iCurrent+7]=this.p_close
this.Control[iCurrent+8]=this.p_retrieve
end on

on pf_w_role_cat_mst_ent.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_2)
destroy(this.dw_role_cat_mst)
destroy(this.p_add)
destroy(this.p_modify)
destroy(this.p_delete)
destroy(this.p_close)
destroy(this.p_retrieve)
end on

event open;call super::open;// Resize $$HEX2$$f1b45db8$$ENDHEX$$
//This.of_SetResize(True)
//inv_Resize.of_Register(dw_role_cat_mst, "ScaleToBottom")
//inv_Resize.of_Register(tab_1, "ScaleToRight&Bottom")

dw_role_cat_mst.settransobject(sqlca)
p_retrieve.event clicked()

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_role_cat_mst_ent
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_role_cat_mst_ent
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_role_cat_mst_ent
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_role_cat_mst_ent
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_role_cat_mst_ent
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_role_cat_mst_ent
end type

type st_1 from statictext within pf_w_role_cat_mst_ent
integer x = 110
integer y = 172
integer width = 608
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
string text = "Role $$HEX8$$74ce4cd1e0acacb92000acb9a4c2b8d2$$ENDHEX$$"
boolean focusrectangle = false
end type

type p_2 from picture within pf_w_role_cat_mst_ent
integer x = 50
integer y = 176
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type dw_role_cat_mst from pf_u_datawindow within pf_w_role_cat_mst_ent
integer x = 50
integer y = 236
integer width = 4494
integer height = 1980
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_role_cat_mst_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean scaletoright = true
boolean scaletobottom = true
end type

event doubleclicked;call super::doubleclicked;// $$HEX16$$54b314be74d0adb92000dcc2200018c215c8200008c7c4b3b0c6200024c608d5$$ENDHEX$$
if row = 0 then return
p_modify.post event clicked()

end event

type p_add from pf_u_imagebutton within pf_w_role_cat_mst_ent
integer x = 3575
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;OpenWithParm(pf_w_role_cat_mst_modify, '$$HEX2$$94cd00ac$$ENDHEX$$')
if message.stringparm = 'OK' then
	dw_role_cat_mst.retrieve(gnv_session.is_sys_id)
end if

end event

type p_modify from pf_u_imagebutton within pf_w_role_cat_mst_ent
integer x = 3822
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_adjust.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long	ll_row
string	ls_role_cat_no

ll_row = dw_role_cat_mst.getrow()
if ll_row > 0 then
	ls_role_cat_no = dw_role_cat_mst.getitemstring(ll_row, 'role_cat_no')
	OpenWithParm(pf_w_role_cat_mst_modify, '$$HEX2$$18c215c8$$ENDHEX$$~t' + ls_role_cat_no)
	if message.stringparm = 'OK' then
		dw_role_cat_mst.retrieve(gnv_session.is_sys_id)
	end if
end if

end event

type p_delete from pf_u_imagebutton within pf_w_role_cat_mst_ent
integer x = 4069
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long	ll_row
string	ls_role_cat_no, ls_role_cat_name
string	ls_errtext

ll_row = dw_role_cat_mst.getrow()
if ll_row > 0 then
	ls_role_cat_no = dw_role_cat_mst.getitemstring(ll_row, 'role_cat_no')
	ls_role_cat_name = dw_role_cat_mst.getitemstring(ll_row, 'role_cat_name')
	if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX5$$20c1ddd058d5e0c22000$$ENDHEX$$' + ls_role_cat_name + '[' + ls_role_cat_no + '] $$HEX17$$8cad5cd5200074ce4cd1e0acacb97cb92000adc01cc858d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Exclamation!, YesNo!, 2) = 1 then
		dw_role_cat_mst.deleterow(ll_row)
		if dw_role_cat_mst.update() = 1 then
			commit using sqlca;
		else
			ls_errtext = sqlca.sqlerrtext
			rollback using sqlca;
			messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'Role $$HEX8$$15c8f4bc2000adc01cc82000e4c228d3$$ENDHEX$$!!~r~n' + 'Error Text: ' + ls_errtext)
			return
		end if
	end if
end if
end event

type p_close from pf_u_imagebutton within pf_w_role_cat_mst_ent
integer x = 4315
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)

end event

type p_retrieve from pf_u_imagebutton within pf_w_role_cat_mst_ent
integer x = 3328
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_retrieve.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;dw_role_cat_mst.retrieve(gnv_session.is_sys_id)

end event

