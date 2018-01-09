HA$PBExportHeader$pf_u_mdi_toolbar.sru
forward
global type pf_u_mdi_toolbar from pf_u_userobject
end type
type cb_close from pf_u_commandbutton within pf_u_mdi_toolbar
end type
type cb_print from pf_u_commandbutton within pf_u_mdi_toolbar
end type
type cb_execute from pf_u_commandbutton within pf_u_mdi_toolbar
end type
type cb_update from pf_u_commandbutton within pf_u_mdi_toolbar
end type
type cb_delete from pf_u_commandbutton within pf_u_mdi_toolbar
end type
type cb_reset from pf_u_commandbutton within pf_u_mdi_toolbar
end type
type cb_insert from pf_u_commandbutton within pf_u_mdi_toolbar
end type
type cb_retrieve from pf_u_commandbutton within pf_u_mdi_toolbar
end type
type p_icon from pf_u_imagebutton within pf_u_mdi_toolbar
end type
type st_title from statictext within pf_u_mdi_toolbar
end type
end forward

global type pf_u_mdi_toolbar from pf_u_userobject
integer width = 4544
integer height = 156
string text = ""
long tabbackcolor = 1073741824
boolean scaletoright = true
event pfe_addsheet ( )
event pfe_closesheet ( )
event pfe_deselectsheet ( )
event pfe_selectsheet ( )
event pfe_shortcutkey ( )
cb_close cb_close
cb_print cb_print
cb_execute cb_execute
cb_update cb_update
cb_delete cb_delete
cb_reset cb_reset
cb_insert cb_insert
cb_retrieve cb_retrieve
p_icon p_icon
st_title st_title
end type
global pf_u_mdi_toolbar pf_u_mdi_toolbar

type variables
private:
	window iw_sheet[]
	datastore ids_sheetdata
	long il_maxsheetseq
	long il_selectedsheetseq
	pf_n_buttonrole inv_buttonrole

public:
	long ToolbarBackColor = RGB(255,255,255)
	long TitleTextColor = RGB(60,55,55)

end variables

forward prototypes
public function string of_getclassname ()
public function long of_closesheet (long al_sheetseq)
public function integer of_deselectsheet (long al_sheetseq)
public function integer of_selectsheet (long al_sheetseq)
public function integer of_addsheet (string as_menu_id, string as_pgm_id, string as_pgm_name, readonly window aw_sheet)
public function integer of_setbuttonrole (ref pf_n_buttonrole anv_buttonrole)
end prototypes

event pfe_addsheet();// $$HEX26$$dcc2b8d208c7c4b3b0c600ac200094cd00ac20b42000bdacb0c6200038d69ccd18b494b2200074c7a4bcb8d2200085c7c8b2e4b2$$ENDHEX$$.

pf_n_hashtable lnvo_param
string ls_menu_id, ls_pgm_id, ls_pgm_name
window lw_sheet_ref
long ll_retval

lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

ls_menu_id = lnvo_param.of_getstring('menu_id')
ls_pgm_id = lnvo_param.of_getstring('pgm_id')
ls_pgm_name = lnvo_param.of_getstring('pgm_name')
lw_sheet_ref = lnvo_param.of_get('sheet_ref')

ll_retval = this.of_addsheet(ls_menu_id, ls_pgm_id, ls_pgm_name, lw_sheet_ref)

gnv_session.of_put("ReturnValue", ll_retval)

end event

event pfe_closesheet();// $$HEX22$$dcc2b8d208c7c4b3b0c6200085c8ccb8dcc2200038d69ccd18b494b2200074c7a4bcb8d2200085c7c8b2e4b2$$ENDHEX$$.

pf_n_hashtable lnvo_param
long ll_tool_seq, ll_retval

lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

ll_tool_seq = lnvo_param.of_getlong('tool_seq')
ll_retval = this.of_closesheet(ll_tool_seq)

gnv_session.of_put("ReturnValue", ll_retval)

end event

event pfe_deselectsheet();// $$HEX6$$dcc2b8d208c7c4b3b0c62000$$ENDHEX$$Deselect $$HEX14$$dcc2200038d69ccd18b494b2200074c7a4bcb8d2200085c7c8b2e4b2$$ENDHEX$$.

pf_n_hashtable lnvo_param
long ll_tool_seq, ll_retval

lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

ll_tool_seq = lnvo_param.of_getlong('tool_seq')
ll_retval = this.of_deselectsheet(ll_tool_seq)

