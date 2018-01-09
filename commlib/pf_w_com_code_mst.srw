HA$PBExportHeader$pf_w_com_code_mst.srw
forward
global type pf_w_com_code_mst from pf_w_sheet
end type
type dw_1 from pf_u_datawindow within pf_w_com_code_mst
end type
type dw_detail from pf_u_datawindow within pf_w_com_code_mst
end type
type dw_list from pf_u_datawindow within pf_w_com_code_mst
end type
type tv_code from pf_u_treeview within pf_w_com_code_mst
end type
type st_1 from statictext within pf_w_com_code_mst
end type
type p_2 from picture within pf_w_com_code_mst
end type
type cb_4 from pf_u_commandbutton within pf_w_com_code_mst
end type
type cb_5 from pf_u_commandbutton within pf_w_com_code_mst
end type
type p_1 from picture within pf_w_com_code_mst
end type
type st_2 from statictext within pf_w_com_code_mst
end type
type p_search from pf_u_imagebutton within pf_w_com_code_mst
end type
type p_insert from pf_u_imagebutton within pf_w_com_code_mst
end type
type p_delete from pf_u_imagebutton within pf_w_com_code_mst
end type
type p_save from pf_u_imagebutton within pf_w_com_code_mst
end type
type p_close from pf_u_imagebutton within pf_w_com_code_mst
end type
end forward

global type pf_w_com_code_mst from pf_w_sheet
dw_1 dw_1
dw_detail dw_detail
dw_list dw_list
tv_code tv_code
st_1 st_1
p_2 p_2
cb_4 cb_4
cb_5 cb_5
p_1 p_1
st_2 st_2
p_search p_search
p_insert p_insert
p_delete p_delete
p_save p_save
p_close p_close
end type
global pf_w_com_code_mst pf_w_com_code_mst

type variables
datastore ids_code
long il_parent, il_current
treeviewitem itvi_item, itvi_parent

end variables

forward prototypes
public function integer of_setcodetree ()
end prototypes

public function integer of_setcodetree ();long ll_rowcnt, ll_child_cnt
long ll_handle, ll_roothndl, i
treeviewitem ltvi_item

tv_code.setredraw(false)

ll_handle = tv_code.finditem(roottreeitem!, 0)
do while ll_handle > 0
	tv_code.deleteitem(ll_handle)
	ll_handle = tv_code.finditem(roottreeitem!, ll_handle)
loop

ll_rowcnt = ids_code.retrieve(gnv_session.is_sys_id, 'ROOT')

for i = 1 to ll_rowcnt
	ltvi_item.data = ids_code.getitemstring(i, 'code_id')
	ltvi_item.label = ids_code.getitemstring(i, 'code_name') + ' [' + ltvi_item.data + ']'
	ll_child_cnt = ids_code.getitemnumber(i, 'child_cnt')
	if ll_child_cnt > 0 then
		ltvi_item.PictureIndex = 3
		ltvi_item.SelectedPictureIndex = 4
		ltvi_item.Children = true
	else
		ltvi_item.PictureIndex = 1
		ltvi_item.SelectedPictureIndex = 2
		ltvi_item.Children = false
	end if
	
	ll_handle = tv_code.InsertItemLast(0, ltvi_item)
next

ll_handle = tv_code.finditem(roottreeitem!, 0)
ll_roothndl = ll_handle
do while ll_handle > 0
	tv_code.expandall(ll_handle)
	ll_handle = tv_code.finditem(NextTreeItem!, ll_handle)
loop

// scroll back to top
tv_code.SetFirstVisible(ll_roothndl)

// select first treeviewitem
tv_code.post selectitem(ll_roothndl)

tv_code.setredraw(true)
return ll_rowcnt

end function

on pf_w_com_code_mst.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_detail=create dw_detail
this.dw_list=create dw_list
this.tv_code=create tv_code
this.st_1=create st_1
this.p_2=create p_2
this.cb_4=create cb_4
this.cb_5=create cb_5
this.p_1=create p_1
this.st_2=create st_2
this.p_search=create p_search
this.p_insert=create p_insert
this.p_delete=create p_delete
this.p_save=create p_save
this.p_close=create p_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_detail
this.Control[iCurrent+3]=this.dw_list
this.Control[iCurrent+4]=this.tv_code
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.p_2
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.cb_5
this.Control[iCurrent+9]=this.p_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.p_search
this.Control[iCurrent+12]=this.p_insert
this.Control[iCurrent+13]=this.p_delete
this.Control[iCurrent+14]=this.p_save
this.Control[iCurrent+15]=this.p_close
end on

