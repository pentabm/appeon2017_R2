HA$PBExportHeader$pf_u_checkbox.sru
$PBExportComments$$$HEX7$$0cd3ccc604d508b884c7a9c62000$$ENDHEX$$CheckBox $$HEX7$$e8ceb8d264b8200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_u_checkbox from checkbox
end type
end forward

global type pf_u_checkbox from checkbox
integer width = 302
integer height = 84
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22172242
event type boolean pfe_ispowerframecontrol ( )
end type
global pf_u_checkbox pf_u_checkbox

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

public function string of_getclassname ();return 'pf_u_checkbox'

end function

on pf_u_checkbox.create
end on

on pf_u_checkbox.destroy
end on

