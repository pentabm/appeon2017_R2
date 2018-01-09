HA$PBExportHeader$pf_u_mdi_xpmenu.sru
$PBExportComments$$$HEX14$$acc0a9c690c7d0c58cac200080bdecc51cb4200054ba74b27cb92000$$ENDHEX$$XP $$HEX26$$54ba74b2200015d6dcd05cb820005cd4dcc274d52000fcc894b22000acc0a9c690c7200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_u_mdi_xpmenu from pf_u_userobject
end type
type dw_menu from datawindow within pf_u_mdi_xpmenu
end type
end forward

global type pf_u_mdi_xpmenu from pf_u_userobject
integer width = 928
integer height = 1516
event pfe_menuclicked ( string as_menu_id,  string as_pgm_id,  string as_pgm_name )
event pfe_nomouseover ( )
dw_menu dw_menu
end type
global pf_u_mdi_xpmenu pf_u_mdi_xpmenu

type variables
private:
	string is_parent_menu

protected:
	pf_n_rolemenu inv_menu

public:
	pf_n_propertywatcher inv_propmon
	integer MenuDepth = 2

	// Header Band Attributes
	boolean DisplayHeaderBand = true
	long HeaderBandHeight = 150
	long HeaderBandBackColor = RGB(120,112,101)
	string HeaderFontFace = '$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$'
	long HeaderFontSize = -12
	long HeaderFontWeight = 700
	long HeaderFontColor = RGB(255,255,255)
	
	// Group#1 Band Attributes
	long Group#1BandHeight = PixelstoUnits(36, YPixelsToUnits!)
	long Group#1BandBackColor = RGB(239,236,221)
	string Group#1IconFileName = ''
	string Group#1FontFace = '$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$'
	long Group#1FontSize = -10
	long Group#1FontWeight = 700
	long Group#1FontColor = RGB(100,100,100)
	
	// Group#2 Band Attributes
	long Group#2BandHeight = PixelstoUnits(38, YPixelsToUnits!)
	long Group#2BandBackColor = RGB(180,174,161)
	string Group#2IconFileName = ''
	string Group#2FontFace = '$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$'
	long Group#2FontSize = -11
	long Group#2FontWeight = 700
	long Group#2FontColor = RGB(125,125,125)
	
	// Detail Band Attributes
	long DetailBandHeight = PixelstoUnits(22, YPixelsToUnits!)
	long DetailBandBackColor = RGB(255,255,255)
	string DetailIconFileName = '..\img\mainframe\u_mdi_xpmenu\xpmenu_icon4.jpg'
	string DetailFontFace = '$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$'
	long DetailFontSize = -9
	long DetailFontWeight = 700
	long DetailFontColor = RGB(150,150,150)
	
end variables

forward prototypes
public function string of_getclassname ()
public subroutine of_setmenudepth (integer ai_menudepth)
public function integer of_add_favorite (string as_menu_id, string as_pgm_name)
public function integer of_drawmenu (string as_parent_menu)
public function long of_drawmenu_1depth (string as_menu_id)
public function long of_drawmenu_2depth (string as_menu_id)
public function long of_drawmenu_3depth (string as_menu_id)
public function integer of_initializemenu ()
end prototypes

event pfe_nomouseover();this.visible = false
this.border = false
inv_propmon.of_unregister('nomouseover')
inv_propmon.of_stop()

end event

public function string of_getclassname ();return 'pf_u_mdi_xpmenu'

end function

public subroutine of_setmenudepth (integer ai_menudepth);menudepth = ai_menudepth

choose case menudepth
	case 1
		dw_menu.dataobject = 'pf_d_mdi_xpmenu_1depth'
	case 2
		dw_menu.dataobject = 'pf_d_mdi_xpmenu_2depth'
	case 3
		dw_menu.dataobject = 'pf_d_mdi_xpmenu_3depth'
	case else
		dw_menu.dataobject = ''
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'XP $$HEX8$$a4c2c0d07cc7200054ba74b294b22000$$ENDHEX$$3 Depth $$HEX12$$4caec0c9ccb920005cd404d6200000aca5b269d5c8b2e4b2$$ENDHEX$$.')
end choose

return

end subroutine

public function integer of_add_favorite (string as_menu_id, string as_pgm_name);pf_n_menudata lnv_menu

lnv_menu = create pf_n_menudata
lnv_menu.is_menu_id = as_menu_id
lnv_menu.is_pgm_name = as_pgm_name

