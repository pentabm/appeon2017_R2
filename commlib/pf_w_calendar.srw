HA$PBExportHeader$pf_w_calendar.srw
$PBExportComments$$$HEX14$$ecb225b8e8ceb8d264b8a9c6200008c7c4b3b0c6200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_calendar from window
end type
type dw_cal from datawindow within pf_w_calendar
end type
end forward

global type pf_w_calendar from window
integer width = 960
integer height = 800
windowtype windowtype = child!
long backcolor = 16777215
string icon = "AppIcon!"
event pfe_postopen ( )
dw_cal dw_cal
end type
global pf_w_calendar pf_w_calendar

type prototypes
FUNCTION boolean AnimateWindow(long lhWnd, long lTm, long lFlags ) library 'user32.dll'
FUNCTION boolean GetCursorPos(REF pf_s_POINT ipPoint) LIBRARY "user32.dll"
FUNCTION boolean ScreenToClient(ulong hWnd, ref pf_s_POINT lpPoint) Library "USER32.DLL"

end prototypes

type variables
window iw_parent
windowobject iwo_parent
dwobject idwo_parent
long il_row
pf_n_animate inv_dropdown
string is_getfocused
date id_dateselected

// mouseover checking
pf_s_point istr_point
pf_n_timing inv_timer
boolean ib_mouseover
string is_mouseover
integer ii_mouseover = -1

end variables

forward prototypes
public function string of_getpresentationstyle (datawindow ldw_target)
public function integer of_drawmonth (integer ai_year, integer ai_month)
public function integer of_getdaysinmonth (integer ai_year, integer ai_month)
public function integer of_selectdate (integer ai_year, integer ai_month, integer ai_day)
public subroutine of_highlightcolumn ()
public function integer of_selectdate (integer ai_day)
public function integer of_movefocusedcolumn (string as_direction)
public function integer of_setparentdate (string as_dateselected)
public function date of_relativemonth (date adt_source, long al_month)
end prototypes

public function string of_getpresentationstyle (datawindow ldw_target);// $$HEX13$$70b374c730d108c7c4b3b0c6200024c60cbe1dc8b8d258c72000$$ENDHEX$$Presentation Style$$HEX6$$44c72000acb934d15cd5e4b2$$ENDHEX$$

string ls_processing, ls_style

ls_processing = ldw_target.describe("datawindow.processing")
choose case long(ls_processing)
	case 0
		//FreeForm$$HEX5$$78c72000bdacb0c62000$$ENDHEX$$: detail band height$$HEX2$$00ac2000$$ENDHEX$$dw control$$HEX2$$58c72000$$ENDHEX$$height$$HEX2$$58c72000$$ENDHEX$$2.5$$HEX4$$30bc2000f8bbccb9$$ENDHEX$$($$HEX3$$ccb97dc52000$$ENDHEX$$Header$$HEX10$$00ac200088c794b2bdacb0c67cb9200000b344be$$ENDHEX$$)
		long ll_detailheight, ll_dwcontrolheight, ll_headerheight
		
		ll_headerheight = long(ldw_target.describe("Datawindow.Header.Height"))
		ll_detailheight = long(ldw_target.describe("Datawindow.Detail.Height"))
		ll_dwcontrolheight = ldw_target.Height
		
		if ll_headerheight > pixelstounits(10, ypixelstounits!) then
			ls_style = "Tabular"
		elseif ll_detailheight * 2.2 < ll_dwcontrolheight then
			ls_style = "Tabular"
		else
			ls_style = "Freeform"
		end if
	case 1
		ls_style = 'Grid'
	case 2
		ls_style = 'Label'
	case 3
		ls_style = 'Graph'
	case 4
		ls_style = 'Crosstab'
	case 5
		ls_style = 'Composite'
	case 6
		ls_style = 'OLE'
	case 7
		ls_style = 'RichText'
	case 8
		ls_style = 'TreeView'
	case 9
		ls_style = 'TreeViewWithGrid'
	Case Else
		ls_style = 'Etc'
end choose

return ls_style

end function

public function integer of_drawmonth (integer ai_year, integer ai_month);//
integer li_daysinmonth, li_firstdaynum, i
date ld_firstday
string ls_syntax, ls_error

dw_cal.setredraw(false)
dw_cal.reset()
dw_cal.insertrow(0)

li_daysinmonth = of_getdaysinmonth(ai_year, ai_month)
ld_firstday = date(ai_year, ai_month, 1)
li_firstdaynum = daynumber(ld_firstday)

