$PBExportHeader$pf_u_mdi_sheettab.sru
$PBExportComments$MDI 화면의 현재 오픈되어 있는 Sheet 윈도우를 관리하는 사용자 오브젝트 입니다.
forward
global type pf_u_mdi_sheettab from pf_u_userobject
end type
type hsb_1 from pf_u_hscrollbar within pf_u_mdi_sheettab
end type
type dw_sheettab from datawindow within pf_u_mdi_sheettab
end type
end forward

global type pf_u_mdi_sheettab from pf_u_userobject
integer width = 3163
integer height = 120
event pfe_addsheettab ( )
event pfe_closesheettab ( )
event pfe_deselectsheettab ( )
event pfe_selectsheettab ( )
hsb_1 hsb_1
dw_sheettab dw_sheettab
end type
global pf_u_mdi_sheettab pf_u_mdi_sheettab

type prototypes

end prototypes

type variables
private:
	constant long DW_HSCROLL_UNIT = 100 // PBUnit
	
	window iw_sheet[]
	datastore ids_tab
	
	long il_tabimageheight
	long il_maxtabwidth
	long il_selectedtabseq
	long il_deactivetabseq
	long il_closeiconwidth
	long il_closeiconheight
	long il_maxtabseq
	long TabStartXpos = 0

public:
	string NormalTabImageFile = "..\img\mainframe\u_mdi_sheettab\sheettab2_normal.png"
	string SelectedTabImageFile = "..\img\mainframe\u_mdi_sheettab\sheettab2_selected.png"
	long TabTextLeftMargin = 10 // pixel
	long TabTextRightMargin = 30 // pixel
	long NormalTabTextColor = RGB(132,132,132)
	long SelectedTabTextColor = RGB(42,97,203)
	long TabControlBackColor = RGB(245,245,245)
	boolean EnableTabClose = true
	boolean ShowUnderLine = false
	long UnderLinePenColor = RGB(121,112,101)
	long UnderLinePenWidth = 1

end variables

forward prototypes
public function integer of_selecttab (string as_menu_id)
public function long of_addtab (string as_menu_id, string as_pgm_id, string as_pgm_name)
public function integer of_selecttab (long al_tabseq)
public function long of_addtab (string as_menu_id, string as_pgm_id, string as_pgm_name, readonly window aw_sheet)
public function integer of_closetab (long al_tabseq)
public function integer of_deselecttab (long al_tabseq)
public function integer of_sheetsetfocus (string as_menu_id)
public function boolean of_isopenedsheet (string as_menu_id)
public function string of_getclassname ()
public function integer of_popup_addfavorite (string as_menu_id, string as_pgm_id, string as_pgm_name)
public function integer of_popup_closewindow (string as_menu_id, string as_pgm_id, string as_pgm_name)
public function integer of_popup_programhelp (string as_menu_id, string as_pgm_id, string as_pgm_name)
public function integer of_popup_closeall ()
public function integer of_scrolltab (long al_scrollwidth)
end prototypes

event pfe_addsheettab();pf_n_hashtable lnvo_param
string ls_menu_id, ls_pgm_id, ls_pgm_name
window lw_sheet_ref
long ll_retval

//iw_parent.dynamic of_getparameter(lnvo_param)
lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

ls_menu_id = lnvo_param.of_getstring('menu_id')
ls_pgm_id = lnvo_param.of_getstring('pgm_id')
ls_pgm_name = lnvo_param.of_getstring('pgm_name')
lw_sheet_ref = lnvo_param.of_get('sheet_ref')

ll_retval = this.of_addtab(ls_menu_id, ls_pgm_id, ls_pgm_name, lw_sheet_ref)

//lnvo_param.of_put("ReturnValue", ll_retval)
gnv_session.of_put("ReturnValue", ll_retval)

return

end event

event pfe_closesheettab();pf_n_hashtable lnvo_param
long ll_tab_seq, ll_retval

//iw_parent.dynamic of_getparameter(lnvo_param)
lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

ll_tab_seq = lnvo_param.of_getlong('tab_seq')
ll_retval = this.of_closetab(ll_tab_seq)

