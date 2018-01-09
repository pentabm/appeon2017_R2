$PBExportHeader$pf_u_tab.sru
$PBExportComments$Tab 컨트롤 디자인용 사용자 오브젝트 입니다. Tab 컨트롤은 상속받을 수 없기 때문에 파워빌더용 Tab을 사용하세요.
forward
global type pf_u_tab from pf_u_userobject
end type
type hsb_1 from pf_u_hscrollbar within pf_u_tab
end type
type dw_tab from datawindow within pf_u_tab
end type
end forward

global type pf_u_tab from pf_u_userobject
integer width = 3168
integer height = 108
event pfe_visiblechanged ( )
event pfe_enablechanged ( )
event pfe_moved ( )
event pfe_resized ( )
event pfe_selectedtabchanged ( )
event pfe_tabpagetextchanged ( )
event pfe_tabpageenablechanged ( )
event pfe_tabpagevisiblechanged ( )
event pfe_open ( )
hsb_1 hsb_1
dw_tab dw_tab
end type
global pf_u_tab pf_u_tab

type prototypes

end prototypes

type variables
private:
	tab it_referencedtab
	pf_n_propertywatcher inv_propmon
	
	string is_tabnotselectedimage, is_tabnotselectedimage_ext
	string is_tabselectedimage, is_tabselectedimage_ext
	string is_tabdisabledimage, is_tabdisabledimage_ext
	
	constant long LEFT_TEXT_MARGIN = 10	// pixel
	constant long RIGHT_TEXT_MARGIN = 10	// pixel
	constant long DW_HSCROLL_UNIT = 100 // pixel
	
	string TAB_IMG_SELECTED = "..\img\controls\u_tab\tab1_selected.jpg"
	string TAB_IMG_NOTSELECTED = "..\img\controls\u_tab\tab1_normal.jpg"
	string TAB_IMG_DISABLED = "..\img\controls\u_tab\tab1_disabled.jpg"

	long il_tabimageheight
	long il_tabtextheight
	long il_maxtabwidth
	long il_selectedtabindex
	long TabStartXpos = 0
	boolean ib_OnceOpened = false

public:
	boolean ApplyDesign = true
	string ReferencedTab
	
	long TabTextColorNormal = RGB(50,50,50)
	long TabTextColorSelected = RGB(100,0,0)
	long TabTextColorDisabled = RGB(120,120,120)

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_setpropertywatcher (string as_switch)
public function integer of_applydesign ()
public function integer of_initialize ()
public function integer of_deselecttab (long al_tabindex)
public function integer of_selecttab (long al_tabindex)
public function integer of_gettabpageindex (string as_tabpagename)
public function integer of_settabpagevisible (integer ai_tabindex, boolean ab_visible)
public function integer of_settabpageenabled (integer ai_tabindex, boolean ab_enabled)
public function integer of_arrangetabpage ()
public function integer of_settabpagetext (integer ai_tabindex, string as_text)
public function tab of_getreferencedtab ()
end prototypes

event pfe_visiblechanged();this.visible = it_referencedtab.visible

end event

event pfe_enablechanged();this.enabled = it_referencedtab.enabled

end event

event pfe_moved();this.x = it_referencedtab.x
this.y = it_referencedtab.y

end event

event pfe_resized();this.width = it_referencedtab.width
this.height = il_tabtextheight

end event

event pfe_selectedtabchanged();this.of_selecttab(it_referencedtab.selectedtab)

end event

event pfe_tabpagetextchanged();// 탭페이지 TEXT 속성 변경시 발생되는 이벤트
this.of_initialize()

end event

event pfe_tabpageenablechanged();// 탭페이지 활성화 변경
this.of_initialize()

end event

event pfe_tabpagevisiblechanged();// 탭페이지 Visible 속성 변경시 발생되는 이벤트
this.of_initialize()

end event

event pfe_open();// Initializing
this.of_initialize()

// SetPosition
this.SetPosition(Behind!, it_referencedtab)
it_referencedtab.SetPosition(Behind!, this)

// set visible, enabled
this.visible = it_referencedtab.visible
this.enabled = it_referencedtab.enabled

