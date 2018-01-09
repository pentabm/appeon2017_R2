$PBExportHeader$pf_u_richtextedit.sru
$PBExportComments$파워프레임용 RichTextEdit 컨트롤 입니다.
forward
global type pf_u_richtextedit from richtextedit
end type
end forward

global type pf_u_richtextedit from richtextedit
integer width = 457
integer height = 132
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
borderstyle borderstyle = stylelowered!
event type boolean pfe_ispowerframecontrol ( )
end type
global pf_u_richtextedit pf_u_richtextedit

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

public function string of_getclassname ();return 'pf_u_richtextedit'

end function

on pf_u_richtextedit.create
end on

on pf_u_richtextedit.destroy
end on

