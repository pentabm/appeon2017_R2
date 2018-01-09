$PBExportHeader$pf_w_pgm_mst_role_pgm.srw
$PBExportComments$프로그램 기본정보 등록 후 권한을 할당할 때 사용되는 팝업 윈도우 입니다.
forward
global type pf_w_pgm_mst_role_pgm from pf_w_response
end type
type st_2 from statictext within pf_w_pgm_mst_role_pgm
end type
type p_1 from picture within pf_w_pgm_mst_role_pgm
end type
type st_1 from statictext within pf_w_pgm_mst_role_pgm
end type
type p_2 from picture within pf_w_pgm_mst_role_pgm
end type
type dw_role_memb from pf_u_datawindow within pf_w_pgm_mst_role_pgm
end type
type p_close from pf_u_imagebutton within pf_w_pgm_mst_role_pgm
end type
type p_update from pf_u_imagebutton within pf_w_pgm_mst_role_pgm
end type
type dw_role_mst from pf_u_datawindow within pf_w_pgm_mst_role_pgm
end type
end forward

global type pf_w_pgm_mst_role_pgm from pf_w_response
integer width = 4306
integer height = 2424
string title = "프로그램별 권한선택"
st_2 st_2
p_1 p_1
st_1 st_1
p_2 p_2
dw_role_memb dw_role_memb
p_close p_close
p_update p_update
dw_role_mst dw_role_mst
end type
global pf_w_pgm_mst_role_pgm pf_w_pgm_mst_role_pgm

type variables
pf_n_hashtable inv_parm

datastore ids_role_cat
datastore ids_role_pgm
string is_menu_id

end variables

forward prototypes
public function integer of_set_title_dw_role_memb ()
public function integer of_add_parent_menu_node (string as_role_no, string as_menu_id)
end prototypes

public function integer of_set_title_dw_role_memb ();integer i, il_role_cat_no
boolean lb_role_cat_yn[8]
string ls_modify, ls_search_type
string ls_role_cat_no, ls_role_cat_name
string ls_code_list_dwo

// modify header title
for i = 1 to ids_role_cat.rowcount()
	ls_role_cat_no = ids_role_cat.getitemstring(i, 'role_cat_no')
	il_role_cat_no = integer(ls_role_cat_no)
	lb_role_cat_yn[il_role_cat_no] = true
	ls_role_cat_name = ids_role_cat.getitemstring(i, 'role_cat_name')
	ls_search_type = ids_role_cat.getitemstring(i, 'search_type')
	ls_code_list_dwo = ids_role_cat.getitemstring(i, 'code_list_dwo')
	
	ls_modify += "memb_name" + string(il_role_cat_no) + "_t.text='" + ls_role_cat_name + "'~r~n"
	ls_modify += "memb_name" + string(il_role_cat_no) + "_t.tag='" + ls_code_list_dwo + "'~r~n"
next

// hide unused columns
for i = 1 to upperbound(lb_role_cat_yn)
	if lb_role_cat_yn[i] = false then
		ls_modify += 'memb_name' + string(i) + '_t.visible="0"~r~n'
		ls_modify += 'memb_name' + string(i) + '.visible="0"~r~n'
	end if
next

// do moidfy
string ls_error

ls_error = dw_role_memb.Modify(ls_modify)
if len(ls_error) > 0 then
	::clipboard(dw_role_memb.classname() + "~r~n" + ls_modify)
	messagebox("Error", dw_role_memb.classname() + " Syntax Modification Failure!! : " + ls_error)
	return -1
end if

dw_role_memb.event pfe_dwowidthchanged()

return 1

end function

public function integer of_add_parent_menu_node (string as_role_no, string as_menu_id);string ls_menu_id
long ll_rolepgm_cnt
long ll_new

select		s01.parent_menu,
			(case when s02.role_no is null then 0 else 1 end) rolepgm_cnt
into		:ls_menu_id,
			:ll_rolepgm_cnt
from		pf_pgm_mst s01 left
outer join pf_role_pgm s02 on s02.sys_id = s01.sys_id and s02.role_no = :as_role_no and s02.menu_id = s01.parent_menu
where	s01.sys_id = :gnv_session.is_sys_id
and		s01.menu_id = :as_menu_id
using		sqlca;