// properties monitor
this.of_setpropertywatcher('true')
inv_propmon.of_registerparent(it_referencedtab, this)
inv_propmon.of_register('visible', 'pfe_visiblechanged')
inv_propmon.of_register('enabled', 'pfe_enablechanged')
inv_propmon.of_register('moved', 'pfe_moved')
inv_propmon.of_register('resized', 'pfe_resized')
inv_propmon.of_register('selectedtab', 'pfe_selectedtabchanged')

// 아래 모니터링 항목들은 탭페이지 변경사항에 대한 설정입니다.
// 속도 이슈가 발생되는 경우 아래 항목들을 주석처리하고 
// of_setTabpageText(), of_setTabpageEnabled(), of_setTabpageVisible()
// 함수를 직접 호출해서 사용하시기 바랍니다.
inv_propmon.of_register('tabtext', 'pfe_tabpagetextchanged')
inv_propmon.of_register('tabenabled', 'pfe_tabpageenablechanged')
inv_propmon.of_register('tabvisible', 'pfe_tabpagevisiblechanged')

return

end event

public function string of_getclassname ();return 'pf_u_tab'

end function

public function integer of_setpropertywatcher (string as_switch);choose case lower(as_switch)
	case 'true'
		if not isvalid(inv_propmon) then
			inv_propmon = create pf_n_propertywatcher
			inv_propmon.of_registerparent(this)
			inv_propmon.of_start(0.3)
		end if
	case 'false'
		if isvalid(inv_propmon) then
			inv_propmon.of_stop()
			destroy inv_propmon
		end if
	case 'start'
		if isvalid(inv_propmon) then
			inv_propmon.of_start(0.3)
		end if
	case 'stop'
		if isvalid(inv_propmon) then
			inv_propmon.of_stop()
		end if
end choose

return 1

end function

public function integer of_applydesign ();// TAB 디자인 처리
pf_s_size lstr_textsize
integer li_tabpagecnt, i
string ls_syntax, ls_errmsg, ls_visible
string ls_tabnotselectedimage, ls_tabselectedimage, ls_tabdisabledimage
string ls_tabpagenm, ls_tabtext
long ll_tabbackcolor, ll_tabtextcolor
long ll_resizewidth, ll_resizeheight
long ll_textwidth, ll_textheight
long ll_imagewidth, ll_imageheight
long ll_textxpos, ll_textypos

// 참조탭 없으면 리턴
if not isvalid(it_referencedtab) then return -1

dw_tab.setredraw(false)
dw_tab.post setredraw(true)