//lnvo_param.of_put("ReturnValue", ll_retval)
gnv_session.of_put("ReturnValue", ll_retval)

return

end event

event pfe_deselectsheettab();pf_n_hashtable lnvo_param
long ll_retval

lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

// Deselect는 Select시에만 처리 한다
il_deactivetabseq = lnvo_param.of_getlong('tab_seq')

gnv_session.of_put("ReturnValue", ll_retval)

return

end event

event pfe_selectsheettab();pf_n_hashtable lnvo_param
long ll_tab_seq, ll_retval

//iw_parent.dynamic of_getparameter(lnvo_param)
lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

setpointer(hourglass!)
if appeongetclienttype() = 'WEB' then
end if

// Deactive 된 Tabseq가 있으면 먼저 처리
if il_deactivetabseq > 0 then
	this.of_deselecttab(il_deactivetabseq)
	il_deactivetabseq = 0
end if

ll_tab_seq = lnvo_param.of_getlong('tab_seq')
ll_retval = this.of_selecttab(ll_tab_seq)

setpointer(arrow!)
if appeongetclienttype() = 'WEB' then
end if

//lnvo_param.of_put("ReturnValue", ll_retval)
gnv_session.of_put("ReturnValue", ll_retval)

return

end event

public function integer of_selecttab (string as_menu_id);long ll_find, ll_tabseq

ll_find = ids_tab.find("menu_id='" + as_menu_id + "'", 1, ids_tab.rowcount())
if ll_find <= 0 then return -1

ll_tabseq = ids_tab.getitemnumber(ll_find, 'tab_seq')
return this.of_selecttab(ll_tabseq)

end function

public function long of_addtab (string as_menu_id, string as_pgm_id, string as_pgm_name);long ll_new, ll_tabseq
pf_s_size lstr_textsize
string ls_syntax, ls_errmsg

dw_sheettab.setredraw(false)
dw_sheettab.post setredraw(true)

ll_new = ids_tab.insertrow(0)
ll_tabseq = il_maxtabseq + 1

ids_tab.setitem(ll_new, 'tab_seq', ll_tabseq)
ids_tab.setitem(ll_new, 'menu_id', as_menu_id)
ids_tab.setitem(ll_new, 'pgm_id', as_pgm_id)
ids_tab.setitem(ll_new, 'pgm_name', as_pgm_name)

// 텍스트 사이즈 구하기
gnv_extfunc.pf_gettextsizeW(handle(this), as_pgm_name, "맑은 고딕", 9, 700, lstr_textsize)

// 탭 이미지 생성
string ls_tabnotselectedimage
string ls_tabselectedimage

ls_tabnotselectedimage = gnv_extfunc.of_getpowerframetemppath()
ls_tabnotselectedimage += "tabnotselectedimage_" + string(ll_tabseq, '000') + ".jpg"

ls_tabselectedimage = gnv_extfunc.of_getpowerframetemppath()
ls_tabselectedimage += "tabselectedimage_" + string(ll_tabseq, '000') + ".jpg"

long ll_resizewidth, ll_resizeheight

ll_resizewidth = TabTextLeftMargin + lstr_textsize.width + TabTextRightMargin
ll_resizeheight = il_tabimageheight

gnv_extfunc.pf_ResizeImage4PB(NormalTabImageFile, ls_tabnotselectedimage, 0, 0, ll_resizewidth, ll_resizeheight)
gnv_extfunc.pf_ResizeImage4PB(SelectedTabImageFile, ls_tabselectedimage, 0, 0, ll_resizewidth, ll_resizeheight)

long ll_textwidth, ll_textheight
long ll_imagewidth, ll_imageheight
long ll_textxpos, ll_textypos

ll_textwidth = pixelstounits(lstr_textsize.width, xpixelstounits!)
ll_textheight = pixelstounits(lstr_textsize.height, ypixelstounits!)

ll_imagewidth = pixelstounits(ll_resizewidth, xpixelstounits!)
ll_imageheight = pixelstounits(il_tabimageheight, ypixelstounits!)

