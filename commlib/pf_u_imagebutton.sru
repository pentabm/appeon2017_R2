HA$PBExportHeader$pf_u_imagebutton.sru
$PBExportComments$$$HEX7$$0cd3ccc604d508b884c7a9c62000$$ENDHEX$$ImageButton $$HEX7$$e8ceb8d264b8200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_u_imagebutton from picture
end type
end forward

global type pf_u_imagebutton from picture
integer width = 402
integer height = 112
string pointer = "HyperLink!"
boolean focusrectangle = false
event mousemove pbm_mousemove
event pfe_mouseleave ( )
event pfe_mouseover ( )
event pfe_lbuttonup pbm_lbuttonup
event pfe_lbuttondown pbm_lbuttondown
event pfe_enablechanged pbm_enable
event pfe_picturenamechanged ( )
event type boolean pfe_ispowerframecontrol ( )
event pfe_postopen ( )
event timer pbm_timer
end type
global pf_u_imagebutton pf_u_imagebutton

type prototypes
function boolean ReleaseCapture() library "user32.dll"
function long SetCapture(long hWnd) library "user32.dll"

function Boolean TrackMouseEvent(Ref pf_s_TRACKMOUSEEVENT lpTrackMouseEvent) Library 'user32.dll' alias for "TrackMouseEvent;Ansi" 
function Long GetLastError() Library 'Kernel32.dll' 

Function Long SetTimer(Long hwnd, long idTimer, Long uTimeOut, Long tmprc) Library "user32.dll"
Function Long KillTimer(Long hwnd, Long idEvent) Library "user32.dll" 

end prototypes

type variables
Constant string MOUSEOVER_SURFIX = "_hover"
Constant string CLICKED_SURFIX =  "_clicked"
Constant string DISABLED_SURFIX = "_disabled"

private:
	window iw_parent
	pf_n_timing inv_timer
	integer ii_referencedobjectcnt

	string is_picturename
	string is_normal_img
	string is_mouseover_img
	string is_clicked_img
	string is_disabled_img
	boolean ib_mouseover
	pf_s_point istr_point
	boolean ib_OnceOpened = false

public:
	powerobject ipo_referencedobject[]

	boolean FixedToRight
	boolean FixedToBottom
	boolean ScaleToRight
	boolean ScaleToBottom

	string ReferencedObject
	string OnClickCallEvent
	string DatawindowAction

end variables

forward prototypes
public function integer of_checkandcreateimage (string as_imagetype, string as_imagepath)
public function string of_getclassname ()
public subroutine of_setenabled (boolean ab_enabled)
public function integer of_picturenamechanged (string as_picturename)
public subroutine of_setpicturename (string as_picturename)
end prototypes

event mousemove;if ib_mouseover = false then
	ib_mouseover = true
	this.event pfe_mouseover()
	inv_timer.of_start()
	//SetTimer(Handle(This), 1, 300, 0)
	//inv_propmon.of_register('mouseleave', 'pfe_mouseleave' )
	//gnv_extfunc.SetTimer(Handle(This), 1, 300, 0)
end if

end event

event pfe_mouseleave();this.picturename = is_normal_img

//if ib_mouseover = true then
//	ib_mouseover = false
//	inv_propmon.of_unregister('mouseleave')
//	this.picturename = is_normal_img
//end if

end event

event pfe_mouseover();if isnull(this.picturename) or this.picturename = '' then return
this.picturename = is_mouseover_img

end event

event pfe_lbuttonup;if isnull(this.picturename) or this.picturename = '' then return
this.picturename = is_mouseover_img

end event

event pfe_lbuttondown;if isnull(this.picturename) or this.picturename = '' then return
this.picturename = is_clicked_img

end event

event pfe_enablechanged;choose case this.enabled
	case true
		this.picturename = is_normal_img
	case false
		this.picturename = is_disabled_img
end choose

end event

event pfe_picturenamechanged();choose case this.picturename
	case is_normal_img
	case is_mouseover_img
	case is_clicked_img
	case is_disabled_img
	case else
		this.of_picturenamechanged(this.picturename)
end choose

end event

event type boolean pfe_ispowerframecontrol();return true

end event

event pfe_postopen();// get referenced object
string ls_refobj[]
integer li_objcnt, i

if isnull(ReferencedObject) then return
if ReferencedObject = '' then return

