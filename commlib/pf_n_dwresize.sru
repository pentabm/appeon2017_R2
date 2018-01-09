HA$PBExportHeader$pf_n_dwresize.sru
$PBExportComments$Datawindow $$HEX20$$e8ceb8d264b82000acb9acc074c788c920001cc144bea4c27cb920001cc8f5ac200069d5c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_dwresize from nonvisualobject
end type
end forward

global type pf_n_dwresize from nonvisualobject
event type integer ue_resize ( unsignedlong aul_sizetype,  integer ai_newwidth,  integer ai_newheight )
end type
global pf_n_dwresize pf_n_dwresize

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

Protected:
constant string LINE='line'
constant string EMPTY=''

int	ii_rounding = 5
long 	il_parentminimumwidth=0
long	il_parentminimumheight=0
long	il_parentprevwidth=-1
long	il_parentprevheight=-1

//	7.0   Instance variable datatype changed from os_resize to n_cst_dwsrv_resizeattrib type
//	7.0   Instance variable name changed from istr_newupdate to inv_newupdate
pf_n_dwresizeattrib	inv_registered[]

datawindow	idw_requestor

end variables

forward prototypes
public function integer of_setrequestor (datawindow adw_requestor)
public function integer of_register (string as_control, boolean ab_scale, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight)
public function integer of_getobjectinformation (string as_control, ref string as_type, ref integer ai_x, ref integer ai_y, ref integer ai_width, ref integer ai_height)
public function integer of_getregisterable (ref string as_objects[])
public function integer of_getobjects (ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly)
public function integer of_getobjects (ref string as_objlist[])
public function integer of_getregistered (dwobject adwo_control, ref boolean ab_scale, ref integer ai_movex, ref integer ai_movey, ref integer ai_scalewidth, ref integer ai_scaleheight)
public function integer of_getregistered (ref string as_control[], ref boolean ab_scale[], ref integer ai_movex[], ref integer ai_movey[], ref integer ai_scalewidth[], ref integer ai_scaleheight[])
public function integer of_getregistered (string as_control, ref boolean ab_scale, ref integer ai_movex, ref integer ai_movey, ref integer ai_scalewidth, ref integer ai_scaleheight)
public function boolean of_isregistered (dwobject adwo_control)
public function boolean of_isregistered (string as_control)
public function integer of_register (dwobject adwo_control, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight)
public function integer of_register (dwobject adwo_control, string as_method)
public function integer of_register (string as_control, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight)
public function integer of_register (string as_control, string as_method)
public function integer of_resize (integer ai_newwidth, integer ai_newheight)
public function integer of_setminsize (integer ai_minwidth, integer ai_minheight)
public function integer of_setorigsize (integer ai_width, integer ai_height)
public function integer of_unregister (dwobject adwo_control)
public function integer of_unregister (string as_control)
public function integer of_autoresizeregister ()
end prototypes

event type integer ue_resize(unsignedlong aul_sizetype, integer ai_newwidth, integer ai_newheight);//////////////////////////////////////////////////////////////////////////////
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
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return of_Resize(ai_newwidth, ai_newheight)

end event