gnv_session.of_put("ReturnValue", ll_retval)

end event

event pfe_selectsheet();// $$HEX27$$dcc2b8d2200008c7c4b3b0c600ac200020c1ddd01cb42000bdacb0c6200038d69ccd18b494b2200074c7a4bcb8d2200085c7c8b2e4b2$$ENDHEX$$.

pf_n_hashtable lnvo_param
long ll_tool_seq, ll_retval

lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

ll_tool_seq = lnvo_param.of_getlong('tool_seq')
ll_retval = this.of_selectsheet(ll_tool_seq)

// Sheet $$HEX16$$08c7c4b3b0c6d0c51cc1200038d69ccd60d520004cb5200090c7e0c258c72000$$ENDHEX$$ButtonRole$$HEX8$$44c72000f4bcb4b018c97cc5200068d5$$ENDHEX$$
inv_buttonrole = lnvo_param.of_get('button_role')
this.of_setbuttonrole(inv_buttonrole)

gnv_session.of_put("ReturnValue", ll_retval)

end event

event pfe_shortcutkey();// $$HEX11$$e8b295cda4d07cb92000acc0a9c660d52000bdacb0c6$$ENDHEX$$, $$HEX7$$54ba74b2200024c60cbe1dc8b8d2$$ENDHEX$$(pf_m_empty) $$HEX21$$d0c51cc12000e8b295cda4d07cb9200078c7ddc258d5e0ac2000ecc530ae7cb9200038d69ccd74d51cc1$$ENDHEX$$
// $$HEX14$$e8b295cda4d0200030aea5b244c7200018c289d5200069d5c8b2e4b2$$ENDHEX$$. $$HEX24$$e8b295cda4d094b22000acc074c7b8d2c4bc5cb82000c1c911c8200018c215c874d51cc12000acc0a9c669d5c8b2e4b2$$ENDHEX$$.

pf_n_hashtable lnvo_param
long ll_tool_seq, ll_retval
string ls_keypressed

lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

ls_keypressed = lnvo_param.of_getstring("keypressed")
choose case ls_keypressed
	case 'F1'		// $$HEX2$$70c88cd6$$ENDHEX$$
		if cb_retrieve.enabled = true and cb_retrieve.visible = true then
			cb_retrieve.post event clicked()
		end if
	case 'F2'		// $$HEX2$$85c725b8$$ENDHEX$$
		if cb_insert.enabled = true and cb_insert.visible = true then
			cb_insert.post event clicked()
		end if
	case 'F3'		// $$HEX2$$e8cd8cc1$$ENDHEX$$
		if cb_reset.enabled = true and cb_reset.visible = true then
			cb_reset.post event clicked()
		end if
	case 'F4'		// $$HEX2$$adc01cc8$$ENDHEX$$
		if cb_delete.enabled = true and cb_delete.visible = true then
			cb_delete.post event clicked()
		end if
	case 'F5'		// $$HEX2$$00c8a5c7$$ENDHEX$$
		if cb_update.enabled = true and cb_update.visible = true then
			cb_update.post event clicked()
		end if
	case 'F6'		// $$HEX2$$e4c289d5$$ENDHEX$$
		if cb_execute.enabled = true and cb_execute.visible = true then
			cb_execute.post event clicked()
		end if
	case 'F7'		// $$HEX2$$78c7c4c1$$ENDHEX$$
		if cb_print.enabled = true and cb_print.visible = true then
			cb_print.post event clicked()
		end if
end choose

gnv_session.of_put("ReturnValue", ll_retval)

end event

public function string of_getclassname ();return "pf_u_mdi_toolbar"

end function

public function long of_closesheet (long al_sheetseq);long ll_rownum

ll_rownum = ids_sheetdata.find("tool_seq=" + string(al_sheetseq), 1, ids_sheetdata.rowcount())
if ll_rownum <= 0 then return -1

//p_icon.visible = false
//st_title.visible = false
//
//cb_retrieve.visible = false
//cb_insert.visible = false
//cb_reset.visible = false
//cb_delete.visible = false
//cb_save.visible = false
//cb_run.visible = false
//cb_print.visible = false
//cb_close.visible = false

ids_sheetdata.deleterow(ll_rownum)
if ids_sheetdata.rowcount() = 0 then
	il_selectedsheetseq = 0
	this.visible = false
end if

return 1

