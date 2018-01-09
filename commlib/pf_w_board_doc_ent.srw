HA$PBExportHeader$pf_w_board_doc_ent.srw
$PBExportComments$$$HEX10$$8cacdcc23cbb2000f1b45db8200054d674ba2000$$ENDHEX$$(WebEditor) $$HEX3$$85c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_board_doc_ent from pf_w_sheet
end type
type st_1 from statictext within pf_w_board_doc_ent
end type
type p_2 from picture within pf_w_board_doc_ent
end type
type dw_list from pf_u_datawindow within pf_w_board_doc_ent
end type
type p_add from pf_u_imagebutton within pf_w_board_doc_ent
end type
type p_save from pf_u_imagebutton within pf_w_board_doc_ent
end type
type p_delete from pf_u_imagebutton within pf_w_board_doc_ent
end type
type p_close from pf_u_imagebutton within pf_w_board_doc_ent
end type
type dw_cond from pf_u_datawindow within pf_w_board_doc_ent
end type
type dw_detail from pf_u_datawindow within pf_w_board_doc_ent
end type
type st_2 from statictext within pf_w_board_doc_ent
end type
type p_1 from picture within pf_w_board_doc_ent
end type
type dw_attach from pf_u_datawindow within pf_w_board_doc_ent
end type
type p_retrieve from pf_u_imagebutton within pf_w_board_doc_ent
end type
type p_attachfile from pf_u_imagebutton within pf_w_board_doc_ent
end type
type uo_editor from pf_u_webeditor within pf_w_board_doc_ent
end type
end forward

global type pf_w_board_doc_ent from pf_w_sheet
st_1 st_1
p_2 p_2
dw_list dw_list
p_add p_add
p_save p_save
p_delete p_delete
p_close p_close
dw_cond dw_cond
dw_detail dw_detail
st_2 st_2
p_1 p_1
dw_attach dw_attach
p_retrieve p_retrieve
p_attachfile p_attachfile
uo_editor uo_editor
end type
global pf_w_board_doc_ent pf_w_board_doc_ent

type variables
constant string UPLOADING_SUBDIR = '/attached'

datastore ids_board_mst
string is_board_no

end variables

forward prototypes
public function long of_attachedfileopen (long al_row)
public function integer of_attachedfilesave (long al_row)
end prototypes

public function long of_attachedfileopen (long al_row);// $$HEX7$$a8cc80bd0cd37cc72000f4c530ae$$ENDHEX$$
choose case dw_attach.getitemstatus(al_row, 0, primary!)
	case newmodified!, new!
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX21$$a8cc80bd0cd37cc774c7200044c5c1c92000c5c55cb8dcb4200018b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$')
		return 0
end choose

string ls_org_filename, ls_mod_filename
string ls_filepath
string ls_board_no
long ll_docu_no
long ll_attach_seq

ls_org_filename = dw_attach.getitemstring(al_row, 'org_file_name')
ls_mod_filename = dw_attach.getitemstring(al_row, 'mod_file_name')
ls_board_no = dw_attach.getitemstring(al_row, 'board_no')
ll_docu_no = dw_attach.getitemnumber(al_row, 'docu_no')
ll_attach_seq = dw_attach.getitemnumber(al_row, 'attach_seq')
ls_filepath = gnv_extfunc.of_getsystemtemppath() + ls_org_filename

//ls_filepath = ls_org_filename
//if getfilesavename("$$HEX19$$a8cc80bd0cd37cc744c7200000c8a5c760d5200004c758ce7cb9200024c115c858d538c194c6$$ENDHEX$$", ls_filepath, ls_filename) <= 0 then return 0

pf_n_httptransfer lnv_http
lnv_http = create pf_n_httptransfer
if lnv_http.of_filedownload(ls_org_filename, UPLOADING_SUBDIR, ls_filepath) < 0 then
	return -1
end if

destroy lnv_http

