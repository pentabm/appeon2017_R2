$PBExportHeader$pf_w_favorite.srw
$PBExportComments$사용자별 즐겨찾기를 추가하는 화면입니다
forward
global type pf_w_favorite from pf_w_response
end type
type cb_new from pf_u_commandbutton within pf_w_favorite
end type
type dw_favor from pf_u_datawindow within pf_w_favorite
end type
type p_cancel from pf_u_imagebutton within pf_w_favorite
end type
type p_ok from pf_u_imagebutton within pf_w_favorite
end type
type st_2 from pf_u_statictext within pf_w_favorite
end type
type st_1 from pf_u_statictext within pf_w_favorite
end type
type st_title from pf_u_statictext within pf_w_favorite
end type
type p_icon from pf_u_picture within pf_w_favorite
end type
end forward

global type pf_w_favorite from pf_w_response
integer width = 2213
integer height = 964
string title = "즐겨찾기 추가"
cb_new cb_new
dw_favor dw_favor
p_cancel p_cancel
p_ok p_ok
st_2 st_2
st_1 st_1
st_title st_title
p_icon p_icon
end type
global pf_w_favorite pf_w_favorite

type variables
pf_n_menudata inv_menuparm

end variables

on pf_w_favorite.create
int iCurrent
call super::create
this.cb_new=create cb_new
this.dw_favor=create dw_favor
this.p_cancel=create p_cancel
this.p_ok=create p_ok
this.st_2=create st_2
this.st_1=create st_1
this.st_title=create st_title
this.p_icon=create p_icon
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_new
this.Control[iCurrent+2]=this.dw_favor
this.Control[iCurrent+3]=this.p_cancel
this.Control[iCurrent+4]=this.p_ok
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_title
this.Control[iCurrent+8]=this.p_icon
end on

on pf_w_favorite.destroy
call super::destroy
destroy(this.cb_new)
destroy(this.dw_favor)
destroy(this.p_cancel)
destroy(this.p_ok)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_title)
destroy(this.p_icon)
end on

event open;call super::open;if not isvalid(message.powerobjectparm) then
	messagebox('알림', '잘못된 윈도우 호출입니다')
	post close(this)
end if

if classname(message.powerobjectparm) <> 'pf_n_menudata' then
	messagebox('알림', '잘못된 윈도우 호출입니다')
	post close(this)
end if

inv_menuparm = message.powerobjectparm
dw_favor.settransobject(sqlca)

datawindowchild ldwc_1
dw_favor.getchild('parent_menu', ldwc_1)
ldwc_1.settransobject(sqlca)
ldwc_1.retrieve(gnv_session.is_sys_id, gnv_session.is_user_id)
ldwc_1.insertrow(1)
ldwc_1.setitem(1, 'menu_id', '00000')
ldwc_1.setitem(1, 'favor_name', '즐겨찾기')

dw_favor.insertrow(0)
dw_favor.setitem(1, 'sys_id', gnv_session.is_sys_id)
dw_favor.setitem(1, 'user_id', gnv_session.is_user_id)
dw_favor.setitem(1, 'menu_id', inv_menuparm.is_menu_id)
dw_favor.setitem(1, 'favor_name', inv_menuparm.is_pgm_name)
dw_favor.setitem(1, 'pgm_kind_code', 'P')
dw_favor.setitem(1, 'parent_menu', '00000')

dw_favor.setcolumn('favor_name')
dw_favor.setfocus()

end event

type ln_templeft from pf_w_response`ln_templeft within pf_w_favorite
end type

type ln_tempright from pf_w_response`ln_tempright within pf_w_favorite
end type

type ln_temptop from pf_w_response`ln_temptop within pf_w_favorite
end type

type ln_tempbuttom from pf_w_response`ln_tempbuttom within pf_w_favorite
end type

type ln_tempbutton from pf_w_response`ln_tempbutton within pf_w_favorite
end type

type ln_tempstart from pf_w_response`ln_tempstart within pf_w_favorite
end type

type cb_new from pf_u_commandbutton within pf_w_favorite
integer x = 1755
integer y = 528
integer width = 315
integer height = 96
integer taborder = 20
string text = "새 폴더"
end type

event clicked;call super::clicked;string	ls_input

if pf_f_inputdialog('폴더 만들기', '신규 생성할 폴더 이름을 입력하세요', ls_input) = 0 then return
if isnull(ls_input) or len(trim(ls_input)) = 0 then return

pf_n_datastore lds_favor
long ll_new
string ls_user_id, ls_menu_id
string ls_max_seq

lds_favor = create pf_n_datastore
lds_favor.dataobject = 'pf_d_favorite_dat'
lds_favor.settransobject(sqlca)

ll_new = lds_favor.insertrow(0)
lds_favor.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
ls_user_id = gnv_session.is_user_id
lds_favor.setitem(ll_new, 'user_id', ls_user_id)

