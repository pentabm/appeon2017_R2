$PBExportHeader$pf_u_mdi_iconmenu.sru
$PBExportComments$MDI화면 위에 사용자의 권한에 따라 메뉴를 표시해 주는 사용자 오브젝트 입니다.
forward
global type pf_u_mdi_iconmenu from pf_u_datawindow
end type
end forward

global type pf_u_mdi_iconmenu from pf_u_datawindow
integer width = 2112
integer height = 244
string dataobject = "pf_d_mdi_iconmenu"
boolean border = false
boolean applydesign = false
boolean singlerowselection = false
boolean sorting = false
boolean useborder = false
boolean confirmupdateonrowchange = false
event ue_menuclicked ( string as_menu_id,  string as_pgm_id,  string as_pgm_nm )
end type
global pf_u_mdi_iconmenu pf_u_mdi_iconmenu

type prototypes
function boolean ReleaseCapture() library "user32.dll"
function long SetCapture(long hWnd) library "user32.dll"
function boolean GetCursorPos(ref pf_s_point mousepos) LIBRARY "User32.dll"

function Boolean TrackMouseEvent(Ref pf_s_TRACKMOUSEEVENT lpTrackMouseEvent) Library 'user32.dll' alias for "TrackMouseEvent;Ansi" 

end prototypes

type variables
constant string MOUSEOVER_SURFIX = "_hover"
constant string CLICKED_SURFIX =  "_clicked"
constant string DISABLED_SURFIX = "_disabled"

constant long MOUSEOVER_COLOR = rgb(11,20,115)
constant long CLICKED_COLOR = 0
constant long DISABLED_COLOR = 0
constant long NORMAL_COLOR = rgb(119,119,119)

private:
	pf_n_rolemenu inv_rolemenu
	//datastore ids_menudata

	long il_prev_seq
	long MENU_GAP = pixelstounits(80, xpixelstounits!)
	long il_max_width

end variables

forward prototypes
public function string of_getclassname ()
public function long of_drawtopmenu ()
public subroutine of_highlightmenu (integer ai_menu_seq, boolean ab_highlight)
public function long of_getmaxdwowidth ()
public function integer of_getscrollunit ()
end prototypes

public function string of_getclassname ();return 'pf_u_mdi_iconmenu'

end function

public function long of_drawtopmenu ();string	ls_error
string ls_menu_id, ls_pgm_id, ls_pgm_name, ls_pgm_icon
pf_n_syntaxbuffer lnv_buffer
long ll_xpos, ll_rowcnt, ll_textwidth, ll_intergap, ll_menugap
integer i
pf_s_size lstr_textsize

ll_rowcnt = inv_rolemenu.of_getmenudata('parent', '00000')

lnv_buffer = create pf_n_syntaxbuffer
ll_xpos = pixelstounits(4, xpixelstounits!)
ll_intergap = pixelstounits(8, xpixelstounits!)
ll_menugap = pixelstounits(42, xpixelstounits!)