end function

public function integer of_deselectsheet (long al_sheetseq);//long ll_rownum

//p_icon.visible = false
//st_title.visible = false
//
//cb_retrieve.visible = false
//cb_insert.visible = false
//cb_reset.visible = false
//cb_delete.visible = false
//cb_save.visible = false
//cb_run.visible = false
//cb_print.visible = false
//cb_close.visible = false

il_selectedsheetseq = 0
return 1

end function

public function integer of_selectsheet (long al_sheetseq);long ll_rownum

//p_icon.visible = true
//st_title.visible = true
//
//cb_retrieve.visible = true
//cb_insert.visible = true
//cb_reset.visible = true
//cb_delete.visible = true
//cb_save.visible = true
//cb_run.visible = true
//cb_print.visible = true
//cb_close.visible = true

if il_selectedsheetseq = al_sheetseq then return 0
ll_rownum = ids_sheetdata.find("tool_seq=" + string(al_sheetseq), 1, ids_sheetdata.rowcount())
if ll_rownum <= 0 then return -1

st_title.text = ids_sheetdata.getitemstring(ll_rownum, 'pgm_name')
//if (lower(left(ids_sheetdata.getitemstring(ll_rownum, 'pgm_id'), 9)) = 'pf_w_home') then
//	this.visible = false
//else
//	this.visible = true
//end if

il_selectedsheetseq = al_sheetseq
return 1

end function

public function integer of_addsheet (string as_menu_id, string as_pgm_id, string as_pgm_name, readonly window aw_sheet);long ll_new, ll_seq

ll_new = ids_sheetdata.insertrow(0)
ll_seq = il_maxsheetseq + 1

ids_sheetdata.setitem(ll_new, 'tool_seq', ll_seq)
ids_sheetdata.setitem(ll_new, 'menu_id', as_menu_id)
ids_sheetdata.setitem(ll_new, 'pgm_id', as_pgm_id)
ids_sheetdata.setitem(ll_new, 'pgm_name', as_pgm_name)
iw_sheet[ll_seq] = aw_sheet

if ids_sheetdata.rowcount() > 0 and this.visible = false then
	this.visible = true
end if

il_maxsheetseq = ll_seq
return ll_seq

end function

public function integer of_setbuttonrole (ref pf_n_buttonrole anv_buttonrole);constant integer BUTTON_GAP = 9

this.setredraw(false)
this.post setredraw(true)

if anv_buttonrole.ib_retbtn_yn <> cb_retrieve.visible then cb_retrieve.visible = anv_buttonrole.ib_retbtn_yn
if anv_buttonrole.ib_inpbtn_yn <> cb_insert.visible then cb_insert.visible = anv_buttonrole.ib_inpbtn_yn
if anv_buttonrole.ib_canbtn_yn <> cb_reset.visible then cb_reset.visible = anv_buttonrole.ib_canbtn_yn
if anv_buttonrole.ib_delbtn_yn <> cb_delete.visible then cb_delete.visible = anv_buttonrole.ib_delbtn_yn
if anv_buttonrole.ib_updbtn_yn <> cb_update.visible then cb_update.visible = anv_buttonrole.ib_updbtn_yn
if anv_buttonrole.ib_exebtn_yn <> cb_execute.visible then cb_execute.visible = anv_buttonrole.ib_exebtn_yn
if anv_buttonrole.ib_prtbtn_yn <> cb_print.visible then cb_print.visible = anv_buttonrole.ib_prtbtn_yn

commandbutton lcb_visible[]
integer li_visiblecnt, i
long ll_xpos

if cb_retrieve.visible then
	li_visiblecnt ++
	lcb_visible[li_visiblecnt] = cb_retrieve
end if

if cb_insert.visible then
	li_visiblecnt ++
	lcb_visible[li_visiblecnt] = cb_insert
end if

if cb_reset.visible then
	li_visiblecnt ++
	lcb_visible[li_visiblecnt] = cb_reset
end if

if cb_delete.visible then
	li_visiblecnt ++
	lcb_visible[li_visiblecnt] = cb_delete
end if

if cb_update.visible then
	li_visiblecnt ++
	lcb_visible[li_visiblecnt] = cb_update
end if
	
if cb_execute.visible then
	li_visiblecnt ++
	lcb_visible[li_visiblecnt] = cb_execute
end if

if cb_print.visible then
	li_visiblecnt ++
	lcb_visible[li_visiblecnt] = cb_print
