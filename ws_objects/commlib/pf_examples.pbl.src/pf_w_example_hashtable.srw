$PBExportHeader$pf_w_example_hashtable.srw
forward
global type pf_w_example_hashtable from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_hashtable
end type
type st_4 from statictext within pf_w_example_hashtable
end type
type st_1 from statictext within pf_w_example_hashtable
end type
type dw_keylist from pf_u_datawindow within pf_w_example_hashtable
end type
type st_2 from statictext within pf_w_example_hashtable
end type
type cb_put from commandbutton within pf_w_example_hashtable
end type
type cb_1 from commandbutton within pf_w_example_hashtable
end type
type st_3 from statictext within pf_w_example_hashtable
end type
type sle_key from singlelineedit within pf_w_example_hashtable
end type
type st_5 from statictext within pf_w_example_hashtable
end type
type sle_value from singlelineedit within pf_w_example_hashtable
end type
type st_6 from statictext within pf_w_example_hashtable
end type
type sle_key4get from singlelineedit within pf_w_example_hashtable
end type
type cb_2 from commandbutton within pf_w_example_hashtable
end type
type cb_3 from commandbutton within pf_w_example_hashtable
end type
type cbx_sorted from checkbox within pf_w_example_hashtable
end type
type rr_1 from roundrectangle within pf_w_example_hashtable
end type
type rr_2 from roundrectangle within pf_w_example_hashtable
end type
end forward

global type pf_w_example_hashtable from pf_w_sheet
string title = "해시테이블 샘플 윈도우"
cb_close cb_close
st_4 st_4
st_1 st_1
dw_keylist dw_keylist
st_2 st_2
cb_put cb_put
cb_1 cb_1
st_3 st_3
sle_key sle_key
st_5 st_5
sle_value sle_value
st_6 st_6
sle_key4get sle_key4get
cb_2 cb_2
cb_3 cb_3
cbx_sorted cbx_sorted
rr_1 rr_1
rr_2 rr_2
end type
global pf_w_example_hashtable pf_w_example_hashtable

type variables
public:
	pf_n_hashtable inv_hash

end variables

forward prototypes
public subroutine of_refreshkeylist ()
end prototypes

public subroutine of_refreshkeylist ();string ls_keyset[]
long ll_keycnt, i

dw_keylist.reset()

if cbx_sorted.checked then
	ll_keycnt = inv_hash.of_sortedkeyset(ls_keyset)
else
	ll_keycnt = inv_hash.of_keyset(ls_keyset)
end if

for i = 1 to ll_keycnt
	dw_keylist.insertrow(i)
	dw_keylist.setitem(i, 'keyname', ls_keyset[i])
next

end subroutine

on pf_w_example_hashtable.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.st_4=create st_4
this.st_1=create st_1
this.dw_keylist=create dw_keylist
this.st_2=create st_2
this.cb_put=create cb_put
this.cb_1=create cb_1
this.st_3=create st_3
this.sle_key=create sle_key
this.st_5=create st_5
this.sle_value=create sle_value
this.st_6=create st_6
this.sle_key4get=create sle_key4get
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cbx_sorted=create cbx_sorted
this.rr_1=create rr_1
this.rr_2=create rr_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_keylist
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_put
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.sle_key
this.Control[iCurrent+10]=this.st_5
this.Control[iCurrent+11]=this.sle_value
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.sle_key4get
this.Control[iCurrent+14]=this.cb_2
this.Control[iCurrent+15]=this.cb_3
this.Control[iCurrent+16]=this.cbx_sorted
this.Control[iCurrent+17]=this.rr_1
this.Control[iCurrent+18]=this.rr_2
end on

on pf_w_example_hashtable.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.dw_keylist)
destroy(this.st_2)
destroy(this.cb_put)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.sle_key)
destroy(this.st_5)
destroy(this.sle_value)
destroy(this.st_6)
destroy(this.sle_key4get)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cbx_sorted)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event pfe_postopen;call super::pfe_postopen;inv_hash = create pf_n_hashtable

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_hashtable
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_hashtable
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_hashtable
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_hashtable
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_hashtable
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_hashtable
end type

type cb_close from pf_u_commandbutton within pf_w_example_hashtable
integer x = 4279
integer y = 32
integer width = 274
integer height = 96
boolean bringtotop = true
fontcharset fontcharset = hangeul!
string text = "닫기"
string powertiptext = "해당 화면을 닫습니다."
boolean applydesign = false
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)
end event

