HA$PBExportHeader$pf_u_mdi_statusbar.sru
forward
global type pf_u_mdi_statusbar from pf_u_userobject
end type
type dw_msg from pf_u_datawindow within pf_u_mdi_statusbar
end type
end forward

global type pf_u_mdi_statusbar from pf_u_userobject
integer width = 4777
integer height = 92
long backcolor = 79741120
event type long pfe_timer ( )
event pfe_setwindowname ( )
event pfe_setmessage ( )
dw_msg dw_msg
end type
global pf_u_mdi_statusbar pf_u_mdi_statusbar

type prototypes
FUNCTION long ShellExecuteW(ulong hWnd, string Operation, string lpFile, string lpParameters, string lpDirectory, long nShowCmd) LIBRARY "shell32.dll"

end prototypes

type variables
private:
	int				iiv_Timer = 0
	//n_Timing		inv_timer
	
	datetime		ldtm_local
	
	//n_datetime	inv_datetime
	datetime		idtm_starttime
	long			il_startcpu

end variables

forward prototypes
public subroutine of_setmessage (string as_message)
public subroutine of_setwindowname (string as_windowname)
public subroutine of_setclock (string as_clock)
public function integer of_printwindow ()
public subroutine of_changecolor (string as_color)
public subroutine of_showhelp ()
public subroutine of_setstarttime ()
public function integer of_setresize (boolean ab_switch)
public function string of_getclassname ()
end prototypes

event type long pfe_timer();datetime	ldtm_now
long		ll_nowcpu

ll_nowcpu = cpu()
//ldtm_now = inv_datetime.of_relativedatetime(idtm_starttime, (ll_nowcpu - il_startcpu) / 1000)
this.of_setclock(string(ldtm_now, 'YYYY-MM-DD hh:mm:ss'))
return 0

end event

event pfe_setwindowname();pf_n_hashtable lnvo_param
string ls_window_id

//iw_parent.dynamic of_getparameter(lnvo_param)
lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

ls_window_id = lnvo_param.of_getstring('window_id')
this.of_setwindowname(ls_window_id)

//lnvo_param.of_put("ReturnValue", 0)
gnv_session.of_put("ReturnValue", 0)

return

end event

event pfe_setmessage();pf_n_hashtable lnvo_param
string ls_message

//iw_parent.dynamic of_getparameter(lnvo_param)
lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

ls_message = lnvo_param.of_getstring('message')
this.of_setmessage(ls_message)

//lnvo_param.of_put("ReturnValue", 0)
gnv_session.of_put("ReturnValue", 0)

return

end event

public subroutine of_setmessage (string as_message);dw_msg.setitem(1, 'msg_txt', as_message)
end subroutine

public subroutine of_setwindowname (string as_windowname);dw_msg.setitem(1, 'pgm_id', as_windowname)

end subroutine

public subroutine of_setclock (string as_clock);dw_msg.setitem(1, 'st_clock', as_clock)

end subroutine

public function integer of_printwindow ();Window	lw_toPrint
pf_n_screencapture ln_capture
Blob		lb_WinImg
String		ls_filename
Long		ll_rc

//lw_toPrint = iw_Parent.GetActiveSheet()
IF Not IsValid(lw_toPrint) THEN
	MessageBox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX24$$78c7c4c1200060d5200018c2200088c794b2200008c7c4b3b0c600ac200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$.')
	Return -1
END IF

// $$HEX5$$54d674ba2000a1ced0cc$$ENDHEX$$
lb_WinImg = ln_capture.of_WindowCapture(lw_toPrint, False)
IF Len(lb_WinImg) = 0 THEN
	MessageBox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX25$$08c7c4b3b0c67cb92000a1ced0cce4c228d35cb8200054d674ba44c7200078c7c4c160d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$.')
	Return -2
END IF

// BMP $$HEX5$$0cd37cc7200000c8a5c7$$ENDHEX$$
ls_filename = ln_capture.of_getTempPath() + "\" + lw_toPrint.ClassName() + "_" + String(today(), 'yyyymmddhhmmss') + ".bmp"

Sleep(0.2)

IF ln_capture.of_writeBlob(ls_filename, lb_WinImg) < 0 THEN
	MessageBox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX20$$08c7c4b3b0c62000a1ced0cc0cd37cc744c7200000c8a5c760d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$.')
	Return -3
END IF

//// BMP $$HEX5$$0cd37cc720009ccd25b8$$ENDHEX$$
//Datastore	lds_print
//n_Vector		lvc_parm
//
//lvc_parm = create n_vector
//lds_print = create datastore
//lds_print.dataobject = 'd_printscreen'
//lds_print.insertrow(0)
//lds_print.modify("print_empnm.text='" + gnv_user.is_emp_name + "'")
//lds_print.modify("print_title.text='" + lw_toPrint.Title + "'")
//lds_print.modify("print_dtm.text='" + String(today(), "yyyy/mm/dd hh:mm:ss") + "'")
//
////p_temp.PictureName = ls_filename
//
//lds_print.setitem(1, 'scrnimg', ls_filename)
//
////lds_print.modify('scrnimg.Width=' + String(p_temp.Width))
////lds_print.modify('scrnimg.Height=' + String(p_temp.Height))
////lds_print.modify('detail.Height=' + String(p_temp.Height + Long(lds_print.describe("scrnimg.Y"))))
//
//lvc_parm.setProperty("dwtype", "datastore")
//lvc_parm.setProperty("datastore", lds_print)
//lvc_parm.setProperty("orientation", "0")
//
//openWithparm(w_print_preview, lvc_parm)
//Destroy lds_print
//Destroy lvc_parm
//Return 0

//ll_rc = ShellExecuteW(handle(iw_Parent), "open", ls_filename, "" , "", 1) 
Return ll_rc