li_objcnt = pf_f_parsetoarray(ReferencedObject, ';', ls_refobj)
for i = 1 to li_objcnt
	if len(ls_refobj[i]) > 0 then
		ii_referencedobjectcnt ++
		ls_refobj[i] = trim(ls_refobj[i])
		choose case lower(ls_refobj[i])
			case 'this'
				ipo_referencedobject[ii_referencedobjectcnt] = this
			case 'parent'
				ipo_referencedobject[ii_referencedobjectcnt] = parent
			case iw_parent.classname()
				ipo_referencedobject[ii_referencedobjectcnt] = iw_parent
			case else
				ipo_referencedobject[ii_referencedobjectcnt] = iw_parent.dynamic of_getwindowobjectbyname(ls_refobj[i])
				if not isvalid(ipo_referencedobject[ii_referencedobjectcnt]) then
					messagebox('[' + this.classname() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + ls_refobj[i] + '] $$HEX18$$38cc70c8200024c60cbe1dc8b8d200ac200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$')
				end if
		end choose
	end if
next

end event

event timer;if gnv_extfunc.GetCursorPos(istr_point) then
	if gnv_extfunc.ScreenToClient(handle(this), istr_point) then
		if istr_point.xpos >= 0 and istr_point.ypos >= 0 and istr_point.xpos <= unitstopixels(this.width, xunitstopixels!) and istr_point.ypos <= unitstopixels(this.height, yunitstopixels!) then
		else
			ib_mouseover = false
			inv_timer.stop()
			//gnv_extfunc.KillTimer(Handle(this), 1)
			//KillTimer(Handle(this), 1)
			this.post event pfe_mouseleave()
		end if
	end if
end if

end event

public function integer of_checkandcreateimage (string as_imagetype, string as_imagepath);string ls_orgfilewritetime, ls_newfilewritetime

// $$HEX14$$74d5f9b220000cd37cc774c7200074c8acc758d574ba2000acb934d1$$ENDHEX$$
if fileexists(as_imagepath) then return 0

// Appeon $$HEX7$$58d6bdac7cc72000bdacb0c62000$$ENDHEX$$URL $$HEX2$$b4cc6cd0$$ENDHEX$$
if AppeonGetClientType() = 'WEB' then
	if gnv_extfunc.of_getappeonimagefile(as_imagepath) = 0 then return 0
end if

// $$HEX14$$d0c6f8bc0cd37cc7200018c215c87cc790c7200000ac38c824c630ae$$ENDHEX$$
gnv_extfunc.of_getfilewritetime(is_normal_img, ls_orgfilewritetime)

string ls_tempfilepath
long ll_lastpos

// Output $$HEX5$$55d6a5c790c794b22000$$ENDHEX$$jpg
ll_lastpos = lastpos(as_imagepath, ".")
if ll_lastpos > 0 then
	as_imagepath = left(as_imagepath, ll_lastpos) + "jpg"
end if

// $$HEX11$$84c7dcc25cb82000acc0a9c620b420000cd37cc785ba$$ENDHEX$$
ls_tempfilepath = gnv_extfunc.of_getpowerframetemppath() + gnv_extfunc.of_pathstrippath(as_imagepath)

choose case as_imagetype
	case 'mouseover'
		is_mouseover_img = ls_tempfilepath
	case 'clicked'
		is_clicked_img = ls_tempfilepath
	case 'disabled'
		is_disabled_img = ls_tempfilepath
end choose

// $$HEX18$$84c7dcc20cd37cc774c7200074c8acc758d574ba200018c215c87cc790c7200044be50ad$$ENDHEX$$, $$HEX7$$d9b37cc758d574ba2000acb934d1$$ENDHEX$$
if fileexists(ls_tempfilepath) then
	 gnv_extfunc.of_getfilewritetime(ls_tempfilepath, ls_newfilewritetime)
	 if ls_orgfilewritetime = ls_newfilewritetime then
		return 0
	end if
end if

// $$HEX21$$74c7f8bbc0c92000c0d085c7d0c5200030b57cb7200084c7dcc20cd37cc72000e0c2dcad2000ddc031c1$$ENDHEX$$
choose case as_imagetype
	case 'mouseover'
		gnv_extfunc.of_makemouseoverbuttonimage(is_normal_img, ls_tempfilepath)
	case 'clicked'
		gnv_extfunc.of_makeclickedbuttonimage(is_normal_img, ls_tempfilepath)
	case 'disabled'
		gnv_extfunc.of_makedisabledbuttonimage(is_normal_img, ls_tempfilepath)
end choose

gnv_extfunc.of_setfilewritetime(ls_tempfilepath, ls_orgfilewritetime)

return 1

end function

public function string of_getclassname ();return 'pf_u_imagebutton'

end function

public subroutine of_setenabled (boolean ab_enabled);this.enabled = ab_enabled

if appeongetclienttype() = 'WEB' then 
	this.event pfe_enablechanged(ab_enabled)
end if

end subroutine

public function integer of_picturenamechanged (string as_picturename);long ll_lastpos
string ls_picture_dir, ls_picture_name
string ls_picture_ext

if isnull(as_picturename) or as_picturename = '' then
	is_picturename = ''
	is_normal_img = ''
	is_mouseover_img = ''
	is_clicked_img = ''
	is_disabled_img = ''
	this.picturename = ''
	return 0
