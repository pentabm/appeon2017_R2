$PBExportHeader$pf_w_window.srw
forward
global type pf_w_window from window
end type
type ln_templeft from line within pf_w_window
end type
type ln_tempright from line within pf_w_window
end type
type ln_temptop from line within pf_w_window
end type
type ln_tempbuttom from line within pf_w_window
end type
type ln_tempbutton from line within pf_w_window
end type
type ln_tempstart from line within pf_w_window
end type
end forward

global type pf_w_window from window
integer width = 4626
integer height = 2364
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
event pfe_postopen ( )
event pfe_delete ( )
event pfe_execute ( )
event pfe_insert ( )
event pfe_print ( )
event pfe_reset ( )
event pfe_retrieve ( )
event pfe_update ( )
event type integer pfe_predelete ( )
event type integer pfe_preinsert ( )
event type integer pfe_preretrieve ( )
event type integer pfe_preupdate ( )
event pfe_updateend ( )
event pfe_shortcutkey ( string as_shortcutkey )
ln_templeft ln_templeft
ln_tempright ln_tempright
ln_temptop ln_temptop
ln_tempbuttom ln_tempbuttom
ln_tempbutton ln_tempbutton
ln_tempstart ln_tempstart
end type
global pf_w_window pf_w_window

type variables
// 공통 리턴값 상수
constant integer SUCCESS = 1
constant integer FAILURE = -1
constant integer NO_ACTION = 0

private:
	// 리사이즈용 윈도우 크기
	integer ii_width, ii_height
	
	// MDI 윈도우의 Sheet 정보
	long il_tab_seq, il_tool_seq, il_sheet_seq
	
	// 액션 데이터윈도우 참조변수
	pf_u_datawindow idw_target[]

public:
	// 윈도우 컨트롤 참조
	windowobject iwo_control[]
	
	// 파라미터 정보
	pf_n_hashtable inv_param
	
	// 부모 윈도우 참조
	window iw_parent
	
	// 컨트롤 리사이즈 서비스
	pf_n_resize inv_resize
	
	// 프로그램 메뉴 정보
	pf_n_menudata inv_menudata
	
	// 버튼권한 정보
	pf_n_buttonrole inv_buttonrole
	
	// 액션 수행할 데이터윈도우
	string TargetDatawindowForAction
	
	// 윈도우 종료시 업데이트 확인
	boolean ConfirmUpdateOnClose = false

end variables

forward prototypes
public subroutine of_getcontrols (graphicobject a_control, ref graphicobject a_controls[])
public function integer of_setresizeservice (boolean ab_switch)
public function windowobject of_getwindowobjectbyname (string as_objname)
public function string of_getclassname ()
public function integer of_setbuttonauthority ()
public function integer of_setmenudata ()
public function integer of_setmessage (string as_message)
end prototypes

event pfe_postopen();// 조회조건 Datawindow 에 SetFocus 처리 합니다
integer li_cnt
datawindow ldw_cond

for li_cnt = 1 to upperbound(iwo_control)
	if iwo_control[li_cnt].typeof() = datawindow! then
		if iwo_control[li_cnt].triggerevent("pfe_ispowerframecontrol") = 1 then
			if iwo_control[li_cnt].dynamic of_getclassname() = 'pf_u_datawindow' then
				if iwo_control[li_cnt].dynamic of_getservicepropertyvalue('isSearchCondition') = true then
					ldw_cond = iwo_control[li_cnt]
					ldw_cond.setfocus()
					exit
				end if
			end if
		end if
	end if
next

end event

event pfe_shortcutkey(string as_shortcutkey);// 단축키 입력시 호출되는 이벤트입니다(from pf_m_empty_shortcutkey)

end event

public subroutine of_getcontrols (graphicobject a_control, ref graphicobject a_controls[]);// 윈도우의 컨트롤을 배열형태로 구합니다. 
// Tab, UserObject 컨트롤과 그 안에 위치한 컨트롤을 포함합니다.
// a_controls[] 는 반드시 초기화된 상태로 호출해야 합니다. 
// 이 함수는 Recursive 형태로 구동되기 때문에 내부적으로 초기화하지 않습니다.

window lw_current
tab ltab_current
userobject luo_current
long ll_previous_elements, ll_total_elements, i

