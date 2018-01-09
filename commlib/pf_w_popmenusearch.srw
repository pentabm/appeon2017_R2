HA$PBExportHeader$pf_w_popmenusearch.srw
$PBExportComments$Pop Menu$$HEX3$$c1c058c72000$$ENDHEX$$Search
forward
global type pf_w_popmenusearch from window
end type
type st_title from statictext within pf_w_popmenusearch
end type
type p_1 from picture within pf_w_popmenusearch
end type
type cb_ok from pf_u_commandbutton within pf_w_popmenusearch
end type
type cb_cancel from pf_u_commandbutton within pf_w_popmenusearch
end type
type sle_search from singlelineedit within pf_w_popmenusearch
end type
end forward

global type pf_w_popmenusearch from window
integer width = 1358
integer height = 456
boolean titlebar = true
string title = "Data Finder"
boolean controlmenu = true
windowtype windowtype = response!
boolean center = true
st_title st_title
p_1 p_1
cb_ok cb_ok
cb_cancel cb_cancel
sle_search sle_search
end type
global pf_w_popmenusearch pf_w_popmenusearch

type variables
datawindow idw_target
long il_columncnt
string is_column[]

end variables

forward prototypes
public function integer of_searchdata (long al_from, long al_to, string as_searchstr)
end prototypes

public function integer of_searchdata (long al_from, long al_to, string as_searchstr);long i, j, ll_pos
string ls_coltype, ls_editstyle, ls_data
boolean lb_lookup

if al_from < 0 then return -1
if al_to > idw_target.rowcount() then return -1

for i = al_from to al_to
	for j = 1 to il_columncnt
		ls_coltype = lower(idw_target.Describe(is_column[j] + ".coltype"))
		ll_pos = pos(ls_coltype, '(')
		if ll_pos > 0 then
			ls_coltype = trim(left(ls_coltype, ll_pos - 1))
		end if
		
		lb_lookup = false
		ls_editstyle = idw_target.describe(is_column[j] + ".Edit.Style")
		choose case ls_editstyle
			case 'dddw', 'ddlb'
				lb_lookup = true
			case 'edit'
				choose case lower(idw_target.describe(is_column[j] + ".Edit.CodeTable"))
					case 'yes', '1'
						lb_lookup = true
				end choose
			case 'editmask'
				choose case lower(idw_target.describe(is_column[j] + ".EditMask.CodeTable"))
					case 'yes', '1'
						lb_lookup = true
				end choose
		end choose
		
		if lb_lookup = true then
			ls_data = idw_target.Describe("Evaluate('LookUpDisplay(" + is_column[j] + ")', " + string(i) + ")")
		else
			choose case ls_coltype
				case 'char'
					ls_data = idw_target.getitemstring(i, is_column[j])
				case 'decimal', 'number', 'long', 'int', 'real', 'ulong'
					ls_data = string(idw_target.getitemnumber(i, is_column[j]))
				case 'date'
					ls_data = string(idw_target.getitemdate(i, is_column[j]))
				case 'datetime'
					ls_data = string(idw_target.getitemdatetime(i, is_column[j]))
				case else
					continue
			end choose
		end if
		
		if pos(ls_data, as_searchstr) > 0 then
			idw_target.setrow(i)
			idw_target.scrolltorow(i)
			idw_target.Event RowFocusChanged(i)
			return i
		end if
	next
next

return 0

end function

event open;// $$HEX8$$38d69ccd200078c790c7200055d678c7$$ENDHEX$$
idw_target = Message.PowerObjectParm
if not isvalid(idw_target) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(pf_w_popmenusearch)', '$$HEX17$$2cc614bc74b9c0c920004ac540c7200008c7c4b3b0c6200038d69ccd85c7c8b2e4b2$$ENDHEX$$')
	close(this)
end if

// $$HEX5$$eccefcb720002fac18c2$$ENDHEX$$
il_columncnt = long(idw_target.describe("Datawindow.Column.Count"))
if il_columncnt <= 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX23$$74d5f9b2200070b374c730d108c7c4b3b0c6d0c5200080acc9c060d520006dd5a9ba74c72000c6c5b5c2c8b2e4b2$$ENDHEX$$')
	close(this)
end if

// $$HEX8$$eccefcb7200085ba6dce2000f4bc00ad$$ENDHEX$$long i
long i

for i = 1 to il_columncnt
	is_column[i] = idw_target.describe('#' + string(i) + '.Name')
next

end event

on pf_w_popmenusearch.create
this.st_title=create st_title
this.p_1=create p_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.sle_search=create sle_search
this.Control[]={this.st_title,&
this.p_1,&
this.cb_ok,&
this.cb_cancel,&
this.sle_search}
end on

on pf_w_popmenusearch.destroy
destroy(this.st_title)
destroy(this.p_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.sle_search)
end on

event key;if key = KeyEscape! then
	cb_cancel.triggerevent(clicked!)
end if

end event

type st_title from statictext within pf_w_popmenusearch
integer x = 110
integer y = 32
integer width = 731
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20395836
string text = "$$HEX14$$80acc9c060d5200038bb90c7f4c544c7200085c725b858d538c194c6$$ENDHEX$$."
long bordercolor = 1073741824
boolean focusrectangle = false
end type

type p_1 from picture within pf_w_popmenusearch
integer x = 46
integer y = 44
integer width = 46
integer height = 40
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type cb_ok from pf_u_commandbutton within pf_w_popmenusearch
integer x = 699
integer y = 248
integer width = 293
integer height = 100
integer taborder = 20
string text = "$$HEX2$$80acc9c0$$ENDHEX$$"
boolean default = true
end type

event clicked;string ls_searchstr, ls_data, ls_coltype, ls_editstyle
boolean lb_lookup
long i, j
long ll_rowcnt, ll_row, ll_pos

ls_searchstr = trim(sle_search.text)
if isnull(ls_searchstr) or len(trim(ls_searchstr)) = 0 then
	messagebox("$$HEX2$$bdace0ac$$ENDHEX$$","$$HEX14$$80acc9c060d5200038bb90c77cb9200085c725b858d5edc2dcc224c6$$ENDHEX$$!")
	sle_search.setfocus()
	return
end if

ll_row = idw_target.getrow() + 1
ll_rowcnt = idw_target.rowcount()
if ll_rowcnt = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX18$$80acc9c060d5200070b374c730d100ac200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$')
	return
end if

setpointer(hourglass!)
if parent.of_searchdata(ll_row, ll_rowcnt, ls_searchstr) > 0 then return
if parent.of_searchdata(1, ll_row - 1, ls_searchstr) > 0 then return
setpointer(arrow!)

messagebox('$$HEX2$$55d678c7$$ENDHEX$$', '$$HEX15$$74d5f9b2200038bb90c77cb920003ecc44c718c22000c6c5b5c2c8b2e4b2$$ENDHEX$$!')
return

end event

type cb_cancel from pf_u_commandbutton within pf_w_popmenusearch
integer x = 1015
integer y = 248
integer width = 302
integer height = 100
integer taborder = 20
string text = "$$HEX2$$e8cd8cc1$$ENDHEX$$"
end type

event clicked;CloseWithReturn(Parent, '')
end event

type sle_search from singlelineedit within pf_w_popmenusearch
event ue_keydown pbm_dwnkey
integer x = 23
integer y = 132
integer width = 1303
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX2$$74adbcb9$$ENDHEX$$"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