il_selectedtabindex = it_referencedtab.selectedtab
li_tabpagecnt = upperbound(it_referencedtab.control)
for i = 1 to li_tabpagecnt
	// 텍스트 사이즈 구하기
	ls_tabtext = it_referencedtab.control[i].text
	gnv_extfunc.pf_GetTextSizeW(handle(this), ls_tabtext, "맑은 고딕", 9, 700, lstr_textsize)
	
	ll_tabbackcolor = it_referencedtab.control[i].tabbackcolor
	ll_tabtextcolor = it_referencedtab.control[i].tabtextcolor
	
	// 탭 이미지/텍스트 생성
	ls_tabpagenm = it_referencedtab.control[i].classname()
	
	ls_tabnotselectedimage = pf_f_replaceall(is_tabnotselectedimage, "." + is_tabnotselectedimage_ext, "_" + ls_tabpagenm + "." + is_tabnotselectedimage_ext)
	ls_tabselectedimage = pf_f_replaceall(is_tabselectedimage, "." + is_tabselectedimage_ext, "_" + ls_tabpagenm + "." + is_tabselectedimage_ext)
	ls_tabdisabledimage = pf_f_replaceall(is_tabdisabledimage, "." + is_tabdisabledimage_ext, "_" + ls_tabpagenm + "." + is_tabdisabledimage_ext)
	
	ll_resizewidth = LEFT_TEXT_MARGIN + lstr_textsize.width + RIGHT_TEXT_MARGIN
	ll_resizeheight = il_tabimageheight
	
	gnv_extfunc.pf_resizeimage4pb(TAB_IMG_NOTSELECTED, ls_tabnotselectedimage, 0, 0, ll_resizewidth, ll_resizeheight)
	gnv_extfunc.pf_resizeimage4pb(TAB_IMG_SELECTED, ls_tabselectedimage, 0, 0, ll_resizewidth, ll_resizeheight)
	gnv_extfunc.pf_resizeimage4pb(TAB_IMG_DISABLED, ls_tabdisabledimage, 0, 0, ll_resizewidth, ll_resizeheight)
	
	ll_textwidth = pixelstounits(lstr_textsize.width, xpixelstounits!)
	ll_textheight = pixelstounits(lstr_textsize.height, ypixelstounits!)

	ll_imagewidth = pixelstounits(ll_resizewidth, xpixelstounits!)
	ll_imageheight = pixelstounits(il_tabimageheight, ypixelstounits!)

	ll_textxpos = il_MaxTabWidth + pixelstounits(LEFT_TEXT_MARGIN, xpixelstounits!)
	ll_textypos = (dw_tab.height - ll_textheight) / 2
	
	if it_referencedtab.control[i].visible = true then
		ls_visible = '1'
	else
		ls_visible = '0'
	end if
	
	if it_referencedtab.control[i].enabled = true then
		if it_referencedtab.selectedtab = i then
			ls_syntax += '~r~ncreate bitmap(band=header pointer="HyperLink!" filename="' + ls_tabselectedimage + '" x="' + string(il_MaxTabWidth) + '" y="' + '0' + '" height="' + string(dw_tab.height) + '" width="' + string(ll_imagewidth) + '" border="0"  name=tabbgimg_' + ls_tabpagenm + ' visible="' + ls_visible + '" )'
			ls_syntax	 += '~r~ncreate text(band=header alignment="2" pointer="HyperLink!" text="' +  ls_tabtext + '" border="0" color="' + string(TabTextColorSelected) + '" x="' + string(ll_textxpos) + '" y="' + string(ll_textypos) + '" height="' + string(ll_textheight) + '" width="' + String(ll_textwidth) + '" html.valueishtml="0"  name=tabtext_' + ls_tabpagenm + ' tag="" visible="' + ls_visible + '"  font.face="' + "맑은 고딕" + '" font.height="-' + string(9) + '" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
		else
			ls_syntax += '~r~ncreate bitmap(band=header pointer="HyperLink!" filename="' + ls_tabnotselectedimage + '" x="' + string(il_MaxTabWidth) + '" y="' + '0' + '" height="' + string(dw_tab.height) + '" width="' + string(ll_imagewidth) + '" border="0"  name=tabbgimg_' + ls_tabpagenm + ' visible="' + ls_visible + '" )'
			ls_syntax	 += '~r~ncreate text(band=header alignment="2" pointer="HyperLink!" text="' +  ls_tabtext + '" border="0" color="' + string(TabTextColorNormal) + '" x="' + string(ll_textxpos) + '" y="' + string(ll_textypos) + '" height="' + string(ll_textheight) + '" width="' + String(ll_textwidth) + '" html.valueishtml="0"  name=tabtext_' + ls_tabpagenm + ' tag="" visible="' + ls_visible + '"  font.face="' + "맑은 고딕" + '" font.height="-' + string(9) + '" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
		end if
	else
		ls_syntax += '~r~ncreate bitmap(band=header pointer="HyperLink!" filename="' + ls_tabdisabledimage + '" x="' + string(il_MaxTabWidth) + '" y="' + '0' + '" height="' + string(dw_tab.height) + '" width="' + string(ll_imagewidth) + '" border="0"  name=tabbgimg_' + ls_tabpagenm + ' visible="' + ls_visible + '" )'
		ls_syntax	 += '~r~ncreate text(band=header alignment="2" pointer="HyperLink!" text="' +  ls_tabtext + '" border="0" color="' + string(TabTextColorDisabled) + '" x="' + string(ll_textxpos) + '" y="' + string(ll_textypos) + '" height="' + string(ll_textheight) + '" width="' + String(ll_textwidth) + '" html.valueishtml="0"  name=tabtext_' + ls_tabpagenm + ' tag="" visible="' + ls_visible + '"  font.face="' + "맑은 고딕" + '" font.height="-' + string(9) + '" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127" )'
	end if
	
	il_maxtabwidth += ll_imagewidth
next

