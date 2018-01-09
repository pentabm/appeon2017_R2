HA$PBExportHeader$pf_u_line.sru
$PBExportComments$$$HEX7$$0cd3ccc604d508b884c7a9c62000$$ENDHEX$$Line $$HEX7$$e8ceb8d264b8200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_u_line from line
end type
end forward

global type pf_u_line from line
long linecolor = 12632256
integer endx = 402
event type boolean pfe_ispowerframecontrol ( )
end type
global pf_u_line pf_u_line

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

public function string of_getclassname ();return 'pf_u_line'

end function

on pf_u_line.create
end on

on pf_u_line.destroy
end on