for i = 1 to ll_rowcnt
	ls_menu_id = inv_rolemenu.ids_menudata.getitemstring(i, 'menu_id')
	ls_pgm_id = inv_rolemenu.ids_menudata.getitemstring(i, 'pgm_id')
	ls_pgm_name = inv_rolemenu.ids_menudata.getitemstring(i, 'pgm_name')
	ls_pgm_icon = inv_rolemenu.ids_menudata.getitemstring(i, 'pgm_icon')
	
	// 텍스트 사이즈 구하기
	gnv_extfunc.pf_gettextsizeW(handle(this), ls_pgm_name, "맑은 고딕", 10, 700, lstr_textsize)
	ll_textwidth = pixelstounits(lstr_textsize.width, xpixelstounits!) + ll_intergap
	
	//아이콘명이 없을수도있다. By KYJ 2013.08.28
	if isnull(ls_pgm_icon) or len(ls_pgm_icon) = 0 then continue
	
	// ASA Database 사용 시 '\' 값을 제대로 못 가져옴
	// 따라서 Database 에 경로를 '/'로 구분해서 입력하고 가져와서 '\'로 Replace 한다
	ls_pgm_icon = pf_f_replaceall(ls_pgm_icon, '/', '\')
	
	lnv_buffer.of_append('create bitmap(band=header filename="' + ls_pgm_icon + '" x="' + string(ll_xpos) + '" y="36" height="68" width="82" border="0"  name=p_menu_' + string(i, '00') +  ' tag="' + ls_menu_id + '" pointer="HyperLink!" visible="1" )')
	ll_xpos += 82
	lnv_buffer.of_append('create text(band=header alignment="2" text="' + ls_pgm_name + '" border="0" color="7829367" x="' + string(ll_xpos) + '" y="36" height="76" width="' + string(ll_textwidth) + '"  html.valueishtml="0"  name=t_menu_' + string(i, '00') + ' tag="' + ls_menu_id + '" pointer="HyperLink!" visible="1"  font.face="맑은 고딕" font.height="-10" font.weight="700"  font.family="1" font.pitch="2" font.charset="1" background.mode="2" background.color="553648127" )')
	ll_xpos += ll_textwidth + ll_menugap
	lnv_buffer.of_append('create bitmap(band=header filename="..\img\mainframe\u_mdi_iconmenu\topmenu_dist.jpg"' + ' x="' + string(ll_xpos) + '" y="8" height="128" width="23" border="0"  name=p_menudist_' + string(i, '00') +  ' tag="" visible="1" )')
	
	ll_xpos += ll_menugap
next

if lnv_buffer.of_size() > 0 then
	ls_error = this.modify(lnv_buffer.of_tostring())
	if len(ls_error) > 0 then
		::clipboard(lnv_buffer.of_tostring())
		messagebox('of_draw_topmenu() Error', ls_error)
		return -1
	end if
end if

// get maximum dwo width
if ll_rowcnt > 0 then
	il_max_width = long(this.describe('t_menu_' + string(inv_rolemenu.ids_menudata.rowcount(), '00') + ".x")) + long(this.describe('t_menu_' + string(inv_rolemenu.ids_menudata.rowcount(), '00') + ".width"))
else
	il_max_width = 0
end if

// program full path 출력용
gnv_session.of_put('submenu_pgm_name', '')

return ll_rowcnt

end function

public subroutine of_highlightmenu (integer ai_menu_seq, boolean ab_highlight);//
string ls_bitmap_nm, ls_text_nm
string ls_pgm_icon

ls_bitmap_nm = 'p_menu_' + string(ai_menu_seq, '00')
ls_text_nm = 't_menu_' + string(ai_menu_seq, '00')
ls_pgm_icon = this.describe(ls_bitmap_nm + '.filename')

long ll_lastpos
string ls_filepath, ls_filename
string ls_fileonly, ls_fileext
string ls_filetype, ls_orgfileonly
string ls_highlight_file

ll_lastpos = lastpos(ls_pgm_icon, '\')
if ll_lastpos = 0 then
	ls_filepath = ''
	ls_filename = ls_pgm_icon
else
	ls_filepath = left(ls_pgm_icon, ll_lastpos)
	ls_filename = mid(ls_pgm_icon, ll_lastpos + 1)
end if

ll_lastpos = lastpos(ls_filename, ".")
if ll_lastpos = 0 then
	ls_fileonly = ls_filename
	ls_fileext = ''
else
	ls_fileonly = left(ls_filename, ll_lastpos - 1)
	ls_fileext = mid(ls_filename, ll_lastpos)
end if

if right(ls_fileonly, len(DISABLED_SURFIX)) = DISABLED_SURFIX then
	ls_filetype = "disabled"
	ls_orgfileonly = left(ls_fileonly, len(ls_fileonly) - len(DISABLED_SURFIX))
elseif right(ls_fileonly, len(CLICKED_SURFIX)) = CLICKED_SURFIX then
	ls_filetype = "clicked"
	ls_orgfileonly = left(ls_fileonly, len(ls_fileonly) - len(CLICKED_SURFIX))
elseif right(ls_fileonly, len(MOUSEOVER_SURFIX)) = MOUSEOVER_SURFIX then
	ls_filetype = "mouseover"
	ls_orgfileonly = left(ls_fileonly, len(ls_fileonly) - len(MOUSEOVER_SURFIX))
else
	ls_filetype = "normal"
	ls_orgfileonly = ls_fileonly
end if

choose case ab_highlight
	case true
		choose case ls_filetype
			case "disabled", "mouseover"
			case else
				ls_highlight_file = ls_orgfileonly + MOUSEOVER_SURFIX + ls_fileext
		end choose
	case false
		choose case ls_filetype
			case "disabled", "normal"
			case else
				ls_highlight_file = ls_orgfileonly + ls_fileext
		end choose
end choose

string ls_syntax

if len(ls_highlight_file) > 0 then
	ls_syntax = ls_bitmap_nm + ".filename='" + ls_filepath + ls_highlight_file + "'~r~n"
end if

if ab_highlight = true then
	ls_syntax += ls_text_nm + ".color=" + string(MOUSEOVER_COLOR)
else
	ls_syntax += ls_text_nm + ".color=" + string(NORMAL_COLOR)
end if

string ls_error
ls_error = this.modify(ls_syntax)
if len(ls_error) > 0 then
	::clipboard(ls_syntax)
	messagebox('of_highlight_menu failure!!', ls_error)
end if

this.setredraw(true)

end subroutine

public function long of_getmaxdwowidth ();return il_max_width

end function

public function integer of_getscrollunit ();//return 192 + MENU_GAP
return 192

end function

on pf_u_mdi_iconmenu.create
call super::create
end on

on pf_u_mdi_iconmenu.destroy
call super::destroy
end on

event destructor;call super::destructor;destroy inv_rolemenu

end event

event clicked;call super::clicked;string	ls_menu_id, ls_pgm_nm

if pos(dwo.name, 'p_menu_') > 0 or pos(dwo.name, 't_menu_') > 0 then
	ls_menu_id = string(dwo.tag)
	ls_pgm_nm = this.describe('t_' + mid(string(dwo.name), 3) + '.text')
	
	// program full path 출력용
	gnv_session.of_put('topmenu_pgm_name', ls_pgm_nm)
	
	this.post event ue_menuclicked(ls_menu_id, '', ls_pgm_nm)
end if

return 0

end event

event pfe_mouseover;call super::pfe_mouseover;integer li_menu_seq

if pos(ao_dwo.name, 'p_menu_') > 0 or pos(ao_dwo.name, 't_menu_') > 0 then
	li_menu_seq = integer(right(ao_dwo.name, 2))
	this.of_highlightmenu(li_menu_seq, true)
	il_prev_seq = li_menu_seq
else
	if il_prev_seq > 0 then
		this.of_highlightmenu(il_prev_seq, false)
		il_prev_seq = 0
	end if
end if

end event

event pfe_mouseleave;call super::pfe_mouseleave;if il_prev_seq > 0 then
	this.of_highlightmenu(il_prev_seq, false)
	il_prev_seq = 0
end if

end event

event pfe_postopen;call super::pfe_postopen;// 메뉴권한 오브젝트 생성
inv_rolemenu = create pf_n_rolemenu

// TOP메뉴 구현
//this.of_drawtopmenu()

end event

