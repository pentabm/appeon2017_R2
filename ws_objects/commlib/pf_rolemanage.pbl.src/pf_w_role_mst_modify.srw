$PBExportHeader$pf_w_role_mst_modify.srw
$PBExportComments$권한 Master의 신규 등록 및 수정을 담당하는 팝업 윈도우 입니다.
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
string title = "권한 관리"
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
	messagebox('알림', '올바르지 않은 윈도우 호출입니다.')
	return
end if

datawindowchild ldwc_dddw
dw_role.getchild('role_cat_no', ldwc_dddw)
ldwc_dddw.settransobject(sqlca)
ldwc_dddw.retrieve(gnv_session.is_sys_id)

dw_role.settransobject(sqlca)
pf_f_parsetoarray(ls_parm, '~t', ls_parm_arr)
choose case ls_parm_arr[1]
	case '추가'
		dw_role.insertrow(0)
	case '수정'
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
	messagebox('알림', 'Role 명칭을 입력하세요')
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
	messagebox('알림', 'Role 정보 저장 실패!!~r~n' + 'Error Text: ' + ls_errtext)
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