// save current year & month
dw_cal.setitem(1, 'year', ai_year)
dw_cal.setitem(1, 'month', ai_month)
dw_cal.setitem(1, 'firstdaynum', li_firstdaynum)

for i = 1 to 42
	if i < li_firstdaynum then
		dw_cal.setitem(1, 'cell' + string(i), string(day(relativedate(ld_firstday, -li_firstdaynum + i))))
		ls_syntax += 'cell' + string(i) + '.color="' + string(rgb(220,220,220)) + '"~r~n'
		ls_syntax += 'cell' + string(i) + '.tag="previous"~r~n'
	elseif i < li_firstdaynum + li_daysinmonth then
		dw_cal.setitem(1, 'cell' + string(i), string(i - li_firstdaynum + 1))
		choose case mod(i, 7)
			case 0; ls_syntax += 'cell' + string(i) + '.color="' + string(rgb(34,117,195)) + '"~r~n'
			case 1; ls_syntax += 'cell' + string(i) + '.color="' + string(rgb(255,0,0)) + '"~r~n'
			case else; ls_syntax += 'cell' + string(i) + '.color="' + string(rgb(101,103,110)) + '"~r~n'
		end choose
		ls_syntax += 'cell' + string(i) + '.tag=""~r~n'
	else
		dw_cal.setitem(1, 'cell' + string(i), string(i - li_firstdaynum - li_daysinmonth + 1))
		ls_syntax += 'cell' + string(i) + '.color="' + string(rgb(220,220,220)) + '"~r~n'
		ls_syntax += 'cell' + string(i) + '.tag="next"~r~n'
	end if
next

if len(ls_syntax) > 0 then
	ls_error = dw_cal.Modify(ls_syntax)
	if len(ls_error) > 0 then
		::clipboard(ls_syntax)
		messagebox("Error", dw_cal.classname() + " Syntax Modification Failure!! : " + ls_error)
		return -1
	end if
end if

dw_cal.setredraw(true)
return 0

end function

public function integer of_getdaysinmonth (integer ai_year, integer ai_month);//

if isnull(ai_year) then return -1
if isnull(ai_month) then return -1

integer li_days[12] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
integer li_daysinmonth

li_daysinmonth = li_days[ai_month]
if ai_month = 2 then
	if (mod(ai_year, 4) = 0 and mod(ai_year, 100) <> 0) or mod(ai_year,400) = 0 then
		li_daysinmonth = 29
	end if
end if

return li_daysinmonth

end function

public function integer of_selectdate (integer ai_year, integer ai_month, integer ai_day);if dw_cal.rowcount() = 0 then
	this.of_drawmonth(ai_year, ai_month)
end if

if dw_cal.getitemnumber(1, 'year') <> ai_year or dw_cal.getitemnumber(1, 'month') <> ai_month then
	this.of_drawmonth(ai_year, ai_month)
end if

return this.of_selectdate(ai_day)

end function

public subroutine of_highlightcolumn ();
end subroutine

public function integer of_selectdate (integer ai_day);integer li_firstdaynum

li_firstdaynum = dw_cal.getitemnumber(1, 'firstdaynum')

// deselect
if is_getfocused <> '' then
	dw_cal.modify(is_getfocused + ".border=0")
end if

// select
is_getfocused = 'cell' + string(li_firstdaynum + ai_day - 1)
dw_cal.modify(is_getfocused + ".border=5")

return 0

end function

public function integer of_movefocusedcolumn (string as_direction);if is_getfocused = '' then return -1

integer li_colseq
integer li_year, li_month

li_colseq = integer(mid(is_getfocused, 5))

choose case as_direction
	case 'up'
		li_colseq -= 7
	case 'down'
		li_colseq += 7
	case 'left'
		li_colseq --
	case 'right'
		li_colseq ++
end choose

choose case li_colseq
	case is < 1
		li_year = dw_cal.getitemnumber(1, 'year')
		li_month = dw_cal.getitemnumber(1, 'month')
		
		li_month --
		if li_month = 0 then
			li_year --
			li_month = 12
		end if
		
		of_drawmonth(li_year, li_month)
		li_colseq += 42

	case is > 42
		li_year = dw_cal.getitemnumber(1, 'year')
		li_month = dw_cal.getitemnumber(1, 'month')
		
		li_month ++
		if li_month > 12 then
			li_year ++
			li_month = 1
		end if
		
		of_drawmonth(li_year, li_month)
		li_colseq -= 42
end choose

