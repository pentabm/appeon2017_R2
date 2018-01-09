$PBExportHeader$pf_n_datastore.sru
$PBExportComments$데이터스토어 Ancestor 입니다. 파워프레임에서 제공되는 데이터스토어 기능들을 사용하기 위해서는 이 오브젝트를 사용해야 합니다.
forward
global type pf_n_datastore from datastore
end type
end forward

global type pf_n_datastore from datastore
event type boolean pfe_ispowerframecontrol ( )
end type
global pf_n_datastore pf_n_datastore

type variables
// 공통 리턴값 상수
constant integer SUCCESS = 1
constant integer FAILURE = -1
constant integer NO_ACTION = 0

// 계속/중지 리턴값 상수
constant integer CONTINUE_ACTION = 1
constant integer PREVENT_ACTION = 0

private:
	transaction itr_trans

public:
	// parent window
	window iw_parent

	// restroed dberror information
	pf_s_dwdberror istr_dberror
	
	// argument service
	pf_n_argument inv_args
	string RetrievalArguments
	
	long HeaderBandColor = RGB(230,226,219)
	long DetailBandColor = 536870912

end variables

forward prototypes
public function string of_getclassname ()
public function integer settransobject (transaction t)
public function string of_getevaluate (string as_expression, long al_row)
public function long of_retrievefromsql (string as_query)
public function integer of_createfromsql (string as_query)
public function integer of_addsearchcriteria ()
public function string of_getcolumnnamebydbname (string as_dbname, boolean ab_updatable)
public function transaction of_gettransobject ()
public function long of_retrieve ()
public function long of_getdberrorcode ()
public function string of_getdberrortext ()
public subroutine of_setparentwindow (window aw_parent)
public function integer of_setargumentservice (boolean ab_switch)
end prototypes

event type boolean pfe_ispowerframecontrol();return true

end event

public function string of_getclassname ();return 'pf_n_datastore'

end function

public function integer settransobject (transaction t);this.itr_trans = t
return super::settransobject(t)

end function

public function string of_getevaluate (string as_expression, long al_row);String		ls_temp
String		ls_data
Long		ll_row

IF al_row = 0 THEN
	ls_temp = "summary"
	ll_row = 1
ELSE
	ls_temp = "detail"
	ll_row = al_row
END IF

ls_temp = 'compute(band=' + ls_temp + ' alignment="0" expression="0" border="0" color="33554432" x="1371" y="4" height="50" width="544" format="[GENERAL]" html.valueishtml="0"  name=compute_evaluate_lookupdisplay visible="0"  font.face="Arial" font.height="-12" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="1073741824" )'
ls_temp = This.Modify("create " + ls_temp)
IF ls_temp = '?' THEN
	Messagebox("Info", "Create Evaluate Failed")
	Return ''
END IF

ls_temp = This.Modify('compute_evaluate_lookupdisplay.expression="' + as_expression + '"')
IF ls_temp = '?' THEN
	messagebox("Error", "Modify LookupDisplay Failed")
	Return ""
END IF

IF This.Rowcount() > 0 THEN ls_data = This.GetItemString(ll_row, 'compute_Evaluate_lookupdisplay')

ls_temp = This.Modify("destroy compute_Evaluate_lookupdisplay")
IF ls_temp = '?' THEN
	Messagebox("Info", "Destroy Evaluate Failed")
	Return ''
END IF

return ls_data
end function

public function long of_retrievefromsql (string as_query);// 주어진 쿼리문으로 데이터 오브젝트를 만들어
// 동적으로 데이터를 조회합니다. 

if isnull(itr_trans) or not isvalid(itr_trans) then return -1
if this.of_createfromsql(as_query) = -1 then return -1

this.settransobject(itr_trans)
return this.retrieve()

end function

public function integer of_createfromsql (string as_query);// 주어진 쿼리문으로 데이터 오브젝트를 동적으로 생성합니다.

string ls_syntax, ls_errmsg
string ls_format

