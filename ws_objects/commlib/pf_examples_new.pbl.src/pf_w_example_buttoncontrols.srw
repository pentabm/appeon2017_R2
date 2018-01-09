$PBExportHeader$pf_w_example_buttoncontrols.srw
forward
global type pf_w_example_buttoncontrols from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_buttoncontrols
end type
end forward

global type pf_w_example_buttoncontrols from pf_w_sheet
string title = "버튼 컨트롤 샘플 윈도우"
cb_close cb_close
end type
global pf_w_example_buttoncontrols pf_w_example_buttoncontrols

type variables

end variables

on pf_w_example_buttoncontrols.create
int iCurrent
call super::create
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
end on

on pf_w_example_buttoncontrols.destroy
call super::destroy
destroy(this.cb_close)
end on

event open;call super::open;//st_resize_v.of_set_leftobject(dw_dept)
//st_resize_v.of_set_rightobject(dw_right)
//
//st_resize_h.of_set_topobject(dw_dept)
//st_resize_h.of_set_topobject(st_resize_v)
//st_resize_h.of_set_topobject(dw_right)
//st_resize_h.of_set_bottomobject( dw_bottom)
//
//dw_dept.SetTransObject(SQLCA)
//dw_right.SetTransObject(SQLCA)
//dw_bottom.SetTransObject(SQLCA)
//
//ino_n_hashtable = Create pf_n_hashtable	
//inv_property =  create pf_n_propertywatcher 
//
//cb_sample_retrieve.visible = false
//cb_sample_retrieve.visible = true

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_buttoncontrols
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_buttoncontrols
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_buttoncontrols
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_buttoncontrols
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_buttoncontrols
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_buttoncontrols
end type

type cb_close from pf_u_commandbutton within pf_w_example_buttoncontrols
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