//selectblob file_content
//into: lb_content
//from pf_docu_attach
//where sys_id = :gnv_session.is_sys_id
//and board_no = :ls_board_no
//and docu_no = :ll_docu_no
//and attach_seq = :ll_attach_seq;
//
//li_file_num = fileopen(ls_path_name, StreamMode!, Write!, LockWrite!, Replace!)
//if li_file_num <= 0 then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX18$$20c1ddd05cd520000cd37cc744c7200024c608d560d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
//	return -1
//end if
//
//filewriteex(li_file_num, lb_content)
//fileclose(li_file_num)

return gnv_extfunc.of_shellexecute(ls_filepath)

end function

public function integer of_attachedfilesave (long al_row);// $$HEX7$$a8cc80bd0cd37cc7200000c8a5c7$$ENDHEX$$
choose case dw_attach.getitemstatus(al_row, 0, primary!)
	case newmodified!, new!
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX21$$a8cc80bd0cd37cc774c7200044c5c1c92000c5c55cb8dcb4200018b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$')
		return 0
end choose

string ls_org_filename, ls_mod_filename
string ls_filepath, ls_filename
string ls_board_no
long ll_docu_no
long ll_attach_seq

ls_org_filename = dw_attach.getitemstring(al_row, 'org_file_name')
ls_mod_filename = dw_attach.getitemstring(al_row, 'mod_file_name')
ls_board_no = dw_attach.getitemstring(al_row, 'board_no')
ll_docu_no = dw_attach.getitemnumber(al_row, 'docu_no')
ll_attach_seq = dw_attach.getitemnumber(al_row, 'attach_seq')

ls_filepath = ls_org_filename
if getfilesavename("$$HEX19$$a8cc80bd0cd37cc744c7200000c8a5c760d5200004c758ce7cb9200024c115c858d538c194c6$$ENDHEX$$", ls_filepath, ls_filename) <= 0 then return 0

pf_n_httptransfer lnv_http
lnv_http = create pf_n_httptransfer
if lnv_http.of_filedownload(ls_mod_filename, UPLOADING_SUBDIR, ls_filepath) < 0 then
	return -1
end if

destroy lnv_http

//selectblob file_content
//into: lb_content
//from pf_docu_attach
//where sys_id = :gnv_session.is_sys_id
//and board_no = :ls_board_no
//and docu_no = :ll_docu_no
//and attach_seq = :ll_attach_seq;

//li_file_num = fileopen(ls_path_name, StreamMode!, Write!, LockWrite!, Replace!)
//if li_file_num <= 0 then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX18$$20c1ddd05cd520000cd37cc744c7200024c608d560d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
//	return -1
//end if
//
//filewriteex(li_file_num, lb_content)
//fileclose(li_file_num)

messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX10$$0cd37cc72000e4b2b4c65cb8dcb4200044c6ccb8$$ENDHEX$$')
return 1

end function

on pf_w_board_doc_ent.create
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
this.dw_detail=create dw_detail
this.st_2=create st_2
this.p_1=create p_1
this.dw_attach=create dw_attach
this.p_retrieve=create p_retrieve
this.p_attachfile=create p_attachfile
this.uo_editor=create uo_editor
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_2
this.Control[iCurrent+3]=this.dw_list
this.Control[iCurrent+4]=this.p_add
this.Control[iCurrent+5]=this.p_save
this.Control[iCurrent+6]=this.p_delete
this.Control[iCurrent+7]=this.p_close
this.Control[iCurrent+8]=this.dw_cond
this.Control[iCurrent+9]=this.dw_detail
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.p_1
this.Control[iCurrent+12]=this.dw_attach
this.Control[iCurrent+13]=this.p_retrieve
this.Control[iCurrent+14]=this.p_attachfile
this.Control[iCurrent+15]=this.uo_editor
end on

on pf_w_board_doc_ent.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_2)
destroy(this.dw_list)
destroy(this.p_add)
destroy(this.p_save)
destroy(this.p_delete)
destroy(this.p_close)
destroy(this.dw_cond)
destroy(this.dw_detail)
destroy(this.st_2)
destroy(this.p_1)
destroy(this.dw_attach)
destroy(this.p_retrieve)
destroy(this.p_attachfile)
destroy(this.uo_editor)
end on

