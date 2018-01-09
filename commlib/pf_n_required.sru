HA$PBExportHeader$pf_n_required.sru
$PBExportComments$$$HEX47$$70b374c730d108c7c4b3b0c6200061c558c120001cc144bea4c240c6200000adc4ac18b4b4c5200044d518c2200085c725b820006dd5a9ba2000b4cc6cd020007cb92000f4b2f9b258d594b2200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_required from pf_n_nonvisualobject
end type
end forward

global type pf_n_required from pf_n_nonvisualobject
end type
global pf_n_required pf_n_required

type variables
// $$HEX13$$44d518c285c725b86dd5a9ba2000b4cc6cd02000a4c2c0d07cc7$$ENDHEX$$
constant integer AsteriskOnTheTitle = 1
//constant integer ColumnTag = 2
//constant integer RequiredProperty = 3

protected:
	datawindow idw_target
	window iw_parent
	
	integer ii_requiredcount
	string is_requiredcolumn[]
	string is_requiredtext[]
	
	integer ii_popupcount
	string is_popupcolumn[]
	string is_popuptext[]

public:
	integer RequiredServiceType = AsteriskOnTheTitle
	boolean RequiredColumnMarker = true
	string RequiredColumnMarkerImageFile = "..\img\datawindow\u_datawindow\red_asterisk.gif"
	string PopupColumnMarkerImageFile = "..\img\commonuse\ib_search.gif"

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_setrequiredcolumnmarker ()
public function integer of_setrequiredcolumn ()
public function integer of_checkrequiredcolumn ()
public function integer of_setpopupcolumn ()
public function integer of_setpopupcolumnmarker ()
public subroutine of_initialize (datawindow adw_datawindow, window aw_parent)
end prototypes

public function string of_getclassname ();return 'pf_n_required'

end function

public function integer of_setrequiredcolumnmarker ();// $$HEX19$$44d518c285c725b86dd5a9bad0c52000c8b9e4ce7cb920005cd4dcc2200074d50dc9c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: success=$$HEX2$$31c1f5ac$$ENDHEX$$, failure=$$HEX2$$e4c228d3$$ENDHEX$$

if not isvalid(idw_target) then return no_action

string ls_syntax, ls_error
string ls_visible, ls_band, ls_text
string ls_fontface, ls_alignment
long ll_fontheight, ll_fontweight
long ll_xpos, ll_ypos, ll_width, ll_iconstart
pf_s_size lstr_textsize
integer i

for i = 1 to ii_requiredcount
	ls_visible = "0~tif(describe('" + is_requiredtext[i] + ".Visible') = '1', 1, 0)"
	ls_band = idw_target.describe(is_requiredtext[i] + ".Band")
	ls_text = idw_target.describe(is_requiredtext[i] + ".Text")
	
	// $$HEX3$$e4d554b32000$$ENDHEX$$Text $$HEX7$$00ac2000c6c594b22000bdacb0c6$$ENDHEX$$
	if ls_text = '' or ls_text = '!' or ls_text = '?' then continue
	
	// $$HEX7$$4dd1a4c2b8d22000acc074c788c9$$ENDHEX$$
	if left(ls_text, 1) = '*' then
		ls_text = '   ' + mid(ls_text, 2)
	else
		ls_text = '  ' + ls_text
	end if
	
	ls_fontface = idw_target.describe(is_requiredtext[i] + ".Font.Face")
	ll_fontheight = - long(idw_target.describe(is_requiredtext[i] + ".Font.Height"))
	ll_fontweight = long(idw_target.describe(is_requiredtext[i] + ".Font.Weight"))
	gnv_extfunc.pf_GetTextSizeW(handle(idw_target), ls_text, ls_fontface, ll_fontheight, ll_fontweight, lstr_textsize)
	lstr_textsize.width = pixelstounits(lstr_textsize.width, xpixelstounits!)
	lstr_textsize.height = pixelstounits(lstr_textsize.height, ypixelstounits!)
	
	// $$HEX8$$4dd1a4c2b8d2200015c82cb829bcddc2$$ENDHEX$$
	ls_alignment = idw_target.describe(is_requiredtext[i] + ".Alignment")
	
	ll_xpos = long(idw_target.describe(is_requiredtext[i] + ".x"))
	ll_ypos = long(idw_target.describe(is_requiredtext[i] + ".y"))
	ll_width = long(idw_target.describe(is_requiredtext[i] + ".width"))
	
	choose case ls_alignment
		// left or justify
		case '0', '3'
			ll_iconstart = 0
		// center
		case '2'
			ll_iconstart = (ll_width - lstr_textsize.width) / 2
		// right
		case '1'
			ll_iconstart = ll_width - lstr_textsize.width
	end choose

	if ll_iconstart < 0 then
		ll_iconstart = 0
	end if

	ls_syntax +=  'create bitmap(band=' + ls_band + ' filename="' + RequiredColumnMarkerImageFile + '" x="' + string(ll_xpos) + '~tlong(describe(~~~"' + is_requiredtext[i] + '.x~~~")) + ' + string(ll_iconstart) + '" y="' + string(ll_ypos) + '~tlong(describe(~~~"' + is_requiredtext[i] + &
					'.y~~~")) + 16" height="36" width="0~t41" border="0" name=' + is_requiredtext[i] + '_required visible="' + ls_visible + '" )~r~n'
	ls_syntax += is_requiredtext[i] + '.text="' + ls_text + '"~r~n'
