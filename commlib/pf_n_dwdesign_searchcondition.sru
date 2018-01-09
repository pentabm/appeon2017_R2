HA$PBExportHeader$pf_n_dwdesign_searchcondition.sru
$PBExportComments$Freeform $$HEX19$$a4c2c0d07cc7200070b374c730d108c7c4b3b0c6200014b590c778c7200098ccacb9a9c62000$$ENDHEX$$NVO $$HEX3$$85c7c8b2e4b2$$ENDHEX$$. ~r~n$$HEX30$$54d674ba6cad31c1200011c9200070c88cd670c874ac200080bd84bdd0c5200000b35cd5200014b590c778c744c7200098ccacb9200069d5c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_dwdesign_searchcondition from pf_n_dwdesign
end type
end forward

global type pf_n_dwdesign_searchcondition from pf_n_dwdesign
end type
global pf_n_dwdesign_searchcondition pf_n_dwdesign_searchcondition

type variables
protected:
	// instance for border
	pf_u_statictext iln_top
	pf_u_statictext iln_bottom
	pf_u_statictext iln_left
	pf_u_statictext iln_right
	long il_borderhndl[4]
	
	// original height of detail band
	long il_detailheight
	
public:
	long BorderTopColor = RGB(233,233,231)
	long BorderBottomColor = RGB(233,233,231)
	long BorderLeftColor = RGB(233,233,231)
	long BorderRightColor = RGB(233,233,231)

	long ColumnBorderColor = RGB(214,213,215)
	long TextBackgroundColor = RGB(245,247,249)
	long DisabledColumnBackgroundColor = RGB(239,239,241)
	long EditableColumnBackgroundColor = RGB(255,255,255)
	long DatawindowBackgroundColor = RGB(255,255,255)
	
	long CellBorderBackColor = RGB(255,255,255)
	long CellBorderColor = RGB(214,213,215)
	long CellBorderThickNess = 1		// Pixel
	long CellLeftRightGap = 4		// Pixel
	long CellTopBottomGap = 4		// Pixel
	long MaxSingleRowHeight = 30		// Pixel
	
	// $$HEX15$$44be5cd631c12000eccefcb72000ecceecb7200001c8a9c62000ecc580bd$$ENDHEX$$
	boolean SetDisabledColumnBackgroundColor = true
	
	// $$HEX19$$85c725b8200000aca5b25cd52000eccefcb720004cd150b4acb920005cd4dcc22000ecc580bd$$ENDHEX$$
	boolean EditableColumnBorder = true

end variables

forward prototypes
public function integer of_drawcustomborder ()
public function integer of_applydesign ()
public function long of_carriagereturncount (string as_searchstr)
public function integer of_getfontsize (string as_fontface, integer ai_fontheight, integer ai_fontweight, ref pf_s_size astr_fontsize)
public subroutine of_setmaxsinglerowheight (long al_rowheight)
end prototypes

public function integer of_drawcustomborder ();// backup message object before OpenUserObject()
message lm_backup
lm_backup = create message
lm_backup.Handle = message.Handle
lm_backup.Number = message.Number
lm_backup.WordParm = message.WordParm
lm_backup.LongParm = message.LongParm
lm_backup.DoubleParm = message.DoubleParm
lm_backup.StringParm = message.StringParm
lm_backup.PowerObjectParm = message.PowerObjectParm
lm_backup.Processed = message.Processed
lm_backup.ReturnValue = message.ReturnValue

long ll_x, ll_y
long ll_width, ll_height

// top line
if not isvalid(iln_top) then
	if idw_target.border = true then
		ll_x = idw_target.x
		ll_y = idw_target.y
		ll_width = idw_target.width
		ll_height = pixelstounits(1, ypixelstounits!)
	else
		ll_x = idw_target.x - pixelstounits(1, xpixelstounits!)
		ll_y = idw_target.y - pixelstounits(1, ypixelstounits!)
		ll_width = idw_target.width + pixelstounits(2, xpixelstounits!)
		ll_height = pixelstounits(1, ypixelstounits!)
	end if
	
	if iw_parent.openuserobject(iln_top, ll_x, ll_y) = 1 then
		iln_top.width = ll_width
		iln_top.height = ll_height
		iln_top.backcolor = BorderTopColor
	end if
end if

if igo_parent.typeof() = userobject! then
	il_borderhndl[1] = gnv_extfunc.getparent(handle(iln_top))
	gnv_extfunc.setparent(handle(iln_top), handle(igo_parent))
end if

// bottom line
if not isvalid(iln_bottom) then
	if idw_target.border = true then
		ll_x = idw_target.x
		ll_y = idw_target.y + idw_target.height - pixelstounits(1, ypixelstounits!)
		ll_width = idw_target.width
		ll_height = pixelstounits(1, ypixelstounits!)
	else
		ll_x = idw_target.x - pixelstounits(1, xpixelstounits!)
		ll_y = idw_target.y + idw_target.height
		ll_width = idw_target.width + pixelstounits(2, xpixelstounits!)
		ll_height = pixelstounits(1, ypixelstounits!)
	end if
	
	if iw_parent.openuserobject(iln_bottom, ll_x, ll_y) = 1 then
		iln_bottom.width = ll_width
		iln_bottom.height = ll_height
		iln_bottom.backcolor = BorderBottomColor
	end if