// deselect
dw_cal.modify(is_getfocused + ".border=0")

// select
is_getfocused = 'cell' + string(li_colseq)

dw_cal.modify(is_getfocused + ".border=5")
dw_cal.setredraw(true)

return 0

end function

public function integer of_setparentdate (string as_dateselected);if isnull(iwo_parent) or not isvalid(iwo_parent) then return -1

date ld_selected
ld_selected = date(string(as_dateselected, '@@@@-@@-@@'))
if isnull(ld_selected) or ld_selected = 1900-01-01 then return -1

choose case iwo_parent.typeof()
	case editmask!
		editmask lem_parent
		lem_parent = iwo_parent
		
		choose case lem_parent.maskdatatype
			case datemask!, datetimemask!
				lem_parent.text = string(ld_selected, lem_parent.mask)
			case stringmask!
				lem_parent.text = as_dateselected
			case else
				return -1
		end choose
		
		lem_parent.post event modified()
		
	case datawindow!
		datawindow ldw_parent
		ldw_parent = iwo_parent
		
		choose case lower(left(ldw_parent.describe(string(idwo_parent.name) + ".ColType"), 5))
			case "char(", "char"
				ldw_parent.setrow(il_row)
				if ldw_parent.setcolumn(string(idwo_parent.name)) <> 1 then return -1
				if lower(ldw_parent.describe(string(idwo_parent.name) + ".ColType")) = 'char(6)' then
					ldw_parent.settext(left(as_dateselected,6))
				else
					ldw_parent.settext(as_dateselected)
				end if
				ldw_parent.post accepttext()
				
				/*
				if lower(ldw_parent.describe(string(idwo_parent.name) + ".ColType")) = 'char(6)' then
					ldw_parent.setitem(il_row, string(idwo_parent.name), left(as_dateselected,6))
				elseif lower(ldw_parent.describe(string(idwo_parent.name) + ".ColType")) = 'char(8)' then
					ldw_parent.setitem(il_row, string(idwo_parent.name), as_dateselected)
				else
					ldw_parent.setitem(il_row, string(idwo_parent.name), as_dateselected)
				end if
				ldw_parent.post event itemchanged(il_row, idwo_parent, as_dateselected)
				*/
			case "date", "datet"
				ldw_parent.setrow(il_row)
				if ldw_parent.setcolumn(string(idwo_parent.name)) <> 1 then return -1
				ldw_parent.settext(string(as_dateselected, '@@@@/@@/@@'))
				ldw_parent.post accepttext()
				
				/*
				ldw_parent.setitem(il_row, string(idwo_parent.name), ld_selected)
				ldw_parent.post event itemchanged(il_row, idwo_parent, string(ld_selected))
				*/
			case else
				return -1
		end choose
end choose

return 1

end function

public function date of_relativemonth (date adt_source, long al_month);long ll_year, ll_month, ll_day, ll_relative

ll_year = year(adt_source)
ll_month = month(adt_source)
ll_day = day(adt_source)

ll_relative = ll_year * 12 + ll_month + al_month

ll_year = long(ll_relative / 12)
ll_month = mod(ll_relative, 12)

do while date(ll_year, ll_month, ll_day) = 1900-01-01
	ll_day --
loop

return date(ll_year, ll_month, ll_day)

end function

on pf_w_calendar.create
this.dw_cal=create dw_cal
this.Control[]={this.dw_cal}
end on

on pf_w_calendar.destroy
destroy(this.dw_cal)
end on

event open;iwo_parent = gnv_session.of_get('pf_w_calendar.parent_object')
if not isvalid(iwo_parent) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(pf_w_calendar)', '$$HEX17$$98c7bbba1cb42000ecb225b8200024c60cbe1dc8b8d2200038d69ccd85c7c8b2e4b2$$ENDHEX$$')
	return
end if

//this.width = dw_cal.width + pixelstounits(1, xpixelstounits!)
//this.height = dw_cal.height + pixelstounits(2, ypixelstounits!)

powerobject lpo_parent
long ll_xpos, ll_ypos

if not isvalid(inv_dropdown) then
	inv_dropdown = create pf_n_animate
end if

// MDI Position
//ll_xpos += gnv_appmgr.iw_mainframe.workspaceX()
//ll_ypos += gnv_appmgr.iw_mainframe.workspaceY()

