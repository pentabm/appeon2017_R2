HA$PBExportHeader$pf_u_oval.sru
$PBExportComments$$$HEX7$$0cd3ccc604d508b884c7a9c62000$$ENDHEX$$Oval $$HEX7$$e8ceb8d264b8200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_u_oval from oval
end type
end forward

global type pf_u_oval from oval
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 1073741824
integer width = 402
integer height = 340
event type boolean pfe_ispowerframecontrol ( )
end type
global pf_u_oval pf_u_oval

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

public function string of_getclassname ();return 'pf_u_oval'

end function

on pf_u_oval.create
end on

on pf_u_oval.destroy
end on

