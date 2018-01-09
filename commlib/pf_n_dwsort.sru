HA$PBExportHeader$pf_n_dwsort.sru
$PBExportComments$$$HEX24$$70b374c730d108c7c4b3b0c6200089d5200015c8f4c520001cc144bea4c2200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_dwsort from pf_n_nonvisualobject
end type
end forward

global type pf_n_dwsort from pf_n_nonvisualobject
event type long pfe_clicked ( integer xpos,  integer ypos,  long row,  dwobject dwo )
end type
global pf_n_dwsort pf_n_dwsort

type variables
protected:
	datawindow idw_target
	graphicobject igo_parent
	pf_n_hashtable inv_sortedcols
	//pf_n_syntaxbuffer inv_sortedcols

	// column information
	long il_columncount
	string is_columnname[]
	long il_columnxpos[], il_columnwidth[]
	
	// sort option
	boolean ib_multisort = false
	boolean ib_nullsort = true
	boolean ib_lookupsort = true
	
	// attribute
	Long SortArrowColor = RGB(29,189,31)

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_sortbyheader (dwobject dwo)
public subroutine of_initialize (datawindow adw_datawindow)
end prototypes

event type long pfe_clicked(integer xpos, integer ypos, long row, dwobject dwo);integer li_xpos

// Text $$HEX10$$eccefcb7200074d0adb92000dcc2d0c5ccb92000$$ENDHEX$$Sort $$HEX5$$30aea5b2200018c289d5$$ENDHEX$$
if string(dwo.type) <> 'text' then return 0

choose case row
	case 0
		if string(dwo.name) = 'datawindow' then return 0
		if left(idw_target.getbandatpointer(),7) = 'header~t' then
			
			if keydown(KeyControl!) then
				ib_multisort = true
			else
				ib_multisort = false
			end if
			
			this.of_sortbyheader(dwo)
			return 1
		else
			ib_multisort = false
		end if
end choose

return 0

end event

public function string of_getclassname ();return 'pf_n_dwsort'
end function

public function integer of_sortbyheader (dwobject dwo);// $$HEX7$$70b374c730d108c7c4b3b0c62000$$ENDHEX$$SORT

// $$HEX13$$e4d554b320004dd1a4c2b8d2200074d0adb9dcc2d0c5ccb92000$$ENDHEX$$Sort $$HEX2$$d9b391c7$$ENDHEX$$
if string(dwo.type) <> 'text' then return 0
if string(dwo.band) <> 'header' or string(dwo.band) = 'foreground' then return 0

// '_arrow' $$HEX17$$4dd1a4c2b8d2200074d0adb95cd52000bdacb0c620008cc1b8d22000eccefcb785ba$$ENDHEX$$
boolean lb_dosort = false
string ls_dwoname
string ls_columnname

ls_dwoname = string(dwo.name)

// 1. '_t' $$HEX20$$7cb920001cc878c65cd520008cc1b8d22000eccefcb785ba74c7200088c794b2c0c9200055d678c7$$ENDHEX$$
long ll_pos, ll_lastpos
long i, ll_xpos, ll_width

if lb_dosort = false then
	ll_pos = pos(ls_dwoname, '_t')
	if ll_pos > 0 then
		ls_columnname = left(ls_dwoname, ll_pos - 1)
		for i = 1 to il_columncount
			if ls_columnname = is_columnname[i] then
				lb_dosort = true
				exit
			end if
		next
	end if
end if

// 2. Tag $$HEX16$$d0c520008cc1b8d22000eccefcb785ba74c7200088c794b2c0c9200055d678c7$$ENDHEX$$
string ls_tag

if lb_dosort = false then
	ls_tag = string(dwo.tag)
	ll_pos = pos(ls_tag, 'sort=')
	if ll_pos > 0 then
		ll_lastpos = pos(ls_tag, '&', ll_pos + 1)
		if ll_lastpos = 0 then
			ll_lastpos = pos(ls_tag, ',', ll_pos + 1)
			if ll_lastpos = 0 then
				ll_lastpos = len(ls_tag)
			end if
		end if
		ls_columnname = mid(ls_tag, ll_pos + 5, ll_lastpos - ll_pos - 5 + 1)
		lb_dosort = true
	end if