openwithparm(pf_w_favorite, lnv_menu)
if message.stringparm = 'OK' then
	pf_n_hashtable lnvo_param
	lnvo_param = create pf_n_hashtable
	iw_parent.dynamic of_eventdispatcher('pf_u_mdi_favorite', 'pfe_refreshmenu', lnvo_param)
end if

return 1

end function

public function integer of_drawmenu (string as_parent_menu);long ll_menucnt, ll_xpos, ll_ypos, ll_textwidth, ll_textheight
string ls_pgm_name
pf_n_syntaxbuffer lnv_syntax
pf_s_size lstr_textsize, lstr_imgsize

setpointer(hourglass!)

this.setredraw(false)
this.post setredraw(true)

// $$HEX10$$70b374c730d108c7c4b3b0c6200008cd30ae54d6$$ENDHEX$$
dw_menu.dataobject = dw_menu.dataobject

// $$HEX7$$70b374c730d108c7c4b3b0c62000$$ENDHEX$$Syntax $$HEX2$$91c731c1$$ENDHEX$$
lnv_syntax = create pf_n_syntaxbuffer

// Parent PgmNo $$HEX8$$00ac2000c6c594b22000bdacb0c62000$$ENDHEX$$Default $$HEX4$$12ac200098ccacb9$$ENDHEX$$(=$$HEX6$$5ccdc1c0e8b2200054ba74b2$$ENDHEX$$)
if isnull(as_parent_menu) or as_parent_menu = '' then
	as_parent_menu = '00000'
	ls_pgm_name = 'ROOT'
else
	ls_pgm_name = inv_menu.of_getpgmname(as_parent_menu)
end if

// $$HEX8$$c1c004c7200054ba74b220005cd4dcc2$$ENDHEX$$
if DisplayHeaderBand = true then
	// $$HEX13$$c1c004c754ba74b2200034bcdcb4200092b174c72000c0c915c8$$ENDHEX$$
	lnv_syntax.of_append('DataWindow.Header.Height="' + string(HeaderBandHeight) + '"')
	
	// $$HEX16$$c1c004c754ba74b2200031bcf8ad7cb7b4c6dcb42000ecceecb7200024c115c8$$ENDHEX$$
	lnv_syntax.of_append('DataWindow.Header.Color="' + string(HeaderBandBackColor) + '"')
	
	// $$HEX16$$c1c004c754ba74b220004dd1a4c2b8d22000acc074c788c920006cad58d530ae$$ENDHEX$$
	if HeaderFontSize < 0 then HeaderFontSize *= -1
	gnv_extfunc.pf_gettextsizeW(handle(this), as_parent_menu, HeaderFontFace, HeaderFontSize, HeaderFontWeight, lstr_textsize)
	ll_textwidth = pixelstounits(lstr_textsize.width, xpixelstounits!)
	ll_textheight = pixelstounits(lstr_textsize.height, ypixelstounits!)
	
	// $$HEX23$$4dd1a4c2b8d22000acc074c788c97cb9200030ae00c93cc75cb82000c1c058d5200000acb4c670b3200015c82cb8$$ENDHEX$$
	ll_ypos = (HeaderBandHeight - ll_textheight) / 2
	
	if HeaderFontSize > 0 then HeaderFontSize *= -1
	lnv_syntax.of_append('create text(band=header alignment="2" text="' + ls_pgm_name + '" border="0" color="' + string(HeaderFontColor) + '" x="0" y="' + string(ll_ypos) + '" height="' + string(ll_textheight) + '" width="' + string(dw_menu.width) + '"  html.valueishtml="0"  name=t_parent_menu tag="' + as_parent_menu + '" pointer="Arrow!" visible="1"  font.face="' + HeaderFontFace + '" font.height="' + string(HeaderFontSize) + '" font.weight="' + string(HeaderFontWeight) + '"  font.family="0" font.pitch="0" font.charset="1" background.mode="2" background.color="553648127" )')
else
	lnv_syntax.of_append('DataWindow.Header.Height="0"')
end if