end if

if igo_parent.typeof() = userobject! then
	il_borderhndl[2] = gnv_extfunc.getparent(handle(iln_bottom))
	gnv_extfunc.setparent(handle(iln_bottom), handle(igo_parent))
end if

// left line
if not isvalid(iln_left) then
	if idw_target.border = true then
		ll_x = idw_target.x
		ll_y = idw_target.y
		ll_width = pixelstounits(1, xpixelstounits!)
		ll_height = idw_target.height
	else
		ll_x = idw_target.x - pixelstounits(1, xpixelstounits!)
		ll_y = idw_target.y - pixelstounits(1, ypixelstounits!)
		ll_width = pixelstounits(1, xpixelstounits!)
		ll_height = idw_target.height + pixelstounits(2, ypixelstounits!)
	end if
	
	if iw_parent.openuserobject(iln_left, ll_x, ll_y) = 1 then
		iln_left.width = ll_width
		iln_left.height = ll_height
		iln_left.backcolor = BorderLeftColor
	end if
end if

if igo_parent.typeof() = userobject! then
	il_borderhndl[3] = gnv_extfunc.getparent(handle(iln_left))
	gnv_extfunc.setparent(handle(iln_left), handle(igo_parent))
end if

// right line
if not isvalid(iln_right) then
	if idw_target.border = true then
		ll_x = idw_target.x + idw_target.width  - pixelstounits(1, xpixelstounits!)
		ll_y = idw_target.y
		ll_width = pixelstounits(1, xpixelstounits!)
		ll_height = idw_target.height
	else
		ll_x = idw_target.x + idw_target.width
		ll_y = idw_target.y - pixelstounits(1, ypixelstounits!)
		ll_width = pixelstounits(1, xpixelstounits!)
		ll_height = idw_target.height + pixelstounits(2, ypixelstounits!)
	end if
	
	if iw_parent.openuserobject(iln_right, ll_x, ll_y) = 1 then
		iln_right.width = ll_width
		iln_right.height = ll_height
		iln_right.backcolor = BorderRightColor
	end if
end if

if igo_parent.typeof() = userobject! then
	il_borderhndl[4] = gnv_extfunc.getparent(handle(iln_right))
	gnv_extfunc.setparent(handle(iln_right), handle(igo_parent))
end if

// restore message object
message.Handle = lm_backup.Handle
message.Number = lm_backup.Number
message.WordParm = lm_backup.WordParm
message.LongParm = lm_backup.LongParm
message.DoubleParm = lm_backup.DoubleParm
message.StringParm = lm_backup.StringParm
message.PowerObjectParm = lm_backup.PowerObjectParm
message.Processed = lm_backup.Processed
message.ReturnValue = lm_backup.ReturnValue

iln_top.visible = idw_target.visible
iln_bottom.visible = idw_target.visible
iln_left.visible = idw_target.visible
iln_right.visible = idw_target.visible

if idw_target.border = true then
	idw_target.border = false
	idw_target.x += pixelstounits(1, xpixelstounits!)
	idw_target.y += pixelstounits(1, ypixelstounits!)
	idw_target.width -= pixelstounits(2, xpixelstounits!)
	idw_target.height -= pixelstounits(2, ypixelstounits!)
end if

return 1

end function

public function integer of_applydesign ();if not isvalid(idw_target) then return -1

string ls_error
pf_n_syntaxbuffer lnv_newsyntax, lnv_modsyntax
lnv_newsyntax = create pf_n_syntaxbuffer
lnv_modsyntax = create pf_n_syntaxbuffer

long ll_objcnt, i, ll_pos
long ll_xpos, ll_ypos, ll_width, ll_height
string ls_objects[]
string ls_objtype, ls_editstyle
string ls_border, ls_band
string ls_visible, ls_protect
string ls_bgcolor, ls_colbgcolor
string ls_tag, ls_bandcolor

string ls_newborder[]
long ll_bordercnt
string ls_newcell[]
long ll_cellcnt

long ll_cellxpos, ll_cellypos
long ll_cellwidth, ll_cellheight

pf_s_size lstr_fontsize
string ls_fontface, ls_filename
integer li_fontheight, li_fontweight
long ll_crcnt

//boolean lb_setdisabledcolumncolor
//lb_setdisabledcolumncolor = idw_target.dynamic of_getservicepropertyvalue('SetDisabledColumnBackColor')
//if SetDisabledColumnBackgroundColor = false then
//	DisabledColumnBackgroundColor = EditableColumnBackgroundColor
//end if

il_detailheight = long(idw_target.describe("Datawindow.Detail.Height"))