ll_previous_elements = UpperBound(a_controls)
ll_total_elements = ll_previous_elements

choose case a_control.TypeOf()
	case Window!
		lw_current = a_control
		for i = 1 to UpperBound(lw_current.Control)
			choose case lw_current.Control[i].classname()
				case 'pf_u_statictext', 'pf_u_commandbutton_overlay'
				case else
					ll_total_elements++
					a_controls[ll_total_elements] = lw_current.Control[i]
			end choose
		next
	case Tab!
		ltab_current = a_control
		for i = 1 to UpperBound(ltab_current.Control)
			choose case ltab_current.Control[i].classname()
				case 'pf_u_statictext', 'pf_u_commandbutton_overlay'
				case else
					ll_total_elements++
					a_controls[ll_total_elements] = ltab_current.Control[i]
			end choose
		next
	case UserObject!
		luo_current = a_control
		for i = 1 to UpperBound(luo_current.Control)
			choose case luo_current.Control[i].classname()
				case 'pf_u_statictext', 'pf_u_commandbutton_overlay'
				case else
					ll_total_elements++
					a_controls[ll_total_elements] = luo_current.Control[i]
			end choose
		next
	case else
		return
end choose

for i = ll_previous_elements + 1 to ll_total_elements
	choose case a_controls[i].TypeOf()
		case Window!, Tab!, UserObject!
			this.of_getcontrols(a_controls[i], a_controls)
	end choose
next

end subroutine

public function integer of_setresizeservice (boolean ab_switch);integer	li_rc

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid (inv_resize) then
		inv_resize = create pf_n_resize
		inv_resize.of_SetOrigSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
		inv_resize.of_AutoResizeRegister(this)
		li_rc = 1
	end if
else
	if IsValid (inv_resize) then
		destroy inv_resize
		li_rc = 1
	end if
end If

return li_rc

end function

public function windowobject of_getwindowobjectbyname (string as_objname);// 윈도우가 포함하고있는 컨트롤 중에 as_objname과 동일한
// 명칭을 가지는 오브젝트를 리턴합니다.

integer i, li_cnter
windowobject lwo_ret

li_cnter = upperbound(iwo_control)
if li_cnter = 0 then
	this.of_getcontrols(this, iwo_control)
	li_cnter = upperbound(iwo_control)
end if

for i = 1 to li_cnter
	if iwo_control[i].classname() = as_objname then
		lwo_ret = iwo_control[i]
		exit
	end if
next

return lwo_ret

end function

public function string of_getclassname ();return 'pf_w_window'

end function

public function integer of_setbuttonauthority ();// 프로그램 버튼 사용 권한 - 등록된 내용에 따라서 버튼을 Enable/Disable 처리 합니다.
if not isvalid(inv_buttonrole) then
	inv_buttonrole = create pf_n_buttonrole
end if

inv_buttonrole.of_registerparent(this)

// 권한관리할 버튼명칭 등록
inv_buttonrole.of_registerbuttonarr('retrieve', { 'cb_retrieve', 'cb_ret', 'cb_inq', 'p_retrieve', 'p_ret', 'p_inq' })
inv_buttonrole.of_registerbuttonarr('insert', { 'cb_insert', 'cb_ins', 'cb_input', 'cb_insertrow', 'cb_add', 'p_insert', 'p_ins', 'p_input', 'p_insertrow', 'p_add' })
inv_buttonrole.of_registerbuttonarr('delete', { 'cb_delete', 'cb_del', 'p_delete', 'p_del' })
inv_buttonrole.of_registerbuttonarr('update', { 'cb_update', 'cb_upd', 'cb_save', 'cb_modify', 'p_update', 'p_upd', 'p_save', 'p_modify' })
inv_buttonrole.of_registerbuttonarr('print', { 'cb_print', 'cb_prt', 'cb_printer', 'p_print', 'p_prt', 'p_printer' })

// 버튼 권한 적용
inv_buttonrole.of_authorize()

return 0

end function

public function integer of_setmenudata ();// 넘겨받은 메뉴 데이터가 있으면 그대로 사용
if gnv_session.of_containskey(upper(this.classname())) = true then
	inv_menudata = gnv_session.of_get(upper(this.classname()))
	gnv_session.of_remove(upper(this.classname()))
end if

