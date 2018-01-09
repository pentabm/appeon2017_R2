$PBExportHeader$pf_w_table_comment_ora.srw
$PBExportComments$데이터베이스 테이블 Commnet 관리
forward
global type pf_w_table_comment_ora from pf_w_sheet
end type
type dw_cond from pf_u_datawindow within pf_w_table_comment_ora
end type
type p_retrieve from pf_u_imagebutton within pf_w_table_comment_ora
end type
type p_save from pf_u_imagebutton within pf_w_table_comment_ora
end type
type p_close from pf_u_imagebutton within pf_w_table_comment_ora
end type
type dw_list from pf_u_datawindow within pf_w_table_comment_ora
end type
type dw_detail from pf_u_datawindow within pf_w_table_comment_ora
end type
type st_vertical from pf_u_splitbar_vertical within pf_w_table_comment_ora
end type
end forward

global type pf_w_table_comment_ora from pf_w_sheet
dw_cond dw_cond
p_retrieve p_retrieve
p_save p_save
p_close p_close
dw_list dw_list
dw_detail dw_detail
st_vertical st_vertical
end type
global pf_w_table_comment_ora pf_w_table_comment_ora

on pf_w_table_comment_ora.create
int iCurrent
call super::create
this.dw_cond=create dw_cond
this.p_retrieve=create p_retrieve
this.p_save=create p_save
this.p_close=create p_close
this.dw_list=create dw_list
this.dw_detail=create dw_detail
this.st_vertical=create st_vertical
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cond
this.Control[iCurrent+2]=this.p_retrieve
this.Control[iCurrent+3]=this.p_save
this.Control[iCurrent+4]=this.p_close
this.Control[iCurrent+5]=this.dw_list
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.st_vertical
end on

on pf_w_table_comment_ora.destroy
call super::destroy
destroy(this.dw_cond)
destroy(this.p_retrieve)
destroy(this.p_save)
destroy(this.p_close)
destroy(this.dw_list)
destroy(this.dw_detail)
destroy(this.st_vertical)
end on

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_table_comment_ora
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_table_comment_ora
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_table_comment_ora
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_table_comment_ora
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_table_comment_ora
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_table_comment_ora
end type

type dw_cond from pf_u_datawindow within pf_w_table_comment_ora
integer x = 50
integer y = 164
integer width = 4498
integer height = 152
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_table_comment_ora_01"
boolean singlerowselection = false
boolean issearchcondition = true
boolean datawindowaction = true
end type

type p_retrieve from pf_u_imagebutton within pf_w_table_comment_ora
integer x = 3831
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_retrieve.gif"
boolean fixedtoright = true
string referencedobject = "dw_list"
string datawindowaction = "retrieve"
end type

event clicked;call super::clicked;//string ls_owner, ls_object_type, ls_table_name
//long ll_rowcnt
//
//if dw_cond.accepttext() = -1 then return
//
//ls_owner = dw_cond.getitemstring(1, 'owner')
//ls_table_name = dw_cond.getitemstring(1, 'table_name')
//
//if pf_f_isemptystring(ls_owner) then
//	ls_owner = '%'
//end if
//
//if pf_f_isemptystring(ls_table_name) then
//	ls_table_name = '%'
//else
//	ls_table_name = '%' + ls_table_name + '%'
//end if
//
//dw_list.reset()
//ll_rowcnt = dw_list.retrieve(ls_owner, ls_table_name)
//of_setmessage('[' + string(ll_rowcnt, '#,##0') + ']건의 자료가 조회되었습니다')

end event

type p_save from pf_u_imagebutton within pf_w_table_comment_ora
integer x = 4073
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
boolean fixedtoright = true
string referencedobject = "dw_list"
end type

event clicked;call super::clicked;if dw_list.accepttext() = -1 then return
if dw_detail.accepttext() = -1 then return

long ll_row
string ls_owner, ls_table_name, ls_column_name, ls_comments
string ls_query

ll_row = dw_list.getnextmodified(0, primary!)
do while ll_row > 0
	ls_owner = dw_list.getitemstring(ll_row, 'owner')
	ls_table_name = dw_list.getitemstring(ll_row, 'table_name')
	ls_comments = dw_list.getitemstring(ll_row, 'comments')
	
	ls_query = "COMMENT ON TABLE " + ls_owner + "." + ls_table_name + " IS '" + ls_comments + "'"
	execute immediate :ls_query;
	
	if sqlca.sqlcode <> 0 then
		messagebox('알림', '아래와 같은 오류가 발생하였습니다~r~n' + sqlca.sqlerrtext)
		return
	end if

	ll_row = dw_list.getnextmodified(ll_row, primary!)
