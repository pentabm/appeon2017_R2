$PBExportHeader$pf_w_example_regularexpression.srw
forward
global type pf_w_example_regularexpression from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_regularexpression
end type
end forward

global type pf_w_example_regularexpression from pf_w_sheet
string title = "정규표현식 샘플 윈도우"
cb_close cb_close
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
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
end on

on pf_w_example_regularexpression.destroy
call super::destroy
destroy(this.cb_close)
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
string text = "닫기"
string powertiptext = "해당 화면을 닫습니다."
boolean applydesign = false
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)
end event