ll_objcnt = pf_f_parsetoarray(idw_target.describe("Datawindow.Objects"), "~t", ls_objects[])
for i = 1 to ll_objcnt
	
	// $$HEX7$$eccefcb72000c0d085c774c72000$$ENDHEX$$Column, Text, Compute $$HEX12$$78c72000bdacb0c6ccb9200014b590c778c7200001c8a9c6$$ENDHEX$$
	ls_objtype = idw_target.describe(ls_objects[i] + ".Type")
	if not (ls_objtype = "column" or ls_objtype = "text" or ls_objtype = "compute") then continue
	
	// $$HEX19$$54d674bad0c5200004c758ce200058d5c0c920004ac594b22000e8ceb8d264b820001cc878c6$$ENDHEX$$
	ls_band = idw_target.describe(ls_objects[i] + ".Band")
	if ls_band = "?" or ls_band = "!" then continue

	ls_editstyle = idw_target.describe(ls_objects[i] + ".Edit.Style")
	ls_tag = lower(idw_target.describe(ls_objects[i] + ".Tag"))
	ls_border = idw_target.describe(ls_objects[i] + ".Border")
	ls_bandcolor = idw_target.describe("Datawindow." + ls_band + ".Color")
	
	// get visible property(Trim trailing and leading space)
	ls_visible = idw_target.describe(ls_objects[i] + ".Visible")
	if left(ls_visible, 1) = '"' and right(ls_visible, 1) = '"' then
		ls_visible = mid(ls_visible, 2, len(ls_visible) - 2)
	end if
	
	// get column background color
	ls_bgcolor = idw_target.describe(ls_objects[i] + ".Background.Color")
	if ls_bgcolor = '!' then ls_bgcolor=string(553648127)
	if left(ls_bgcolor, 1) = '"' and right(ls_bgcolor, 1) = '"' then
		ls_bgcolor = of_fixescapechar(mid(ls_bgcolor, 2, len(ls_bgcolor) - 2))
	end if
	
	// Background.Color = Transparent $$HEX6$$78c72000bdacb0c6ccb92000$$ENDHEX$$Background $$HEX3$$14b590c778c7$$ENDHEX$$(Protect $$HEX12$$8dc131c1fcac2000f0c5c4ac74d51cc1200098ccacb928b4$$ENDHEX$$)
	if ls_objtype = "column" or ls_objtype = "compute" then
		// 536870912 = 0x 20 00 00 00 Transparency bit = 1, RGB-bytes designate BLACK (Red=0, Green=0, Blue=0)
		// 553648127 = 0x 20 FF FF FF Transparency bit = 1, RGB-bytes designate WHITE (Red=255, Green=255, Blue=255)
		if SetDisabledColumnBackgroundColor = true and &
			(left(ls_bgcolor, 9) = '553648127' or left(ls_bgcolor, 9) = '536870912') then
			if pos(ls_bgcolor, '~t') = 0 then
				ls_protect = idw_target.describe(ls_objects[i] + ".Protect")
				ll_pos = pos(ls_protect, '~t')
				if ll_pos > 0 then
					ls_protect = mid(ls_protect, ll_pos + 1, len(ls_protect) - ll_pos - 1)
					ls_colbgcolor = ls_bgcolor + of_getinnersyntax('~tIf(Long(Describe("Evaluate(~~~"" + "' + ls_protect + '" + "~~~", " + String(GetRow()) + ")")) = 0 And Long(Describe("' + ls_objects[i] + '.TabSequence")) > 0, ' + string(EditableColumnBackgroundColor) + ', ' + string(DisabledColumnBackgroundColor) + ')')
				else
					ls_colbgcolor = ls_bgcolor + of_getinnersyntax('~tIf(Long(Describe("' + ls_objects[i] + '.Protect")) = 0 And Long(Describe("' + ls_objects[i] + '.TabSequence")) > 0, ' + string(EditableColumnBackgroundColor) + ', ' + string(DisabledColumnBackgroundColor) + ')')
				end if
				
				if ls_editstyle <> 'checkbox' and ls_editstyle <> 'radiobuttons' then
					lnv_modsyntax.of_append(ls_objects[i] + '.Background.Mode="0"')
					lnv_modsyntax.of_append(ls_objects[i] + '.Background.Color="' + ls_colbgcolor + '"')
				end if
			end if
		else
			ls_colbgcolor = ls_bgcolor
		end if
	end if
	
	// Border Style = 2(Box) $$HEX16$$78c72000bdacb0c620005cd415d6dcd058c7200014b590c778c7200018c289d5$$ENDHEX$$
	if ls_border = '2' then
		
		ll_cellxpos = long(idw_target.describe(ls_objects[i] + ".x")) - long(pixelstounits(CellBorderThickNess, XPixelsToUnits!))
		ll_cellypos = long(idw_target.describe(ls_objects[i] + ".y")) - long(pixelstounits(CellBorderThickNess, YPixelsToUnits!))
		ll_cellwidth = long(idw_target.describe(ls_objects[i] + ".width")) + long(pixelstounits(CellBorderThickNess * 2, XPixelsToUnits!))
		ll_cellheight = long(idw_target.describe(ls_objects[i] + ".height")) + long(pixelstounits(CellBorderThickNess * 2, YPixelsToUnits!))
		
		// Cell Border $$HEX2$$98ccacb9$$ENDHEX$$
		string ls_cellbgcolor
		
		choose case ls_objtype
			case 'text'
				ls_cellbgcolor = string(TextBackgroundColor)
			case 'column', 'compute'
				if EditableColumnBorder = true then
					ls_cellbgcolor = ls_bandcolor
				else
					ls_cellbgcolor = ls_colbgcolor
				end if
		end choose
		
		lnv_newsyntax.of_append('rectangle(band=' + ls_band + ' x="' +String(ll_cellxpos) + '" y="' + string(ll_cellypos) + '" height="' + string(ll_cellheight) + '"' + ' width="' + string(ll_cellwidth) + '" name='  + ls_objects[i] + '_rect  visible="' + ls_visible + '" brush.hatch="6" brush.color="' + ls_cellbgcolor + '"' +  &
									' pen.style="0" pen.width="' + string(PixelsToUnits(CellBorderThickNess, YPixelsToUnits!)) + '" pen.color="' + string(CellBorderColor) + '" background.mode="1" background.color="553648127" )')
		
		// $$HEX7$$e0c2dcad2000ddc031c11cb42000$$ENDHEX$$Cell Border $$HEX2$$f4bc00ad$$ENDHEX$$
		ll_cellcnt ++
		ls_newcell[ll_cellcnt] = ls_objects[i] + '_rect'
		
		// Border $$HEX3$$1cc878c62000$$ENDHEX$$Cell $$HEX2$$01c6edc5$$ENDHEX$$
		ll_cellxpos += long(pixelstounits(CellBorderThickNess, XPixelsToUnits!))
		ll_cellypos += long(pixelstounits(CellBorderThickNess, YPixelsToUnits!))
		ll_cellwidth -= long(pixelstounits(CellBorderThickNess * 2, XPixelsToUnits!))
		ll_cellheight -= long(pixelstounits(CellBorderThickNess * 2, YPixelsToUnits!))
		
		// $$HEX19$$24c60cbe1dc8b8d22000c0d085c7c4bc5cb82000eccefcb7200014b590c778c7200098ccacb9$$ENDHEX$$
		choose case ls_objtype
			case 'text'
				ls_fontface = idw_target.describe(ls_objects[i] + ".Font.Face")
				li_fontheight = integer(idw_target.describe(ls_objects[i] + ".Font.Height"))
				li_fontweight = integer(idw_target.describe(ls_objects[i] + ".Font.Weight"))
				
				this.of_getfontsize(ls_fontface, li_fontheight, li_fontweight, lstr_fontsize)
				
				// Carriage Return $$HEX6$$88c794b22000bdacb0c62000$$ENDHEX$$Font Height *= CR
				ll_crcnt = this.of_carriagereturncount(idw_target.describe(ls_objects[i] + ".Text"))
				if ll_crcnt > 0 then
					lstr_fontsize.height *= ll_crcnt + 1
				end if
				
				// XPOS, WIDTH $$HEX2$$24c115c8$$ENDHEX$$
				ll_xpos = ll_cellxpos + pixelstounits(CellLeftRightGap, xpixelstounits!)
				ll_width = ll_cellwidth - pixelstounits(CellLeftRightGap * 2, xpixelstounits!)
				
				// YPOS, HEIGHT $$HEX2$$24c115c8$$ENDHEX$$(Column Tag$$HEX2$$d0c52000$$ENDHEX$$verticalcenter=no $$HEX18$$38bb6cad00ac200088c73cc774ba200000acb4c670b3200015c82cb8200048c5200068d5$$ENDHEX$$)
				if match(ls_tag, 'verticalcenter *= *no') = true then
					ll_ypos = ll_cellypos
					ll_height = ll_cellheight
				else
					ll_ypos = ll_cellypos + (ll_cellheight - lstr_fontsize.height) / 2
					ll_height = lstr_fontsize.height
				end if
				
				lnv_modsyntax.of_append(ls_objects[i] + ".Border=~"0~"")
				lnv_modsyntax.of_append(ls_objects[i] + '.X="' + string(ll_xpos) + '"')
				lnv_modsyntax.of_append(ls_objects[i] + '.Y="' + string(ll_ypos) + '"')
				lnv_modsyntax.of_append(ls_objects[i] + '.width="' + string(ll_width) + '"')
				lnv_modsyntax.of_append(ls_objects[i] + '.height="' + string(ll_height) + '"')
				
			case 'column', 'compute'
				ls_fontface = idw_target.describe(ls_objects[i] + ".Font.Face")
				li_fontheight = integer(idw_target.describe(ls_objects[i] + ".Font.Height"))
				li_fontweight = integer(idw_target.describe(ls_objects[i] + ".Font.Weight"))
				
				this.of_getfontsize(ls_fontface, li_fontheight, li_fontweight, lstr_fontsize)
				
				ll_xpos = ll_cellxpos + pixelstounits(CellLeftRightGap, xpixelstounits!)
				ll_width = ll_cellwidth - pixelstounits(CellLeftRightGap * 2, xpixelstounits!)
				
				// YPOS, HEIGHT $$HEX2$$24c115c8$$ENDHEX$$(Column Tag$$HEX2$$d0c52000$$ENDHEX$$verticalcenter=no $$HEX18$$38bb6cad00ac200088c73cc774ba200000acb4c670b3200015c82cb8200048c5200068d5$$ENDHEX$$)
				if match(ls_tag, 'verticalcenter *= *no') = true then
					ll_ypos = ll_cellypos
					ll_height = lstr_fontsize.height
				else
					choose case ll_cellheight
						// $$HEX21$$40c174c7200030aef8bc2000acc074c788c9f4bce4b2200092b174c700ac200070d02000bdacb0c62000$$ENDHEX$$VerticalCenter $$HEX6$$98ccacb9200048c5200068d5$$ENDHEX$$(Multi-Line Column $$HEX5$$5cb8200078c7ddc268d5$$ENDHEX$$)
						case is > pixelstounits(MaxSingleRowHeight, ypixelstounits!)
							ll_ypos = ll_cellypos + pixelstounits(CellTopBottomGap, ypixelstounits!)
							ll_height = ll_cellheight - pixelstounits(CellTopBottomGap, ypixelstounits!)
							
						// $$HEX18$$40c174c7200030aef8bc2000acc074c788c9f4bce4b2200091c740c72000bdacb0c62000$$ENDHEX$$VAlign $$HEX2$$98ccacb9$$ENDHEX$$
						case else
							ll_ypos = ll_cellypos + (ll_cellheight - lstr_fontsize.height) / 2
							ll_height = lstr_fontsize.height
							
					end choose
				end if
				
				// $$HEX3$$eccefcb72000$$ENDHEX$$CALENDAR ICON $$HEX2$$98ccacb9$$ENDHEX$$
				if match(ls_tag, 'posticon *= *calendar') = true then
					ls_filename = "..\img\commonuse\icon_calendar.jpg"
					
					lnv_newsyntax.of_append(&
					'bitmap(band=' + ls_band + ' filename="' + ls_filename + '" x="' + string(ll_xpos + ll_width - 73) + '" y="' + string(ll_ypos + ((ll_height - 64) / 2)) + '" height="64" width="73" border="0" name=p_' + ls_objects[i] + '_comcalendar pointer="HyperLink!" visible="' + ls_visible + '" )')
					lnv_modsyntax.of_append(ls_objects[i] + '.width="' + string(ll_width - 73 - pixelstounits(3, xpixelstounits!)) + '"')
					
				// $$HEX3$$eccefcb72000$$ENDHEX$$YEARMONTH ICON $$HEX2$$98ccacb9$$ENDHEX$$
				elseif match(ls_tag, 'posticon *= *yearmonth') = true then
					ls_filename = "..\img\commonuse\icon_calendar.jpg"
					
					lnv_newsyntax.of_append(&
					'bitmap(band=' + ls_band + ' filename="' + ls_filename + '" x="' + string(ll_xpos + ll_width - 73) + '" y="' + string(ll_ypos + ((ll_height - 64) / 2)) + '" height="64" width="73" border="0" name=p_' + ls_objects[i] + '_comyearmonth pointer="HyperLink!" visible="' + ls_visible + '" )')
					lnv_modsyntax.of_append(ls_objects[i] + '.width="' + string(ll_width - 73 - pixelstounits(3, xpixelstounits!)) + '"')
					
				// $$HEX3$$eccefcb72000$$ENDHEX$$POPUP ICON $$HEX2$$98ccacb9$$ENDHEX$$
				elseif match(ls_tag, 'posticon *= *popup') = true then
					ls_filename = "..\img\commonuse\icon_popup.jpg"
					
					lnv_newsyntax.of_append(&
					'bitmap(band=' + ls_band + ' filename="' + ls_filename + '" x="' + string(ll_xpos + ll_width - 73) + '" y="' + string(ll_ypos + ((ll_height - 64) / 2)) + '" height="64" width="73" border="0" name=p_' + ls_objects[i] + '_compopup pointer="HyperLink!" visible="' + ls_visible + '" )')
					lnv_modsyntax.of_append(ls_objects[i] + '.width="' + string(ll_width - 73 - pixelstounits(3, xpixelstounits!)) + '"')
				else
					lnv_modsyntax.of_append(ls_objects[i] + '.width="' + string(ll_width) + '"')
				end if
				
				lnv_modsyntax.of_append(ls_objects[i] + ".Border=~"0~"")
				lnv_modsyntax.of_append(ls_objects[i] + '.X="' + string(ll_xpos) + '"')
				lnv_modsyntax.of_append(ls_objects[i] + '.Y="' + string(ll_ypos) + '"')
				//lnv_modsyntax.of_append(ls_objects[i] + '.width="' + string(ll_width) + '"')
				lnv_modsyntax.of_append(ls_objects[i] + '.height="' + string(ll_height) + '"')
				
				// Column Border $$HEX2$$ddc031c1$$ENDHEX$$
				if EditableColumnBorder then
					if ls_editstyle <> 'checkbox' and ls_editstyle <> 'radiobuttons' then
						if ll_cellheight > ll_height + pixelstounits(2, ypixelstounits!) then
							ll_bordercnt ++
							ls_newborder[ll_bordercnt] = ls_objects[i] + '_rrct'
							
							ll_xpos = ll_xpos - pixelstounits(1, xpixelstounits!)
							ll_ypos = ll_ypos - pixelstounits(1, ypixelstounits!)
							ll_width = ll_width + pixelstounits(2, xpixelstounits!)
							ll_height = ll_height + pixelstounits(2, ypixelstounits!)
							
							// $$HEX7$$84c7dcc220004cd1a4c2b8d2a9c6$$ENDHEX$$
							ls_visible = '0'
							
							lnv_newsyntax.of_append( &
							'roundrectangle(band=' + ls_band + ' ellipseheight="12" ellipsewidth="15" x="' + string(ll_xpos) + '" y="' + string(ll_ypos) + '" height="' + string(ll_height) + '"' + &
							' width="' + string(ll_width) + '" name='  + ls_objects[i] + '_rrct visible="' + ls_visible + '" brush.hatch="6" brush.color="' + ls_colbgcolor + '"' +  &
							' pen.style="0" pen.width="1" pen.color="1073741824~t' +  string(ColumnBorderColor) + '" background.mode="1" background.color="553648127" )' )
						end if
					end if
				else
					if ls_editstyle = 'dddw' or ls_editstyle = 'ddlb' then
						if ll_cellheight > ll_height + pixelstounits(2, ypixelstounits!) then
							ll_xpos = ll_xpos - pixelstounits(1, xpixelstounits!)
							ll_ypos = ll_ypos - pixelstounits(1, ypixelstounits!)
							ll_width = ll_width + pixelstounits(1, xpixelstounits!)
							ll_height = ll_height + pixelstounits(1, ypixelstounits!)
							
							lnv_modsyntax.of_append('create line(band=detail x1="' + string(ll_xpos) + '" y1="' + string(ll_ypos) + '" x2="' + string(ll_xpos + ll_width + pixelstounits(1, xpixelstounits!)) + '" y2="' + string(ll_ypos) + '"  name=' + ls_objects[i] + '_border1' + ' visible="' + ls_visible + '" pen.style="0" pen.width="5" pen.color="' + ls_cellbgcolor + '"  background.mode="2" background.color="33554432" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" )')
							lnv_modsyntax.of_append('create line(band=detail x1="' + string(ll_xpos) + '" y1="' + string(ll_ypos + ll_height) + '" x2="' + string(ll_xpos + ll_width + pixelstounits(1, xpixelstounits!)) + '" y2="' + string(ll_ypos + ll_height) + '"  name=' + ls_objects[i] + '_border2' + ' visible="' + ls_visible + '" pen.style="0" pen.width="5" pen.color="' + ls_cellbgcolor + '"  background.mode="2" background.color="33554432" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" )')
							lnv_modsyntax.of_append('create line(band=detail x1="' + string(ll_xpos) + '" y1="' + string(ll_ypos) + '" x2="' + string(ll_xpos) + '" y2="' + string(ll_ypos + ll_height + pixelstounits(1, ypixelstounits!)) + '"  name=' + ls_objects[i] + '_border3' + ' visible="' + ls_visible + '" pen.style="0" pen.width="5" pen.color="' + ls_cellbgcolor + '"  background.mode="2" background.color="33554432" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" )')
							lnv_modsyntax.of_append('create line(band=detail x1="' + string(ll_xpos + ll_width) + '" y1="' + string(ll_ypos) + '" x2="' + string(ll_xpos + ll_width) + '" y2="' + string(ll_ypos + ll_height + pixelstounits(1, ypixelstounits!)) + '"  name=' + ls_objects[i] + '_border4' + ' visible="' + ls_visible + '" pen.style="0" pen.width="5" pen.color="' + ls_cellbgcolor + '"  background.mode="2" background.color="33554432" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" )')
						end if
					end if
				end if
		end choose
	end if
