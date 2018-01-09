HA$PBExportHeader$pf_w_role_mst_memb_select.srw
$PBExportComments$$$HEX28$$8cad5cd5d0c5200060d5f9b274d504c9200064ba84bc7cb9200080acc9c058d594b220001dd3c5c5200008c7c4b3b0c6200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_role_mst_memb_select from pf_w_response
end type
type dw_data from pf_u_datawindow within pf_w_role_mst_memb_select
end type
type p_search from pf_u_imagebutton within pf_w_role_mst_memb_select
end type
type p_close from pf_u_imagebutton within pf_w_role_mst_memb_select
end type
type p_select from pf_u_imagebutton within pf_w_role_mst_memb_select
end type
type dw_cond from pf_u_datawindow within pf_w_role_mst_memb_select
end type
end forward

global type pf_w_role_mst_memb_select from pf_w_response
integer width = 2441
integer height = 1692
string title = "Role $$HEX5$$64ba84bc200020c1ddd0$$ENDHEX$$"
dw_data dw_data
p_search p_search
p_close p_close
p_select p_select
dw_cond dw_cond
end type
global pf_w_role_mst_memb_select pf_w_role_mst_memb_select

type variables
string is_parm

end variables

on pf_w_role_mst_memb_select.create
int iCurrent
call super::create
this.dw_data=create dw_data
this.p_search=create p_search
this.p_close=create p_close
this.p_select=create p_select
this.dw_cond=create dw_cond
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_data
this.Control[iCurrent+2]=this.p_search
this.Control[iCurrent+3]=this.p_close
this.Control[iCurrent+4]=this.p_select
this.Control[iCurrent+5]=this.dw_cond
end on

on pf_w_role_mst_memb_select.destroy
call super::destroy
destroy(this.dw_data)
destroy(this.p_search)
destroy(this.p_close)
destroy(this.p_select)
destroy(this.dw_cond)
end on

event open;call super::open;string ls_dataobject, ls_sql

is_parm = message.stringparm
if isnull(is_parm) or len(is_parm) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX17$$2cc614bc74b9c0c920004ac540c7200008c7c4b3b0c6200038d69ccd85c7c8b2e4b2$$ENDHEX$$.')
	return
end if

// $$HEX5$$38bb90c7f4c520005ec5$$ENDHEX$$.$$HEX2$$a4b42000$$ENDHEX$$DoubleQuotation $$HEX2$$1cc870ac$$ENDHEX$$
if left(is_parm, 1) = '"' then
	is_parm = mid(is_parm, 2, len(is_parm) - 2)
end if

// $$HEX18$$8cc1a4c2c0d085c7d0c5200030b578b9200054cfdcb4200070b374c730d1200070c88cd6$$ENDHEX$$
choose case left(is_parm, 4)
	case 'dwo:'
		ls_dataobject = mid(is_parm, 5)
		dw_data.dataobject = ls_dataobject
		dw_data.settransobject(sqlca)
		dw_data.event pfe_dataobjectchanged()
		
	case 'sql:'
		ls_sql = mid(is_parm, 5)

		pf_n_datastore lds_temp
		blob lblb_state
		lds_temp = create pf_n_datastore
		lds_temp.settransobject(sqlca)
		if lds_temp.of_createfromsql(ls_sql) > 0 then
			if lds_temp.getfullstate(lblb_state) >= 0 then
				dw_data.setfullstate(lblb_state)
				dw_data.settransobject(sqlca)
				dw_data.event pfe_dataobjectchanged()
			end if
		end if
	case else
		return
end choose

dw_cond.insertrow(0)
dw_cond.setfocus()

end event

type dw_data from pf_u_datawindow within pf_w_role_mst_memb_select
integer x = 37
integer y = 296
integer width = 2363
integer height = 1280
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean scaletoright = true
boolean scaletobottom = true
end type

event doubleclicked;call super::doubleclicked;if row = 0 then return

// DoubleClicked
p_select.post event clicked()

end event

event pfe_keydown;call super::pfe_keydown;If This.GetRow() = 0 Then Return

If key = KeyEnter! Then
	p_select.Event Clicked()
End If

end event

type p_search from pf_u_imagebutton within pf_w_role_mst_memb_select
integer x = 1669
integer y = 28
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_search.gif"
end type

event clicked;call super::clicked;if dw_cond.accepttext() = -1 then return

string	ls_code, ls_name

ls_code = dw_cond.getitemstring(1, 'code')
ls_name = dw_cond.getitemstring(1, 'name')

if isnull(ls_code) or len(trim(ls_code)) = 0 then
	ls_code = '%'
else
	ls_code = '%' + ls_code + '%'
end if

if isnull(ls_name) or len(trim(ls_name)) = 0 then
	ls_name = '%'
else
	ls_name = '%' + ls_name + '%'
end if

string ls_orig_sql, ls_modi_sql
string ls_codedbalias, ls_namedbalias
integer li_rc
long ll_pos

ls_orig_sql = dw_data.Describe("Datawindow.Table.Select")

ls_codedbalias = dw_data.describe("#1.dbAlias")
if ls_codedbalias = '?' or ls_codedbalias = '!' or  len(trim(ls_codedbalias)) = 0 then
	ls_codedbalias = dw_data.describe("#1.dbName")
end if

ll_pos = pos(ls_codedbalias, '.')
if ll_pos > 0 then
	ls_codedbalias = mid(ls_codedbalias, ll_pos + 1)
end if