ll_textxpos = TabStartXpos + il_MaxTabWidth + pixelstounits(TabTextLeftMargin, xpixelstounits!)
ll_textypos = (ll_imageheight - ll_textheight) / 2

ls_syntax = 'create bitmap(band=header pointer="HyperLink!" filename="' + ls_tabnotselectedimage + '" x="' + string(TabStartXpos + il_MaxTabWidth) + '" y="' + '0' + '" height="' + string(ll_imageheight) + '" width="' + string(ll_imagewidth) + '" border="0"  name=tabnotselected_' + string(ll_tabseq, '000') + ' visible="1" )'
ls_syntax += '~r~ncreate bitmap(band=header pointer="HyperLink!" filename="' + ls_tabselectedimage + '" x="' + string(TabStartXpos + il_MaxTabWidth) + '" y="' + '0' + '" height="' + string(ll_imageheight) + '" width="' + string(ll_imagewidth) + '" border="0"  name=tabselected_' + string(ll_tabseq, '000') + ' visible="0" )'
ls_syntax	 += '~r~ncreate text(band=header alignment="2" pointer="HyperLink!" text="' +  as_pgm_name + '" border="0" color="' + string(SelectedTabTextColor) + '" x="' + string(ll_textxpos) + '" y="' + string(ll_textypos) + '" height="' + string(ll_textheight) + '" width="' + String(ll_textwidth) + '" html.valueishtml="0"  name=tabtext_' + string(ll_tabseq, '000') + ' tag="' + as_menu_id + '" visible="1"  font.face="' + "맑은 고딕" + '" font.height="-' + string(9) + '" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'

ls_errmsg = dw_sheettab.modify(ls_syntax)
if len(ls_errmsg) > 0 then
	messagebox('modify error', ls_errmsg)
	return -1
end if

// 확인 후 수정
//ids_tab.setitem(ll_new, 'image_xpos', TabStartXpos + il_MaxTabWidth)
//ids_tab.setitem(ll_new, 'image_width', ll_imagewidth)

il_maxtabwidth += ll_imagewidth
il_maxtabseq = ll_tabseq

// DW 스크롤용 HScrollBar 컨트롤 Visible 처리
long ll_scrollwidth

if (TabStartXpos + il_maxtabwidth) > this.width then
	ll_scrollwidth = ((TabStartXpos + il_maxtabwidth) - this.width + hsb_1.width) * -1
	this.of_scrolltab(ll_scrollwidth)
	//dw_sheettab.x = (il_maxtabwidth - this.width + hsb_1.width) * -1
	hsb_1.visible = true
end if

return ll_tabseq

end function

public function integer of_selecttab (long al_tabseq);long ll_rownum
string ls_syntax, ls_errmsg
long ll_imagexpos, ll_imagewidth

if il_selectedtabseq = al_tabseq then return 0

ll_rownum = ids_tab.find("tab_seq=" + string(al_tabseq), 1, ids_tab.rowcount())
if ll_rownum <= 0 then return -1

//ll_imagexpos = ids_tab.getitemnumber(ll_rownum, 'image_xpos')
//ll_imagewidth = ids_tab.getitemnumber(ll_rownum, 'image_width')

ll_imagexpos = long(dw_sheettab.describe("tabnotselected_" + string(al_tabseq, '000') + ".x"))
ll_imagewidth = long(dw_sheettab.describe("tabnotselected_" + string(al_tabseq, '000') + ".width"))

ls_syntax = 'tabnotselected_' + string(al_tabseq, '000') + '.visible=0'
ls_syntax += '~r~ntabselected_' + string(al_tabseq, '000') + '.visible=1'
ls_syntax += '~r~ntabtext_' + string(al_tabseq, '000') + '.color=' + string(SelectedTabTextColor)
ls_syntax += '~r~ntabtext_' + string(al_tabseq, '000') + '.Font.Weight=700'

long ll_closexpos, ll_closeypos

