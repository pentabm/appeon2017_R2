HA$PBExportHeader$pf_w_popmenufilter.srw
$PBExportComments$Pop Menu$$HEX3$$c1c058c72000$$ENDHEX$$Filter
forward
global type pf_w_popmenufilter from window
end type
type cb_1 from pf_u_commandbutton within pf_w_popmenufilter
end type
type cb_2 from pf_u_commandbutton within pf_w_popmenufilter
end type
type cb_3 from pf_u_commandbutton within pf_w_popmenufilter
end type
type cb_4 from pf_u_commandbutton within pf_w_popmenufilter
end type
type dw_criteria from pf_u_datawindow within pf_w_popmenufilter
end type
type dw_child from pf_u_datawindow within pf_w_popmenufilter
end type
end forward

global type pf_w_popmenufilter from window
integer width = 2021
integer height = 768
boolean titlebar = true
string title = "Data Filter"
boolean controlmenu = true
windowtype windowtype = response!
boolean center = true
event pfe_postopen ( )
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
dw_criteria dw_criteria
dw_child dw_child
end type
global pf_w_popmenufilter pf_w_popmenufilter

type variables
DataWindow idw_target
long il_normal_height
long il_extended_height

end variables

event pfe_postopen;long ll_cnter, ll_columncnt, nInsRow,ll_pos
string ls_column, ls_dropdownlist, ls_text

ll_columncnt = long(idw_target.describe('DataWindow.Column.Count'))
if ll_columncnt < 1 then return

for ll_cnter = 1 to ll_columncnt
	ls_column = idw_target.Describe('#' + String(ll_cnter) + '.Name')
	ls_text = idw_target.Describe(ls_column + "_t.Text")
	if ls_text = '!' or ls_text = '?' or ls_text = '' then continue
	
	ls_text = pf_f_replaceall(ls_text, '~r', '')
	ls_text = pf_f_replaceall(ls_text, '~n', '')
	ls_text = pf_f_replaceall(ls_text, '"', '')
	ls_text = pf_f_replaceall(ls_text, '~~', '')
		
	ls_dropdownlist += ls_text + '~t' + ls_column + '/'
next

dw_criteria.modify("Column_Name.Values='" + ls_dropdownlist + "'")
dw_criteria.insertrow(0)

end event

on pf_w_popmenufilter.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_criteria=create dw_criteria
this.dw_child=create dw_child
this.Control[]={this.cb_1,&
this.cb_2,&
this.cb_3,&
this.cb_4,&
this.dw_criteria,&
this.dw_child}
end on

on pf_w_popmenufilter.destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.dw_criteria)
destroy(this.dw_child)
end on

event open;idw_target = message.powerobjectparm
if not isvalid(idw_target) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(pf_w_popmenufilter)', '$$HEX17$$2cc614bc74b9c0c920004ac540c7200008c7c4b3b0c6200038d69ccd85c7c8b2e4b2$$ENDHEX$$')
	close(this)
end if

il_normal_height = this.height
il_extended_height = il_normal_height + 636

this.post event pfe_postopen()

end event

type cb_1 from pf_u_commandbutton within pf_w_popmenufilter
integer x = 1399
integer y = 528
integer width = 288
integer height = 108
string text = "$$HEX2$$55d678c7$$ENDHEX$$"
end type

event clicked;call super::clicked;long ll_row, ll_rowcnt
string ls_column, ls_operator, ls_value, ls_join
string ls_coltype, ls_filter

if dw_criteria.accepttext() = -1 then return

