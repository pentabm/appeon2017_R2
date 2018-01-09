$PBExportHeader$pf_u_hscrollbar.sru
$PBExportComments$파워프레임용 HScrollBar 컨트롤 입니다.
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

