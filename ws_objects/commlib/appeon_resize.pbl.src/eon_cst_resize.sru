$PBExportHeader$eon_cst_resize.sru
$PBExportComments$PFC Resize service
forward
global type eon_cst_resize from nonvisualobject
end type
end forward

global type eon_cst_resize from nonvisualobject autoinstantiate
event type integer pfc_resize ( unsignedlong aul_sizetype,  integer ai_newwidth,  integer ai_newheight )
end type

type variables
Public:
// Predefined resize constants.
Constant String FIXEDRIGHT =  'FixedToRight'
Constant String FIXEDBOTTOM = 'FixedToBottom'
Constant String FIXEDRIGHTBOTTOM = 'FixedToRight&Bottom'
Constant String SCALE = 'Scale'
Constant String SCALERIGHT = 'ScaleToRight'
Constant String SCALEBOTTOM = 'ScaleToBottom'
Constant String SCALERIGHTBOTTOM = 'ScaleToRight&Bottom'
Constant String FIXEDRIGHT_SCALEBOTTOM = 'FixedToRight&ScaleToBottom'
Constant String FIXEDBOTTOM_SCALERIGHT = 'FixedToBottom&ScaleToRight'
//	7.0   Instance variable datatype changed from os_resize to n_cst_resizeattrib type
//	7.0   Instance variable name changed from istr_registered to inv_registered
eon_cst_resizeattrib	inv_registered[]
//eon_cst_resizeattrib inv_resizeAttrib[]
userObject iuo_component
powerObject ipo_component
int i_tabIdx[]
Protected:
constant string  DRAGOBJECT = 'dragobject!'
constant string  LINE = 'line!'
constant string  OVAL = 'oval!'
constant string  RECTANGLE = 'rectangle!'
constant string  ROUNDRECTANGLE = 'roundrectangle!'
constant string  MDICLIENT = 'mdiclient!'
constant string  ics_dragobject = 'dragobject!'	// Obsoleted in 6.0
constant string  ics_line = 'line!'		// Obsoleted in 6.0
constant string  ics_oval = 'oval!'		// Obsoleted in 6.0
constant string  ics_rectangle = 'rectangle!'	// Obsoleted in 6.0
constant string  ics_roundrectangle = 'roundrectangle!' // Obsoleted in 6.0
constant string ics_mdiclient = 'mdiclient!'	// Obsoleted in 6.0
long 	il_parentminimumwidth=0
long	il_parentminimumheight=0
long	il_parentprevwidth=-1
long	il_parentprevheight=-1
integer	ii_rounding = 5
end variables

forward prototypes
public function integer of_unregister (windowobject awo_control)
public function integer of_register (windowobject awo_control, string as_method)
public function integer of_setminsize (integer ai_minwidth, integer ai_minheight)
public function integer of_SetOrigSize (integer ai_width, integer ai_height)
public function integer of_register (windowobject awo_control, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight)
public function integer of_getminmaxpoints (windowobject awo_control[], ref integer ai_min_x, ref integer ai_min_y, ref integer ai_max_x, ref integer ai_max_y)
public function integer of_register (windowobject awo_control, boolean ab_scale, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight)
private function integer of_register (windowobject awo_obj)
public function integer of_init ()
private function boolean of_checksizetype (eon_cst_resizeattrib a_attr, string as_filterstart, string as_origstart, string as_origlength)
public function integer of_init (userobject a_obj)
public function integer of_init (window a_obj)
public function string of_getcomponentname ()
private function integer of_setresizetype (powerobject awo_control, boolean ab_leftsizetype, boolean ab_upsizetype, boolean ab_selfsizable)
public function integer of_resize (integer ai_newwidth, integer ai_newheight)
protected function string of_typeof (powerobject awo_control)
end prototypes

event type integer pfc_resize(unsignedlong aul_sizetype, integer ai_newwidth, integer ai_newheight);//////////////////////////////////////////////////////////////////////////////
//
//	Event:  resize
//
//	Description:
//	Send resize notification to services.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright 1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Return of_Resize(ai_newwidth, ai_newheight)
end event

