$PBExportHeader$pf_u_roundrectangle.sru
$PBExportComments$파워프레임용 RoundRectangle 컨트롤 입니다.
forward
global type pf_u_roundrectangle from roundrectangle
end type
end forward

global type pf_u_roundrectangle from roundrectangle
long linecolor = 12632256
integer linethickness = 4
long fillcolor = 1073741824
integer width = 402
integer height = 400
integer cornerheight = 40
integer cornerwidth = 55
event type boolean pfe_ispowerframecontrol ( )
end type
global pf_u_roundrectangle pf_u_roundrectangle

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

public function string of_getclassname ();return 'pf_u_roundrectangle'

end function

on pf_u_roundrectangle.create
end on

on pf_u_roundrectangle.destroy
end on

