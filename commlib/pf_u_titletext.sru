HA$PBExportHeader$pf_u_titletext.sru
$PBExportComments$$$HEX24$$4dd1a4c2b8d220005ec5d0c5200044c574c758cf44c72000d9b301c83cc75cb820005cd4dcc274d520000dc9c8b2e4b2$$ENDHEX$$. $$HEX20$$fcc85cb82000c0d074c7c0d220004dd1a4c2b8d22000a9c6c4b35cb82000acc0a9c629b4c8b2e4b2$$ENDHEX$$.
forward
global type pf_u_titletext from statictext
end type
end forward

global type pf_u_titletext from statictext
integer width = 457
integer height = 64
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 25123896
boolean focusrectangle = false
event type boolean pfe_ispowerframecontrol ( )
event pfe_visiblechanged pbm_showwindow
event move pbm_move
event pfe_enablechanged pbm_enable
end type
global pf_u_titletext pf_u_titletext

type variables
protected:
	window iw_parent
	picture inv_icon
	pf_s_size istr_size
	boolean ib_OnceOpened = false

public:
	string PostIconImage = '..\img\controls\u_titletext\titletext_icon1.jpg'
	boolean FixedToRight
	boolean FixedToBottom
	boolean ScaleToRight
	boolean ScaleToBottom

end variables

forward prototypes
public function string of_getclassname ()
public subroutine of_setvisible (boolean ab_visible)
public subroutine of_setenabled (boolean ab_enabled)
end prototypes

event type boolean pfe_ispowerframecontrol();return true

end event

event pfe_visiblechanged;if isvalid(inv_icon) then
	inv_icon.visible = this.visible
end if

end event

event move;if isvalid(inv_icon) then
	inv_icon.x = xpos - inv_icon.width - pixelstounits(3, xpixelstounits!)
	inv_icon.y = ypos + (this.height - inv_icon.height) / 2
end if

end event

event pfe_enablechanged;if isvalid(inv_icon) then
	inv_icon.enabled = this.enabled
end if

end event

public function string of_getclassname ();return 'pf_u_titletext'

end function

public subroutine of_setvisible (boolean ab_visible);this.visible = ab_visible

if appeongetclienttype() = 'WEB' then 
	this.event pfe_visiblechanged(ab_visible, 0)
end if

end subroutine

public subroutine of_setenabled (boolean ab_enabled);this.enabled = ab_enabled

if appeongetclienttype() = 'WEB' then 
	this.event pfe_enablechanged(ab_enabled)
end if

end subroutine

on pf_u_titletext.create
end on

on pf_u_titletext.destroy
end on

event constructor;if appeongetclienttype() <> 'PB' then
	if ib_OnceOpened = true then return
end if

if len(PostIconImage) = 0  then return

// backup message object before OpenUserObject()
message lm_backup
lm_backup = create message
lm_backup.Handle = message.Handle
lm_backup.Number = message.Number
lm_backup.WordParm = message.WordParm
lm_backup.LongParm = message.LongParm
lm_backup.DoubleParm = message.DoubleParm
lm_backup.StringParm = message.StringParm
lm_backup.PowerObjectParm = message.PowerObjectParm
lm_backup.Processed = message.Processed
lm_backup.ReturnValue = message.ReturnValue

iw_parent = pf_f_getparentwindow(this)

// Appeon $$HEX16$$58d6bdac7cc72000bdacb0c6200074c7f8bbc0c92000bdac5cb82000c0bcbdac$$ENDHEX$$
if AppeonGetClientType() = 'WEB' then
	PostIconImage = pf_f_getimagepathappeon(PostIconImage)
end if

gnv_extfunc.pf_getimagesize(PostIconImage, istr_size)

long ll_height, ll_width
long ll_xpos, ll_ypos

ll_height = pixelstounits(istr_size.height, ypixelstounits!)
ll_width = pixelstounits(istr_size.width, xpixelstounits!)

ll_xpos = this.x
ll_ypos = this.y + (this.height - ll_height) / 2
this.x = this.x + ll_width + pixelstounits(3, xpixelstounits!)

iw_parent.OpenUserObject(inv_icon, ll_xpos, ll_ypos)
if parent.typeof() = userobject! then
	gnv_extfunc.setparent(handle(inv_icon), handle(parent))
end if

inv_icon.picturename = PostIconImage
inv_icon.originalsize = true
//inv_icon.width = ll_width
//inv_icon.height = ll_height
inv_icon.bringtotop = true
if this.bringtotop = true then
	this.bringtotop = false
	this.setposition(behind!, inv_icon)
end if

// restore message object
message.Handle = lm_backup.Handle
message.Number = lm_backup.Number
message.WordParm = lm_backup.WordParm
message.LongParm = lm_backup.LongParm
message.DoubleParm = lm_backup.DoubleParm
message.StringParm = lm_backup.StringParm
message.PowerObjectParm = lm_backup.PowerObjectParm
message.Processed = lm_backup.Processed
message.ReturnValue = lm_backup.ReturnValue

inv_icon.visible = this.visible

if appeongetclienttype() <> 'PB' then
	ib_OnceOpened = true
end if

end event

event destructor;if isvalid(inv_icon) then
	// Appeon $$HEX3$$d0c51cc12000$$ENDHEX$$Popup $$HEX5$$08c7c4b3b0c694b22000$$ENDHEX$$CloseUserObject $$HEX7$$7cb9200018c289d558d574ba2000$$ENDHEX$$
	// $$HEX16$$74d07cb774c7b8c5b8d200ac200048ba94cd94b2200004d6c1c0200088c74cc7$$ENDHEX$$
	// (Appeon2016Build1119 $$HEX4$$84bc04c840c72000$$ENDHEX$$CloseUserObject $$HEX12$$38d69ccd200048c558d574ba200024c658b91cbcddc028b4$$ENDHEX$$)
	//if appeongetclienttype() = 'PB' then
		iw_parent.CloseUserObject(inv_icon)
	//end if
	destroy inv_icon
end if

end event