// MODIFY 수행
if len(ls_syntax) > 0 then
	ls_errmsg = dw_tab.modify(ls_syntax)
	if len(ls_errmsg) > 0 then
		messagebox('pf_u_tab.of_applydesign() error', ls_errmsg)
		return -1
	end if
end if

// 탭페이지 정렬
this.of_arrangetabpage()

return 1

end function

public function integer of_initialize ();// 탭 컨트롤 초기화 작업

// Reset Dataobject
dw_tab.dataobject = dw_tab.dataobject

// 참조탭 구하기
if ReferencedTab = '' then
	messagebox('알림', '참조할 탭 명칭을 입력하세요')
	return -1
end if

it_referencedtab = of_GetReferencedTab()
if not isvalid(it_referencedtab) then
	messagebox('알림', '참조할 탭 명칭을 찾을 수 없습니다')
	return -1
end if

// TAB 이미지 파일명
if AppeonGetClientType() = "WEB" then
	TAB_IMG_SELECTED = pf_f_getimagepathappeon(TAB_IMG_SELECTED)
	TAB_IMG_NOTSELECTED = pf_f_getimagepathappeon(TAB_IMG_NOTSELECTED)
	TAB_IMG_DISABLED = pf_f_getimagepathappeon(TAB_IMG_DISABLED)
end if

// 탭이미지 없으면 DO NOTHING
if	fileexists(TAB_IMG_SELECTED) = false or &
	fileexists(TAB_IMG_NOTSELECTED) = false or &
	fileexists(TAB_IMG_DISABLED) = false then return -1

// 데이터윈도우 백그라운드 컬러 설정
choose case parent.typeof()
	case window!
		window lw_parent
		lw_parent = parent
		dw_tab.modify("DataWindow.Header.Color=" + string(lw_parent.backcolor))
	case userobject!
		userobject luo_parent
		luo_parent = parent
		dw_tab.modify("DataWindow.Header.Color=" + string(luo_parent.backcolor))
		gnv_extfunc.setparent(handle(this), handle(parent))
end choose

// 탭 시작위치
il_maxtabwidth = TabStartXpos

// 탭 이미지 사이즈를 구해와 높이를 맞춘다
pf_s_size lstr_imagesize
gnv_extfunc.pf_GetImageSize(TAB_IMG_NOTSELECTED, lstr_imagesize)
il_tabimageheight = lstr_imagesize.height
il_tabtextheight = it_referencedtab.height - it_referencedtab.control[1].height - pixelstounits(5, ypixelstounits!)

this.x = it_referencedtab.x
this.y = it_referencedtab.y
this.width = it_referencedtab.width
this.height = il_tabtextheight

choose case il_tabtextheight - pixelstounits(il_tabimageheight, ypixelstounits!)
	case is > 0
		dw_tab.y = il_tabtextheight - pixelstounits(il_tabimageheight, ypixelstounits!)
		dw_tab.height = pixelstounits(il_tabimageheight, ypixelstounits!)
	case 0
		dw_tab.y = 0
		dw_tab.height = pixelstounits(il_tabimageheight, ypixelstounits!)
	case is < 0
		dw_tab.y = 0
		dw_tab.height = il_tabtextheight
end choose

dw_tab.modify("DataWindow.Header.Height=" + string(dw_tab.height))
dw_tab.modify("l_underline.y1=" + string(dw_tab.height - pixelstounits(1, ypixelstounits!)))
dw_tab.modify("l_underline.y2=" + string(dw_tab.height - pixelstounits(1, ypixelstounits!)))

// 실제 사용될 탭 이미지명
string ls_temppath

ls_temppath = gnv_extfunc.of_getpowerframetemppath()
is_tabnotselectedimage = ls_temppath
is_tabnotselectedimage += iw_parent.classname() + "_" + it_referencedtab.classname() + "_"
is_tabnotselectedimage += gnv_extfunc.of_pathstrippath(TAB_IMG_NOTSELECTED)
is_tabnotselectedimage_ext = gnv_extfunc.of_pathgetfileext(is_tabnotselectedimage)

is_tabselectedimage = ls_temppath
is_tabselectedimage += iw_parent.classname() + "_" + it_referencedtab.classname() + "_"
is_tabselectedimage += gnv_extfunc.of_pathstrippath(TAB_IMG_SELECTED)
is_tabselectedimage_ext = gnv_extfunc.of_pathgetfileext(is_tabselectedimage)

