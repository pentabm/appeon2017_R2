$PBExportHeader$pf_u_userobject.sru
$PBExportComments$파워프레임 User Object 의 최상위 조상 오브젝트 입니다. 모든 파워프레임 User Object 들은 이 오브젝트를 상속 받습니다.
forward
global type pf_u_userobject from userobject
end type
type p_background from picture within pf_u_userobject
end type
end forward

global type pf_u_userobject from userobject
integer width = 1134
integer height = 572
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event type boolean pfe_ispowerframecontrol ( )
event pfe_postopen ( )
event resize pbm_size
p_background p_background
end type
global pf_u_userobject pf_u_userobject

type variables
// - Common return value constants:
constant integer SUCCESS = 1
constant integer FAILURE = -1
constant integer NO_ACTION = 0

// - Continue/Prevent return value constants:
constant integer CONTINUE_ACTION = 1
constant integer PREVENT_ACTION = 0

protected:
	window iw_parent
	pf_n_resize inv_resize

public:
	boolean TransparentBackground
	boolean FixedToRight
	boolean FixedToBottom
	boolean ScaleToRight
	boolean ScaleToBottom

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_setresize (boolean ab_switch)
end prototypes

event type boolean pfe_ispowerframecontrol();return true

end event

event resize;integer li_resize

this.setredraw(false)

If IsValid (inv_resize) Then
	li_resize = inv_resize.Event pfc_Resize (sizetype, newwidth, newheight)
End If

this.setredraw(true)

end event

public function string of_getclassname ();return 'pf_u_userobject'

end function

public function integer of_setresize (boolean ab_switch);integer	li_rc

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid (inv_resize) then
		inv_resize = create pf_n_resize
		inv_resize.of_SetOrigSize(this.width, this.height)
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

on pf_u_userobject.create
this.p_background=create p_background
this.Control[]={this.p_background}
end on

on pf_u_userobject.destroy
destroy(this.p_background)
end on

event constructor;// Get Parent Window
iw_parent = pf_f_getparentwindow(this)

// Resize 설정
this.of_setresize(true)

// Arrange Controls
this.event resize(0, this.width, this.height)

// PostOpen 이벤트 호출
this.post event pfe_postopen()

end event

type p_background from picture within pf_u_userobject
boolean visible = false
integer x = 5504
integer y = 4
integer width = 320
integer height = 168
boolean focusrectangle = false
end type

