HA$PBExportHeader$pf_w_syncmanager.srw
forward
global type pf_w_syncmanager from pf_w_sheet
end type
type dw_project from pf_u_datawindow within pf_w_syncmanager
end type
type cb_close from pf_u_commandbutton within pf_w_syncmanager
end type
type dw_liblist from pf_u_datawindow within pf_w_syncmanager
end type
type cb_addproj from pf_u_commandbutton within pf_w_syncmanager
end type
type cb_delproj from pf_u_commandbutton within pf_w_syncmanager
end type
type cb_updproj from pf_u_commandbutton within pf_w_syncmanager
end type
type cb_addfile from pf_u_commandbutton within pf_w_syncmanager
end type
type cb_delfile from pf_u_commandbutton within pf_w_syncmanager
end type
type cb_upload from pf_u_commandbutton within pf_w_syncmanager
end type
type dw_cond from datawindow within pf_w_syncmanager
end type
type cb_zipfile from pf_u_commandbutton within pf_w_syncmanager
end type
type cb_zipall from pf_u_commandbutton within pf_w_syncmanager
end type
type cb_refresh from pf_u_commandbutton within pf_w_syncmanager
end type
end forward

global type pf_w_syncmanager from pf_w_sheet
dw_project dw_project
cb_close cb_close
dw_liblist dw_liblist
cb_addproj cb_addproj
cb_delproj cb_delproj
cb_updproj cb_updproj
cb_addfile cb_addfile
cb_delfile cb_delfile
cb_upload cb_upload
dw_cond dw_cond
cb_zipfile cb_zipfile
cb_zipall cb_zipall
cb_refresh cb_refresh
end type
global pf_w_syncmanager pf_w_syncmanager

type variables
constant string ApplicationContextFile = "pf_syncapplication.xml"
constant string UploadSubDir = "/SyncProject/"

end variables

forward prototypes
public function integer of_setprojectlistddlb ()
public function integer of_setlibrarylist (long al_row, string as_filepath)
public function integer of_compresslibrarylist (long al_row)
end prototypes

public function integer of_setprojectlistddlb ();long ll_row
string ls_project_name
string ls_values

for ll_row = 1 to dw_project.rowcount()
	ls_project_name = dw_project.getitemstring(ll_row, 'project_name')
	if len(trim(ls_project_name)) > 0 then
		ls_values += ls_project_name + "~t" + ls_project_name + "/"
	end if
next

dw_cond.modify("project_name.values='" + ls_values + "'")
return ll_row

end function

public function integer of_setlibrarylist (long al_row, string as_filepath);datetime ldtm_modified
ulong lul_filesize
string ls_filename

// pbl --> pbd $$HEX2$$c0bcbdac$$ENDHEX$$
if lower(right(as_filepath, 4)) = '.pbl' then
	as_filepath = left(as_filepath, len(as_filepath) - 4) + ".pbd"
end if

dw_liblist.setitem(al_row, 'path', as_filepath)

gnv_extfunc.of_getfilewritetime(as_filepath, ldtm_modified)
lul_filesize = gnv_extfunc.pf_getfilesize(as_filepath)

dw_liblist.setitem(al_row, 'src_lastmodifydate', ldtm_modified)
dw_liblist.setitem(al_row, 'src_size', lul_filesize)

ls_filename = gnv_extfunc.of_pathstrippath(as_filepath)
dw_liblist.setitem(al_row, 'src_filename', ls_filename)

return 1

end function

public function integer of_compresslibrarylist (long al_row);// $$HEX16$$30bcecd360d520000cd37cc744c7200055c595cd98ccacb9200069d5c8b2e4b2$$ENDHEX$$.

integer li_rc
string ls_project_name, ls_orgfile
string ls_zipfile
long ll_proj_row

ll_proj_row = dw_project.getrow()
if ll_proj_row = 0 then return -1
ls_project_name = dw_project.getitemstring(ll_proj_row, 'project_name')

ls_orgfile = dw_liblist.getitemstring(al_row, 'path')
ls_zipfile = gnv_appmgr.is_currentdir  + "\SyncProject\" + ls_project_name + "\" + gnv_extfunc.of_pathstrippath(ls_orgfile) + ".z"

li_rc = gnv_extfunc.of_compressfile(ls_orgfile, ls_zipfile)
if li_rc < 0 then return -1

