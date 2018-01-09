HA$PBExportHeader$pf_u_mdi_sheetnavi.sru
forward
global type pf_u_mdi_sheetnavi from pf_u_userobject
end type
type p_icon from pf_u_picture within pf_u_mdi_sheetnavi
end type
type st_navi from pf_u_statictext within pf_u_mdi_sheetnavi
end type
type p_help from pf_u_imagebutton within pf_u_mdi_sheetnavi
end type
end forward

global type pf_u_mdi_sheetnavi from pf_u_userobject
integer width = 3602
integer height = 100
event pfe_addsheet ( )
event pfe_closesheet ( )
event pfe_selectsheet ( )
event pfe_deselectsheet ( )
p_icon p_icon
st_navi st_navi
p_help p_help
end type
global pf_u_mdi_sheetnavi pf_u_mdi_sheetnavi

type variables
private:
	window iw_sheet[]
	datastore ids_sheetdata
	long il_maxsheetseq
	long il_selectedsheetseq

end variables

forward prototypes
public subroutine of_setsheetnavi (string as_sheetnavi)
public function string of_getclassname ()
public function integer of_addsheet (string as_menu_id, string as_pgm_id, string as_pgm_path, readonly window aw_sheet)
public function integer of_selectsheet (long al_sheetseq)
public function integer of_deselectsheet (long al_sheetseq)
public function long of_closesheet (long al_sheetseq)
end prototypes

event pfe_addsheet();pf_n_hashtable lnvo_param
string ls_menu_id, ls_pgm_id, ls_pgm_path
window lw_sheet_ref
long ll_retval

//iw_parent.dynamic of_getparameter(lnvo_param)
lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

ls_menu_id = lnvo_param.of_getstring('menu_id')
ls_pgm_id = lnvo_param.of_getstring('pgm_id')
ls_pgm_path = lnvo_param.of_getstring('pgm_path')
lw_sheet_ref = lnvo_param.of_get('sheet_ref')

ll_retval = this.of_addsheet(ls_menu_id, ls_pgm_id, ls_pgm_path, lw_sheet_ref)

//lnvo_param.of_put("ReturnValue", ll_retval)
gnv_session.of_put("ReturnValue", ll_retval)

return

end event

event pfe_closesheet();pf_n_hashtable lnvo_param
long ll_sheet_seq, ll_retval

//iw_parent.dynamic of_getparameter(lnvo_param)
lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

ll_sheet_seq = lnvo_param.of_getlong('sheet_seq')
ll_retval = this.of_closesheet(ll_sheet_seq)

//lnvo_param.of_put("ReturnValue", ll_retval)
gnv_session.of_put("ReturnValue", ll_retval)

return

end event

event pfe_selectsheet();pf_n_hashtable lnvo_param
long ll_sheet_seq, ll_retval

//iw_parent.dynamic of_getparameter(lnvo_param)
lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

ll_sheet_seq = lnvo_param.of_getlong('sheet_seq')
ll_retval = this.of_selectsheet(ll_sheet_seq)

//lnvo_param.of_put("ReturnValue", ll_retval)
gnv_session.of_put("ReturnValue", ll_retval)

return

end event

event pfe_deselectsheet();pf_n_hashtable lnvo_param
long ll_sheet_seq, ll_retval

//iw_parent.dynamic of_getparameter(lnvo_param)
lnvo_param = gnv_session.of_get(this.of_getclassname())
if isnull(lnvo_param) or not isvalid(lnvo_param) then return

ll_sheet_seq = lnvo_param.of_getlong('sheet_seq')
ll_retval = this.of_deselectsheet(ll_sheet_seq)

//lnvo_param.of_put("ReturnValue", ll_retval)
gnv_session.of_put("ReturnValue", ll_retval)

return

end event

public subroutine of_setsheetnavi (string as_sheetnavi);
end subroutine

public function string of_getclassname ();return 'pf_u_mdi_sheetnavi'

end function

public function integer of_addsheet (string as_menu_id, string as_pgm_id, string as_pgm_path, readonly window aw_sheet);long ll_new, ll_seq

ll_new = ids_sheetdata.insertrow(0)
ll_seq = il_maxsheetseq + 1

ids_sheetdata.setitem(ll_new, 'sheet_seq', ll_seq)
ids_sheetdata.setitem(ll_new, 'menu_id', as_menu_id)
ids_sheetdata.setitem(ll_new, 'pgm_id', as_pgm_id)
ids_sheetdata.setitem(ll_new, 'pgm_path', as_pgm_path)
iw_sheet[ll_seq] = aw_sheet

il_maxsheetseq = ll_seq
return ll_seq

end function

public function integer of_selectsheet (long al_sheetseq);long ll_rownum

p_icon.visible = true
st_navi.visible = true
p_help.visible = true
//p_favorite.visible = true

if il_selectedsheetseq = al_sheetseq then return 0
ll_rownum = ids_sheetdata.find("sheet_seq=" + string(al_sheetseq), 1, ids_sheetdata.rowcount())
if ll_rownum <= 0 then return -1

st_navi.text = ids_sheetdata.getitemstring(ll_rownum, 'pgm_path')
il_selectedsheetseq = al_sheetseq
return 1

end function

public function integer of_deselectsheet (long al_sheetseq);p_icon.visible = false
st_navi.visible = false
p_help.visible = false
//p_favorite.visible = false

il_selectedsheetseq = 0
return 1

end function

public function long of_closesheet (long al_sheetseq);long ll_rownum

ll_rownum = ids_sheetdata.find("sheet_seq=" + string(al_sheetseq), 1, ids_sheetdata.rowcount())
if ll_rownum <= 0 then return -1

p_icon.visible = false
st_navi.visible = false
p_help.visible = false
//p_favorite.visible = false

ids_sheetdata.deleterow(ll_rownum)
if ids_sheetdata.rowcount() = 0 then
	il_selectedsheetseq = 0
end if

return 1

end function

on pf_u_mdi_sheetnavi.create
int iCurrent
call super::create
this.p_icon=create p_icon
this.st_navi=create st_navi
this.p_help=create p_help
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_icon
this.Control[iCurrent+2]=this.st_navi
this.Control[iCurrent+3]=this.p_help
end on

on pf_u_mdi_sheetnavi.destroy
call super::destroy
destroy(this.p_icon)
destroy(this.st_navi)
destroy(this.p_help)
end on

event destructor;call super::destructor;destroy ids_sheetdata

end event

event pfe_postopen;call super::pfe_postopen;// $$HEX18$$edd098d374c7c0c9200015c8f4bc2000f4bc00ada9c6200070b374c730d108c7c4b3b0c6$$ENDHEX$$
ids_sheetdata = create datastore
ids_sheetdata.dataobject = 'pf_d_mdi_sheetnavi_data'

end event

type p_background from pf_u_userobject`p_background within pf_u_mdi_sheetnavi
end type

type p_icon from pf_u_picture within pf_u_mdi_sheetnavi
boolean visible = false
integer x = 27
integer y = 36
integer width = 46
integer height = 36
boolean bringtotop = true
string picturename = "..\img\commonuse\nav_icon.jpg"
end type

type st_navi from pf_u_statictext within pf_u_mdi_sheetnavi
boolean visible = false
integer x = 96
integer y = 16
integer width = 3173
boolean bringtotop = true
long textcolor = 10789024
long bordercolor = 1073741824
boolean scaletoright = true
end type

type p_help from pf_u_imagebutton within pf_u_mdi_sheetnavi
boolean visible = false
integer x = 3282
integer y = 8
integer width = 302
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_thelp.gif"
boolean fixedtoright = true
end type

