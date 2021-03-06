HA$PBExportHeader$pf_w_role_cat_mst_modify.srw
$PBExportComments$$$HEX29$$8cad5cd5200020c715d6200015c8f4bc58c72000f1b45db820000fbc200018c215c8a9c620001dd3c5c5200008c7c4b3b0c6200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_role_cat_mst_modify from pf_w_response
end type
type dw_preview from pf_u_datawindow within pf_w_role_cat_mst_modify
end type
type cb_1 from commandbutton within pf_w_role_cat_mst_modify
end type
type p_close from pf_u_imagebutton within pf_w_role_cat_mst_modify
end type
type p_update from pf_u_imagebutton within pf_w_role_cat_mst_modify
end type
type dw_cat from pf_u_datawindow within pf_w_role_cat_mst_modify
end type
end forward

global type pf_w_role_cat_mst_modify from pf_w_response
integer width = 2395
integer height = 1900
string title = "Role $$HEX7$$74ce4cd1e0acacb9200000adacb9$$ENDHEX$$"
dw_preview dw_preview
cb_1 cb_1
p_close p_close
p_update p_update
dw_cat dw_cat
end type
global pf_w_role_cat_mst_modify pf_w_role_cat_mst_modify

on pf_w_role_cat_mst_modify.create
int iCurrent
call super::create
this.dw_preview=create dw_preview
this.cb_1=create cb_1
this.p_close=create p_close
this.p_update=create p_update
this.dw_cat=create dw_cat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_preview
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.p_close
this.Control[iCurrent+4]=this.p_update
this.Control[iCurrent+5]=this.dw_cat
end on

on pf_w_role_cat_mst_modify.destroy
call super::destroy
destroy(this.dw_preview)
destroy(this.cb_1)
destroy(this.p_close)
destroy(this.p_update)
destroy(this.dw_cat)
end on

event open;call super::open;string	ls_parm, ls_parm_arr[]
string ls_dddwobj

ls_parm = message.stringparm
if isnull(ls_parm) or len(ls_parm) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX17$$2cc614bc74b9c0c920004ac540c7200008c7c4b3b0c6200038d69ccd85c7c8b2e4b2$$ENDHEX$$.')
	return
end if

dw_cat.settransobject(sqlca)
choose case upper(left(sqlca.dbms, 3))
	case 'ASE', 'SYC', 'ODB'
		ls_dddwobj = 'pf_dddw_db_column_name_asa'
	case 'IN8', 'IN9', 'I10'
		ls_dddwobj = 'pf_dddw_db_column_name_informix'
	case 'O80', 'O90', 'O10', 'ORA'
		ls_dddwobj = 'pf_dddw_db_column_name_oracle'
	case 'ADO', 'OLE', 'SNC'
		ls_dddwobj = 'pf_dddw_db_column_name_mssql'
	case else
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX6$$4cc518c22000c6c594b22000$$ENDHEX$$DBMS $$HEX5$$c0d085c785c7c8b2e4b2$$ENDHEX$$~r~nDBMS=' + sqlca.dbms)
		return
end choose

dw_cat.modify("user_tbl_col.dddw.name='" + ls_dddwobj + "'")

datawindowchild	ldwc
dw_cat.getchild('user_tbl_col', ldwc)
ldwc.settransobject(sqlca)
ldwc.retrieve('PF_USER_MST')
ldwc.insertrow(1)

pf_f_parsetoarray(ls_parm, '~t', ls_parm_arr)
choose case ls_parm_arr[1]
	case '$$HEX2$$94cd00ac$$ENDHEX$$'
		dw_cat.insertrow(0)
	case '$$HEX2$$18c215c8$$ENDHEX$$'
		dw_cat.retrieve(gnv_session.is_sys_id, ls_parm_arr[2])
end choose

this.title = this.title + '[' + ls_parm_arr[1] + ']'
dw_cat.setfocus()

end event

type dw_preview from pf_u_datawindow within pf_w_role_cat_mst_modify
boolean visible = false
integer x = 23
integer y = 16
integer width = 2345
integer height = 1788
integer taborder = 20
boolean titlebar = true
string title = "Please, doubleclick the row in order to close this sql preview"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event doubleclicked;call super::doubleclicked;this.visible = false

end event

event pfe_postopen;call super::pfe_postopen;this.title = 'Please, doubleclick the row in order to close this sql preview'
end event

type cb_1 from commandbutton within pf_w_role_cat_mst_modify
integer x = 1353
integer y = 16
integer width = 453
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "$$HEX6$$fccfacb920004cd1a4c2b8d2$$ENDHEX$$"
end type

event clicked;// $$HEX13$$85c725b81cb42000fccfacb97cb9200055d678c769d5c8b2e4b2$$ENDHEX$$

string ls_sql
long ll_rv
blob lblb_status

ls_sql = dw_cat.getitemstring(1, 'code_list_sql')
if pf_f_isemptystring(ls_sql) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX25$$54cfdcb42000acb9a4c2b8d2200070c88cd6a9c62000fccfacb900ac200085c725b818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$')
	return
end if

pf_n_datastore lds_preview