//dw_liblist.setitem(al_row, 'zip_name', gnv_extfunc.of_pathstrippath(ls_zipfile))
//
//li_filenum = fileopen(ls_orgfile, StreamMode!, Read!, LockRead!)
//if li_filenum = -1 then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', ls_orgfile + ' $$HEX12$$0cd37cc744c72000f4c5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$~r~n$$HEX32$$74d5f9b220000cd37cc744c72000acc0a9c6200011c978c7200004d55cb8f8ada8b744c72000ebb2e0ac2000e4b2dcc22000dcc2c4b374d52000f4bc38c194c6$$ENDHEX$$')
//	return -1
//end if
//
//if filereadex(li_filenum, lb_contents) = -1 then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', ls_orgfile + ' $$HEX13$$0cd37cc744c720007dc744c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$~r~n$$HEX32$$74d5f9b220000cd37cc744c72000acc0a9c6200011c978c7200004d55cb8f8ada8b744c72000ebb2e0ac2000e4b2dcc22000dcc2c4b374d52000f4bc38c194c6$$ENDHEX$$')
//	return -1
//end if
//
//fileclose(li_filenum)
//
//ls_filenameonly = gnv_extfunc.of_pathstrippath(ls_orgfile)
//ls_zipfile = gnv_appmgr.is_currentdir  + "\SyncProject\" + ls_project_name + "\" + ls_filenameonly + ".z"
//
//if gnv_extfunc.of_compress(lb_contents, lb_zipped) < 1 then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', ls_orgfile + '~r~n$$HEX8$$0cd37cc7200055c595cd2000e4c228d3$$ENDHEX$$!')
//	return -1
//end if
//
//li_filenum = fileopen(ls_zipfile, StreamMode!, Write!, LockWrite!, Replace!)
//if li_filenum = -1 then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', ls_zipfile + ' $$HEX12$$0cd37cc744c72000f4c5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$~r~n$$HEX32$$74d5f9b220000cd37cc744c72000acc0a9c6200011c978c7200004d55cb8f8ada8b744c72000ebb2e0ac2000e4b2dcc22000dcc2c4b374d52000f4bc38c194c6$$ENDHEX$$')
//	return -1
//end if
//
//if filewriteex(li_filenum, lb_zipped) = -1 then
//	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', ls_zipfile + ' $$HEX20$$0cd37cc7d0c5200070b374c730d12000f0c430ae7cb9200060d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$~r~n$$HEX32$$74d5f9b220000cd37cc744c72000acc0a9c6200011c978c7200004d55cb8f8ada8b744c72000ebb2e0ac2000e4b2dcc22000dcc2c4b374d52000f4bc38c194c6$$ENDHEX$$')
//	return -1
//end if
//
//fileclose(li_filenum)

datetime ldtm_modified
long lul_filesize, lul_orgfilesize
decimal ld_comp_raito

dw_liblist.setitem(al_row, 'zip_name', gnv_extfunc.of_pathstrippath(ls_zipfile))

gnv_extfunc.of_getfilewritetime(ls_zipfile, ldtm_modified)
lul_filesize = gnv_extfunc.pf_getfilesize(ls_zipfile)

dw_liblist.setitem(al_row, 'dest_lastmodifydate', ldtm_modified)
dw_liblist.setitem(al_row, 'dest_size', lul_filesize)

lul_orgfilesize = dw_liblist.getitemnumber(al_row, 'src_size')
if lul_orgfilesize > 0 then
	ld_comp_raito = (lul_orgfilesize - lul_filesize) / lul_orgfilesize * 100
	dw_liblist.setitem(al_row, 'comp_ratio', ld_comp_raito)
end if

dw_liblist.setitem(al_row, 'file_trans', 'Y')

return 1

end function

on pf_w_syncmanager.create
int iCurrent
call super::create
this.dw_project=create dw_project
this.cb_close=create cb_close
this.dw_liblist=create dw_liblist
this.cb_addproj=create cb_addproj
this.cb_delproj=create cb_delproj
this.cb_updproj=create cb_updproj
this.cb_addfile=create cb_addfile
this.cb_delfile=create cb_delfile
this.cb_upload=create cb_upload
this.dw_cond=create dw_cond
this.cb_zipfile=create cb_zipfile
this.cb_zipall=create cb_zipall
this.cb_refresh=create cb_refresh
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_project
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.dw_liblist
this.Control[iCurrent+4]=this.cb_addproj
this.Control[iCurrent+5]=this.cb_delproj
this.Control[iCurrent+6]=this.cb_updproj
this.Control[iCurrent+7]=this.cb_addfile
this.Control[iCurrent+8]=this.cb_delfile
this.Control[iCurrent+9]=this.cb_upload
this.Control[iCurrent+10]=this.dw_cond
this.Control[iCurrent+11]=this.cb_zipfile
this.Control[iCurrent+12]=this.cb_zipall
this.Control[iCurrent+13]=this.cb_refresh
end on

on pf_w_syncmanager.destroy
call super::destroy
destroy(this.dw_project)
destroy(this.cb_close)
destroy(this.dw_liblist)
destroy(this.cb_addproj)
destroy(this.cb_delproj)
destroy(this.cb_updproj)
destroy(this.cb_addfile)
destroy(this.cb_delfile)
destroy(this.cb_upload)
destroy(this.dw_cond)
destroy(this.cb_zipfile)
destroy(this.cb_zipall)
destroy(this.cb_refresh)
end on