end if

if is_picturename = as_picturename then return 0

is_normal_img = pf_f_getimagepathappeon(as_picturename)

//ls_picture_dir = gnv_extfunc.pathstrippath(is_normal_img)
//ls_picture_name = gnv_extfunc.pathremovefilespec(is_normal_img)

ll_lastpos = lastpos(is_normal_img, "\")
if ll_lastpos > 0 then
	ls_picture_dir = left(is_normal_img, ll_lastpos)
	ls_picture_name = mid(is_normal_img, ll_lastpos + 1)
else
	ls_picture_dir = ''
	ls_picture_name = is_normal_img
end if

ll_lastpos = lastpos(ls_picture_name, ".")
if ll_lastpos > 0 then
	ls_picture_ext = mid(ls_picture_name, ll_lastpos)
	ls_picture_name = left(ls_picture_name, ll_lastpos - 1)
end if

//is_mouseover_img = ls_picture_dir + MOUSEOVER_PREFIX + ls_picture_name
is_mouseover_img = ls_picture_dir + ls_picture_name + MOUSEOVER_SURFIX + ls_picture_ext
this.of_checkandcreateimage('mouseover', is_mouseover_img)

//is_clicked_img = ls_picture_dir + CLICKED_PREFIX + ls_picture_name
is_clicked_img = ls_picture_dir + ls_picture_name + CLICKED_SURFIX + ls_picture_ext
this.of_checkandcreateimage('clicked', is_clicked_img)

//is_disabled_img = ls_picture_dir + DISABLED_PREFIX + ls_picture_name
is_disabled_img = ls_picture_dir + ls_picture_name + DISABLED_SURFIX + ls_picture_ext
this.of_checkandcreateimage('disabled', is_disabled_img)

//messagebox('is_mouseover_img', is_mouseover_img)
//messagebox('is_clicked_img', is_clicked_img)
//messagebox('is_disabled_img', is_disabled_img)

is_picturename = as_picturename
if this.enabled  = true then
	if appeongetclienttype() = 'WEB' then
		this.picturename = is_normal_img
	end if
else
	this.picturename = is_disabled_img
end if

return 1

end function

public subroutine of_setpicturename (string as_picturename);this.picturename = as_picturename
this.event pfe_picturenamechanged()

end subroutine

on pf_u_imagebutton.create
end on

on pf_u_imagebutton.destroy
end on

event constructor;if appeongetclienttype() <> 'PB' then
	if ib_OnceOpened = true then return
end if

// get parent window
iw_parent = pf_f_getparentwindow(this)

// init each button picture names
this.of_setpicturename(this.picturename)

// mouseover monitor
inv_timer = create pf_n_timing
inv_timer.of_initialize(this)

if appeongetclienttype() <> 'PB' then
	ib_OnceOpened = true
end if

// postopen event
this.post event pfe_postopen()

end event

event destructor;//this.of_setpropertywatcher('false')
if isvalid(inv_timer) then
	destroy inv_timer
end if

end event

event clicked;integer i

// $$HEX35$$38cc70c8200024c60cbe1dc8b8d200ac200020c1b8c51cb42000bdacb0c6200074d5f9b2200024c60cbe1dc8b8d258c7200074c7a4bcb8d27cb9200038d69ccd69d5c8b2e4b2$$ENDHEX$$
if ii_referencedobjectcnt > 0 then
	for i = 1 to ii_referencedobjectcnt
		if len(OnClickCallEvent) > 0 then
			if not isvalid(ipo_referencedobject[i]) then continue
			if ipo_referencedobject[i].triggerevent(OnClickCallEvent) = -1 then exit
		end if
	next
end if

// $$HEX29$$38cc70c8200024c60cbe1dc8b8d200ac200070b374c730d108c7c4b3b0c678c72000bdacb0c6200074d5f9b2200024c60cbe1dc8b8d258c72000$$ENDHEX$$ACTION $$HEX10$$1cc144bea4c27cb9200038d69ccd69d5c8b2e4b2$$ENDHEX$$
if ii_referencedobjectcnt > 0 then
	for i = 1 to ii_referencedobjectcnt
		if not isvalid(ipo_referencedobject[i]) then continue
		if ipo_referencedobject[i].typeof() = datawindow! then
			if len(DatawindowAction) > 0 then
				if ipo_referencedobject[i].triggerevent('pfe_ispowerframecontrol') = 1 then
					if ipo_referencedobject[i].dynamic of_getclassname() = 'pf_u_datawindow' then
						pf_u_datawindow ldw_ref
						ldw_ref = ipo_referencedobject[i]
						if isvalid(ldw_ref.inv_action) then
							ldw_ref.inv_action.of_datawindowaction(DatawindowAction)
						end if
					end if
				end if
			end if
		end if
	next
end if

end event