event open;call super::open;dw_list.settransobject(sqlca)
dw_detail.settransobject(sqlca)
dw_attach.settransobject(sqlca)

ids_board_mst = create datastore
ids_board_mst.dataobject = 'pf_d_board_doc_ent_05'
ids_board_mst.settransobject(sqlca)

end event

event close;call super::close;destroy ids_board_mst

end event

event pfe_postopen;call super::pfe_postopen;date ld_now, ld_from

// DDDW $$HEX2$$24c115c8$$ENDHEX$$
datawindowchild ldwc_1

dw_cond.getchild('board_no', ldwc_1)
ldwc_1.settransobject(sqlca)
if ldwc_1.retrieve(gnv_session.is_sys_id) > 0 then
	is_board_no = ldwc_1.getitemstring(1, 'board_no')
	ids_board_mst.retrieve(gnv_session.is_sys_id, is_board_no)
end if
dw_cond.insertrow(0)
dw_cond.setitem(1, 'board_no', is_board_no)

if dw_detail.getchild('role_no', ldwc_1) = 1 then
	ldwc_1.settransobject(sqlca)
	ldwc_1.retrieve(gnv_session.is_sys_id)
	ldwc_1.insertrow(1)
end if

// $$HEX6$$8cacdcc22000dcc291c77cc7$$ENDHEX$$, $$HEX6$$85c8ccb87cc7200024c115c8$$ENDHEX$$
ld_now = date(pf_f_getdbmsdatetime())
ld_from = relativedate(ld_now, -90)

dw_cond.setitem(1, 'from_dt', ld_from)
dw_cond.setitem(1, 'to_dt', ld_now)

// Editor $$HEX6$$98d374c7c0c9200024c608d5$$ENDHEX$$
uo_editor.of_openwebeditor()

// $$HEX5$$b4b0a9c6200070c88cd6$$ENDHEX$$
//this.post event usrevt_view()

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_board_doc_ent
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_board_doc_ent
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_board_doc_ent
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_board_doc_ent
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_board_doc_ent
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_board_doc_ent
end type

type st_1 from statictext within pf_w_board_doc_ent
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
string facename = "$$HEX2$$cbb3c0c6$$ENDHEX$$"
long textcolor = 25123896
long backcolor = 16777215
string text = "$$HEX7$$8cacdcc23cbb2000acb9a4c2b8d2$$ENDHEX$$"
boolean focusrectangle = false
end type

type p_2 from picture within pf_w_board_doc_ent
integer x = 64
integer y = 384
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type dw_list from pf_u_datawindow within pf_w_board_doc_ent
integer x = 50
integer y = 440
integer width = 1577
integer height = 1780
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_board_doc_ent_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean scaletobottom = true
end type

event rowfocuschanged;call super::rowfocuschanged;this.selectrow(0, false)
this.selectrow(currentrow, true)

if currentrow = 0 then
	dw_detail.reset()
	dw_attach.reset()
	return
end if

string ls_sys_id, ls_board_no
long ll_docu_no
blob lb_content

setpointer(hourglass!)
post setpointer(arrow!)

ls_sys_id = this.getitemstring(currentrow, 'sys_id')
ls_board_no = this.getitemstring(currentrow, 'board_no')
ll_docu_no = this.getitemnumber(currentrow, 'docu_no')

uo_editor.of_resetcontents()

if dw_detail.retrieve(ls_sys_id, ls_board_no, ll_docu_no) > 0 then
	selectblob	docu_content
	into		:lb_content
	from		pf_docu_mst
	where	sys_id = :ls_sys_id
	and		board_no = :ls_board_no
	and		docu_no = :ll_docu_no;
	
	uo_editor.of_setcontents(string(lb_content))
end if

dw_attach.retrieve(ls_sys_id, ls_board_no, ll_docu_no)

end event

