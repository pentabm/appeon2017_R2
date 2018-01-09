$PBExportHeader$pf_w_board_doc_check.srw
$PBExportComments$게시물 조회 내역 확인 프로그램 입니다.
forward
global type pf_w_board_doc_check from pf_w_sheet
end type
type st_1 from statictext within pf_w_board_doc_check
end type
type p_2 from picture within pf_w_board_doc_check
end type
type dw_list from pf_u_datawindow within pf_w_board_doc_check
end type
type p_add from pf_u_imagebutton within pf_w_board_doc_check
end type
type p_save from pf_u_imagebutton within pf_w_board_doc_check
end type
type p_delete from pf_u_imagebutton within pf_w_board_doc_check
end type
type p_close from pf_u_imagebutton within pf_w_board_doc_check
end type
type dw_cond from pf_u_datawindow within pf_w_board_doc_check
end type
type st_2 from statictext within pf_w_board_doc_check
end type
type p_1 from picture within pf_w_board_doc_check
end type
type p_retrieve from pf_u_imagebutton within pf_w_board_doc_check
end type
type tab_1 from tab within pf_w_board_doc_check
end type
type tabpage_1 from userobject within tab_1
end type
type dw_viewer from pf_u_datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_viewer dw_viewer
end type
type tabpage_2 from userobject within tab_1
end type
type dw_notread from pf_u_datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_notread dw_notread
end type
type tab_1 from tab within pf_w_board_doc_check
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_1 from pf_u_tab within pf_w_board_doc_check
end type
end forward

global type pf_w_board_doc_check from pf_w_sheet
st_1 st_1
p_2 p_2
dw_list dw_list
p_add p_add
p_save p_save
p_delete p_delete
p_close p_close
dw_cond dw_cond
st_2 st_2
p_1 p_1
p_retrieve p_retrieve
tab_1 tab_1
uo_1 uo_1
end type
global pf_w_board_doc_check pf_w_board_doc_check

type variables
datastore ids_board_mst
string is_board_no

end variables

on pf_w_board_doc_check.create
int iCurrent
call super::create
this.st_1=create st_1
this.p_2=create p_2
this.dw_list=create dw_list
this.p_add=create p_add
this.p_save=create p_save
this.p_delete=create p_delete
this.p_close=create p_close
this.dw_cond=create dw_cond
this.st_2=create st_2
this.p_1=create p_1
this.p_retrieve=create p_retrieve
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_2
this.Control[iCurrent+3]=this.dw_list
this.Control[iCurrent+4]=this.p_add
this.Control[iCurrent+5]=this.p_save
this.Control[iCurrent+6]=this.p_delete
this.Control[iCurrent+7]=this.p_close
this.Control[iCurrent+8]=this.dw_cond
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.p_1
this.Control[iCurrent+11]=this.p_retrieve
this.Control[iCurrent+12]=this.tab_1
this.Control[iCurrent+13]=this.uo_1
end on

on pf_w_board_doc_check.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_2)
destroy(this.dw_list)
destroy(this.p_add)
destroy(this.p_save)
destroy(this.p_delete)
destroy(this.p_close)
destroy(this.dw_cond)
destroy(this.st_2)
destroy(this.p_1)
destroy(this.p_retrieve)
destroy(this.tab_1)
destroy(this.uo_1)
end on

event open;call super::open;dw_list.settransobject(sqlca)
tab_1.tabpage_1.dw_viewer.settransobject(sqlca)

ids_board_mst = create datastore
ids_board_mst.dataobject = 'pf_d_board_doc_ent_05'
ids_board_mst.settransobject(sqlca)

end event

event pfe_postopen;call super::pfe_postopen;date ld_now, ld_from

// DDDW 설정
datawindowchild ldwc_1

dw_cond.getchild('board_no', ldwc_1)
ldwc_1.settransobject(sqlca)
if ldwc_1.retrieve(gnv_session.is_sys_id) > 0 then
	is_board_no = ldwc_1.getitemstring(1, 'board_no')
	dw_cond.setitem(1, 'board_no', is_board_no)
