$PBExportHeader$pf_u_picturelistbox.sru
$PBExportComments$파워프레임용 PictureListBox 컨트롤 입니다.
forward
global type pf_u_picturelistbox from picturelistbox
end type
end forward

global type pf_u_picturelistbox from picturelistbox
integer width = 549
integer height = 476
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22172242
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 536870912
event type boolean pfe_ispowerframecontrol ( )
end type
global pf_u_picturelistbox pf_u_picturelistbox

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

public function string of_getclassname ();return 'pf_u_picturelistbox'

end function

on pf_u_picturelistbox.create
end on

on pf_u_picturelistbox.destroy
end on

