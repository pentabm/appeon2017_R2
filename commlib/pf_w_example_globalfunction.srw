HA$PBExportHeader$pf_w_example_globalfunction.srw
forward
global type pf_w_example_globalfunction from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_globalfunction
end type
type cb_1 from commandbutton within pf_w_example_globalfunction
end type
type cb_2 from commandbutton within pf_w_example_globalfunction
end type
type cb_3 from commandbutton within pf_w_example_globalfunction
end type
type cb_4 from commandbutton within pf_w_example_globalfunction
end type
type cb_5 from commandbutton within pf_w_example_globalfunction
end type
type cb_6 from commandbutton within pf_w_example_globalfunction
end type
type cb_7 from commandbutton within pf_w_example_globalfunction
end type
type st_1 from statictext within pf_w_example_globalfunction
end type
type st_2 from statictext within pf_w_example_globalfunction
end type
type st_3 from statictext within pf_w_example_globalfunction
end type
type st_4 from statictext within pf_w_example_globalfunction
end type
type st_5 from statictext within pf_w_example_globalfunction
end type
type st_6 from statictext within pf_w_example_globalfunction
end type
type st_7 from statictext within pf_w_example_globalfunction
end type
type st_8 from statictext within pf_w_example_globalfunction
end type
type sle_dbmsdatetime from singlelineedit within pf_w_example_globalfunction
end type
type st_9 from statictext within pf_w_example_globalfunction
end type
type sle_parentwindow from singlelineedit within pf_w_example_globalfunction
end type
type st_10 from statictext within pf_w_example_globalfunction
end type
type sle_nvl from singlelineedit within pf_w_example_globalfunction
end type
type cb_8 from commandbutton within pf_w_example_globalfunction
end type
type st_11 from statictext within pf_w_example_globalfunction
end type
type sle_source from singlelineedit within pf_w_example_globalfunction
end type
type st_12 from statictext within pf_w_example_globalfunction
end type
type sle_delimiter from singlelineedit within pf_w_example_globalfunction
end type
type st_13 from statictext within pf_w_example_globalfunction
end type
type ddlb_result from dropdownlistbox within pf_w_example_globalfunction
end type
type st_14 from statictext within pf_w_example_globalfunction
end type
type sle_tobereplaced from singlelineedit within pf_w_example_globalfunction
end type
type st_15 from statictext within pf_w_example_globalfunction
end type
type sle_replaced from singlelineedit within pf_w_example_globalfunction
end type
type st_16 from statictext within pf_w_example_globalfunction
end type
type sle_usertyped from singlelineedit within pf_w_example_globalfunction
end type
type st_17 from statictext within pf_w_example_globalfunction
end type
type dw_list from datawindow within pf_w_example_globalfunction
end type
type st_18 from statictext within pf_w_example_globalfunction
end type
type sle_selectedrow from singlelineedit within pf_w_example_globalfunction
end type
type st_19 from statictext within pf_w_example_globalfunction
end type
type cb_9 from commandbutton within pf_w_example_globalfunction
end type
type sle_koreng from singlelineedit within pf_w_example_globalfunction
end type
type st_20 from statictext within pf_w_example_globalfunction
end type
end forward

global type pf_w_example_globalfunction from pf_w_sheet
string title = "$$HEX12$$04c8edc5200068d518c22000d8c00cd5200008c7c4b3b0c6$$ENDHEX$$"
cb_close cb_close
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
sle_dbmsdatetime sle_dbmsdatetime
st_9 st_9
sle_parentwindow sle_parentwindow
st_10 st_10
sle_nvl sle_nvl
cb_8 cb_8
st_11 st_11
sle_source sle_source
st_12 st_12
sle_delimiter sle_delimiter
st_13 st_13
ddlb_result ddlb_result
st_14 st_14
sle_tobereplaced sle_tobereplaced
st_15 st_15
sle_replaced sle_replaced
st_16 st_16
sle_usertyped sle_usertyped
st_17 st_17
dw_list dw_list
st_18 st_18
sle_selectedrow sle_selectedrow
st_19 st_19
cb_9 cb_9
sle_koreng sle_koreng
st_20 st_20
end type
global pf_w_example_globalfunction pf_w_example_globalfunction

type variables

end variables