end if

// 3. xpos $$HEX2$$40c62000$$ENDHEX$$width $$HEX20$$00ac20007cc758ce58d594b220008cc1b8d22000eccefcb774c7200088c794b2c0c9200055d678c7$$ENDHEX$$
if lb_dosort = false then
	ll_xpos = long(dwo.x)
	ll_width = long(dwo.width)
	
	for i = 1 to il_columncount
		if ll_xpos = il_columnxpos[i] and ll_width = il_columnwidth[i] then
			ls_columnname = is_columnname[i]
			lb_dosort = true
			exit
		end if
	next
end if

// $$HEX13$$8cc1b8d22000eccefcb774c72000c6c53cc774ba2000acb934d1$$ENDHEX$$
if lb_dosort = false then return 0

// $$HEX3$$8cc1b8d22000$$ENDHEX$$Order $$HEX3$$6cad58d530ae$$ENDHEX$$
string ls_titletext
string ls_sortorder_old, ls_sortorder_new
string ls_sortcriteria

ls_titletext = idw_target.describe(ls_dwoname + ".Text")
ls_sortorder_old = right(ls_titletext, 1)
choose case ls_sortorder_old
	case '$$HEX1$$b225$$ENDHEX$$'
		ls_titletext = left(ls_titletext, len(ls_titletext) - 2)
		ls_sortorder_old = 'D'
		ls_sortorder_new = 'A'
	case '$$HEX1$$bc25$$ENDHEX$$'
		ls_titletext = left(ls_titletext, len(ls_titletext) - 2)
		ls_sortorder_old = 'A'
		ls_sortorder_new = 'D'
	case else
		ls_sortorder_old = 'None'
		ls_sortorder_new = 'A'
end choose

// dddw, ddlb $$HEX24$$eccefcb744c7200054cfdcb412ac74c7200044c5ccb2200054d674bad0c52000f4bc74c794b2200012ac3cc75cb82000$$ENDHEX$$sort $$HEX5$$58d594b2200035c658c1$$ENDHEX$$
string ls_editstyle
string ls_colexp
boolean lb_lookup

ls_colexp = ls_columnname

if ib_lookupsort = true then
	ls_editstyle = idw_target.describe(ls_columnname + ".Edit.Style")
	choose case ls_editstyle
		case 'dddw', 'ddlb'
			lb_lookup = true
		case 'edit'
			choose case lower(idw_target.describe(ls_columnname + ".Edit.CodeTable"))
				case 'yes', '1'
					lb_lookup = true
			end choose
		case 'editmask'
			choose case lower(idw_target.describe(ls_columnname + ".EditMask.CodeTable"))
				case 'yes', '1'
					lb_lookup = true
			end choose
	end choose
	
	if lb_lookup = true then
		ls_colexp = "lookupdisplay(" + ls_columnname + ")"
	end if
end if

// null $$HEX7$$70b374c730d1200012ac44c72000$$ENDHEX$$empty$$HEX7$$5cb8200058ce58d674d51cc12000$$ENDHEX$$sort $$HEX5$$58d594b2200035c658c1$$ENDHEX$$
if ib_nullsort = true then
	choose case left(lower(idw_target.describe(ls_columnname + ".coltype")), 5)
		case 'char('
			ls_colexp = 'if(isnull(' + ls_colexp + '), "", ' + ls_colexp + ')'
		case 'datet', 'times'
			ls_colexp = 'if(isnull(' + ls_colexp + '), 1900-01-01 00:00:00, ' + ls_colexp + ')'
		case 'date'
			ls_colexp = 'if(isnull(' + ls_colexp + '), 1900-01-01, ' + ls_colexp + ')'
		case 'decim', 'int', 'long', 'numbe', 'real', 'ulong'
			ls_colexp = 'if(isnull(' + ls_colexp + '), 0, ' + ls_colexp + ')'
		case 'time'
			ls_colexp = 'if(isnull(' + ls_colexp + '), 00:00:00, ' + ls_colexp + ')'
	end choose