is_tabdisabledimage = gnv_extfunc.of_getpowerframetemppath()
is_tabdisabledimage += iw_parent.classname() + "_" + it_referencedtab.classname() + "_"
is_tabdisabledimage += gnv_extfunc.of_pathstrippath(TAB_IMG_DISABLED)
is_tabdisabledimage_ext = gnv_extfunc.of_pathgetfileext(is_tabdisabledimage)

// 탭 디자인
this.of_applydesign()

// Tab Position 초기화
dw_tab.x = 0

return 1

end function

public function integer of_deselecttab (long al_tabindex);// 해당 탭을 Deselect 처리 합니다

string ls_syntax, ls_errmsg
string ls_tabpagenm, ls_imagefile

if not isvalid(it_referencedtab) then return -1
if al_tabindex < 1 or al_tabindex > upperbound(it_referencedtab.control) then return -1
if it_referencedtab.control[al_tabindex].enabled = false then return 0

ls_tabpagenm = it_referencedtab.control[al_tabindex].classname()
ls_imagefile = pf_f_replaceall(is_tabnotselectedimage, "." + is_tabnotselectedimage_ext, "_" + ls_tabpagenm + "." + is_tabnotselectedimage_ext)

ls_syntax = 'tabbgimg_' + ls_tabpagenm + '.Filename="' + ls_imagefile + '"'
ls_syntax += '~r~ntabtext_' + ls_tabpagenm + '.Color=' + string(TabTextColorNormal)
ls_syntax += '~r~ntabtext_' + ls_tabpagenm + '.Font.Weight=400'

ls_errmsg = dw_tab.modify(ls_syntax)
if len(ls_errmsg) > 0 then
	::clipboard(ls_syntax)
	messagebox('pf_u_tab.of_deselecttab() error', ls_errmsg)
	return -1
end if

return 1

end function

public function integer of_selecttab (long al_tabindex);// 해당 탭을 Select 처리 합니다

string ls_syntax, ls_errmsg
string ls_tabpagenm, ls_imagefile

if not isvalid(it_referencedtab) then return -1
if al_tabindex < 1 or al_tabindex > upperbound(it_referencedtab.control) then return -1
if il_selectedtabindex = al_tabindex then return 0
if it_referencedtab.control[al_tabindex].enabled = false then return 0

if al_tabindex <> it_referencedtab.selectedtab then
	if it_referencedtab.selecttab(al_tabindex) = -1 then return -1
end if

if il_selectedtabindex > 0 then
	this.of_deselecttab(il_selectedtabindex)
end if

ls_tabpagenm = it_referencedtab.control[al_tabindex].classname()
ls_imagefile = pf_f_replaceall(is_tabselectedimage, "." + is_tabselectedimage_ext, "_" + ls_tabpagenm + "." + is_tabselectedimage_ext)

ls_syntax = 'tabbgimg_' + ls_tabpagenm + '.Filename="' + ls_imagefile + '"'
ls_syntax += '~r~ntabtext_' + ls_tabpagenm + '.Color=' + string(TabTextColorSelected)
ls_syntax += '~r~ntabtext_' + ls_tabpagenm + '.Font.Weight=700'

ls_errmsg = dw_tab.modify(ls_syntax)
if len(ls_errmsg) > 0 then
	::clipboard(ls_syntax)
	messagebox('pf_u_tab.of_selecttab() error', ls_errmsg)
	return -1
end if

il_selectedtabindex = al_tabindex
return 1

end function

public function integer of_gettabpageindex (string as_tabpagename);// 탭페이지 명칭으로 탭 Index 찾기

integer i, li_tabpagecnt

if not isvalid(it_referencedtab) then return -1

li_tabpagecnt = upperbound(it_referencedtab.control)
for i = 1 to li_tabpagecnt
	if it_referencedtab.control[i].classname() = as_tabpagename then
		return i
	end if
next

return 0

end function

public function integer of_settabpagevisible (integer ai_tabindex, boolean ab_visible);// 해당 탭페이지를 Visible/Invisible 처리 합니다.

string ls_syntax, ls_errmsg
string ls_tabpagename, ls_imagefile
long ll_tabwidth, ll_xpos, i