next

// Modify Syntax
if len(ls_syntax) > 0 then
	ls_error = idw_target.modify(ls_syntax)
	if ls_error <> '' then
		::clipboard(ls_syntax)
		messagebox("syntax modify", "pf_n_required, syntax modification failure!~r~n" + ls_error)
		return failure
	end if
end if

return success

end function

public function integer of_setrequiredcolumn ();// $$HEX23$$44d518c285c725b820006dd5a9ba44c72000b4cc6cd0c4d62000eccefcb785ba44c72000f4bc00ad69d5c8b2e4b2$$ENDHEX$$

if not isvalid(idw_target) then return no_action

string ls_object, ls_objarr[], ls_empty[]
string ls_objtype, ls_text, ls_column, ls_tag
long i, j, ll_objcnt

ii_requiredcount = 0
is_requiredcolumn = ls_empty
is_requiredtext = ls_empty

ls_object = idw_target.describe("Datawindow.Objects")
ll_objcnt = pf_f_parsetoarray(ls_object, '~t', ls_objarr[])
for i = 1 to ll_objcnt
	ls_objtype = idw_target.describe(ls_objarr[i] + ".Type")
	
	choose case ls_objtype
		case "text"
			ls_text = idw_target.describe(ls_objarr[i] + ".Text")
			if left(ls_text, 1) = '*' then
				ls_column = ls_objarr[i]
				if right(ls_column, 2) = '_t' then
					ls_column = left(ls_column, len(ls_column) - 2)
					for j = 1 to ll_objcnt
						if ls_column = ls_objarr[j] then
							ii_requiredcount ++
							is_requiredcolumn[ii_requiredcount] = ls_column
							is_requiredtext[ii_requiredcount] = ls_objarr[i]
							
							ls_tag = idw_target.describe(ls_column + ".Tag")
							if ls_tag = '?' or ls_tag = '!' or ls_tag = '' then
								ls_tag = "required=true"
							else
								ls_tag += ";required=true"
							end if
							
							ls_tag = pf_f_replaceall(ls_tag, "'", "~~'")
							idw_target.modify(ls_column + ".Tag='" + ls_tag + "'")
						end if
					next
				end if
			end if
			
		case "column"
			ls_column = ls_objarr[i]
			ls_tag = idw_target.describe(ls_column + ".Tag")
			if match(ls_tag, 'required *= *true') = true then
				ls_text = trim(idw_target.describe(ls_column + "_t.Text"))
				if ls_text = '' or ls_text = '!' or ls_text = '?' then
					ls_text = ls_column
				end if
				
				ii_requiredcount ++
				is_requiredcolumn[ii_requiredcount] = ls_column
				is_requiredtext[ii_requiredcount] = ls_column + '_t'
			end if
	end choose
next

return ii_requiredcount

end function