event pfe_postopen;call super::pfe_postopen;// $$HEX17$$b4c50cd5acb900cf74c758c1200015c8f4bc7cb920007dc7b4c5200035c6c8b2e4b2$$ENDHEX$$
string ls_appctx

ls_appctx = gnv_appmgr.is_currentdir + "\" + ApplicationContextFile
if fileexists(ls_appctx) then
	dw_project.reset()
	dw_project.importfile( XML!, ls_appctx )
	//dw_project.resetupdate()
end if

if dw_project.rowcount() = 0 then
	dw_cond.insertrow(0)
	cb_addproj.post event clicked()
	return
end if

// $$HEX7$$80acc9c070c874ac200094cd00ac$$ENDHEX$$
this.of_setprojectlistddlb()
dw_cond.insertrow(0)
dw_cond.setfocus()

// $$HEX14$$5ccd85c82000acc0a9c61cb4200004d55cb81dc8b8d2200020c1ddd0$$ENDHEX$$
long ll_row
string ls_lastused

for ll_row = 1 to dw_project.rowcount()
	if dw_project.getitemstring(ll_row, 'last_used') = 'Y' then
		ls_lastused = dw_project.getitemstring(ll_row, 'project_name')
	end if
next

if ls_lastused = '' then
	ls_lastused = dw_project.getitemstring(1, 'project_name')
end if

dw_cond.setitem(1, 'project_name', ls_lastused)
dw_cond.post event itemchanged(1, dw_cond.object.project_name, ls_lastused)
dw_project.post resetupdate()

// $$HEX14$$30bcecd320000cd37cc72000ddc031c12000f4d354b3200055d678c7$$ENDHEX$$
string ls_syncfolder

ls_syncfolder = gnv_appmgr.is_currentdir + "\SyncProject"
if not fileexists(ls_syncfolder) then
	createdirectory(ls_syncfolder)
end if

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_syncmanager
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_syncmanager
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_syncmanager
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_syncmanager
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_syncmanager
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_syncmanager
end type

type dw_project from pf_u_datawindow within pf_w_syncmanager
integer x = 50
integer y = 160
integer width = 4498
integer height = 248
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_syncmanager_01"
boolean confirmupdateonrowchange = false
boolean scaletoright = true
end type

event buttonclicked;call super::buttonclicked;// $$HEX5$$c0d09fac200020c1ddd0$$ENDHEX$$
integer li_cnt, i
string ls_fullname, ls_filename
string ls_appname, ls_liblist[]
pf_n_pbtliblist lnv_pbtlib

// accepttext
if this.accepttext() = -1 then return

choose case dwo.name
	case 'b_target'
			if GetFileOpenName("Open", ls_fullname, ls_filename, "pbt", "PowerBuilder Target Files(*.pbt), *.pbt", "", 512) < 1 then return
			if dw_liblist.rowcount() > 0 then
				if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX19$$30ae2000f1b45db81cb4200030bcecd300b3c1c040c7200074d0acb9b4c5200029b4c8b2e4b2$$ENDHEX$$.~r~n$$HEX11$$c4ac8dc12000c4c989d558d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 2 then return
			end if
			
			lnv_pbtlib = create pf_n_pbtliblist
			li_cnt = lnv_pbtlib.of_parsetarget( ls_fullname )
			if li_cnt < 1 then
				MessageBox("$$HEX2$$55d678c7$$ENDHEX$$", ls_fullname + "-$$HEX16$$0cd3ccc64cbe54b32000c0d013cf20000cd37cc774c7200044c5c8b270ac98b0$$ENDHEX$$, $$HEX13$$0cd37cc774c7200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$.")
				return
			end if
			
			ls_appname = lnv_pbtlib.is_appname
			ls_liblist = lnv_pbtlib.is_liblist
			
			this.setitem(row, 'pb_target', ls_fullname)
			
			dw_liblist.reset()
			
			for i = 1 to li_cnt
				dw_liblist.insertrow(i)
				parent.of_setlibrarylist(i, ls_liblist[i])
			next
		case 'b_ping'
			string ls_url
			
			ls_url = this.getitemstring(row, 'server_url')
			if isnull(ls_url) or len(trim(ls_url)) = 0 then
				messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX8$$3cba00c8200030bcecd31cc184bc2000$$ENDHEX$$URL$$HEX7$$44c7200085c725b858d538c194c6$$ENDHEX$$')
				return
			end if
			
			if gnv_extfunc.pf_http_ping(ls_url, 5) then
				messagebox('URL $$HEX5$$38d69ccd200031c1f5ac$$ENDHEX$$!', ls_url + '~r~n$$HEX13$$98d374c7c0c9200038d69ccd200031c1f5ac88d5b5c2c8b2e4b2$$ENDHEX$$.')
			else
				messagebox('URL $$HEX5$$38d69ccd2000e4c228d3$$ENDHEX$$!', ls_url + '~r~n$$HEX13$$98d374c7c0c9200038d69ccd2000e4c228d388d5b5c2c8b2e4b2$$ENDHEX$$.~r~n~r~n$$HEX5$$85c725b858d5e0c22000$$ENDHEX$$URL $$HEX10$$44c72000e4b2dcc2200055d678c758d538c194c6$$ENDHEX$$.')
			end if