ll_closexpos = ll_imagexpos + ll_imagewidth - pixelstounits(TabTextRightMargin, xpixelstounits!) + (pixelstounits(TabTextRightMargin, xpixelstounits!) - il_closeiconwidth) / 2 -12
ll_closeypos = (pixelstounits(il_tabimageheight, ypixelstounits!) - il_closeiconheight) / 2 + 4

if EnableTabClose = True then
	ls_syntax += '~r~np_close.x=' +  string(ll_closexpos)
	ls_syntax += '~r~np_close.y=' +  string(ll_closeypos)
	ls_syntax += '~r~np_close.visible=1'
end if

ls_errmsg = dw_sheettab.modify(ls_syntax)
if len(ls_errmsg) > 0 then
	::clipboard(ls_syntax)
	messagebox('of_selecttab() error', ls_errmsg)
	return -1
end if

dw_sheettab.setposition("p_close", "header", true)
il_selectedtabseq = al_tabseq

////20150414
////선택된 탭 화면에 표시되는지 확인후 스크롤 이동시켜줌
//long ll_tabxpos
//ll_tabxpos = long(dw_sheettab.describe('tabnotselected_'  + string(al_tabseq, '000') + '.X'))
//
//long ll_tabselectedwidth
//ll_tabselectedwidth = long(dw_sheettab.describe('tabnotselected_'  + string(al_tabseq,'000') + '.Width'))
//
//int li_row
//long ll_tabselectedtotalwidth
//ll_rownum = ids_tab.find("tab_seq=" + string(al_tabseq,'000'), 1, ids_tab.rowcount())
//
//           long ll_tabminusxpos, ll_tabminusxposresult
//           for li_row = 1 to ll_rownum 
//                     ll_tabselectedtotalwidth += long(dw_sheettab.describe('tabnotselected_'  + string(li_row,'000') + '.Width'))
//                     ll_tabminusxpos = long(dw_sheettab.describe('tabnotselected_'  + string(li_row, '000') + '.X'))
//
//                     ll_tabminusxposresult += long(dw_sheettab.describe('tabnotselected_'  + string(li_row, '000') + '.X'))                     
//                     if ll_tabminusxpos > 0 THEN CONTINUE
//
//           next
//
//
//if ll_tabxpos + dw_sheettab.x < 0 then
//           //left position
//           dw_sheettab.x = - ll_tabxpos
//           
//elseif ( ll_tabxpos + dw_sheettab.x ) > this.width then
//           
//           long ll_thiswidth
//           ll_thiswidth = this.width   
//           dw_sheettab.x =  - ll_tabminusxpos + ( ll_thiswidth - ( ( ll_tabselectedwidth * 3 ) / 2 ) )
//
//end if

return 1

end function

public function long of_addtab (string as_menu_id, string as_pgm_id, string as_pgm_name, readonly window aw_sheet);long ll_tabseq

ll_tabseq = this.of_addtab(as_menu_id, as_pgm_id, as_pgm_name)
if ll_tabseq > 0 then
	iw_sheet[ll_tabseq] = aw_sheet
end if

return ll_tabseq

end function

public function integer of_closetab (long al_tabseq);long ll_shiftwidth
long ll_rownum
string ls_syntax

dw_sheettab.setredraw(false)
dw_sheettab.post setredraw(true)

ll_rownum = ids_tab.find("tab_seq=" + string(al_tabseq), 1, ids_tab.rowcount())
if ll_rownum <= 0 then return -1

//ll_shiftwidth = ids_tab.getitemnumber(ll_rownum, 'image_width')
ll_shiftwidth = long(dw_sheettab.describe("tabnotselected_" + string(al_tabseq, '000') + ".width"))

ls_syntax = "destroy tabnotselected_" + string(al_tabseq, '000')
ls_syntax += "~r~ndestroy tabselected_" + string(al_tabseq, '000')
ls_syntax += "~r~ndestroy tabtext_" + string(al_tabseq, '000')

integer i
long ll_imagexpos, ll_textxpos, ll_tabseq
string ls_errmsg

