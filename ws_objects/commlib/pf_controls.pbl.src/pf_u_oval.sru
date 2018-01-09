$PBExportHeader$pf_u_oval.sru
$PBExportComments$파워프레임용 Oval 컨트롤 입니다.
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