end if

// $$HEX3$$8cc1b8d22000$$ENDHEX$$criteria $$HEX2$$ddc031c1$$ENDHEX$$
if ib_multisort = true then
	ls_sortcriteria = idw_target.describe("Datawindow.Table.Sort")
	if ls_sortcriteria = '!' or ls_sortcriteria = '?' then ls_sortcriteria = ''
	
	ll_pos = pos(ls_sortcriteria, ls_colexp + " " + ls_sortorder_old)
	if ll_pos > 0 then
		ls_sortcriteria = replace(ls_sortcriteria, ll_pos, len(ls_colexp + " " + ls_sortorder_old), ls_colexp + " " + ls_sortorder_new)
	else
		if len(ls_sortcriteria) > 0 then ls_sortcriteria += ", "
		ls_sortcriteria += ls_colexp + " " + ls_sortorder_new
	end if
else
	ls_sortcriteria = ls_colexp + " " + ls_sortorder_new
end if

// $$HEX5$$8cc1b8d2200018c289d5$$ENDHEX$$
idw_target.setsort(ls_sortcriteria)
idw_target.sort()
if idw_target.findgroupchange(0, 1) > 0 then
	idw_target.groupcalc()
end if

// $$HEX10$$70b374c730d108c7c4b3b0c6200014b590c778c7$$ENDHEX$$
string ls_text
string ls_syntax
pf_n_syntaxbuffer lnv_syntax
string ls_error

lnv_syntax = create pf_n_syntaxbuffer

choose case ls_sortorder_new
	case 'A'
		lnv_syntax.of_append(ls_dwoname + ".Text='" + ls_titletext + " $$HEX1$$bc25$$ENDHEX$$'")
	case 'D'
		lnv_syntax.of_append(ls_dwoname + ".Text='" + ls_titletext + " $$HEX1$$b225$$ENDHEX$$'")
end choose

// Hide SortArrow
long ll_sortobjcnt

if ib_multisort = false then
	ll_sortobjcnt = inv_sortedcols.of_size()
	for i = 1 to ll_sortobjcnt
		if inv_sortedcols.of_getkey(i) <> ls_dwoname then
			ls_titletext = idw_target.describe(inv_sortedcols.of_getkey(i) + ".Text")
			ls_titletext = left(ls_titletext, len(ls_titletext) - 2)
			lnv_syntax.of_append(inv_sortedcols.of_getkey(i) + ".Text='" + ls_titletext + "'")
		end if
	next
	
	inv_sortedcols.of_clear()
end if

inv_sortedcols.of_put(ls_dwoname, ls_columnname)

// do syntax modify
ls_error = idw_target.modify(lnv_syntax.of_tostring())
if ls_error <> '' then
	::clipboard(idw_target.classname() + "~r~n" + lnv_syntax.of_tostring())
	messagebox("of_sort()", idw_target.classname() + " Syntax Creation Failure!!~r~n" + ls_error)
	return -1
end if

return 1

end function

public subroutine of_initialize (datawindow adw_datawindow);// parent datawindow $$HEX2$$f1b45db8$$ENDHEX$$
idw_target = adw_datawindow
igo_parent = idw_target.getparent()

// column name, xpos, width $$HEX2$$00c8a5c7$$ENDHEX$$
long i

il_columncount = long(idw_target.describe("Datawindow.Column.Count"))
for i = 1 to il_columncount
	is_columnname[i] = idw_target.describe("#" + string(i) + ".Name")
	il_columnxpos[i] = long(idw_target.describe("#" + string(i) + ".X"))
	il_columnwidth[i] = long(idw_target.describe("#" + string(i) + ".Width"))
next

// sorted column $$HEX3$$f4bc00ada9c6$$ENDHEX$$
if not isvalid(inv_sortedcols) then inv_sortedcols = create pf_n_hashtable

end subroutine

on pf_n_dwsort.create
call super::create
end on

on pf_n_dwsort.destroy
call super::destroy
end on

