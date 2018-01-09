HA$PBExportHeader$pf_u_mdi_menubar.sru
forward
global type pf_u_mdi_menubar from pf_u_userobject
end type
type dw_menubar from pf_u_datawindow within pf_u_mdi_menubar
end type
type hsb_1 from pf_u_hscrollbar within pf_u_mdi_menubar
end type
end forward

global type pf_u_mdi_menubar from pf_u_userobject
integer width = 3163
integer height = 120
string text = ""
boolean scaletoright = true
event pfe_menuselected ( string as_menu_id )
dw_menubar dw_menubar
hsb_1 hsb_1
end type
global pf_u_mdi_menubar pf_u_mdi_menubar

type variables
constant long NORMAL_TEXTCOLOR = rgb(119, 119, 119)
constant long MOUSEOVER_TEXTCOLOR = rgb(11, 20, 115)
constant long CLICKED_TEXTCOLOR = 0
constant long DISABLED_TEXTCOLOR = 0

private:
	pf_n_rolemenu inv_menu
	integer ii_selectedmenuseq
	long il_maxwidth

public:
	long MenuBarBackgroundColor = rgb(22,2,0)
	long FirstMenuStartXPos = 0 // pixels
	string MenuTextFontFace = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
	integer MenuTextFontSize = -9
	integer MenuTextFontWeight = 700
	
	long MenuTextFontColor = rgb(184,184,184)
	long MenuTextMoveOverColor = rgb(0,0,0)
	long MenuTextClickedColor = rgb(141,141,141)
	long MenuTextDisabledColor = rgb(0,0,0)
	long MenuTextBackColor = 553648127 // transparent
	
	string MenuDelimiterImage = "..\img\mainframe\u_mdi_menubar\menu_delimiter1.jpg"
	long MenuDelimiterHeight = 12 // pixels
	long MenuDelimiterWidth = 2 // pixels
	boolean MenuDelimiterAtTheBeginning = false
	boolean DisplayMenuIcon = false
	long GapBetweenMenuItems = 20 // pixels
	
	long SelectedMenuFontColor = rgb(141,141,141)
	long SelectedMenuBackColor = 1073741824 // window background

end variables

forward prototypes
public function integer of_drawmenu (string as_parent_menu)
public function long of_getmenuwidth ()
public function integer of_initializemenu ()
public function string of_getclassname ()
end prototypes

public function integer of_drawmenu (string as_parent_menu);long ll_menucnt, ll_xpos, ll_ypos, ll_menugap, ll_textwidth, ll_textheight, i
long ll_bgxpos, ll_bgwidth
string ls_menu_id, ls_pgm_id, ls_pgm_name, ls_pgm_icon
pf_n_syntaxbuffer lnv_syntax
pf_s_size lstr_textsize

dw_menubar.setredraw(false)
dw_menubar.post setredraw(true)

// $$HEX10$$70b374c730d108c7c4b3b0c6200008cd30ae54d6$$ENDHEX$$
dw_menubar.dataobject = dw_menubar.dataobject
ii_selectedmenuseq = 0

// Parent PgmNo $$HEX8$$00ac2000c6c594b22000bdacb0c62000$$ENDHEX$$Default $$HEX4$$12ac200098ccacb9$$ENDHEX$$(=$$HEX6$$5ccdc1c0e8b2200054ba74b2$$ENDHEX$$)
if isnull(as_parent_menu) or as_parent_menu = '' then
	as_parent_menu = '00000'
end if

// $$HEX14$$8cad5cd574c7200030b578b9200054ba74b2200000ac38c824c630ae$$ENDHEX$$
ll_menucnt = inv_menu.of_getmenudata('parent', as_parent_menu)

// $$HEX7$$70b374c730d108c7c4b3b0c62000$$ENDHEX$$Syntax $$HEX2$$91c731c1$$ENDHEX$$
lnv_syntax = create pf_n_syntaxbuffer
ll_xpos = pixelstounits(FirstMenuStartXPos, xpixelstounits!)
ll_menugap = pixelstounits(GapBetweenMenuItems, xpixelstounits!)

// $$HEX15$$70b374c730d108c7c4b3b0c6200031bcf8ad7cb7b4c6dcb42000ecceecb7$$ENDHEX$$
lnv_syntax.of_append('DataWindow.Header.Color="' + string(MenuBarBackgroundColor) + '"')
lnv_syntax.of_append('DataWindow.Header.Height="' + string(dw_menubar.height) + '"')

