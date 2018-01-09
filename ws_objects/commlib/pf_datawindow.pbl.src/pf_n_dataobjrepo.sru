$PBExportHeader$pf_n_dataobjrepo.sru
forward
global type pf_n_dataobjrepo from pf_n_nonvisualobject
end type
end forward

global type pf_n_dataobjrepo from pf_n_nonvisualobject
end type
global pf_n_dataobjrepo pf_n_dataobjrepo

type variables
constant string USER_KEY = 'www.penta.co.kr'

protected:
	powerobject ipo_target
	window iw_parent
	string is_dwdesigner

public:
	string	is_repopath
	string is_metapath
	string is_objpath

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_getdataobjectsyntax (string as_dataobject, string as_dwdesigner, ref string as_syntax)
public function integer of_setdataobjectsyntax (string as_dataobject, string as_dwdesigner, string as_syntax)
public subroutine of_initialize (powerobject apo_target, window awo_parent, string as_dwdesigner)
public function integer of_backupdesignedsyntax ()
public function integer of_applydesignedsyntax ()
end prototypes

public function string of_getclassname ();return 'pf_n_dataobjrepo'

end function

public function integer of_getdataobjectsyntax (string as_dataobject, string as_dwdesigner, ref string as_syntax);// as_dataobject 데이터윈도우 오브젝트의 Syntax를 구해옵니다.

if appeongetclienttype() <> 'WEB' then return NO_ACTION

string ls_metafile, ls_repofile
string ls_metamodified, ls_repomodified

// get last modified datetime of metafile
ls_metafile = is_metapath + '\' + as_dataobject + '.dat'
if not FileExists(ls_metafile) then return FAILURE
gnv_extfunc.of_getfilewritetime(ls_metafile, ls_metamodified)

// get last modified datetime of repository
ls_repofile = is_repopath + '\' + as_dataobject
if not FileExists(ls_repofile) then return NO_ACTION
gnv_extfunc.of_getfilewritetime(ls_repofile, ls_repomodified)

// check if the both files has the same modified datetime
if ls_metamodified <> ls_repomodified then return NO_ACTION

// read stored syntax from temporary folder
blob{1048576} lblb_syntax
string ls_syntax, ls_dsnrfile
string ls_dwdesigner
string ls_dsnrmodified, ls_objmodified
long ll_syntaxlen
pf_n_hashtable lnv_header

if appeongetclienttype() = 'WEB' then
	lblb_syntax = blob(space(1048576), EncodingAnsi!)
end if

ll_syntaxlen = len(lblb_syntax)
if gnv_extfunc.pf_DWCacheRead(ls_repofile, USER_KEY, lblb_syntax, ll_syntaxlen) = false then
	return FAILURE
end if

// get meta data from the contents
pf_f_parsetohashtable(string(blobmid(lblb_syntax, 1, 100), EncodingAnsi!), ';', lnv_header)
ls_dwdesigner = lnv_header.of_get('dwdesigner')
ls_dsnrmodified = trim(lnv_header.of_getstring('lastmodified'))

// compare current name with original name of dwdesginer
if as_dwdesigner <> ls_dwdesigner then return NO_ACTION

// get last modified datetime of dwdesigner object
ls_dsnrfile = is_objpath + '\' + ls_dwdesigner + '.js'
if not FileExists(ls_dsnrfile) then return FAILURE
gnv_extfunc.of_getfilewritetime(ls_dsnrfile, ls_objmodified)

// compare current datetime with original datetime of dwdesginer
if ls_dsnrmodified <> ls_objmodified then return NO_ACTION

// set datawindow syntax to referenced argument
as_syntax = string(blobmid(lblb_syntax, 101), EncodingAnsi!)

//this.of_testlog('c:\temp\a.log', 'of_getdataobjectsyntax() = Dataobject: ' + as_dataobject + ' succeed')

return SUCCESS

end function

public function integer of_setdataobjectsyntax (string as_dataobject, string as_dwdesigner, string as_syntax);// as_dataobject 데이터윈도우 오브젝트의 Syntax를 저장합니다.

if appeongetclienttype() <> 'WEB' then return NO_ACTION