next

// Highlight get focused column
lnv_newsyntax.of_append('rectangle(band=detail x="0" y="0" height="0" width="0"  name=r_getfocused visible="0" brush.hatch="7" brush.color="570425344" pen.style="0" pen.width="8" pen.color="6731519"  background.mode="1" background.color="553648127" )')

// datawindow background color $$HEX2$$24c115c8$$ENDHEX$$
lnv_modsyntax.of_append('Datawindow.Color="' + string(DatawindowBackgroundColor) + '"')

// Modify datawindow syntax 
ls_error = idw_target.Modify(lnv_modsyntax.of_tostring())
if len(ls_error) > 0 then
	::clipboard(lnv_modsyntax.of_tostring())
	messagebox("Error", idw_target.classname() + " Syntax Modification Failure!! : " + ls_error)
	return -1
end if

string ls_newsyntax, ls_dwsyntax
string ls_findstr[] = { "column(name", "compute(name", "text(name" }
long ll_minpos = 2147483647

ls_newsyntax = trim(lnv_newsyntax.of_tostring())
if ls_newsyntax <> '' then
	ls_dwsyntax = idw_target.describe("datawindow.syntax")
	for i = 1 to upperbound(ls_findstr)
		ll_pos = pos(ls_dwsyntax, ls_findstr[i])
		if ll_pos > 0 then
			if ll_pos < ll_minpos then ll_minpos = ll_pos
		end if
	next
	
	if ll_minpos > 0 then
		ls_dwsyntax = replace(ls_dwsyntax, ll_minpos, 0, ls_newsyntax)
		if idw_target.Create(ls_dwsyntax, ls_error) = -1 then
			::clipboard(idw_target.classname() + "~r~n" + ls_dwsyntax)
			messagebox("Error", idw_target.classname() + " Syntax Modification(Create) Failure!! : " + ls_error)
			return -1
		end if
		this.of_resetdwdisplayorder(idw_target.classname())
	end if
