$PBExportHeader$pf_u_titletext.sru
$PBExportComments$텍스트 앞에 아이콘을 동적으로 표시해 줍니다. 주로 타이틀 텍스트 용도로 사용됩니다.
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
string facename = "맑은 고딕"
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

// Appeon 환경일 경우 이미지 경로 변경
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
	// Appeon 에서 Popup 윈도우는 CloseUserObject 를 수행하면 
	// 클라이언트가 멈추는 현상 있음
	// (Appeon2016Build1119 버전은 CloseUserObject 호출 안하면 오류발생됨)
	//if appeongetclienttype() = 'PB' then
		iw_parent.CloseUserObject(inv_icon)
	//end if
	destroy inv_icon
end if

end event

