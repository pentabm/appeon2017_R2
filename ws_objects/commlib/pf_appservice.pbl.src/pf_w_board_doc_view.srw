$PBExportHeader$pf_w_board_doc_view.srw
$PBExportComments$게시물 조회 화면 (WebEditor) 입니다.
forward
global type pf_w_board_doc_view from pf_w_response
end type
type uo_viewer from pf_u_webeditor within pf_w_board_doc_view
end type
type p_close from pf_u_imagebutton within pf_w_board_doc_view
end type
type dw_mast from pf_u_datawindow within pf_w_board_doc_view
end type
type dw_attach from pf_u_datawindow within pf_w_board_doc_view
end type
end forward

global type pf_w_board_doc_view from pf_w_response
integer width = 3918
integer height = 3032
string title = "문서보기"
uo_viewer uo_viewer
p_close p_close
dw_mast dw_mast
dw_attach dw_attach
end type
global pf_w_board_doc_view pf_w_board_doc_view

type variables
string is_board_no
long il_docu_no
string is_log_yn

end variables

forward prototypes
public function long of_attachedfileopen (long al_row)
public function integer of_attachedfilesave (long al_row)
public function integer of_inithtml (string as_id)
end prototypes

public function long of_attachedfileopen (long al_row);// 첨부파일 열기
choose case dw_attach.getitemstatus(al_row, 0, primary!)
	case newmodified!, new!
		messagebox('알림', '첨부파일이 아직 업로드 되지 않았습니다')
		return 0
end choose

string ls_file_name, ls_path_name
string ls_board_no
long ll_docu_no
long ll_attach_seq
blob lb_content
integer li_file_num

ls_file_name = dw_attach.getitemstring(al_row, 'org_file_name')
ls_board_no = dw_attach.getitemstring(al_row, 'board_no')
ll_docu_no = dw_attach.getitemnumber(al_row, 'docu_no')
ll_attach_seq = dw_attach.getitemnumber(al_row, 'attach_seq')
ls_path_name = gnv_extfunc.of_getsystemtemppath() + ls_file_name

selectblob file_content
into: lb_content
from pf_docu_attach
where sys_id = :gnv_session.is_sys_id
and board_no = :ls_board_no
and docu_no = :ll_docu_no
and attach_seq = :ll_attach_seq;

li_file_num = fileopen(ls_path_name, StreamMode!, Write!, LockWrite!, Replace!)
if li_file_num <= 0 then
	messagebox('알림', '선택한 파일을 오픈할 수 없습니다')
	return -1
end if

filewriteex(li_file_num, lb_content)
fileclose(li_file_num)

return gnv_extfunc.of_shellexecute(ls_path_name)

end function

public function integer of_attachedfilesave (long al_row);// 첨부파일 저장
choose case dw_attach.getitemstatus(al_row, 0, primary!)
	case newmodified!, new!
		messagebox('알림', '첨부파일이 아직 업로드 되지 않았습니다')
		return 0
end choose

string ls_file_name, ls_path_name
string ls_board_no
long ll_docu_no
long ll_attach_seq
blob lb_content
integer li_file_num

ls_file_name = dw_attach.getitemstring(al_row, 'org_file_name')
ls_board_no = dw_attach.getitemstring(al_row, 'board_no')
ll_docu_no = dw_attach.getitemnumber(al_row, 'docu_no')
ll_attach_seq = dw_attach.getitemnumber(al_row, 'attach_seq')

ls_path_name = ls_file_name
if getfilesavename("첨부파일을 저장할 경로를 설정하세요", ls_path_name, ls_file_name) <= 0 then return 0

selectblob file_content
into: lb_content
from pf_docu_attach
where sys_id = :gnv_session.is_sys_id
and board_no = :ls_board_no
and docu_no = :ll_docu_no
and attach_seq = :ll_attach_seq;

li_file_num = fileopen(ls_path_name, StreamMode!, Write!, LockWrite!, Replace!)
if li_file_num <= 0 then
	messagebox('알림', '선택한 파일을 오픈할 수 없습니다')
	return -1
end if

filewriteex(li_file_num, lb_content)
fileclose(li_file_num)

messagebox('알림', '파일 다운로드 완료')
return 1



end function

public function integer of_inithtml (string as_id);//ole_ie.object.navigate2("http://eas.penta.co.kr/SmartEditor2/ContentsViewer.jsp?id=" + as_id + "&type=webeditor&title=WebEditor")

return 0

end function