public function integer of_checkrequiredcolumn ();// $$HEX24$$f8bb200085c725b81cb4200044d518c285c725b820006dd5a9ba74c7200088c794b2c0c9200055d678c769d5c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX13$$1cbcacac1cb42000f8bb85c725b820006dd5a9ba20002fac18c2$$ENDHEX$$(0=$$HEX6$$f8bb85c725b82000c6c54cc7$$ENDHEX$$)

long ll_row
integer i, li_reqcnt
string ls_required_msg, ls_text
string ls_unfilled[]

ll_row = idw_target.getnextmodified(0, primary!)
do while ll_row > 0
	ls_required_msg = ''
	
	for i = 1 to ii_requiredcount
		choose case lower(left(idw_target.describe(is_requiredcolumn[i] + ".ColType"), 5))
			case "char(", "char"
				string ls_data
				ls_data = idw_target.getitemstring(ll_row, is_requiredcolumn[i])
				if isnull(ls_data) or ls_data = '' then
					li_reqcnt ++
					ls_unfilled[li_reqcnt] = is_requiredcolumn[i]
					ls_text = trim(idw_target.describe(is_requiredtext[i] + ".Text"))
					
					if len(ls_required_msg) > 0 then ls_required_msg += ', '
					if ls_text <> '!' and ls_text <> '?' and ls_text <> '' then
						ls_required_msg += ls_text
					else
						ls_required_msg += is_requiredcolumn[i]
					end if
				end if
				
			case "date"
				date ldt_data
				ldt_data = idw_target.getitemdate(ll_row, is_requiredcolumn[i])
				if isnull(ldt_data) then
					li_reqcnt ++
					ls_unfilled[li_reqcnt] = is_requiredcolumn[i]
					ls_text = trim(idw_target.describe(is_requiredtext[i] + ".Text"))
					
					if len(ls_required_msg) > 0 then ls_required_msg += ', '
					if ls_text <> '!' and ls_text <> '?' and ls_text <> '' then
						ls_required_msg += ls_text
					else
						ls_required_msg += is_requiredcolumn[i]
					end if
				end if
				
			case "datet", "times"
				datetime ldtm_data
				ldtm_data = idw_target.getitemdatetime(ll_row, is_requiredcolumn[i])
				if isnull(ldtm_data) then
					li_reqcnt ++
					ls_unfilled[li_reqcnt] = is_requiredcolumn[i]
					ls_text = trim(idw_target.describe(is_requiredtext[i] + ".Text"))
					
					if len(ls_required_msg) > 0 then ls_required_msg += ', '
					if ls_text <> '!' and ls_text <> '?' and ls_text <> '' then
						ls_required_msg += ls_text
					else
						ls_required_msg += is_requiredcolumn[i]
					end if
				end if
				
			case "decim"
				decimal ld_data
				ld_data = idw_target.getitemdecimal(ll_row, is_requiredcolumn[i])
				if isnull(ld_data) then
					li_reqcnt ++
					ls_unfilled[li_reqcnt] = is_requiredcolumn[i]
					ls_text = trim(idw_target.describe(is_requiredtext[i] + ".Text"))
					
					if len(ls_required_msg) > 0 then ls_required_msg += ', '
					if ls_text <> '!' and ls_text <> '?' and ls_text <> '' then
						ls_required_msg += ls_text
					else
						ls_required_msg += is_requiredcolumn[i]
					end if
				end if
				
			case "numbe", "long", "ulong", "real", "int"
				double ldbl_data
				ldbl_data = idw_target.getitemnumber(ll_row, is_requiredcolumn[i])
				if isnull(ldbl_data) then
					li_reqcnt ++
					ls_unfilled[li_reqcnt] = is_requiredcolumn[i]
					ls_text = trim(idw_target.describe(is_requiredtext[i] + ".Text"))
					
					if len(ls_required_msg) > 0 then ls_required_msg += ', '
					if ls_text <> '!' and ls_text <> '?' and ls_text <> '' then
						ls_required_msg += ls_text
					else
						ls_required_msg += is_requiredcolumn[i]
					end if
				end if

			case "time"
				time lt_data
				lt_data = idw_target.getitemtime(ll_row, is_requiredcolumn[i])
				if isnull(lt_data) then
					li_reqcnt ++
					ls_unfilled[li_reqcnt] = is_requiredcolumn[i]
					ls_text = trim(idw_target.describe(is_requiredtext[i] + ".Text"))
					
					if len(ls_required_msg) > 0 then ls_required_msg += ', '
					if ls_text <> '!' and ls_text <> '?' and ls_text <> '' then
						ls_required_msg += ls_text
					else
						ls_required_msg += is_requiredcolumn[i]
					end if
				end if
		end choose
	next
	
	if li_reqcnt > 0 then
		choose case idw_target.dynamic of_getpresentationstyle()
			case 'Freeform'
				messagebox('[' + idw_target.dynamic of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX22$$44c598b7200044d518c285c725b820006dd5a9ba74c72000f1b45db818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.~r~n(' + ls_required_msg + ')')
			case else
				idw_target.scrolltorow(ll_row)
				messagebox('[' + idw_target.dynamic of_gettitle() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', string(ll_row) + ' $$HEX32$$88bcf8c9200089d5d0c5200044c598b740c6200019ac40c7200044d518c285c725b820006dd5a9ba74c72000f1b45db818b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$.~r~n(' + ls_required_msg + ')')
		end choose
		
		idw_target.setcolumn(ls_unfilled[1])
		idw_target.setfocus()
		return li_reqcnt
	end if
	
	ll_row = idw_target.getnextmodified(ll_row, primary!)
loop

return 0

end function

public function integer of_setpopupcolumn ();// $$HEX24$$1dd3c5c5200085c725b820006dd5a9ba44c72000b4cc6cd0c4d62000eccefcb785ba44c72000f4bc00ad69d5c8b2e4b2$$ENDHEX$$

if not isvalid(idw_target) then return no_action

string ls_object, ls_objarr[], ls_empty[]
string ls_objtype, ls_text, ls_column
long i, j, ll_objcnt

ii_popupcount = 0
is_popupcolumn = ls_empty
is_popuptext = ls_empty

ls_object = idw_target.describe("Datawindow.Objects")
ll_objcnt = pf_f_parsetoarray(ls_object, '~t', ls_objarr[])
for i = 1 to ll_objcnt
	ls_objtype = idw_target.describe(ls_objarr[i] + ".Type")
	if ls_objtype <> "text" then continue
	
	ls_text = idw_target.describe(ls_objarr[i] + ".Text")
	if right(ls_text, 1) = '@' then
		ls_column = ls_objarr[i]
		if right(ls_column, 2) = '_t' then
			ls_column = left(ls_column, len(ls_column) - 2)
			for j = 1 to ll_objcnt
				if ls_column = ls_objarr[j] then
					ii_popupcount ++
					is_popupcolumn[ii_popupcount] = ls_column
					is_popuptext[ii_popupcount] = ls_objarr[i]
				end if
			next
		end if
	end if
next

return ii_popupcount

end function

public function integer of_setpopupcolumnmarker ();// $$HEX20$$1dd3c5c5200085c725b86dd5a9bad0c52000c8b9e4ce7cb920005cd4dcc2200074d50dc9c8b2e4b2$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: success=$$HEX2$$31c1f5ac$$ENDHEX$$, failure=$$HEX2$$e4c228d3$$ENDHEX$$

if not isvalid(idw_target) then return no_action

string ls_syntax, ls_error
string ls_visible, ls_band, ls_text
string ls_fontface, ls_alignment
long ll_fontheight, ll_fontweight
long ll_xpos, ll_ypos, ll_width, ll_iconstart
pf_s_size lstr_textsize
integer i

for i = 1 to ii_popupcount
	ls_visible = "0~tif(describe('" + is_popuptext[i] + ".Visible') = '1', 1, 0)"
	ls_band = idw_target.describe(is_popuptext[i] + ".Band")
	ls_text = idw_target.describe(is_popuptext[i] + ".Text")
	
	// $$HEX7$$4dd1a4c2b8d22000acc074c788c9$$ENDHEX$$
	ls_text = left(ls_text, len(ls_text) - 1) + '    '
	ls_fontface = idw_target.describe(is_popuptext[i] + ".Font.Face")
	ll_fontheight = - long(idw_target.describe(is_popuptext[i] + ".Font.Height"))
	ll_fontweight = long(idw_target.describe(is_popuptext[i] + ".Font.Weight"))
	gnv_extfunc.pf_GetTextSizeW(handle(idw_target), ls_text, ls_fontface, ll_fontheight, ll_fontweight, lstr_textsize)
	lstr_textsize.width = pixelstounits(lstr_textsize.width, xpixelstounits!)
	lstr_textsize.height = pixelstounits(lstr_textsize.height, ypixelstounits!)
	
	// $$HEX8$$4dd1a4c2b8d2200015c82cb829bcddc2$$ENDHEX$$
	ls_alignment = idw_target.describe(is_popuptext[i] + ".Alignment")
	
	ll_xpos = long(idw_target.describe(is_popuptext[i] + ".x"))
	ll_ypos = long(idw_target.describe(is_popuptext[i] + ".y"))
	ll_width = long(idw_target.describe(is_popuptext[i] + ".width"))
	
	choose case ls_alignment
		// left or justify
		case '0', '3'
			ll_iconstart = lstr_textsize.width - 68
		// center
		case '2'
			ll_iconstart = lstr_textsize.width + ((ll_width - lstr_textsize.width) / 2) - 68
		// right
		case '1'
			ll_iconstart = ll_width - 68 - pixelstounits(2, xpixelstounits!)
	end choose

	if ll_iconstart < 0 then
		ll_iconstart = 0
	end if

	// imagesize(original:height=72, original:width=82, height=58, width=66)
	ls_syntax +=  'create bitmap(band=' + ls_band + ' filename="' + PopupColumnMarkerImageFile + '" x="' + string(ll_xpos) + '~tlong(describe(~~~"' + is_popuptext[i] + '.x~~~")) + ' + string(ll_iconstart) + '" y="' + string(ll_ypos) + '~tlong(describe(~~~"' + is_popuptext[i] + &
					'.y~~~"))" height="60" width="0~t68" border="0" name=' + is_popuptext[i] + '_popup visible="' + ls_visible + '" )~r~n'
	ls_syntax += is_popuptext[i] + '.text="' + ls_text + '"~r~n'
next

// Modify Syntax
if len(ls_syntax) > 0 then
	ls_error = idw_target.modify(ls_syntax)
	if ls_error <> '' then
		::clipboard(ls_syntax)
		messagebox("syntax modify", "pf_n_required, syntax modification failure!~r~n" + ls_error)
		return failure
	end if
end if

return success

end function

public subroutine of_initialize (datawindow adw_datawindow, window aw_parent);// $$HEX18$$44c5dcad3cbab8d220001cc144bea4c27cb9200008cd30ae54d658d594b2200068d518c2$$ENDHEX$$
// adw_datawindow: $$HEX20$$44c5dcad3cbaa4c220001cc144bea4c27cb920001cc8f5ac60d5200070b374c730d108c7c4b3b0c6$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$: $$HEX2$$c6c54cc7$$ENDHEX$$

// $$HEX12$$80bda8ba200070b374c730d108c7c4b3b0c62000f1b45db8$$ENDHEX$$
if not isvalid(adw_datawindow) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX16$$2cc614bc74b9c0c920004ac540c7200068d518c238d69ccd200085c7c8b2e4b2$$ENDHEX$$.~r~npf_n_required.of_registertarget()')
	return
end if

idw_target = adw_datawindow
iw_parent = aw_parent

// $$HEX17$$44d518c285c725b86dd5a9ba2000eccefcb785ba44c72000f4bc00ad69d5c8b2e4b2$$ENDHEX$$
this.of_setrequiredcolumn()

// $$HEX16$$44d518c285c725b86dd5a9ba2000c8b9e4ce7cb920005cd4dcc269d5c8b2e4b2$$ENDHEX$$
if RequiredColumnMarker = true then
	this.of_setrequiredcolumnmarker()
end if

// $$HEX18$$1dd3c5c5200085c725b86dd5a9ba2000eccefcb785ba44c72000f4bc00ad69d5c8b2e4b2$$ENDHEX$$
//this.of_setpopupcolumn()

// $$HEX17$$1dd3c5c5200085c725b86dd5a9ba2000c8b9e4ce7cb920005cd4dcc269d5c8b2e4b2$$ENDHEX$$
//this.of_setpopupcolumnmarker()

end subroutine

on pf_n_required.create
call super::create
end on

on pf_n_required.destroy
call super::destroy
end on