type st_4 from statictext within pf_w_example_hashtable
integer x = 389
integer y = 388
integer width = 581
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "HashTable - PUT"
boolean focusrectangle = false
end type

type st_1 from statictext within pf_w_example_hashtable
integer x = 3191
integer y = 388
integer width = 581
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "HashTable - GET"
boolean focusrectangle = false
end type

type dw_keylist from pf_u_datawindow within pf_w_example_hashtable
integer x = 1751
integer y = 480
integer width = 1083
integer height = 1356
integer taborder = 60
boolean bringtotop = true
string dataobject = "pf_d_example_hashtable_01"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;if currentrow = 0 then return

sle_key4get.text = this.getitemstring(currentrow, 'keyname')

end event

type st_2 from statictext within pf_w_example_hashtable
integer x = 1751
integer y = 396
integer width = 635
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "▶ HashTable Key List"
boolean focusrectangle = false
end type

type cb_put from commandbutton within pf_w_example_hashtable
integer x = 402
integer y = 796
integer width = 457
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "Put"
end type

event clicked;string ls_key, ls_value

ls_key = sle_key.text
ls_value = sle_value.text

if pf_f_isemptystring(ls_key) then
	messagebox('알림', 'Key 항목을 입력하세요')
	return
end if

if pf_f_isemptystring(ls_value) then
	messagebox('알림', 'Value 항목을 입력하세요')
	return
end if

inv_hash.of_put(ls_key, ls_value)
of_refreshkeylist()

end event

type cb_1 from commandbutton within pf_w_example_hashtable
integer x = 3205
integer y = 672
integer width = 457
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "Get"
end type

event clicked;string ls_key, ls_value

ls_key = sle_key4get.text
if pf_f_isemptystring(ls_key) then
	messagebox('알림', 'Hash테이블에서 값을 가져올 키 항목을 입력하세요')
	return
end if

ls_value = inv_hash.of_getstring(ls_key)
messagebox('Returned value is...', 'Key=' + ls_key + '~r~nValue=' + ls_value)

end event

type st_3 from statictext within pf_w_example_hashtable
integer x = 402
integer y = 560
integer width = 210
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "Key"
boolean focusrectangle = false
end type

type sle_key from singlelineedit within pf_w_example_hashtable
integer x = 613
integer y = 544
integer width = 599
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
end type

type st_5 from statictext within pf_w_example_hashtable
integer x = 402
integer y = 684
integer width = 210
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "Value"
boolean focusrectangle = false
end type

type sle_value from singlelineedit within pf_w_example_hashtable
integer x = 613
integer y = 668
integer width = 859
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
end type

type st_6 from statictext within pf_w_example_hashtable
integer x = 3205
integer y = 560
integer width = 210
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "Key"
boolean focusrectangle = false
end type

type sle_key4get from singlelineedit within pf_w_example_hashtable
integer x = 3415
integer y = 544
integer width = 599
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
end type

type cb_2 from commandbutton within pf_w_example_hashtable
integer x = 1751
integer y = 1848
integer width = 457
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "Remove"
end type

event clicked;string ls_key
long ll_row

ll_row = dw_keylist.getrow()
if ll_row = 0 then
	messagebox('알림', 'Remove 처리할 KeyName 을 선택하세요')
	return
end if

ls_key = dw_keylist.getitemstring(ll_row, 'keyname')
inv_hash.of_remove(ls_key)
of_refreshkeylist()

end event

type cb_3 from commandbutton within pf_w_example_hashtable
integer x = 2217
integer y = 1848
integer width = 457
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "Clear"
end type

event clicked;inv_hash.of_clear()
of_refreshkeylist()

end event

type cbx_sorted from checkbox within pf_w_example_hashtable
integer x = 2555
integer y = 388
integer width = 288
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "sorted"
end type

event clicked;of_refreshkeylist()

end event

type rr_1 from roundrectangle within pf_w_example_hashtable
long linecolor = 67108864
integer linethickness = 4
long fillcolor = 1073741824
integer x = 238
integer y = 324
integer width = 1362
integer height = 684
integer cornerheight = 40
integer cornerwidth = 55
end type

type rr_2 from roundrectangle within pf_w_example_hashtable
long linecolor = 67108864
integer linethickness = 4
long fillcolor = 1073741824
integer x = 2994
integer y = 324
integer width = 1362
integer height = 684
integer cornerheight = 40
integer cornerwidth = 55
end type

