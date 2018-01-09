$PBExportHeader$pf_w_select_rolemst.srw
$PBExportComments$권한을 할당할때 사용되는 팝업윈도우 입니다.
forward
global type pf_w_select_rolemst from pf_w_response
end type
type cb_close from pf_u_commandbutton within pf_w_select_rolemst
end type
type cb_select from pf_u_commandbutton within pf_w_select_rolemst
end type
type st_1 from statictext within pf_w_select_rolemst
end type
type p_2 from picture within pf_w_select_rolemst
end type
type dw_role_mst from pf_u_datawindow within pf_w_select_rolemst
end type
end forward

global type pf_w_select_rolemst from pf_w_response
integer width = 2318
integer height = 2424
string title = "프로그램별 권한선택"
cb_close cb_close
cb_select cb_select
st_1 st_1
p_2 p_2
dw_role_mst dw_role_mst
end type
global pf_w_select_rolemst pf_w_select_rolemst

type variables
pf_n_hashtable inv_parm

datastore ids_role_cat
datastore ids_role_pgm

string is_job_type
string is_menu_id
string is_user_id

end variables

forward prototypes
public function integer of_add_parent_menu_idde (string as_role_no, string as_menu_id)
end prototypes

public function integer of_add_parent_menu_idde (string as_role_no, string as_menu_id);string ls_menu_id
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

on pf_w_select_rolemst.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_select=create cb_select
this.st_1=create st_1
this.p_2=create p_2
this.dw_role_mst=create dw_role_mst
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_select
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.p_2
this.Control[iCurrent+5]=this.dw_role_mst
end on

on pf_w_select_rolemst.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_select)
destroy(this.st_1)
destroy(this.p_2)
destroy(this.dw_role_mst)
end on

event open;call super::open;dw_role_mst.settransobject(sqlca)

end event

event pfe_postopen;call super::pfe_postopen;dw_role_mst.retrieve(gnv_session.is_sys_id)

end event

type cb_close from pf_u_commandbutton within pf_w_select_rolemst
integer x = 1879
integer y = 20
integer height = 96
integer taborder = 20
string text = "닫기"
end type

event clicked;call super::clicked;closewithreturn(parent, '')

end event

type cb_select from pf_u_commandbutton within pf_w_select_rolemst
integer x = 1472
integer y = 20
integer height = 96
integer taborder = 10
string text = "선택"
end type

event clicked;call super::clicked;long ll_row
string ls_role_no, ls_role_name

ll_row = dw_role_mst.getrow()
if ll_row = 0 then
	messagebox('알림', '선택된 권한이 없습니다')
	return
end if

ls_role_no = dw_role_mst.getitemstring(ll_row, 'role_no')
ls_role_name = dw_role_mst.getitemstring(ll_row, 'role_name')

closewithreturn(parent, ls_role_no + '~t' + ls_role_name)

end event

type st_1 from statictext within pf_w_select_rolemst
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
long textcolor = 20395836
string text = "권한목록"
boolean focusrectangle = false
end type

type p_2 from picture within pf_w_select_rolemst
integer x = 37
integer y = 52
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type dw_role_mst from pf_u_datawindow within pf_w_select_rolemst
integer x = 37
integer y = 136
integer width = 2245
integer height = 2180
integer taborder = 10
string dataobject = "pf_d_select_rolemst"
boolean hscrollbar = true
boolean vscrollbar = true
boolean scaletobottom = true
end type

event doubleclicked;call super::doubleclicked;if row > 0 then
	cb_select.post event clicked()
end if

end event

