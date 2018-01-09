HA$PBExportHeader$pf_u_hscrollbar.sru
$PBExportComments$$$HEX7$$0cd3ccc604d508b884c7a9c62000$$ENDHEX$$HScrollBar $$HEX7$$e8ceb8d264b8200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_u_hscrollbar from hscrollbar
end type
end forward

global type pf_u_hscrollbar from hscrollbar
integer width = 311
integer height = 68
event type boolean pfe_ispowerframecontrol ( )
end type
global pf_u_hscrollbar pf_u_hscrollbar

type variables
public:
	boolean FixedToRight
	boolean FixedToBottom
	boolean ScaleToRight
	boolean ScaleToBottom

end variables

forward prototypes
public function string of_getclassname ()
end prototypes

event type boolean pfe_ispowerframecontrol();return true

end event

public function string of_getclassname ();return 'pf_u_hscrollbar'

end function

on pf_u_hscrollbar.create
end on

on pf_u_hscrollbar.destroy
end on