end if
dw_cond.insertrow(0)

//if dw_detail.getchild('role_no', ldwc_1) = 1 then
//	ldwc_1.settransobject(sqlca)
//	ldwc_1.retrieve(gnv_session.is_sys_id)
//end if

// 게시 시작일, 종료일 설정
ld_now = date(pf_f_getdbmsdatetime())
ld_from = relativedate(ld_now, -90)

dw_cond.setitem(1, 'from_dt', ld_from)
dw_cond.setitem(1, 'to_dt', ld_now)

// ???
//rte_content.picturesasframe = false

// 내용 조회
p_retrieve.post event clicked()

end event

event close;call super::close;destroy ids_board_mst

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_board_doc_check
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_board_doc_check
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_board_doc_check
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_board_doc_check
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_board_doc_check
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_board_doc_check
end type

type st_1 from statictext within pf_w_board_doc_check
integer x = 123
integer y = 380
integer width = 517
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
string text = "공지사항 리스트"
boolean focusrectangle = false
end type

type p_2 from picture within pf_w_board_doc_check
integer x = 64
integer y = 384
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type dw_list from pf_u_datawindow within pf_w_board_doc_check
integer x = 50
integer y = 440
integer width = 1573
integer height = 1780
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_board_doc_check_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean scaletobottom = true
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_sys_id, ls_board_no, ls_memb_type
long ll_docu_no

// 공지사항 열람자 조회
if currentrow = 0 then
	tab_1.tabpage_1.dw_viewer.reset()
	return
end if

ls_sys_id = this.getitemstring(currentrow, 'sys_id')
ls_board_no = this.getitemstring(currentrow, 'board_no')
ll_docu_no = this.getitemnumber(currentrow, 'docu_no')
ls_memb_type = this.getitemstring(currentrow, 'memb_type')

tab_1.tabpage_1.dw_viewer.retrieve(ls_sys_id, ls_board_no, ll_docu_no)

// 공지사항 미 열람자 조회
datawindow ldw_notread
string ls_select
string ls_innerselect
long ll_cat_cnt, ll_memb_cnt, i, j
string ls_inclause, ls_item, ls_role_no

ldw_notread = tab_1.tabpage_2.dw_notread

string ls_dbms, ls_operator

ls_dbms = sqlca.dbms
choose case upper(left(ls_dbms, 3))
	// ASE, ASA
	case 'ASE', 'SYC', 'ODB'
		ls_operator = ' except '
	// Oracle
	case 'O80', 'O90', 'O10', 'ORA'
		ls_operator = ' minus '
	// SQLServer
	case 'ADO', 'OLE', 'SNC'
		ls_operator = ' except '
	case else
		return -1
end choose

// 
ls_select = "select s02.user_id, s02.user_name "

// 전체 조회인 경우 쿼리 생성
if isnull(ls_memb_type) or len(ls_memb_type) = 0 or ls_memb_type = 'all' then
	ls_innerselect = "select user_id from pf_user_mst " + ls_operator + "  select distinct read_user as user_id from pf_docu_log where sys_id = '" + ls_sys_id + "' and board_no = '" + ls_board_no + "' and docu_no = " + string(ll_docu_no)