on pf_w_com_code_mst.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_detail)
destroy(this.dw_list)
destroy(this.tv_code)
destroy(this.st_1)
destroy(this.p_2)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.p_search)
destroy(this.p_insert)
destroy(this.p_delete)
destroy(this.p_save)
destroy(this.p_close)
end on

event pfe_postopen;call super::pfe_postopen;dw_1.insertrow(0)

p_search.event clicked()

end event

event open;call super::open;ids_code = create datastore
ids_code.dataobject = 'pf_d_com_code_mst_02'
ids_code.settransobject(sqlca)

dw_detail.settransobject(sqlca)
dw_list.settransobject(sqlca)

end event

event close;call super::close;if isvalid(ids_code) then
	destroy ids_code
end if

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_com_code_mst
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_com_code_mst
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_com_code_mst
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_com_code_mst
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_com_code_mst
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_com_code_mst
end type

type dw_1 from pf_u_datawindow within pf_w_com_code_mst
integer x = 37
integer y = 164
integer width = 1417
integer height = 164
integer taborder = 90
boolean bringtotop = true
string dataobject = "pf_d_com_code_mst_01"
boolean issearchcondition = true
string defaultvaluesoninsertrow = "sys_id=session.sys_id"
end type

type dw_detail from pf_u_datawindow within pf_w_com_code_mst
integer x = 1477
integer y = 232
integer width = 3072
integer height = 1116
integer taborder = 110
boolean bringtotop = true
string dataobject = "pf_d_com_code_mst_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean scaletoright = true
end type

event doubleclicked;call super::doubleclicked;if string(dwo.name) = 'ext_attr1' then
	pf_f_setcalendardate_dw(this, dwo, row)
end if

end event

type dw_list from pf_u_datawindow within pf_w_com_code_mst
integer x = 1477
integer y = 1468
integer width = 3072
integer height = 752
integer taborder = 100
boolean bringtotop = true
string dataobject = "pf_d_com_code_mst_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean scaletoright = true
boolean scaletobottom = true
end type

type tv_code from pf_u_treeview within pf_w_com_code_mst
integer x = 37
integer y = 348
integer width = 1417
integer height = 1872
integer taborder = 110
boolean dragauto = true
boolean bringtotop = true
long textcolor = 22040656
boolean linesatroot = true
boolean disabledragdrop = false
string picturename[] = {"ScriptYes!","ScriptNo!","Custom039!","Open!"}
long picturemaskcolor = 12632256
boolean scaletobottom = true
end type

event itemexpanding;call super::itemexpanding;treeviewitem ltvi_item
string ls_code
long ll_rowcnt, ll_child_cnt, ll_child, i

this.getitem(handle, ltvi_item)
if ltvi_item.ExpandedOnce then return 0
if this.finditem(ChildTreeItem!, handle) > 0 then return 0

ls_code = ltvi_item.data
ll_rowcnt = ids_code.retrieve(gnv_session.is_sys_id, ls_code)
for i = 1 to ll_rowcnt
	ltvi_item.data = ids_code.getitemstring(i, 'code_id')
	ltvi_item.label = ids_code.getitemstring(i, 'code_name') + ' [' + ltvi_item.data + ']'
	
	ll_child_cnt = ids_code.getitemnumber(i, 'child_cnt')
	if ll_child_cnt > 0 then
		ltvi_item.PictureIndex = 3
		ltvi_item.SelectedPictureIndex = 4
		ltvi_item.Children = true
	else
		ltvi_item.PictureIndex = 1
		ltvi_item.SelectedPictureIndex = 2
		ltvi_item.Children = false
	end if
	
	ltvi_item.HasFocus = false
	ltvi_item.selected = false
	
	ll_child = this.InsertItemLast(handle, ltvi_item)
next

return 0

end event

event selectionchanged;call super::selectionchanged;//

treeviewitem ltvi_item, ltvi_upper
string ls_code, ls_upper_code

if this.getitem(newhandle, ltvi_item) = -1 then return -1
ls_code = ltvi_item.data

il_current = newhandle
this.getitem(il_current, itvi_item)

il_parent = tv_code.finditem(ParentTreeItem!, il_current)
if il_parent = -1 then
	ls_upper_code = 'ROOT'
else
	this.getitem(il_parent, ltvi_upper)
	ls_upper_code = ltvi_upper.data
end if

