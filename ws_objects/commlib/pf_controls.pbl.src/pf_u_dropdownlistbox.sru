$PBExportHeader$pf_u_dropdownlistbox.sru
$PBExportComments$파워프레임용 DropDownListBox 컨트롤 입니다.
forward
global type pf_u_dropdownlistbox from dropdownlistbox
end type
end forward

global type pf_u_dropdownlistbox from dropdownlistbox
integer width = 402
integer height = 476
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22172242
boolean border = false
integer limit = 12
borderstyle borderstyle = stylelowered!
event type boolean pfe_ispowerframecontrol ( )
end type
global pf_u_dropdownlistbox pf_u_dropdownlistbox

type variables
protected:
	integer ii_SelectedIndex

public:
	boolean FixedToRight
	boolean FixedToBottom
	boolean ScaleToRight
	boolean ScaleToBottom

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_getselectedindex ()
public function integer selectitem (integer i)
public function integer selectitem (string s, integer i)
end prototypes

event type boolean pfe_ispowerframecontrol();return true

end event

public function string of_getclassname ();return 'pf_u_dropdownlistbox'

end function

public function integer of_getselectedindex ();return ii_selectedindex

end function

public function integer selectitem (integer i);integer li_rc

li_rc = super::selectitem(i)
if li_rc > 0 then
	ii_SelectedIndex = i
end if

return li_rc

end function

public function integer selectitem (string s, integer i);integer li_rc

li_rc = super::selectitem(s, i)
if li_rc > 0 then
	ii_SelectedIndex = li_rc
end if

return li_rc

end function

on pf_u_dropdownlistbox.create
end on

on pf_u_dropdownlistbox.destroy
end on

event selectionchanged;ii_selectedindex = index

end event

