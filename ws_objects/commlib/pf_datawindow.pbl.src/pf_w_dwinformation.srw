$PBExportHeader$pf_w_dwinformation.srw
forward
global type pf_w_dwinformation from pf_w_response
end type
type tab_1 from tab within pf_w_dwinformation
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from pf_u_datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from pf_u_datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_3 from pf_u_datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_3 dw_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_4 from pf_u_datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_4 dw_4
end type
type tabpage_5 from userobject within tab_1
end type
type dw_5 from pf_u_datawindow within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_5 dw_5
end type
type tabpage_6 from userobject within tab_1
end type
type dw_6 from pf_u_datawindow within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_6 dw_6
end type
type tabpage_7 from userobject within tab_1
end type
type dw_7 from pf_u_datawindow within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_7 dw_7
end type
type tab_1 from tab within pf_w_dwinformation
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type
end forward

global type pf_w_dwinformation from pf_w_response
string title = "Datawindow Information"
string icon = "Asterisk!"
tab_1 tab_1
end type
global pf_w_dwinformation pf_w_dwinformation

type variables
pf_u_datawindow idw_org
pf_u_datawindow idw_dwo, idw_col, idw_query, idw_args, idw_sort, idw_filter, idw_data

end variables

forward prototypes
public function integer of_setdwobjectinfo ()
public function integer of_setcolumninfo ()
public function integer of_setqueryinfo ()
public function integer of_setargumentinfo ()
public function integer of_setsortinfo ()
public function integer of_setfilterinfo ()
public function integer of_setdatainfo ()
end prototypes

public function integer of_setdwobjectinfo ();idw_dwo.reset()
idw_dwo.insertrow(1)

// dwobject name
idw_dwo.setitem(1, 'dwobject', idw_org.dataobject)

// ancestor
classdefinition lcd_org, lcd_parent, lcd_ancestor

lcd_org = idw_org.classdefinition
lcd_parent = lcd_org.parentclass
lcd_ancestor = lcd_org.ancestor

idw_dwo.setitem(1, 'parentobj', lcd_parent.name)
idw_dwo.setitem(1, 'ancestor', lcd_ancestor.name)

// library name
idw_dwo.setitem(1, 'libraryname', lcd_org.libraryname)

// title
idw_dwo.setitem(1, 'title', idw_org.title)

// presentation style
string ls_processing
string ls_printpreview
string ls_style

ls_printpreview = lower(idw_org.describe("DataWindow.Print.Preview"))

ls_processing = idw_org.describe("datawindow.processing")
choose case long(ls_processing)
	case 0
		if ls_printpreview = "yes" or ls_printpreview = "1" then
			ls_style = "PrintPreview"
		else
			//FreeForm인 경우 : detail band height가 dw control의 height의 2.5배 미만(만약 Header가 있는경우를 대비)
			long ll_detailheight, ll_dwcontrolheight, ll_headerheight
			
			ll_headerheight = long(idw_org.describe("Datawindow.Header.Height"))
			ll_detailheight = long(idw_org.describe("Datawindow.Detail.Height"))
			ll_dwcontrolheight = idw_org.Height
			
			if ll_headerheight > pixelstounits(10, ypixelstounits!) then
				ls_style = "Tabular"
			elseif ll_detailheight * 2.2 < ll_dwcontrolheight then
				ls_style = "Tabular"
			else
				ls_style = "Freeform"
			end if
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

idw_dwo.setitem(1, 'presentationstyle', ls_style)

// datasource
string ls_syntax, ls_datasource
long ll_pos
long ll_external, ll_normal, ll_websvc