loop

dw_list.resetupdate()

ll_row = dw_detail.getnextmodified(0, primary!)
do while ll_row > 0
	ls_owner = dw_detail.getitemstring(ll_row, 'owner')
	ls_table_name = dw_detail.getitemstring(ll_row, 'table_name')
	ls_column_name = dw_detail.getitemstring(ll_row, 'column_name')
	ls_comments = dw_detail.getitemstring(ll_row, 'comments')
	
	ls_query = "COMMENT ON COLUMN " + ls_owner + "." + ls_table_name + "." + ls_column_name + " IS '" + ls_comments + "'"
	execute immediate :ls_query;
	
	if sqlca.sqlcode <> 0 then
		messagebox('알림', '아래와 같은 오류가 발생하였습니다~r~n' + sqlca.sqlerrtext)
		return
	end if

	ll_row = dw_detail.getnextmodified(ll_row, primary!)
loop

dw_detail.resetupdate()
of_setmessage("자료 저장 완료!!")


//if dw_detail.accepttext() = -1 then return
//
//// 변경사항 체크
//if rte_content.modified = false and dw_detail.modifiedcount() = 0 and dw_detail.deletedcount() = 0 and &
//	dw_attach.modifiedcount() = 0 and dw_attach.deletedcount() = 0 then
//	return
//end if
//
//// 필수입력사항 체크
//string ls_writer_name
//string ls_docu_title
//string ls_content
//
//ls_writer_name = dw_detail.getitemstring(1, 'writer_name')
//if isnull(ls_writer_name) or len(trim(ls_writer_name)) = 0 then
//	messagebox('알림', '작성자를 입력하세요')
//	return 0
//end if
//
//ls_docu_title = dw_detail.getitemstring(1, 'docu_title')
//if isnull(ls_docu_title) or len(trim(ls_docu_title)) = 0 then
//	messagebox('알림', '문서 타이틀을 입력하세요')
//	return 0
//end if
//
//ls_content = rte_content.copyrtf(false)
//if isnull(ls_content) or len(trim(ls_content)) = 0 then
//	messagebox('알림', '문서 내용을 입력하세요')
//	return 0
//end if
//
//// Primary Key 생성
//string ls_docu_no
//long ll_modified, ll_attach_seq
//
//if dw_detail.getitemstatus(1, 0, primary!) = newmodified! then
//	select		max(docu_no)
//	into		:ls_docu_no
//	from		pf_docu_mst
//	where	sys_id = :gnv_session.is_sys_id
//	and		board_no = :is_board_no;
//	
//	if isnull(ls_docu_no) then ls_docu_no = '0'
//	ls_docu_no = string(long(ls_docu_no) + 100, '0000000')
//	dw_detail.setitem(1, 'docu_no', ls_docu_no)
//	dw_detail.setitem(1, 'create_user', gnv_session.of_getstring('user_id'))
//	dw_detail.setitem(1, 'create_dtm', now())
//else
//	ls_docu_no = dw_detail.getitemstring(1, 'docu_no')
//end if
//
//ll_modified = dw_attach.getnextmodified(0, primary!)
//do while ll_modified > 0
//	if dw_attach.getitemstatus(ll_modified, 0, primary!) = newmodified! then
//		ll_attach_seq = long(dw_attach.describe("Evaluate('Max(attach_seq for all)', 1)"))
//		ll_attach_seq += 1
//		
//		dw_attach.setitem(ll_modified, 'docu_no', ls_docu_no)
//		dw_attach.setitem(ll_modified, 'attach_seq', ll_attach_seq)
//	end if
//	
//	ll_modified = dw_attach.getnextmodified(ll_modified, primary!)
//loop
//
//// 저장
//string ls_errmsg
//blob lb_content
//integer li_file_num
//blob lb_file_content
//string ls_server_path
//
//lb_content = blob(ls_content)	//, EncodingAnsi!)
//
//if dw_detail.update(true, false) = 1 then
//	updateblob	pf_docu_mst
//	set			docu_content = :lb_content
//	where	sys_id = :gnv_session.is_sys_id
//	and		board_no = :is_board_no
//	and		docu_no = :ls_docu_no;
//	
//	if sqlca.sqlcode <> 0 then
//		ls_errmsg = sqlca.sqlerrtext
//		rollback using sqlca;
//		messagebox('알림1', '자료 저장 실패했습니다!!~r~n' + ls_errmsg)
//		return
//	end if
//else
//	rollback using sqlca;
//	messagebox('알림2', '자료 저장 실패했습니다!!~r~n' + dw_detail.istr_dberror.sqlerrtext)
//	return
//end if
//
//if dw_attach.update(true, false) = 1 then
//	ll_modified = dw_attach.getnextmodified(0, primary!)
//	do while ll_modified > 0
//		if dw_attach.getitemstatus(ll_modified, 0, primary!) = newmodified! then
//			ll_attach_seq = dw_attach.getitemnumber(ll_modified, 'attach_seq')
//			ls_server_path = dw_attach.getitemstring(ll_modified, 'server_path')
//			
//			li_file_num = fileopen(ls_server_path, StreamMode!, Read!, LockRead!)
//			if li_file_num <= 0 then
//				rollback using sqlca;
//				messagebox('알림3', '첨부파일을 찾을 수 없습니다!~r~n' + ls_server_path)
//				return
//			end if
//			
//			filereadex(li_file_num, lb_file_content)
//			fileclose(li_file_num)
//			
//			updateblob	pf_docu_attach
//			set			file_content = :lb_file_content
//			where	sys_id = :gnv_session.is_sys_id
//			and		board_no = :is_board_no
//			and		docu_no = :ls_docu_no
//			and		attach_seq = :ll_attach_seq;
//			
//			if sqlca.sqlcode <> 0 then
//				ls_errmsg = sqlca.sqlerrtext
//				rollback using sqlca;
//				messagebox('알림4', '자료 저장 실패했습니다!!~r~n' + ls_errmsg)
//				return
//			end if
//		end if
//		
//		ll_modified = dw_attach.getnextmodified(ll_modified, primary!)
//	loop
//else
//	rollback using sqlca;
//	messagebox('알림5', '자료 저장 실패했습니다!!~r~n' + dw_attach.istr_dberror.sqlerrtext)
//	return
//end if
//
//if dw_detail.getitemstatus(1, 0, primary!) = newmodified! then
//	dw_list.insertrow(1)
//	dw_list.setitem(1, 'sys_id', dw_detail.getitemstring(1, 'sys_id'))
//	dw_list.setitem(1, 'board_no', dw_detail.getitemstring(1, 'board_no'))
//	dw_list.setitem(1, 'docu_no', dw_detail.getitemstring(1, 'docu_no'))
//	dw_list.setitem(1, 'start_dtm', dw_detail.getitemdatetime(1, 'start_dtm'))
//	dw_list.setitem(1, 'end_dtm', dw_detail.getitemdatetime(1, 'end_dtm'))
//	dw_list.setitem(1, 'docu_title', dw_detail.getitemstring(1, 'docu_title'))
//	dw_list.setitem(1, 'memb_type', dw_detail.getitemstring(1, 'memb_type'))
//	dw_list.setitem(1, 'hold_yn', dw_detail.getitemstring(1, 'hold_yn'))
//	dw_list.setitem(1, 'writer_name', dw_detail.getitemstring(1, 'writer_name'))
//	dw_list.setitem(1, 'linked_menu_id', dw_detail.getitemstring(1, 'linked_menu_id'))
//	dw_list.scrolltorow(1)
//	dw_list.setrow(1)
//	dw_list.selectrow(0, false)
//	dw_list.selectrow(1, true)
//end if
//
//dw_detail.resetupdate()
//dw_attach.resetupdate()
//commit using sqlca;
//of_setmessage("자료 저장 완료!!")
//return
//
end event

