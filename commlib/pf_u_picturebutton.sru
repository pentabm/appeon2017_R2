HA$PBExportHeader$pf_u_picturebutton.sru
$PBExportComments$$$HEX7$$0cd3ccc604d508b884c7a9c62000$$ENDHEX$$PictureButton $$HEX7$$e8ceb8d264b8200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_u_picturebutton from picturebutton
end type
end forward

global type pf_u_picturebutton from picturebutton
integer width = 402
integer height = 104
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX2$$cbb3c0c6$$ENDHEX$$"
string pointer = "HyperLink!"
vtextalign vtextalign = vcenter!
event type boolean pfe_ispowerframecontrol ( )
event pfe_postopen ( )
end type
global pf_u_picturebutton pf_u_picturebutton

type prototypes
Function long GetTempPath(long nBufferLength, ref string lpBuffer ) Library "kernel32.dll" Alias For "GetTempPathA;Ansi"

end prototypes

type variables
private:
	window iw_parent
	string is_picturename
	string is_disabledname
	integer ii_referencedobjectcnt
	boolean ib_OnceOpened = false

public:
	powerobject ipo_referencedobject[]

	string IconPath

	boolean FixedToRight
	boolean FixedToBottom
	boolean ScaleToRight
	boolean ScaleToBottom

	string ReferencedObject
	string OnClickCallEvent
	string DatawindowAction

end variables

forward prototypes
public function integer of_setpicturename (string as_iconname)
public function integer of_checkandcreateimage (string as_imagetype, string as_imagepath)
public function string of_getclassname ()
end prototypes

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

public function integer of_setpicturename (string as_iconname);if isnull(as_iconname) or as_iconname = '' then
	is_picturename = ''
	is_disabledname = ''
	return 0
end if

IconPath = pf_f_getimagepathappeon(as_iconname)
if not fileexists(IconPath) then return -1

is_picturename = gnv_extfunc.of_getpowerframetemppath() + gnv_extfunc.of_getuniqpicturename(this) + ".jpg"
if this.of_checkandcreateimage('picturename', is_picturename) > 0 then
	this.picturename = is_picturename
end if

is_disabledname = gnv_extfunc.of_getpowerframetemppath() + gnv_extfunc.of_getuniqpicturename(this) + "_disabled.jpg"
if this.of_checkandcreateimage('disabledname', is_disabledname) > 0 then
	this.disabledname = is_disabledname
end if

// text alignment & gap
this.htextalign = left!
this.text = space(6) + this.text

return 1

end function

public function integer of_checkandcreateimage (string as_imagetype, string as_imagepath);//string ls_orgfilewritetime, ls_newfilewritetime
long ll_width, ll_height

ll_width = unitstopixels(this.width, xunitstopixels!) - 5
ll_height = unitstopixels(this.height, yunitstopixels!) - 5

//// $$HEX36$$74c7f8bbc0c9200090ce6cc2200030aea5b240c7200054bac0d070b374c730d15cb8200055d678c760d5200018c2200088c7c4b35db8200098b011c9d0c520006cad04d65cd5e4b2$$ENDHEX$$.
//// $$HEX14$$d0c6f8bc0cd37cc7200018c215c87cc790c7200000ac38c824c630ae$$ENDHEX$$
//gnv_extfunc.of_getfilewritetime(IconPath, ls_orgfilewritetime)
//
//// $$HEX16$$0cd37cc774c7200074c8acc758d574ba200018c215c87cc790c7200044be50ad$$ENDHEX$$, $$HEX7$$d9b37cc758d574ba2000acb934d1$$ENDHEX$$
//if fileexists(as_imagepath) then
//	 gnv_extfunc.of_getfilewritetime(as_imagepath, ls_newfilewritetime)
//	 if ls_orgfilewritetime = ls_newfilewritetime then
//		return 1
//	end if
//end if

// $$HEX21$$74c7f8bbc0c92000c0d085c7d0c5200030b57cb7200084c7dcc20cd37cc72000e0c2dcad2000ddc031c1$$ENDHEX$$
choose case as_imagetype
	case 'picturename'
		gnv_extfunc.pf_MakePictureButtonImage(iconpath, as_imagepath, ll_width, ll_height, true)
	case 'disabledname'
		gnv_extfunc.pf_MakePictureButtonImage(iconpath, as_imagepath, ll_width, ll_height, false)
end choose

//gnv_extfunc.of_setfilewritetime(as_imagepath, ls_orgfilewritetime)
return 1

end function

public function string of_getclassname ();return 'pf_u_picturebutton'

end function

on pf_u_picturebutton.create
end on

on pf_u_picturebutton.destroy
end on

event constructor;if appeongetclienttype() <> 'PB' then
	if ib_OnceOpened = true then return
end if

// get parent window
iw_parent = pf_f_getparentwindow(this)

// init each button picture names
this.of_setpicturename(this.IconPath)

if appeongetclienttype() <> 'PB' then
	ib_OnceOpened = true
end if

// postopen event
this.post event pfe_postopen()

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