end function

public subroutine of_changecolor (string as_color);//long		ll_RGB
//f_GetRGB(as_color, ll_RGB)
//st_Message.TextColor = ll_RGB

end subroutine

public subroutine of_showhelp ();//window	lw_active
//
//lw_active = iw_Parent.GetActiveSheet()
//if not isvalid(lw_active) then return
//
//openwithparm(w_popup_help, lw_active.classname(), iw_parent)

end subroutine

public subroutine of_setstarttime ();//idtm_starttime = f_get_localtime('gniscn/n_dw')
il_startcpu = cpu()

end subroutine

public function integer of_setresize (boolean ab_switch);integer	li_rc

// Check arguments
if IsNull (ab_switch) then
	return -1
end if

if ab_Switch then
	if not IsValid (inv_resize) then
		inv_resize = create pf_n_resize
		inv_resize.of_SetOrigSize(4375, 104)
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

public function string of_getclassname ();return 'pf_u_mdi_statusbar'

end function

on pf_u_mdi_statusbar.create
int iCurrent
call super::create
this.dw_msg=create dw_msg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_msg
end on

on pf_u_mdi_statusbar.destroy
call super::destroy
destroy(this.dw_msg)
end on

event destructor;//IF IsValid(inv_timer) THEN
//	inv_timer.stop()
//	Destroy inv_timer
//END IF

end event

event resize;call super::resize;// Set Resize
Long	ll_x, ll_x2, ll_wkWidth

dw_msg.x = 0
dw_msg.y = 0
dw_msg.Width = newwidth
dw_msg.Height = newheight

ll_wkwidth = newwidth
//dw_msg.modify("p_background.width=" + string(ll_wkwidth))

ll_x = ll_wkWidth - long(dw_msg.describe("pgm_id.width")) - pixelstounits(10, xpixelstounits!)
dw_msg.modify("pgm_id.x=" + string(ll_x))

ll_x = ll_x - long(dw_msg.describe("p_pgm_icon.width")) - PixelsToUnits(10, XPixelsToUnits!)
dw_msg.modify("p_pgm_icon.x=" + string(ll_x))

//ll_x2 = PixelsToUnits(10, XPixelsToUnits!) 
//dw_msg.modify("p_msg_icon.x=" + string(ll_x2))

ll_x2 = ll_x2 + long(dw_msg.describe("p_msg_icon.width"))  + PixelsToUnits(10, XPixelsToUnits!)
dw_msg.modify("msg_txt.x=" + string(ll_x2))
dw_msg.modify("msg_txt.width=" + String(ll_x - ll_x2))

end event

event pfe_postopen;call super::pfe_postopen;dw_msg.modify("p_background.y=-4")
dw_msg.insertrow(0)

// $$HEX2$$c0c9edc5$$ENDHEX$$(DB) $$HEX5$$dcc204ac200024c115c8$$ENDHEX$$
//this.of_setstarttime()

// $$HEX6$$c0d074c738ba200024c115c8$$ENDHEX$$
//inv_timer = Create n_Timing
//inv_timer.event ue_setparent(This, 'ue_timer')
//inv_timer.Start(1)

end event

type p_background from pf_u_userobject`p_background within pf_u_mdi_statusbar
end type

type dw_msg from pf_u_datawindow within pf_u_mdi_statusbar
integer width = 4777
integer height = 96
integer taborder = 10
string title = "none"
string dataobject = "pf_d_mdi_statusbar"
boolean applydesign = false
boolean sorting = false
boolean useborder = false
boolean scaletoright = true
end type

event clicked;String		ls_excel
//Window	lw_toExcel

CHOOSE CASE dwo.name
	CASE 'p_excel'
		IF RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\excel.exe", "", RegString!, ls_excel) = 1 THEN
			Run(ls_excel)
		ELSE
			Run("excel.exe")
		END IF
		
//		lw_toExcel = iw_Parent.GetActiveSheet()
//		IF Not IsValid(lw_toExcel) THEN
//			MessageBox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX26$$d1c540c100c8a5c7200060d5200018c2200088c794b2200008c7c4b3b0c600ac200074c8acc758d5c0c920004ac5b5c2c8b2e4b2$$ENDHEX$$.')
//			Return -1
//		END IF
//		
//		lw_toExcel.dynamic event ue_excel()
		
	CASE 'p_calc'
		Run("calc.exe")
		
	CASE 'p_print'
		Parent.of_PrintWindow()
		
	CASE 'p_help'
		Parent.of_ShowHelp()
END CHOOSE

Return 0

end event

event resize;call super::resize;//// Set Resize
//Long	ll_x, ll_x2, ll_wkWidth
//
//ll_wkwidth = newwidth
//dw_msg.modify("p_background.width=" + string(ll_wkwidth))
//
//ll_x = ll_wkWidth - long(dw_msg.describe("pgm_id.width")) - pixelstounits(10, xpixelstounits!)
//dw_msg.modify("pgm_id.x=" + string(ll_x))
//
//ll_x = ll_x - long(dw_msg.describe("p_pgm_icon.width")) - PixelsToUnits(10, XPixelsToUnits!)
//dw_msg.modify("p_pgm_icon.x=" + string(ll_x))
//
////ll_x2 = PixelsToUnits(10, XPixelsToUnits!) 
////dw_msg.modify("p_msg_icon.x=" + string(ll_x2))
//
//ll_x2 = ll_x2 + long(dw_msg.describe("p_msg_icon.width"))  + PixelsToUnits(10, XPixelsToUnits!)
//dw_msg.modify("msg_txt.x=" + string(ll_x2))
//dw_msg.modify("msg_txt.width=" + String(ll_x - ll_x2))

end event

