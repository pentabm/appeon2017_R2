HA$PBExportHeader$pf_w_example_regularexpression.srw
forward
global type pf_w_example_regularexpression from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_regularexpression
end type
type st_4 from statictext within pf_w_example_regularexpression
end type
type st_1 from statictext within pf_w_example_regularexpression
end type
type sle_pattern from singlelineedit within pf_w_example_regularexpression
end type
type st_2 from statictext within pf_w_example_regularexpression
end type
type st_3 from statictext within pf_w_example_regularexpression
end type
type ddlb_matchtype from dropdownlistbox within pf_w_example_regularexpression
end type
type cbx_ignorecase from checkbox within pf_w_example_regularexpression
end type
type cbx_global from checkbox within pf_w_example_regularexpression
end type
type st_5 from statictext within pf_w_example_regularexpression
end type
type ddlb_pattern from dropdownlistbox within pf_w_example_regularexpression
end type
type cb_execute from commandbutton within pf_w_example_regularexpression
end type
type st_6 from statictext within pf_w_example_regularexpression
end type
type mle_result from multilineedit within pf_w_example_regularexpression
end type
type mle_teststr from multilineedit within pf_w_example_regularexpression
end type
end forward

global type pf_w_example_regularexpression from pf_w_sheet
string title = "$$HEX12$$15c8dcad5cd404d6ddc22000d8c00cd5200008c7c4b3b0c6$$ENDHEX$$"
cb_close cb_close
st_4 st_4
st_1 st_1
sle_pattern sle_pattern
st_2 st_2
st_3 st_3
ddlb_matchtype ddlb_matchtype
cbx_ignorecase cbx_ignorecase
cbx_global cbx_global
st_5 st_5
ddlb_pattern ddlb_pattern
cb_execute cb_execute
st_6 st_6
mle_result mle_result
mle_teststr mle_teststr
end type
global pf_w_example_regularexpression pf_w_example_regularexpression

type variables
public:
	pf_n_regexp inv_exp

end variables

on pf_w_example_regularexpression.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_4=create st_4
this.st_1=create st_1
this.sle_pattern=create sle_pattern
this.st_2=create st_2
this.st_3=create st_3
this.ddlb_matchtype=create ddlb_matchtype
this.cbx_ignorecase=create cbx_ignorecase
this.cbx_global=create cbx_global
this.st_5=create st_5
this.ddlb_pattern=create ddlb_pattern
this.cb_execute=create cb_execute
this.st_6=create st_6
this.mle_result=create mle_result
this.mle_teststr=create mle_teststr
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_pattern
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.ddlb_matchtype
this.Control[iCurrent+8]=this.cbx_ignorecase
this.Control[iCurrent+9]=this.cbx_global
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.ddlb_pattern
this.Control[iCurrent+12]=this.cb_execute
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.mle_result
this.Control[iCurrent+15]=this.mle_teststr
end on

on pf_w_example_regularexpression.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.sle_pattern)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.ddlb_matchtype)
destroy(this.cbx_ignorecase)
destroy(this.cbx_global)
destroy(this.st_5)
destroy(this.ddlb_pattern)
destroy(this.cb_execute)
destroy(this.st_6)
destroy(this.mle_result)
destroy(this.mle_teststr)
end on

event pfe_postopen;call super::pfe_postopen;inv_exp = create pf_n_regexp

end event

event close;call super::close;destroy inv_exp

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_regularexpression
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_regularexpression
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_regularexpression
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_regularexpression
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_regularexpression
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_regularexpression
end type

type cb_close from pf_u_commandbutton within pf_w_example_regularexpression
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

type st_4 from statictext within pf_w_example_regularexpression
integer x = 763
integer y = 204
integer width = 626
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "Regular Expression"
boolean focusrectangle = false
end type

type st_1 from statictext within pf_w_example_regularexpression
integer x = 937
integer y = 548
integer width = 535
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "Pattern : "
boolean focusrectangle = false
end type

type sle_pattern from singlelineedit within pf_w_example_regularexpression
integer x = 1477
integer y = 536
integer width = 1888
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within pf_w_example_regularexpression
integer x = 937
integer y = 812
integer width = 535
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "Test String : "
boolean focusrectangle = false
end type

type st_3 from statictext within pf_w_example_regularexpression
integer x = 937
integer y = 416
integer width = 535
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "Match Type : "
boolean focusrectangle = false
end type

type ddlb_matchtype from dropdownlistbox within pf_w_example_regularexpression
integer x = 1477
integer y = 408
integer width = 754
integer height = 376
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22040656
string item[] = {"Find Match","Replace Match","Test Pattern"}
borderstyle borderstyle = stylelowered!
end type

type cbx_ignorecase from checkbox within pf_w_example_regularexpression
integer x = 2962
integer y = 420
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "IgnoreCase"
boolean checked = true
end type