for i = ll_rownum + 1 to ids_tab.rowcount()
	ll_tabseq = ids_tab.getitemnumber(i, 'tab_seq')
	ll_imagexpos = long(dw_sheettab.describe("tabnotselected_" + string(ll_tabseq, '000') + ".x")) - ll_shiftwidth
	ll_textxpos = long(dw_sheettab.describe("tabtext_" + string(ll_tabseq, '000') + ".x")) - ll_shiftwidth
	
	ls_syntax += "~r~ntabnotselected_" + string(ll_tabseq, '000') + ".x = " + string(ll_imagexpos)
	ls_syntax += "~r~ntabselected_" + string(ll_tabseq, '000') + ".x = " + string(ll_imagexpos)
	ls_syntax += "~r~ntabtext_" + string(ll_tabseq, '000') + ".x = " + string(ll_textxpos)
	
	//ids_tab.setitem(i, 'image_xpos', ll_imagexpos)
next

ls_syntax += '~r~np_close.visible=0'

ls_errmsg = dw_sheettab.modify(ls_syntax)
if len(ls_errmsg) > 0 then
	::clipboard(ls_syntax)
	messagebox('of_closetab() error', ls_errmsg)
	return -1
end if

il_maxtabwidth -= ll_shiftwidth
ids_tab.deleterow(ll_rownum)
if ids_tab.rowcount() = 0 then
	il_selectedtabseq = 0
end if

//// DW 스크롤용 HScrollBar 컨트롤 Visible 처리
//if il_maxtabwidth <= this.width then
//	this.of_scrolltab(-TabStartXpos)
//	hsb_1.visible = false
//else
//	this.of_scrolltab(ll_shiftwidth)
//end if

if TabStartXpos + ll_shiftwidth > 0 then
	this.of_scrolltab(-TabStartXpos)
else
	this.of_scrolltab(ll_shiftwidth)
end if

if il_maxtabwidth <= dw_sheettab.width then
	hsb_1.visible = false
end if

return 1

end function

public function integer of_deselecttab (long al_tabseq);long ll_rownum
string ls_syntax, ls_errmsg

ll_rownum = ids_tab.find("tab_seq=" + string(al_tabseq), 1, ids_tab.rowcount())
if ll_rownum <= 0 then return -1

ls_syntax = 'tabnotselected_' + string(al_tabseq, '000') + '.visible=1'
ls_syntax += '~r~ntabselected_' + string(al_tabseq, '000') + '.visible=0'
//ls_syntax += '~r~ntabtext_' + string(al_tabseq, '000') + '.color=' + string(NormalTabTextColor)
ls_syntax += '~r~ntabtext_' + string(al_tabseq, '000') + '.Font.Weight=400'

if EnableTabClose = true then
	ls_syntax += '~r~np_close.visible=0'
end if

ls_errmsg = dw_sheettab.modify(ls_syntax)
if len(ls_errmsg) > 0 then
	::clipboard(ls_syntax)
	messagebox('of_deselect() error', ls_errmsg)
	return -1
end if

il_selectedtabseq = 0
return 1

end function

public function integer of_sheetsetfocus (string as_menu_id);long ll_find, ll_tabseq

ll_find = ids_tab.find("menu_id='" + as_menu_id + "'", 1, ids_tab.rowcount())
if ll_find <= 0 then return -1

ll_tabseq = ids_tab.getitemnumber(ll_find, 'tab_seq')
if not isvalid(iw_sheet[ll_tabseq]) then return -1

iw_sheet[ll_tabseq].post setfocus()
return 1

end function

public function boolean of_isopenedsheet (string as_menu_id);long ll_fnd

if isnull(as_menu_id) then return false
if len(trim(as_menu_id)) = 0 then return false

ll_fnd = ids_tab.find("menu_id='" + as_menu_id + "'", 1, ids_tab.rowcount())
if ll_fnd > 0 then
	return true
else
	return false
end if

end function

public function string of_getclassname ();return 'pf_u_mdi_sheettab'

end function

public function integer of_popup_addfavorite (string as_menu_id, string as_pgm_id, string as_pgm_name);pf_n_menudata lnv_menu

lnv_menu = create pf_n_menudata
lnv_menu.is_menu_id = as_menu_id
lnv_menu.is_pgm_id = as_pgm_id
lnv_menu.is_pgm_name = as_pgm_name