end choose

end event

event rowfocuschanged;//

end event

event rowfocuschanging;//

end event

type cb_close from pf_u_commandbutton within pf_w_syncmanager
integer x = 4242
integer y = 36
integer width = 311
integer height = 88
integer taborder = 20
boolean bringtotop = true
string text = "$$HEX2$$ebb230ae$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)

end event

type dw_liblist from pf_u_datawindow within pf_w_syncmanager
integer x = 46
integer y = 436
integer width = 4498
integer height = 1784
integer taborder = 20
boolean bringtotop = true
string dataobject = "pf_d_syncmanager_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean singlerowselection = false
boolean multirowselection = true
boolean scaletoright = true
boolean scaletobottom = true
end type

type cb_addproj from pf_u_commandbutton within pf_w_syncmanager
integer x = 1166
integer y = 36
integer height = 88
integer taborder = 10
boolean bringtotop = true
string text = "$$HEX7$$04d55cb81dc8b8d2200094cd00ac$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long ll_new

ll_new = dw_project.insertrow(0)
dw_project.scrolltorow(ll_new)
dw_project.setrow(ll_new)
dw_project.setfocus()

dw_liblist.reset()
dw_cond.setitem(1, 'project_name', '')

end event

type cb_delproj from pf_u_commandbutton within pf_w_syncmanager
integer x = 1573
integer y = 36
integer height = 88
integer taborder = 10
boolean bringtotop = true
string text = "$$HEX7$$04d55cb81dc8b8d22000adc01cc8$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;string ls_project_name
string ls_appctx, ls_libctx
long i

ls_project_name = dw_cond.getitemstring(1, 'project_name')
if pf_f_isemptystring(ls_project_name) then return

if messagebox('$$HEX5$$adc01cc8200055d678c7$$ENDHEX$$', '$$HEX4$$15c8d0b95cb82000$$ENDHEX$$[' + ls_project_name + '] $$HEX27$$04d55cb81dc8b8d2200015c8f4bc40c620007cb774c70cbeecb7acb9200015c8f4bc7cb92000adc01cc858d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 2 then return

// $$HEX10$$04d55cb81dc8b8d2200015c8f4bc2000adc01cc8$$ENDHEX$$
dw_project.deleterow(dw_project.getrow())

// $$HEX11$$7cb774c70cbeecb7acb9200015c8f4bc2000adc01cc8$$ENDHEX$$
for i = dw_liblist.rowcount() to 1 step -1
	dw_liblist.deleterow(i)
next

// $$HEX10$$04d55cb81dc8b8d2200015c8f4bc200000c8a5c7$$ENDHEX$$
ls_appctx = gnv_appmgr.is_currentdir + "\" + ApplicationContextFile
if dw_project.saveas(ls_appctx, xml!, false) = -1 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX19$$04d55cb81dc8b8d2200015c8f4bc7cb9200000c8a5c760d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
	return
end if

// $$HEX11$$7cb774c70cbeecb7acb9200015c8f4bc200000c8a5c7$$ENDHEX$$
ls_libctx = gnv_appmgr.is_currentdir + "\SyncProject\" + ls_project_name + "\" + ls_project_name + ".xml"
if filedelete(ls_libctx) = false then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + ls_libctx + '] $$HEX20$$7cb774c70cbeecb7acb9200015c8f4bc7cb92000adc01cc860d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
	return
end if

// $$HEX8$$70c88cd670c874ac2000acc724c115c8$$ENDHEX$$
parent.of_setprojectlistddlb()

dw_project.resetupdate()
dw_liblist.resetupdate()

// GetFocus $$HEX8$$04d55cb81dc8b8d25cb8200074c7d9b3$$ENDHEX$$
long ll_row

ll_row = dw_project.getrow()
if ll_row > 0 then
	ls_project_name = dw_project.getitemstring(ll_row, 'project_name')
	dw_cond.setitem(1, 'project_name', ls_project_name)
	dw_cond.event itemchanged(1, dw_cond.object.project_name, ls_project_name)
end if

dw_project.setredraw(true)
messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX15$$04d55cb81dc8b8d2200015c8f4bc7cb92000adc01cc888d5b5c2c8b2e4b2$$ENDHEX$$')
return

end event

type cb_updproj from pf_u_commandbutton within pf_w_syncmanager
integer x = 1979
integer y = 36
integer height = 88
integer taborder = 20
boolean bringtotop = true
string text = "$$HEX7$$04d55cb81dc8b8d2200000c8a5c7$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long ll_row
string ls_project_name, ls_pb_target, ls_server_url

if dw_project.accepttext() = -1 then return
ll_row = dw_project.getrow()
if  ll_row = 0 then return

if dw_project.modifiedcount() + dw_liblist.modifiedcount() = 0 then return

// $$HEX9$$44d518c285c725b8acc06dd5200055d678c7$$ENDHEX$$
ls_project_name = dw_project.getitemstring(ll_row, 'project_name')
ls_pb_target = dw_project.getitemstring(ll_row, 'pb_target')
ls_server_url = dw_project.getitemstring(ll_row, 'server_url')

if pf_f_isemptystring(ls_project_name) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX13$$04d55cb81dc8b8d2200085ba44c7200085c725b858d538c194c6$$ENDHEX$$')
	return
end if

if pf_f_isemptystring(ls_pb_target) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX21$$30bcecd360d520000cd3ccc64cbe54b32000c0d09fac20000cd37cc744c7200020c1ddd058d538c194c6$$ENDHEX$$')
	return
end if

if pf_f_isemptystring(ls_server_url) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX7$$30bcecd360d520001cc184bc2000$$ENDHEX$$URL $$HEX9$$15c8f4bc7cb9200085c725b858d538c194c6$$ENDHEX$$')
	return
end if

// $$HEX12$$04d55cb81dc8b8d2200085ba6dce200011c9f5bc55d678c7$$ENDHEX$$
long i

for i = 1 to dw_project.rowcount()
	if i = ll_row then continue
	if ls_project_name = dw_project.getitemstring(i, 'project_name') then
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + ls_project_name + '] $$HEX18$$04d55cb81dc8b8d2200085ba6dce40c7200074c7f8bb2000acc0a9c611c985c7c8b2e4b2$$ENDHEX$$.')
		return
	end if