do while sqlca.sqlcode = 0 and ls_menu_id <> 'ROOT'
	if ll_rolepgm_cnt = 0 then
		ll_new = ids_role_pgm.insertrow(0)
		ids_role_pgm.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
		ids_role_pgm.setitem(ll_new, 'menu_id', ls_menu_id)
		ids_role_pgm.setitem(ll_new, 'role_no', as_role_no)
	end if
	
	select		s01.parent_menu,
				(case when s02.role_no is null then 0 else 1 end) rolepgm_cnt
	into		:ls_menu_id,
				:ll_rolepgm_cnt
	from		pf_pgm_mst s01 left
	outer join pf_role_pgm s02 on s02.sys_id = s01.sys_id and s02.role_no = :as_role_no and s02.menu_id = s01.parent_menu
	where	s01.sys_id = :gnv_session.is_sys_id
	and		s01.menu_id = :ls_menu_id
	using		sqlca;
loop

return 0

end function

on pf_w_pgm_mst_role_pgm.create
int iCurrent
call super::create
this.st_2=create st_2
this.p_1=create p_1
this.st_1=create st_1
this.p_2=create p_2
this.dw_role_memb=create dw_role_memb
this.p_close=create p_close
this.p_update=create p_update
this.dw_role_mst=create dw_role_mst
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.p_2
this.Control[iCurrent+5]=this.dw_role_memb
this.Control[iCurrent+6]=this.p_close
this.Control[iCurrent+7]=this.p_update
this.Control[iCurrent+8]=this.dw_role_mst
end on

on pf_w_pgm_mst_role_pgm.destroy
call super::destroy
destroy(this.st_2)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.p_2)
destroy(this.dw_role_memb)
destroy(this.p_close)
destroy(this.p_update)
destroy(this.dw_role_mst)
end on

event open;call super::open;//inv_parm = message.powerobjectparm
//if isnull(inv_parm) or not isvalid(inv_parm) then
//	messagebox('알림', '올바르지 않은 윈도우 호출입니다.')
//	return
//end if

if isnull(message.stringparm) or message.stringparm = '' then
	messagebox('알림', '올바르지 않은 윈도우 호출입니다.')
	close(this)
	return
end if

is_menu_id = message.stringparm

ids_role_pgm = create datastore
ids_role_pgm.dataobject = 'pf_d_pgm_mst_role_pgm_03'
ids_role_pgm.settransobject(sqlca)
ids_role_pgm.retrieve(gnv_session.is_sys_id, is_menu_id)

dw_role_mst.settransobject(sqlca)
dw_role_memb.settransobject(sqlca)

ids_role_cat = create datastore
ids_role_cat.dataobject = 'pf_d_role_cat_mst'
ids_role_cat.settransobject(sqlca)
ids_role_cat.retrieve(gnv_session.is_sys_id)

of_set_title_dw_role_memb()

end event

event pfe_postopen;call super::pfe_postopen;dw_role_mst.retrieve(gnv_session.is_sys_id)

integer i
string ls_role_no
long ll_find, ll_rowcnt

ll_rowcnt = ids_role_pgm.rowcount()
for i = 1 to ll_rowcnt
	ls_role_no = ids_role_pgm.getitemstring(i, 'role_no')
	ll_find = dw_role_mst.find("role_no='" + ls_role_no + "'", 1, dw_role_mst.rowcount())
	if ll_find > 0 then
		dw_role_mst.setitem(ll_find, 'chk', 'Y')
	end if
next

//if is_work_gb = '' then
//	is_work_gb = '%'
//else
//	ddlb_manager.text = is_work_gb
//end if
//
//dw_role_mst.retrieve(gnv_session.is_sys_id, is_work_gb)
//
//integer i
//string ls_role_no
//long ll_find, ll_rowcnt
//
//ll_rowcnt = ids_role_pgm.retrieve(gnv_session.is_sys_id, is_menu_id)
//for i = 1 to ll_rowcnt
//	ls_role_no = ids_role_pgm.getitemstring(i, 'role_no')
//	ll_find = dw_role_mst.find("role_no='" + ls_role_no + "'", 1, dw_role_mst.rowcount())
//	if ll_find > 0 then
//		dw_role_mst.setitem(ll_find, 'chk', 'Y')
//	end if
//next

