$PBExportHeader$pf_w_database_info_ora.srw
$PBExportComments$데이터베이스 정보 조회
forward
global type pf_w_database_info_ora from pf_w_sheet
end type
type dw_list from pf_u_datawindow within pf_w_database_info_ora
end type
type p_add from pf_u_imagebutton within pf_w_database_info_ora
end type
type p_save from pf_u_imagebutton within pf_w_database_info_ora
end type
type p_delete from pf_u_imagebutton within pf_w_database_info_ora
end type
type p_close from pf_u_imagebutton within pf_w_database_info_ora
end type
type dw_cond from pf_u_datawindow within pf_w_database_info_ora
end type
type p_retrieve from pf_u_imagebutton within pf_w_database_info_ora
end type
type dw_table from pf_u_datawindow within pf_w_database_info_ora
end type
type uo_editor from multilineedit within pf_w_database_info_ora
end type
end forward

global type pf_w_database_info_ora from pf_w_sheet
boolean confirmupdateonclose = false
dw_list dw_list
p_add p_add
p_save p_save
p_delete p_delete
p_close p_close
dw_cond dw_cond
p_retrieve p_retrieve
dw_table dw_table
uo_editor uo_editor
end type
global pf_w_database_info_ora pf_w_database_info_ora

type variables
transaction itr_ora
datastore ids_source

end variables

on pf_w_database_info_ora.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.p_add=create p_add
this.p_save=create p_save
this.p_delete=create p_delete
this.p_close=create p_close
this.dw_cond=create dw_cond
this.p_retrieve=create p_retrieve
this.dw_table=create dw_table
this.uo_editor=create uo_editor
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.p_add
this.Control[iCurrent+3]=this.p_save
this.Control[iCurrent+4]=this.p_delete
this.Control[iCurrent+5]=this.p_close
this.Control[iCurrent+6]=this.dw_cond
this.Control[iCurrent+7]=this.p_retrieve
this.Control[iCurrent+8]=this.dw_table
this.Control[iCurrent+9]=this.uo_editor
end on

on pf_w_database_info_ora.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.p_add)
destroy(this.p_save)
destroy(this.p_delete)
destroy(this.p_close)
destroy(this.dw_cond)
destroy(this.p_retrieve)
destroy(this.dw_table)
destroy(this.uo_editor)
end on

event open;call super::open;// Oracle에 파워프레임 테이블 추가하기 전까지 임시로 사용
itr_ora = create transaction

itr_ora.DBMS = "O10 Oracle10g (10.1.0)"
itr_ora.LogPass = "erp00"
itr_ora.ServerName = "ORAERP01"
itr_ora.LogId = "erpdev"
itr_ora.AutoCommit = False
itr_ora.DBParm = "PBCatalogOwner='erpdev'"

connect using itr_ora;
if itr_ora.sqlcode <> 0 then 
	messagebox('알림', 'DATABASER 연결 실패!!~r~n' + itr_ora.sqlerrtext)
	return
end if

// Scintilla Editor 초기화
string ls_FaceName
boolean lb_Bold, lb_Italic
integer li_TextSize, li_TabWidth

// restore font properties
ls_FaceName = "Fixedsys"
lb_Bold = false
lb_Italic = false
li_TextSize = 9
li_TabWidth = 3

//// apply settings
//uo_editor.of_SetFont(ls_FaceName)
//uo_editor.of_SetFontBold(lb_Bold)
//uo_editor.of_SetFontItalic(lb_Italic)
//uo_editor.of_SetFontSize(li_TextSize)
//uo_editor.of_SetTabWidth(li_TabWidth)
////uo_editor.of_SetReadOnly(true)
//uo_editor.of_ShowLineNumbers(true)

//// set margin & folding colors
//uo_editor.of_SetMarginTextColor(uo_editor.of_Color("Navy"))
//uo_editor.of_SetMarginBackColor(uo_editor.of_GetSysColor(15))
//uo_editor.of_SetFoldLineColor(uo_editor.of_Color("Gray"))
//uo_editor.of_SetFoldMarkerColor(uo_editor.of_Color("Gray"))
//uo_editor.of_set_sql()

// source 조회용 datastore
ids_source = create datastore
ids_source.settransobject(itr_ora)

dw_cond.settransobject(itr_ora)
dw_list.settransobject(itr_ora)
dw_table.settransobject(itr_ora)

end event

event close;call super::close;disconnect using itr_ora;
destroy itr_ora
destroy ids_source

end event

event pfe_postopen;call super::pfe_postopen;dw_cond.insertrow(0)

end event

event resize;call super::resize;uo_editor.x = dw_table.x
uo_editor.y = dw_table.y

uo_editor.width = dw_table.width
uo_editor.height = dw_table.height

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_database_info_ora
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_database_info_ora
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_database_info_ora
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_database_info_ora
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_database_info_ora
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_database_info_ora
end type

type dw_list from pf_u_datawindow within pf_w_database_info_ora
integer x = 50
integer y = 308
integer width = 1495
integer height = 1912
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_database_info_ora_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean scaletobottom = true
end type

event rowfocuschanged;call super::rowfocuschanged;// 오브젝트 타입별로 내용 조회

string ls_object_type
string ls_object_name
string ls_owner
string ls_source
long ll_row, ll_rowcnt

if currentrow = 0 then return