// 넘겨받은 메뉴데이터가 없는 경우 직접 생성
// =개발자가 직접 OpenSheet 오픈한 경우
if not isvalid(inv_menudata) then
	pf_n_rolemenu lnv_rolemenu
	lnv_rolemenu = create pf_n_rolemenu
	inv_menudata = create pf_n_menudata
	
	if lnv_rolemenu.of_getmenudata_by_pgmid(upper(this.classname()), inv_menudata) = 0 then
		inv_menudata.is_pgm_id = this.classname()
		inv_menudata.is_menu_id = inv_menudata.is_pgm_id
		inv_menudata.is_pgm_name = this.title
	end if
end if

return 0

end function

public function integer of_setmessage (string as_message);// MDI 윈도우 Status Bar 에 메시지 표시

if isvalid(iw_parent) then
	inv_param.of_clear()
	inv_param.of_put('message', as_message)
	iw_parent.dynamic of_eventdispatcher('pf_u_mdi_statusbar', 'pfe_setmessage', inv_param)
end if

return 0

end function

on pf_w_window.create
this.ln_templeft=create ln_templeft
this.ln_tempright=create ln_tempright
this.ln_temptop=create ln_temptop
this.ln_tempbuttom=create ln_tempbuttom
this.ln_tempbutton=create ln_tempbutton
this.ln_tempstart=create ln_tempstart
this.Control[]={this.ln_templeft,&
this.ln_tempright,&
this.ln_temptop,&
this.ln_tempbuttom,&
this.ln_tempbutton,&
this.ln_tempstart}
end on

on pf_w_window.destroy
destroy(this.ln_templeft)
destroy(this.ln_tempright)
destroy(this.ln_temptop)
destroy(this.ln_tempbuttom)
destroy(this.ln_tempbutton)
destroy(this.ln_tempstart)
end on

event open;// 모든 윈도우 컨트롤 보관
this.of_getcontrols(this, iwo_control[])

// 리사이즈 서비스 활성화
this.of_setresizeservice(true)

// 부모 윈도우 구하기
iw_parent = this.parentwindow()

// 메뉴 정보 설정하기
this.of_setmenudata()

// 윈도우 타이틀 설정
if inv_menudata.is_pgm_name <> this.title then
	this.title = inv_menudata.is_pgm_name
end if

// 윈도우 타입에 따른 추가 작업
choose case this.windowtype
	case main!
		// SHEET 윈도우 기본 속성 확인
		if this.controlmenu <> false then this.controlmenu = false
		if this.maxbox <> true then this.maxbox = true
		if this.minbox <> true then this.minbox = true
		if this.windowstate <> maximized! then this.windowstate = maximized!
		
		// MDI 윈도우 컨트롤 이벤트 호출
		inv_param = create pf_n_hashtable
		inv_param.of_put('menu_id', inv_menudata.is_menu_id)
		inv_param.of_put('pgm_id', inv_menudata.is_pgm_id)
		inv_param.of_put('pgm_name', inv_menudata.is_pgm_name)
		inv_param.of_put('sheet_ref', this)
		
		// sheet_tab_bar 컨트롤 설정
		il_tab_seq = iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheettab', 'pfe_addsheettab', inv_param)
		
		// tool_bar 컨트롤 설정
		il_tool_seq = iw_parent.dynamic of_eventdispatcher('pf_u_mdi_toolbar', 'pfe_addsheet', inv_param)
		
		// sheet_navi_bar 컨트롤 설정
		il_sheet_seq = iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheetnavi', 'pfe_setwindowname', inv_param)
end choose

// 버튼 Enable/Disable 처리
this.of_setbuttonauthority()

// pfe_PostEvent 호출
This.Post Event pfe_postopen()

end event

event activate;// CurrentDirectory 변경여부 확인, 디폴트 폴더로 원복처리
if appeongetclienttype() = 'PB' then
	if getcurrentdirectory() <> gnv_appmgr.is_currentdir then
		changedirectory(gnv_appmgr.is_currentdir)
	end if
end if