type p_close from pf_u_imagebutton within pf_w_table_comment_ora
integer x = 4315
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)

end event

type dw_list from pf_u_datawindow within pf_w_table_comment_ora
integer x = 50
integer y = 332
integer width = 1600
integer height = 1888
integer taborder = 20
boolean bringtotop = true
string dataobject = "pf_d_table_comment_ora_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean datawindowaction = true
string retrievalarguments = "as_owner=dw_cond.owner; as_table_name=dw_cond.table_name+~'%~';"
boolean scaletobottom = true
end type

type dw_detail from pf_u_datawindow within pf_w_table_comment_ora
integer x = 1669
integer y = 332
integer width = 2880
integer height = 1888
integer taborder = 30
boolean bringtotop = true
string dataobject = "pf_d_table_comment_ora_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean datawindowaction = true
string uplinkeddatawindow = "dw_list"
string retrievalarguments = "as_owner=dw_list.owner; as_table_name=dw_list.table_name"
boolean scaletoright = true
boolean scaletobottom = true
end type

type st_vertical from pf_u_splitbar_vertical within pf_w_table_comment_ora
integer x = 1650
integer y = 332
integer height = 1892
boolean bringtotop = true
string leftdragobject = "dw_list"
string rightdragobject = "dw_detail"
end type