type p_add from pf_u_imagebutton within pf_w_board_doc_ent
integer x = 3589
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long ll_new
datetime ldtm_today

ldtm_today = pf_f_getdbmsdatetime()

dw_detail.reset()
ll_new = dw_detail.insertrow(0)
dw_detail.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
dw_detail.setitem(ll_new, 'board_no', is_board_no)
dw_detail.setitem(ll_new, 'writer_name', gnv_session.is_user_name)
dw_detail.setitem(ll_new, 'start_dtm', ldtm_today)
dw_detail.setitem(ll_new, 'memb_type', 'all')
dw_detail.setitem(ll_new, 'hold_yn', 'N')
dw_detail.setitemstatus(ll_new, 0, primary!, notmodified!)

dw_detail.setcolumn('docu_title')
dw_detail.setfocus()

uo_editor.post of_resetcontents()
dw_attach.reset()

end event

type p_save from pf_u_imagebutton within pf_w_board_doc_ent
integer x = 4073
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;if dw_detail.accepttext() = -1 then return

//// $$HEX7$$c0bcbdacacc06dd52000b4cc6cd0$$ENDHEX$$
//if rte_content.modified = false and dw_detail.modifiedcount() = 0 and dw_detail.deletedcount() = 0 and &
//	dw_attach.modifiedcount() = 0 and dw_attach.deletedcount() = 0 then
//	return
//end if

// $$HEX9$$44d518c285c725b8acc06dd52000b4cc6cd0$$ENDHEX$$
string ls_writer_name
string ls_docu_title
string ls_contents