string ls_metafile, ls_repofile, ls_dsnrfile
string ls_metamodified, ls_dsnrmodified
string ls_header
blob lblb_syntax
long ll_syntaxlen

// get last modified datetime of metafile
ls_metafile = is_metapath + '\' + as_dataobject + '.dat'
if not FileExists(ls_metafile) then return FAILURE
gnv_extfunc.of_getfilewritetime(ls_metafile, ls_metamodified)

// get last modified datetime of dwdesigner object
ls_dsnrfile = is_objpath + '\' + as_dwdesigner + '.js'
if not FileExists(ls_dsnrfile) then return FAILURE
gnv_extfunc.of_getfilewritetime(ls_dsnrfile, ls_dsnrmodified)

// write dataobject syntax to temporary folder
ls_repofile = is_repopath + '\' + as_dataobject
ls_header = 'dwdesigner=' + as_dwdesigner + ';lastmodified=' + ls_dsnrmodified
ls_header += space(100 - lenA(ls_header))

lblb_syntax = blob(ls_header, EncodingAnsi!)
lblb_syntax += blob(as_syntax, EncodingAnsi!)

ll_syntaxlen = len(lblb_syntax)
if gnv_extfunc.pf_dwcachewrite(ls_repofile, USER_KEY, lblb_syntax, ll_syntaxlen) = false then
	return FAILURE
end if

// set file write time with the same as meta file write time
gnv_extfunc.of_setfilewritetime(ls_repofile, ls_metamodified)

//this.of_testlog('c:\temp\a.log', 'of_setdataobjectsyntax() = Dataobject: ' + as_dataobject + ' succeed')

return SUCCESS

end function

public subroutine of_initialize (powerobject apo_target, window awo_parent, string as_dwdesigner);// 아규먼트 서비스를 초기화하는 함수
// adw_datawindow: 아규먼스 서비스를 제공할 데이터윈도우
// 리턴값: 없음

if not isvalid(apo_target) then
	messagebox('알림', '올바르지 않은 함수호출 입니다.~r~npf_n_dataobjrepo.of_initialize()')
	return
end if

// 처리대상 데이터윈도우 보관
ipo_target = apo_target

// 부모 윈도우 보관
iw_parent = awo_parent

// 디자인 오브젝트 명칭
is_dwdesigner = as_dwdesigner

end subroutine

public function integer of_backupdesignedsyntax ();// 디자인처리된 데이터윈도우 Syntax를 보관합니다.

if appeongetclienttype() <> 'WEB' then return NO_ACTION

if not isvalid(ipo_target) then return -1

string ls_syntax
integer li_rc

datawindow ldw_target
ldw_target = ipo_target

ls_syntax = ldw_target.describe('datawindow.syntax')
li_rc =  this.of_setdataobjectsyntax(ldw_target.dataobject, is_dwdesigner, ls_syntax)

return li_rc

end function

public function integer of_applydesignedsyntax ();if appeongetclienttype() <> 'WEB' then return NO_ACTION

if not isvalid(ipo_target) then return -1

string ls_syntax, ls_error

datawindow ldw_target
ldw_target = ipo_target

if this.of_getdataobjectsyntax(ldw_target.dataobject, is_dwdesigner, ls_syntax) = 1 then
	if ldw_target.create(ls_syntax, ls_error) = 1 then
		return 1
	else
		::clipboard(ls_syntax)
		messagebox('pf_n_dataobjrepo.of_applycachedsyntax() failure!!', ls_error)
		return -1
	end if
end if

return 0

end function

on pf_n_dataobjrepo.create
call super::create
end on

on pf_n_dataobjrepo.destroy
call super::destroy
end on

event constructor;call super::constructor;is_metapath = appeongetcachedir() + '\meta'
is_repopath = is_metapath + '\dataobjrepo'
is_objpath = appeongetcachedir()

// 테스트용 임시 설정
if appeongetclienttype() = 'PB' then
	is_objpath = 'C:\Users\haan\AppData\Roaming\appeon\localhost_powerframe'
	is_metapath = is_objpath + '\meta'
	is_repopath = is_metapath + '\dataobjrepo'
end if	

if not FileExists ( is_repopath ) then
	CreateDirectory ( is_repopath )
end if

end event