openwithparm(pf_w_favorite, lnv_menu)
if message.stringparm = 'OK' then
	pf_n_hashtable lnvo_param
	lnvo_param = create pf_n_hashtable
	iw_parent.dynamic of_eventdispatcher('pf_u_mdi_favorite', 'pfe_refreshmenu', lnvo_param)
end if

return 1

end function

public function integer of_popup_closewindow (string as_menu_id, string as_pgm_id, string as_pgm_name);if il_selectedtabseq > 0 then
	if isvalid(iw_sheet[il_selectedtabseq]) then
		post close(iw_sheet[il_selectedtabseq])
	end if
end if

return 1

end function

public function integer of_popup_programhelp (string as_menu_id, string as_pgm_id, string as_pgm_name);pf_n_menudata lnv_menu

lnv_menu = create pf_n_menudata
lnv_menu.is_menu_id = as_menu_id
lnv_menu.is_pgm_id = as_pgm_id
lnv_menu.is_pgm_name = as_pgm_name

openwithparm(pf_w_pgm_help_ent, lnv_menu)

return 1

end function

public function integer of_popup_closeall ();// 현재 오픈된 모든 쉬트 윈도우를 모두 종료합니다

integer li_sheetcnt, i

li_sheetcnt = upperbound(iw_sheet)
for i = 1 to li_sheetcnt
	if isvalid(iw_sheet[i]) then
		if iw_sheet[i].classname() = 'pf_w_home' then
		else
			post close(iw_sheet[i])
		end if
	end if
next

return 1

end function

public function integer of_scrolltab (long al_scrollwidth);if al_scrollwidth = 0 then return 0

string ls_objects[]
string ls_objtype
string ls_syntax
string ls_errmsg
long i, ll_objcnt, ll_x, ll_x2

ll_objcnt = pf_f_parsetoarray(dw_sheettab.describe("Datawindow.Objects"), "~t", ls_objects[])

for i = 1 to ll_objcnt
	ls_objtype = dw_sheettab.describe(ls_objects[i] + ".Type")
	choose case ls_objtype
		case 'line'
			ll_x = long(dw_sheettab.describe(ls_objects[i] + ".x1"))
			ll_x2 = long(dw_sheettab.describe(ls_objects[i] + ".x2"))
			ls_syntax += ls_objects[i] + '.x1=' + string(ll_x + al_scrollwidth) + '~r~n'
			ls_syntax += ls_objects[i] + '.x2=' + string(ll_x2 + al_scrollwidth) + '~r~n'
			
		case 'bitmap', 'text'
			ll_x = long(dw_sheettab.describe(ls_objects[i] + ".x"))
			ls_syntax += ls_objects[i] + '.x=' + string(ll_x + al_scrollwidth) + '~r~n'
	end choose
next

ls_errmsg = dw_sheettab.modify(ls_syntax)
if len(ls_errmsg) > 0 then
	messagebox(this.classname() + '.of_scrolltab()', ls_errmsg)
	return -1
end if

TabStartXpos += al_scrollwidth
return 0

end function

on pf_u_mdi_sheettab.create
int iCurrent
call super::create
this.hsb_1=create hsb_1
this.dw_sheettab=create dw_sheettab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.hsb_1
this.Control[iCurrent+2]=this.dw_sheettab
end on

on pf_u_mdi_sheettab.destroy
call super::destroy
destroy(this.hsb_1)
destroy(this.dw_sheettab)
end on

event destructor;if isvalid(ids_tab) then
	destroy ids_tab
end if

end event

event resize;dw_sheettab.width = newwidth
dw_sheettab.height = newheight
hsb_1.x = newwidth - hsb_1.width

//if il_maxtabwidth > newwidth then
//	hsb_1.visible = true
//else
//	dw_sheettab.x = 0
//	hsb_1.visible = false
//end if

end event

event pfe_postopen;call super::pfe_postopen;string ls_syntax