ls_writer_name = dw_detail.getitemstring(1, 'writer_name')
if isnull(ls_writer_name) or len(trim(ls_writer_name)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX10$$91c731c190c77cb9200085c725b858d538c194c6$$ENDHEX$$')
	return
end if

ls_docu_title = dw_detail.getitemstring(1, 'docu_title')
if isnull(ls_docu_title) or len(trim(ls_docu_title)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX13$$38bb1cc12000c0d074c7c0d244c7200085c725b858d538c194c6$$ENDHEX$$')
	return
end if

//ls_content = rte_content.copyrtf(false)
//if isnull(ls_content) or len(trim(ls_content)) = 0 then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX12$$38bb1cc12000b4b0a9c644c7200085c725b858d538c194c6$$ENDHEX$$')
//	return
//end if

ls_contents = uo_editor.of_getcontents()
if isnull(ls_contents) or len(trim(ls_contents)) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX12$$38bb1cc12000b4b0a9c644c7200085c725b858d538c194c6$$ENDHEX$$')
	return
end if

// Primary Key $$HEX2$$ddc031c1$$ENDHEX$$
long ll_docu_no
long ll_modified, ll_attach_seq

if dw_detail.getitemstatus(1, 0, primary!) = newmodified! then
	select		max(docu_no)
	into		:ll_docu_no
	from		pf_docu_mst
	where	sys_id = :gnv_session.is_sys_id
	and		board_no = :is_board_no;
	
	if isnull(ll_docu_no) then ll_docu_no = 0
	ll_docu_no = (long(ll_docu_no / 100) + 1) * 100 + 99
	dw_detail.setitem(1, 'docu_no', ll_docu_no)
	dw_detail.setitem(1, 'create_user', gnv_session.is_user_id)
	dw_detail.setitem(1, 'create_dtm', now())
else
	ll_docu_no = dw_detail.getitemnumber(1, 'docu_no')
end if

ll_modified = dw_attach.getnextmodified(0, primary!)
do while ll_modified > 0
	if dw_attach.getitemstatus(ll_modified, 0, primary!) = newmodified! then
		ll_attach_seq = long(dw_attach.describe("Evaluate('Max(attach_seq for all)', 1)"))
		ll_attach_seq += 1
		
		dw_attach.setitem(ll_modified, 'docu_no', ll_docu_no)
		dw_attach.setitem(ll_modified, 'attach_seq', ll_attach_seq)
	end if
	
	ll_modified = dw_attach.getnextmodified(ll_modified, primary!)
loop

// $$HEX2$$00c8a5c7$$ENDHEX$$
string ls_errmsg
blob lb_contents
string ls_server_path

lb_contents = blob(ls_contents)

if dw_detail.update(true, false) = 1 then
	updateblob	pf_docu_mst
	set			docu_content = :lb_contents
	where	sys_id = :gnv_session.is_sys_id
	and		board_no = :is_board_no
	and		docu_no = :ll_docu_no;
	
	if sqlca.sqlcode <> 0 then
		ls_errmsg = sqlca.sqlerrtext
		rollback using sqlca;
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$1', '$$HEX12$$90c7ccb8200000c8a5c72000e4c228d388d5b5c2c8b2e4b2$$ENDHEX$$!!~r~n' + ls_errmsg)
		return
	end if
else
	rollback using sqlca;
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$2', '$$HEX12$$90c7ccb8200000c8a5c72000e4c228d388d5b5c2c8b2e4b2$$ENDHEX$$!!~r~n' + dw_detail.istr_dberror.sqlerrtext)
	return
end if

// $$HEX9$$c5c55cb8dcb4200091c7c5c52000c4d62000$$ENDHEX$$PF_DOCU_ATTACH $$HEX2$$00c8a5c7$$ENDHEX$$
string ls_filestobeuploaded[]
long ll_filecnt

ll_modified = dw_attach.getnextmodified(0, primary!)
do while ll_modified > 0
	if dw_attach.getitemstatus(ll_modified, 0, primary!) = newmodified! then
		ll_attach_seq = dw_attach.getitemnumber(ll_modified, 'attach_seq')
		ls_server_path = dw_attach.getitemstring(ll_modified, 'server_path')

		ll_filecnt += 1
		ls_filestobeuploaded[ll_filecnt] = ls_server_path
	end if
	
	ll_modified = dw_attach.getnextmodified(ll_modified, primary!)
loop

if ll_filecnt > 0 then
	pf_n_httptransfer lnv_http
	lnv_http = create pf_n_httptransfer
	if lnv_http.of_fileupload(ls_filestobeuploaded, UPLOADING_SUBDIR, false) < 0 then
		rollback using sqlca;
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$4.1', '$$HEX12$$90c7ccb8200000c8a5c72000e4c228d388d5b5c2c8b2e4b2$$ENDHEX$$!!~r~n' + '$$HEX10$$a8cc80bd0cd37cc7200004c8a1c1200024c658b9$$ENDHEX$$')
		destroy lnv_http
		return
	end if
	
	destroy lnv_http
end if

ll_filecnt = 0
ll_modified = dw_attach.getnextmodified(0, primary!)
do while ll_modified > 0
	if dw_attach.getitemstatus(ll_modified, 0, primary!) = newmodified! then
		ll_filecnt ++
		
		dw_attach.setitem(ll_modified, 'mod_file_name', ls_filestobeuploaded[ll_filecnt])
		dw_attach.setitem(ll_modified, 'server_path', UPLOADING_SUBDIR)
		dw_attach.setitem(ll_modified, 'create_dtm', pf_f_getdbmsdatetime())
		dw_attach.setitem(ll_modified, 'create_user', gnv_session.is_user_id)
	end if
	
	ll_modified = dw_attach.getnextmodified(ll_modified, primary!)
loop

if dw_attach.update(true, false) = -1 then
	rollback using sqlca;
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$5', '$$HEX12$$90c7ccb8200000c8a5c72000e4c228d388d5b5c2c8b2e4b2$$ENDHEX$$!!~r~n' + dw_attach.istr_dberror.sqlerrtext)
	return
end if

if dw_detail.getitemstatus(1, 0, primary!) = newmodified! then
	
	dw_detail.RowsCopy(1, 1, Primary!, dw_list, 1, Primary!)
	
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
end if

//choose case dw_detail.getitemstatus(1, 0, primary!)
//	case newmodified!
//		ll_row = dw_list.insertrow(1)
//		//dw_list.scrolltorow(ll_row)
//		//dw_list.setrow(ll_row)
//		//dw_list.selectrow(0, false)
//		//dw_list.selectrow(ll_row, true)
//	case datamodified!
//		ll_row = dw_list.getrow()
//end choose
//
//messagebox('dw_detail.rowcount()', dw_detail.rowcount())
//
//dw_list.setitem(ll_row, 'sys_id', dw_detail.getitemstring(1, 'sys_id'))
//dw_list.setitem(ll_row, 'board_no', dw_detail.getitemstring(1, 'board_no'))
//dw_list.setitem(ll_row, 'docu_no', dw_detail.getitemnumber(1, 'docu_no'))
//dw_list.setitem(ll_row, 'start_dtm', dw_detail.getitemdatetime(1, 'start_dtm'))
//dw_list.setitem(ll_row, 'end_dtm', dw_detail.getitemdatetime(1, 'end_dtm'))
//dw_list.setitem(ll_row, 'docu_title', dw_detail.getitemstring(1, 'docu_title'))
//dw_list.setitem(ll_row, 'memb_type', dw_detail.getitemstring(1, 'memb_type'))
//dw_list.setitem(ll_row, 'hold_yn', dw_detail.getitemstring(1, 'hold_yn'))
//dw_list.setitem(ll_row, 'writer_name', dw_detail.getitemstring(1, 'writer_name'))
//dw_list.setitem(ll_row, 'linked_menu_id', dw_detail.getitemstring(1, 'linked_menu_id'))

dw_detail.resetupdate()
dw_attach.resetupdate()
commit using sqlca;
of_setmessage("$$HEX8$$90c7ccb8200000c8a5c7200044c6ccb8$$ENDHEX$$!!")
return

end event

type p_delete from pf_u_imagebutton within pf_w_board_doc_ent
integer x = 3831
integer y = 40
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long	ll_row
long ll_docu_no
string	ls_docu_title
string	ls_errtext

ll_row = dw_list.getrow()
if ll_row > 0 then
	ll_docu_no = dw_list.getitemnumber(ll_row, 'docu_no')
	ls_docu_title = dw_list.getitemstring(ll_row, 'docu_title')
	if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX5$$20c1ddd058d5e0c22000$$ENDHEX$$' + ls_docu_title + '[' + string(ll_docu_no) + '] $$HEX13$$8cacdcc23cbb44c72000adc01cc858d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Exclamation!, YesNo!, 2) = 1 then
		dw_list.deleterow(ll_row)
		if dw_list.update() = 1 then
			commit using sqlca;
			parent.of_setmessage('$$HEX5$$adc01cc8200044c6ccb8$$ENDHEX$$')
			dw_list.post event rowfocuschanged(dw_list.getrow())
		else
			ls_errtext = sqlca.sqlerrtext
			rollback using sqlca;
			messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'Role $$HEX8$$15c8f4bc2000adc01cc82000e4c228d3$$ENDHEX$$!!~r~n' + 'Error Text: ' + ls_errtext)
			return
		end if
	end if