on pf_w_example_globalfunction.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.sle_dbmsdatetime=create sle_dbmsdatetime
this.st_9=create st_9
this.sle_parentwindow=create sle_parentwindow
this.st_10=create st_10
this.sle_nvl=create sle_nvl
this.cb_8=create cb_8
this.st_11=create st_11
this.sle_source=create sle_source
this.st_12=create st_12
this.sle_delimiter=create sle_delimiter
this.st_13=create st_13
this.ddlb_result=create ddlb_result
this.st_14=create st_14
this.sle_tobereplaced=create sle_tobereplaced
this.st_15=create st_15
this.sle_replaced=create sle_replaced
this.st_16=create st_16
this.sle_usertyped=create sle_usertyped
this.st_17=create st_17
this.dw_list=create dw_list
this.st_18=create st_18
this.sle_selectedrow=create sle_selectedrow
this.st_19=create st_19
this.cb_9=create cb_9
this.sle_koreng=create sle_koreng
this.st_20=create st_20
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_4
this.Control[iCurrent+6]=this.cb_5
this.Control[iCurrent+7]=this.cb_6
this.Control[iCurrent+8]=this.cb_7
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.st_7
this.Control[iCurrent+16]=this.st_8
this.Control[iCurrent+17]=this.sle_dbmsdatetime
this.Control[iCurrent+18]=this.st_9
this.Control[iCurrent+19]=this.sle_parentwindow
this.Control[iCurrent+20]=this.st_10
this.Control[iCurrent+21]=this.sle_nvl
this.Control[iCurrent+22]=this.cb_8
this.Control[iCurrent+23]=this.st_11
this.Control[iCurrent+24]=this.sle_source
this.Control[iCurrent+25]=this.st_12
this.Control[iCurrent+26]=this.sle_delimiter
this.Control[iCurrent+27]=this.st_13
this.Control[iCurrent+28]=this.ddlb_result
this.Control[iCurrent+29]=this.st_14
this.Control[iCurrent+30]=this.sle_tobereplaced
this.Control[iCurrent+31]=this.st_15
this.Control[iCurrent+32]=this.sle_replaced
this.Control[iCurrent+33]=this.st_16
this.Control[iCurrent+34]=this.sle_usertyped
this.Control[iCurrent+35]=this.st_17
this.Control[iCurrent+36]=this.dw_list
this.Control[iCurrent+37]=this.st_18
this.Control[iCurrent+38]=this.sle_selectedrow
this.Control[iCurrent+39]=this.st_19
this.Control[iCurrent+40]=this.cb_9
this.Control[iCurrent+41]=this.sle_koreng
this.Control[iCurrent+42]=this.st_20
end on

on pf_w_example_globalfunction.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.sle_dbmsdatetime)
destroy(this.st_9)
destroy(this.sle_parentwindow)
destroy(this.st_10)
destroy(this.sle_nvl)
destroy(this.cb_8)
destroy(this.st_11)
destroy(this.sle_source)
destroy(this.st_12)
destroy(this.sle_delimiter)
destroy(this.st_13)
destroy(this.ddlb_result)
destroy(this.st_14)
destroy(this.sle_tobereplaced)
destroy(this.st_15)
destroy(this.sle_replaced)
destroy(this.st_16)
destroy(this.sle_usertyped)
destroy(this.st_17)
destroy(this.dw_list)
destroy(this.st_18)
destroy(this.sle_selectedrow)
destroy(this.st_19)
destroy(this.cb_9)
destroy(this.sle_koreng)
destroy(this.st_20)
end on

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_globalfunction
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_globalfunction
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_globalfunction
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_globalfunction
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_globalfunction
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_globalfunction
end type

type cb_close from pf_u_commandbutton within pf_w_example_globalfunction
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

type cb_1 from commandbutton within pf_w_example_globalfunction
integer x = 311
integer y = 376
integer width = 640
integer height = 120
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "getDBMSDatetime"
end type

event clicked;// DBMS $$HEX9$$04d6acc720007cc7dcc220006cad58d530ae$$ENDHEX$$
Datetime ld_date

ld_date = pf_f_getdbmsdatetime()	
sle_dbmsdatetime.text = string( ld_date )

end event

type cb_2 from commandbutton within pf_w_example_globalfunction
integer x = 311
integer y = 596
integer width = 640
integer height = 120
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "getParentWindow"
end type

event clicked;window lw_parent

lw_parent = pf_f_getparentwindow(this)
sle_parentwindow.text = lw_parent.classname()

end event

type cb_3 from commandbutton within pf_w_example_globalfunction
integer x = 311
integer y = 816
integer width = 640
integer height = 120
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "nvl"
end type

event clicked;string ls_testdata, ls_result

ls_testdata = sle_nvl.text
ls_result = pf_f_nvl(ls_testdata, 'The test data is null')

messagebox('Result', ls_result)

end event

type cb_4 from commandbutton within pf_w_example_globalfunction
integer x = 311
integer y = 1036
integer width = 640
integer height = 120
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "parseToArray"
end type

event clicked;string ls_source, ls_delimiter, ls_result[]
integer li_cnt, i

ls_source = sle_source.text
ls_delimiter = sle_delimiter.text

