HA$PBExportHeader$pf_w_frame.srw
$PBExportComments$$$HEX9$$0cd3ccc604d508b884c7200054ba78c72000$$ENDHEX$$MDI $$HEX20$$08c7c4b3b0c658c720005ccdc1c004c7200070c8c1c0200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_frame from window
end type
type mdi_1 from mdiclient within pf_w_frame
end type
type st_mdiclient from pf_u_statictext within pf_w_frame
end type
end forward

global type pf_w_frame from window
integer width = 4686
integer height = 2992
boolean titlebar = true
string title = "PowerFrame"
string menuname = "pf_m_empty"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdi!
string icon = "AppIcon!"
boolean toolbarvisible = false
boolean center = true
event pfe_postopen ( )
mdi_1 mdi_1
st_mdiclient st_mdiclient
end type
global pf_w_frame pf_w_frame

type variables
// $$HEX9$$f5acb5d12000acb934d112ac2000c1c018c2$$ENDHEX$$
constant integer SUCCESS = 1
constant integer FAILURE = -1
constant integer NO_ACTION = 0

// $$HEX2$$c4ac8dc1$$ENDHEX$$/$$HEX9$$11c9c0c92000acb934d112ac2000c1c018c2$$ENDHEX$$
constant integer CONTINUE_ACTION = 1
constant integer PREVENT_ACTION = 0

private:
	boolean ib_resize = false
	
protected:
	pf_n_resize inv_resize

end variables

forward prototypes
public function integer of_setresize (boolean ab_switch)
public function long of_eventdispatcher (string as_objectname, string as_eventname, pf_n_hashtable anvo_parameter)
public function string of_getclassname ()
public subroutine of_setmdiclientborder (integer ai_borderstyle)
public function integer of_checkactivesheetstate ()
public function windowobject of_getwindowobjectbyname (string as_objname)
end prototypes

event pfe_postopen();ib_resize = true

// Resize $$HEX2$$24c115c8$$ENDHEX$$
this.event resize(0, This.WorkSpaceWidth(), This.WorkSpaceHeight())
this.post setredraw(true)

end event

public function integer of_setresize (boolean ab_switch);integer	li_rc

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid (inv_resize) then
		inv_resize = create pf_n_resize
		
//		// Appeon $$HEX7$$58d6bdac7cc72000bdacb0c62000$$ENDHEX$$OriginalSize$$HEX2$$94b22000$$ENDHEX$$pf_n_appconfig$$HEX13$$d0c5200015c858c71cb4200012ac44c7200038cc70c85cd5e4b2$$ENDHEX$$
//		if appeongetclienttype() = 'WEB' then
//			long ll_width, ll_height
//			
//			ll_width = long(gnv_appconf.of_getproperty("mainframe.original.width"))
//			ll_height = long(gnv_appconf.of_getproperty("mainframe.original.height"))
//			
//			inv_resize.of_SetOrigSize (ll_width, ll_height)
//			//inv_resize.of_SetMinSize (ll_width, ll_height)
//		else
//			inv_resize.of_SetOrigSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
//			//inv_resize.of_SetMinSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
//		end if
		
		if appeongetclienttype() = 'WEB' then
			inv_resize.of_SetOrigSize (5856, 3044)
			inv_resize.of_SetMinSize(pixelstounits(1024, xpixelstounits!), pixelstounits(768, ypixelstounits!))
			//inv_resize.of_SetMinSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
		else
			inv_resize.of_SetOrigSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
			//inv_resize.of_SetMinSize(pixelstounits(800, xpixelstounits!), pixelstounits(600, ypixelstounits!))
			//inv_resize.of_SetMinSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())			
		end if
		
		inv_resize.of_AutoResizeRegister(this)
		li_rc = 1
	end if
else
	if IsValid (inv_resize) then
		destroy inv_resize
		li_rc = 1
	end if
end If

return li_rc

end function

public function long of_eventdispatcher (string as_objectname, string as_eventname, pf_n_hashtable anvo_parameter);integer i, li_retval

