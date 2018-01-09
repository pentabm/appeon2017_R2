HA$PBExportHeader$pf_w_role_mst_modify.srw
$PBExportComments$$$HEX3$$8cad5cd52000$$ENDHEX$$Master$$HEX29$$58c72000e0c2dcad2000f1b45db820000fbc200018c215c844c72000f4b2f9b258d594b220001dd3c5c5200008c7c4b3b0c6200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_role_mst_modify from pf_w_response
end type
type p_close from pf_u_imagebutton within pf_w_role_mst_modify
end type
type p_update from pf_u_imagebutton within pf_w_role_mst_modify
end type
type dw_role from pf_u_datawindow within pf_w_role_mst_modify
end type
end forward

global type pf_w_role_mst_modify from pf_w_response
integer width = 1614
integer height = 804
string title = "$$HEX5$$8cad5cd5200000adacb9$$ENDHEX$$"
p_close p_close
p_update p_update
dw_role dw_role
end type
global pf_w_role_mst_modify pf_w_role_mst_modify

on pf_w_role_mst_modify.create
int iCurrent
call super::create
this.p_close=create p_close
this.p_update=create p_update
this.dw_role=create dw_role
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_close
this.Control[iCurrent+2]=this.p_update
this.Control[iCurrent+3]=this.dw_role
end on

on pf_w_role_mst_modify.destroy
call super::destroy
destroy(this.p_close)
destroy(this.p_update)
destroy(this.dw_role)
end on

event open;call super::open;string	ls_parm, ls_parm_arr[]

ls_parm = message.stringparm
if isnull(ls_parm) or len(ls_parm) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX17$$2cc614bc74b9c0c920004ac540c7200008c7c4b3b0c6200038d69ccd85c7c8b2e4b2$$ENDHEX$$.')
	return
end if

datawindowchild ldwc_dddw
dw_role.getchild('role_cat_no', ldwc_dddw)
ldwc_dddw.settransobject(sqlca)
ldwc_dddw.retrieve(gnv_session.is_sys_id)

dw_role.settransobject(sqlca)
pf_f_parsetoarray(ls_parm, '~t', ls_parm_arr)
choose case ls_parm_arr[1]
	case '$$HEX2$$94cd00ac$$ENDHEX$$'
		dw_role.insertrow(0)
	case '$$HEX2$$18c215c8$$ENDHEX$$'
		dw_role.retrieve(gnv_session.is_sys_id, ls_parm_arr[2])
end choose

this.title = this.title + '[' + ls_parm_arr[1] + ']'
dw_role.setfocus()

end event

type p_close from pf_u_imagebutton within pf_w_role_mst_modify
integer x = 1335
integer y = 36
integer width = 233
integer height = 88
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;closewithreturn(parent, 'Cancel')

end event

type p_update from pf_u_imagebutton within pf_w_role_mst_modify
integer x = 1088
integer y = 36
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// Accept Text
if dw_role.accepttext() = -1 then return

// Check Mendatory Field
string	ls_role_name

ls_role_name = dw_role.getitemstring(1, 'role_name')
if isnull(ls_role_name) or len(trim(ls_role_name)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'Role $$HEX9$$85ba6dce44c7200085c725b858d538c194c6$$ENDHEX$$')
	return
end if

// Set Primary Key
string	ls_role_no

if dw_role.getitemstatus(1, 0, primary!) = newmodified! then
	select		max(role_no)
	into		:ls_role_no
	from		pf_role_mst
	where	sys_id = :gnv_session.is_sys_id
	using		sqlca;
	
	if isnull(ls_role_no) then
		ls_role_no = '00001'
	else
		ls_role_no = string(long(ls_role_no) + 1, '00000')
	end if
	
	dw_role.setitem(1, 'sys_id', gnv_session.is_sys_id)
	dw_role.setitem(1, 'role_no', ls_role_no)
end if

// Do Update
string	ls_errtext

if dw_role.update() = 1 then
	commit using sqlca;
else
	ls_errtext = sqlca.sqlerrtext
	rollback using sqlca;
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'Role $$HEX8$$15c8f4bc200000c8a5c72000e4c228d3$$ENDHEX$$!!~r~n' + 'Error Text: ' + ls_errtext)
	return
end if

// return value
string ls_retval

ls_retval += '~t' + pf_f_nvl(dw_role.getitemstring(1, 'role_no'), '')
ls_retval += '~t' + pf_f_nvl(dw_role.getitemstring(1, 'role_name'), '')
ls_retval += '~t' + pf_f_nvl(dw_role.getitemstring(1, 'role_desc'), '')

closewithreturn(parent, 'OK' + ls_retval)


end event

type dw_role from pf_u_datawindow within pf_w_role_mst_modify
integer x = 50
integer y = 148
integer width = 1518
integer height = 544
integer taborder = 10
string dataobject = "pf_d_role_mst_modify_01"
boolean datawindowaction = false
boolean scaletoright = true
boolean scaletobottom = true
end type

