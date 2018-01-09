$PBExportHeader$pf_w_board_mst_ent.srw
$PBExportComments$게시판 기본정보 관리 화면 입니다.
forward
global type pf_w_board_mst_ent from pf_w_sheet
end type
type st_1 from statictext within pf_w_board_mst_ent
end type
type p_2 from picture within pf_w_board_mst_ent
end type
type dw_list from pf_u_datawindow within pf_w_board_mst_ent
end type
type p_add from pf_u_imagebutton within pf_w_board_mst_ent
end type
type p_save from pf_u_imagebutton within pf_w_board_mst_ent
end type
type p_delete from pf_u_imagebutton within pf_w_board_mst_ent
end type
type p_close from pf_u_imagebutton within pf_w_board_mst_ent
end type
end forward

global type pf_w_board_mst_ent from pf_w_sheet
st_1 st_1
p_2 p_2
dw_list dw_list
p_add p_add
p_save p_save
p_delete p_delete
p_close p_close
end type
global pf_w_board_mst_ent pf_w_board_mst_ent

on pf_w_board_mst_ent.create
int iCurrent
call super::create
this.st_1=create st_1
this.p_2=create p_2
this.dw_list=create dw_list
this.p_add=create p_add
this.p_save=create p_save
this.p_delete=create p_delete
this.p_close=create p_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_2
this.Control[iCurrent+3]=this.dw_list
this.Control[iCurrent+4]=this.p_add
this.Control[iCurrent+5]=this.p_save
this.Control[iCurrent+6]=this.p_delete
this.Control[iCurrent+7]=this.p_close
end on

on pf_w_board_mst_ent.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_2)
destroy(this.dw_list)
destroy(this.p_add)
destroy(this.p_save)
destroy(this.p_delete)
destroy(this.p_close)
end on

event open;call super::open;dw_list.settransobject(sqlca)
dw_list.retrieve(gnv_session.is_sys_id)

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_board_mst_ent
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_board_mst_ent
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_board_mst_ent
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_board_mst_ent
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_board_mst_ent
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_board_mst_ent
end type

type st_1 from statictext within pf_w_board_mst_ent
integer x = 110
integer y = 172
integer width = 882
integer height = 48
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "게시판(Board) 기본정보 리스트"
boolean focusrectangle = false
end type

type p_2 from picture within pf_w_board_mst_ent
integer x = 50
integer y = 176
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type dw_list from pf_u_datawindow within pf_w_board_mst_ent
integer x = 50
integer y = 236
integer width = 4498
integer height = 1984
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_board_mst_ent_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean scaletoright = true
boolean scaletobottom = true
end type

type p_add from pf_u_imagebutton within pf_w_board_mst_ent
integer x = 3589
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long ll_new

ll_new = dw_list.insertrow(0)
dw_list.scrolltorow(ll_new)
dw_list.setrow(ll_new)

end event

type p_save from pf_u_imagebutton within pf_w_board_mst_ent
integer x = 4073
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;if dw_list.accepttext() = -1 then return

// 필수입력사항 체크
string ls_board_name

ls_board_name = dw_list.getitemstring(1, 'board_name')
if isnull(ls_board_name) or len(trim(ls_board_name)) = 0 then
	messagebox('알림', '보드 명칭을 입력하세요')
	return 0
end if

// Primary Key 생성
string ls_board_no
long ll_modified

ll_modified = dw_list.getnextmodified(0, primary!)
do while ll_modified > 0
	if dw_list.getitemstatus(ll_modified, 0, primary!) = newmodified! then
		select		max(board_no)
		into		:ls_board_no
		from		pf_board_mst
		where	sys_id = :gnv_session.is_sys_id;
		
		if isnull(ls_board_no) then ls_board_no = '0'
		ls_board_no = string(long(ls_board_no) + 1, '0000000')
		dw_list.setitem(ll_modified, 'sys_id', gnv_session.is_sys_id)
		dw_list.setitem(ll_modified, 'board_no', ls_board_no)
	end if
	
	ll_modified = dw_list.getnextmodified(ll_modified, primary!)
loop

// 저장
if dw_list.update() = 1 then
	commit using sqlca;
	of_setmessage("자료 저장 완료!!")
else
	rollback using sqlca;
	messagebox('알림', '자료 저장 실패했습니다!!~r~n' + dw_list.istr_dberror.sqlerrtext)
end if

end event

type p_delete from pf_u_imagebutton within pf_w_board_mst_ent
integer x = 3831
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long	ll_row
string	ls_board_no, ls_board_name
string	ls_errtext

ll_row = dw_list.getrow()
if ll_row > 0 then
	ls_board_no = dw_list.getitemstring(ll_row, 'board_no')
	ls_board_name = dw_list.getitemstring(ll_row, 'board_name')
	if messagebox('알림', '선택하신 ' + ls_board_name + '[' + ls_board_no + '] 보드 기본정보를 삭제하시겠습니까?', Exclamation!, YesNo!, 2) = 1 then
		dw_list.deleterow(ll_row)
		if dw_list.update() = 1 then
			commit using sqlca;
			parent.of_setmessage('삭제 완료')
		else
			ls_errtext = sqlca.sqlerrtext
			rollback using sqlca;
			messagebox('알림', 'Role 정보 삭제 실패!!~r~n' + 'Error Text: ' + ls_errtext)
			return
		end if
	end if
end if

end event

type p_close from pf_u_imagebutton within pf_w_board_mst_ent
integer x = 4315
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)

end event