li_retval = -1
for i = 1 to upperbound(this.control)
	if this.control[i].triggerevent('pfe_ispowerframecontrol') = 1 then
		if this.control[i].dynamic of_getclassname() = as_objectname then
			gnv_session.of_put(as_objectname, anvo_parameter)
			if this.control[i].triggerevent(as_eventname) = 1 then
				gnv_session.of_remove(as_objectname)
				li_retval = gnv_session.of_getint('ReturnValue')
				exit
			end if
		end if
	end if
next

return li_retval

end function

public function string of_getclassname ();return 'pf_w_frame'

end function

public subroutine of_setmdiclientborder (integer ai_borderstyle);// setmdiclientborder
gnv_extfunc.pf_setmdiclientborder(handle(mdi_1), ai_borderstyle)

end subroutine

public function integer of_checkactivesheetstate ();// Sheet $$HEX4$$08c7c4b3b0c62000$$ENDHEX$$Open$$HEX2$$dcc22000$$ENDHEX$$Close(This) $$HEX9$$85ba39b874c7200018c289d518b474ba2000$$ENDHEX$$WindowState$$HEX2$$00ac2000$$ENDHEX$$Maximized -> Normal $$HEX7$$c1c0dcd05cb82000c0bcbdac28b4$$ENDHEX$$
// $$HEX13$$c1c0dcd02000b4cc6cd02000c4d62000d0c698b700b35cb82000$$ENDHEX$$Maximized $$HEX2$$98ccacb9$$ENDHEX$$
window lw_activesheet

lw_activesheet = This.GetActiveSheet()
IF IsValid(lw_activesheet) THEN
	IF lw_activesheet.windowstate <> Maximized! THEN
		lw_activesheet.windowstate = Maximized!
	END IF
END IF

Return 0

end function

public function windowobject of_getwindowobjectbyname (string as_objname);// $$HEX19$$08c7c4b3b0c600ac2000ecd368d558d5e0ac88c794b22000e8ceb8d264b8200011c9d0c52000$$ENDHEX$$as_objname$$HEX5$$fcac2000d9b37cc75cd5$$ENDHEX$$
// $$HEX19$$85ba6dce44c7200000acc0c994b2200024c60cbe1dc8b8d27cb92000acb934d169d5c8b2e4b2$$ENDHEX$$.

integer i, li_cnter
windowobject lwo_ret

li_cnter  = upperbound(this.control)
for  i  = 1 to  li_cnter
	if  this.control[i].classname() = as_objname  then
		lwo_ret = this.control[i]
		exit
	end  if
next

return lwo_ret

end function

on pf_w_frame.create
if this.MenuName = "pf_m_empty" then this.MenuID = create pf_m_empty
this.mdi_1=create mdi_1
this.st_mdiclient=create st_mdiclient
this.Control[]={this.mdi_1,&
this.st_mdiclient}
end on

on pf_w_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.st_mdiclient)
end on

event open;this.setredraw(false)
SetPointer(HourGlass!)

// MDI Client $$HEX2$$24c115c8$$ENDHEX$$
mdi_1.backcolor = rgb(255, 255, 255)
mdi_1.move(st_mdiclient.x, st_mdiclient.y)
this.of_setmdiclientborder(3)

// System Color $$HEX2$$24c115c8$$ENDHEX$$
pf_s_syscolor lstr_param
lstr_param.color_highlight = RGB(167,205,240)	//RGB(94,172,248)
lstr_param.color_highlighttext = RGB(33,39,45)
lstr_param.color_btnface = RGB(210,210,210)
gnv_extfunc.of_SetSystemColor(lstr_param)

ib_resize = false
this.of_setresize(true)

this.post event pfe_postopen()

end event

event resize;//if ib_resize = false then return

if IsValid (inv_resize) then
	if appeongetclienttype() = 'WEB' then
		inv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
	else
		inv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
	end if
end if

end event

type mdi_1 from mdiclient within pf_w_frame
long BackColor=268435456
end type

type st_mdiclient from pf_u_statictext within pf_w_frame
event ue_move pbm_move
event resize pbm_size
integer x = 896
integer y = 604
integer width = 3721
integer height = 2176
long bordercolor = 10789024
boolean scaletoright = true
boolean scaletobottom = true
end type

event ue_move;mdi_1.x = xpos
mdi_1.y = ypos


end event

event resize;mdi_1.width = this.width
mdi_1.height = this.height

end event

