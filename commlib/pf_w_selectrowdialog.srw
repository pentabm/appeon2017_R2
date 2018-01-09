HA$PBExportHeader$pf_w_selectrowdialog.srw
$PBExportComments$pf_f_selectrowdialog $$HEX16$$a9c620001dd3c5c508c7c4b3b0c6200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_selectrowdialog from window
end type
type dw_list from pf_u_datawindow within pf_w_selectrowdialog
end type
type cb_cancel from pf_u_commandbutton within pf_w_selectrowdialog
end type
type cb_confirm from pf_u_commandbutton within pf_w_selectrowdialog
end type
type st_title from pf_u_statictext within pf_w_selectrowdialog
end type
type st_comment from statictext within pf_w_selectrowdialog
end type
end forward

global type pf_w_selectrowdialog from window
integer width = 1413
integer height = 1468
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
string icon = "AppIcon!"
boolean toolbarvisible = false
boolean center = true
dw_list dw_list
cb_cancel cb_cancel
cb_confirm cb_confirm
st_title st_title
st_comment st_comment
end type
global pf_w_selectrowdialog pf_w_selectrowdialog

on pf_w_selectrowdialog.create
this.dw_list=create dw_list
this.cb_cancel=create cb_cancel
this.cb_confirm=create cb_confirm
this.st_title=create st_title
this.st_comment=create st_comment
this.Control[]={this.dw_list,&
this.cb_cancel,&
this.cb_confirm,&
this.st_title,&
this.st_comment}
end on

on pf_w_selectrowdialog.destroy
destroy(this.dw_list)
destroy(this.cb_cancel)
destroy(this.cb_confirm)
destroy(this.st_title)
destroy(this.st_comment)
end on

event open;// Dialog $$HEX15$$08c7c4b3b0c67cb9200024c608d574d52000acc0a9c690c7d0c58cac2000$$ENDHEX$$DW $$HEX9$$89d544c7200020c1ddd020001bbc94b2e4b2$$ENDHEX$$

if not gnv_session.of_containskey(this.classname() + ".datastore_ref") then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(' + this.classname() + ')', '$$HEX13$$98c7bbba1cb4200008c7c4b3b0c6200038d69ccd85c7c8b2e4b2$$ENDHEX$$')
	return
end if

string ls_title, ls_comment
datastore lds_ref

ls_title = gnv_session.of_getstring(this.classname() + ".window_title")
ls_comment = gnv_session.of_getstring(this.classname() + ".comment_for_user")
lds_ref = gnv_session.of_get(this.classname() + ".datastore_ref")

if not isvalid(lds_ref) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$(' + this.classname() + ')', '$$HEX13$$98c7bbba1cb4200008c7c4b3b0c6200038d69ccd85c7c8b2e4b2$$ENDHEX$$')
	return
end if

st_title.text = ls_title
st_comment.text = ls_comment

dw_list.dataobject = lds_ref.dataobject
dw_list.event pfe_dataobjectchanged()
lds_ref.sharedata(dw_list)

dw_list.setfocus()

end event

event key;choose case key
	case KeyEscape!
		cb_cancel.post event clicked()
end choose

end event

type dw_list from pf_u_datawindow within pf_w_selectrowdialog
integer x = 37
integer y = 240
integer width = 1335
integer height = 1004
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;if row = 0 then return

cb_confirm.post event clicked()

end event

type cb_cancel from pf_u_commandbutton within pf_w_selectrowdialog
integer x = 969
integer y = 1256
integer height = 104
integer taborder = 10
string text = "$$HEX2$$e8cd8cc1$$ENDHEX$$"
end type

event clicked;call super::clicked;close(parent)

end event

type cb_confirm from pf_u_commandbutton within pf_w_selectrowdialog
integer x = 562
integer y = 1256
integer height = 104
integer taborder = 10
string text = "$$HEX2$$55d678c7$$ENDHEX$$"
end type

event clicked;call super::clicked;long ll_row

ll_row = dw_list.getrow()
if ll_row = 0 then return

gnv_session.of_put(parent.classname() + ".return_value", ll_row)
close(parent)

end event

type st_title from pf_u_statictext within pf_w_selectrowdialog
integer x = 37
integer y = 32
integer width = 1335
integer height = 72
integer textsize = -10
integer weight = 700
long textcolor = 25123896
string text = "Title"
end type

type st_comment from statictext within pf_w_selectrowdialog
integer x = 37
integer y = 100
integer width = 1335
integer height = 128
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 23488102
string text = "Description"
boolean focusrectangle = false
end type