// 윈도우 타입에 따른 추가 작업
choose case this.windowtype
	case main!
		if isvalid(iw_parent) then
			if il_tab_seq > 0 then
				// sheettab 컨트롤
				inv_param.of_clear()
				inv_param.of_put('tab_seq', il_tab_seq)
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheettab', 'pfe_selectsheettab', inv_param)
				
				// toolbar 컨트롤
				inv_param.of_clear()
				inv_param.of_put('tool_seq', il_tool_seq)
				inv_param.of_put('button_role', inv_buttonrole)
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_toolbar', 'pfe_selectsheet', inv_param)
				
				// sheetnavi 컨트롤
				inv_param.of_clear()
				inv_param.of_put('sheet_seq', il_sheet_seq)
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheetnavi', 'pfe_selectsheet', inv_param)
				
				// statusbar 컨트롤
				inv_param.of_clear()
				inv_param.of_put('window_id', this.classname())
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_statusbar', 'pfe_setwindowname', inv_param)
			end if
		end if
end choose

end event

event resize;// Width, Height 윈도우 사이즈가 변경된 경우 리사이즈 서비스 수행
If ii_width <> newwidth Or ii_height <> newheight Then
	If IsValid (inv_resize) Then
		inv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
		ii_width = newwidth
		ii_height = newheight
	End If
End If

end event

event deactivate;choose case this.windowtype
	case main!
		if isvalid(iw_parent) then
			if il_tab_seq > 0 then
				// sheettab 컨트롤
				inv_param.of_clear()
				inv_param.of_put('tab_seq', il_tab_seq)
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheettab', 'pfe_deselectsheettab', inv_param)
				
				// toolbar 컨트롤
				inv_param.of_clear()
				inv_param.of_put('tool_seq', il_tool_seq)
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_toolbar', 'pfe_deselectsheet', inv_param)
				
				// sheetnavi 컨트롤
				inv_param.of_clear()
				inv_param.of_put('sheet_seq', il_sheet_seq)
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheetnavi', 'pfe_deselectsheet', inv_param)
				
				// statusbar 컨트롤
				inv_param.of_clear()
				inv_param.of_put('window_id', '')
				iw_parent.dynamic of_eventdispatcher('pf_u_mdi_statusbar', 'pfe_setwindowname', inv_param)
			end if
		end if
end choose

end event

event close;if isvalid(iw_parent) then
	if this.windowtype = main! then
		if il_tab_seq > 0 then
			// sheettab 컨트롤
			inv_param.of_clear()
			inv_param.of_put('tab_seq', il_tab_seq)
			iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheettab', 'pfe_closesheettab', inv_param)
			
			// toolbar 컨트롤
			inv_param.of_clear()
			inv_param.of_put('tool_seq', il_tool_seq)
			iw_parent.dynamic of_eventdispatcher('pf_u_mdi_toolbar', 'pfe_closesheet', inv_param)

			// sheetnavi 컨트롤
			inv_param.of_clear()
			inv_param.of_put('sheet_seq', il_sheet_seq)
			iw_parent.dynamic of_eventdispatcher('pf_u_mdi_sheetnavi', 'pfe_closesheet', inv_param)

			// Clear Message
			of_setmessage('')
		end if
		
		// appeon 환경인 경우 sheet 종료 후 mdi_1.border가 복원됨
		if appeongetclienttype() = 'WEB' then
			iw_parent.post dynamic of_setmdiclientborder(3)
		end if
		
		// 윈도우 Open시 Close(This) 명령이 수행되면 WindowState가 Maximized -> Normal 상태로 변경됨
		iw_parent.dynamic post of_checkactivesheetstate()
	end if
end if			

end event

type ln_templeft from line within pf_w_window
boolean visible = false
long linecolor = 134217857
integer linethickness = 2
integer beginx = 46
integer beginy = 24
integer endx = 46
integer endy = 2272
end type

type ln_tempright from line within pf_w_window
boolean visible = false
long linecolor = 134217857
integer linethickness = 2
integer beginx = 4549
integer beginy = 24
integer endx = 4549
integer endy = 2272
end type

type ln_temptop from line within pf_w_window
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 36
integer endx = 4590
integer endy = 36
end type

type ln_tempbuttom from line within pf_w_window
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 2220
integer endx = 4590
integer endy = 2220
end type

type ln_tempbutton from line within pf_w_window
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 120
integer endx = 4590
integer endy = 120
end type

type ln_tempstart from line within pf_w_window
boolean visible = false
long linecolor = 134217857
integer linethickness = 4
integer beginy = 160
integer endx = 4590
integer endy = 160
end type