if not isvalid(it_referencedtab) then return -1
if ai_tabindex < 1 or ai_tabindex > upperbound(it_referencedtab.control) then return -1
if it_referencedtab.control[ai_tabindex].visible = ab_visible then return 0

it_referencedtab.control[ai_tabindex].visible = ab_visible
ls_tabpagename = it_referencedtab.control[ai_tabindex].classname()
ll_tabwidth = long(dw_tab.describe("tabbgimg_" + ls_tabpagename + ".width"))

if ab_visible = false then
	ls_syntax = "tabbgimg_" + ls_tabpagename + ".visible='0'"
	ls_syntax += "~r~ntabtext_" + ls_tabpagename + ".visible='0'"
	ll_tabwidth *= -1
else
	ls_syntax = "tabbgimg_" + ls_tabpagename + ".visible='1'"
	ls_syntax += "~r~ntabtext_" + ls_tabpagename + ".visible='1'"
end if

for i = ai_tabindex + 1 to upperbound(it_referencedtab.control)
	ll_xpos = long(dw_tab.describe("tabbgimg_" + it_referencedtab.control[i].classname() + ".x"))
	ls_syntax += "~r~ntabbgimg_" + it_referencedtab.control[i].classname() + ".x=" + string(ll_xpos + ll_tabwidth)

	ll_xpos = long(dw_tab.describe("tabtext_" + it_referencedtab.control[i].classname() + ".x"))
	ls_syntax += "~r~ntabtext_" + it_referencedtab.control[i].classname() + ".x=" + string(ll_xpos + ll_tabwidth)
next

ls_errmsg = dw_tab.modify(ls_syntax)
if len(ls_errmsg) > 0 then
	::clipboard(ls_syntax)
	messagebox('pf_u_tab.of_settabpagevisible() error', ls_errmsg)
	return -1
end if

this.of_arrangetabpage()
return 1

end function

public function integer of_settabpageenabled (integer ai_tabindex, boolean ab_enabled);// 해당 탭페이지를 Enable/Disable 처리 합니다.

string ls_syntax, ls_errmsg
string ls_tabpagename, ls_imagefile

if not isvalid(it_referencedtab) then return -1
if ai_tabindex < 1 or ai_tabindex > upperbound(it_referencedtab.control) then return -1
if it_referencedtab.control[ai_tabindex].enabled = ab_enabled then return 0

it_referencedtab.control[ai_tabindex].enabled = ab_enabled
ls_tabpagename = it_referencedtab.control[ai_tabindex].classname()
if ab_enabled = false then
	ls_imagefile = pf_f_replaceall(is_tabdisabledimage, "." + is_tabdisabledimage_ext, "_" + ls_tabpagename + "." + is_tabdisabledimage_ext)
else
	ls_imagefile = pf_f_replaceall(is_tabnotselectedimage, "." + is_tabnotselectedimage_ext, "_" + ls_tabpagename + "." + is_tabnotselectedimage_ext)
end if

ls_syntax = 'tabbgimg_' + ls_tabpagename + '.Filename=~'' + ls_imagefile + '~''
if ab_enabled = false then
	ls_syntax += '~r~ntabtext_' + ls_tabpagename + '.Color=' + string(TabTextColorDisabled)
else
	ls_syntax += '~r~ntabtext_' + ls_tabpagename + '.Color=' + string(TabTextColorNormal)
end if
ls_syntax += '~r~ntabtext_' + ls_tabpagename + '.Font.Weight=400'

ls_errmsg = dw_tab.modify(ls_syntax)
if len(ls_errmsg) > 0 then
	::clipboard(ls_syntax)
	messagebox('pf_u_tab.of_settabpageenabled() error', ls_errmsg)
	return -1
end if

return 1

end function

public function integer of_arrangetabpage ();// 탭페이지 위치를 재정렬 합니다

integer i, li_tabpagecnt
long ll_xpos = 1, ll_width
pf_n_syntaxbuffer lnv_syntax
string ls_errmsg

if not isvalid(it_referencedtab) then return -1
lnv_syntax = create pf_n_syntaxbuffer