end if

ll_xpos = cb_close.x

for i = li_visiblecnt to 1 step -1
	lcb_visible[i].x = ll_xpos - lcb_visible[i].width - BUTTON_GAP
	ll_xpos = lcb_visible[i].x
next

return 0

end function

on pf_u_mdi_toolbar.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_execute=create cb_execute
this.cb_update=create cb_update
this.cb_delete=create cb_delete
this.cb_reset=create cb_reset
this.cb_insert=create cb_insert
this.cb_retrieve=create cb_retrieve
this.p_icon=create p_icon
this.st_title=create st_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_execute
this.Control[iCurrent+4]=this.cb_update
this.Control[iCurrent+5]=this.cb_delete
this.Control[iCurrent+6]=this.cb_reset
this.Control[iCurrent+7]=this.cb_insert
this.Control[iCurrent+8]=this.cb_retrieve
this.Control[iCurrent+9]=this.p_icon
this.Control[iCurrent+10]=this.st_title
end on

on pf_u_mdi_toolbar.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_execute)
destroy(this.cb_update)
destroy(this.cb_delete)
destroy(this.cb_reset)
destroy(this.cb_insert)
destroy(this.cb_retrieve)
destroy(this.p_icon)
destroy(this.st_title)
end on

event destructor;call super::destructor;if isvalid(ids_sheetdata) then
	destroy ids_sheetdata
end if

end event

event pfe_postopen;call super::pfe_postopen;// Constructor $$HEX19$$74c7a4bcb8d2200074c7c4d6200038d69ccd18b494b2200074c7a4bcb8d2200085c7c8b2e4b2$$ENDHEX$$.

// $$HEX18$$edd098d374c7c0c9200015c8f4bc2000f4bc00ada9c6200070b374c730d108c7c4b3b0c6$$ENDHEX$$
ids_sheetdata = create datastore
ids_sheetdata.dataobject = 'pf_d_mdi_toolbar_data'

this.BackColor = ToolbarBackColor
st_title.BackColor = ToolbarBackColor
st_title.TextColor = TitleTextColor

end event

