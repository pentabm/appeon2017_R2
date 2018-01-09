$PBExportHeader$pf_w_frame.srw
$PBExportComments$파워프레임 메인 MDI 윈도우의 최상위 조상 오브젝트 입니다.
forward
global type pf_w_frame from window
end type
type mdi_1 from mdiclient within pf_w_frame
end type
type st_mdiclient from pf_u_statictext within pf_w_frame
end type
end forward

global type pf_w_frame from window
integer width = 4686
integer height = 2992
boolean titlebar = true
string title = "PowerFrame"
string menuname = "pf_m_empty"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdi!
string icon = "AppIcon!"
boolean toolbarvisible = false
boolean center = true
event pfe_postopen ( )
mdi_1 mdi_1
st_mdiclient st_mdiclient
end type
global pf_w_frame pf_w_frame

type variables
// 공통 리턴값 상수
constant integer SUCCESS = 1
constant integer FAILURE = -1
constant integer NO_ACTION = 0

// 계속/중지 리턴값 상수
constant integer CONTINUE_ACTION = 1
constant integer PREVENT_ACTION = 0

private:
	boolean ib_resize = false
	
protected:
	pf_n_resize inv_resize

end variables

forward prototypes
public function integer of_setresize (boolean ab_switch)
public function long of_eventdispatcher (string as_objectname, string as_eventname, pf_n_hashtable anvo_parameter)
public function string of_getclassname ()
public subroutine of_setmdiclientborder (integer ai_borderstyle)
public function integer of_checkactivesheetstate ()
public function windowobject of_getwindowobjectbyname (string as_objname)
end prototypes

event pfe_postopen();ib_resize = true

// Resize 설정
this.event resize(0, This.WorkSpaceWidth(), This.WorkSpaceHeight())
this.post setredraw(true)

end event

public function integer of_setresize (boolean ab_switch);integer	li_rc

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid (inv_resize) then
		inv_resize = create pf_n_resize
		
//		// Appeon 환경일 경우 OriginalSize는 pf_n_appconfig에 정의된 값을 참조한다
//		if appeongetclienttype() = 'WEB' then
//			long ll_width, ll_height
//			
//			ll_width = long(gnv_appconf.of_getproperty("mainframe.original.width"))
//			ll_height = long(gnv_appconf.of_getproperty("mainframe.original.height"))
//			
//			inv_resize.of_SetOrigSize (ll_width, ll_height)
//			//inv_resize.of_SetMinSize (ll_width, ll_height)
//		else
//			inv_resize.of_SetOrigSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
//			//inv_resize.of_SetMinSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
//		end if
		
		if appeongetclienttype() = 'WEB' then
			inv_resize.of_SetOrigSize (5856, 3044)
			inv_resize.of_SetMinSize(pixelstounits(1024, xpixelstounits!), pixelstounits(768, ypixelstounits!))
			//inv_resize.of_SetMinSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
		else
			inv_resize.of_SetOrigSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
			//inv_resize.of_SetMinSize(pixelstounits(800, xpixelstounits!), pixelstounits(600, ypixelstounits!))
			//inv_resize.of_SetMinSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())			
		end if
		
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

public function long of_eventdispatcher (string as_objectname, string as_eventname, pf_n_hashtable anvo_parameter);integer i, li_retval

li_retval = -1
for i = 1 to upperbound(this.control)
	if this.control[i].triggerevent('pfe_ispowerframecontrol') = 1 then
		if this.control[i].dynamic of_getclassname() = as_objectname then
			gnv_session.of_put(as_objectname, anvo_parameter)
			if this.control[i].triggerevent(as_eventname) = 1 then
				gnv_session.of_remove(as_objectname)
				li_retval = gnv_session.of_getint('ReturnValue')
				exit
			end if
		end if
	end if
next

return li_retval

end function

public function string of_getclassname ();return 'pf_w_frame'

end function

public subroutine of_setmdiclientborder (integer ai_borderstyle);// setmdiclientborder
gnv_extfunc.pf_setmdiclientborder(handle(mdi_1), ai_borderstyle)

end subroutine

public function integer of_checkactivesheetstate ();// Sheet 윈도우 Open시 Close(This) 명령이 수행되면 WindowState가 Maximized -> Normal 상태로 변경됨
// 상태 체크 후 원래대로 Maximized 처리
window lw_activesheet

lw_activesheet = This.GetActiveSheet()
IF IsValid(lw_activesheet) THEN
	IF lw_activesheet.windowstate <> Maximized! THEN
		lw_activesheet.windowstate = Maximized!
	END IF
END IF

Return 0

end function

public function windowobject of_getwindowobjectbyname (string as_objname);// 윈도우가 포함하고있는 컨트롤 중에 as_objname과 동일한
// 명칭을 가지는 오브젝트를 리턴합니다.

integer i, li_cnter
windowobject lwo_ret

li_cnter  = upperbound(this.control)
for  i  = 1 to  li_cnter
	if  this.control[i].classname() = as_objname  then
		lwo_ret = this.control[i]
		exit
	end  if
next

return lwo_ret

end function

on pf_w_frame.create
if this.MenuName = "pf_m_empty" then this.MenuID = create pf_m_empty
this.mdi_1=create mdi_1
this.st_mdiclient=create st_mdiclient
this.Control[]={this.mdi_1,&
this.st_mdiclient}
end on

on pf_w_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.st_mdiclient)
end on

event open;this.setredraw(false)
SetPointer(HourGlass!)

// MDI Client 설정
mdi_1.backcolor = rgb(255, 255, 255)
mdi_1.move(st_mdiclient.x, st_mdiclient.y)
this.of_setmdiclientborder(3)

// System Color 설정
pf_s_syscolor lstr_param
lstr_param.color_highlight = RGB(167,205,240)	//RGB(94,172,248)
lstr_param.color_highlighttext = RGB(33,39,45)
lstr_param.color_btnface = RGB(210,210,210)
gnv_extfunc.of_SetSystemColor(lstr_param)

ib_resize = false
this.of_setresize(true)

this.post event pfe_postopen()

end event

event resize;//if ib_resize = false then return

if IsValid (inv_resize) then
	if appeongetclienttype() = 'WEB' then
		inv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
	else
		inv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
	end if
end if

end event

type mdi_1 from mdiclient within pf_w_frame
long BackColor=268435456
end type

type st_mdiclient from pf_u_statictext within pf_w_frame
event ue_move pbm_move
event resize pbm_size
integer x = 896
integer y = 604
integer width = 3721
integer height = 2176
long bordercolor = 10789024
boolean scaletoright = true
boolean scaletobottom = true
end type

event ue_move;mdi_1.x = xpos
mdi_1.y = ypos


end event

event resize;mdi_1.width = this.width
mdi_1.height = this.height

end event

