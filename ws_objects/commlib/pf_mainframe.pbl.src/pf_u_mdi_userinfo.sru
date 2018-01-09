$PBExportHeader$pf_u_mdi_userinfo.sru
forward
global type pf_u_mdi_userinfo from pf_u_datawindow
end type
end forward

global type pf_u_mdi_userinfo from pf_u_datawindow
integer width = 1001
integer height = 120
string dataobject = "pf_d_mdi_userinfo"
boolean border = false
end type
global pf_u_mdi_userinfo pf_u_mdi_userinfo

on pf_u_mdi_userinfo.create
call super::create
end on

on pf_u_mdi_userinfo.destroy
call super::destroy
end on

event resize;call super::resize;long ll_imgxpos
long ll_imgwidth
string ls_syntax
string ls_error

ll_imgwidth = long(this.describe("p_logout.width"))
ll_imgxpos = this.width - ll_imgwidth
ls_syntax = "p_logout.x='" + string(ll_imgxpos) + "'~r~n"

ll_imgwidth = long(this.describe("p_setup.width"))
ll_imgxpos -= ll_imgwidth
ls_syntax += "p_setup.x='" + string(ll_imgxpos) + "'"

ls_error = this.modify(ls_syntax)
if ls_error <> '' then
	messagebox(this.classname() + '.resize()', ls_error)
end if

end event