li_tabpagecnt = upperbound(it_referencedtab.control)
for i = 1 to li_tabpagecnt
	if it_referencedtab.control[i].visible = false then continue
	ll_width = long(dw_tab.describe("tabbgimg_" + it_referencedtab.control[i].classname() + ".width"))
	lnv_syntax.of_append("tabbgimg_" + it_referencedtab.control[i].classname() + ".x=" + string(ll_xpos))
	lnv_syntax.of_append("tabtext_" + it_referencedtab.control[i].classname() + ".x=" + string(ll_xpos + pixelstounits(LEFT_TEXT_MARGIN, xpixelstounits!)))
	ll_xpos += ll_width
next

// Modify dw syntax
ls_errmsg = dw_tab.modify(lnv_syntax.of_tostring())
if len(ls_errmsg) > 0 then
	::clipboard(lnv_syntax.of_tostring())
	messagebox('pf_u_tab.of_arrangetabpage() error', ls_errmsg)
	return -1
end if

// DW 스크롤용 HScrollBar 컨트롤 Visible 처리
il_maxtabwidth = ll_xpos
if il_maxtabwidth > this.width then
	dw_tab.x = (il_maxtabwidth - this.width + hsb_1.width) * -1
	hsb_1.visible = true
end if

return 1

end function

public function integer of_settabpagetext (integer ai_tabindex, string as_text);// 해당 탭페이지의 Text를 변경 합니다.

// 참조탭 없으면 리턴
if not isvalid(it_referencedtab) then return -1
if ai_tabindex < 1 or ai_tabindex > upperbound(it_referencedtab.control) then return -1
if isnull(as_text) then return -1

pf_s_size lstr_textsize
string ls_tabpagename, ls_syntax, ls_errmsg
string ls_tabnotselectedimage, ls_tabselectedimage, ls_tabdisabledimage
long ll_resizeheight, ll_resizewidth
long ll_resizeright

// 참조 탭페이지 텍스트 변경
it_referencedtab.control[ai_tabindex].text = as_text

// 텍스트 사이즈 구하기
gnv_extfunc.pf_GetTextSizeW(handle(this), as_text, "맑은 고딕", 9, 700, lstr_textsize)

// 탭 이미지/텍스트 리사이즈
ls_tabpagename = it_referencedtab.control[ai_tabindex].classname()

ls_tabnotselectedimage = pf_f_replaceall(is_tabnotselectedimage, "." + is_tabnotselectedimage_ext, "_" + ls_tabpagename + "." + is_tabnotselectedimage_ext)
ls_tabselectedimage = pf_f_replaceall(is_tabselectedimage, "." + is_tabselectedimage_ext, "_" + ls_tabpagename + "." + is_tabselectedimage_ext)
ls_tabdisabledimage = pf_f_replaceall(is_tabdisabledimage, "." + is_tabdisabledimage_ext, "_" + ls_tabpagename + "." + is_tabdisabledimage_ext)

ll_resizewidth = LEFT_TEXT_MARGIN + lstr_textsize.width + RIGHT_TEXT_MARGIN
ll_resizeheight = il_tabimageheight
	
gnv_extfunc.pf_resizeimage4pb(TAB_IMG_NOTSELECTED, ls_tabnotselectedimage, 0, 0, ll_resizewidth, ll_resizeheight)
gnv_extfunc.pf_resizeimage4pb(TAB_IMG_SELECTED, ls_tabselectedimage, 0, 0, ll_resizewidth, ll_resizeheight)
gnv_extfunc.pf_resizeimage4pb(TAB_IMG_DISABLED, ls_tabdisabledimage, 0, 0, ll_resizewidth, ll_resizeheight)

ls_syntax = 'tabbgimg_' + ls_tabpagename + '.width=' + string(pixelstounits(ll_resizewidth, xpixelstounits!))
ls_syntax += '~r~ntabtext_' + ls_tabpagename + '.text=~'' + as_text + '~''
ls_syntax += '~r~ntabtext_' + ls_tabpagename + '.width=' + string(pixelstounits(lstr_textsize.width, xpixelstounits!))

ls_errmsg = dw_tab.modify(ls_syntax)
if len(ls_errmsg) > 0 then
	::clipboard(ls_syntax)
	messagebox('pf_u_tab.of_settabpagetext() error', ls_errmsg)
	return -1
end if

this.of_arrangetabpage()
return 1

end function