// $$HEX9$$5ccd08cd200054ba74b220006cad84bd90c7$$ENDHEX$$
if ll_menucnt > 0 then
	if MenuDelimiterAtTheBeginning = true then
		// $$HEX9$$54ba74b220006cad84bd90c72000ddc031c1$$ENDHEX$$
		if len(MenuDelimiterImage) > 0 then
			ll_xpos += ll_textwidth + ll_menugap
			ll_ypos = (dw_menubar.height - pixelstounits(MenuDelimiterHeight, ypixelstounits!)) / 2
			lnv_syntax.of_append('create bitmap(band=header filename="' + MenuDelimiterImage + '" x="' + string(ll_xpos) + '" y="' + string(ll_ypos) + '" height="' + string(pixelstounits(MenuDelimiterHeight, ypixelstounits!)) + '" width="' + string(pixelstounits(MenuDelimiterWidth, xpixelstounits!)) + '" border="0"  name=p_menudist_' + string(i, '00') +  ' tag="" visible="1" )')
			ll_xpos += pixelstounits(MenuDelimiterWidth, xpixelstounits!)
		end if
	end if
end if

for i = 1 to ll_menucnt
	ll_bgxpos = ll_xpos
	ll_xpos += ll_menugap
	
	ls_menu_id = inv_menu.ids_menudata.getitemstring(i, 'menu_id')
	ls_pgm_id = inv_menu.ids_menudata.getitemstring(i, 'pgm_id')
	ls_pgm_name = inv_menu.ids_menudata.getitemstring(i, 'pgm_name')
	ls_pgm_icon = inv_menu.ids_menudata.getitemstring(i, 'pgm_icon')
	
	// $$HEX11$$4dd1a4c2b8d22000acc074c788c920006cad58d530ae$$ENDHEX$$
	if MenuTextFontSize < 0 then MenuTextFontSize *= -1
	gnv_extfunc.pf_gettextsizeW(handle(this), ls_pgm_name, MenuTextFontFace, MenuTextFontSize, MenuTextFontWeight, lstr_textsize)
	ll_textwidth = pixelstounits(lstr_textsize.width, xpixelstounits!)
	ll_textheight = pixelstounits(lstr_textsize.height, ypixelstounits!)
	
	// $$HEX23$$4dd1a4c2b8d22000acc074c788c97cb9200030ae00c93cc75cb82000c1c058d5200000acb4c670b3200015c82cb8$$ENDHEX$$
	ll_ypos = (dw_menubar.height - ll_textheight) / 2
	
	// $$HEX9$$54ba74b2200044c574c758cf2000ddc031c1$$ENDHEX$$
	if len(ls_pgm_icon) > 0 and DisplayMenuIcon = true then
		// ASA Database $$HEX5$$acc0a9c62000dcc22000$$ENDHEX$$'\' $$HEX12$$12ac44c720001cc800b35cb82000bbba200000ac38c834c6$$ENDHEX$$
		// $$HEX4$$30b57cb71cc12000$$ENDHEX$$Database $$HEX6$$d0c52000bdac5cb87cb92000$$ENDHEX$$'/'$$HEX17$$5cb820006cad84bd74d51cc1200085c725b858d5e0ac200000ac38c840c61cc12000$$ENDHEX$$'\'$$HEX2$$5cb82000$$ENDHEX$$Replace $$HEX2$$5cd5e4b2$$ENDHEX$$
		ls_pgm_icon = pf_f_replaceall(ls_pgm_icon, '/', '\')
		lnv_syntax.of_append('create bitmap(band=header filename="' + ls_pgm_icon + '" x="' + string(ll_xpos) + '" y="' + string(ll_ypos) + '" height="' + string(ll_textheight) + '" width="' + string(ll_textheight * 4 / 3) + '" border="0"  name=p_menu_' + string(i, '00') +  ' tag="' + ls_menu_id + '" pointer="HyperLink!" visible="1" )')
		ll_xpos += (ll_textheight * 4 / 3) * 1.2
	end if
	
	// $$HEX9$$54ba74b220004dd1a4c2b8d22000ddc031c1$$ENDHEX$$
	// font.charset : 0 = ANSI;1 = The default character set for the specified font;2 = Symbol;128 = Shift JIS;255 = OEM
	// font.family : 0 = AnyFont;1 = Roman;2 = Swiss;3 = Modern;4 = Script;5 = Decorative
	// font.pitch : 0 = The default pitch for your system;1 = Fixed;2 = Variable
	if MenuTextFontSize > 0 then MenuTextFontSize *= -1
	lnv_syntax.of_append('create text(band=header alignment="2" text="' + ls_pgm_name + '" border="0" color="' + string(MenuTextFontColor) + '" x="' + string(ll_xpos) + '" y="' + string(ll_ypos) + '" height="76" width="' + string(ll_textwidth) + '"  html.valueishtml="0"  name=t_menu_' + string(i, '00') + ' tag="' + ls_menu_id + '" pointer="HyperLink!" visible="1"  font.face="' + MenuTextFontFace + '" font.height="' + string(MenuTextFontSize) + '" font.weight="' + string(MenuTextFontWeight) + '"  font.family="0" font.pitch="0" font.charset="1" background.mode="2" background.color="' + string(MenuTextBackColor) + '" )')
	ll_xpos += ll_textwidth + ll_menugap
	
	// $$HEX13$$31bcf8ad7cb7b4c6dcb4a9c620004dd1a4c2b8d22000ddc031c1$$ENDHEX$$
	ll_bgxpos += pixelstounits(1, xpixelstounits!)
	ll_bgwidth = ll_xpos - ll_bgxpos - pixelstounits(1, xpixelstounits!)
	lnv_syntax.of_put(lnv_syntax.of_size() - 1, 'create text(band=header alignment="2" text="" border="0" color="33554432" x="' + string(ll_bgxpos) + '" y="0" height="' + string(dw_menubar.height) + '" width="' + string(ll_bgwidth) + '" html.valueishtml="0"  name=t_menubg_' + string(i, '00') + ' tag="' + ls_menu_id + '" visible="1"  font.face="$$HEX2$$74adbcb9$$ENDHEX$$" font.height="-9" font.weight="400"  font.family="1" font.pitch="2" font.charset="1" background.mode="1" background.color="' + string(MenuTextBackColor) + '" )')
	
	// $$HEX9$$54ba74b220006cad84bd90c72000ddc031c1$$ENDHEX$$
	if len(MenuDelimiterImage) > 0 then
		ll_ypos = (dw_menubar.height - pixelstounits(MenuDelimiterHeight, ypixelstounits!)) / 2
		lnv_syntax.of_append('create bitmap(band=header filename="' + MenuDelimiterImage + '" x="' + string(ll_xpos) + '" y="' + string(ll_ypos) + '" height="' + string(pixelstounits(MenuDelimiterHeight, ypixelstounits!)) + '" width="' + string(pixelstounits(MenuDelimiterWidth, xpixelstounits!)) + '" border="0"  name=p_menudist_' + string(i, '00') +  ' tag="" visible="1" )')
		ll_xpos += pixelstounits(MenuDelimiterWidth, xpixelstounits!)
	end if
next

// $$HEX5$$54ba74b2200038ae74c7$$ENDHEX$$(width) $$HEX2$$f4bc00ad$$ENDHEX$$
il_maxwidth = ll_xpos

// $$HEX9$$70b374c730d108c7c4b3b0c62000ddc031c1$$ENDHEX$$
string ls_error
if lnv_syntax.of_size() > 0 then
	ls_error = dw_menubar.modify(lnv_syntax.of_tostring())
	if len(ls_error) > 0 then
		::clipboard(lnv_syntax.of_tostring())
		messagebox(dw_menubar.classname() + '.of_drawmenu() Error!!', ls_error)
		return -1
	end if
end if

// $$HEX9$$54ba74b220008cc85cd4200008cd30ae54d6$$ENDHEX$$
if dw_menubar.x <> 0 then dw_menubar.x = 0

// $$HEX7$$acb9acc074c788c9200018c289d5$$ENDHEX$$
this.event resize(0, this.width, this.height)

return ll_menucnt

end function

public function long of_getmenuwidth ();return il_maxwidth

end function

public function integer of_initializemenu ();// $$HEX18$$04d6acc720005cd4dcc21cb4200054ba74b27cb9200008cd30ae54d6200069d5c8b2e4b2$$ENDHEX$$

// $$HEX10$$70b374c730d108c7c4b3b0c6200008cd30ae54d6$$ENDHEX$$
dw_menubar.dataobject = dw_menubar.dataobject

// inv_menu $$HEX3$$08cd30ae54d6$$ENDHEX$$
if isvalid(inv_menu) then
	destroy inv_menu
	inv_menu = create pf_n_rolemenu
end if

// $$HEX13$$04d6acc7200020c1ddd01cb4200054ba74b2200008cd30ae54d6$$ENDHEX$$
ii_selectedmenuseq = 0

// $$HEX10$$e8ceb8d264b820008cc85cd4200008cd30ae54d6$$ENDHEX$$
if hsb_1.visible = true then hsb_1.visible = false
if dw_menubar.x <> 0 then dw_menubar.x = 0

return 0

end function

public function string of_getclassname ();return 'pf_u_mdi_menubar'

end function

on pf_u_mdi_menubar.create
int iCurrent
call super::create
this.dw_menubar=create dw_menubar
this.hsb_1=create hsb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_menubar
this.Control[iCurrent+2]=this.hsb_1
end on

on pf_u_mdi_menubar.destroy
call super::destroy
destroy(this.dw_menubar)
destroy(this.hsb_1)
end on

event destructor;call super::destructor;if isvalid(inv_menu) then
	destroy inv_menu
end if

end event

event resize;call super::resize;dw_menubar.height = newheight
hsb_1.x = newwidth - hsb_1.width

if il_maxwidth > newwidth then
	hsb_1.y = (newheight - hsb_1.height) / 2
	hsb_1.visible = true
else
	dw_menubar.x = 0
	hsb_1.visible = false
end if

end event

event pfe_postopen;call super::pfe_postopen;inv_menu = create pf_n_rolemenu

end event

type p_background from pf_u_userobject`p_background within pf_u_mdi_menubar
end type

type dw_menubar from pf_u_datawindow within pf_u_mdi_menubar
integer width = 29938
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_mdi_sheettab_disp"
boolean border = false
boolean applydesign = false
boolean singlerowselection = false
boolean sorting = false
boolean useborder = false
end type

event clicked;call super::clicked;pf_n_syntaxbuffer lnv_syntax
lnv_syntax = create pf_n_syntaxbuffer
string ls_menu_id
integer li_colseq

if left(dwo.name, 7) = 'p_menu_' or left(dwo.name, 7) = 't_menu_' or left(dwo.name, 9) = 't_menubg_' then
	if ii_selectedmenuseq > 0 then
		if MenuTextBackColor = 553648127 then
			lnv_syntax.of_append('t_menu_' + string(ii_selectedmenuseq, '00') + '.Background.Mode=1')
			lnv_syntax.of_append('t_menubg_' + string(ii_selectedmenuseq, '00') + '.Background.Mode=1')
		end if
		
		lnv_syntax.of_append('t_menu_' + string(ii_selectedmenuseq, '00') + '.Background.Color=' + string(MenuTextBackColor))
		lnv_syntax.of_append('t_menubg_' + string(ii_selectedmenuseq, '00') + '.Background.Color=' + string(MenuTextBackColor))
		lnv_syntax.of_append('t_menu_' + string(ii_selectedmenuseq, '00') + '.Color=' + string(MenuTextFontColor))
		
		ii_selectedmenuseq = 0
	end if
	
	li_colseq = integer(right(dwo.name, 2))

	lnv_syntax.of_append('t_menu_' + string(li_colseq, '00') + '.Background.Mode=0')
	lnv_syntax.of_append('t_menubg_' + string(li_colseq, '00') + '.Background.Mode=0')
	lnv_syntax.of_append('t_menu_' + string(li_colseq, '00') + '.Background.Color=' + string(SelectedMenuBackColor))
	lnv_syntax.of_append('t_menubg_' + string(li_colseq, '00') + '.Background.Color=' + string(SelectedMenuBackColor))
	lnv_syntax.of_append('t_menu_' + string(li_colseq, '00') + '.Color=' + string(SelectedMenuFontColor))
	ii_selectedmenuseq = li_colseq
	
	ls_menu_id = this.describe('t_menu_' + string(li_colseq, '00') + '.Tag')
	parent.post event pfe_menuselected(ls_menu_id)
end if

string ls_error

if lnv_syntax.of_size() > 0 then
	ls_error = this.modify(lnv_syntax.of_tostring())
	if len(ls_error) > 0 then
		::clipboard(lnv_syntax.of_tostring())
		messagebox(this.classname() + '.of_clicked() Error!!', ls_error)
		return -1
	end if
end if

end event

type hsb_1 from pf_u_hscrollbar within pf_u_mdi_menubar
integer x = 2994
integer y = 12
integer width = 165
integer height = 100
boolean bringtotop = true
boolean stdheight = false
integer minposition = 1
integer maxposition = 100
integer position = 1
boolean fixedtoright = true
end type

event lineleft;call super::lineleft;if dw_menubar.x + 500 > 0 then
	dw_menubar.x = 0
else
	dw_menubar.x += 500
end if

end event

event lineright;call super::lineright;long ll_max

ll_max = (il_maxwidth - parent.width + this.width) * -1
if dw_menubar.x - 500 > ll_max then
	dw_menubar.x -= 500
else
	dw_menubar.x = ll_max
end if

end event

