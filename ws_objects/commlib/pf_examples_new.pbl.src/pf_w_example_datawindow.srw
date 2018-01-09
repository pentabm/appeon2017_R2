$PBExportHeader$pf_w_example_datawindow.srw
forward
global type pf_w_example_datawindow from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_datawindow
end type
end forward

global type pf_w_example_datawindow from pf_w_sheet
string title = "데이터윈도우 샘플 윈도우"
cb_close cb_close
end type
global pf_w_example_datawindow pf_w_example_datawindow

type variables

end variables

forward prototypes
public subroutine of_gettargetdatawindow ()
end prototypes

public subroutine of_gettargetdatawindow ();
end subroutine

on pf_w_example_datawindow.create
int iCurrent
call super::create
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
end on

on pf_w_example_datawindow.destroy
call super::destroy
destroy(this.cb_close)
end on

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_datawindow
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_datawindow
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_datawindow
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_datawindow
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_datawindow
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_datawindow
end type

type cb_close from pf_u_commandbutton within pf_w_example_datawindow
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