ddlb_result.reset()
li_cnt = pf_f_parsetoarray(ls_source, ls_delimiter, ls_result)
for i = 1 to li_cnt
	ddlb_result.additem(ls_result[i])
next

end event

type cb_5 from commandbutton within pf_w_example_globalfunction
integer x = 311
integer y = 1256
integer width = 640
integer height = 120
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "replaceAll"
end type

event clicked;string ls_source
string ls_findstr, ls_repstr

ls_source = sle_tobereplaced.text
if pf_f_isemptystring(ls_source) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX14$$58ce58d660d5200038bb90c7f4c544c7200085c725b858d538c194c6$$ENDHEX$$')
	return
end if

if pf_f_inputdialog('Searching String', '$$HEX13$$80acc9c060d52000b4b0a9c644c7200085c725b858d538c194c6$$ENDHEX$$', ls_findstr) = 0 then
	return
end if

if pf_f_inputdialog('Replacing String', '$$HEX21$$80acc9c01cb42000b4b0a9c67cb9200058ce58d660d5200038bb90c77cb9200085c725b858d538c194c6$$ENDHEX$$', ls_repstr) = 0 then
	return
end if

sle_replaced.text = pf_f_replaceall(ls_source, ls_findstr, ls_repstr)

end event

type cb_6 from commandbutton within pf_w_example_globalfunction
integer x = 311
integer y = 1476
integer width = 640
integer height = 120
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "inputDialog"
end type

event clicked;string ls_usertyped

if pf_f_inputdialog('Please type your name', '$$HEX14$$f9b2e0c258c7200074c784b944c7200085c725b874d5fcc838c194c6$$ENDHEX$$', ls_usertyped) = 1 then
	sle_usertyped.text = ls_usertyped
end if

end event

type cb_7 from commandbutton within pf_w_example_globalfunction
integer x = 311
integer y = 1916
integer width = 640
integer height = 120
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "selectrowDialog"
end type

event clicked;long ll_selectedrow
datastore lds_list

lds_list = create datastore
lds_list.dataobject = dw_list.dataobject

ll_selectedrow = pf_f_selectrowdialog('Choose your favorite...', '$$HEX18$$f9b2e0c274c7200020c138d658d594b22000fcac7cc744c7200020c1ddd058d538c194c6$$ENDHEX$$', lds_list)
if ll_selectedrow > 0 then
	sle_selectedrow.text = string(ll_selectedrow) + "$$HEX13$$88bcf8c9200089d574c7200020c1ddd018b4c8c5b5c2c8b2e4b2$$ENDHEX$$"
end if

end event

type st_1 from statictext within pf_w_example_globalfunction
integer x = 320
integer y = 300
integer width = 873
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX9$$70b374c730d1a0bc74c7a4c220007cc790c7$$ENDHEX$$+$$HEX6$$dcc204ac20006cad58d530ae$$ENDHEX$$"
boolean focusrectangle = false
end type

type st_2 from statictext within pf_w_example_globalfunction
integer x = 320
integer y = 520
integer width = 681
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX10$$80bda8ba200008c7c4b3b0c620006cad58d530ae$$ENDHEX$$"
boolean focusrectangle = false
end type

type st_3 from statictext within pf_w_example_globalfunction
integer x = 320
integer y = 740
integer width = 681
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "NULL$$HEX6$$12ac200058ce58d658d530ae$$ENDHEX$$"
boolean focusrectangle = false
end type

type st_4 from statictext within pf_w_example_globalfunction
integer x = 315
integer y = 960
integer width = 713
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX13$$38bb90c7f4c544c7200030bcf4c55cb820000cd3f1c258d530ae$$ENDHEX$$"
boolean focusrectangle = false
end type

type st_5 from statictext within pf_w_example_globalfunction
integer x = 315
integer y = 1180
integer width = 681
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX8$$38bb90c7f4c5200058ce58d658d530ae$$ENDHEX$$"
boolean focusrectangle = false
end type

type st_6 from statictext within pf_w_example_globalfunction
integer x = 315
integer y = 1400
integer width = 681
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX8$$38bb90c7f4c5200085c725b81bbc30ae$$ENDHEX$$"
boolean focusrectangle = false
end type

type st_7 from statictext within pf_w_example_globalfunction
integer x = 315
integer y = 1840
integer width = 681
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX11$$acb9a4c2b8d220006dd5a9ba200020c1ddd01bbc30ae$$ENDHEX$$"
boolean focusrectangle = false
end type