next

// $$HEX16$$5ccd85c82000acc0a9c61cb42000b4c50cd5acb900cf74c758c12000f1b45db8$$ENDHEX$$
string ls_appctx, ls_libctx

for i = 1 to dw_project.rowcount()
	if i = ll_row then
		dw_project.setitem(i, 'last_used', 'Y')
	else
		dw_project.setitem(i, 'last_used', 'N')
	end if
next

if dw_project.getitemstatus(ll_row, 0, primary!) = newmodified! then
	parent.of_setprojectlistddlb()
	dw_cond.setitem(1, 'project_name', ls_project_name)
end if

// $$HEX9$$48be200004d55cb81dc8b8d220001cc870ac$$ENDHEX$$
for i = dw_project.rowcount() to 1 step -1
	if dw_project.getitemstatus(i, 0, primary!) = new! or pf_f_isemptystring(dw_project.getitemstring(i, 'project_name')) then
		dw_project.deleterow(i)
	end if
next

// $$HEX10$$04d55cb81dc8b8d2200015c8f4bc200000c8a5c7$$ENDHEX$$
ls_appctx = gnv_appmgr.is_currentdir + "\" + ApplicationContextFile
if dw_project.saveas(ls_appctx, xml!, false) = -1 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX19$$04d55cb81dc8b8d2200015c8f4bc7cb9200000c8a5c760d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
	return
end if

// $$HEX9$$30bcecd3a9c62000f4d354b3200080acacc0$$ENDHEX$$
string ls_syncfolder

ls_syncfolder = gnv_appmgr.is_currentdir + "\SyncProject\" + ls_project_name
if not fileexists(ls_syncfolder) then
	createdirectory(ls_syncfolder)
end if

// $$HEX11$$7cb774c70cbeecb7acb9200015c8f4bc200000c8a5c7$$ENDHEX$$
ls_libctx = gnv_appmgr.is_currentdir + "\SyncProject\" + ls_project_name + "\" + ls_project_name + ".xml"
if dw_liblist.saveas(ls_libctx, xml!, false) = -1 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX20$$7cb774c70cbeecb7acb9200015c8f4bc7cb9200000c8a5c760d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
	return
end if

dw_project.resetupdate()
dw_liblist.resetupdate()

dw_project.setredraw(true)
messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX15$$04d55cb81dc8b8d2200015c8f4bc7cb9200000c8a5c788d5b5c2c8b2e4b2$$ENDHEX$$')

end event

type cb_addfile from pf_u_commandbutton within pf_w_syncmanager
integer x = 2665
integer y = 36
integer width = 311
integer height = 88
integer taborder = 20
boolean bringtotop = true
string text = "$$HEX5$$0cd37cc7200094cd00ac$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX12$$30bcecd360d520007cb774c70cbeecb7acb9200094cd00ac$$ENDHEX$$
string ls_pb_target, ls_initpath
string ls_docpath, ls_docname[]
long ll_row, ll_new
integer i, li_cnt, li_rtn