if isnull(itr_trans) or not isvalid(itr_trans) then
	messagebox(This.Classname() + '.of_CreateFromSQL() 알림', '먼저 SetTransObject() 함수를 호출하세요')
	return -1
end if

if isnull(as_query) or len(trim(as_query)) = 0 then return -1

ls_format = "style(type=grid)~r~n"
ls_format += "column(color=22040656 font.face='맑은 고딕' font.height=-9 font.weight=400  font.family=1 font.pitch=2 font.charset=129 background.mode=1 background.color=536870912)~r~n"
ls_format += "text(color=20066866 font.face='맑은 고딕' font.height=-9 font.weight=400  font.family=1 font.pitch=2 font.charset=129 background.mode=1 background.color=536870912)"

ls_syntax = itr_trans.syntaxFromSQL(as_query, ls_format, ls_errmsg)
if len(ls_errmsg) > 0 then
	messagebox('of_retrievefromsql()', '잘못된 쿼리문입니다~r~n' + ls_errmsg)
	return -1
end if

this.create(ls_syntax, ls_errmsg)
if len(ls_errmsg) > 0 then
	messagebox('of_retrievefromsql()', '데이터윈도우 오브젝트 생성 오류~r~n' + ls_errmsg)
	return -1
end if

this.modify("Datawindow.Selected.Mouse=no DataWindow.Header.Color=" + string(HeaderBandColor) + " Datawindow.Header.Height=96 Datawindow.Detail.Height=96 Datawindow.Detail.Color=" + string(DetailBandColor))

return 1

end function

public function integer of_addsearchcriteria ();// WHERE 절에 조건을 추가합니다(작업중, 사용하지 마세요)

//pf_n_regexp lnv_regexp
//string ls_query, ls_objref[]
//long ll_refcnt, i
//
//ls_query = this.GetSqlSelect()
//messagebox("ls_query", ls_query)
//
//lnv_regexp = create pf_n_regexp
//ll_refcnt = lnv_regexp.of_findmatches(ls_query, "(\w+\.\w+(\[\d+\])?)", ls_objref[])
//
//for i = 1 to ll_refcnt
//	messagebox(string(i), ls_objref[i])
//next

return 0

end function

public function string of_getcolumnnamebydbname (string as_dbname, boolean ab_updatable);// DBName(Table Column명) 으로 Column Name을 찾아주는 함수 입니다.
// Updatable 컬럼만 검색할 경우 ab_updatable = true 로 설정.
// 찾는 컬럼이 없는 경우 Empty String('') 을 리턴합니다.

long ll_colcnt, ll_cnter, ll_pos
string ls_colname, ls_dbname

as_dbname = lower(as_dbname)
ll_colcnt = long(this.describe("Datawindow.Column.Count"))
for ll_cnter = 1 to ll_colcnt
	ls_colname = this.describe("#" + string(ll_cnter) + ".Name")

	if ab_updatable = true then
		if this.describe(ls_colname + ".Update") <> "yes" then continue
	end if
	
	ls_dbname = lower(this.describe(ls_colname + ".DBName"))
	if ls_dbname = as_dbname then return as_dbname
	
	ll_pos = pos(ls_dbname, '.')
	if ll_pos > 0 then
		ls_dbname = mid(ls_dbname, ll_pos + 1)
		if ls_dbname = as_dbname then return as_dbname
	end if
next

return ''

end function

public function transaction of_gettransobject ();return itr_trans

end function

public function long of_retrieve ();// 아규먼트 서비스를 이용해 데이터 스토어를 조회 합니다
// 리턴값: 성공=조회된 데이터 건수, 실패=-1

any la_args[]
long ll_rowcnt

// 아규먼트 서비스 비활성화 = 리턴
if not isvalid(inv_args) then return failure

// 아직 할당되지않은 아규먼트가 있는지 확인합니다
if this.inv_args.of_checknotassignedargument() = failure then return failure

// 아규먼트 값들을 산출 합니다
if this.inv_args.of_getallargumentvalue(la_args) = failure then return failure