lds_preview = create pf_n_datastore
lds_preview.settransobject(sqlca)
ll_rv = lds_preview.of_retrievefromsql(ls_sql)
choose case ll_rv
	case is > 0
		if lds_preview.getfullstate(lblb_status) > 0 then
			dw_preview.setfullstate(lblb_status)
			dw_preview.visible = true
		end if
	case 0
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX21$$74d5f9b22000fccfacb994b2200070b374c730d100ac200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$')
	case else
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX10$$98c7bbba1cb42000fccfacb938bb85c7c8b2e4b2$$ENDHEX$$.')
end choose

end event

type p_close from pf_u_imagebutton within pf_w_role_cat_mst_modify
integer x = 2075
integer y = 28
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
end type

event clicked;call super::clicked;closewithreturn(parent, 'Cancel')

end event

type p_update from pf_u_imagebutton within pf_w_role_cat_mst_modify
integer x = 1824
integer y = 28
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
end type

event clicked;call super::clicked;// Accept Text
if dw_cat.accepttext() = -1 then return

// Check Mendatory Field
string	ls_role_cat_no, ls_role_cat_name
string	ls_code_list_dwo
string ls_code_list_sql

ls_role_cat_name = dw_cat.getitemstring(1, 'role_cat_name')
if isnull(ls_role_cat_name) or len(trim(ls_role_cat_name)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'Role $$HEX9$$85ba6dce44c7200085c725b858d538c194c6$$ENDHEX$$')
	return
end if

//ls_emp_tbl_col = dw_cat.getitemstring(1, 'emp_tbl_col')
//if isnull(ls_emp_tbl_col) or len(trim(ls_emp_tbl_col)) = 0 then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX4$$f0c5c4ac20b42000$$ENDHEX$$pf_Employee $$HEX14$$4cd174c714be2000eccefcb785ba44c7200085c725b858d538c194c6$$ENDHEX$$')
//	return
//end if

ls_code_list_dwo = dw_cat.getitemstring(1, 'code_list_dwo')
ls_code_list_sql = dw_cat.getitemstring(1, 'code_list_sql')

if (isnull(ls_code_list_dwo) or len(trim(ls_code_list_dwo)) = 0) and & 
	(isnull(ls_code_list_sql) or len(trim(ls_code_list_sql)) = 0) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX10$$54cfdcb4acb9a4c2b8d2200070c88cd6a9c62000$$ENDHEX$$DWObject $$HEX3$$10b694b22000$$ENDHEX$$SQL$$HEX7$$44c7200085c725b858d538c194c6$$ENDHEX$$')
	return
end if

// Set Primary Key
if dw_cat.getitemstatus(1, 0, primary!) = newmodified! then
	select		max(role_cat_no)
	into		:ls_role_cat_no
	from		pf_role_cat_mst
	where	sys_id = :gnv_session.is_sys_id
	using		sqlca;
	
	if isnull(ls_role_cat_no) then
		ls_role_cat_no = '00001'
	else
		ls_role_cat_no = string(long(ls_role_cat_no) + 1, '00000')
	end if
	
	dw_cat.setitem(1, 'sys_id', gnv_session.is_sys_id)
	dw_cat.setitem(1, 'role_cat_no', ls_role_cat_no)
end if

// Do Update
string	ls_errtext

if dw_cat.update() = 1 then
	commit using sqlca;
else
	ls_errtext = sqlca.sqlerrtext
	rollback using sqlca;
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'Role $$HEX8$$15c8f4bc200000c8a5c72000e4c228d3$$ENDHEX$$!!~r~n' + 'Error Text: ' + ls_errtext)
	return
end if

closewithreturn(parent, 'OK')

end event

type dw_cat from pf_u_datawindow within pf_w_role_cat_mst_modify
integer x = 37
integer y = 136
integer width = 2318
integer height = 1652
integer taborder = 10
string dataobject = "pf_d_role_cat_mst_modify_01"
boolean singlerowselection = false
end type

event buttonclicked;if dwo.name = 'b_dwo' then
	OpenwithParm(pf_w_datawindow_search, '', parent)
	if isvalid(message.powerobjectparm) then
		pf_n_hashtable lnv_retval
		lnv_retval = message.powerobjectparm
		if isvalid(lnv_retval) then
			this.setitem(row, 'code_list_dwo', lnv_retval.of_get('classname'))
		end if
	end if
end if

end event

event itemchanged;call super::itemchanged;// code list $$HEX2$$a9c62000$$ENDHEX$$sql $$HEX13$$74c72000c0bcbdac1cb42000bdacb0c6200020c794c65cd52000$$ENDHEX$$sql $$HEX8$$78c7c0c9200055d678c769d5c8b2e4b2$$ENDHEX$$.

choose case dwo.name
	case 'code_list_sql'
		if pf_f_isemptystring(data) then return 0

		pf_n_datastore lds_verify
		lds_verify = create pf_n_datastore
		lds_verify.settransobject(sqlca)
		if lds_verify.of_retrievefromsql(data) < 0 then
			return 2
		end if
end choose

return 0

end event