ls_namedbalias = dw_data.describe("#2.dbAlias")
if ls_namedbalias = '?' or ls_namedbalias = '!' or  len(trim(ls_namedbalias)) = 0 then
	ls_namedbalias = dw_data.describe("#2.dbName")
end if

ll_pos = pos(ls_namedbalias, '.')
if ll_pos > 0 then
	ls_namedbalias = mid(ls_namedbalias, ll_pos + 1)
end if

ls_modi_sql = "select * from ( " + ls_orig_sql + " ) sub01 where " + ls_codedbalias + " like '" + ls_code + "' and " + ls_namedbalias + " like '" + ls_name + "'"

li_rc = dw_data.SetSQLSelect(ls_modi_sql)
IF li_rc = 1 THEN
	dw_data.Reset()
	dw_data.Retrieve()
END IF

li_rc = dw_data.SetSQLSelect(ls_orig_sql)

dw_data.insertrow(1)
dw_data.setitem(1, 1, '')
dw_data.setitem(1, 2, 'All')
dw_data.setrow(1)
dw_data.selectrow(0, false)
dw_data.selectrow(1, true)
dw_data.setfocus()


// dynamic where clause
// -- querymode $$HEX3$$acc0a9c62000$$ENDHEX$$==> $$HEX5$$fccfacb938bbd0c52000$$ENDHEX$$alias $$HEX10$$acc0a9c6dcc2200024c658b920001cbcddc028b4$$ENDHEX$$... PB BUG??
// -- pfc sql parser $$HEX3$$acc0a9c62000$$ENDHEX$$==> $$HEX10$$eccefcb7200010b694b220004cd174c714be2000$$ENDHEX$$alias $$HEX18$$acc0a9c6dcc22000eccefcb785ba44c720004cc544c5bcb0200018c200ac2000c6c54cc7$$ENDHEX$$, Where $$HEX15$$08c8d0c52000c1c911c8200070c874ac200094cd00ac200088bd00aca5b2$$ENDHEX$$.

// PFC SQL
//pfc_n_sql lnv_sql
//pfc_n_sqlattrib lnv_sqlattrib[]
//li_rtn =  lnv_sql.of_parse(ls_orig_sql, lnv_sqlattrib[])
//If li_rtn > 0 then
////	ls_str = lnv_sqlattrib[1].s_verb +'~n~r'+&
////		lnv_sqlattrib[1].s_tables+'~n~r'+&
////		lnv_sqlattrib[1].s_columns+'~n~r'+&
////		lnv_sqlattrib[1].s_values+'~n~r'+ &
////		lnv_sqlattrib[1].s_where+'~n~r'+ &
////		lnv_sqlattrib[1].s_order+'~n~r'+ &
////		lnv_sqlattrib[1].s_group+'~n~r'+&
////		lnv_sqlattrib[1].s_having
//	
//	ls_codedbalias = dw_data.describe("#1.dbAlias")
//	ls_namedbalias = dw_data.describe("#2.dbAlias")
//	
//	If len(trim(lnv_sqlattrib[1].s_where)) > 0 then
//		lnv_sqlattrib[1].s_where += "~r~nand"
//	End If
//	
//	lnv_sqlattrib[1].s_where = lnv_sqlattrib[1].s_where + &
//	ls_codedbalias + " like '" + ls_code + "'" + &
//	" ~r~nand " + ls_namedbalias + " like '" + ls_name + "'"
//End if
//
//ls_str = lnv_sql.of_Assemble(lnv_sqlattrib[])
//
//li_rc = dw_data.SetSQLSelect(Upper(ls_str))
//IF li_rc = 1 THEN
//	dw_data.Retrieve()
//END IF
//
//li_rc = dw_data.SetSQLSelect(ls_orig_sql)
//

// QUERYMODE
////dw_data.modify("datawindow.queryclear='yes'")
////dw_data.modify("datawindow.querymode='yes'")
////
////dw_data.setitem(1, 1, 'like ' + ls_code)
////dw_data.setrow(1)
////dw_data.setcolumn(1)
////dw_data.settext('like ' + ls_code)
////
////dw_data.setitem(1, 2, 'like ' + ls_name)
////dw_data.setrow(1)
////dw_data.setcolumn(2)
////dw_data.settext('like ' + ls_name)
////
////dw_data.accepttext()
////dw_data.modify("datawindow.querymode='no'")
////dw_data.retrieve()

end event

type p_close from pf_u_imagebutton within pf_w_role_mst_memb_select
integer x = 2162
integer y = 28
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
end type

event clicked;call super::clicked;closewithreturn(parent, 'Cancel')

end event

type p_select from pf_u_imagebutton within pf_w_role_mst_memb_select
integer x = 1915
integer y = 28
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_input.gif"
end type

event clicked;call super::clicked;long	ll_row
string	ls_code, ls_name

ll_row = dw_data.getrow()
if ll_row < 1 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX17$$20c1ddd060d5200064ba84bc00ac200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$')
	return
end if

ls_code = dw_data.getitemstring(ll_row, 1)
if len(ls_code) > 0 then
	ls_name = dw_data.getitemstring(ll_row, 2)
end if

closewithreturn(parent, 'OK' + '~t' + ls_code + '~t' + ls_name)

end event

type dw_cond from pf_u_datawindow within pf_w_role_mst_memb_select
integer x = 37
integer y = 128
integer width = 2363
integer height = 144
integer taborder = 10
string dataobject = "pf_d_role_mst_memb_select_01"
boolean sorting = false
boolean issearchcondition = true
boolean scaletoright = true
end type

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'code', 'name'
		p_search.post event clicked()
end choose

end event