public function integer of_unregister (windowobject awo_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_UnRegister	
//
//	Access:  		public
//
//	Arguments:		
//	awo_control		The control to unregister.
//
//	Returns:  		integer
//				1 if it succeeds and-1 if an error occurs.
//
//	Description:  	Unregister a control that was previously registered.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Changed to support for weighted movement and sizing of controls.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright 1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer			li_upperbound
integer			li_cnt
integer			li_registered_slot
//Check parameters
If IsNull(awo_control) or (not IsValid(awo_control)) Then
	Return -1
End If
//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If
//Get the current UpperBound
li_upperbound = UpperBound (inv_registered[])
//Find the registered object
li_registered_slot = 0
For li_cnt = 1 to li_upperbound
	If inv_registered[li_cnt].wo_control = awo_control Then
		li_registered_slot = li_cnt
		exit
	End If
Next
//If the control was not previously registered, return
//an error code.
If li_registered_slot = 0 Then
	Return -1
End If
//Unregister the control
SetNull(inv_registered[li_registered_slot].wo_control)
inv_registered[li_registered_slot].s_typeof = ''
inv_registered[li_registered_slot].b_movex = False
inv_registered[li_registered_slot].i_movex = 0
inv_registered[li_registered_slot].b_movey = False
inv_registered[li_registered_slot].i_movey = 0
inv_registered[li_registered_slot].b_scalewidth = False
inv_registered[li_registered_slot].i_scalewidth = 0
inv_registered[li_registered_slot].b_scaleheight = False
inv_registered[li_registered_slot].i_scaleheight = 0
Return 1
end function

public function integer of_register (windowobject awo_control, string as_method);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:		
//	awo_control		The window object being registered.
//	as_method		The desired resize/move method.
//						Valid values are:
//						 'FixedToRight'
//						 'FixedToBottom'
//						 'FixedToRight&Bottom'
//						 'Scale'
//						 'ScaleToRight'
//						 'ScaleToBottom'
//						 'ScaleToRight&Bottom'
//						 'FixedToRight&ScaleToBottom'
//						 'FixedToBottom&ScaleToRight'
//
//	Returns:  		integer
//			1 if it succeeds and -1 if an error occurs.
//
//	Description:  	Register a control which needs to either be moved or resized
//						when the parent object is resized. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	6.0	Changed to use constants for checking resize method.
// 6.0	Changed to support for weighted movement and sizing of controls.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright  1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
constant integer FULL_PERCENT= 100
integer			li_movex, li_movey
integer			li_scalewidth, li_scaleheight
boolean			lb_scale=False
//Check parameters
If IsNull(awo_control) or (not IsValid(awo_control)) or IsNull(as_method) Then
	Return -1
End If
//Translate and finish validating parameteters
Choose Case Lower(as_method)
	Case Lower(FIXEDRIGHT)
		li_movex = FULL_PERCENT
	Case Lower(FIXEDBOTTOM)
		li_movey = FULL_PERCENT
	Case Lower(FIXEDRIGHTBOTTOM)
		li_movex = FULL_PERCENT
		li_movey = FULL_PERCENT
	Case Lower(SCALE)
		lb_scale = True
	Case Lower(SCALERIGHT)
		li_scalewidth = FULL_PERCENT
	Case Lower(SCALEBOTTOM)
		li_scaleheight = FULL_PERCENT
	Case Lower(SCALERIGHTBOTTOM)
		li_scalewidth = FULL_PERCENT
		li_scaleheight = FULL_PERCENT
	Case Lower(FIXEDRIGHT_SCALEBOTTOM)		
		li_movex = FULL_PERCENT
		li_scaleheight = FULL_PERCENT
	Case Lower(FIXEDBOTTOM_SCALERIGHT)	
		li_movey = FULL_PERCENT
		li_scalewidth = FULL_PERCENT
	Case Else
		li_movex = 0
		li_movey = 0
		li_scaleWidth = 0
		li_scaleHeight = 0
		lb_scale = false
		//Return -1
End Choose
Return of_Register(awo_control, lb_scale, &
		li_movex, li_movey, li_scalewidth, li_scaleheight)
end function

public function integer of_setminsize (integer ai_minwidth, integer ai_minheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetMinSize
//
//	Access:  		public
//
//	Arguments:		
//	ai_minwidth		The minimum width for the parent object.
//	ai_minheight	The minimum height for the parent object.
//
//	Returns:  		integer
//				1 if it succeeds and -1 if an error occurs.
//
//	Description:  	Sets the current object minimum size attributes.
//						Note: the service object needs to be initialized (of_SetOrigSize())
//						prior to	setting the Minimum size of the object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright 1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
//Check parameters
If	IsNull(ai_minwidth) or IsNull(ai_minheight) Then
	Return -1
End If
//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If
//Set the minimum values for the width and height
il_parentminimumwidth = ai_minwidth
il_parentminimumheight = ai_minheight
Return 1
end function

public function integer of_SetOrigSize (integer ai_width, integer ai_height);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetOrigSize
//
//	Access:  		public
//
//	Arguments:		
//	ai_width			The current width of the parent object.
//	ai_height		The current height of the parent object.
//
//	Returns:  		integer
//				1 if it succeeds and -1 if an error occurs.
//
//	Description:  	Initializes the Resize object by setting the current object
//						size.
//						Note: the service object needs to be initialized (this function)
//						prior to	the registering (of_register()) of objects.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright 1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
//Check parameters
If IsNull(ai_width) or IsNull(ai_height) Then
	Return -1
End If
//Set the current width and height
il_parentprevwidth = ai_width
il_parentprevheight = ai_height
Return 1
end function

public function integer of_register (windowobject awo_control, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:		
//	 awo_control	The window object being registered.
//  ai_movex			The percentage to move the object along the x axis.
//  ai_movey			The percentage to move the object along the y axis.
//  ai_scalewidth 	The percentage to scale the object along the x axis.
//  ai_scaleheight	The percentage to scale the object along the y axis.
//
//	Returns:  		integer
//			1 if it succeeds and -1 if an error occurs.
//
//	Description:  	Register a control which needs to either be moved or resized
//						when the parent object is resized.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright  1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
boolean 		lb_scale=False
Return of_Register (awo_control, lb_scale, ai_movex, ai_movey, &
		ai_scalewidth, ai_scaleheight)
end function

public function integer of_getminmaxpoints (windowobject awo_control[], ref integer ai_min_x, ref integer ai_min_y, ref integer ai_max_x, ref integer ai_max_y);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetMinMaxPoints
//
//	Access:  		public
//
//	Arguments:		
//	awo_control[]	The control array for whom the Min and Max attributes are needed.
//	ai_min_x			The minimum X point found by looking at the X attributes of all
//							the controls on the control array (by reference).
//	ai_min_y			The minimum Y point found by looking at the X attributes of all
//							the controls on the control array (by reference).
//	ai_max_x			The maximum X point found by adding the X and Width attributes
//							of all the controls on the control array (by reference).
//	ai_max_y			The maximum Y point found by adding the Y and Height attributes
//							of all the controls on the control array (by reference).
//
//	Returns:  		integer
//			1 if it succeeds and -1 if an error occurs.
//
//	Description:  	Determines the four extreme points of the controls within a 
//						control array by looking at the X, Y, Width, Height, BeginX, 
//						BeginY, EndX, EndY attributes.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Changed to use new constants.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright  1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
dragobject		ldrg_cntrl
oval				loval_cntrl
line				ln_cntrl
rectangle		lrec_cntrl
roundrectangle	lrrec_cntrl
integer			li_x, li_y, li_width, li_height, li_temp
integer			li_upperbound
integer			li_cnt
//Check arguments
If IsNull(awo_control) or IsNull(awo_control[]) or UpperBound(awo_control[])=0 Then
	Return -1
End If
//Initialize
ai_min_x=32767
ai_min_y=32767
ai_max_x=0
ai_max_y=0
//Get the Control upper bound
li_upperbound = UpperBound (awo_control[])
//Determine position of the right most and bottom most control.
For li_cnt = 1 to li_upperbound
	If IsValid(awo_control[li_cnt]) Then
		Choose Case of_TypeOf(awo_control[li_cnt])
			Case DRAGOBJECT
				//Set a reference to the control.
				ldrg_cntrl = awo_control[li_cnt]
				//Get the position, width, and height of the control.
				li_x = ldrg_cntrl.X
				li_y = ldrg_cntrl.Y
				li_width = ldrg_cntrl.Width
				li_height = ldrg_cntrl.Height
			Case LINE
				ln_cntrl = awo_control[li_cnt]
				li_x = ln_cntrl.BeginX
				li_y = ln_cntrl.BeginY
				li_width = ln_cntrl.EndX
				li_height = ln_cntrl.EndY
				//Correct for lines that may have the End points 
				//before to the Begin points.
				If li_width >= li_x Then
					li_width = li_width - li_x
				Else
					li_temp = li_x
					li_x = li_width
					li_width = li_temp - li_x
				End If	
				If li_height >= li_y Then
					li_height = li_height - li_y
				Else
					li_temp = li_y
					li_y = li_height
					li_height = li_temp - li_y
				End If
			Case OVAL
				loval_cntrl = awo_control[li_cnt]
				li_x = loval_cntrl.X
				li_y = loval_cntrl.Y
				li_width = loval_cntrl.Width
				li_height = loval_cntrl.Height		
			Case RECTANGLE
				lrec_cntrl = awo_control[li_cnt]
				li_x = lrec_cntrl.X
				li_y = lrec_cntrl.Y
				li_width = lrec_cntrl.Width
				li_height = lrec_cntrl.Height		
			Case ROUNDRECTANGLE
				lrrec_cntrl = awo_control[li_cnt]
				li_x = lrrec_cntrl.X
				li_y = lrrec_cntrl.Y
				li_width = lrrec_cntrl.Width
				li_height = lrrec_cntrl.Height
			Case MDICLIENT
				Continue
			Case Else
				//An unknown control type has been encountered
				Return -1
		End Choose
		//Determine the Min and Max points
		If li_x < ai_min_x Then ai_min_x = li_x
		If li_y < ai_min_y Then ai_min_y = li_y
		If li_x + li_width > ai_max_x Then ai_max_x = li_x + li_width
		If li_y + li_height > ai_max_y Then ai_max_y = li_y + li_height
	End If
Next
Return 1
end function

public function integer of_register (windowobject awo_control, boolean ab_scale, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:		
//	 awo_control		The window object being registered.
//  ab_scale			If the object should be registered as a Scale type.
//  ai_movex			The percentage to move the object along the x axis.
//  ai_movey			The percentage to move the object along the y axis.
//  ai_scalewidth 	The percentage to scale the object along the x axis.
//  ai_scaleheight	The percentage to scale the object along the y axis.
//
//	Returns:  		integer
//			1 if it succeeds and -1 if an error occurs.
//
//	Description:  	Register a control which needs to either be moved or resized
//						when the parent object is resized.  The action taken on this
//						control depends on the four attributes: ai_movex, ai ai_movey,
//						ai_scalewidth, ai_scaleheight.
//						Note: the service object needs to be initialized (of_SetOrigSize())
//						prior to	any registering (this function) of objects.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright  1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
dragobject		ldrg_cntrl
oval				loval_cntrl
line				ln_cntrl
rectangle		lrec_cntrl
roundrectangle	lrrec_cntrl
tab				ltab_cntrl
userobject luo_cntrl
integer			li_x, li_y, li_width, li_height
integer			li_upperbound
integer			li_cnt
integer			li_slot_available
boolean			lb_movex=False, lb_movey=False
boolean			lb_scalewidth=False, lb_scaleheight=False
//Check parameters
If IsNull(awo_control) or Not IsValid(awo_control) or &
	IsNull(ab_scale) or &
	IsNull(ai_movex) or ai_movex<0 or ai_movex>100 or &
	IsNull(ai_movey) or ai_movey<0 or ai_movey>100 or &
	IsNull(ai_scalewidth) or ai_scalewidth<0 or ai_scalewidth>100 or & 
	IsNull(ai_scaleheight) or ai_scaleheight<0 or ai_scaleheight>100 Then
	Return -1
End If
//Translate parameteters.
If ab_scale Then
	ai_movex = 0
	ai_movey = 0
	ai_scalewidth = 0
	ai_scaleheight = 0
End If
lb_movex = (ai_movex > 0)
lb_movey = (ai_movey > 0)
lb_scalewidth = (ai_scalewidth > 0)
lb_scaleheight = (ai_scaleheight > 0)
//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If
//Get the previous Bound
li_upperbound = UpperBound (inv_registered[])
//Determine if there is an open slot available other than a
//new entry on the array
li_slot_available = 0
For li_cnt = 1 to li_upperbound
	If IsNull(inv_registered[li_cnt].wo_control) Or &
		Not IsValid(inv_registered[li_cnt].wo_control) Then
		If li_slot_available = 0 Then
			//Get the first slot found
			li_slot_available = li_cnt
		End If
	Else
		//Check if control has already been registered
		If inv_registered[li_cnt].wo_control = awo_control Then
			//Return -1
			li_slot_available = li_cnt
		End If
	End If
Next
//If an available slot was not found then create a new entry
If li_slot_available = 0 Then
	li_slot_available = li_upperbound + 1
End If
///////////////////////////////////////////////////////////////////////////////////////
//Register the new object
///////////////////////////////////////////////////////////////////////////////////////
//Validate and set typeof value
Choose Case of_TypeOf(awo_control)
	Case DRAGOBJECT
		//Store a reference to the control
		ldrg_cntrl = awo_control
		//Store the type of the control to speed access to its attributes
		inv_registered[li_slot_available].s_typeof = DRAGOBJECT		
		//Store the position and size of control
		li_x = ldrg_cntrl.X
		li_y = ldrg_cntrl.Y
		li_width = ldrg_cntrl.Width
		li_height = ldrg_cntrl.Height
	Case LINE
		ln_cntrl = awo_control
		inv_registered[li_slot_available].s_typeof = LINE		
		li_x = ln_cntrl.BeginX
		li_y = ln_cntrl.BeginY
		li_width = ln_cntrl.EndX
		li_height = ln_cntrl.EndY
	Case OVAL
		loval_cntrl = awo_control
		inv_registered[li_slot_available].s_typeof = OVAL			
		li_x = loval_cntrl.X
		li_y = loval_cntrl.Y
		li_width = loval_cntrl.Width
		li_height = loval_cntrl.Height		
	Case RECTANGLE
		lrec_cntrl = awo_control
		inv_registered[li_slot_available].s_typeof = RECTANGLE		
		li_x = lrec_cntrl.X
		li_y = lrec_cntrl.Y
		li_width = lrec_cntrl.Width
		li_height = lrec_cntrl.Height		
	Case ROUNDRECTANGLE
		lrrec_cntrl = awo_control
		inv_registered[li_slot_available].s_typeof = ROUNDRECTANGLE				
		li_x = lrrec_cntrl.X
		li_y = lrrec_cntrl.Y
		li_width = lrrec_cntrl.Width
		li_height = lrrec_cntrl.Height		
	Case Else
		//An unknown control type has been encountered
		Return -1
End Choose
//Register the actual object
inv_registered[li_slot_available].wo_control = awo_control
inv_registered[li_slot_available].s_classname = awo_control.ClassName()
//Set the behavior attributes
inv_registered[li_slot_available].b_movex = lb_movex
inv_registered[li_slot_available].i_movex = ai_movex
inv_registered[li_slot_available].b_movey = lb_movey
inv_registered[li_slot_available].i_movey = ai_movey
inv_registered[li_slot_available].b_scalewidth = lb_scalewidth
inv_registered[li_slot_available].i_scalewidth = ai_scalewidth
inv_registered[li_slot_available].b_scaleheight = lb_scaleheight
inv_registered[li_slot_available].i_scaleheight = ai_scaleheight
inv_registered[li_slot_available].b_scale = ab_scale
//Set the initial position/size attributes
inv_registered[li_slot_available].r_x = li_x
inv_registered[li_slot_available].r_y = li_y
inv_registered[li_slot_available].r_width = li_width
inv_registered[li_slot_available].r_height = li_height
inv_registered[li_slot_available].i_origX = li_x
inv_registered[li_slot_available].i_origY = li_y
inv_registered[li_slot_available].i_origWidth = li_width
inv_registered[li_slot_available].i_origHeight = li_height
if awo_control.typeOf() = tab! then
	ltab_cntrl = awo_control
	inv_registered[li_slot_available].i_tabWidth = ltab_cntrl.control[1].width
	inv_registered[li_slot_available].i_tabHeight = ltab_cntrl.control[1].height
end if
if awo_control.typeOf() = userobject!  then
	luo_cntrl = awo_control
	inv_registered[li_slot_available].i_uowidth = luo_cntrl.width
	inv_registered[li_slot_available].i_uoheight = luo_cntrl.height
end if
Choose Case awo_control.TypeOf()
	Case  datawindow!, &
			graph!, listbox!, listview!, multilineedit!, picturelistbox!, &
			richtextedit!, tab!, treeview!, userobject!, oval!,  &
			rectangle!, roundrectangle!, mdiclient!,groupbox!
		inv_registered[li_slot_available].b_sizable = true
	case else
		inv_registered[li_slot_available].b_sizable = false
End Choose
Return li_slot_available
end function

private function integer of_register (windowobject awo_obj);
return of_register(awo_obj, "")
end function

public function integer of_init ();
int i, li_idx
string ls_objName
boolean lb_selfSizable, lb_upSizable, lb_leftSizable
for i = 1 to upperBound(inv_registered)
	ls_objName = inv_registered[i].s_className
	lb_selfSizable = inv_registered[i].b_sizable
	lb_upSizable = of_checkSizeType(inv_registered[i], "origy", "origx", "origwidth")
	lb_leftSizable = of_checkSizeType(inv_registered[i], "origx", "origy", "origheight")
	li_idx = of_setResizeType(inv_registered[i].wo_control, lb_leftSizable, lb_upSizable, lb_selfSizable)
	//<Modified At 2014-06-27>
	if inv_registered[i].wo_control.typeOf() = tab! or inv_registered[i].wo_control.typeof() = userobject! then
		i_tabIdx[upperBound(i_tabIdx) + 1] = li_idx
	end if
next
return 1
end function

private function boolean of_checksizetype (eon_cst_resizeattrib a_attr, string as_filterstart, string as_origstart, string as_origlength);
integer li_filterStart, li_selfStart, li_selfLength
int li_filter, li_start, li_length
int li_x, li_y, li_width, li_height
int li_x1, li_y1, li_width1, li_height1
int i
boolean lb_sizable, lb_flag
if as_filterStart = "origx" then
	li_filterStart = a_attr.i_origX
else
	li_filterStart = a_attr.i_origY
end if
if as_origStart = "origx" then
	li_selfStart = a_attr.i_origX
else
	li_selfStart = a_attr.i_origY
end if
if as_origLength = "origwidth" then
	li_selfLength = a_attr.i_origWidth
else
	li_selfLength = a_attr.i_origHeight
end if
li_x = a_attr.i_origX
li_y = a_attr.i_origY
li_width = a_attr.i_origWidth
li_height = a_attr.i_origHeight
for i = 1 to upperBound(inv_registered)
	if a_attr.s_className = inv_registered[i].s_className then continue
	if as_filterStart = "origx" then
		li_filter = inv_registered[i].i_origX
	else
		li_filter = inv_registered[i].i_origY
	end if
	if li_filter < li_filterStart then
		if as_origStart = "origx" then
			li_start = inv_registered[i].i_origX
		else
			li_start = inv_registered[i].i_origY
		end if
		if as_origLength = "origwidth" then
			li_length = inv_registered[i].i_origWidth
		else
			li_length = inv_registered[i].i_origHeight
		end if
		li_x1 = inv_registered[i].i_origX
		li_y1 = inv_registered[i].i_origY
		li_width1 = inv_registered[i].i_origWidth
		li_height1 = inv_registered[i].i_origHeight
		if li_x1 < li_x then
			if li_y1 < li_y then
				if (li_x1 + li_width1) > (li_x + li_width) then
					if (li_y1 + li_height1) > (li_y + li_height) then
						continue
					end if
				end if
			end if
		end if
		lb_flag = false
		if li_start < li_selfStart then
			if li_selfStart < (li_start + li_length) then
				lb_flag = true
			end if
		else
			if li_start < (li_selfStart + li_selfLength) then
				lb_flag = true
			end if
		end if
		if lb_flag = true then
			lb_sizable = inv_registered[i].b_sizable
			if lb_sizable = true then
				return lb_sizable
			end if
		end if
	end if
next
return false
end function

public function integer of_init (userobject a_obj);
int i, li_width, li_height
tab ltab
li_width = a_obj.width
li_height = a_obj.height
of_setOrigSize(li_width, li_height)
for i = 1 to upperBound(a_obj.control)
	of_register(a_obj.control[i])
next
of_init()
iuo_component = a_obj
ipo_component = a_obj
return 1
end function

public function integer of_init (window a_obj);
int i
of_setOrigSize(a_obj.width, a_obj.height)
for i = 1 to upperBound(a_obj.control)
	of_register(a_obj.control[i])
next
of_init()
ipo_component = a_obj
return 0
end function

public function string of_getcomponentname ();
return ipo_component.classname( )
end function

private function integer of_setresizetype (powerobject awo_control, boolean ab_leftsizetype, boolean ab_upsizetype, boolean ab_selfsizable);
string ls_sizeType
if ab_selfSizable = false then
	if ab_upSizeType = false then
		if ab_leftSizeType = false then
			//inv_resize.of_register(ipo_list[li_idx], inv_resize.SCALERIGHTBOTTOM)
			ls_sizeType = ""
		else
			ls_sizeType = FIXEDRIGHT
		end if
	else
		if ab_leftSizeType = false then
			ls_sizeType = FIXEDBOTTOM
		else
			ls_sizeType = FIXEDRIGHTBOTTOM
		end if
	end if
else
	if ab_upSizeType = false then
		if ab_leftSizeType = false then
			ls_sizeType = SCALERIGHTBOTTOM
		else
			ls_sizeType = FIXEDRIGHT_SCALEBOTTOM
		end if
	else
		if ab_leftSizeType = false then
			ls_sizeType = FIXEDBOTTOM_SCALERIGHT
		else
			ls_sizeType = FIXEDRIGHTBOTTOM
		end if
	end if
end if
return of_register(awo_control, ls_sizeType)
end function

public function integer of_resize (integer ai_newwidth, integer ai_newheight);//////////////////////////////////////////////////////////////////////////////
//	Protected Function:		of_Resize
//	Arguments:					ai_newwidth		The new width of the parent object.
//									ai_newheight	The new height of the parent object.
//	Returns:  					integer
//							1 if it succeeds and -1 if an error occurs.
//	Description:  				Moves or resizes objects that were registered with the service.
//									Performs the actions that were requested via the
//									of_SetOrigSize() and of_Register functions.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History					Version
//									5.0		Initial version
// 									6.0		Changed to support for weighted movement and sizing of controls.
// 									6.0		Changed to use new constants.
//									8.0		Changed from Move for drawing objects to setting X and Y
//////////////////////////////////////////////////////////////////////////////
//	Copyright  1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//Note: For the line control: the width and height variables are
//										used to hold EndX and EndY attributes.
//////////////////////////////////////////////////////////////////////////////
//Temporary controls to get to attributes
dragobject		ldrg_cntrl
oval				loval_cntrl
line				lln_cntrl
rectangle		lrec_cntrl
roundrectangle	lrrec_cntrl
tab				ltab_cntrl
//Local variables
integer			li_upperbound
integer			li_cnt
integer			li_x, li_y, li_width, li_height
integer			li_deltawidth, li_deltaheight
real				lr_ratiowidth, lr_ratioheight
real				lr_move_deltax, lr_move_deltay
real				lr_resize_deltawidth, lr_resize_deltaheight
//Confirm that the user object has already been initialized
If il_parentprevheight=-1 And il_parentprevwidth=-1 Then
	Return -1
End If
//Check the parameters
If IsNull(ai_newwidth) or IsNull(ai_newheight) Then
	return -1
End If
//Prevent the contents of the windows from resizing past the min width/height
If ai_newwidth < il_parentminimumwidth   Then ai_newwidth = il_parentminimumwidth
If ai_newheight < il_parentminimumheight Then ai_newheight = il_parentminimumheight
//Set the deltas/ratios for the width and height as compared to the previous size
li_deltawidth  = ai_newwidth  - il_parentprevwidth 
li_deltaheight = ai_newheight - il_parentprevheight
If il_parentprevwidth=0 Then il_parentprevwidth=1
If il_parentprevheight=0 Then il_parentprevheight=1	
lr_ratiowidth  = ai_newwidth  / il_parentprevwidth
lr_ratioheight = ai_newheight / il_parentprevheight
//Only continue if the size has changed
If li_deltawidth=0 And li_deltaheight=0 Then Return 1
//Set the new previous size
il_parentprevwidth = ai_newwidth
il_parentprevheight = ai_newheight
///////////////////////////////////////////////////////////////////////////////////////////////
// Loop through all registered controls - Moving and resizing as appropriate
///////////////////////////////////////////////////////////////////////////////////////////////
//Loop trough all controls
li_upperbound = UpperBound (inv_registered[])
For li_cnt = 1 to li_upperbound
	//Initialize variables
	li_x = 0
	li_y = 0 
	li_width = 0
	li_height = 0
	lr_move_deltax = 0	
	lr_move_deltay = 0
	lr_resize_deltawidth = 0	
	lr_resize_deltaheight = 0	
	SetNull(ldrg_cntrl)
	SetNull(loval_cntrl)
	SetNull(lln_cntrl)
	SetNull(lrec_cntrl)
	SetNull(lrrec_cntrl)
	If IsValid(inv_registered[li_cnt].wo_control) Then
		inv_registered[li_cnt].i_prevX = inv_registered[li_cnt].r_x
		inv_registered[li_cnt].i_prevY = inv_registered[li_cnt].r_y
		inv_registered[li_cnt].i_prevWidth = inv_registered[li_cnt].r_width
		inv_registered[li_cnt].i_prevHeight = inv_registered[li_cnt].r_height
		//Get attribute information from the appropriate control
		Choose Case inv_registered[li_cnt].s_typeof
			Case DRAGOBJECT
				ldrg_cntrl = inv_registered[li_cnt].wo_control
				li_x = ldrg_cntrl.X
				li_y = ldrg_cntrl.Y
				li_width = ldrg_cntrl.Width
				li_height = ldrg_cntrl.Height
			Case LINE
				// For the line control, the width and height variables 
				// are used to hold EndX and EndY attributes
				lln_cntrl = inv_registered[li_cnt].wo_control
				li_x = lln_cntrl.BeginX
				li_y = lln_cntrl.BeginY
				li_width = lln_cntrl.EndX
				li_height = lln_cntrl.EndY
			Case OVAL
				loval_cntrl = inv_registered[li_cnt].wo_control
				li_x = loval_cntrl.X
				li_y = loval_cntrl.Y
				li_width = loval_cntrl.Width
				li_height = loval_cntrl.Height	
			Case RECTANGLE
				lrec_cntrl = inv_registered[li_cnt].wo_control
				li_x = lrec_cntrl.X
				li_y = lrec_cntrl.Y
				li_width = lrec_cntrl.Width
				li_height = lrec_cntrl.Height
			Case ROUNDRECTANGLE
				lrrec_cntrl = inv_registered[li_cnt].wo_control			
				li_x = lrrec_cntrl.X
				li_y = lrrec_cntrl.Y
				li_width = lrrec_cntrl.Width
				li_height = lrrec_cntrl.Height				
			Case Else
				Return -1
		End Choose
		//Correct for any rounding or moving/resizing of objects trough
		//any other means
		If abs(inv_registered[li_cnt].r_x - li_x) > ii_rounding Then
			inv_registered[li_cnt].r_x = li_x
		End If				
		If abs(inv_registered[li_cnt].r_y - li_y) > ii_rounding Then
			inv_registered[li_cnt].r_y = li_y
		End If		
		If abs(inv_registered[li_cnt].r_width - li_width) > ii_rounding And &
		   li_width > inv_registered[li_cnt].i_widthmin Then
			inv_registered[li_cnt].r_width = li_width
		End If							
		If abs(inv_registered[li_cnt].r_height - li_height) > ii_rounding And &
		   li_height > inv_registered[li_cnt].i_heightmin Then
			inv_registered[li_cnt].r_height = li_height
		End If			
		//Define the deltas for this control:  Move and Resize
		If inv_registered[li_cnt].b_scale Then
			lr_move_deltax = (inv_registered[li_cnt].r_x * lr_ratiowidth) - inv_registered[li_cnt].r_x
			lr_move_deltay = (inv_registered[li_cnt].r_y * lr_ratioheight) - inv_registered[li_cnt].r_y
			lr_resize_deltawidth = (inv_registered[li_cnt].r_width * lr_ratiowidth) - inv_registered[li_cnt].r_width
			lr_resize_deltaheight = (inv_registered[li_cnt].r_height * lr_ratioheight) - inv_registered[li_cnt].r_height
		Else
			// Prevent the weighted value from being overriden.
			If inv_registered[li_cnt].b_movex And inv_registered[li_cnt].i_movex = 0 Then
				inv_registered[li_cnt].i_movex = 100
			End If
			If inv_registered[li_cnt].b_movey And inv_registered[li_cnt].i_movey = 0 Then
				inv_registered[li_cnt].i_movey = 100
			End If
			If inv_registered[li_cnt].b_scalewidth And inv_registered[li_cnt].i_scalewidth=0 Then
				inv_registered[li_cnt].i_scalewidth = 100
			End If
			If inv_registered[li_cnt].b_scaleheight And inv_registered[li_cnt].i_scaleheight=0 Then
				inv_registered[li_cnt].i_scaleheight = 100
			End If			
			// Support for weighted movement and sizing of controls.
			If inv_registered[li_cnt].b_movex Then 
				lr_move_deltax = li_deltawidth * inv_registered[li_cnt].i_movex / 100
			End If
			If inv_registered[li_cnt].b_movey Then 
				lr_move_deltay = li_deltaheight * inv_registered[li_cnt].i_movey / 100
			End If
			If inv_registered[li_cnt].b_scalewidth Then 
				lr_resize_deltawidth = li_deltawidth * inv_registered[li_cnt].i_scalewidth / 100
			End If
			If inv_registered[li_cnt].b_scaleheight Then 
				lr_resize_deltaheight = li_deltaheight * inv_registered[li_cnt].i_scaleheight /100
			End If
		End If
		//If appropriate move the control along the X and Y attribute.
		If lr_move_deltax <> 0 Or lr_move_deltay <> 0 Then	
			//Save the 'exact' X and Y attributes.
			inv_registered[li_cnt].r_x = inv_registered[li_cnt].r_x + lr_move_deltax		
			inv_registered[li_cnt].r_y = inv_registered[li_cnt].r_y + lr_move_deltay
			Choose Case inv_registered[li_cnt].s_typeof
				Case DRAGOBJECT
					ldrg_cntrl.Move (inv_registered[li_cnt].r_x, inv_registered[li_cnt].r_y)
				Case LINE
					//X moving
					lln_cntrl.BeginX = inv_registered[li_cnt].r_x
					inv_registered[li_cnt].r_width = inv_registered[li_cnt].r_width + lr_move_deltax					
					lln_cntrl.EndX = inv_registered[li_cnt].r_width
					//Y moving
					lln_cntrl.BeginY = inv_registered[li_cnt].r_y
					inv_registered[li_cnt].r_height = inv_registered[li_cnt].r_height + lr_move_deltay
					lln_cntrl.EndY = inv_registered[li_cnt].r_height					
				Case OVAL
					loval_cntrl.X = inv_registered[li_cnt].r_x
					loval_cntrl.Y = inv_registered[li_cnt].r_y
				Case RECTANGLE
					lrec_cntrl.X = inv_registered[li_cnt].r_x
					lrec_cntrl.Y = inv_registered[li_cnt].r_y
				Case ROUNDRECTANGLE
					lrrec_cntrl.X = inv_registered[li_cnt].r_x
					lrrec_cntrl.Y = inv_registered[li_cnt].r_y
			End Choose	
		End If /* Move */
		//If appropriate Resize the Width And Height of the control.
		//Performing one Resize instead of changing Width and Height individually.
		If lr_resize_deltawidth <> 0 Or lr_resize_deltaheight <> 0 Then		
			//Save the 'exact' Width and Height attributes.
			inv_registered[li_cnt].r_width = inv_registered[li_cnt].r_width + lr_resize_deltawidth	
			inv_registered[li_cnt].r_height = inv_registered[li_cnt].r_height + lr_resize_deltaheight		
			Choose Case inv_registered[li_cnt].s_typeof
				Case DRAGOBJECT
					ldrg_cntrl.Resize (inv_registered[li_cnt].r_width, inv_registered[li_cnt].r_height)
					li_width = ldrg_cntrl.Width
					li_height = ldrg_cntrl.Height
				Case LINE
					lln_cntrl.EndX = inv_registered[li_cnt].r_width
				Case OVAL
					loval_cntrl.Resize (inv_registered[li_cnt].r_width, inv_registered[li_cnt].r_height)
					li_width = loval_cntrl.Width
					li_height = loval_cntrl.Height					
				Case RECTANGLE
					lrec_cntrl.Resize (inv_registered[li_cnt].r_width, inv_registered[li_cnt].r_height)
					li_width = lrec_cntrl.Width
					li_height = lrec_cntrl.Height	
				Case ROUNDRECTANGLE
					lrrec_cntrl.Resize (inv_registered[li_cnt].r_width, inv_registered[li_cnt].r_height)
					li_width = lrrec_cntrl.Width
					li_height = lrrec_cntrl.Height					
			End Choose		
			//Determine if the object does not support the requested Width or Height.
			//Used to determine if the object was resized by any other means.
			If li_width > inv_registered[li_cnt].r_width Then
				inv_registered[li_cnt].i_widthmin = li_width
			Else
				inv_registered[li_cnt].i_widthmin = 0
			End If
			If li_height > inv_registered[li_cnt].r_height Then
				inv_registered[li_cnt].i_heightmin = li_height
			Else
				inv_registered[li_cnt].i_heightmin = 0
			End If					
			if inv_registered[li_cnt].wo_control.typeOf() = tab! then
				inv_registered[li_cnt].i_tabWidth = inv_registered[li_cnt].i_tabWidth + (li_width - inv_registered[li_cnt].i_prevWidth)
				inv_registered[li_cnt].i_tabHeight = inv_registered[li_cnt].i_tabHeight + (li_height - inv_registered[li_cnt].i_prevHeight)
				if inv_registered[li_cnt].i_tabWidth < 0 then
					inv_registered[li_cnt].i_tabWidth = 0
				end if
				if inv_registered[li_cnt].i_tabHeight < 0 then
					inv_registered[li_cnt].i_tabHeight = 0
				end if
			end if
			if inv_registered[li_cnt].wo_control.typeOf() = userobject! then
				inv_registered[li_cnt].i_uoWidth = inv_registered[li_cnt].i_uoWidth + (li_width - inv_registered[li_cnt].i_prevWidth)
				inv_registered[li_cnt].i_uoHeight = inv_registered[li_cnt].i_uoHeight + (li_height - inv_registered[li_cnt].i_prevHeight)
				if inv_registered[li_cnt].i_uoWidth < 0 then
					inv_registered[li_cnt].i_uoWidth = 0
				end if
				if inv_registered[li_cnt].i_uoHeight < 0 then
					inv_registered[li_cnt].i_uoHeight = 0
				end if
			end if
		End If /* Resize */
	End If /* If IsValid(inv_registered[li_cnt].wo_control) Then */
Next /* For li_cnt = 1 to li_upperbound */
Return 1
end function

protected function string of_typeof (powerobject awo_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_TypeOf
//
//	Access:  		protected
//
//	Arguments:		
//	awo_control		The window object for which a type is needed.
//
//	Returns:  		string
//						Describes the type of the object.
//						'!' if an error occurs.
//
//	Description:  	Determines on the type of an object for the purposes of 
//						getting to its attributes.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Changed to use new constants.
// 7.0	Added new controls hprogressbar!, htrackbar!, vprogressbar!,
//			vtrackbar!, picturehyperlink!, statichyperlink!
//10 Added new controls monthcalendar!
//11 Added new datatype windowobject!,new controls  datepicker!
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright 1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
//Check parameters
If IsNull(awo_control) or (not IsValid(awo_control)) Then
	Return '!'
End If
//Validate and set typeof value
Choose Case awo_control.TypeOf()
	Case  checkbox!, commandbutton!, datawindow!, dropdownlistbox!, dropdownpicturelistbox!, &
			editmask!, graph!, groupbox!, hprogressbar!, hscrollbar!, htrackbar!, listbox!,  &
			listview!, multilineedit!, olecontrol!, olecustomcontrol!, omcontrol!, omcustomcontrol!,  &
			omembeddedcontrol!, picture!, picturebutton!, picturehyperlink!, picturelistbox!,  &
			radiobutton!, richtextedit!, singlelineedit!, statichyperlink!, statictext!,  &
			tab!, treeview!, userobject!, vprogressbar!, vscrollbar!, vtrackbar!, monthcalendar!, datepicker!
		Return DRAGOBJECT
	Case  line!
		Return LINE
	Case  oval!
		Return OVAL
	Case  rectangle!
		Return RECTANGLE
	Case  roundrectangle!
		Return ROUNDRECTANGLE
	Case  mdiclient!
		Return MDICLIENT
End Choose
Return '!'
end function

on eon_cst_resize.create
call super::create
TriggerEvent( this, "constructor" )
end on

on eon_cst_resize.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_n_cst_resize
//
//	Description:
//	Resize service.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version - Claudio J. Quant
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright  1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
end event