type p_background from pf_u_userobject`p_background within pf_u_mdi_toolbar
end type

type cb_close from pf_u_commandbutton within pf_u_mdi_toolbar
integer x = 4219
integer y = 28
integer width = 293
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer weight = 700
string text = "$$HEX2$$ebb230ae$$ENDHEX$$"
string prefixiconfile = "..\img\controls\u_tab\closetab.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX22$$ebb230ae84bcbcd2200074d0adb9dcc2200074d5f9b2200008c7c4b3b0c67cb9200085c8ccb869d5c8b2e4b2$$ENDHEX$$.

if il_selectedsheetseq > 0 then
	if isvalid(iw_sheet[il_selectedsheetseq]) then
		post close(iw_sheet[il_selectedsheetseq])
	end if
end if

end event

type cb_print from pf_u_commandbutton within pf_u_mdi_toolbar
integer x = 3918
integer y = 28
integer width = 293
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer weight = 700
string text = "$$HEX2$$78c7c4c1$$ENDHEX$$"
string prefixiconfile = "..\img\controls\u_commandbutton\sub_btn_icon\sub_btn_ico_21.png"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX21$$78c7c4c184bcbcd2200074d0adb9dcc2200038d69ccd18b494b2200074c7a4bcb8d2200085c7c8b2e4b2$$ENDHEX$$.

if il_selectedsheetseq > 0 then
	if isvalid(iw_sheet[il_selectedsheetseq]) then
		iw_sheet[il_selectedsheetseq].dynamic post event pfe_print()
	end if
end if

end event

type cb_execute from pf_u_commandbutton within pf_u_mdi_toolbar
integer x = 3616
integer y = 28
integer width = 293
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer weight = 700
string text = "$$HEX2$$e4c289d5$$ENDHEX$$"
string prefixiconfile = "..\img\controls\u_commandbutton\sub_btn_icon\sub_btn_ico_19.png"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX21$$e4c289d584bcbcd2200074d0adb9dcc2200038d69ccd18b494b2200074c7a4bcb8d2200085c7c8b2e4b2$$ENDHEX$$.

if il_selectedsheetseq > 0 then
	if isvalid(iw_sheet[il_selectedsheetseq]) then
		iw_sheet[il_selectedsheetseq].dynamic post event pfe_execute()
	end if
end if

end event

type cb_update from pf_u_commandbutton within pf_u_mdi_toolbar
integer x = 3314
integer y = 28
integer width = 293
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer weight = 700
string text = "$$HEX2$$00c8a5c7$$ENDHEX$$"
string prefixiconfile = "..\img\controls\u_commandbutton\sub_btn_icon\sub_btn_ico_06.png"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX21$$00c8a5c784bcbcd2200074d0adb9dcc2200038d69ccd18b494b2200074c7a4bcb8d2200085c7c8b2e4b2$$ENDHEX$$.

if il_selectedsheetseq > 0 then
	if isvalid(iw_sheet[il_selectedsheetseq]) then
		iw_sheet[il_selectedsheetseq].dynamic post event pfe_update()
	end if
end if

end event

type cb_delete from pf_u_commandbutton within pf_u_mdi_toolbar
integer x = 3013
integer y = 28
integer width = 293
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string text = "$$HEX2$$adc01cc8$$ENDHEX$$"
string prefixiconfile = "..\img\controls\u_commandbutton\sub_btn_icon\sub_btn_ico_05.png"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX21$$adc01cc884bcbcd2200074d0adb9dcc2200038d69ccd18b494b2200074c7a4bcb8d2200085c7c8b2e4b2$$ENDHEX$$.

if il_selectedsheetseq > 0 then
	if isvalid(iw_sheet[il_selectedsheetseq]) then
		iw_sheet[il_selectedsheetseq].dynamic post event pfe_delete()
	end if
end if

end event

type cb_reset from pf_u_commandbutton within pf_u_mdi_toolbar
integer x = 2711
integer y = 28
integer width = 293
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer weight = 700
string text = "$$HEX2$$e8cd8cc1$$ENDHEX$$"
string prefixiconfile = "..\img\controls\u_commandbutton\sub_btn_icon\sub_btn_ico_02.png"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX2$$e8cd8cc1$$ENDHEX$$($$HEX2$$acb94bc1$$ENDHEX$$) $$HEX19$$84bcbcd2200074d0adb9dcc2200038d69ccd18b494b2200074c7a4bcb8d2200085c7c8b2e4b2$$ENDHEX$$.

if il_selectedsheetseq > 0 then
	if isvalid(iw_sheet[il_selectedsheetseq]) then
		iw_sheet[il_selectedsheetseq].dynamic post event pfe_reset()
	end if
end if

end event

type cb_insert from pf_u_commandbutton within pf_u_mdi_toolbar
integer x = 2409
integer y = 28
integer width = 293
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer weight = 700
string text = "$$HEX2$$85c725b8$$ENDHEX$$"
string prefixiconfile = "..\img\controls\u_commandbutton\sub_btn_icon\sub_btn_ico_04.png"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX21$$85c725b884bcbcd2200074d0adb9dcc2200038d69ccd18b494b2200074c7a4bcb8d2200085c7c8b2e4b2$$ENDHEX$$.

if il_selectedsheetseq > 0 then
	if isvalid(iw_sheet[il_selectedsheetseq]) then
		iw_sheet[il_selectedsheetseq].dynamic post event pfe_insert()
	end if
end if

end event

type cb_retrieve from pf_u_commandbutton within pf_u_mdi_toolbar
integer x = 2107
integer y = 28
integer width = 293
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer weight = 700
string text = "$$HEX2$$70c88cd6$$ENDHEX$$"
string prefixiconfile = "..\img\controls\u_commandbutton\sub_btn_icon\sub_btn_ico_20.png"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX21$$70c88cd684bcbcd2200074d0adb9dcc2200038d69ccd18b494b2200074c7a4bcb8d2200085c7c8b2e4b2$$ENDHEX$$.

if il_selectedsheetseq > 0 then
	if isvalid(iw_sheet[il_selectedsheetseq]) then
		iw_sheet[il_selectedsheetseq].dynamic post event pfe_retrieve()
	end if
end if

end event

type p_icon from pf_u_imagebutton within pf_u_mdi_toolbar
integer x = 50
integer y = 40
integer width = 91
integer height = 76
boolean bringtotop = true
string picturename = "..\img\mainframe\u_mdi_toolbar\title_icon.jpg"
end type

type st_title from statictext within pf_u_mdi_toolbar
integer x = 197
integer y = 16
integer width = 1883
integer height = 116
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
boolean focusrectangle = false
end type