ll_rowcnt = dw_criteria.rowcount()
for ll_row = 1 to ll_rowcnt
	ls_column = dw_criteria.getitemstring(ll_row, 'column_name')
	if pf_f_isemptystring(ls_column) then continue

	ls_operator = dw_criteria.getitemstring(ll_row, 'operator')
	if pf_f_isemptystring(ls_operator) then continue
	
	ls_value = dw_criteria.getitemstring(ll_row, 'value')
	if pf_f_isemptystring(ls_value) then continue
	
	// make filter criteria
	if len(ls_filter) > 0 then
		ls_filter += '~r~n' + ls_join + ' '
	end if
	
	ls_coltype = idw_target.describe(ls_column + ".ColType")
	choose case ls_coltype
		case 'date'
			ls_filter += 'string(' + ls_column + ', ~'yyyy/mm/dd~')'
			ls_value = '~'' + ls_value + '~''
		case 'datetime', 'timestamp'
			ls_filter += 'string(' + ls_column + ', ~'yyyy/mm/dd hh:mm:ss~')'
			ls_value = '~'' + ls_value + '~''
		case 'time'
			ls_filter += 'string(' + ls_column + ', ~'hh:mm:ss~')'
			ls_value = '~'' + ls_value + '~''
		case 'number'
			ls_filter += ls_column
			ls_value = ls_value
		case else
			ls_filter += ls_column
			if ls_operator = 'like' and pos(ls_value, '%') = 0 then
				ls_value = '~'%' + ls_value + '%~''
			else
				ls_value = '~'' + ls_value + '~''
			end if
	end choose
	
	ls_filter += ' ' + ls_operator + ' ' + ls_value
	ls_join =  dw_criteria.getitemstring(ll_row, 'join')
next

// Reset Filter
idw_target.setfilter('')
idw_target.filter()

// Set Filter
if idw_target.setfilter(ls_filter) = 1 then
	idw_target.filter()
	idw_target.groupcalc()
	if idw_target.rowcount() = 0 then
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX15$$70c874acd0c52000deb994b2200090c7ccb800ac2000c6c5b5c2c8b2e4b2$$ENDHEX$$.')
		idw_target.setfilter('')
		idw_target.filter()
	end if
end if

close(parent)

end event

type cb_2 from pf_u_commandbutton within pf_w_popmenufilter
integer x = 1701
integer y = 528
integer width = 288
integer height = 108
string text = "$$HEX2$$e8cd8cc1$$ENDHEX$$"
end type

event clicked;close(parent)

end event

type cb_3 from pf_u_commandbutton within pf_w_popmenufilter
integer x = 27
integer y = 528
integer width = 288
integer height = 108
integer taborder = 40
string text = "$$HEX2$$94cd00ac$$ENDHEX$$"
end type

event clicked;long ll_newrow

ll_newrow = dw_criteria.insertrow(0)
dw_criteria.scrolltorow(ll_newrow)
dw_criteria.setrow(ll_newrow)

dw_child.reset()
parent.height = il_normal_height

end event

event destructor;////SetRow(row)
//String cDddwStyle, cColumnNm
//This.AcceptText()
//IF This.GetColumnName() = 'value' THEN
//	messagebox("cDddwStyle", String(This.Object.column_name[row]))
//	cDddwStyle = idw_target.Describe(This.Object.column_name[row] + ".dddw.name")
////	messagebox("cDddwStyle", cDddwStyle)
//	IF cDddwStyle <> '?' THEN
//		IF f_nvl(cDddwStyle) = FALSE THEN
//			This.Object.value.dddw.name 				= cDddwStyle
//			This.Object.value.dddw.displaycolumn 	= 'sub_name'
//			This.Object.value.dddw.datacolumn 		= 'sub_code'
//			This.Object.value.dddw.percentwidth 	= 200	
//			This.Object.value.dddw.limit 				= 15
//			This.Object.value.dddw.allowedit 		= 'yes'
//			This.Object.value.dddw.vscrollbar 		= 'yes' 
//		END IF
//	END IF
//ELSE
////	This.Object.value.style = 'edit'
//END IF
end event

type cb_4 from pf_u_commandbutton within pf_w_popmenufilter
integer x = 334
integer y = 528
integer width = 288
integer height = 108
integer taborder = 50
string text = "$$HEX2$$adc01cc8$$ENDHEX$$"
end type

event clicked;long ll_row

dw_criteria.deleterow(0)
ll_row = dw_criteria.getrow()
if ll_row > 0 then
	dw_criteria.scrolltorow(ll_row)
end if

dw_child.reset()
parent.height = il_normal_height

end event

type dw_criteria from pf_u_datawindow within pf_w_popmenufilter
integer x = 27
integer y = 32
integer width = 1961
integer height = 472
string dataobject = "pf_d_popmenufilter"
boolean vscrollbar = true
end type

