HA$PBExportHeader$pf_n_animate.sru
$PBExportComments$$$HEX27$$08c7c4b3b0c6200060c5c8b254ba74c758c12000a8d6fcac7cb92000c0c9d0c658d594b2200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_animate from nonvisualobject
end type
end forward

global type pf_n_animate from nonvisualobject
end type
global pf_n_animate pf_n_animate

type prototypes
Function boolean AnimateWindow(ulong lhWnd, long lTm, long lFlags) Library 'user32.dll'

end prototypes

type variables
// $$HEX6$$a4c26cd064b8200029bca5d5$$ENDHEX$$
Constant Integer TopDown = 1		// $$HEX7$$04c7d0c51cc1200044c598b75cb8$$ENDHEX$$
Constant Integer LeftToRight = 2	// $$HEX6$$8cc8d0c51cc12000b0c65cb8$$ENDHEX$$
Constant Integer RightToLeft = 3	// $$HEX6$$b0c6d0c51cc120008cc85cb8$$ENDHEX$$
Constant Integer BottomUp = 4		// $$HEX7$$44c598b7d0c51cc1200004c75cb8$$ENDHEX$$

// $$HEX6$$a4c26cd064b82000dcc204ac$$ENDHEX$$
Constant Long ANIMATE_TIME = 200

// $$HEX11$$a4c26cd064b8200000b3c1c0200024c60cbe1dc8b8d2$$ENDHEX$$
PowerObject ipo_Target
//DragObject ipo_Target

// $$HEX9$$30aef8bc2000a4c26cd064b8200029bca5d5$$ENDHEX$$
Integer ii_direction = TopDown

end variables

forward prototypes
public function long of_getanimateflag (boolean ab_hide)
public function boolean of_hide ()
public function boolean of_show ()
public function long of_getanimateflag (integer ai_direction, boolean ab_hide)
public function boolean of_hide (readonly powerobject lpo_target)
public function boolean of_hide (readonly powerobject lpo_target, integer ai_direction)
public subroutine of_initialize (readonly powerobject apo_target)
public subroutine of_initialize (readonly powerobject apo_target, integer ai_direction)
public function boolean of_show (readonly powerobject lpo_target, integer ai_direction)
public function boolean of_show (readonly powerobject lpo_target)
end prototypes

public function long of_getanimateflag (boolean ab_hide);return this.of_getanimateflag(ii_Direction, ab_hide)

end function

public function boolean of_hide ();return this.of_hide(ipo_target, ii_direction)

end function

public function boolean of_show ();return this.of_show(ipo_target, ii_direction)

end function

public function long of_getanimateflag (integer ai_direction, boolean ab_hide);// Animate the window from left to right
Constant Long AW_HOR_POSITIVE = 1
// Animate the window from right to left
Constant Long AW_HOR_NEGATIVE = 2 
// Animate the window from top to bottom
Constant Long AW_VER_POSITIVE = 4 
// Animate the window from bottom to
Constant Long AW_VER_NEGATIVE = 8
// Makes the window appear to collapse inward
Constant Long AW_CENTER = 16
// Hides the window
Constant Long AW_HIDE = 65536
// Activates the window
Constant Long AW_ACTIVATE = 131072
// Uses slide animation
Constant Long AW_SLIDE = 262144
// Uses a fade effect
Constant Long AW_BLEND = 524288

Long ll_rv

CHOOSE CASE ai_Direction
	CASE TopDown
		IF ab_hide THEN
			ll_rv = AW_SLIDE + AW_VER_NEGATIVE + AW_HIDE
		ELSE
			ll_rv = AW_SLIDE + AW_VER_POSITIVE + AW_ACTIVATE
		END IF
	CASE LeftToRight
		IF ab_hide THEN
			ll_rv = AW_SLIDE + AW_HOR_NEGATIVE + AW_HIDE
		ELSE
			ll_rv = AW_SLIDE + AW_HOR_POSITIVE + AW_ACTIVATE
		END IF
	CASE RightToLeft
		IF ab_hide THEN
			ll_rv = AW_SLIDE + AW_HOR_POSITIVE + AW_HIDE
		ELSE
			ll_rv = AW_SLIDE + AW_HOR_NEGATIVE + AW_ACTIVATE
		END IF
	CASE BottomUp
		IF ab_hide THEN
			ll_rv = AW_SLIDE + AW_VER_POSITIVE + AW_HIDE
		ELSE
			ll_rv = AW_SLIDE + AW_VER_NEGATIVE + AW_ACTIVATE
		END IF
END CHOOSE

RETURN ll_rv

end function

public function boolean of_hide (readonly powerobject lpo_target);return this.of_hide(lpo_target, ii_direction)

end function

public function boolean of_hide (readonly powerobject lpo_target, integer ai_direction);Long	ll_Handle
Boolean lb_retval

setnull(lb_retval)
if not isvalid(lpo_target) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(pf_n_animate.of_hide)', '$$HEX19$$00b3c1c0200024c60cbe1dc8b8d200ac200020c1b8c518b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$')
	return lb_retval
end if

ll_Handle = Handle(lpo_target)
AnimateWindow(ll_Handle, ANIMATE_TIME, of_GetAnimateFlag(ai_direction, True)) 
//lpo_target.SetRedraw(True)

//lb_retval = lpo_target.visible
Return lb_retval

end function

public subroutine of_initialize (readonly powerobject apo_target);// $$HEX10$$00b3c1c0200024c60cbe1dc8b8d2200024c115c8$$ENDHEX$$
ipo_target = apo_target

end subroutine

public subroutine of_initialize (readonly powerobject apo_target, integer ai_direction);// $$HEX10$$00b3c1c0200024c60cbe1dc8b8d2200024c115c8$$ENDHEX$$
ipo_target = apo_target

// $$HEX8$$a4c26cd064b8200029bca5d524c115c8$$ENDHEX$$
ii_direction = ai_direction

end subroutine

public function boolean of_show (readonly powerobject lpo_target, integer ai_direction);Long ll_handle
Boolean lb_retval

setnull(lb_retval)
if not isvalid(lpo_target) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(pf_n_animate.of_show)', '$$HEX19$$00b3c1c0200024c60cbe1dc8b8d200ac200020c1b8c518b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$')
	return lb_retval
end if

ll_handle = Handle(lpo_target)
AnimateWindow(ll_Handle, ANIMATE_TIME, of_GetAnimateFlag(ai_direction, False))
//lpo_target.SetRedraw(True)

//lb_retval = lpo_target.visible
Return lb_retval

end function

public function boolean of_show (readonly powerobject lpo_target);return this.of_show(lpo_target, ii_direction)

end function

on pf_n_animate.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pf_n_animate.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