dw_detail.retrieve(gnv_session.is_sys_id, ls_upper_code, ls_code)

if ltvi_item.children = true then
	dw_list.visible = true
	dw_list.retrieve(gnv_session.is_sys_id, ls_code)
else
	dw_list.visible = false
	dw_list.reset()
end if

end event

type st_1 from statictext within pf_w_com_code_mst
integer x = 1536
integer y = 1392
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "$$HEX4$$58d504c76dd5a9ba$$ENDHEX$$"
boolean focusrectangle = false
end type

type p_2 from picture within pf_w_com_code_mst
integer x = 1477
integer y = 1408
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type cb_4 from pf_u_commandbutton within pf_w_com_code_mst
integer x = 3744
integer y = 1360
integer height = 104
integer taborder = 120
boolean bringtotop = true
string text = "$$HEX3$$89d594cd00ac$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;long ll_new
string ls_upper_code_id

if dw_detail.getrow() = 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX20$$3cba00c8200089d5200094cd00ac60d52000c1c004c754cfdcb47cb9200020c1ddd058d538c194c6$$ENDHEX$$')
	return
end if

if dw_list.visible = false then
	dw_list.visible = true
end if

// $$HEX9$$c1c004c754cfdcb4200000ac38c824c630ae$$ENDHEX$$
ls_upper_code_id = dw_detail.getitemstring(1, 'code_id')

ll_new = dw_list.insertrow(0)
dw_list.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
dw_list.setitem(ll_new, 'upper_code_id', ls_upper_code_id)
dw_list.setitemstatus(ll_new, 'upper_code_id', primary!, notmodified!)

dw_list.scrolltorow(ll_new)
dw_list.setrow(ll_new)

end event

type cb_5 from pf_u_commandbutton within pf_w_com_code_mst
integer x = 4151
integer y = 1360
integer height = 104
integer taborder = 130
boolean bringtotop = true
string text = "$$HEX3$$89d5adc01cc8$$ENDHEX$$"
boolean fixedtoright = true
end type

event clicked;call super::clicked;dw_list.deleterow(0)

end event

type p_1 from picture within pf_w_com_code_mst
integer x = 1477
integer y = 180
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type st_2 from statictext within pf_w_com_code_mst
integer x = 1536
integer y = 164
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "$$HEX4$$04d6acc76dd5a9ba$$ENDHEX$$"
boolean focusrectangle = false
end type

type p_search from pf_u_imagebutton within pf_w_com_code_mst
integer x = 3346
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_search.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;tv_code.setredraw(false)
parent.of_setcodetree()
tv_code.setredraw(true)

end event

type p_insert from pf_u_imagebutton within pf_w_com_code_mst
integer x = 3589
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\controls\u_imagebutton\topBtn_add.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;// $$HEX4$$6dd5a9ba94cd00ac$$ENDHEX$$
if il_current = 0 then 
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX25$$6dd5a9ba44c7200094cd00ac60d5200080bda8ba200054cfdcb400ac200020c1ddd018b4c0c920004ac558c5b5c2c8b2e4b2$$ENDHEX$$')
	return 0
end if

treeviewitem ltvi_current
if tv_code.getitem(il_current, ltvi_current) = -1 then return

dw_detail.reset()
dw_detail.insertrow(0)
dw_detail.setitem(1, 'sys_id', gnv_session.is_sys_id)
dw_detail.setitem(1, 'upper_code_id', string(ltvi_current.data))
dw_detail.setitemstatus(1, 'sys_id', primary!, notmodified!)

dw_list.reset()

end event

type p_delete from pf_u_imagebutton within pf_w_com_code_mst
integer x = 3831
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_delete.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;if dw_list.rowcount() > 0 then
	messagebox('$$HEX2$$4cc5bcb9$$ENDHEX$$', '$$HEX26$$58d504c720006dd5a9ba74c7200074c8acc758d530ae20004cb538bbd0c52000adc01cc860d5200018c22000c6c5b5c2c8b2e4b2$$ENDHEX$$~r~n$$HEX16$$3cba00c8200058d504c720006dd5a9ba44c72000adc01cc8200058d538c194c6$$ENDHEX$$')
	return 0
end if

dw_detail.deleterow(0)

end event

type p_save from pf_u_imagebutton within pf_w_com_code_mst
integer x = 4073
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;dw_detail.update()
dw_list.update()

commit;

end event

type p_close from pf_u_imagebutton within pf_w_com_code_mst
integer x = 4315
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_close.gif"
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)

end event

