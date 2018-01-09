$PBExportHeader$w_test.srw
forward
global type w_test from window
end type
type cb_2 from commandbutton within w_test
end type
type cb_1 from commandbutton within w_test
end type
type dw_1 from datawindow within w_test
end type
end forward

global type w_test from window
integer width = 2830
integer height = 2196
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_test w_test

event open;// Profile pf3base_asa9
SQLCA.DBMS = "ODBC"
SQLCA.AutoCommit = False
SQLCA.DBParm = "ConnectString='DSN=pf3base_asa9;UID=dba;PWD=sql'"

connect using sqlca;

dw_1.settransobject(sqlca)

end event

on w_test.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_test.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event close;disconnect using sqlca;

end event

type cb_2 from commandbutton within w_test
integer x = 2309
integer y = 180
integer width = 457
integer height = 132
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "retrieve"
end type

event clicked;dw_1.accepttext()
dw_1.modify("datawindow.querymode=no")
dw_1.retrieve()

end event

type cb_1 from commandbutton within w_test
integer x = 2309
integer y = 28
integer width = 457
integer height = 132
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "querymode"
end type

event clicked;dw_1.modify("datawindow.querymode=yes")

end event

type dw_1 from datawindow within w_test
integer x = 37
integer y = 28
integer width = 2249
integer height = 2020
integer taborder = 10
string title = "none"
string dataobject = "d_temp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