event clicked;this.setrow(row)

end event

event rowfocuschanged;this.event itemchanged(currentrow, this.object.column_name, this.getitemstring(currentrow, 'column_name'))

end event

event itemchanged;choose case dwo.name
	case 'column_name'
		string ls_dataobject, ls_datacolumn, ls_dispcolumn, ls_values
		string ls_rows[], ls_items[]
		long ll_cnter, ll_rowcnt, ll_newrow
		datawindowchild ldwc_dddw
		
		choose case idw_target.describe(data + ".Edit.Style")
			case 'dddw'
				if idw_target.getchild(string(data), ldwc_dddw) = -1 then return 0
				
				ls_dataobject = idw_target.describe(data + ".DDDW.Name")
				if ls_dataobject = '!' or ls_dataobject = '?' or ls_dataobject = '' then return 0
				
				ls_datacolumn = idw_target.describe(data + ".DDDW.DataColumn")
				if ls_datacolumn = '!' or ls_datacolumn = '?' or ls_datacolumn = '' then return 0
				
				ls_dispcolumn = idw_target.describe(data + ".DDDW.DisplayColumn")
				if ls_dispcolumn = '!' or ls_dispcolumn = '?' or ls_dispcolumn = '' then return 0
				
				dw_child.dataobject = ls_dataobject
				ldwc_dddw.rowscopy(1, ldwc_dddw.rowcount(), primary!, dw_child, 1, primary!)
				parent.height = il_extended_height
				
			case 'ddlb', 'radiobuttons'
				ls_values = idw_target.describe(string(data) + ".Values")
				ll_rowcnt = pf_f_parsetoarray(ls_values, '/', ls_rows[])
				dw_child.dataobject = 'pf_d_popmenufilter_ddlb'
				for ll_cnter = 1 to ll_rowcnt
					if pf_f_parsetoarray(ls_rows[ll_cnter], '~t', ls_items) >= 2 then
						ll_newrow = dw_child.insertrow(0)
						dw_child.setitem(ll_newrow, 'dispvalue', ls_items[1])
						dw_child.setitem(ll_newrow, 'datavalue', ls_items[2])
					end if
				next
				parent.height = il_extended_height
				
			case 'checkbox'
				dw_child.dataobject = 'pf_d_popmenufilter_ddlb'
				
				ll_newrow = dw_child.insertrow(0)
				dw_child.setitem(ll_newrow, 'datavalue', idw_target.describe(string(data) + ".CheckBox.On"))
				dw_child.setitem(ll_newrow, 'dispvalue', 'DataValue for On')
				
				ll_newrow = dw_child.insertrow(0)
				dw_child.setitem(ll_newrow, 'datavalue', idw_target.describe(string(data) + ".CheckBox.Off"))
				dw_child.setitem(ll_newrow, 'dispvalue', 'DataValue for Off')
				
				if len(idw_target.describe(string(data) + ".CheckBox.Other")) > 0 then
					ll_newrow = dw_child.insertrow(0)
					dw_child.setitem(ll_newrow, 'datavalue', idw_target.describe(string(data) + ".CheckBox.Other"))
					dw_child.setitem(ll_newrow, 'dispvalue', 'DataValue for Other')
				end if
				parent.height = il_extended_height

			case else
				dw_child.reset()
				parent.height = il_normal_height
		end choose
end choose

end event

type dw_child from pf_u_datawindow within pf_w_popmenufilter
integer x = 27
integer y = 672
integer width = 1961
integer height = 600
integer taborder = 50
boolean bringtotop = true
string title = "Select item listed below"
boolean vscrollbar = true
end type

event doubleclicked;if row = 0 then return

long ll_row

ll_row = dw_criteria.getrow()
dw_criteria.setitem(ll_row, 'value', this.getitemstring(row, 1))
parent.height = il_normal_height

end event

event clicked;//IF row > 0 THEN
//	dw_criteria.SetItem(dw_criteria.GetRow(), 'value', This.GetItemString(row, "sub_code"))
////	dw_child.ReSet()
////	Parent.height = il_normal_height
//END IF
end event