end if

return 1

end function

public function long of_carriagereturncount (string as_searchstr);// $$HEX6$$38bb90c7f4c548c5d0c52000$$ENDHEX$$CarriageReturn $$HEX10$$12ac44c7200074ceb4c6b8d2200069d5c8b2e4b2$$ENDHEX$$.

long ll_pos, ll_crcnt

ll_pos = pos(as_searchstr, '~r~n')
do while ll_pos > 0
	ll_crcnt ++
	ll_pos = pos(as_searchstr, '~r~n', ll_pos + 1)
loop

return ll_crcnt

end function

public function integer of_getfontsize (string as_fontface, integer ai_fontheight, integer ai_fontweight, ref pf_s_size astr_fontsize);// $$HEX6$$f0d3b8d22000acc074c788c9$$ENDHEX$$(Width, Height) $$HEX6$$7cb920006cad69d5c8b2e4b2$$ENDHEX$$
// $$HEX28$$c4acb0c020008dc1c4b32000a5d5c1c044c7200004c774d5200074c7f8bb2000b0c09ccd1cb4200012ac40c7200090cedcc269d5c8b2e4b2$$ENDHEX$$

string ls_cachekey

// $$HEX27$$74d5f9b22000f0d3b8d200ac200090cedcc21cb42000c1c0dcd074ba2000c4acb0c01cb4200012acccb9200038cc70c869d5c8b2e4b2$$ENDHEX$$
ls_cachekey = "FontSizeRepo=" + as_fontface + "~t" + string(ai_fontheight) + "~t" + string(ai_fontweight)