ls_object_type = this.getitemstring(currentrow, 'object_type')
choose case ls_object_type
	case 'TABLE'
		dw_table.visible = true
		uo_editor.visible = false
		
		dw_table.dataobject = 'pf_d_database_info_ora_03'
		dw_table.settransobject(itr_ora)
		dw_table.event pfe_dataobjectchanged()
		ls_owner = upper(this.getitemstring(currentrow, 'owner'))
		ls_object_name = upper(this.getitemstring(currentrow, 'object_name'))
		dw_table.retrieve(ls_owner, ls_object_name)
	case 'TYPE BODY', 'PROCEDURE', 'LIBRARY', 'TRIGGER', 'JAVA SOURCE', 'PACKAGE', 'TYPE', 'FUNCTION', 'PACKAGE BODY'
		uo_editor.visible = true
		dw_table.visible = false
		
		ls_owner = upper(this.getitemstring(currentrow, 'owner'))
		ls_object_name = upper(this.getitemstring(currentrow, 'object_name'))
		ids_source.dataobject = 'pf_d_database_info_ora_04'
		ids_source.settransobject(itr_ora)
		
		ll_rowcnt = ids_source.retrieve(ls_owner, ls_object_name)
		for ll_row = 1 to ll_rowcnt
			ls_source += ids_source.getitemstring(ll_row, 'text')
		next
		
//		uo_editor.of_SetReadOnly(false)
//		uo_editor.of_settext(ls_source)
//		uo_editor.of_SetReadOnly(true)
	case 'VIEW'
		uo_editor.visible = true
		dw_table.visible = false
		
		ls_owner = upper(this.getitemstring(currentrow, 'owner'))
		ls_object_name = upper(this.getitemstring(currentrow, 'object_name'))
		ids_source.dataobject = 'pf_d_database_info_ora_05'
		ids_source.settransobject(itr_ora)
		
		ll_rowcnt = ids_source.retrieve(ls_owner, ls_object_name)
		for ll_row = 1 to ll_rowcnt
			ls_source += ids_source.getitemstring(ll_row, 'text')
		next
		
//		uo_editor.of_SetReadOnly(false)
//		uo_editor.of_settext(ls_source)
//		uo_editor.of_SetReadOnly(true)
	case 'INDEX'
		dw_table.visible = true
		uo_editor.visible = false
		
		dw_table.dataobject = 'pf_d_database_info_ora_06'
		dw_table.settransobject(itr_ora)
		dw_table.event pfe_dataobjectchanged()
		ls_owner = upper(this.getitemstring(currentrow, 'owner'))
		ls_object_name = upper(this.getitemstring(currentrow, 'object_name'))
		dw_table.retrieve(ls_owner, ls_object_name)
end choose

end event

type p_add from pf_u_imagebutton within pf_w_database_info_ora
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

type p_save from pf_u_imagebutton within pf_w_database_info_ora
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

type p_delete from pf_u_imagebutton within pf_w_database_info_ora
integer x = 3831
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long	ll_row
string	ls_docu_no, ls_docu_title
string	ls_errtext

ll_row = dw_list.getrow()
if ll_row > 0 then
	ls_docu_no = dw_list.getitemstring(ll_row, 'docu_no')
	ls_docu_title = dw_list.getitemstring(ll_row, 'docu_title')
	if messagebox('알림', '선택하신 ' + ls_docu_title + '[' + ls_docu_no + '] 게시물을 삭제하시겠습니까?', Exclamation!, YesNo!, 2) = 1 then
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

type p_close from pf_u_imagebutton within pf_w_database_info_ora
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

type dw_cond from pf_u_datawindow within pf_w_database_info_ora
integer x = 50
integer y = 140
integer width = 4498
integer height = 152
integer taborder = 20
boolean bringtotop = true
string dataobject = "pf_d_database_info_ora_01"
boolean livescroll = false
boolean sorting = false
boolean issearchcondition = true
boolean scaletoright = true
end type

type p_retrieve from pf_u_imagebutton within pf_w_database_info_ora
integer x = 3346
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_retrieve.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;string ls_owner, ls_object_type, ls_object_name
long ll_rowcnt

if dw_cond.accepttext() = -1 then return

ls_owner = dw_cond.getitemstring(1, 'owner')
ls_object_type = dw_cond.getitemstring(1, 'object_type')
ls_object_name = dw_cond.getitemstring(1, 'object_name')

if pf_f_isemptystring(ls_owner) then
	ls_owner = '%'
end if

if pf_f_isemptystring(ls_object_type) then
	ls_object_type = '%'
end if

if pf_f_isemptystring(ls_object_name) then
	ls_object_name = '%'
else
	ls_object_name = '%' + ls_object_name + '%'
end if

dw_list.reset()
ll_rowcnt = dw_list.retrieve(ls_owner, ls_object_type, ls_object_name)
of_setmessage('[' + string(ll_rowcnt, '#,##0') + ']건의 자료가 조회되었습니다')

end event

type dw_table from pf_u_datawindow within pf_w_database_info_ora
integer x = 1563
integer y = 308
integer width = 2985
integer height = 1912
integer taborder = 30
boolean bringtotop = true
string dataobject = "pf_d_database_info_ora_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean scaletoright = true
boolean scaletobottom = true
end type

type uo_editor from multilineedit within pf_w_database_info_ora
integer x = 1623
integer y = 360
integer width = 2880
integer height = 1768
integer taborder = 40
boolean bringtotop = true
borderstyle borderstyle = stylebox!
end type