type st_8 from statictext within pf_w_example_globalfunction
integer x = 1051
integer y = 408
integer width = 466
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX5$$04d6acc7f4d354b32000$$ENDHEX$$: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_dbmsdatetime from singlelineedit within pf_w_example_globalfunction
integer x = 1513
integer y = 384
integer width = 1691
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type st_9 from statictext within pf_w_example_globalfunction
integer x = 1051
integer y = 628
integer width = 466
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX7$$80bda8ba08c7c4b3b0c685ba2000$$ENDHEX$$: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_parentwindow from singlelineedit within pf_w_example_globalfunction
integer x = 1513
integer y = 604
integer width = 1691
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type st_10 from statictext within pf_w_example_globalfunction
integer x = 1051
integer y = 848
integer width = 466
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX7$$4cd1a4c2b8d260d5200012ac2000$$ENDHEX$$: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_nvl from singlelineedit within pf_w_example_globalfunction
integer x = 1513
integer y = 824
integer width = 1275
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type cb_8 from commandbutton within pf_w_example_globalfunction
integer x = 2802
integer y = 824
integer width = 402
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "set NULL"
end type

event clicked;sle_nvl.text = ''
setnull(sle_nvl.text)

end event

type st_11 from statictext within pf_w_example_globalfunction
integer x = 1051
integer y = 1068
integer width = 466
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX8$$0cd3f1c260d5200038bb90c7f4c52000$$ENDHEX$$: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_source from singlelineedit within pf_w_example_globalfunction
integer x = 1518
integer y = 1044
integer width = 992
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22040656
string text = "../img/calendar/btn_calender_left.jpg"
borderstyle borderstyle = stylelowered!
end type

type st_12 from statictext within pf_w_example_globalfunction
integer x = 2528
integer y = 1068
integer width = 283
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX4$$6cad84bd90c72000$$ENDHEX$$: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_delimiter from singlelineedit within pf_w_example_globalfunction
integer x = 2816
integer y = 1044
integer width = 174
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22040656
string text = "/"
borderstyle borderstyle = stylelowered!
end type

type st_13 from statictext within pf_w_example_globalfunction
integer x = 3013
integer y = 1068
integer width = 261
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX4$$b0acfcac12ac2000$$ENDHEX$$: "
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_result from dropdownlistbox within pf_w_example_globalfunction
integer x = 3282
integer y = 1044
integer width = 663
integer height = 376
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type st_14 from statictext within pf_w_example_globalfunction
integer x = 1051
integer y = 1288
integer width = 466
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX8$$58ce58d660d5200038bb90c7f4c52000$$ENDHEX$$: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_tobereplaced from singlelineedit within pf_w_example_globalfunction
integer x = 1518
integer y = 1264
integer width = 992
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type st_15 from statictext within pf_w_example_globalfunction
integer x = 2537
integer y = 1288
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX8$$58ce58d61cb4200038bb90c7f4c52000$$ENDHEX$$: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_replaced from singlelineedit within pf_w_example_globalfunction
integer x = 2958
integer y = 1264
integer width = 992
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type st_16 from statictext within pf_w_example_globalfunction
integer x = 1051
integer y = 1508
integer width = 466
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX9$$85c725b81bbc40c7200038bb90c7f4c52000$$ENDHEX$$: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_usertyped from singlelineedit within pf_w_example_globalfunction
integer x = 1518
integer y = 1484
integer width = 1691
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type st_17 from statictext within pf_w_example_globalfunction
integer x = 1051
integer y = 1948
integer width = 466
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX8$$20c1ddd060d52000acb9a4c2b8d22000$$ENDHEX$$: "
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_list from datawindow within pf_w_example_globalfunction
integer x = 1518
integer y = 1916
integer width = 992
integer height = 484
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "pf_d_example_globalfunction_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_18 from statictext within pf_w_example_globalfunction
integer x = 2537
integer y = 1948
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX7$$20c1ddd01cb420007cb778c72000$$ENDHEX$$: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_selectedrow from singlelineedit within pf_w_example_globalfunction
integer x = 2962
integer y = 1924
integer width = 992
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type st_19 from statictext within pf_w_example_globalfunction
integer x = 315
integer y = 1620
integer width = 681
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX5$$5cd501c6200004c858d6$$ENDHEX$$"
boolean focusrectangle = false
end type

type cb_9 from commandbutton within pf_w_example_globalfunction
integer x = 311
integer y = 1696
integer width = 640
integer height = 120
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "toggleKorEng"
end type

event clicked;pf_f_togglekoreng('k')

end event

type sle_koreng from singlelineedit within pf_w_example_globalfunction
integer x = 1518
integer y = 1704
integer width = 1691
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type st_20 from statictext within pf_w_example_globalfunction
integer x = 1051
integer y = 1728
integer width = 466
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "$$HEX5$$5cd501c604c858d62000$$ENDHEX$$: "
alignment alignment = right!
boolean focusrectangle = false
end type