// 이미지 파일 경로 설정 및 확인
SelectedTabImageFile = pf_f_getimagepathappeon(SelectedTabImageFile)
NormalTabImageFile = pf_f_getimagepathappeon(NormalTabImageFile)

if not fileexists(NormalTabImageFile) then
	messagebox('알림', 'SheetTab 용 이미지 파일이 존재하지 않습니다~ r~n' + NormalTabImageFile)
end if

if not fileexists(SelectedTabImageFile) then
	messagebox('알림', 'SheetTab 용 이미지 파일이 존재하지 않습니다~ r~n' + SelectedTabImageFile)
end if

// 탭페이지 정보 보관용 데이터윈도우
ids_tab = create datastore
ids_tab.dataobject = 'pf_d_mdi_sheettab_data'

// 이미지 사이즈를 구해와 데이터윈도우 높이를 맞춘다
if fileexists(SelectedTabImageFile) and fileexists(NormalTabImageFile) then
	pf_s_size lstr_imagesize
	gnv_extfunc.pf_GetImageSize(NormalTabImageFile, lstr_imagesize)
	il_tabimageheight = lstr_imagesize.height
	
	dw_sheettab.height = pixelstounits(il_tabimageheight, ypixelstounits!)
	ls_syntax += "~r~nDataWindow.Header.Height='" + string(dw_sheettab.height) + "'"
end if

// 탭 Close 아이콘 높이 보관
il_closeiconwidth = long(dw_sheettab.describe("p_close.width"))
il_closeiconheight = long(dw_sheettab.describe("p_close.height"))

// 데이터윈도우 백그라운드 컬러
if TabControlBackColor = 0 then
	TabControlBackColor = iw_parent.dynamic of_getbackgroundcolor()
end if
ls_syntax += "~r~nDataWindow.Header.Color='" + string(TabControlBackColor) + "'"

// 언더라인 표시
if ShowUnderLine = true then
	long ll_ypos
	ll_ypos = dw_sheettab.height - pixelstounits(UnderLinePenWidth, ypixelstounits!)
	
	ls_syntax += "~r~nl_underline1.Visible='1'"
	ls_syntax += "~r~nl_underline1.Pen.Color='" + string(UnderLinePenColor) + "'"
	ls_syntax += "~r~nl_underline1.Pen.Width='" + string(UnderLinePenWidth) + "'"
	ls_syntax += "~r~nl_underline1.Y1='" + string(ll_ypos) + "'"
	ls_syntax += "~r~nl_underline1.Y2='" + string(ll_ypos + pixelstounits(UnderLinePenWidth, ypixelstounits!)) + "'"
end if

string ls_errmsg
ls_errmsg = dw_sheettab.modify(ls_syntax)
if len(ls_errmsg) > 0 then
	messagebox(this.classname() + '.constructor', ls_errmsg)
	return
end if

// 탭 시작위치
il_maxtabwidth = TabStartXpos

end event

