HA$PBExportHeader$pf_w_example_screencapture.srw
forward
global type pf_w_example_screencapture from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_screencapture
end type
type cb_1 from commandbutton within pf_w_example_screencapture
end type
type cb_2 from commandbutton within pf_w_example_screencapture
end type
type cb_3 from commandbutton within pf_w_example_screencapture
end type
type cb_4 from commandbutton within pf_w_example_screencapture
end type
type cb_5 from commandbutton within pf_w_example_screencapture
end type
type st_1 from statictext within pf_w_example_screencapture
end type
type sle_folder from singlelineedit within pf_w_example_screencapture
end type
type cb_6 from commandbutton within pf_w_example_screencapture
end type
type p_1 from picture within pf_w_example_screencapture
end type
type dw_1 from pf_u_datawindow within pf_w_example_screencapture
end type
type ddlb_method from pf_u_dropdownlistbox within pf_w_example_screencapture
end type
type gb_1 from pf_u_groupbox within pf_w_example_screencapture
end type
end forward

global type pf_w_example_screencapture from pf_w_sheet
string title = "$$HEX12$$54d674ba2000a0ced0cc2000d8c00cd5200008c7c4b3b0c6$$ENDHEX$$"
cb_close cb_close
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
st_1 st_1
sle_folder sle_folder
cb_6 cb_6
p_1 p_1
dw_1 dw_1
ddlb_method ddlb_method
gb_1 gb_1
end type
global pf_w_example_screencapture pf_w_example_screencapture

type variables
pf_n_screencapture inv_screen

end variables

on pf_w_example_screencapture.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.st_1=create st_1
this.sle_folder=create sle_folder
this.cb_6=create cb_6
this.p_1=create p_1
this.dw_1=create dw_1
this.ddlb_method=create ddlb_method
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_4
this.Control[iCurrent+6]=this.cb_5
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.sle_folder
this.Control[iCurrent+9]=this.cb_6
this.Control[iCurrent+10]=this.p_1
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.ddlb_method
this.Control[iCurrent+13]=this.gb_1
end on

on pf_w_example_screencapture.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.st_1)
destroy(this.sle_folder)
destroy(this.cb_6)
destroy(this.p_1)
destroy(this.dw_1)
destroy(this.ddlb_method)
destroy(this.gb_1)
end on

event pfe_postopen;call super::pfe_postopen;ddlb_method.selectitem(1)
sle_folder.text = getcurrentdirectory()

dw_1.settransobject(sqlca)
dw_1.retrieve(gnv_session.is_sys_id)

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_screencapture
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_screencapture
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_screencapture
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_screencapture
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_screencapture
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_screencapture
end type

type cb_close from pf_u_commandbutton within pf_w_example_screencapture
integer x = 4279
integer y = 32
integer width = 274
integer height = 96
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = hangeul!
string text = "$$HEX2$$ebb230ae$$ENDHEX$$"
string powertiptext = "$$HEX11$$74d5f9b2200054d674ba44c72000ebb2b5c2c8b2e4b2$$ENDHEX$$."
boolean applydesign = false
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)
end event

type cb_1 from commandbutton within pf_w_example_screencapture
integer x = 526
integer y = 380
integer width = 590
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "Control Capture"
end type

event clicked;boolean lb_clipboard
blob lblb_bitmap

choose case ddlb_method.of_getselectedindex()
	case 1
		lb_clipboard = true
	case 2
		lb_clipboard = false
end choose

lblb_bitmap = inv_screen.of_controlcapture(sle_folder, lb_clipboard)
if lb_clipboard = false then
	inv_screen.of_writeblob(sle_folder.text + '\' + sle_folder.classname() + '.bmp', lblb_bitmap)
end if

end event

type cb_2 from commandbutton within pf_w_example_screencapture
integer x = 526
integer y = 504
integer width = 599
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "Datawindow Capture"
end type

event clicked;boolean lb_clipboard
blob lblb_bitmap

choose case ddlb_method.of_getselectedindex()
	case 1
		lb_clipboard = true
	case 2
		lb_clipboard = false
end choose

lblb_bitmap = inv_screen.of_dw_today_capture(dw_1, lb_clipboard)
if lb_clipboard = false then
	inv_screen.of_writeblob(sle_folder.text + '\' + dw_1.classname() + '.bmp', lblb_bitmap)
end if

end event

type cb_3 from commandbutton within pf_w_example_screencapture
integer x = 526
integer y = 628
integer width = 599
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "Window Capture"
end type

event clicked;boolean lb_clipboard
blob lblb_bitmap

choose case ddlb_method.of_getselectedindex()
	case 1
		lb_clipboard = true
	case 2
		lb_clipboard = false
end choose

lblb_bitmap = inv_screen.of_windowcapture(parent, lb_clipboard)
if lb_clipboard = false then
	inv_screen.of_writeblob(sle_folder.text + '\' + parent.classname() + '.bmp', lblb_bitmap)
end if

end event

type cb_4 from commandbutton within pf_w_example_screencapture
integer x = 526
integer y = 752
integer width = 599
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "OS Capture"
end type

event clicked;boolean lb_clipboard
blob lblb_bitmap

choose case ddlb_method.of_getselectedindex()
	case 1
		lb_clipboard = true
	case 2
		lb_clipboard = false
end choose

lblb_bitmap = inv_screen.of_screencapture(lb_clipboard)
if lb_clipboard = false then
	inv_screen.of_writeblob(sle_folder.text + '\fullscreen.bmp', lblb_bitmap)
end if

end event

type cb_5 from commandbutton within pf_w_example_screencapture
integer x = 526
integer y = 876
integer width = 599
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "Clipboard to Bitmap"
end type

event clicked;string ls_filename

ls_filename = gnv_extfunc.of_getsystemtemppath() + gnv_extfunc.of_getuniqpicturename(this)

if gnv_extfunc.pf_clipboardtobitmap(ls_filename) > 0 then
	p_1.picturename = ''
	p_1.picturename = ls_filename
end if

end event

type st_1 from statictext within pf_w_example_screencapture
integer x = 1289
integer y = 228
integer width = 489
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22172242
string text = "Current Directory : "
boolean focusrectangle = false
end type

type sle_folder from singlelineedit within pf_w_example_screencapture
integer x = 1774
integer y = 204
integer width = 2162
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "c:\"
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_6 from commandbutton within pf_w_example_screencapture
integer x = 3945
integer y = 200
integer width = 123
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "..."
end type

event clicked;string ls_folder

ls_folder = sle_folder.text
if GetFolder ('Select folder you want to save the image file', ls_folder) > 0 then
	changedirectory(ls_folder)
	sle_folder.text = ls_folder
end if

end event

type p_1 from picture within pf_w_example_screencapture
integer x = 1298
integer y = 356
integer width = 2747
integer height = 916
boolean bringtotop = true
boolean focusrectangle = false
end type

type dw_1 from pf_u_datawindow within pf_w_example_screencapture
integer x = 1298
integer y = 1308
integer width = 2747
integer height = 936
integer taborder = 80
boolean bringtotop = true
string dataobject = "pf_d_example_screencapture_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type ddlb_method from pf_u_dropdownlistbox within pf_w_example_screencapture
integer x = 526
integer y = 256
integer width = 590
integer height = 376
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = hangeul!
long textcolor = 33554432
string item[] = {"Copy image to Clipboard","Save image to File"}
end type

type gb_1 from pf_u_groupbox within pf_w_example_screencapture
integer x = 466
integer y = 144
integer width = 704
integer height = 2100
integer taborder = 20
string text = " Capture Type "
end type