// $$HEX19$$08c7c4b3b0c62000e8b2c5b32000e4c289d544c7200004c75cd5200084c7dcc2200054cfdcb4$$ENDHEX$$
if not isvalid(gnv_session) then
	gnv_session = create pf_n_appsession
end if

if gnv_session.of_containskey(ls_cachekey) then
	astr_fontsize = gnv_session.of_get(ls_cachekey)
	return 1
end if

// $$HEX8$$f0d3b8d22000acc074c788c900ac2000$$ENDHEX$$- $$HEX4$$78c7bdacb0c62000$$ENDHEX$$+ $$HEX4$$5cb82000c0bcbdac$$ENDHEX$$( -9 ==> 9 )
if ai_fontheight < 0 then
	ai_fontheight *= -1
end if

// $$HEX10$$f0d3b8d2acc074c788c920006cad58d530ae2000$$ENDHEX$$API  $$HEX2$$38d69ccd$$ENDHEX$$
gnv_extfunc.pf_gettextsizeW(handle(this), " ", as_fontface, ai_fontheight, ai_fontweight, astr_fontsize)

// Pixel $$HEX2$$44c72000$$ENDHEX$$PBUnit $$HEX5$$3cc75cb82000c0bcbdac$$ENDHEX$$
astr_fontsize.width = pixelstounits(astr_fontsize.width, xpixelstounits!)
astr_fontsize.height = pixelstounits(astr_fontsize.height, ypixelstounits!)

