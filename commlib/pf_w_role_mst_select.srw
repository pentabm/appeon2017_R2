HA$PBExportHeader$pf_w_role_mst_select.srw
$PBExportComments$$$HEX41$$8cad5cd544c72000f5bcacc060d520004cb52000f5bcacc074d52cc62000d0c6f8bc20008cad5cd544c7200020c1ddd058d594b22000a9c6c4b358c720001dd3c5c5200008c7c4b3b0c6200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_role_mst_select from pf_w_response
end type
type st_1 from statictext within pf_w_role_mst_select
end type
type dw_data from pf_u_datawindow within pf_w_role_mst_select
end type
type p_close from pf_u_imagebutton within pf_w_role_mst_select
end type
type p_select from pf_u_imagebutton within pf_w_role_mst_select
end type
end forward

global type pf_w_role_mst_select from pf_w_response
integer width = 2062
integer height = 1516
string title = "$$HEX6$$8cad5cd5200020c1ddd03dcc$$ENDHEX$$"
st_1 st_1
dw_data dw_data
p_close p_close
p_select p_select
end type
global pf_w_role_mst_select pf_w_role_mst_select

type variables
string is_parm

end variables

on pf_w_role_mst_select.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_data=create dw_data
this.p_close=create p_close
this.p_select=create p_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_data
this.Control[iCurrent+3]=this.p_close
this.Control[iCurrent+4]=this.p_select
end on

on pf_w_role_mst_select.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_data)
destroy(this.p_close)
destroy(this.p_select)
end on

event open;call super::open;dw_data.settransobject(sqlca)

end event

event pfe_postopen;call super::pfe_postopen;dw_data.retrieve(gnv_session.is_sys_id)

end event

type st_1 from statictext within pf_w_role_mst_select
integer x = 41
integer y = 36
integer width = 1161
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
string text = "$$HEX10$$70b374c730d17cb92000f5bcacc074d52cc62000$$ENDHEX$$[$$HEX2$$d0c6f8bc$$ENDHEX$$] $$HEX9$$8cad5cd544c7200020c1ddd058d538c194c6$$ENDHEX$$"
boolean focusrectangle = false
end type

type dw_data from pf_u_datawindow within pf_w_role_mst_select
integer x = 37
integer y = 132
integer width = 1984
integer height = 1280
integer taborder = 10
string dataobject = "pf_d_role_mst_select_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean datawindowaction = false
boolean scaletoright = true
boolean scaletobottom = true
end type

event doubleclicked;call super::doubleclicked;// DoubleClicked
p_select.post event clicked()

end event

type p_close from pf_u_imagebutton within pf_w_role_mst_select
integer x = 1783
integer y = 28
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_cancel.gif"
end type

event clicked;call super::clicked;closewithreturn(parent, 'Cancel')

end event

type p_select from pf_u_imagebutton within pf_w_role_mst_select
integer x = 1541
integer y = 28
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_select.gif"
end type

event clicked;call super::clicked;long	ll_row
string	ls_code, ls_name

ll_row = dw_data.getrow()
if ll_row < 1 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX17$$20c1ddd060d520008cad5cd574c7200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$')
	return
end if

ls_code = dw_data.getitemstring(ll_row, 'role_no')
ls_name = dw_data.getitemstring(ll_row, 'role_name')

closewithreturn(parent, 'OK' + '~t' + ls_code + '~t' + ls_name)

end event