// $$HEX8$$80bda8ba2000e8ceb8d264b858c72000$$ENDHEX$$X,Y $$HEX8$$8cc85cd47cb920006cad69d5c8b2e4b2$$ENDHEX$$.
lpo_parent = iwo_parent.getparent()
do while isvalid(lpo_parent)
	choose case lpo_parent.typeof()
		case tab!
			tab ltab
			ltab = lpo_parent
			ll_xpos += ltab.x
			ll_ypos += ltab.y
		case userobject!
			userobject luo
			luo = lpo_parent
			ll_xpos += luo.x
			ll_ypos += luo.y
		case window!
			iw_parent = lpo_parent
			//ll_xpos += iw_parent.workspacex()
			//ll_ypos += iw_parent.workspacey()
			exit
	end choose
	lpo_parent = lpo_parent.getparent()
loop

if not isvalid(iw_parent) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(pf_w_calendar)', '$$HEX17$$80bda8ba200008c7c4b3b0c67cb920003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$.')
	return
end if

// $$HEX25$$24c60cbe1dc8b8d258c72000c0d085c7d0c5200030b57cb72000ecb225b8200004c758ce7cb9200070c808c869d5c8b2e4b2$$ENDHEX$$.
string ls_date
date ld_date

choose case iwo_parent.typeof()
	case editmask!
		editmask lem

		lem = iwo_parent
		ll_xpos += lem.x
		ll_ypos += lem.y + lem.height
		
		ls_date = lem.text
		if isdate(ls_date) then
			id_dateselected = date(ls_date)
		end if
		
	case datawindow!
		datawindow ldw_parent
		
		ldw_parent = iwo_parent
		idwo_parent = gnv_session.of_get('pf_w_calendar.dwobject')
		il_row = gnv_session.of_getint('pf_w_calendar.row')
		
		if this.of_getpresentationstyle(ldw_parent)  = 'Freeform' then
			ll_xpos += ldw_parent.x + long(idwo_parent.x)
			ll_ypos += ldw_parent.y + long(idwo_parent.y) + long(idwo_parent.height) + pixelstounits(2, ypixelstounits!)
		else
			ll_xpos += ldw_parent.x + ldw_parent.pointerx()
			ll_ypos += ldw_parent.y + ldw_parent.pointery() + pixelstounits(2, ypixelstounits!)
		end if
		
		choose case lower(left(ldw_parent.describe(string(idwo_parent.name) + ".ColType"), 5))
			case "char(", "char"
				ls_date = ldw_parent.getitemstring(il_row, string(idwo_parent.name))
				ls_date = string(ls_Date, '@@@@/@@/@@')
				if isdate(ls_date) then
					id_dateselected = date(ls_date)
				end if
			case "date"
				ld_date = ldw_parent.getitemdate(il_row, string(idwo_parent.name))
				if not isnull(ld_date) and ld_date > 1900-01-01 then
					id_dateselected = ld_date
				end if
			case "datet"
				ld_date = date(ldw_parent.getitemdatetime(il_row, string(idwo_parent.name)))
				if not isnull(ld_date) and ld_date > 1900-01-01 then
					id_dateselected = ld_date
				end if
			case else
				messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX3$$38bb90c72000$$ENDHEX$$or $$HEX28$$a0b090c72000c0d085c72000eccefcb7d0c5ccb92000ecb225b8200024c60cbe1dc8b8d27cb92000acc0a9c600aca5b2200069d5c8b2e4b2$$ENDHEX$$')
				return
		end choose
end choose

// $$HEX25$$80bda8ba200008c7c4b3b0c620006cd030aed0c52000deb98cac2000ecb225b8200004c758ce200070c815c869d5c8b2e4b2$$ENDHEX$$.
integer li_direction

if ll_xpos + this.width > iw_parent.workspacewidth() then
	ll_xpos = iw_parent.workspacewidth() - this.width
end if

// $$HEX11$$60c5c8b254ba74c758c1200029bca5d5200024c115c8$$ENDHEX$$
//if ll_ypos + this.height - iw_parent.workspacey() > iw_parent.workspaceheight() then
if ll_ypos + this.height > iw_parent.workspaceheight() then
	ll_ypos -= this.height
	li_direction = inv_dropdown.BottomUp
else
	li_direction = inv_dropdown.TopDown
end if

this.x = ll_xpos
this.y = ll_ypos

// $$HEX5$$7cc790c7200024c115c8$$ENDHEX$$
if isnull(id_dateselected) or id_dateselected = 1900-01-01 then
	id_dateselected = today()
end if

// $$HEX3$$ecb225b82000$$ENDHEX$$DRAW
this.of_drawmonth(year(id_dateselected), month(id_dateselected))
this.of_selectdate(day(id_dateselected))