select		max(menu_id)
into		:ls_max_seq
from		pf_user_favor
where	sys_id = :gnv_session.is_sys_id
and		user_id = :ls_user_id
and		pgm_kind_code = 'M'
and		menu_id like 'FVR%'
using		sqlca;

if isnull(ls_max_seq) then 
	ls_max_seq = '0'
else
	ls_max_seq = mid(ls_max_seq, 4, 2)
end if

ls_menu_id = 'FVR' + string(long(ls_max_seq) + 1, '00')

lds_favor.setitem(ll_new, 'menu_id', ls_menu_id)
lds_favor.setitem(ll_new, 'favor_name', ls_input)
lds_favor.setitem(ll_new, 'pgm_kind_code', 'M')
lds_favor.setitem(ll_new, 'parent_menu', 'ROOT')
lds_favor.setitem(ll_new, 'sort_order', long(ls_max_seq) + 1)

datawindowchild ldwc_1

if lds_favor.update() = 1 then
	commit using sqlca;
	
	if dw_favor.getchild('parent_menu', ldwc_1) = 1  then
		ll_new = ldwc_1.insertrow(0)
		ldwc_1.setitem(ll_new, 'menu_id', ls_menu_id)
		ldwc_1.setitem(ll_new, 'favor_name', ls_input)
		
		dw_favor.setitem(1, 'parent_menu', ls_menu_id)
	end if
else
	rollback using sqlca;
	messagebox('알림', '폴더 생성 실패!!~r~n' + lds_favor.istr_dberror.sqlerrtext)
end if

end event

type dw_favor from pf_u_datawindow within pf_w_favorite
integer x = 128
integer y = 396
integer width = 2025
integer height = 276
integer taborder = 10
string dataobject = "pf_d_favorite_ent"
boolean border = false
boolean useborder = false
end type

type p_cancel from pf_u_imagebutton within pf_w_favorite
integer x = 1824
integer y = 744
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_cancel.gif"
end type

event clicked;call super::clicked;closewithreturn(parent, 'Cancel')

end event

type p_ok from pf_u_imagebutton within pf_w_favorite
integer x = 1577
integer y = 744
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
end type

event clicked;call super::clicked;string ls_user_id
string ls_parent_menu, ls_menu_id
long ll_sort_order, ll_cnter

ls_user_id = gnv_session.is_user_id
ls_parent_menu = dw_favor.getitemstring(1, 'parent_menu')
ls_menu_id = dw_favor.getitemstring(1, 'menu_id')

select		count(1)
into		:ll_cnter
from		pf_user_favor
where	sys_id = :gnv_session.is_sys_id
and		user_id = :ls_user_id
and		menu_id = :ls_menu_id;

if ll_cnter > 0 then
	messagebox('알림', "해당 프로그램은 이미 즐겨찾기 추가되어 있습니다")
	closewithreturn(parent, 'Cancel')
	return
end if

select		max(sort_order)
into		:ll_sort_order
from		pf_user_favor
where	sys_id = :gnv_session.is_sys_id
and		user_id = :ls_user_id
and		parent_menu = :ls_parent_menu
using		sqlca;

if isnull(ll_sort_order) then ll_sort_order = 0
dw_favor.setitem(1, 'sort_order', ll_sort_order + 1)

if dw_favor.update() = 1 then
	commit using sqlca;
	messagebox('알림', '즐겨찾기 추가 완료')
else
	rollback using sqlca;
	
	choose case dw_favor.istr_dberror.sqldbcode
		case 1
			messagebox('알림', "해당 프로그램은 이미 즐겨찾기 추가되어 있습니다")
			closewithreturn(parent, 'Cancel')
			return
		case else
			messagebox('알림', "즐겨찾기 추가 실패!~r~n" + dw_favor.istr_dberror.sqlerrtext)	
			closewithreturn(parent, 'Cancel')
			return
	end choose
end if

if isnull(parent) then return
closewithreturn(parent, 'OK')

end event

type st_2 from pf_u_statictext within pf_w_favorite
integer x = 430
integer y = 244
integer width = 1723
long textcolor = 20132659
string text = "좌측의 즐겨찾기 메뉴를 선택하세요."
end type

type st_1 from pf_u_statictext within pf_w_favorite
integer x = 430
integer y = 176
integer width = 1723
long textcolor = 20132659
string text = "이 프로그램을 즐겨찾기에 추가합니다. 즐겨찾기에 액세스 하려면"
end type

type st_title from pf_u_statictext within pf_w_favorite
integer x = 430
integer y = 64
integer width = 503
integer height = 96
integer textsize = -12
integer weight = 700
long textcolor = 25123896
string text = "즐겨찾기 추가"
end type

type p_icon from pf_u_picture within pf_w_favorite
integer x = 114
integer y = 104
integer width = 201
integer height = 176
boolean originalsize = false
string picturename = "..\img\mainframe\w_favorite\favorite.jpg"
end type