ls_syntax = idw_org.describe("datawindow.syntax")
ll_pos = pos(ls_syntax, "~r~ntable(")
if ll_pos > 0 then
	ll_external = pos(ls_syntax, "data(", ll_pos + 8)
	ll_normal = pos(ls_syntax, "retrieve=~"", ll_pos + 8)
	ll_websvc = pos(ls_syntax, "webservice=(", ll_pos + 8)
	
	if ll_external > 0 then
		ls_datasource = 'External'
	elseif ll_normal > 0 then
		if pos(ls_syntax, "procedure=~"1 execute ", ll_pos + 8) > 0 then
			ls_datasource = 'StoredProcedure'
		else
			ls_datasource = 'Select'
		end if
	elseif ll_websvc > 0 then
		ls_datasource = 'Web Service'
	else
		ls_datasource = 'External'
	end if
	
	idw_dwo.setitem(1, 'datasource', ls_datasource)
end if

// allow updates, update table
string ls_updatetable

ls_updatetable = idw_org.describe("datawindow.table.updateTable")
if ls_updatetable = '?' or ls_updatetable = '!' then ls_updatetable = ''

if not isnull(ls_updatetable) and len(trim(ls_updatetable)) > 0 then
	idw_dwo.setitem(1, 'allowupdates', 'Y')
	idw_dwo.setitem(1, 'tabletoupdate', ls_updatetable)
else
	idw_dwo.setitem(1, 'allowupdates', 'N')
	idw_dwo.setitem(1, 'tabletoupdate', '')
end if

return 0

end function

public function integer of_setcolumninfo ();long ll_columncnt, i
string ls_colname, ls_coltype, ls_editstyle
string ls_initial, ls_validation, ls_validationmsg
string ls_dbname, ls_dddwname

idw_col.reset()

ll_columncnt = long(idw_org.describe("datawindow.column.count"))
for i = 1 to ll_columncnt
	idw_col.insertrow(i)
	
	ls_colname = idw_org.describe("#" + string(i) + ".Name")
	ls_coltype = idw_org.describe("#" + string(i) + ".ColType")
	ls_editstyle = idw_org.describe("#" + string(i) + ".Edit.Style")
	if ls_editstyle = '?' then
		ls_editstyle = 'n/a'
	end if
	
	ls_initial = idw_org.describe("#" + string(i) + ".Initial")
	ls_validation = idw_org.describe("#" + string(i) + ".Validation")
	if ls_validation = '?' then
		ls_validation = ''
	end if
		
	ls_validationmsg = idw_org.describe("#" + string(i) + ".ValidationMsg")
	if ls_validationmsg = '?' then
		ls_validationmsg = ''
	end if
	
	ls_dbname = idw_org.describe("#" + string(i) + ".dbName")
	
	if ls_editstyle = 'dddw' then
		ls_dddwname = idw_org.describe("#" + string(i) + ".DDDW.Name")
	else
		ls_dddwname = ''
	end if

	idw_col.setitem(i, 'colname', ls_colname)
	idw_col.setitem(i, 'coltype', ls_coltype)
	idw_col.setitem(i, 'editstyle', ls_editstyle)
	idw_col.setitem(i, 'validationexpression', ls_validation)
	idw_col.setitem(i, 'validationmessage', ls_validationmsg)
	idw_col.setitem(i, 'dbname', ls_dbname)
	idw_col.setitem(i, 'dddwname', ls_dddwname)
next


return 0

end function

public function integer of_setqueryinfo ();string ls_query
string ls_datasource

idw_query.reset()
idw_query.insertrow(0)

ls_datasource = idw_dwo.getitemstring(1, 'datasource')
choose case ls_datasource
	case 'Select'
		ls_query = idw_org.describe("datawindow.Table.SQLSelect")
		//ls_query = idw_org.describe("datawindow.Table.Select")
	case 'StoredProcedure'
		ls_query = idw_org.describe("datawindow.Table.Procedure")
	case else
		ls_query = ''
end choose

idw_query.setitem(1, 'dwquery', ls_query)
return 0

end function

public function integer of_setargumentinfo ();idw_args.reset()

string ls_arguments

ls_arguments = trim(idw_org.describe("Datawindow.Table.Arguments"))
if ls_arguments = '?' or ls_arguments = '!' or ls_arguments = '' then return 0

string ls_linebuf[]
string ls_itembuf[]
integer li_line, i
string ls_argname, ls_argtype, ls_argvalue

li_line = pf_f_parsetoarray(ls_arguments, '~n', ls_linebuf)
for i = 1 to li_line
	if pf_f_parsetoarray(ls_linebuf[i], '~t', ls_itembuf) <> 2 then continue
	
	ls_argname = trim(ls_itembuf[1])
	ls_argtype = trim(ls_itembuf[2])
	ls_argvalue = idw_org.describe("Evaluate('" + ls_argname + "', 1)")
	
	idw_args.insertrow(i)
	idw_args.setitem(i, 'argname', ls_argname)
	idw_args.setitem(i, 'argtype', ls_argtype)
	idw_args.setitem(i, 'argvalue', ls_argvalue)
next

return 0

end function

public function integer of_setsortinfo ();string ls_sort
string ls_sortlist[], ls_item[]
long ll_linecnt, i
string ls_colname, ls_sorttype

idw_sort.reset()

ls_sort = idw_org.describe('datawindow.table.sort')
if ls_sort = '?' or ls_sort = '!' or ls_sort = '' then return 0

pf_f_replaceall(ls_sort, '~r~n', ' ')
ls_sort = pf_f_replaceall(ls_sort, '  ', ' ')
do while pos(ls_sort, '  ') > 0
	ls_sort = pf_f_replaceall(ls_sort, '  ', ' ')
loop

ll_linecnt = pf_f_parsetoarray(ls_sort, ',', ls_sortlist)
for i = 1 to ll_linecnt
	if pf_f_parsetoarray(trim(ls_sortlist[i]), ' ', ls_item) <> 2 then continue
	ls_colname = ls_item[1]
	ls_sorttype = ls_item[2]
	
	idw_sort.insertrow(i)
	idw_sort.setitem(i, 'colname', ls_colname)
	choose case ls_sorttype
		case 'A'
			idw_sort.setitem(i, 'sorttype', 'Asc')
		case 'D'
			idw_sort.setitem(i, 'sorttype', 'Desc')
	end choose
next

return 0

end function

public function integer of_setfilterinfo ();string ls_filter

idw_filter.reset()

ls_filter = idw_org.describe('datawindow.table.filter')
if ls_filter = '?' or ls_filter = '!' or trim(ls_filter) = '' then return 0

idw_filter.insertrow(0)
idw_filter.setitem(1, 'dwfilter', ls_filter)

return 0

end function

public function integer of_setdatainfo ();string ls_select, ls_syntax, ls_error, ls_format
string ls_argtype, ls_repstr, ls_args[]
long ll_argcnt, ll_find, ll_columncnt, i
pf_n_regexp lnv_regexp

ls_select = idw_org.describe("datawindow.table.SQLSelect")

// 아규먼트 변수 구하기
lnv_regexp = create pf_n_regexp
lnv_regexp.of_initialize(true, true)

ll_argcnt = lnv_regexp.of_findmatches(ls_select, "(:\w+)", ls_args[])
destroy lnv_regexp

// 아규먼트 변수 중복 제거
pf_n_hashtable lnv_args
lnv_args = create pf_n_hashtable

for i = 1 to ll_argcnt
	if not lnv_args.of_containskey(ls_args[i]) then
		lnv_args.of_put(ls_args[i], '')
	end if
next

ll_argcnt = lnv_args.of_keyset(ls_args)
destroy lnv_args

// 타입에 따른 아규먼트 기본값 설정
for i = 1 to ll_argcnt
	ll_find = idw_args.find("argname = '" + mid(ls_args[i], 2) + "'", 1, idw_args.rowcount())
	ls_repstr = ''
	if ll_find > 0 then
		ls_argtype = idw_args.getitemstring(ll_find, 'argtype')
		choose case lower(ls_argtype)
			case 'number'
				ls_repstr = "0"
			case 'string'
				ls_repstr = "''"
			case 'date'
				ls_repstr = "'1900-01-01'"
			case 'time'
				ls_repstr = "'00:00:00.000'"
			case 'datetime'
				ls_repstr = "'1900-01-01 00:00:00.000'"
			case 'decimal'
				ls_repstr = "0.0"
			case 'number array'
				ls_repstr = "( 0 )"
			case 'string array', 'stringlist'
				ls_repstr = "( '' )"
			case 'date array', 'datelist'
				ls_repstr = "( '1900-01-01' )"
			case 'time array', 'timelist'
				ls_repstr = "( '00:00:00.000' )"
			case 'datetime array', 'datetimelist'
				ls_repstr = "( '1900-01-01 00:00:00.000' )"
			case 'decimal array', 'decimallist'
				ls_repstr = "( 0.0 )"
			case else
				messagebox('알림(of_setdatainfo)', '아규먼트 타입을 확인할 수 없습니다')
				return -1
		end choose
	end if

	ls_select = pf_f_replaceall(ls_select, ls_args[i], ls_repstr)
next

ls_format = "style(type=grid)~r~n"
ls_format += "column(color=22040656 font.face='맑은 고딕' font.height=-9 font.weight=400  font.family=1 font.pitch=2 font.charset=129 background.mode=1 background.color=536870912)~r~n"
ls_format += "text(color=20066866 font.face='맑은 고딕' font.height=-9 font.weight=400  font.family=1 font.pitch=2 font.charset=129 background.mode=1 background.color=536870912)"

ls_syntax = sqlca.syntaxfromsql(ls_select, ls_format, ls_error)
if len(ls_error) > 0 then
	::clipboard(ls_select)
	messagebox('알림(Data)', ls_error)
	return -1
end if

if idw_data.create(ls_syntax, ls_error) = -1 then
	messagebox('알림(Data)', ls_error)
	return -1
end if

ll_columncnt = long(idw_data.describe("datawindow.column.count"))
for i = 1 to ll_columncnt
	idw_data.modify("#" + string(i) + ".Edit.DisplayOnly=yes")
next

idw_org.event pfe_dataobjectchanged()
idw_org.sharedata(idw_data)

return 0

end function

on pf_w_dwinformation.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on pf_w_dwinformation.destroy
call super::destroy
destroy(this.tab_1)
end on

event open;call super::open;idw_org = gnv_session.of_get(this.classname() + ".datawindowref")
if not isvalid(idw_org) then
	messagebox('알림', '잘못된 윈도우 호출입니다')
	return
end if

idw_dwo = tab_1.tabpage_1.dw_1
idw_col = tab_1.tabpage_2.dw_2
idw_query = tab_1.tabpage_3.dw_3
idw_args = tab_1.tabpage_4.dw_4
idw_sort = tab_1.tabpage_5.dw_5
idw_filter = tab_1.tabpage_6.dw_6
idw_data = tab_1.tabpage_7.dw_7

idw_query.modify("dwquery.width = " + string(idw_query.width - idw_query.x * 2))
idw_query.modify("dwquery.height = " + string(idw_query.height - idw_query.y * 2))

idw_filter.modify("dwfilter.width = " + string(idw_filter.width - idw_filter.x * 2))
idw_filter.modify("dwfilter.height = " + string(idw_filter.height - idw_filter.y * 2))

end event

event pfe_postopen;call super::pfe_postopen;this.of_setdwobjectinfo()
this.of_setcolumninfo()
this.of_setqueryinfo()
this.of_setargumentinfo()
this.of_setsortinfo()
this.of_setfilterinfo()
this.of_setdatainfo()

end event

type tab_1 from tab within pf_w_dwinformation
integer x = 55
integer y = 48
integer width = 2889
integer height = 1416
integer taborder = 10
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
tabpage_7 tabpage_7
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.tabpage_7=create tabpage_7
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
destroy(this.tabpage_7)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 2853
integer height = 1292
string text = "DWObject"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from pf_u_datawindow within tabpage_1
integer x = 23
integer y = 28
integer width = 2807
integer height = 1244
integer taborder = 20
string title = "none"
string dataobject = "pf_d_dwinfo_01"
borderstyle borderstyle = stylelowered!
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 2853
integer height = 1292
string text = "Column"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from pf_u_datawindow within tabpage_2
integer x = 23
integer y = 28
integer width = 2807
integer height = 1244
integer taborder = 20
string title = "none"
string dataobject = "pf_d_dwinfo_02"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 2853
integer height = 1292
string text = "Query"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_3)
end on

type dw_3 from pf_u_datawindow within tabpage_3
integer x = 23
integer y = 28
integer width = 2807
integer height = 1244
integer taborder = 20
string title = "none"
string dataobject = "pf_d_dwinfo_03"
borderstyle borderstyle = stylelowered!
end type

event resize;this.modify("dwquery.width = " + string(newwidth - this.x * 2))
this.modify("dwquery.height = " + string(newwidth - this.y * 2))

end event

event getfocus;call super::getfocus;this.selecttext ( 1 , 65535 )

end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 2853
integer height = 1292
string text = "Argument"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tabpage_4.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_4.destroy
destroy(this.dw_4)
end on

type dw_4 from pf_u_datawindow within tabpage_4
integer x = 23
integer y = 28
integer width = 2807
integer height = 1244
integer taborder = 20
string title = "none"
string dataobject = "pf_d_dwinfo_04"
borderstyle borderstyle = stylelowered!
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 2853
integer height = 1292
string text = "Sort"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
dw_5 dw_5
end type

on tabpage_5.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on tabpage_5.destroy
destroy(this.dw_5)
end on

type dw_5 from pf_u_datawindow within tabpage_5
integer x = 23
integer y = 28
integer width = 2807
integer height = 1244
integer taborder = 20
string title = "none"
string dataobject = "pf_d_dwinfo_05"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 2853
integer height = 1292
string text = "Filter"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
dw_6 dw_6
end type

on tabpage_6.create
this.dw_6=create dw_6
this.Control[]={this.dw_6}
end on

on tabpage_6.destroy
destroy(this.dw_6)
end on

type dw_6 from pf_u_datawindow within tabpage_6
integer x = 23
integer y = 28
integer width = 2807
integer height = 1244
integer taborder = 20
string title = "none"
string dataobject = "pf_d_dwinfo_06"
borderstyle borderstyle = stylelowered!
end type

type tabpage_7 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 2853
integer height = 1292
string text = "Data"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
dw_7 dw_7
end type

on tabpage_7.create
this.dw_7=create dw_7
this.Control[]={this.dw_7}
end on

on tabpage_7.destroy
destroy(this.dw_7)
end on

type dw_7 from pf_u_datawindow within tabpage_7
integer x = 23
integer y = 28
integer width = 2807
integer height = 1244
integer taborder = 20
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

