HA$PBExportHeader$pf_u_listview.sru
$PBExportComments$$$HEX7$$0cd3ccc604d508b884c7a9c62000$$ENDHEX$$ListView $$HEX7$$e8ceb8d264b8200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_u_listview from listview
end type
end forward

global type pf_u_listview from listview
integer width = 549
integer height = 476
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22172242
borderstyle borderstyle = stylelowered!
long largepicturemaskcolor = 536870912
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
event type boolean pfe_ispowerframecontrol ( )
end type
global pf_u_listview pf_u_listview

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

public function string of_getclassname ();return 'pf_u_listview'

end function

on pf_u_listview.create
end on

on pf_u_listview.destroy
end on

event constructor;// pb listview control flickers on windows xp when resizing .
// set listview extended style to LVS_EX_DOUBLEBUFFER could solve it.

//LVM_FIRST = 4096
//LVM_SETEXTENDEDLISTVIEWSTYLE = (LVM_FIRST + 54)
//LVS_EX_DOUBLEBUFFER    = 65536
Send(handle(this), 4096+54, 65536, 65536)

end event