end if

end event

type p_close from pf_u_imagebutton within pf_w_board_doc_ent
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

type dw_cond from pf_u_datawindow within pf_w_board_doc_ent
integer x = 50
integer y = 140
integer width = 4498
integer height = 220
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_board_doc_ent_01"
boolean livescroll = false
boolean issearchcondition = true
boolean scaletoright = true
end type

event itemchanged;call super::itemchanged;choose case string(dwo.name)
	case 'board_no'
		is_board_no = data
		ids_board_mst.retrieve(gnv_session.is_sys_id, is_board_no)
end choose

return 0

end event

type dw_detail from pf_u_datawindow within pf_w_board_doc_ent
integer x = 1641
integer y = 440
integer width = 2907
integer height = 524
integer taborder = 20
boolean bringtotop = true
string dataobject = "pf_d_board_doc_ent_03"
boolean livescroll = false
boolean scaletoright = true
end type

type st_2 from statictext within pf_w_board_doc_ent
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
string facename = "$$HEX2$$cbb3c0c6$$ENDHEX$$"
long textcolor = 25123896
long backcolor = 16777215
string text = "$$HEX8$$8cacdcc23cbb2000c1c038c1b4b0edc5$$ENDHEX$$"
boolean focusrectangle = false
end type

type p_1 from picture within pf_w_board_doc_ent
integer x = 1646
integer y = 384
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type dw_attach from pf_u_datawindow within pf_w_board_doc_ent
integer x = 1641
integer y = 1928
integer width = 2907
integer height = 292
integer taborder = 20
boolean bringtotop = true
string dataobject = "pf_d_board_doc_ent_04"
boolean vscrollbar = true
boolean livescroll = false
boolean fixedtobottom = true
boolean scaletoright = true
end type