// Group#1 $$HEX4$$34bcdcb424c115c8$$ENDHEX$$
if MenuDepth > 1 then
	// $$HEX8$$34bcdcb4200092b174c7200024c115c8$$ENDHEX$$
	lnv_syntax.of_append('Datawindow.Header.1.Height="' + string(Group#1BandHeight) + '"')
	
	// $$HEX9$$34bcdcb4200030bcbdacc9c0200024c115c8$$ENDHEX$$
	lnv_syntax.of_append('Datawindow.Header.1.Color="' + string(Group#1BandBackColor) + '"')
	
	// $$HEX6$$44c574c758cf200024c115c8$$ENDHEX$$
	if Group#1IconFileName = '' then
		ll_xpos = long(dw_menu.describe("p_pgm_icon_lv1.X"))
		lnv_syntax.of_append('p_pgm_icon_lv1.Visible="0"')
		lnv_syntax.of_append('pgm_name_lv1.X="0~t' + string(ll_xpos) + '"')
	else
		if gnv_extfunc.of_GetImageSize(Group#1IconFileName, lstr_imgsize) > 0 then
			lnv_syntax.of_append('p_pgm_icon_lv1.FileName="' + Group#1IconFileName + '"')
			lnv_syntax.of_append('p_pgm_icon_lv1.Width="' + string(lstr_imgsize.width) + '"')
			lnv_syntax.of_append('p_pgm_icon_lv1.Height="' + string(lstr_imgsize.height) + '"')
			ll_ypos = (Group#1BandHeight - lstr_imgsize.height) / 2
			lnv_syntax.of_append('p_pgm_icon_lv1.Y="' + string(ll_ypos) + '"')
		end if
	end if
	
	// $$HEX23$$4dd1a4c2b8d22000acc074c788c97cb9200030ae00c93cc75cb82000c1c058d5200000acb4c670b3200015c82cb8$$ENDHEX$$
	if Group#1FontSize < 0 then Group#1FontSize *= -1
	gnv_extfunc.pf_gettextsizeW(handle(this), as_parent_menu, Group#1FontFace, Group#1FontSize, Group#1FontWeight, lstr_textsize)
	ll_textwidth = pixelstounits(lstr_textsize.width, xpixelstounits!)
	ll_textheight = pixelstounits(lstr_textsize.height, ypixelstounits!)
	ll_ypos = (Group#1BandHeight - ll_textheight) / 2
	lnv_syntax.of_append('pgm_name_lv1.Y="' + string(ll_ypos) + '"')
	lnv_syntax.of_append('pgm_name_lv1.Height="' + string(ll_textheight) + '"')
	
	// $$HEX5$$f0d3b8d2200024c115c8$$ENDHEX$$
	if Group#1FontSize > 0 then Group#1FontSize *= -1
	lnv_syntax.of_append('pgm_name_lv1.Font.Face="' + Group#1FontFace + '"')
	lnv_syntax.of_append('pgm_name_lv1.Font.Height="' + string(Group#1FontSize) + '"')
	lnv_syntax.of_append('pgm_name_lv1.Font.Weight="' + string(Group#1FontWeight) + '"')
	lnv_syntax.of_append('pgm_name_lv1.Font.Family="0"')
	lnv_syntax.of_append('pgm_name_lv1.Font.Pitch="0"')
	lnv_syntax.of_append('pgm_name_lv1.Font.Charset="1"')
	
	// $$HEX8$$f0d3b8d22000ecceecb7200024c115c8$$ENDHEX$$
	lnv_syntax.of_append('pgm_name_lv1.Color="' + string(Group#1FontColor) + '"')
end if

// Group#2 $$HEX4$$34bcdcb424c115c8$$ENDHEX$$
if MenuDepth > 2 then
	// $$HEX8$$34bcdcb4200092b174c7200024c115c8$$ENDHEX$$
	lnv_syntax.of_append('Datawindow.Header.2.Height="' + string(Group#2BandHeight) + '"')
	
	// $$HEX9$$34bcdcb4200030bcbdacc9c0200024c115c8$$ENDHEX$$
	lnv_syntax.of_append('Datawindow.Header.2.Color="' + string(Group#2BandBackColor) + '"')
	
	// $$HEX6$$44c574c758cf200024c115c8$$ENDHEX$$
	if Group#2IconFileName = '' then
		ll_xpos = long(dw_menu.describe("p_pgm_icon_lv2.X"))
		lnv_syntax.of_append('p_pgm_icon_lv2.Visible="0"')
		lnv_syntax.of_append('pgm_name_lv2.X="' + string(ll_xpos) + '"')
	else
		if gnv_extfunc.of_GetImageSize(Group#2IconFileName, lstr_imgsize) > 0 then
			lnv_syntax.of_append('p_pgm_icon_lv2.FileName="' + Group#2IconFileName + '"')
			lnv_syntax.of_append('p_pgm_icon_lv2.Width="' + string(lstr_imgsize.width) + '"')
			lnv_syntax.of_append('p_pgm_icon_lv2.Height="' + string(lstr_imgsize.height) + '"')
			ll_ypos = (Group#2BandHeight - lstr_imgsize.height) / 2
			lnv_syntax.of_append('p_pgm_icon_lv2.Y="' + string(ll_ypos) + '"')
		end if
	end if
	
	// $$HEX23$$4dd1a4c2b8d22000acc074c788c97cb9200030ae00c93cc75cb82000c1c058d5200000acb4c670b3200015c82cb8$$ENDHEX$$
	if Group#2FontSize < 0 then Group#2FontSize *= -1
	gnv_extfunc.pf_gettextsizeW(handle(this), as_parent_menu, Group#2FontFace, Group#2FontSize, Group#2FontWeight, lstr_textsize)
	ll_textwidth = pixelstounits(lstr_textsize.width, xpixelstounits!)
	ll_textheight = pixelstounits(lstr_textsize.height, ypixelstounits!)
	ll_ypos = (Group#2BandHeight - ll_textheight) / 2
	lnv_syntax.of_append('pgm_name_lv2.Y="' + string(ll_ypos) + '"')
	lnv_syntax.of_append('pgm_name_lv2.Height="' + string(ll_textheight) + '"')
	
	// $$HEX5$$f0d3b8d2200024c115c8$$ENDHEX$$
	if Group#2FontSize > 0 then Group#2FontSize *= -1
	lnv_syntax.of_append('pgm_name_lv2.Font.Face="' + Group#2FontFace + '"')
	lnv_syntax.of_append('pgm_name_lv2.Font.Height="' + string(Group#2FontSize) + '"')
	lnv_syntax.of_append('pgm_name_lv2.Font.Weight="' + string(Group#2FontWeight) + '"')
	lnv_syntax.of_append('pgm_name_lv2.Font.Family="0"')
	lnv_syntax.of_append('pgm_name_lv2.Font.Pitch="0"')
	lnv_syntax.of_append('pgm_name_lv2.Font.Charset="1"')
	
	// $$HEX8$$f0d3b8d22000ecceecb7200024c115c8$$ENDHEX$$
	lnv_syntax.of_append('pgm_name_lv2.Color="' + string(Group#2FontColor) + '"')
end if

// Detail $$HEX4$$34bcdcb424c115c8$$ENDHEX$$

// $$HEX8$$34bcdcb4200092b174c7200024c115c8$$ENDHEX$$
lnv_syntax.of_append('Datawindow.Detail.Height="' + string(DetailBandHeight) + '"')

// $$HEX9$$34bcdcb4200030bcbdacc9c0200024c115c8$$ENDHEX$$
lnv_syntax.of_append('Datawindow.Detail.Color="' + string(DetailBandBackColor) + '"')

// $$HEX6$$44c574c758cf200024c115c8$$ENDHEX$$
if DetailIconFileName = '' then
	ll_xpos = long(dw_menu.describe("p_pgm_icon.X"))
	lnv_syntax.of_append('p_pgm_icon.Visible="0"')
	lnv_syntax.of_append('pgm_name.X="' + string(ll_xpos) + '"')
else
	if gnv_extfunc.of_GetImageSize(DetailIconFileName, lstr_imgsize) > 0 then
		lnv_syntax.of_append('p_pgm_icon.FileName="' + DetailIconFileName + '"')
		lnv_syntax.of_append('p_pgm_icon.Width="' + string(lstr_imgsize.width) + '"')
		lnv_syntax.of_append('p_pgm_icon.Height="' + string(lstr_imgsize.height) + '"')
		ll_ypos = (DetailBandHeight - lstr_imgsize.height) / 2
		lnv_syntax.of_append('p_pgm_icon.Y="' + string(ll_ypos) + '"')
	end if
end if

// $$HEX23$$4dd1a4c2b8d22000acc074c788c97cb9200030ae00c93cc75cb82000c1c058d5200000acb4c670b3200015c82cb8$$ENDHEX$$
if DetailFontSize < 0 then DetailFontSize *= -1
gnv_extfunc.pf_gettextsizeW(handle(this), as_parent_menu, DetailFontFace, DetailFontSize, DetailFontWeight, lstr_textsize)
ll_textwidth = pixelstounits(lstr_textsize.width, xpixelstounits!)
ll_textheight = pixelstounits(lstr_textsize.height, ypixelstounits!)
ll_ypos = (DetailBandHeight - ll_textheight) / 2
lnv_syntax.of_append('pgm_name.Y="' + string(ll_ypos) + '"')
lnv_syntax.of_append('pgm_name.Height="' + string(ll_textheight) + '"')

// $$HEX5$$f0d3b8d2200024c115c8$$ENDHEX$$
if DetailFontSize > 0 then DetailFontSize *= -1
lnv_syntax.of_append('pgm_name.Font.Face="' + DetailFontFace + '"')
lnv_syntax.of_append('pgm_name.Font.Height="' + string(DetailFontSize) + '"')
lnv_syntax.of_append('pgm_name.Font.Weight="' + string(DetailFontWeight) + '"')
lnv_syntax.of_append('pgm_name.Font.Family="0"')
lnv_syntax.of_append('pgm_name.Font.Pitch="0"')
lnv_syntax.of_append('pgm_name.Font.Charset="1"')

// $$HEX8$$f0d3b8d22000ecceecb7200024c115c8$$ENDHEX$$
lnv_syntax.of_append('pgm_name.Color="' + string(DetailFontColor) + '"')

// $$HEX9$$70b374c730d108c7c4b3b0c62000c0bcbdac$$ENDHEX$$
string ls_error

if lnv_syntax.of_size() > 0 then
	ls_error = dw_menu.modify(lnv_syntax.of_tostring())
	if len(ls_error) > 0 then
		::clipboard(lnv_syntax.of_tostring())
		messagebox(this.classname() + '.of_drawmenu() Error!!', ls_error)
		return -1
	end if
end if

// $$HEX12$$54ba74b2200070b374c730d17cb9200000ac38c828c6e4b2$$ENDHEX$$
ll_menucnt =  inv_menu.of_getmenudata('parent', as_parent_menu)

// DEPTH$$HEX15$$d0c52000deb9b0cd1cc1200070b374c730d17cb920005cd4dcc25cd5e4b2$$ENDHEX$$
dw_menu.reset()

choose case MenuDepth
	case 1
		this.of_drawmenu_1depth(as_parent_menu)
	case 2
		this.of_drawmenu_2depth(as_parent_menu)
	case 3
		this.of_drawmenu_3depth(as_parent_menu)
end choose

dw_menu.groupcalc()

choose case menudepth
	case 1
	case 2
		dw_menu.post expandall()
		
		// $$HEX18$$8cc821ce200054ba74b200ac2000ceb944c7200018c2200088c730ae20004cb538bbd0c5$$ENDHEX$$
		// $$HEX24$$a8ba50b4200011c88cd72000c1c0dcd05cb82000f4bcecc5fcc8e0ac2000abcc200089d5ccb92000bcd3d0ccf4bc84c7$$ENDHEX$$
		//dw_menu.collapseall()
		//dw_menu.expand(1, 1)
	case 3
		dw_menu.CollapseLevel (1)
		//dw_menu.post expandall()
		//dw_menu.post expandlevel(2)
end choose

//dw_menu.expandall()
is_parent_menu = as_parent_menu

return ll_menucnt

end function

public function long of_drawmenu_1depth (string as_menu_id);// 1$$HEX11$$08b8a8bc2000b8d2acb954ba74b22000f8adacb930ae$$ENDHEX$$
pf_n_rolemenu lnv_menuauth

string ls_parent_menu, ls_parent_name
string ls_pgm_kc, ls_menu_id, ls_pgm_id
string ls_pgm_name
long i, ll_new, ll_sort_order, ll_rowcnt

// $$HEX7$$c1c004c7f4d354b3200085ba6dce$$ENDHEX$$
lnv_menuauth = create pf_n_rolemenu
if lnv_menuauth.of_getmenudata('self', as_menu_id) <= 0 then return -1

ls_parent_menu = as_menu_id
ls_parent_name = lnv_menuauth.ids_menudata.getitemstring(1, 'pgm_name')
destroy lnv_menuauth

// $$HEX6$$f4d354b3200044c574c75cd1$$ENDHEX$$
ll_rowcnt = inv_menu.ids_menudata.rowcount()
for i = 1 to ll_rowcnt
	ls_menu_id = inv_menu.ids_menudata.getitemstring(i, 'menu_id')
	ls_pgm_id = inv_menu.ids_menudata.getitemstring(i, 'pgm_id')
	ls_pgm_name = inv_menu.ids_menudata.getitemstring(i, 'pgm_name')
	ls_pgm_kc = inv_menu.ids_menudata.getitemstring(i, 'pgm_kc')
	ll_sort_order = inv_menu.ids_menudata.getitemnumber(i, 'sort_order')
	
	if ls_pgm_kc = 'P' then
		ll_new = dw_menu.insertrow(0)
		dw_menu.setitem(ll_new, 'menu_id', ls_menu_id)
		dw_menu.setitem(ll_new, 'pgm_id', ls_pgm_id)
		dw_menu.setitem(ll_new, 'pgm_name', ls_pgm_name)
		dw_menu.setitem(ll_new, 'pgm_kind_code', ls_pgm_kc)
		dw_menu.setitem(ll_new, 'sort_order', ll_sort_order)
		dw_menu.setitem(ll_new, 'menu_id_lv1', ls_parent_menu)
		dw_menu.setitem(ll_new, 'pgm_name_lv1', ls_parent_name)
	end if
next

return 1

end function

public function long of_drawmenu_2depth (string as_menu_id);// 2$$HEX11$$08b8a8bc2000b8d2acb954ba74b22000f8adacb930ae$$ENDHEX$$
pf_n_rolemenu lnv_menuauth

string ls_parent_menu, ls_parent_name
string ls_pgm_kc, ls_menu_id, ls_pgm_id
string ls_pgm_name
long i, j, ll_new
long ll_sort_order, ll_parent_order
long ll_rowcnt, ll_itemcnt

this.of_drawmenu_1depth(as_menu_id)

lnv_menuauth = create pf_n_rolemenu

// 1$$HEX5$$08b8a8bc2000f4d354b3$$ENDHEX$$
ll_rowcnt = inv_menu.ids_menudata.rowcount()
for i = 1 to ll_rowcnt
	ls_parent_menu = inv_menu.ids_menudata.getitemstring(i, 'menu_id')
	ls_parent_name = inv_menu.ids_menudata.getitemstring(i, 'pgm_name')
	ll_parent_order = inv_menu.ids_menudata.getitemnumber(i, 'sort_order')
	
	// $$HEX6$$58d504c7200044c574c75cd1$$ENDHEX$$
	ll_itemcnt = lnv_menuauth.of_getmenudata('parent', ls_parent_menu)
	for j = 1 to ll_itemcnt
		ls_menu_id = lnv_menuauth.ids_menudata.getitemstring(j, 'menu_id')
		ls_pgm_id = lnv_menuauth.ids_menudata.getitemstring(j, 'pgm_id')
		ls_pgm_name = lnv_menuauth.ids_menudata.getitemstring(j, 'pgm_name')
		ls_pgm_kc = lnv_menuauth.ids_menudata.getitemstring(j, 'pgm_kc')
		ll_sort_order = lnv_menuauth.ids_menudata.getitemnumber(j, 'sort_order')
		
		if ls_pgm_kc = 'P' then
			ll_new = dw_menu.insertrow(0)
			dw_menu.setitem(ll_new, 'menu_id', ls_menu_id)
			dw_menu.setitem(ll_new, 'pgm_id', ls_pgm_id)
			dw_menu.setitem(ll_new, 'pgm_name', ls_pgm_name)
			dw_menu.setitem(ll_new, 'pgm_kind_code', ls_pgm_kc)
			dw_menu.setitem(ll_new, 'sort_order', ll_sort_order)
			dw_menu.setitem(ll_new, 'menu_id_lv1', ls_parent_menu)
			dw_menu.setitem(ll_new, 'pgm_name_lv1', ls_parent_name)
			dw_menu.setitem(ll_new, 'sort_order_lv1', ll_parent_order)
		end if
	next
next

return 1

end function

public function long of_drawmenu_3depth (string as_menu_id);// 3$$HEX11$$08b8a8bc2000b8d2acb954ba74b22000f8adacb930ae$$ENDHEX$$
pf_n_rolemenu lnv_menuauth_lv1, lnv_menuauth_lv2

string ls_parent_menu_lv1, ls_parent_name_lv1
string ls_parent_menu_lv2, ls_parent_name_lv2
string ls_pgm_kc, ls_menu_id, ls_pgm_id
string ls_pgm_name
long i, j, ll_new
long ll_sort_order, ll_parent_order_lv1, ll_parent_order_lv2
long ll_rowcnt, ll_itemcnt_lv2

lnv_menuauth_lv2 = create pf_n_rolemenu
lnv_menuauth_lv1 = create pf_n_rolemenu

// 2$$HEX5$$08b8a8bc2000f4d354b3$$ENDHEX$$
ll_rowcnt = inv_menu.ids_menudata.rowcount()
for i = 1 to ll_rowcnt
	ls_parent_menu_lv2 = inv_menu.ids_menudata.getitemstring(i, 'menu_id')
	ls_parent_name_lv2 = inv_menu.ids_menudata.getitemstring(i, 'pgm_name')
	ll_parent_order_lv2 = inv_menu.ids_menudata.getitemnumber(i, 'sort_order')

	// 1$$HEX5$$08b8a8bc2000f4d354b3$$ENDHEX$$
	ll_itemcnt_lv2 = lnv_menuauth_lv2.of_getmenudata('parent', ls_parent_menu_lv2)
	for j = 1 to ll_itemcnt_lv2
		ls_parent_menu_lv1 = lnv_menuauth_lv2.ids_menudata.getitemstring(j, 'menu_id')
		ls_parent_name_lv1 = lnv_menuauth_lv2.ids_menudata.getitemstring(j, 'pgm_name')
		ll_parent_order_lv1 = lnv_menuauth_lv2.ids_menudata.getitemnumber(j, 'sort_order')
		
		ll_new = dw_menu.insertrow(0)
		dw_menu.setitem(ll_new, 'menu_id', ls_menu_id)
		dw_menu.setitem(ll_new, 'pgm_id', ls_pgm_id)
		dw_menu.setitem(ll_new, 'pgm_name', ls_pgm_name)
		dw_menu.setitem(ll_new, 'pgm_kind_code', ls_pgm_kc)
		dw_menu.setitem(ll_new, 'sort_order', ll_sort_order)
		dw_menu.setitem(ll_new, 'menu_id_lv1', ls_parent_menu_lv1)
		dw_menu.setitem(ll_new, 'pgm_name_lv1', ls_parent_name_lv1)
		dw_menu.setitem(ll_new, 'sort_order_lv1', ll_parent_order_lv1)
		dw_menu.setitem(ll_new, 'menu_id_lv2', ls_parent_menu_lv2)
		dw_menu.setitem(ll_new, 'pgm_name_lv2', ls_parent_name_lv2)
		dw_menu.setitem(ll_new, 'sort_order_lv2', ll_parent_order_lv2)
		dw_menu.setitem(ll_new, 'expanded_once', 'N')
	next
next

return 1

end function

public function integer of_initializemenu ();dw_menu.dataobject = dw_menu.dataobject

if isvalid(inv_menu) then
	destroy inv_menu
	inv_menu = create pf_n_rolemenu
end if

return 0

end function

on pf_u_mdi_xpmenu.create
int iCurrent
call super::create
this.dw_menu=create dw_menu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_menu
end on

on pf_u_mdi_xpmenu.destroy
call super::destroy
destroy(this.dw_menu)
end on

event resize;call super::resize;dw_menu.x = -100
dw_menu.y = 0
dw_menu.width = this.width + 100
dw_menu.height = this.height

end event

event destructor;call super::destructor;if isvalid(inv_propmon) then
	inv_propmon.of_stop()
	destroy inv_propmon
end if

if isvalid(inv_menu) then
	destroy inv_menu
end if

end event

event pfe_postopen;call super::pfe_postopen;// register porps watcher
inv_propmon = create pf_n_propertywatcher
inv_propmon.of_registerparent(this)
inv_propmon.of_setvisibletime(2500)

// create rolemenu
inv_menu = create pf_n_rolemenu

// set default menu depth
this.of_setmenudepth(menudepth)

end event

type p_background from pf_u_userobject`p_background within pf_u_mdi_xpmenu
end type

type dw_menu from datawindow within pf_u_mdi_xpmenu
event expanding pbm_dwnexpanding
integer width = 901
integer height = 1488
integer taborder = 10
string title = "none"
string dataobject = "pf_d_mdi_xpmenu"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event expanding;if grouplevel <> 2 then return 0
if this.getitemstring(row, 'expanded_once') = 'Y' then return 0

// 3level $$HEX6$$70b374c730d1200070c88cd6$$ENDHEX$$

pf_n_rolemenu lnv_menuauth

string ls_parent_menu_lv1, ls_parent_name_lv1
string ls_parent_menu_lv2, ls_parent_name_lv2
string ls_pgm_kc, ls_menu_id, ls_pgm_id
string ls_pgm_name
long  k, ll_new
long ll_sort_order, ll_parent_order_lv1, ll_parent_order_lv2
long ll_itemcnt_lv1

lnv_menuauth = create pf_n_rolemenu

ls_parent_menu_lv2 = dw_menu.getitemstring(row, 'menu_id_lv2')
ls_parent_name_lv2 = dw_menu.getitemstring(row, 'pgm_name_lv2')
ll_parent_order_lv2 = dw_menu.getitemnumber(row, 'sort_order_lv2')

ls_parent_menu_lv1= dw_menu.getitemstring(row, 'menu_id_lv1')
ls_parent_name_lv1 = dw_menu.getitemstring(row, 'pgm_name_lv1')
ll_parent_order_lv1 = dw_menu.getitemnumber(row, 'sort_order_lv1')

ll_itemcnt_lv1 = lnv_menuauth.of_getmenudata('parent', ls_parent_menu_lv1)
for k = 1 to ll_itemcnt_lv1
	ls_menu_id = lnv_menuauth.ids_menudata.getitemstring(k, 'menu_id')
	ls_pgm_id = lnv_menuauth.ids_menudata.getitemstring(k, 'pgm_id')
	ls_pgm_name = lnv_menuauth.ids_menudata.getitemstring(k, 'pgm_name')
	ls_pgm_kc = lnv_menuauth.ids_menudata.getitemstring(k, 'pgm_kc')
	ll_sort_order = lnv_menuauth.ids_menudata.getitemnumber(k, 'sort_order')
	
	if k = 1 then
		ll_new = row
	else
		ll_new = dw_menu.insertrow(row + k -1)
		
		dw_menu.setitem(ll_new, 'menu_id_lv1', ls_parent_menu_lv1)
		dw_menu.setitem(ll_new, 'pgm_name_lv1', ls_parent_name_lv1)
		dw_menu.setitem(ll_new, 'sort_order_lv1', ll_parent_order_lv1)
		
		dw_menu.setitem(ll_new, 'menu_id_lv2', ls_parent_menu_lv2)
		dw_menu.setitem(ll_new, 'pgm_name_lv2', ls_parent_name_lv2)
		dw_menu.setitem(ll_new, 'sort_order_lv2', ll_parent_order_lv2)
	end if
	
	dw_menu.setitem(ll_new, 'menu_id', ls_menu_id)
	dw_menu.setitem(ll_new, 'pgm_id', ls_pgm_id)
	dw_menu.setitem(ll_new, 'pgm_name', ls_pgm_name)
	dw_menu.setitem(ll_new, 'pgm_kind_code', ls_pgm_kc)
	dw_menu.setitem(ll_new, 'sort_order', ll_sort_order)
	
	dw_menu.setitem(ll_new, 'expanded_once', 'Y')
next

return 0


end event

event clicked;String		ls_level, ls_data
Long		ll_row, ll_level

Choose Case row
	Case 0
		this.setRedRaw(false)
		ls_data 	= this.GetBandAtPointer()
		ls_level 	= LEFT(ls_data, Pos(ls_data, "~t") - 1)
		ll_row 	= Long(Mid(ls_data, Pos(ls_data, "~t") + Len("~t")))
		ll_level 	= Long(Mid(ls_level, LastPos(ls_level, ".") + Len(".")))

		If IsExpanded(ll_Row, ll_level) Then
			this.Collapse(ll_row, ll_level)
		Else
			If AppeonGetClientType() = 'PB' Then
				this.CollapseLevel(ll_level)
				this.Expand(ll_row, ll_level)
			Else
				this.CollapseLevel(ll_level)
				this.Expand(ll_row, ll_level)
				
				Choose Case MenuDepth
					Case 3
						if ll_level = 2 then
							this.CollapseLevel(1)
							this.expand(ll_row, 1)
							this.expand(ll_row, 2)
						end if
					Case 4
						if ll_level = 3 then
							this.CollapseLevel(1)
							this.expand(ll_row, 1)
							this.expand(ll_row, 2)
							this.expand(ll_row, 3)
						end if
				End Choose
			End If
		End If
		
		this.setRedRaw(true)
	Case Is > 0
		string ls_menu_id, ls_pgm_id, ls_pgm_name
		
		ls_menu_id = this.getitemstring(row, 'menu_id')
		ls_pgm_id = this.getitemstring(row, 'pgm_id')
		ls_pgm_name = this.getitemstring(row, 'pgm_name')
		
		if Not match( ls_pgm_name, '----') Then
			parent.post event pfe_menuclicked(ls_menu_id, ls_pgm_id, ls_pgm_name)
		end if
End CHoose

end event

event rbuttondown;if row = 0 then return

// $$HEX7$$90c9a8ac3ecc30ae200094cd00ac$$ENDHEX$$
pf_m_favorite lm_popup
string ls_menu_id, ls_pgm_name

ls_menu_id = this.getitemstring(row, 'menu_id')
ls_pgm_name = this.getitemstring(row, 'pgm_name')

lm_popup = create pf_m_favorite
lm_popup.of_setparent(parent, ls_menu_id, ls_pgm_name)
lm_popup.m_xpmenu.PopMenu(PointerX(iw_parent), PointerY(iw_parent))

end event