// $$HEX18$$80d4e4b2b4c6200015d6dcd05cb8200008c7c4b3b0c600ac200024c608d529b4c8b2e4b2$$ENDHEX$$.
if appeongetclienttype() = 'PB' then
	this.width = dw_cal.width
	this.height = dw_cal.height

	inv_dropdown.of_initialize(this, li_direction)
	inv_dropdown.of_show()
else
	// Child $$HEX25$$08c7c4b3b0c62000acc074c788c900ac20000cd3ccc64cbe54b340c62000ecb27cb72000acc074c788c9200000c8a5c768d5$$ENDHEX$$(2013R2 $$HEX2$$30ae00c9$$ENDHEX$$)
	this.width = dw_cal.width - pixelstounits(10, xpixelstounits!)
	this.height = dw_cal.height - pixelstounits(11, ypixelstounits!)
end if

dw_cal.setredraw(true)
dw_cal.setfocus()

this.post event pfe_postopen()

end event

event close;gnv_session.of_remove('pf_w_calendar.parent_object')

if appeongetclienttype() = 'PB' then
	if isvalid(inv_dropdown) then
		inv_dropdown.of_hide()
	end if
end if

destroy inv_dropdown

// $$HEX16$$38d69ccd5cd5200024c60cbe1dc8b8d25cb82000ecd3e4cea4c22000c0bcbdac$$ENDHEX$$
iwo_parent.post dynamic setfocus()

end event

type dw_cal from datawindow within pf_w_calendar
event ue_dwnkey pbm_dwnkey
event mousemove pbm_dwnmousemove
event pfe_mouseover ( long row,  dwobject dwo )
event timer pbm_timer
event pfe_mouseleave ( )
integer width = 951
integer height = 788
integer taborder = 10
string dataobject = "pf_d_calendar"
boolean border = false
end type

event ue_dwnkey;CHOOSE CASE key
	CASE KeyHome!
		this.event clicked(0, 0, this.getrow(), this.object.p_nextyear)
	CASE KeyEnd!
		this.event clicked(0, 0, this.getrow(), this.object.p_preyear)
	CASE KeyPageUp!
		this.event clicked(0, 0, this.getrow(), this.object.p_nextmonth)
	CASE KeyPageDown!
		this.event clicked(0, 0, this.getrow(), this.object.p_premonth)
	CASE KeyRightArrow!
		of_movefocusedcolumn('right')
	CASE KeyLeftArrow!
		of_movefocusedcolumn('left')
	CASE KeyUpArrow!
		of_movefocusedcolumn('up')
	CASE KeyDownArrow!
		of_movefocusedcolumn('down')
	CASE KeyEscape!
		post close(parent)
	CASE KeyEnter!
		if is_getfocused <> '' then
			integer li_year, li_month, li_day
			date ldt_relative
			
			li_year = this.getitemnumber(this.getrow(), 'year')
			li_month = this.getitemnumber(this.getrow(), 'month')
			li_day = integer(this.getitemstring(this.getrow(), is_getfocused))
			if isnull(li_day) or li_day = 0 then return
			
			choose case this.describe(is_getfocused + '.Tag')
				case 'previous'
					ldt_relative = of_relativemonth(date(li_year, li_month, 1), -1)
					li_year = year(ldt_relative)
					li_month = month(ldt_relative)
				case 'next'
					ldt_relative = of_relativemonth(date(li_year, li_month, 1), +1)
					li_year = year(ldt_relative)
					li_month = month(ldt_relative)
			end choose
			
			of_setparentdate(string(li_year, '0000') + string(li_month, '00') + string(li_day, '00'))
			post close(parent)
		end if
END CHOOSE

end event

event mousemove;if ib_mouseover = false then
	ib_mouseover = true
	inv_timer.of_start()
end if

if ii_mouseover <> row or is_mouseover <> string(dwo.name) then
	this.event pfe_mouseover(row, dwo)
	ii_mouseover = row
	is_mouseover = string(dwo.name)
end if

end event

event pfe_mouseover(long row, dwobject dwo);if row = 0 then return
if isnull(dwo) then return

choose case left(dwo.name, 4)
	case 'cell'
		this.setitem(row, 'mouseover', string(dwo.name))
end choose

end event