public function integer of_setrequestor (datawindow adw_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetRequestor
//
//	Access:    Public
//
//	Arguments:
//   adw_Requestor   The datawindow requesting the service
//
//	Returns:  Integer
//
//	Description:  Associates a datawindow control with a datawindow service NVO
//			        by setting the idw_Requestor instance variable.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

string ls_describeret
constant string COMPOSITE='5'
constant string RTE='7'

// Validate the reference.
If IsNull(adw_Requestor) or Not IsValid(adw_Requestor) Then
	Return -1
End If

// Confirm this datawindow does not contain an unsupported object.
ls_describeret = adw_Requestor.Object.DataWindow.Processing
//0 Form, group, query, or tabular
//1 Grid, 2 Label, 3 Graph, 4 Crosstab
//5 Composite, 6 ole, 7 rte
If ls_describeret=COMPOSITE or ls_describeret=RTE Then 
	Return -1
End If

idw_Requestor = adw_Requestor
Return 1
end function

public function integer of_register (string as_control, boolean ab_scale, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		protected
//
//	Arguments:		
//	 as_control			The object being registered.
//  ab_scale			If the object should be registered as a Scale type.
//  ai_movex			The percentage to move the object along the x axis.
//  ai_movey			The percentage to move the object along the y axis.
//  ai_scalewidth 	The percentage to scale the object along the x axis.
//  ai_scaleheight	The percentage to scale the object along the y axis.
//
//	Returns:  		integer
//						1 if it succeeds and?-1 if an error occurs.
//
//	Description:  	
//	Register a control which needs to either be moved or resized when the parent
//	object is resized.  The action taken on this control depends on the four
//	attributes: ai_movex, ai ai_movey, ai_scalewidth, ai_scaleheight.
//
//	Note:
//	The service object needs to be initialized (of_SetOrigSize()) prior to	
//	any registering (this function) of objects.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

integer			li_rc
integer			li_x, li_y, li_width, li_height
integer			li_upperbound
integer			li_cnt
integer			li_slot_available
boolean			lb_movex=False, lb_movey=False
boolean			lb_scalewidth=False, lb_scaleheight=False
string			ls_describeret, ls_describeexp
string			ls_type

// Validate the reference.
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
	Return -1
End If

//Check parameters
If IsNull(as_control) or Len(Trim(as_control))=0 or &
	IsNull(ab_scale) or &
	IsNull(ai_movex) or ai_movex<0 or ai_movex>100 or &
	IsNull(ai_movey) or ai_movey<0 or ai_movey>100 or &
	IsNull(ai_scalewidth) or ai_scalewidth<0 or ai_scalewidth>100 or & 
	IsNull(ai_scaleheight) or ai_scaleheight<0 or ai_scaleheight>100 Then
	Return -1
End If

// Validate the object.
ls_describeret = idw_requestor.Describe(as_control+'.Attributes')
If IsNull(ls_describeret) or ls_describeret='!' or ls_describeret='?' Then
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
	If IsNull(inv_registered[li_cnt].s_control) Or &
		Len(Trim(inv_registered[li_cnt].s_control))=0 Then
		If li_slot_available = 0 Then
			//Get the first slot found
			li_slot_available = li_cnt
		End If
	Else
		//Check if control has already been registered
		If inv_registered[li_cnt].s_control = as_control Then
			Return -1
		End If
	End If
Next

//If an available slot was not found then create a new entry
If li_slot_available = 0 Then
	li_slot_available = li_upperbound + 1
End If

///////////////////////////////////////////////////////////////////////////////////////
//Get the current object information/coordinates
///////////////////////////////////////////////////////////////////////////////////////
li_rc = of_GetObjectInformation (as_control, ls_type, li_x, li_y, li_width, li_height)
If li_rc < 0 then Return -1

///////////////////////////////////////////////////////////////////////////////////////
//Register the new object
///////////////////////////////////////////////////////////////////////////////////////

//Register the actual object
inv_registered[li_slot_available].s_control = as_control
inv_registered[li_slot_available].s_typeof = ls_type	

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

Return 1

end function

public function integer of_getobjectinformation (string as_control, ref string as_type, ref integer ai_x, ref integer ai_y, ref integer ai_width, ref integer ai_height);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetObjectInformation
//
//	Scope:  		protected
//
//	Arguments:		
//	 as_control		The object whose current information is needed.
//  as_type(by reference)	The object type.
//  ai_x(by reference)		The object x.
//	 ai_y(by reference)		The object y.
//  ai_width(by reference)	The object width.		
//  ai_height(by reference) The object height.
//
//	Returns:  		integer
//						1 if it succeeds and?-1 if an error occurs.
//
//	Description:  	
//		Get the desired object information from the datawindow object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

string  ls_type
string  ls_describeret
integer li_x
integer li_y
integer li_height
integer li_width

// Validate the reference.
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
	Return -1
End If

//Validate and set type value
ls_describeret = idw_requestor.Describe(as_control+'.Type')
If IsNull(ls_describeret) or ls_describeret='!' or ls_describeret='?' Then
	Return -1
End If
ls_type = ls_describeret

//Get the coordinates.
If Pos(ls_type, LINE) > 0 Then
	ls_describeret = idw_requestor.Describe(as_control+'.X1')
	If IsNull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or Not IsNumber(ls_describeret) Then
		Return -1
	End If
	li_x = Integer (ls_describeret)

	ls_describeret = idw_requestor.Describe(as_control+'.Y1')
	If IsNull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or Not IsNumber(ls_describeret) Then
		Return -1
	End If
	li_y = Integer (ls_describeret)

	ls_describeret = idw_requestor.Describe(as_control+'.X2')
	If IsNull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or Not IsNumber(ls_describeret) Then
		Return -1
	End If
	li_width = Integer (ls_describeret)

	ls_describeret = idw_requestor.Describe(as_control+'.Y2')
	If IsNull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or Not IsNumber(ls_describeret) Then
		Return -1
	End If
	li_height = Integer (ls_describeret)	
Else
	ls_describeret = idw_requestor.Describe(as_control+'.X')
	If IsNull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or Not IsNumber(ls_describeret) Then
		Return -1
	End If
	li_x = Integer (ls_describeret)

	ls_describeret = idw_requestor.Describe(as_control+'.Y')
	If IsNull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or Not IsNumber(ls_describeret) Then
		Return -1
	End If
	li_y = Integer (ls_describeret)

	ls_describeret = idw_requestor.Describe(as_control+'.Width')
	If IsNull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or Not IsNumber(ls_describeret) Then
		Return -1
	End If
	li_width = Integer (ls_describeret)

	ls_describeret = idw_requestor.Describe(as_control+'.Height')
	If IsNull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or Not IsNumber(ls_describeret) Then
		Return -1
	End If
	li_height = Integer (ls_describeret)
End If

as_type = ls_type
ai_x = li_x
ai_y = li_y
ai_width = li_width
ai_height = li_height
Return 1
end function

public function integer of_getregisterable (ref string as_objects[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetRegisterable
//
//	Access:    		Public
//
//	Arguments:
//   as_objects[] (by ref)	 Will hold all the objects that can be registered.
//
//	Returns:   		Integer
// Number of entries in array.
//	-1 if an error occurs.
//
//	Description:  
//	To get the list of all the objects that can be registered.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

integer	li_numobjs
string	ls_objects[]
string	ls_empty[]

// Clear the reference variable.
as_objects = ls_empty

// Get all the Visible objects on the datawindow.
// Objects that are not visible do not Coordinates and therefore cannot be registered.
li_numobjs = of_GetObjects ( ls_objects, "*", "*", TRUE ) 
If li_numobjs < 0 Then Return -1

// Return the objects.
as_objects = ls_objects
Return UpperBound(as_objects)



end function

public function integer of_getobjects (ref string as_objlist[], string as_objtype, string as_band, boolean ab_visibleonly);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetObjects (FORMAT 2)
//
//	Access:    		Public
//
//	Arguments:
//   as_objlist[]:	A string array to hold objects (passed by reference)
//   as_objtype:  	The type of objects to get (* for all, others defined
//							by the object .TYPE attribute)
//   as_band:  		The dw band to get objects from (* for all) 
//							Valid bands: header, detail, footer, summary
//							header.#, trailer.#
//   ab_visibleonly: TRUE  - get only the visible objects,
//							 FALSE - get visible and non-visible objects
//
//	Returns:  		Integer
//   					The number of objects in the array
//
//	Description:	The following function will parse the list of objects 
//						contained in the datawindow control associated with this service,
//						returning their names into a string array passed by reference, 
//						and returning the number of names in the array as the return value 
//						of the function.
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
//	Copyright $$HEX2$$d2242000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string	ls_ObjString, ls_ObjHolder
integer	li_Start=1, li_Tab, li_Count=0

/* Get the Object String */
ls_ObjString = idw_Requestor.Describe("Datawindow.Objects")

/* Get the first tab position. */
li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Do While li_Tab > 0
	ls_ObjHolder = Mid(ls_ObjString, li_Start, (li_Tab - li_Start))

	// Determine if object is the right type and in the right band
	If (as_ObjType = "*" or idw_Requestor.Describe(ls_ObjHolder + ".type") = as_ObjType ) And &
		(as_Band = "*" or idw_Requestor.Describe(ls_ObjHolder + ".band") = as_Band ) And &
		(Not ab_VisibleOnly Or idw_Requestor.Describe(ls_ObjHolder + ".visible") = "1") Then
			li_Count ++
			as_ObjList[li_Count] = ls_ObjHolder
	End if

	/* Get the next tab position. */
	li_Start = li_Tab + 1
	li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Loop 

// Check the last object
ls_ObjHolder = Mid(ls_ObjString, li_Start, Len(ls_ObjString))

// Determine if object is the right type and in the right band
If (idw_Requestor.Describe(ls_ObjHolder + ".type") = as_ObjType or as_ObjType = "*") And &
	(idw_Requestor.Describe(ls_ObjHolder + ".band") = as_Band or as_Band = "*") And &
	(idw_Requestor.Describe(ls_ObjHolder + ".visible") = "1" Or Not ab_VisibleOnly) Then
		li_Count ++
		as_ObjList[li_Count] = ls_ObjHolder
End if

Return li_Count
end function

public function integer of_getobjects (ref string as_objlist[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetObjects (FORMAT 1)
//
//	Access:    		Public
//
//	Arguments:
//   as_objlist[]:	A string array to hold objects (passed by reference)
//
//	Returns:  		Integer
//   					The number of objects in the array
//
//	Description:	The following function will parse the list of objects 
//						contained in the datawindow control associated with this service,
//						returning their names into a string array passed by reference, 
//						and returning the number of names in the array as the return value 
//						of the function.
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
//	Copyright $$HEX2$$d2242000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return of_GetObjects ( as_objlist, "*", "*", FALSE ) 

end function

public function integer of_getregistered (dwobject adwo_control, ref boolean ab_scale, ref integer ai_movex, ref integer ai_movey, ref integer ai_scalewidth, ref integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetRegistered
//
//	Access:  		public
//
//	Arguments:		
//	 adwo_control		The registered object.
//	 ab_scale			(by ref) The scale switch.
//  ai_movex			(by ref) The percentage to move the object along the x axis.
//  ai_movey			(by ref) The percentage to move the object along the y axis.
//  ai_scalewidth 	(by ref) The percentage to scale the object along the x axis.
//  ai_scaleheight	(by ref) The percentage to scale the object along the y axis.
//
//	Returns:  		integer
//	1 if it succeeds and?-1 if an error occurs.
//
//	Description:  	
//	Get the registered information for the passed in object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

string ls_control

// Initilize reference variables.
ab_scale = False
ai_movex = 0
ai_movey = 0
ai_scalewidth = 0
ai_scaleheight = 0

//Check parameters
If IsNull(adwo_control) Then
	Return -1
End If

ls_control = adwo_control.Name
Return of_GetRegistered(ls_control, ab_scale, &
	ai_movex, ai_movey, ai_scalewidth, ai_scaleheight)
end function

public function integer of_getregistered (ref string as_control[], ref boolean ab_scale[], ref integer ai_movex[], ref integer ai_movey[], ref integer ai_scalewidth[], ref integer ai_scaleheight[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetRegistered
//
//	Access:  		public
//
//	Arguments:		
//	 as_control[]		(by ref) All of the registered objects.
//	 ab_scale[]			(by ref) The scale switch.
//  ai_movex[]			(by ref) The percentage to move the object along the x axis.
//  ai_movey[]			(by ref) The percentage to move the object along the y axis.
//  ai_scalewidth[] 	(by ref) The percentage to scale the object along the x axis.
//  ai_scaleheight[]	(by ref) The percentage to scale the object along the y axis.
//
//	Returns:  		integer
//	1 if it succeeds and?-1 if an error occurs.
//
//	Description:  	
//	Get the registered information for the passed in object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

integer	li_regcount
integer	li_count
integer	li_cnt
boolean	lb_empty[]
integer	li_empty[]

// Initilize reference variables.
ab_scale = lb_empty
ai_movex = li_empty
ai_movey = li_empty
ai_scalewidth = li_empty
ai_scaleheight = li_empty

// Loop to find and populate all the entries.
li_count = UpperBound(inv_registered)
For li_cnt = 1 to li_count
	If Len(Trim(inv_registered[li_cnt].s_control)) > 0 Then

		li_regcount ++
		
		as_control[li_regcount] = inv_registered[li_cnt].s_control
		ab_scale[li_regcount] = inv_registered[li_cnt].b_scale
		ai_movex[li_regcount] = inv_registered[li_cnt].i_movex
		ai_movey[li_regcount] = inv_registered[li_cnt].i_movey
		ai_scalewidth[li_regcount] = inv_registered[li_cnt].i_scalewidth
		ai_scaleheight[li_regcount] = inv_registered[li_cnt].i_scaleheight
	End If
Next

Return li_regcount

end function

public function integer of_getregistered (string as_control, ref boolean ab_scale, ref integer ai_movex, ref integer ai_movey, ref integer ai_scalewidth, ref integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetRegistered
//
//	Access:  		public
//
//	Arguments:		
//	 as_control			The registered object.
//	 ab_scale			(by ref) The scale switch.
//  ai_movex			(by ref) The percentage to move the object along the x axis.
//  ai_movey			(by ref) The percentage to move the object along the y axis.
//  ai_scalewidth 	(by ref) The percentage to scale the object along the x axis.
//  ai_scaleheight	(by ref) The percentage to scale the object along the y axis.
//
//	Returns:  		integer
//	1 if it succeeds and?-1 if an error occurs.
//
//	Description:  	
//	Get the registered information for the passed in object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

integer	li_count
integer	li_cnt

// Initilize reference variables.
ab_scale = False
ai_movex = 0
ai_movey = 0
ai_scalewidth = 0
ai_scaleheight = 0

// Loop to find entry.
li_count = UpperBound(inv_registered)
For li_cnt = 1 to li_count
	If inv_registered[li_cnt].s_control = as_control Then
		// Set the reference variables and return.
		ab_scale = inv_registered[li_cnt].b_scale
		ai_movex = inv_registered[li_cnt].i_movex
		ai_movey = inv_registered[li_cnt].i_movey
		ai_scalewidth = inv_registered[li_cnt].i_scalewidth
		ai_scaleheight = inv_registered[li_cnt].i_scaleheight
		Return 1
	End If
Next

// Did not find the entry.
Return -1

end function

public function boolean of_isregistered (dwobject adwo_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsRegistered
//
//	Access:  		public
//
//	Arguments:		
//	adwo_control 	Object to test if registered.
//
//	Returns:  		boolean
//	 True if the object is registered.
//	 False if not.
//
//	Description:
//	 Determine if the passed in object is registered.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

string ls_control

//Check parameters
If IsNull(adwo_control) Then
	Return False
End If

ls_control = adwo_control.Name
Return of_IsRegistered(ls_control)
end function

public function boolean of_isregistered (string as_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsRegistered
//
//	Access:  		public
//
//	Arguments:
//	as_control		Object to test if registered.
//
//	Returns:  		boolean
//	 True if the object is registered.
//	 False if not.
//
//	Description:
//	 Determine if the passed in object is registered.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

integer 		li_count
integer		li_cnt

// Check arguments
If IsNull(as_control) Or Len(Trim(as_control))=0 Then 
	Return False
End If

// Loop to find entry.
li_count = UpperBound(inv_registered)
For li_cnt = 1 to li_count
	If inv_registered[li_cnt].s_control = as_control Then
		Return True
	End If
Next

Return False
end function

public function integer of_register (dwobject adwo_control, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:		
//	 adwo_control		The object being registered.
//  ai_movex			The percentage to move the object along the x axis.
//  ai_movey			The percentage to move the object along the y axis.
//  ai_scalewidth 	The percentage to scale the object along the x axis.
//  ai_scaleheight	The percentage to scale the object along the y axis.
//
//	Returns:  		integer
//						1 if it succeeds and?-1 if an error occurs.
//
//	Description:  	Register a control which needs to either be moved or resized
//						when the parent object is resized.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

string ls_objname

//Check parameters
If IsNull(adwo_control) Then
	Return -1
End If

ls_objname = adwo_control.Name
Return of_Register(ls_objname, ai_movex, ai_movey, ai_scalewidth, ai_scaleheight)
end function

public function integer of_register (dwobject adwo_control, string as_method);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:		
//	as_control		The object being registered.
//	as_method		The desired resize/move method.
//
//	Returns:  		integer
//						1 if it succeeds and?-1 if an error occurs.
//
//	Description:  	Register a control which needs to either be moved or resized
//						when the parent object is resized. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

string	ls_objname

//Check parameters
If IsNull(adwo_control) Then
	Return -1
End If

ls_objname = adwo_control.Name
Return of_Register(ls_objname, as_method)
end function

public function integer of_register (string as_control, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:		
//	 as_control			The object being registered.
//  ai_movex			The percentage to move the object along the x axis.
//  ai_movey			The percentage to move the object along the y axis.
//  ai_scalewidth 	The percentage to scale the object along the x axis.
//  ai_scaleheight	The percentage to scale the object along the y axis.
//
//	Returns:  		integer
//						1 if it succeeds and?-1 if an error occurs.
//
//	Description:  	Register a control which needs to either be moved or resized
//						when the parent object is resized.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

boolean 		lb_scale=False

Return of_Register (as_control, lb_scale, ai_movex, ai_movey, &
		ai_scalewidth, ai_scaleheight)

end function

public function integer of_register (string as_control, string as_method);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Register
//
//	Access:  		public
//
//	Arguments:		
//	as_control		The object being registered.
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
//	1 if it succeeds and?-1 if an error occurs.
//
//	Description:  	
//	Register a control which needs to either be moved or resized
//	when the parent object is resized. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

constant integer FULL_PERCENT= 100
integer			li_x, li_y, li_width, li_height
integer			li_upperbound
integer			li_cnt
integer			li_slot_available
integer			li_movex, li_movey
integer			li_scalewidth, li_scaleheight
boolean			lb_scale=False

//Check parameters
If IsNull(as_control) or Len(Trim(as_control))=0 or IsNull(as_method) Then
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
		Return -1
End Choose

Return of_Register(as_control, lb_scale, &
		li_movex, li_movey, li_scalewidth, li_scaleheight)
end function

public function integer of_resize (integer ai_newwidth, integer ai_newheight);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Resize
//
//	Access:  		protected
//
//	Arguments:		
//	ai_newwidth		The new width of the parent object.
//	ai_newheight	The new height of the parent object.
//
//	Returns:  		integer
//						1 if it succeeds and?-1 if an error occurs.
//
//	Description:  	Moves or resizes objects that were registered with the service.
//						Performs the actions that were requested via the
//						of_SetOrigSize() and of_Register functions.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
//Note: For the line control: the width and height variables are
//										used to hold EndX and EndY attributes.
//////////////////////////////////////////////////////////////////////////////

//Local variables
constant integer MINIMUM_SIZE =0

string			ls_control
string			ls_type
integer			li_upperbound
integer			li_rc
integer			li_cnt
integer			li_x, li_y, li_width, li_height
integer			li_deltawidth, li_deltaheight
real				lr_ratiowidth, lr_ratioheight
real				lr_move_deltax, lr_move_deltay
real				lr_resize_deltawidth, lr_resize_deltaheight
string			ls_singlemodifyexp, ls_complexmodifyexp
string			ls_modifyret
integer 			li_placewidth, li_placeheight

// Validate the reference.
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
	Return -1
End If

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
	ls_singlemodifyexp = ''
	
	If Len(inv_registered[li_cnt].s_control) > 0 Then
		li_rc = of_GetObjectInformation (inv_registered[li_cnt].s_control, ls_type, li_x, li_y, li_width, li_height)
		If li_rc < 0 then Return -1
		
		//Correct for any ii_rounding or moving/resizing of objects trough
		//any other means
		If abs(inv_registered[li_cnt].r_x - li_x) > ii_rounding Then
			inv_registered[li_cnt].r_x = li_x
		End If				
		If abs(inv_registered[li_cnt].r_y - li_y) > ii_rounding Then
			inv_registered[li_cnt].r_y = li_y
		End If		
		If abs(inv_registered[li_cnt].r_width - li_width) > ii_rounding And &
		   li_width > MINIMUM_SIZE  Then
			inv_registered[li_cnt].r_width = li_width
		End If							
		If abs(inv_registered[li_cnt].r_height - li_height) > ii_rounding And &
		   li_height > MINIMUM_SIZE  Then
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
			
			If Pos(ls_type, LINE) > 0 Then
				inv_registered[li_cnt].r_width = inv_registered[li_cnt].r_width + lr_move_deltax
				inv_registered[li_cnt].r_height = inv_registered[li_cnt].r_height + lr_move_deltay
				ls_singlemodifyexp = ls_singlemodifyexp + &
									inv_registered[li_cnt].s_control+'.X1 = '+string(Integer(inv_registered[li_cnt].r_x))+' '+&
									inv_registered[li_cnt].s_control+'.X2 = '+string(Integer(inv_registered[li_cnt].r_width))+' '+&
									inv_registered[li_cnt].s_control+'.Y1 = '+string(Integer(inv_registered[li_cnt].r_y))+' '+ &
									inv_registered[li_cnt].s_control+'.Y2 = '+string(Integer(inv_registered[li_cnt].r_height))+' '
			Else
				ls_singlemodifyexp = ls_singlemodifyexp + &
									inv_registered[li_cnt].s_control+'.X = '+string(Integer(inv_registered[li_cnt].r_x))+' '+&
									inv_registered[li_cnt].s_control+'.Y = '+string(Integer(inv_registered[li_cnt].r_y))+' '					
			End If
		End If /* Move */
		
		//If appropriate Resize the Width And Height of the control.
		If lr_resize_deltawidth <> 0 Or lr_resize_deltaheight <> 0 Then		
			//Save the 'exact' Width and Height attributes.
			inv_registered[li_cnt].r_width = inv_registered[li_cnt].r_width + lr_resize_deltawidth	
			inv_registered[li_cnt].r_height = inv_registered[li_cnt].r_height + lr_resize_deltaheight		

			// Determine the placement variables.
			If inv_registered[li_cnt].r_width > MINIMUM_SIZE  Then
				li_placewidth = inv_registered[li_cnt].r_width
			Else
				li_placewidth = MINIMUM_SIZE 
			End If
			If inv_registered[li_cnt].r_height > MINIMUM_SIZE  Then
				li_placeheight = inv_registered[li_cnt].r_height
			Else
				li_placeheight = MINIMUM_SIZE 
			End If							
			
			If Pos(ls_type, LINE) > 0 Then
				ls_singlemodifyexp = ls_singlemodifyexp + &
									inv_registered[li_cnt].s_control+'.X2 = '+string(Integer(li_placewidth))+' '+ &
									inv_registered[li_cnt].s_control+'.Y2 = '+string(Integer(li_placeheight))+' '				
			Else
				ls_singlemodifyexp = ls_singlemodifyexp + &
									inv_registered[li_cnt].s_control+'.Width = '+string(Integer(li_placewidth))+' '+ &
									inv_registered[li_cnt].s_control+'.Height = '+string(Integer(li_placeheight))+' '				
			End If			
		End If /* Resize */

		// Batch all into one Large Modify expression.
		If Len(ls_singlemodifyexp) > 0 Then
			ls_complexmodifyexp += '   ' + ls_singlemodifyexp
		End If
		
	End If /* If IsValid(inv_registered[li_cnt].wo_control) Then */
Next /* For li_cnt = 1 to li_upperbound */

// Execute the one Modify expression.
If Len(ls_complexmodifyexp) > 0 Then
	ls_modifyret = idw_requestor.Modify(ls_complexmodifyexp)
	If IsNull(ls_modifyret) or Len(ls_modifyret) > 0 Then	
		Return -1
	End If				
End If

Return 1

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
//						1 if it succeeds and?-1 if an error occurs.
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
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

// Validate the reference.
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
	Return -1
End If

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

public function integer of_setorigsize (integer ai_width, integer ai_height);//////////////////////////////////////////////////////////////////////////////
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
//						1 if it succeeds and?-1 if an error occurs.
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
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

// Validate the reference.
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
	Return -1
End If

//Check parameters
If IsNull(ai_width) or IsNull(ai_height) Then
	Return -1
End If

//Set the current width and height
il_parentprevwidth = ai_width
il_parentprevheight = ai_height

Return 1

end function

public function integer of_unregister (dwobject adwo_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_UnRegister	
//
//	Access:  		public
//
//	Arguments:		
//	as_control		The control to unregister.
//
//	Returns:  		integer
//						1 if it succeeds and?-1 if an error occurs.
//
//	Description:  	Unregister a control that was previously registered.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

string ls_objname

// Validate the reference.
If IsNull(adwo_control) Then
	Return -1
End If

ls_objname = adwo_control.Name
Return of_Unregister(ls_objname)
end function

public function integer of_unregister (string as_control);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_UnRegister	
//
//	Access:  		public
//
//	Arguments:		
//	as_control		The control to unregister.
//
//	Returns:  		integer
//						1 if it succeeds and?-1 if an error occurs.
//
//	Description:  	Unregister a control that was previously registered.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////

integer			li_upperbound
integer			li_cnt
integer			li_registered_slot

// Validate the reference.
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
	Return -1
End If

//Check parameters
If IsNull(as_control) or Len(Trim(as_control))=0 Then
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
	If inv_registered[li_cnt].s_control = as_control Then
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
inv_registered[li_registered_slot].s_control = EMPTY
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

public function integer of_autoresizeregister ();if not isvalid(idw_Requestor) then return -1

long ll_objcnt, ll_linecnt, i, j, ll_pos
string ls_objects[], ls_linebuf[]
string ls_tag, ls_objname, ls_line
string ls_name, ls_value, ls_resizeopt[]

ll_objcnt = pf_f_parsetoarray(idw_Requestor.describe("Datawindow.Objects"), "~t", ls_objects[])
for i = 1 to ll_objcnt
	ls_objname = ls_objects[i]
	if idw_Requestor.describe(ls_objname + ".visible") = '1' or isnumber(idw_Requestor.describe(ls_objname + ".x")) then
		ls_tag = idw_Requestor.describe(ls_objname + ".tag")
		ll_linecnt = pf_f_parsetoarray(ls_tag, ';', ls_linebuf[])
		for j = 1 to ll_linecnt
			ls_line = trim(ls_linebuf[j])
			if ls_line = '' then continue
			ll_pos = pos(ls_line, '=')
			if ll_pos = 0 then continue
			
			ls_name = trim(left(ls_line, ll_pos - 1))
			ls_value = trim(mid(ls_line, ll_pos + 1))
			
			if lower(ls_name) = 'resize' then
				if pf_f_parsetoarray(ls_value, ',', ls_resizeopt[]) <> 4 then
					messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'DWObject$$HEX10$$58c72000acb9acc074c788c9200024c115c840c7$$ENDHEX$$, [resize=0,0,0,0] $$HEX5$$15d6dcd085c7c8b2e4b2$$ENDHEX$$.')
					return -1
				end if
				
				this.of_register(ls_objname, integer(ls_resizeopt[1]), integer(ls_resizeopt[2]), integer(ls_resizeopt[3]), integer(ls_resizeopt[4]))
			end if
		next
	end if
next

return 1

end function

on pf_n_dwresize.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pf_n_dwresize.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  n_cst_resize
//
//	Description:
//	DW Resize service.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version - C. Quant
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

end event