public function tab of_getreferencedtab ();// 윈도우 오브젝트에서 참조되는 탭의 레퍼런스를 리턴합니다
// 탭안에 탭이 존재하는 경우있음, Refrence 참조 방식 변경(2016.12.12)
// 리턴값: 참조 탭 레퍼런스

tab lt_referencedtab
integer li_ctrlcnt, i

if isvalid(it_referencedtab) then return it_referencedtab

setnull(lt_referencedtab)
windowobject lwo_obj

lwo_obj = iw_parent.dynamic of_getwindowobjectbyname(ReferencedTab)
if isnull(lwo_obj) or not isvalid(lwo_obj) then
	li_ctrlcnt = upperbound(iw_parent.control)
	for i = 1 to li_ctrlcnt
		if iw_parent.control[i].typeof() = tab! then
			if iw_parent.control[i].classname() = ReferencedTab then
				lwo_obj = iw_parent.control[i]
				exit
			end if
		end if
	next
	
	if isnull(lwo_obj) or not isvalid(lwo_obj) then
		messagebox('알림', '[' + ReferencedTab + '] 탭 컨트롤을 찾을 수 없습니다.~r~n명칭을 다시 한 번 확인하세요')
		return lt_referencedtab
	end if
end if

if lwo_obj.typeof() <> tab! then
	messagebox('알림', '[' + ReferencedTab + '] 는 탭 컨트롤이 아닙니다.~r~n명칭을 다시 한 번 확인하세요')
	return lt_referencedtab
end if

lt_referencedtab = lwo_obj
return lt_referencedtab

end function

on pf_u_tab.create
int iCurrent
call super::create
this.hsb_1=create hsb_1
this.dw_tab=create dw_tab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.hsb_1
this.Control[iCurrent+2]=this.dw_tab
end on

on pf_u_tab.destroy
call super::destroy
destroy(this.hsb_1)
destroy(this.dw_tab)
end on

event constructor;call super::constructor;if appeongetclienttype() <> 'PB' then
	if ib_OnceOpened = true then return
end if

// Visible 속성 제거
This.Visible = False

// Get Parent Window
iw_parent = pf_f_getparentwindow(this)

if ApplyDesign = true then
	this.post event pfe_open()
end if

if appeongetclienttype() <> 'PB' then
	ib_OnceOpened = true
end if

end event

event destructor;this.of_setpropertywatcher('false')

end event

event resize;call super::resize;dw_tab.height = newheight
hsb_1.x = newwidth - hsb_1.width

// adjust UnderLine width
dw_tab.modify("l_underline.x2=" + string(newwidth - pixelstounits(3, xpixelstounits!)))

if il_maxtabwidth > newwidth then
	hsb_1.visible = true
else
	dw_tab.x = 0
	hsb_1.visible = false
end if

end event

type p_background from pf_u_userobject`p_background within pf_u_tab
end type

type hsb_1 from pf_u_hscrollbar within pf_u_tab
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

event lineleft;call super::lineleft;if dw_tab.x + 100 > 0 then
	dw_tab.x = 0
else
	dw_tab.x += 100
end if

end event

event lineright;call super::lineright;long ll_max

ll_max = (il_maxtabwidth - parent.width + this.width) * -1
if dw_tab.x - 100 > ll_max then
	dw_tab.x -= 100
else
	dw_tab.x = ll_max
end if

end event

type dw_tab from datawindow within pf_u_tab
event ue_post_open ( )
integer width = 29938
integer height = 120
integer taborder = 10
string title = "none"
string dataobject = "pf_d_tab_disp"
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_dwoname, ls_tabpagename
integer li_tabpageindex

if not isvalid(it_referencedtab) then return 0

ls_dwoname = string(dwo.name)

if left(ls_dwoname, 9) = 'tabbgimg_' then
	ls_tabpagename = mid(ls_dwoname, 10)
elseif left(ls_dwoname, 8) = 'tabtext_' then
	ls_tabpagename = mid(ls_dwoname, 9)
else
	return 0
end if

li_tabpageindex = parent.of_gettabpageindex(ls_tabpagename)
if li_tabpageindex > 0 then
	if it_referencedtab.control[li_tabpageindex].enabled = true then
		parent.of_selecttab(li_tabpageindex)
	end if
end if

return 0

end event