ll_row = dw_project.getrow()
if ll_row = 0 then return

ls_pb_target = dw_project.getitemstring(ll_row, 'pb_target')
ls_initpath = gnv_extfunc.of_pathremovefilespec(ls_pb_target)
li_rtn = GetFileOpenName("Select File", ls_docpath, ls_docname[], "*", "All Files (*.*), *.*", ls_initpath)
if li_rtn < 1 then return

if upperbound(ls_docname) = 1 then
	ls_docname[1] = ls_docpath
else
	for i = 1 to upperbound(ls_docname)
		ls_docname[i] = ls_docpath + '\' + ls_docname[i]
	next
end if

ll_row = dw_liblist.getrow()
li_cnt = Upperbound(ls_docname)
for i = li_cnt to 1 step -1
	ll_new = dw_liblist.insertrow(ll_row)
	parent.of_setlibrarylist(ll_new, ls_docname[i])
next

messagebox("$$HEX2$$4cc5bcb9$$ENDHEX$$", "$$HEX22$$20c1ddd058d5e0c220000cd37cc744c7200030bcecd300b3c1c03cc75cb8200094cd00ac88d5b5c2c8b2e4b2$$ENDHEX$$.~r~n'$$HEX7$$04d55cb81dc8b8d2200000c8a5c7$$ENDHEX$$' $$HEX20$$84bcbcd244c7200074d0adb974d52000c0bcbdac2000b4b0edc544c7200000c8a5c758d538c194c6$$ENDHEX$$.")
return

end event

type cb_delfile from pf_u_commandbutton within pf_w_syncmanager
integer x = 2981
integer y = 36
integer width = 311
integer height = 88
integer taborder = 30
boolean bringtotop = true
string text = "$$HEX5$$0cd37cc72000adc01cc8$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long ll_cnter
long ll_row, ll_selected[]
string ls_selected

ll_row = dw_liblist.getselectedrow(0)
do while ll_row > 0
	ll_cnter++
	ll_selected[ll_cnter] = ll_row
	ls_selected += dw_liblist.getitemstring(ll_row, 'path') + '~r~n'
	
	ll_row = dw_liblist.getselectedrow(ll_row)
loop

if ll_cnter = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX17$$3cba00c82000adc01cc860d520000cd37cc7e4b444c7200020c1ddd058d538c194c6$$ENDHEX$$')
	return
end if

if messagebox("$$HEX5$$adc01cc8200055d678c7$$ENDHEX$$", "$$HEX7$$20c1ddd058d5e0c220000cd37cc7$$ENDHEX$$= ~r~n" + ls_selected + "$$HEX21$$04c720007cb774c70cbeecb7acb97cb9200030bcecd300b3c1c0d0c51cc120001cc878c669d5c8b2e4b2$$ENDHEX$$.", Question!, YesNo!, 2) = 2 then
	return
end if

for ll_row = ll_cnter to 1 step -1
	dw_liblist.deleterow(ll_selected[ll_row])
next

messagebox("$$HEX2$$4cc5bcb9$$ENDHEX$$", "$$HEX15$$20c1ddd058d5e0c220000cd37cc744c72000adc01cc888d5b5c2c8b2e4b2$$ENDHEX$$.~r~n'$$HEX7$$04d55cb81dc8b8d2200000c8a5c7$$ENDHEX$$' $$HEX20$$84bcbcd244c7200074d0adb974d52000c0bcbdac2000b4b0edc544c7200000c8a5c758d538c194c6$$ENDHEX$$.")
return

end event

type cb_upload from pf_u_commandbutton within pf_w_syncmanager
integer x = 3927
integer y = 36
integer width = 311
integer height = 88
integer taborder = 30
boolean bringtotop = true
string text = "$$HEX5$$0cd37cc7200004c8a1c1$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX12$$55c595cd20000cd37cc720001cc184bcd0c5200004c8a1c1$$ENDHEX$$

long i, ll_row, ll_cnter
string ls_project_name
string ls_uploadfiles[]
string ls_uploadurl, ls_subdir
pf_n_httptransfer lnv_http

lnv_http = create pf_n_httptransfer

if dw_project.accepttext() = -1 then return
ll_row = dw_project.getrow()
if  ll_row = 0 then return

ls_project_name = dw_project.getitemstring(ll_row, 'project_name')
if pf_f_isemptystring(ls_project_name) then return

ls_uploadurl = dw_project.getitemstring(ll_row, 'server_url')
if pf_f_isemptystring(ls_uploadurl) then return

ls_subdir = UploadSubDir + ls_project_name

