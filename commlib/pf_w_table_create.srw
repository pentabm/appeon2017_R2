HA$PBExportHeader$pf_w_table_create.srw
$PBExportComments$$$HEX20$$04d508b884c7ccc66cd0a9c620004cd174c714be2000ddc031c1200054d674ba200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_table_create from pf_w_sheet
end type
type dw_rslt from datawindow within pf_w_table_create
end type
type dw_src from datawindow within pf_w_table_create
end type
type dw_dst from datawindow within pf_w_table_create
end type
type pb_1 from picturebutton within pf_w_table_create
end type
type st_1 from statictext within pf_w_table_create
end type
end forward

global type pf_w_table_create from pf_w_sheet
dw_rslt dw_rslt
dw_src dw_src
dw_dst dw_dst
pb_1 pb_1
st_1 st_1
end type
global pf_w_table_create pf_w_table_create

on pf_w_table_create.create
int iCurrent
call super::create
this.dw_rslt=create dw_rslt
this.dw_src=create dw_src
this.dw_dst=create dw_dst
this.pb_1=create pb_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_rslt
this.Control[iCurrent+2]=this.dw_src
this.Control[iCurrent+3]=this.dw_dst
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.st_1
end on

on pf_w_table_create.destroy
call super::destroy
destroy(this.dw_rslt)
destroy(this.dw_src)
destroy(this.dw_dst)
destroy(this.pb_1)
destroy(this.st_1)
end on

event pfe_postopen;call super::pfe_postopen;dw_src.settransobject(sqlca)
dw_src.insertrow(0)
dw_src.setitem(1, 'src_odbc', sqlca.dbms)

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_table_create
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_table_create
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_table_create
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_table_create
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_table_create
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_table_create
end type

type dw_rslt from datawindow within pf_w_table_create
integer x = 50
integer y = 1412
integer width = 4498
integer height = 808
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "pf_d_table_copy_rslt"
boolean livescroll = true
end type

type dw_src from datawindow within pf_w_table_create
integer x = 50
integer y = 24
integer width = 2011
integer height = 1308
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "pf_d_table_copy_src"
boolean border = false
boolean livescroll = true
end type

type dw_dst from datawindow within pf_w_table_create
integer x = 2542
integer y = 24
integer width = 2021
integer height = 1308
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "pf_d_table_copy_dst"
boolean border = false
boolean livescroll = true
end type

type pb_1 from picturebutton within pf_w_table_create
integer x = 1993
integer y = 408
integer width = 613
integer height = 536
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "..\img\commonuse\db_trans.jpg"
alignment htextalign = left!
end type

type st_1 from statictext within pf_w_table_create
integer x = 69
integer y = 1336
integer width = 457
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "$$HEX4$$98ccacb9b0acfcac$$ENDHEX$$"
boolean focusrectangle = false
end type