// 조회 전 데이터윈도우 리셋
this.reset()

// 데이터를 조회합니다
choose case upperbound(la_args)
	case 0
		ll_rowcnt = this.retrieve()
	case 1
		ll_rowcnt = this.retrieve(la_args[1])
	case 2
		ll_rowcnt = this.retrieve(la_args[1], la_args[2])
	case 3
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3])
	case 4
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4])
	case 5
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5])
	case 6
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6])
	case 7
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7])
	case 8
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8])
	case 9
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9])
	case 10
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10])
	case 11
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11])
	case 12
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12])
	case 13
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13])
	case 14
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14])
	case 15
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15])
	case 16
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16])
	case 17
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17])
	case 18
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18])
	case 19
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19])
	case 20
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20])
	case 21
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21])
	case 22
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22])
	case 23
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23])
	case 24
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24])
	case 25
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25])
	case 26
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26])
	case 27
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27])
	case 28
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28])
	case 29
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29])
	case 30
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30])
	case 31
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31])
	case 32
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32])
	case 33
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33])
	case 34
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34])
	case 35
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35])
	case 36
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36])
	case 37
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37])
	case 38
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38])
	case 39
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39])
	case 40
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40])
	case 41
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41])
	case 42
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42])
	case 43
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43])
	case 44
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44])
	case 45
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44], la_args[45])
	case 46
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44], la_args[45], la_args[46])
	case 47
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44], la_args[45], la_args[46], la_args[47])
	case 48
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44], la_args[45], la_args[46], la_args[47], la_args[48])
	case 49
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44], la_args[45], la_args[46], la_args[47], la_args[48], la_args[49])
	case 50
		ll_rowcnt = this.retrieve(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10], la_args[11], la_args[12], la_args[13], la_args[14], la_args[15], la_args[16], la_args[17], la_args[18], la_args[19], la_args[20], la_args[21], la_args[22], la_args[23], la_args[24], la_args[25], la_args[26], la_args[27], la_args[28], la_args[29], la_args[30], la_args[31], la_args[32], la_args[33], la_args[34], la_args[35], la_args[36], la_args[37], la_args[38], la_args[39], la_args[40], la_args[41], la_args[42], la_args[43], la_args[44], la_args[45], la_args[46], la_args[47], la_args[48], la_args[49], la_args[50])
end choose

// 에러시 메시지 출력
if ll_rowcnt = -1 then
	messagebox('알림(DBCode=' + string(this.of_getdberrorcode()) + ')', '조회를 수행하는 중 아래와 같은 오류가 발생했습니다~r~n' + string(this.of_getdberrortext()))
	return failure
end if

return ll_rowcnt

end function

public function long of_getdberrorcode ();return istr_dberror.sqldbcode

end function

public function string of_getdberrortext ();return istr_dberror.sqlerrtext

end function

public subroutine of_setparentwindow (window aw_parent);iw_parent = aw_parent

end subroutine

public function integer of_setargumentservice (boolean ab_switch);// RetrievalArgument 서비스 설정
if ab_switch = true then
	if not isvalid(inv_args) then
		if not isvalid(iw_parent) then
			messagebox('알림', '데이터윈도우 아규먼트 서비스를 사용하려면 먼저 부모윈도우를 등록(of_setParentWindw) 해야 합니다')
			return failure
		end if
		
		inv_args = create pf_n_argument
		inv_args.of_initialize(this, iw_parent)
		if not pf_f_isemptystring(RetrievalArguments) then
			inv_args.of_parsearguments(RetrievalArguments)
		end if
	end if
else
	if isvalid(inv_args) then
		destroy inv_args
	end if
end if

return 1

end function

on pf_n_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pf_n_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event dberror;// 에러 정보 보관
istr_dberror.sqldbcode = sqldbcode
istr_dberror.sqlerrtext = sqlerrtext
istr_dberror.sqlsyntax = sqlsyntax
istr_dberror.errorrow = row

// Display the error message
return 0

end event

