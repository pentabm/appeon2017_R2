$PBExportHeader$pf_u_vscrollbar.sru
$PBExportComments$파워프레임용 VscrollBar 컨트롤 입니다.
forward
global type pf_u_vscrollbar from vscrollbar
end type
end forward

global type pf_u_vscrollbar from vscrollbar
integer width = 78
integer height = 272
event type boolean pfe_ispowerframecontrol ( )
end type
global pf_u_vscrollbar pf_u_vscrollbar

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

public function string of_getclassname ();return 'pf_u_vscrollbar'

end function

on pf_u_vscrollbar.create
end on

on pf_u_vscrollbar.destroy
end on