// $$HEX13$$c4acb0c01cb42000f0d3b8d22000acc074c788c92000f4bc00ad$$ENDHEX$$
gnv_session.of_put(ls_cachekey, astr_fontsize)

return 1

end function

public subroutine of_setmaxsinglerowheight (long al_rowheight);// $$HEX18$$eccefcb7200014b590c778c7200091c7c5c52000dcc2200074d5f9b22000eccefcb774c7$$ENDHEX$$
// Single Row $$HEX3$$78c7c0c92000$$ENDHEX$$Multi Row$$HEX18$$78c7c0c9200010d3e8b258d594b2200030ae00c912ac44c7200024c115c869d5c8b2e4b2$$ENDHEX$$. (Pixel $$HEX2$$e8b204c7$$ENDHEX$$)
MaxSingleRowHeight = al_rowheight

end subroutine

on pf_n_dwdesign_searchcondition.create
call super::create
end on

on pf_n_dwdesign_searchcondition.destroy
call super::destroy
end on

event move;call super::move;if isvalid(iln_top) then
	iln_top.x = xpos - pixelstounits(1, xpixelstounits!)
	iln_top.y = ypos - pixelstounits(1, ypixelstounits!)
end if

if isvalid(iln_bottom) then
	iln_bottom.x = xpos - pixelstounits(1, xpixelstounits!)
	iln_bottom.y = ypos + idw_target.height + pixelstounits(1, ypixelstounits!)
end if

if isvalid(iln_left) then
	iln_left.x = xpos - pixelstounits(1, xpixelstounits!)
	iln_left.y = ypos - pixelstounits(1, ypixelstounits!)
end if

if isvalid(iln_right) then
	iln_right.x = xpos + idw_target.width + pixelstounits(1, xpixelstounits!)
	iln_right.y = ypos - pixelstounits(1, ypixelstounits!)