type p_background from pf_u_userobject`p_background within pf_u_mdi_sheettab
end type

type hsb_1 from pf_u_hscrollbar within pf_u_mdi_sheettab
boolean visible = false
integer x = 2999
integer width = 165
integer height = 100
boolean bringtotop = true
boolean stdheight = false
integer minposition = 1
integer maxposition = 100
integer position = 1
boolean fixedtoright = true
end type

event lineright;call super::lineright;//long ll_maxxpos, ll_hscrollpos
//
//ll_maxxpos = il_maxtabwidth - parent.width + this.width
//ll_hscrollpos = long(dw_sheettab.describe("DataWindow.HorizontalScrollPosition"))
//
//if ll_hscrollpos - DW_HSCROLL_UNIT > ll_maxxpos then
//	ll_hscrollpos -= DW_HSCROLL_UNIT
//else
//	ll_hscrollpos = ll_maxxpos
//end if
//
//dw_sheettab.modify("DataWindow.HorizontalScrollPosition=" + string(ll_hscrollpos))

//long ll_max
//
//ll_max = (il_maxtabwidth - parent.width + this.width) * -1
//if dw_sheettab.x - 100 > ll_max then
//	dw_sheettab.x -= 100
//else
//	dw_sheettab.x = ll_max
//end if

// ScrollToRight
long ll_rightwidth

ll_rightwidth = TabStartXpos + il_maxtabwidth
if ll_rightwidth - DW_HSCROLL_UNIT > parent.width - this.width then
	parent.of_scrolltab(-DW_HSCROLL_UNIT)
else
	parent.of_scrolltab((ll_rightwidth - (parent.width - this.width)) * -1)
end if

end event

event lineleft;call super::lineleft;//long ll_hscrollpos
//
//ll_hscrollpos = long(dw_sheettab.describe("DataWindow.HorizontalScrollPosition"))
//
//if ll_hscrollpos + DW_HSCROLL_UNIT > 0 then
//	ll_hscrollpos = 0
//else
//	ll_hscrollpos += DW_HSCROLL_UNIT
//end if
//
//dw_sheettab.modify("DataWindow.HorizontalScrollPosition=" + string(ll_hscrollpos))

//if dw_sheettab.x + 100 > 0 then
//	dw_sheettab.x = 0
//else
//	dw_sheettab.x += 100
//end if

if TabStartXpos = 0 then return
if TabStartXpos + DW_HSCROLL_UNIT > 0 then
	parent.of_scrolltab(-TabStartXpos)
else
	parent.of_scrolltab(DW_HSCROLL_UNIT)
end if

end event

type dw_sheettab from datawindow within pf_u_mdi_sheettab
event ue_post_open ( )
integer width = 3163
integer height = 120
integer taborder = 10
string title = "none"
string dataobject = "pf_d_mdi_sheettab_disp"
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_dwoname
long ll_tabseq

setpointer(HourGlass!)
post setpointer(Arrow!)
if AppeonGetClientType() = 'WEB' then
	gnv_appmgr.iw_mainframe.setredraw(false)
	gnv_appmgr.iw_mainframe.post setredraw(true)
end if

ls_dwoname = string(dwo.name)

if ls_dwoname = 'p_close' then
	if il_selectedtabseq > 0 then
		if isvalid(iw_sheet[il_selectedtabseq]) then
			post close(iw_sheet[il_selectedtabseq])
		end if
	end if
else
	if pos(ls_dwoname, 'tabnotselected_') + pos(ls_dwoname, 'tabselected_') + pos(ls_dwoname, 'tabtext_') = 0 then return -1
	
	ll_tabseq = long(right(ls_dwoname, 3))
	if ll_tabseq = 0 then return -1
	if ll_tabseq = il_selectedtabseq then return 0
	
	if isvalid(iw_sheet[ll_tabseq]) then
		iw_sheet[ll_tabseq].setfocus()
	end if
end if

return 0

end event

event rbuttondown;long ll_tabseq
long ll_find
string ls_dwoname

ls_dwoname = string(dwo.name)
if pos(ls_dwoname, 'tabnotselected_') + pos(ls_dwoname, 'tabselected_') + pos(ls_dwoname, 'tabtext_') = 0 then return -1

ll_tabseq = long(right(ls_dwoname, 3))
if ll_tabseq = 0 then return -1
if ll_tabseq <> il_selectedtabseq then return 0

// 탭 메뉴
pf_m_sheettab lm_popup
string ls_menu_id, ls_pgm_id, ls_pgm_name

ll_find = ids_tab.find("tab_seq=" + string(ll_tabseq), 1, ids_tab.rowcount())
if ll_find <= 0 then return -1

if upper(ids_tab.getitemstring(ll_find, 'pgm_id')) = 'PF_W_HOME' then return 0
ls_menu_id = ids_tab.getitemstring(ll_find, 'menu_id')
ls_pgm_id = ids_tab.getitemstring(ll_find, 'pgm_id')
ls_pgm_name = ids_tab.getitemstring(ll_find, 'pgm_name')

lm_popup = create pf_m_sheettab
lm_popup.of_setparent(parent, ls_menu_id, ls_pgm_id, ls_pgm_name)
lm_popup.PopMenu(PointerX(iw_parent), PointerY(iw_parent))

return 0

end event

