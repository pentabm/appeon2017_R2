HA$PBExportHeader$pf_u_splitbar_horizontal.sru
$PBExportComments$$$HEX7$$0cd3ccc604d508b884c7a9c62000$$ENDHEX$$Horizontal Splitbar $$HEX7$$e8ceb8d264b8200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_u_splitbar_horizontal from pf_u_statictext
end type
end forward

global type pf_u_splitbar_horizontal from pf_u_statictext
integer width = 901
integer height = 20
integer textsize = -10
fontcharset fontcharset = ansi!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "..\img\controls\u_splitbar_horizontal\splith.cur"
long backcolor = 255
boolean scaletoright = true
event mousedown pbm_lbuttondown
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
end type
global pf_u_splitbar_horizontal pf_u_splitbar_horizontal

type prototypes
Function ulong GetSysColor ( &
	integer nindex &
	) Library "user32.dll"

end prototypes

type variables
private:
	Window iw_parent
	String is_myname
	PowerObject ipo_parent
	Dragobject idrg_top[]
	Dragobject idrg_bottom[]
	String is_company
	String is_appname
	boolean ib_OnceOpened = false
	
public:
	Boolean ib_livesizing
	Integer ii_minrange = 100
	Integer ii_maxrange = 100
	string TopDragObject
	string BottomDragObject

end variables

forward prototypes
public function unsignedlong of_get_syscolor (integer ai_index)
public subroutine of_set_livesizing (boolean ab_flag)
public function window of_get_parentwindow ()
public function string of_get_objectname ()
public subroutine of_set_topobject (ref dragobject adrg_top)
public subroutine of_set_bottomobject (ref dragobject adrg_bottom)
public subroutine of_get_location ()
public subroutine of_set_location ()
public subroutine of_arrange_objects ()
public subroutine of_set_minsize (integer ai_minrange, integer ai_maxrange)
public function string of_getclassname ()
public function integer of_setobjectsbyname (string as_direction, string as_objectnames)
end prototypes

event mousedown;// make sure object stays on top
this.SetPosition(ToTop!)

// set color to button shadow
If Not ib_livesizing Then
	this.BackColor = of_get_syscolor(16)
End If

end event

event mousemove;Integer li_pointer, li_minrange, li_maxrange
DragObject ldrg_parent

// if left button pressed, move object
If KeyDown(keyLeftButton!) Then
	// get location of mouse pointer
	If ipo_parent.TypeOf() = Window! Then
		li_pointer = iw_parent.PointerY()
	Else
		ldrg_parent = ipo_parent
		li_pointer = ldrg_parent.PointerY()
	End If
	// calculate the valid range of movement
	li_minrange = idrg_top[1].y + ii_minrange
	li_maxrange = (idrg_bottom[1].y + idrg_bottom[1].height) - ii_maxrange
	// move the splitbar if within the range
	If li_pointer > li_minrange And li_pointer < li_maxrange Then
		// move splitbar to mouse location
		this.Y = li_pointer
		// resize objects if using livesizing
		If ib_livesizing Then
			of_arrange_objects()
		End If
	End If
End If

end event

event mouseup;// arrange objects
of_arrange_objects()

// restore color to match background
If Not ib_livesizing Then
	this.BackColor = iw_parent.BackColor
End If

end event

public function unsignedlong of_get_syscolor (integer ai_index);// These are the argument values
//
//        Object          Value         Object          Value
// --------------------- ------- --------------------- -------
// Scroll Bar Background     0
// Desktop Background        1   Inactive Border          11
// Active Title Bar          2   App Work Space           12
// Inactive Title Bar        3   Highlight                13
// Menu                      4   Highlight Text           14
// Window                    5   Button Face              15
// Window Frame              6   Button Shadow            16
// Menu Text                 7   Gray Text                17
// Window Text               8   Button Text              18
// Title Bar Text            9   Inactive Title Bar Text  19
// Active Border            10   Button Highlight         20

// ToolTip Text             23   ToolTip Background       24

Return GetSysColor(ai_index)

end function

public subroutine of_set_livesizing (boolean ab_flag);// set livesizing flag
ib_livesizing = ab_flag

end subroutine

public function window of_get_parentwindow ();PowerObject	lpo_parent
Window lw_window

// loop thru parents until a window is found
lpo_parent = this.GetParent()
Do While lpo_parent.TypeOf() <> Window! and IsValid (lpo_parent)
	lpo_parent = lpo_parent.GetParent()
Loop

// set return to the window or null if not found
If IsValid (lpo_parent) Then
	lw_window = lpo_parent
Else
	SetNull(lw_window)
End If

Return lw_window

end function

public function string of_get_objectname ();PowerObject	lpo_parent
String ls_object

// loop thru parents building object name
lpo_parent = this.GetParent()
ls_object = this.ClassName()
Do While lpo_parent.TypeOf() <> Window! and IsValid (lpo_parent)
	ls_object = lpo_parent.ClassName() + "." + ls_object
	lpo_parent = lpo_parent.GetParent()
Loop

Return ls_object

end function

public subroutine of_set_topobject (ref dragobject adrg_top);Integer li_max

li_max = UpperBound(idrg_top) + 1

// set drag top object
idrg_top[li_max] = adrg_top

// arrange objects
of_arrange_objects()

