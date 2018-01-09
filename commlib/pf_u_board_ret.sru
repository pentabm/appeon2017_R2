HA$PBExportHeader$pf_u_board_ret.sru
$PBExportComments$$$HEX20$$8cacdcc23cbb200070c88cd6a9c62000acc0a9c690c7200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$. $$HEX26$$8cacdcc23cbb2000acb9a4c2b8d240c620008cacdcc22000b4b0a9c644c7200055d678c760d5200018c2200088c7b5c2c8b2e4b2$$ENDHEX$$.
forward
global type pf_u_board_ret from pf_u_userobject
end type
type dw_list from pf_u_datawindow within pf_u_board_ret
end type
type dw_mast from pf_u_datawindow within pf_u_board_ret
end type
type cb_refresh from pf_u_commandbutton within pf_u_board_ret
end type
end forward

global type pf_u_board_ret from pf_u_userobject
integer width = 3328
integer height = 2036
event ue_retrieve ( )
dw_list dw_list
dw_mast dw_mast
cb_refresh cb_refresh
end type
global pf_u_board_ret pf_u_board_ret

type variables
string is_board_no = '0000001'

end variables

event ue_retrieve();datetime ldtm_today
pf_n_userrole lnv_userrole
lnv_userrole = gnv_session.of_get('userrole')

ldtm_today = pf_f_getdbmsdatetime()

dw_list.reset()
dw_list.retrieve(gnv_session.is_sys_id, is_board_no, lnv_userrole.is_userrole[], ldtm_today)

end event

on pf_u_board_ret.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_mast=create dw_mast
this.cb_refresh=create cb_refresh
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_mast
this.Control[iCurrent+3]=this.cb_refresh
end on

on pf_u_board_ret.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_mast)
destroy(this.cb_refresh)
end on

event resize;call super::resize;dw_list.width = newwidth - dw_list.x * 2
dw_list.height = newheight - dw_list.y - pixelstounits(1, ypixelstounits!)

cb_refresh.x = dw_list.x + dw_list.width - cb_refresh.width - pixelstounits(6, xpixelstounits!)

end event

event pfe_postopen;call super::pfe_postopen;dw_mast.settransobject(sqlca)
dw_list.settransobject(sqlca)

if dw_mast.retrieve(gnv_session.is_sys_id, is_board_no) = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', 'board_no $$HEX9$$8dc131c144c7200055d678c758d538c194c6$$ENDHEX$$')
	//close(parent)
end if

this.event ue_retrieve()

end event

event constructor;call super::constructor;choose case upper(left(sqlca.dbms, 3))
	// Oracle
	case 'O80', 'O90', 'O10', 'ORA'
		dw_list.dataobject = 'pf_d_board_ret_01_oracle'
	// Other
	case else
		dw_list.dataobject = 'pf_d_board_ret_01_asa'
end choose

end event

type p_background from pf_u_userobject`p_background within pf_u_board_ret
end type

type dw_list from pf_u_datawindow within pf_u_board_ret
integer x = 37
integer y = 100
integer width = 3255
integer height = 1908
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_board_ret_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorting = false
boolean scaletoright = true
boolean scaletobottom = true
end type

event doubleclicked;call super::doubleclicked;if row = 0 then return

string ls_board_no, ls_log_yn
long ll_docu_no

ls_board_no = this.getitemstring(row, 'board_no')
ll_docu_no = this.getitemnumber(row, 'docu_no')
ls_log_yn = dw_mast.getitemstring(1, 'make_log_yn')
if isnull(ls_log_yn) then ls_log_yn = 'N'

openwithparm(pf_w_board_doc_view, ls_board_no + '~t' + string(ll_docu_no) + '~t' + ls_log_yn)

end event

type dw_mast from pf_u_datawindow within pf_u_board_ret
integer x = 37
integer width = 2834
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_board_ret_02"
boolean border = false
boolean applydesign = false
boolean sorting = false
boolean useborder = false
boolean scaletoright = true
end type

type cb_refresh from pf_u_commandbutton within pf_u_board_ret
integer x = 2958
integer width = 338
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string text = "Refresh"
boolean fixedtoright = true
end type

event clicked;call super::clicked;parent.post event ue_retrieve()

end event