// 부분 조회인 경우 쿼리 생성
else
	ls_role_no = this.getitemstring(currentrow, 'role_no')
	
	datastore lds_role_memb
	lds_role_memb = create datastore
	lds_role_memb.dataobject = 'pf_dddw_role_memb'
	lds_role_memb.settransobject(sqlca)
	ll_memb_cnt = lds_role_memb.retrieve(ls_sys_id, ls_role_no)
	
	datastore lds_role_cat
	lds_role_cat = create datastore
	lds_role_cat.dataobject = 'pf_d_role_cat_mst_01'
	lds_role_cat.settransobject(sqlca)
	ll_cat_cnt = lds_role_cat.retrieve(gnv_session.is_sys_id)
	
	ls_inclause = ''
	for i = 1 to ll_cat_cnt
		for j = 1 to ll_memb_cnt
			ls_item = lds_role_memb.getitemstring(j, 'memb_code' + string(i))
			if isnull(ls_item) or len(trim(ls_item)) > 0 then
				if len(ls_inclause) > 0 then ls_inclause += ","
				ls_inclause += "'" + ls_item + "'"
			end if
		next
		
		if len(ls_inclause) > 0 then
			if len(ls_innerselect) > 0 then ls_innerselect += ' union '
			ls_innerselect = "select user_id from pf_user_mst where " + lds_role_cat.getitemstring(i, 'emp_tbl_col') + " in ( " + ls_inclause + " )"
		end if
	next
	
	if len(ls_innerselect) > 0 then
		ls_innerselect += ls_operator + " select distinct read_user as user_id from pf_docu_log where sys_id = '" + ls_sys_id + "' and board_no = '" + ls_board_no + "' and docu_no = " + string(ll_docu_no)
	end if
end if

string ls_error
ls_select = ls_select + "~r~nfrom ( " + ls_innerselect + " ) s01, pf_user_mst s02 where s01.user_id = s02.user_id"
//::clipboard(ls_select)

ls_error = ldw_notread.modify('DataWindow.Table.Select="' + ls_select + '"')
if len(ls_error) > 0 then
	::clipboard(ls_select)
	messagebox('modify', ls_error)
	return
end if

ldw_notread.retrieve()

end event

type p_add from pf_u_imagebutton within pf_w_board_doc_check
integer x = 3589
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;//long ll_new
//string ls_today
//
//ls_today = pf_f_getsystemdatetime(sqlca.dbms, 'yyyy-mm-dd hh:mm:ss')
//
//dw_detail.reset()
//ll_new = dw_detail.insertrow(0)
//dw_detail.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
//dw_detail.setitem(ll_new, 'board_no', is_board_no)
//dw_detail.setitem(ll_new, 'writer_name', gnv_session.of_getstring("user_name"))
//dw_detail.setitem(ll_new, 'start_dtm', datetime(date(left(ls_today,10)), time(right(ls_today, 8))))
//dw_detail.setitem(ll_new, 'memb_type', 'all')
//dw_detail.setitem(ll_new, 'hold_yn', 'N')
//dw_detail.setitemstatus(ll_new, 0, primary!, notmodified!)
//
//dw_detail.setcolumn('docu_title')
//dw_detail.setfocus()
//
//rte_content.clearall()
//rte_content.modified = false
//
//dw_attach.reset()
//
end event

type p_save from pf_u_imagebutton within pf_w_board_doc_check
integer x = 4073
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;//if dw_detail.accepttext() = -1 then return
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

type p_delete from pf_u_imagebutton within pf_w_board_doc_check
integer x = 3831
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long	ll_row
string	ls_docu_title
long ll_docu_no
string	ls_errtext

ll_row = dw_list.getrow()
if ll_row > 0 then
	ll_docu_no = dw_list.getitemnumber(ll_row, 'docu_no')
	ls_docu_title = dw_list.getitemstring(ll_row, 'docu_title')
	if messagebox('알림', '선택하신 ' + ls_docu_title + '[' + string(ll_docu_no) + '] 게시물을 삭제하시겠습니까?', Exclamation!, YesNo!, 2) = 1 then
		dw_list.deleterow(ll_row)
		if dw_list.update() = 1 then
			commit using sqlca;
			parent.of_setmessage('삭제 완료')
			dw_list.post event rowfocuschanged(dw_list.getrow())
		else
			ls_errtext = sqlca.sqlerrtext
			rollback using sqlca;
			messagebox('알림', 'Role 정보 삭제 실패!!~r~n' + 'Error Text: ' + ls_errtext)
			return
		end if
	end if
end if

end event

type p_close from pf_u_imagebutton within pf_w_board_doc_check
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

type dw_cond from pf_u_datawindow within pf_w_board_doc_check
integer x = 50
integer y = 140
integer width = 4498
integer height = 220
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_board_doc_check_01"
boolean livescroll = false
boolean issearchcondition = true
boolean scaletoright = true
end type