end subroutine

public subroutine of_set_bottomobject (ref dragobject adrg_bottom);Integer li_max

li_max = UpperBound(idrg_bottom) + 1

// set bottom drag object
idrg_bottom[li_max] = adrg_bottom

// arrange objects
of_arrange_objects()

end subroutine

public subroutine of_get_location ();// this function loads current location from the registry

String ls_regkey, ls_value
Long ll_position

ls_regkey  = "HKEY_CURRENT_USER\Software\" + is_company
ls_regkey += "\" + is_appname + "\SplitBars"

// set value in registry
RegistryGet(ls_regkey, is_myname, RegString!, ls_value)

// move object to prior location
ll_position = Long(ls_value)
If ll_position > 0 Then
	this.Y = ll_position
	of_arrange_objects()
End If

end subroutine

public subroutine of_set_location ();// this function saves current location in the registry

String ls_regkey

ls_regkey  = "HKEY_CURRENT_USER\Software\" + is_company
ls_regkey += "\" + is_appname + "\SplitBars"

// set value in registry
RegistrySet(ls_regkey, is_myname, String(this.y))

end subroutine

public subroutine of_arrange_objects ();// resize and arrange dragobjects

Integer li_cnt, li_max, li_maxsize

If UpperBound(idrg_top) = 0 Then Return
If UpperBound(idrg_bottom) = 0 Then Return

iw_parent.SetRedraw(False)

// resize the top dragobjects
li_max = UpperBound(idrg_top)
FOR li_cnt = 1 TO li_max
	idrg_top[li_cnt].height = this.y - idrg_top[li_cnt].y
NEXT

// resize the bottom dragobjects
li_max = UpperBound(idrg_bottom)
FOR li_cnt = 1 TO li_max
	li_maxsize = (idrg_bottom[li_cnt].y + idrg_bottom[li_cnt].height)
	idrg_bottom[li_cnt].y = this.y + this.height
	idrg_bottom[li_cnt].height = li_maxsize - idrg_bottom[li_cnt].y
NEXT

iw_parent.SetRedraw(True)

end subroutine

public subroutine of_set_minsize (integer ai_minrange, integer ai_maxrange);// set minimum size
ii_minrange = ai_minrange
ii_maxrange = ai_maxrange

end subroutine

public function string of_getclassname ();return 'pf_u_splitbar_horizontal'

end function

public function integer of_setobjectsbyname (string as_direction, string as_objectnames);// TOP, BOTTOM $$HEX21$$24c60cbe1dc8b8d27cb9200024c60cbe1dc8b8d2200074c784b93cc75cb82000f1b45db869d5c8b2e4b2$$ENDHEX$$
// as_direction: top = $$HEX7$$04c7bdca200024c60cbe1dc8b8d2$$ENDHEX$$, bottom=$$HEX11$$44c598b7bdca200024c60cbe1dc8b8d22000f1b45db8$$ENDHEX$$
// as_objectnames = $$HEX10$$f1b45db860d5200024c60cbe1dc8b8d2200085ba$$ENDHEX$$($$HEX8$$ecc5ecb71cac78c72000bdacb0c62000$$ENDHEX$$; $$HEX4$$5cb820006cad84bd$$ENDHEX$$)
// $$HEX3$$acb934d112ac$$ENDHEX$$: 1=$$HEX2$$31c1f5ac$$ENDHEX$$, -1=$$HEX2$$e4c228d3$$ENDHEX$$

dragobject lwo_control
string ls_object[]
integer li_objcnt, i

if not isvalid(iw_parent) then return 0
if isnull(as_objectnames) then return 0
if as_objectnames = '' then return 0

li_objcnt = pf_f_parsetoarray(as_objectnames, ';', ls_object)
for i = 1 to li_objcnt
	ls_object[i] = trim(ls_object[i])
	if ls_object[i] = '' then continue

	lwo_control = iw_parent.dynamic of_getwindowobjectbyname(ls_object[i])
	if not isvalid(lwo_control) then
		messagebox('[' + this.classname() + '] $$HEX2$$4cc5bcb9$$ENDHEX$$', '[' + ls_object[i] + '] $$HEX16$$24c60cbe1dc8b8d285ba44c720003ecc44c7200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$')
		return -1
	end if
	
	choose case as_direction
		case 'top'
			this.of_set_topobject(lwo_control)
		case 'bottom'
			this.of_set_bottomobject(lwo_control)
	end choose
next

return 1

end function

event constructor;if appeongetclienttype() <> 'PB' then
	if ib_OnceOpened = true then return
end if

Application la_app

// set identification variables
iw_parent = this.of_get_parentwindow()
ipo_parent = this.GetParent()
is_myname = iw_parent.ClassName() + "." + this.of_get_objectname()

// default appname/company
la_app = GetApplication()
is_appname = la_app.AppName
is_company = "My Company"

// set color to match background
this.BackColor = iw_parent.BackColor

// auto register predefined object name
this.post of_setobjectsbyname('top', TopDragObject)
this.post of_setobjectsbyname('bottom', BottomDragObject)

if appeongetclienttype() <> 'PB' then
	ib_OnceOpened = true
end if

end event

on pf_u_splitbar_horizontal.create
call super::create
end on

on pf_u_splitbar_horizontal.destroy
call super::destroy
end on