// ZIP $$HEX5$$0cd37cc72000bdac5cb8$$ENDHEX$$
string ls_zipfolder
string ls_zipfile

ls_zipfolder = gnv_appmgr.is_currentdir  + "\SyncProject\" + ls_project_name + "\" 

for i = 1 to dw_liblist.rowcount()
	if pf_f_nvl(dw_liblist.getitemstring(i, 'file_trans'), '') <> 'Y' then continue
	
	ls_zipfile = dw_liblist.getitemstring(i, 'zip_name')
	if pf_f_isemptystring(ls_zipfile) then
		dw_liblist.scrolltorow(i)
		dw_liblist.setrow(i)
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', dw_liblist.getitemstring(i, 'path') + '~r~n$$HEX17$$0cd37cc740c7200044c5c1c9200055c595cd18b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$~r~n$$HEX19$$3cba00c8200055c595cd91c7c5c544c72000c4c989d52000c4d6200030bcecd358d538c194c6$$ENDHEX$$')
		return -1
	end if
	
	ll_cnter ++
	ls_uploadfiles[ll_cnter] = ls_zipfolder + ls_zipfile
next

// $$HEX12$$84bc04c80cd37cc7200094cd00ac20000fbc200030bcecd3$$ENDHEX$$
string ls_libctx

if ll_cnter > 0 then
	ls_libctx = gnv_appmgr.is_currentdir + "\SyncProject\" + ls_project_name + "\" + ls_project_name + ".xml"
	if dw_liblist.saveas(ls_libctx, xml!, false) = -1 then
		messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX20$$7cb774c70cbeecb7acb9200015c8f4bc7cb9200000c8a5c760d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
		return
	end if
	
	ll_cnter ++
	ls_uploadfiles[ll_cnter] = ls_libctx
	
	if lnv_http.of_fileupload(ls_uploadfiles, ls_uploadurl, ls_subdir) = 0 then
		for i = 1 to dw_liblist.rowcount()
			if dw_liblist.getitemstring(i, 'file_trans') = 'Y' then
				dw_liblist.setitem(i, 'file_trans', 'N')
			end if
		next
		
		if dw_liblist.saveas(ls_libctx, xml!, false) = -1 then
			messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX20$$7cb774c70cbeecb7acb9200015c8f4bc7cb9200000c8a5c760d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
			return
		end if
	end if
else
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', "$$HEX12$$04c8a1c160d520000cd37cc774c72000c6c5b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX9$$04c8a1c160d520000cd37cc7e4b440c72000$$ENDHEX$$'$$HEX3$$04c8a1c12000$$ENDHEX$$CheckBox'$$HEX7$$7cb9200074d0adb958d538c194c6$$ENDHEX$$")
	return
end if

//if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX13$$0cd37cc7200004c8a1c174c7200044c6ccb810b4b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX17$$04d55cb81dc8b8d220000cd37cc744c7200000c8a5c758d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 1 then
//	cb_updproj.post event clicked()
//end if

end event

type dw_cond from datawindow within pf_w_syncmanager
integer x = 50
integer y = 32
integer width = 1056
integer height = 96
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "pf_d_syncmanager_cond"
boolean border = false
boolean livescroll = true
end type

event itemchanged;if row = 0 then return

string ls_project_name, ls_libctx
long ll_find, i

choose case dwo.name
	case 'project_name'
		ls_project_name = data
		
		ll_find = dw_project.find("project_name='" + ls_project_name + "'", 1, dw_project.rowcount())
		if ll_find > 0 then
			dw_project.scrolltorow(ll_find)
			dw_project.setrow(ll_find)
			dw_project.post setredraw(true)
			
			ls_libctx = gnv_appmgr.is_currentdir + "\SyncProject\" + ls_project_name + "\" + ls_project_name + ".xml"
			dw_liblist.reset()
			dw_liblist.importfile(xml!, ls_libctx)
			dw_liblist.resetupdate()
			
			// Refresh $$HEX9$$7cb774c70cbeecb7acb92000acb9a4c2b8d2$$ENDHEX$$
			cb_refresh.post event clicked()
			
			// Default $$HEX7$$04d55cb81dc8b8d2200024c115c8$$ENDHEX$$
			for i = 1 to dw_project.rowcount()
				if i = ll_find then
					dw_project.setitem(i, 'last_used', 'Y')
				else
					dw_project.setitem(i, 'last_used', 'N')
				end if
			next
		end if
end choose

return 0

end event

type cb_zipfile from pf_u_commandbutton within pf_w_syncmanager
integer x = 3296
integer y = 36
integer width = 311
integer height = 88
integer taborder = 30
boolean bringtotop = true
string text = "$$HEX4$$0cd37cc755c595cd$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX8$$20c1ddd020000cd37cc7200055c595cd$$ENDHEX$$
long ll_row, ll_cnter

setpointer(hourglass!)
post setpointer(arrow!)