event itemchanged;call super::itemchanged;string ls_log_yn

choose case string(dwo.name)
	case 'board_no'
		is_board_no = data
		if ids_board_mst.retrieve(gnv_session.is_sys_id, is_board_no) > 0 then
			ls_log_yn = ids_board_mst.getitemstring(1, 'make_log_yn')
			if isnull(ls_log_yn) then ls_log_yn = 'N'
			if ls_log_yn <> 'Y' then
				messagebox('알림', '선택하신 게시판(Board)은 로그생성을 하지않기 때문에 조회자를 확인할 수 없습니다')
				return
			end if
		end if
end choose

return 0

end event

type st_2 from statictext within pf_w_board_doc_check
integer x = 1705
integer y = 380
integer width = 517
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
string text = "공지사항 조회내역"
boolean focusrectangle = false
end type

type p_1 from picture within pf_w_board_doc_check
integer x = 1646
integer y = 384
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type p_retrieve from pf_u_imagebutton within pf_w_board_doc_check
integer x = 3346
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_retrieve.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;datetime	ld_from_dt, ld_to_dt
string ls_writer_name, ls_docu_title

if dw_cond.accepttext() = -1 then return

ld_from_dt = datetime(dw_cond.getitemdate(1, 'from_dt'), time('00:00:00'))
ld_to_dt = datetime(dw_cond.getitemdate(1, 'to_dt'), time('23:59:59'))
ls_writer_name = dw_cond.getitemstring(1, 'writer_name')
ls_docu_title = dw_cond.getitemstring(1, 'docu_title')

if isnull(ls_writer_name) or len(ls_writer_name) = 0 then 
	ls_writer_name = '%'
else
	ls_writer_name = '%' + ls_writer_name + '%'
end if
	
if isnull(ls_docu_title) or len(ls_docu_title) = 0 then 
	ls_docu_title = '%'
else
	ls_docu_title = '%' + ls_docu_title + '%'
end if

dw_list.reset()
dw_list.retrieve(gnv_session.is_sys_id, is_board_no, ld_from_dt, ld_to_dt, ls_writer_name, ls_docu_title)

end event

type tab_1 from tab within pf_w_board_doc_check
event create ( )
event destroy ( )
integer x = 1646
integer y = 440
integer width = 2903
integer height = 1780
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2866
integer height = 1652
string text = "열람자"
long tabtextcolor = 20132659
long tabbackcolor = 1073741824
string picturename = "Database!"
long picturemaskcolor = 536870912
dw_viewer dw_viewer
end type

on tabpage_1.create
this.dw_viewer=create dw_viewer
this.Control[]={this.dw_viewer}
end on

on tabpage_1.destroy
destroy(this.dw_viewer)
end on

type dw_viewer from pf_u_datawindow within tabpage_1
integer x = 18
integer y = 20
integer width = 2830
integer height = 1616
integer taborder = 20
string dataobject = "pf_d_board_doc_check_03"
boolean scaletoright = true
boolean scaletobottom = true
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2866
integer height = 1652
string text = "미열람자"
long tabtextcolor = 20132659
long tabbackcolor = 1073741824
string picturename = "Close!"
long picturemaskcolor = 12632256
dw_notread dw_notread
end type

on tabpage_2.create
this.dw_notread=create dw_notread
this.Control[]={this.dw_notread}
end on

on tabpage_2.destroy
destroy(this.dw_notread)
end on

type dw_notread from pf_u_datawindow within tabpage_2
integer x = 18
integer y = 20
integer width = 2830
integer height = 1616
integer taborder = 20
string dataobject = "pf_d_board_doc_check_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean scaletoright = true
boolean scaletobottom = true
end type

type uo_1 from pf_u_tab within pf_w_board_doc_check
integer x = 101
integer y = 12
integer taborder = 30
boolean bringtotop = true
boolean scaletoright = true
boolean scaletobottom = true
string referencedtab = "tab_1"
end type

on uo_1.destroy
call pf_u_tab::destroy
end on