event buttonclicked;call super::buttonclicked;choose case string(dwo.name)
	case 'b_open'
		of_attachedfileopen(row)
	case 'b_save'
		of_attachedfilesave(row)
	case 'b_delete'
		if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX18$$20c1ddd05cd52000a8cc80bd0cd37cc744c72000adc01cc858d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 1 then
			dw_attach.deleterow(row)
			dw_attach.update()
			of_setmessage('$$HEX10$$a8cc80bd0cd37cc72000adc01cc8200044c6ccb8$$ENDHEX$$')
		end if
end choose

end event

type p_retrieve from pf_u_imagebutton within pf_w_board_doc_ent
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

type p_attachfile from pf_u_imagebutton within pf_w_board_doc_ent
integer x = 4197
integer y = 1840
integer width = 347
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_fileappend.gif"
boolean fixedtoright = true
boolean fixedtobottom = true
end type

event clicked;call super::clicked;string ls_pathname, ls_filename
integer li_rtn

li_rtn = getfileopenname("$$HEX14$$c5c55cb8dcb460d520000cd37cc744c7200020c1ddd058d538c194c6$$ENDHEX$$", ls_pathname, ls_filename, "*.*", "All Files(*.*), *.*")
if li_rtn < 1 then return

//ll_find = dw_attach.find("org_file_name='" + ls_filename + "'", 1, dw_attach.rowcount())
//if ll_find > 0 then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + ls_filename + '] $$HEX28$$74d5f9b220000cd37cc740c7200074c7f8bb2000a8cc80bd0cd37cc72000a9ba5db8d0c52000f1b45db818b4b4c5200088c7b5c2c8b2e4b2$$ENDHEX$$.')
//	return
//end if

if ids_board_mst.rowcount() = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX2$$f4bcdcb4$$ENDHEX$$(Board) $$HEX14$$15c8f4bc7cb920007dc7b4c52cc6200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
	return
end if

long ll_max_file_size, ll_file_size

ll_max_file_size = ids_board_mst.getitemnumber(1, 'max_file_size')
ll_file_size = filelength(ls_pathname)
if ll_file_size > ll_max_file_size * 1024 * 1024 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX15$$5ccd00b32000c5c55cb8dcb4200000aca5b22000acc074c788c994b22000$$ENDHEX$$' + string(ll_max_file_size) + 'MByte $$HEX3$$85c7c8b2e4b2$$ENDHEX$$')
	return
end if

long ll_new

ll_new = dw_attach.insertrow(0)
dw_attach.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
dw_attach.setitem(ll_new, 'board_no', is_board_no)
dw_attach.setitem(ll_new, 'org_file_name', ls_filename)
dw_attach.setitem(ll_new, 'file_size', ll_file_size)
dw_attach.setitem(ll_new, 'server_path', ls_pathname)

end event

type uo_editor from pf_u_webeditor within pf_w_board_doc_ent
integer x = 1641
integer y = 972
integer width = 2907
integer height = 856
integer taborder = 30
boolean bringtotop = true
boolean scaletoright = true
boolean scaletobottom = true
end type

on uo_editor.destroy
call pf_u_webeditor::destroy
end on