ll_row = dw_liblist.getselectedrow(0)
do while ll_row > 0
	if parent.of_compresslibrarylist(ll_row) = -1 then return
	ll_cnter ++
	ll_row = dw_liblist.getselectedrow(ll_row)
loop

if ll_cnter > 0 then
	if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX12$$0cd37cc7200055c595cd74c720005db0acb0b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX20$$55c595cd5cd520000cd37cc744c720001cc184bcd0c5200004c8a1c158d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 1 then
		cb_upload.post event clicked()
	end if
else
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX13$$55c595cd60d520000cd37cc744c7200020c1ddd058d538c194c6$$ENDHEX$$.~r~n$$HEX8$$e4b211c989d5200020c1ddd040c72000$$ENDHEX$$Shift $$HEX3$$10b694b22000$$ENDHEX$$Ctrl $$HEX9$$a4d07cb9200004b278b9c1c0dcd0d0c51cc1$$ENDHEX$$~r~n$$HEX10$$ecc5ecb789d544c7200020c1ddd058d538c194c6$$ENDHEX$$')
end if

end event

type cb_zipall from pf_u_commandbutton within pf_w_syncmanager
integer x = 3611
integer y = 36
integer width = 311
integer height = 88
integer taborder = 40
boolean bringtotop = true
string text = "$$HEX4$$04c8b4cc55c595cd$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX8$$04c8b4cc20000cd37cc7200055c595cd$$ENDHEX$$
long ll_row, ll_cnter

setpointer(hourglass!)
post setpointer(arrow!)

if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX24$$15c8d0b95cb82000a8bae0b420000cd37cc744c7200055c595cd2000c4d6200004c8a1c158d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Exclamation!, YesNo!, 2) = 2 then return

for ll_row = 1 to dw_liblist.rowcount()
	if parent.of_compresslibrarylist(ll_row) = -1 then return
	ll_cnter ++
next

if ll_cnter > 0 then
	if messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX15$$0cd37cc7200055c595cd74c72000a8ba50b420005db0acb0b5c2c8b2e4b2$$ENDHEX$$.~r~n$$HEX20$$55c595cd5cd520000cd37cc744c720001cc184bcd0c5200004c8a1c158d5dcc2a0acb5c2c8b24cae$$ENDHEX$$?', Question!, YesNo!, 2) = 1 then
		cb_upload.post event clicked()
	end if
end if

end event

type cb_refresh from pf_u_commandbutton within pf_w_syncmanager
integer x = 2386
integer y = 36
integer width = 274
integer height = 88
integer taborder = 20
boolean bringtotop = true
string text = "$$HEX4$$acb904d508b8dcc2$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// Refresh LibraryList

long ll_row, ll_null
string ls_filename, ls_null
datetime ldtm_modified, ldtm_null
long lul_filesize

setnull(ls_null)
setnull(ll_null)
setnull(ldtm_null)

for ll_row = 1 to dw_liblist.rowcount()
	ls_filename = dw_liblist.getitemstring(ll_row, 'path')
	
	// $$HEX19$$7cb774c70cbeecb7acb920000cd37cc720007cc790c720000fbc20006cd030ae200044be50ad$$ENDHEX$$
	gnv_extfunc.of_getfilewritetime(ls_filename, ldtm_modified)
	lul_filesize = gnv_extfunc.pf_getfilesize(ls_filename)
	
	// $$HEX21$$0cd37cc7c0bcbdac7cc774c7200014bc0cb070ac98b02000acc074c788c900ac200014bc10b0bdacb0c6$$ENDHEX$$
	if ldtm_modified <> dw_liblist.getitemdatetime(ll_row, 'src_lastmodifydate') or &
		lul_filesize <> dw_liblist.getitemnumber(ll_row, 'src_size') then
		
		dw_liblist.setitem(ll_row, 'src_lastmodifydate', ldtm_modified)
		dw_liblist.setitem(ll_row, 'src_size', lul_filesize)
		
		dw_liblist.setitem(ll_row, 'zip_name', ls_null)
		dw_liblist.setitem(ll_row, 'dest_lastmodifydate', ldtm_null)
		dw_liblist.setitem(ll_row, 'dest_size', ll_null)
		dw_liblist.setitem(ll_row, 'comp_ratio', ll_null)
		dw_liblist.setitem(ll_row, 'file_trans', ls_null)
		
		// $$HEX13$$c0bcbdac1cb420000cd37cc740c7200090c7d9b33cc75cb82000$$ENDHEX$$'$$HEX2$$04c8a1c1$$ENDHEX$$' $$HEX5$$b4cc6cd020000fbc2000$$ENDHEX$$SelectRow
		dw_liblist.setitem(ll_row, 'file_trans', 'Y')
		dw_liblist.SelectRow(ll_row, True)
	end if
next

return 0

end event

