HA$PBExportHeader$pf_u_userobject.sru
$PBExportComments$$$HEX6$$0cd3ccc604d508b884c72000$$ENDHEX$$User Object $$HEX17$$58c720005ccdc1c004c7200070c8c1c0200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$. $$HEX9$$a8bae0b420000cd3ccc604d508b884c72000$$ENDHEX$$User Object $$HEX18$$e4b440c7200074c7200024c60cbe1dc8b8d27cb92000c1c08dc120001bbcb5c2c8b2e4b2$$ENDHEX$$.
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

// Resize $$HEX2$$24c115c8$$ENDHEX$$
this.of_setresize(true)

// Arrange Controls
this.event resize(0, this.width, this.height)

// PostOpen $$HEX6$$74c7a4bcb8d2200038d69ccd$$ENDHEX$$
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