//integer li_index
//
//li_index = gnv_session.of_getint('ddlb_manager.index')
//if isnull(li_index) or li_index = 0 then li_index = 1
//ddlb_manager.selectitem(li_index)
//ddlb_manager.event selectionchanged(li_index)
//return


end event

type st_2 from statictext within pf_w_pgm_mst_role_pgm
integer x = 1893
integer y = 40
integer width = 402
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 8421504
string text = "권한멤버"
boolean focusrectangle = false
end type

type p_1 from picture within pf_w_pgm_mst_role_pgm
integer x = 1829
integer y = 52
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type st_1 from statictext within pf_w_pgm_mst_role_pgm
integer x = 101
integer y = 40
integer width = 402
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 8421504
string text = "권한목록"
boolean focusrectangle = false
end type

type p_2 from picture within pf_w_pgm_mst_role_pgm
integer x = 37
integer y = 52
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type dw_role_memb from pf_u_datawindow within pf_w_pgm_mst_role_pgm
integer x = 1829
integer y = 136
integer width = 2437
integer height = 2180
integer taborder = 10
string dataobject = "pf_d_pgm_mst_role_pgm_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean datawindowaction = false
boolean scaletoright = true
boolean scaletobottom = true
end type

event buttonclicked;if dwo.name = 'b_dwo' then
	OpenwithParm(pf_w_datawindow_search, '', parent)
	if isvalid(message.powerobjectparm) then
		pf_n_hashtable lnv_retval
		lnv_retval = message.powerobjectparm
		if isvalid(lnv_retval) then
			this.setitem(row, 'code_list_dwo', lnv_retval.of_get('classname'))
		end if
	end if
end if

end event

type p_close from pf_u_imagebutton within pf_w_pgm_mst_role_pgm
integer x = 4032
integer y = 28
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
end type

event clicked;call super::clicked;closewithreturn(parent, 'Cancel')

end event

type p_update from pf_u_imagebutton within pf_w_pgm_mst_role_pgm
integer x = 3781
integer y = 28
integer width = 233
integer height = 88
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
end type

event clicked;call super::clicked;string ls_errtext

// Accept Text
if dw_role_mst.accepttext() = -1 then return

if ids_role_pgm.update() = 1 then
	commit using sqlca;
	closewithreturn(parent, 'OK')
else
	ls_errtext = sqlca.sqlerrtext
	rollback using sqlca;
	messagebox('알림', '프로그램 권한 정보 저장 실패!!~r~n' + 'Error Text: ' + ls_errtext)
	return
end if

end event

type dw_role_mst from pf_u_datawindow within pf_w_pgm_mst_role_pgm
integer x = 37
integer y = 136
integer width = 1774
integer height = 2180
integer taborder = 10
string dataobject = "pf_d_pgm_mst_role_pgm_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean datawindowaction = false
boolean scaletobottom = true
end type

event rowfocuschanged;call super::rowfocuschanged;if currentrow = 0 then return

string ls_role_no

ls_role_no = this.getitemstring(currentrow, 'role_no')
dw_role_memb.retrieve(gnv_session.is_sys_id, ls_role_no)

end event

event itemchanged;call super::itemchanged;long ll_new, ll_find
string ls_role_no

choose case dwo.name
	case 'chk'
		if data = 'Y' then
			ll_new = ids_role_pgm.insertrow(0)
			ls_role_no = this.getitemstring(row, 'role_no')
			ids_role_pgm.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
			ids_role_pgm.setitem(ll_new, 'menu_id', is_menu_id)
			ids_role_pgm.setitem(ll_new, 'role_no', ls_role_no)
			
			of_add_parent_menu_node(ls_role_no, is_menu_id)
		else
			ls_role_no = this.getitemstring(row, 'role_no')
			ll_find = ids_role_pgm.find("role_no='" + ls_role_no + "' and menu_id='" + is_menu_id + "'", 1, ids_role_pgm.rowcount())
			if ll_find > 0 then
				ids_role_pgm.deleterow(ll_find)
			end if
		end if
end choose

end event

