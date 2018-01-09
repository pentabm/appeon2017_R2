HA$PBExportHeader$pf_w_example_popupsearch.srw
forward
global type pf_w_example_popupsearch from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_popupsearch
end type
type st_1 from pf_u_statictext within pf_w_example_popupsearch
end type
type st_2 from pf_u_statictext within pf_w_example_popupsearch
end type
type st_3 from pf_u_statictext within pf_w_example_popupsearch
end type
type st_4 from pf_u_statictext within pf_w_example_popupsearch
end type
type st_5 from pf_u_statictext within pf_w_example_popupsearch
end type
type st_6 from pf_u_statictext within pf_w_example_popupsearch
end type
type st_7 from pf_u_statictext within pf_w_example_popupsearch
end type
type cb_1 from commandbutton within pf_w_example_popupsearch
end type
type sle_wintitle from singlelineedit within pf_w_example_popupsearch
end type
type sle_dwosearch from singlelineedit within pf_w_example_popupsearch
end type
type sle_defvalsearch from singlelineedit within pf_w_example_popupsearch
end type
type sle_dwolist from singlelineedit within pf_w_example_popupsearch
end type
type sle_argslist from singlelineedit within pf_w_example_popupsearch
end type
type sle_colname from singlelineedit within pf_w_example_popupsearch
end type
type st_8 from statictext within pf_w_example_popupsearch
end type
type ddlb_autoretrieve from pf_u_dropdownlistbox within pf_w_example_popupsearch
end type
end forward

global type pf_w_example_popupsearch from pf_w_sheet
string title = "$$HEX12$$f9c62000d0c514b530d12000d8c00cd5200008c7c4b3b0c6$$ENDHEX$$"
boolean controlmenu = true
cb_close cb_close
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
cb_1 cb_1
sle_wintitle sle_wintitle
sle_dwosearch sle_dwosearch
sle_defvalsearch sle_defvalsearch
sle_dwolist sle_dwolist
sle_argslist sle_argslist
sle_colname sle_colname
st_8 st_8
ddlb_autoretrieve ddlb_autoretrieve
end type
global pf_w_example_popupsearch pf_w_example_popupsearch

type variables

end variables

on pf_w_example_popupsearch.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.cb_1=create cb_1
this.sle_wintitle=create sle_wintitle
this.sle_dwosearch=create sle_dwosearch
this.sle_defvalsearch=create sle_defvalsearch
this.sle_dwolist=create sle_dwolist
this.sle_argslist=create sle_argslist
this.sle_colname=create sle_colname
this.st_8=create st_8
this.ddlb_autoretrieve=create ddlb_autoretrieve
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_5
this.Control[iCurrent+7]=this.st_6
this.Control[iCurrent+8]=this.st_7
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.sle_wintitle
this.Control[iCurrent+11]=this.sle_dwosearch
this.Control[iCurrent+12]=this.sle_defvalsearch
this.Control[iCurrent+13]=this.sle_dwolist
this.Control[iCurrent+14]=this.sle_argslist
this.Control[iCurrent+15]=this.sle_colname
this.Control[iCurrent+16]=this.st_8
this.Control[iCurrent+17]=this.ddlb_autoretrieve
end on

on pf_w_example_popupsearch.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.cb_1)
destroy(this.sle_wintitle)
destroy(this.sle_dwosearch)
destroy(this.sle_defvalsearch)
destroy(this.sle_dwolist)
destroy(this.sle_argslist)
destroy(this.sle_colname)
destroy(this.st_8)
destroy(this.ddlb_autoretrieve)
end on

event pfe_postopen;call super::pfe_postopen;ddlb_autoretrieve.selectitem(1)

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_popupsearch
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_popupsearch
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_popupsearch
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_popupsearch
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_popupsearch
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_popupsearch
end type

type cb_close from pf_u_commandbutton within pf_w_example_popupsearch
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

type st_1 from pf_u_statictext within pf_w_example_popupsearch
integer x = 1010
integer y = 664
integer width = 1051
boolean bringtotop = true
string text = "Window title : "
alignment alignment = right!
end type

type st_2 from pf_u_statictext within pf_w_example_popupsearch
integer x = 1010
integer y = 780
integer width = 1051
boolean bringtotop = true
string text = "datawindow object for search condition : "
alignment alignment = right!
end type