event timer;if gnv_extfunc.GetCursorPos(istr_point) then
	if gnv_extfunc.ScreenToClient(handle(this), istr_point) then
		if istr_point.xpos >= 0 and istr_point.ypos >= 0 and istr_point.xpos <= unitstopixels(this.width, xunitstopixels!) and istr_point.ypos <= unitstopixels(this.height, yunitstopixels!) then
		else
			ib_mouseover = false
			inv_timer.stop()
			this.post event pfe_mouseleave()
		end if
	end if
end if

end event

event clicked;if row = 0 then return
if isnull(dwo) then return
integer li_year, li_month, li_day

// $$HEX5$$7cc790c7200020c1ddd0$$ENDHEX$$
if left(dwo.name, 4) = "cell" then
	choose case string(dwo.tag)
		case 'previous'
			this.post event clicked(0, 0, row, this.object.p_premonth)
			parent.post of_selectdate(long(this.getitemstring(row, string(dwo.name))))
		case 'next'
			this.post event clicked(0, 0, row, this.object.p_nextmonth)
			parent.post of_selectdate(long(this.getitemstring(row, string(dwo.name))))
		case else
			li_day = long(this.getitemstring(row, string(dwo.name)))
			if li_day > 0 then
				parent.of_selectdate(li_day)
				
				li_year = this.getitemnumber(row, 'year')
				li_month = this.getitemnumber(row, 'month')
				if isnull(li_day) or li_day = 0 then return

				of_setparentdate(string(li_year, '0000') + string(li_month, '00') + string(li_day, '00'))
				post close(parent)
			end if
			return
	end choose
end if

// $$HEX3$$74c704c8d4c6$$ENDHEX$$, $$HEX3$$e4b24cc7d4c6$$ENDHEX$$
long ll_monthcnt

if left(dwo.name, 5) = 'p_pre' or left(dwo.name, 6) = 'p_next' then
	li_year = this.getitemnumber(row, 'year')
	li_month = this.getitemnumber(row, 'month')
	ll_monthcnt = li_year * 12 + li_month

	choose case dwo.name
		case 'p_preyear'
			ll_monthcnt -= 12
		case 'p_premonth'
			ll_monthcnt -= 1
		case 'p_nextyear'
			ll_monthcnt += 12
		case 'p_nextmonth'
			ll_monthcnt += 1
	end choose
	
	ll_monthcnt --
	li_year = truncate(ll_monthcnt / 12, 0)
	li_month = mod(ll_monthcnt, 12) + 1
	parent.of_drawmonth(li_year, li_month)
end if

// $$HEX2$$ebb230ae$$ENDHEX$$, $$HEX2$$24c698b2$$ENDHEX$$, $$HEX8$$20c1ddd0200084bcbcd2200094cd00ac$$ENDHEX$$
choose case dwo.name
	case 't_close'
		post close(parent)
	case 't_today'
		date ld_today
		ld_today = Today()
		of_selectdate(year(ld_today), month(ld_today), day(ld_today))
	case 't_select'
		if is_getfocused = '' then return
		
		li_year = this.getitemnumber(row, 'year')
		li_month = this.getitemnumber(row, 'month')
		li_day = integer(this.getitemstring(row, is_getfocused))
		if isnull(li_day) or li_day = 0 then return
		
		of_setparentdate(string(li_year, '0000') + string(li_month, '00') + string(li_day, '00'))
		post close(parent)
end choose

// $$HEX7$$1cacc4bc2000d4c6200084bcbcd2$$ENDHEX$$
if left(dwo.name, 7) = 't_month' then
	li_year = this.getitemnumber(row, 'year')
	li_month = integer(mid(dwo.name, 8))
	parent.of_drawmonth(li_year, li_month)	
end if

end event

event doubleclicked;//if row = 0 then return
//if left(dwo.name, 4) <> 'cell' then return
//if is_getfocused = '' then return
//
//integer li_year, li_month, li_day
//
//li_year = this.getitemnumber(row, 'year')
//li_month = this.getitemnumber(row, 'month')
//li_day = integer(this.getitemstring(row, is_getfocused))
//if isnull(li_day) or li_day = 0 then return
//
//of_setparentdate(string(li_year, '0000') + string(li_month, '00') + string(li_day, '00'))
//post close(parent)

end event

event losefocus;// $$HEX12$$ecd3e4cea4c2200083c794b22000bdacb0c6200085c8ccb8$$ENDHEX$$
post close(parent)

end event

event constructor;// properties monitor
inv_timer = create pf_n_timing
inv_timer.of_initialize(this)

end event

event destructor;if isvalid(inv_timer) then
	destroy inv_timer
end if

end event