on pf_w_board_doc_view.create
int iCurrent
call super::create
this.uo_viewer=create uo_viewer
this.p_close=create p_close
this.dw_mast=create dw_mast
this.dw_attach=create dw_attach
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_viewer
this.Control[iCurrent+2]=this.p_close
this.Control[iCurrent+3]=this.dw_mast
this.Control[iCurrent+4]=this.dw_attach
end on

on pf_w_board_doc_view.destroy
call super::destroy
destroy(this.uo_viewer)
destroy(this.p_close)
destroy(this.dw_mast)
destroy(this.dw_attach)
end on

event open;call super::open;string ls_mesg, ls_parm[]

ls_mesg = message.stringparm
if pf_f_parsetoarray(ls_mesg, '~t', ls_parm) <> 3 then
	messagebox('알림', '잘못된 윈도우 호출입니다')
	post close(this)
	return
end if

is_board_no = ls_parm[1]
il_docu_no = long(ls_parm[2])
is_log_yn = ls_parm[3]

end event

event pfe_postopen;call super::pfe_postopen;dw_mast.settransobject(sqlca)
dw_attach.settransobject(sqlca)

blob lb_content
long ll_read_seq
string ls_errtext
datetime ldtm_now

if dw_mast.retrieve(gnv_session.is_sys_id, is_board_no, il_docu_no) > 0 then
		
	this.of_inithtml(is_board_no + string(il_docu_no))
	
	selectblob	docu_content
	into		:lb_content
	from		pf_docu_mst
	where	sys_id = :gnv_session.is_sys_id
	and		board_no = :is_board_no
	and		docu_no = :il_docu_no
	using		sqlca;
	
	if sqlca.sqlcode = 0 then
		
		uo_viewer.of_navigate(uo_viewer.viewer_url)
		uo_viewer.of_viewcontents(string(lb_content))
		
		if is_log_yn = 'Y' then
			select		max(read_seq)
			into		:ll_read_seq
			from		pf_docu_log
			where	sys_id = :gnv_session.is_sys_id
			and		board_no = :is_board_no
			and		docu_no = :il_docu_no
			using		sqlca;
			
			if isnull(ll_read_seq) then ll_read_seq = 0
			ll_read_seq += 1
			
			ldtm_now = pf_f_getdbmsdatetime()
			
			insert into pf_docu_log  ( sys_id, board_no, docu_no, read_seq, read_user, read_dtm )
			values ( :gnv_session.is_sys_id, :is_board_no, :il_docu_no, :ll_read_seq, :gnv_session.is_user_id, :ldtm_now )
			using sqlca;
			
			if sqlca.sqlcode = 0 then
				commit using sqlca;
			else
				ls_errtext = sqlca.sqlerrtext
				rollback using sqlca;
				messagebox('알림', '게시글 로그 생성 오류~r~n' + ls_errtext)
				return
			end if
		end if
	else
		messagebox('알림', '게시글 읽기 실패!')
		return
	end if
end if

dw_attach.retrieve(gnv_session.is_sys_id, is_board_no, il_docu_no)

end event

type uo_viewer from pf_u_webeditor within pf_w_board_doc_view
event destroy ( )
integer x = 50
integer y = 376
integer width = 3826
integer height = 2268
integer taborder = 20
boolean scaletoright = true
boolean scaletobottom = true
end type

on uo_viewer.destroy
call pf_u_webeditor::destroy
end on

type p_close from pf_u_imagebutton within pf_w_board_doc_view
integer x = 3643
integer y = 24
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
end type

event clicked;call super::clicked;close(parent)

end event

type dw_mast from pf_u_datawindow within pf_w_board_doc_view
integer x = 50
integer y = 120
integer width = 3826
integer height = 244
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_board_doc_view_01"
boolean sorting = false
boolean issearchcondition = true
boolean scaletoright = true
end type

type dw_attach from pf_u_datawindow within pf_w_board_doc_view
integer x = 50
integer y = 2652
integer width = 3826
integer height = 288
integer taborder = 30
boolean bringtotop = true
string dataobject = "pf_d_board_doc_view_02"
boolean vscrollbar = true
boolean livescroll = false
boolean sorting = false
boolean fixedtobottom = true
boolean scaletoright = true
end type

event buttonclicked;call super::buttonclicked;choose case string(dwo.name)
	case 'b_open'
		of_attachedfileopen(row)
	case 'b_save'
		of_attachedfilesave(row)
	case 'b_delete'
		if messagebox('알림', '선택한 첨부파일을 삭제하시겠습니까?', Question!, YesNo!, 2) = 1 then
			dw_attach.deleterow(row)
			dw_attach.update()
		end if
end choose

end event