type st_3 from pf_u_statictext within pf_w_example_popupsearch
integer x = 1010
integer y = 896
integer width = 1051
boolean bringtotop = true
string text = "default value for search condition : "
alignment alignment = right!
end type

type st_4 from pf_u_statictext within pf_w_example_popupsearch
integer x = 1010
integer y = 1012
integer width = 1051
boolean bringtotop = true
string text = "datawindow object for list : "
alignment alignment = right!
end type

type st_5 from pf_u_statictext within pf_w_example_popupsearch
integer x = 1010
integer y = 1128
integer width = 1051
boolean bringtotop = true
string text = "datawindow arguments for list : "
alignment alignment = right!
end type

type st_6 from pf_u_statictext within pf_w_example_popupsearch
integer x = 1010
integer y = 1244
integer width = 1051
boolean bringtotop = true
string text = "auto retrieve when opened : "
alignment alignment = right!
end type

type st_7 from pf_u_statictext within pf_w_example_popupsearch
integer x = 1010
integer y = 1360
integer width = 1051
boolean bringtotop = true
string text = "column name(s) to be returned :  "
alignment alignment = right!
end type

type cb_1 from commandbutton within pf_w_example_popupsearch
integer x = 2066
integer y = 1504
integer width = 402
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "Execute"
end type

event clicked;pf_s_popupsearch lstr_search
string ls_getitemcolumns[]
integer li_itemcnt, i

lstr_search.transaction_object = sqlca
lstr_search.window_title = sle_wintitle.text
lstr_search.condition_dwobject = sle_dwosearch.text
lstr_search.condition_defaultvalues = sle_defvalsearch.text
lstr_search.list_dwobject = sle_dwolist.text
lstr_search.list_arguments = sle_argslist.text

if ddlb_autoretrieve.of_getselectedindex() = 1 then
	lstr_search.auto_retrieve = false
else
	lstr_search.auto_retrieve = true
end if

li_itemcnt = pf_f_parsetoarray(sle_colname.text, ';', ls_getitemcolumns)
for i = 1 to li_itemcnt
	lstr_search.getitem_column[i] = trim(ls_getitemcolumns[i])
next

openwithparm(pf_w_popupsearch, lstr_search)
if isvalid(message.powerobjectparm) then
        lstr_search = message.powerobjectparm
        if lstr_search.data_selected = true then
			for i = 1 to li_itemcnt
				messagebox(lstr_search.getitem_column[i], lstr_search.column_value[i])
			next
        end if
end if

end event

type sle_wintitle from singlelineedit within pf_w_example_popupsearch
integer x = 2066
integer y = 652
integer width = 878
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "$$HEX7$$f5acb5d154cfdcb4200080acc9c0$$ENDHEX$$"
borderstyle borderstyle = stylelowered!
end type

type sle_dwosearch from singlelineedit within pf_w_example_popupsearch
integer x = 2066
integer y = 768
integer width = 878
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "pf_d_com_code_mst_01"
borderstyle borderstyle = stylelowered!
end type

type sle_defvalsearch from singlelineedit within pf_w_example_popupsearch
integer x = 2066
integer y = 884
integer width = 1815
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "upper_code_id=~'ROOT~'"
borderstyle borderstyle = stylelowered!
end type

type sle_dwolist from singlelineedit within pf_w_example_popupsearch
integer x = 2066
integer y = 1000
integer width = 878
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "pf_d_com_code_mst_04"
borderstyle borderstyle = stylelowered!
end type

type sle_argslist from singlelineedit within pf_w_example_popupsearch
integer x = 2066
integer y = 1116
integer width = 1815
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "as_sys_id = session.sys_id; as_upper_code_id = dw_cond.upper_code_id"
borderstyle borderstyle = stylelowered!
end type

type sle_colname from singlelineedit within pf_w_example_popupsearch
integer x = 2066
integer y = 1352
integer width = 878
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "code_id; code_name"
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within pf_w_example_popupsearch
integer x = 750
integer y = 436
integer width = 987
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "Common Popup for searching"
boolean focusrectangle = false
end type

type ddlb_autoretrieve from pf_u_dropdownlistbox within pf_w_example_popupsearch
integer x = 2066
integer y = 1236
integer width = 480
integer height = 376
integer taborder = 80
boolean bringtotop = true
fontcharset fontcharset = hangeul!
long textcolor = 33554432
string item[] = {"False","True"}
end type