end if

end event

event resize;call super::resize;// $$HEX3$$c1c0e8b22000$$ENDHEX$$Border $$HEX3$$acc074c788c9$$ENDHEX$$
if isvalid(iln_top) then
	iln_top.width = idw_target.width + pixelstounits(2, xpixelstounits!)
end if

// $$HEX3$$58d5e8b22000$$ENDHEX$$Border $$HEX3$$acc074c788c9$$ENDHEX$$
if isvalid(iln_bottom) then
	iln_bottom.y = idw_target.y + idw_target.height
	iln_bottom.width = idw_target.width + pixelstounits(2, xpixelstounits!)
end if

// $$HEX3$$8cc821ce2000$$ENDHEX$$Border $$HEX3$$acc074c788c9$$ENDHEX$$
if isvalid(iln_left) then
	iln_left.height = idw_target.height + pixelstounits(2, ypixelstounits!)
end if

// $$HEX3$$b0c621ce2000$$ENDHEX$$Border $$HEX3$$acc074c788c9$$ENDHEX$$
if isvalid(iln_right) then
	iln_right.x = idw_target.x + idw_target.width
	iln_right.height = idw_target.height + pixelstounits(2, ypixelstounits!)
end if

end event

event destructor;call super::destructor;// Appeon $$HEX3$$d0c51cc12000$$ENDHEX$$Popup $$HEX5$$08c7c4b3b0c694b22000$$ENDHEX$$CloseUserObject $$HEX23$$7cb9200018c289d558d574ba200074d07cb774c7b8c5b8d200ac200048ba94cd94b2200004d6c1c0200088c74cc7$$ENDHEX$$
// (Appeon2016Build1119 $$HEX4$$84bc04c840c72000$$ENDHEX$$CloseUserObject $$HEX12$$38d69ccd200048c558d574ba200024c658b91cbcddc028b4$$ENDHEX$$)
//if appeongetclienttype() <> 'PB' then return

if isvalid(iln_top) then
	if igo_parent.typeof() = userobject! then gnv_extfunc.setparent(handle(iln_top), il_borderhndl[1])
	iw_parent.CloseUserObject(iln_top)
	destroy iln_top
end if

if isvalid(iln_bottom) then
	if igo_parent.typeof() = userobject! then gnv_extfunc.setparent(handle(iln_bottom), il_borderhndl[2])
	iw_parent.CloseUserObject(iln_bottom)
	destroy iln_bottom
end if

if isvalid(iln_left) then
	if igo_parent.typeof() = userobject! then gnv_extfunc.setparent(handle(iln_left), il_borderhndl[3])
	iw_parent.CloseUserObject(iln_left)
	destroy iln_left
end if

if isvalid(iln_right) then
	if igo_parent.typeof() = userobject! then gnv_extfunc.setparent(handle(iln_right), il_borderhndl[4])
	iw_parent.CloseUserObject(iln_right)
	destroy iln_right
end if

end event

event pfe_visiblechanged;call super::pfe_visiblechanged;if isvalid(iln_top) then
	iln_top.visible = idw_target.visible
end if

if isvalid(iln_bottom) then
	iln_bottom.visible = idw_target.visible
end if

if isvalid(iln_left) then
	iln_left.visible = idw_target.visible
end if

if isvalid(iln_right) then
	iln_right.visible = idw_target.visible
end if

end event

event itemfocuschanged;call super::itemfocuschanged;if not isvalid(idw_target) then return
if row = 0 then return

long ll_xpos, ll_ypos, ll_width, ll_height
string ls_syntax, ls_error

if string(dwo.type) = 'column' then
	if EditableColumnBorder = true then
		ll_xpos = long(idw_target.describe(dwo.name + ".x"))
		if ll_xpos > 0 then
			ll_ypos = long(idw_target.describe(dwo.name + ".y"))
			ll_width = long(idw_target.describe(dwo.name + ".width"))
			ll_height = long(idw_target.describe(dwo.name + ".height"))
			
			ll_xpos -= pixelstounits(1, xpixelstounits!)
			ll_ypos -= pixelstounits(1, ypixelstounits!)
			ll_width += pixelstounits(3, xpixelstounits!)
			ll_height += pixelstounits(3, ypixelstounits!)
			
			ls_syntax += "r_getfocused.x='" + string(ll_xpos) + "'~r~n"
			ls_syntax += "r_getfocused.y='" + string(ll_ypos) + "'~r~n"
			ls_syntax += "r_getfocused.width='" + string(ll_width) + "'~r~n"
			ls_syntax += "r_getfocused.height='" + string(ll_height) + "'"
		end if
		
		ls_error = idw_target.modify(ls_syntax)
		//if len(ls_error) > 0 then
		//	::clipboard(ls_syntax)
		//	messagebox('itemfocuschanged', ls_error)
		//end if
	end if
end if

end event

event getfocus;call super::getfocus;if isvalid(idw_target) then
	idw_target.modify("r_getfocused.visible='1'")
end if

end event

event losefocus;call super::losefocus;if isvalid(idw_target) then
	idw_target.modify("r_getfocused.visible='0'")
	idw_target.setredraw(true)
end if

end event