type cbx_global from checkbox within pf_w_example_regularexpression
integer x = 2592
integer y = 420
integer width = 320
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "Global"
boolean checked = true
end type

type st_5 from statictext within pf_w_example_regularexpression
integer x = 937
integer y = 680
integer width = 535
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "(Predefined Pattern)"
boolean focusrectangle = false
end type

type ddlb_pattern from dropdownlistbox within pf_w_example_regularexpression
integer x = 1477
integer y = 672
integer width = 754
integer height = 616
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22040656
string item[] = {" ","Validate Email","Validate isHangul","Validate PhoneNumber","Validate URL","Validdate Password"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;choose case index
	// Empty Item
	case 1
		sle_pattern.text = ''
	// Validate Email
	case 2
		ddlb_matchtype.selectitem(3)
		sle_pattern.text = "^[A-Za-z0-9._-]+@[[A-Za-z0-9.-]+$"
		cbx_ignorecase.checked = false
		cbx_global.checked = false
	// Validate isHangul
	case 3
		ddlb_matchtype.selectitem(3)
		sle_pattern.text = "[$$HEX1$$3131$$ENDHEX$$-$$HEX1$$4e31$$ENDHEX$$|$$HEX1$$4f31$$ENDHEX$$-$$HEX1$$6331$$ENDHEX$$|$$HEX1$$00ac$$ENDHEX$$-$$HEX1$$a3d7$$ENDHEX$$]"
		cbx_ignorecase.checked = false
		cbx_global.checked = false
	// Validate PhoneNumber
	case 4
		ddlb_matchtype.selectitem(3)
		sle_pattern.text = "^\(\d{2,3}\)\s?\d{3,4}-\d{4}$"
		cbx_ignorecase.checked = false
		cbx_global.checked = false
	// Validate URL
	case 5
		ddlb_matchtype.selectitem(3)
		sle_pattern.text = "^(https?:\/\/[a-z0-9\-]+\.[a-z0-9\-\.]+(?:\/|(?:\/[a-zA-Z0-9!#\$%&'\*\+,\-\.:;=\?@\[\]_~]+)*))$"
		cbx_ignorecase.checked = true
		cbx_global.checked = false
	// Validate Password
	case 6
		ddlb_matchtype.selectitem(3)
		sle_pattern.text = "^(?=.*[a-zA-Z])(?=.*[0-9])"
		cbx_ignorecase.checked = false
		cbx_global.checked = true
end choose

end event

type cb_execute from commandbutton within pf_w_example_regularexpression
integer x = 1477
integer y = 2044
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
string text = "Execute"
end type

event clicked;string ls_pattern, ls_teststr
string ls_result, ls_results[]
string ls_replacestr

boolean lb_result
integer li_cnt, i

ls_pattern = sle_pattern.text
if pf_f_isemptystring(ls_pattern) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX12$$80acc9c0200028d334d144c7200085c725b858d538c194c6$$ENDHEX$$')
	return
end if

ls_teststr = mle_teststr.text
if pf_f_isemptystring(ls_teststr) then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX14$$4cd1a4c2b8d2200038bb90c7f4c544c7200085c725b858d538c194c6$$ENDHEX$$')
	return
end if

inv_exp.of_setPattern(ls_pattern)
inv_exp.of_setIgnoreCase(cbx_ignorecase.checked)
inv_exp.of_setGlobal(cbx_global.checked)

choose case ddlb_matchtype.Text
	case 'Find Match'
		li_cnt = inv_exp.of_findmatches(ls_teststr, ls_results)
		ls_result = ''
		for i = 1 to li_cnt
			if i > 1 then ls_result += '~r~n'
			ls_result += ls_results[i]
		next
		mle_result.text = ls_result
		
	case 'Replace Match'
		if pf_f_inputdialog("Input stirng replace matche(s)", "$$HEX14$$c0bcbdac60d5200038bb90c7f4c544c7200085c725b858d538c194c6$$ENDHEX$$", ls_replacestr) > 0 then
			if cbx_global.checked = false then
				ls_result = inv_exp.of_replace(ls_teststr, ls_replacestr)
			else
				ls_result = inv_exp.of_replaceall(ls_teststr, ls_replacestr)
			end if
			mle_result.text = ls_Result
		end if
		
	case 'Test Pattern'
		lb_result = inv_exp.of_test(ls_teststr)
		if lb_result then
			mle_result.text = 'True'
		else
			mle_result.text = 'False'
		end if
end choose

end event

type st_6 from statictext within pf_w_example_regularexpression
integer x = 937
integer y = 1420
integer width = 535
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 20066866
string text = "Result : "
boolean focusrectangle = false
end type

type mle_result from multilineedit within pf_w_example_regularexpression
integer x = 1477
integer y = 1420
integer width = 1888
integer height = 600
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type mle_teststr from multilineedit within pf_w_example_regularexpression
integer x = 1477
integer y = 800
integer width = 1888
integer height = 600
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

