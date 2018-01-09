$PBExportHeader$pf_w_btn_role_ent.srw
$PBExportComments$롤 별 윈도우의 공통 버튼 권한을 일괄 등록하는 프로그램 입니다.
forward
global type pf_w_btn_role_ent from pf_w_sheet
end type
type dw_rolemst from pf_u_datawindow within pf_w_btn_role_ent
end type
type dw_rolebtn from pf_u_datawindow within pf_w_btn_role_ent
end type
type dw_rolepgm from pf_u_datawindow within pf_w_btn_role_ent
end type
type p_retrieve from pf_u_imagebutton within pf_w_btn_role_ent
end type
type cb_btnscan from pf_u_commandbutton within pf_w_btn_role_ent
end type
type p_update from pf_u_imagebutton within pf_w_btn_role_ent
end type
type p_close from pf_u_imagebutton within pf_w_btn_role_ent
end type
type st_1 from pf_u_splitbar_vertical within pf_w_btn_role_ent
end type
type p_2 from picture within pf_w_btn_role_ent
end type
type st_2 from pf_u_statictext within pf_w_btn_role_ent
end type
type p_1 from picture within pf_w_btn_role_ent
end type
type st_3 from pf_u_statictext within pf_w_btn_role_ent
end type
type p_3 from picture within pf_w_btn_role_ent
end type
type st_4 from pf_u_statictext within pf_w_btn_role_ent
end type
type cb_delbtn from pf_u_commandbutton within pf_w_btn_role_ent
end type
end forward

global type pf_w_btn_role_ent from pf_w_sheet
dw_rolemst dw_rolemst
dw_rolebtn dw_rolebtn
dw_rolepgm dw_rolepgm
p_retrieve p_retrieve
cb_btnscan cb_btnscan
p_update p_update
p_close p_close
st_1 st_1
p_2 p_2
st_2 st_2
p_1 p_1
st_3 st_3
p_3 p_3
st_4 st_4
cb_delbtn cb_delbtn
end type
global pf_w_btn_role_ent pf_w_btn_role_ent

forward prototypes
public function integer of_getbuttonlist (string as_pgm_id, ref windowobject awo_button[])
public function long of_getwindowcontrols (windowobject awo_input[], ref windowobject awo_output[])
public subroutine of_set_com_btn_auth_yn ()
end prototypes

public function integer of_getbuttonlist (string as_pgm_id, ref windowobject awo_button[]);window lw_window
lw_window = create using as_pgm_id
if isnull(lw_window) then return -1
if not isvalid(lw_window) then return -1

long i, ll_objcnt, ll_btncnt
windowobject lw_object[]
ll_objcnt = of_getwindowcontrols(lw_window.control[], lw_object[])

for i = 1 to ll_objcnt
	choose case lw_object[i].typeof()
		case commandbutton!, picturebutton!
			ll_btncnt ++
			awo_button[ll_btncnt] = lw_object[i]
		case picture!
			picture lp_object
			lp_object = lw_object[i]
			if lp_object.triggerevent('pfe_ispowerframecontrol') = 1 then
				if lp_object.dynamic of_getclassname() = 'pf_u_imagebutton' then
					ll_btncnt ++
					awo_button[ll_btncnt] = lw_object[i]
				end if
			end if
	end choose
next

return ll_btncnt

end function

public function long of_getwindowcontrols (windowobject awo_input[], ref windowobject awo_output[]);long ll_Input, ll_InputCount, ll_OutputCount, ll_Sub, ll_SubCount
userobject luo_UserObject
tab ltb_Tab
windowobject lwo_Empty[], lwo_Sub[]

awo_Output = lwo_Empty

ll_InputCount = UpperBound (awo_Input)
FOR ll_Input = 1 TO ll_InputCount
    ll_OutputCount ++
    awo_Output[ll_OutputCount] = awo_Input[ll_Input]

    CHOOSE CASE awo_Input[ll_Input].TypeOf()
        CASE UserObject!
            luo_UserObject = awo_Input[ll_Input]
            ll_SubCount = of_getwindowcontrols (luo_UserObject.Control, lwo_Sub)
            FOR ll_Sub = 1 TO ll_SubCount
                ll_OutputCount ++
                awo_Output[ll_OutputCount] = lwo_Sub[ll_Sub]
            NEXT

        CASE Tab!
            ltb_Tab = awo_Input[ll_Input]
            ll_SubCount = of_getwindowcontrols (ltb_Tab.Control, lwo_Sub)
            FOR ll_Sub = 1 TO ll_SubCount
                ll_OutputCount ++
                awo_Output[ll_OutputCount] = lwo_Sub[ll_Sub]
            NEXT
    END CHOOSE
NEXT

RETURN ll_OutputCount

end function

public subroutine of_set_com_btn_auth_yn ();// 공통버튼 사용여부(Y/N)을 설정합니다.

string ls_comm_btn_auth_yn
string ls_retrieve_auth_yn
string ls_input_auth_yn
string ls_delete_auth_yn
string ls_update_auth_yn
string ls_print_auth_yn
string ls_execute_auth_yn
string ls_cancel_auth_yn
string ls_excel_auth_yn
long ll_row

ll_row = dw_rolepgm.getrow()
if ll_row = 0 then return

ls_retrieve_auth_yn = dw_rolepgm.getitemstring(ll_row, 'retrieve_auth_yn')
ls_input_auth_yn = dw_rolepgm.getitemstring(ll_row, 'input_auth_yn')
ls_delete_auth_yn = dw_rolepgm.getitemstring(ll_row, 'delete_auth_yn')
ls_update_auth_yn = dw_rolepgm.getitemstring(ll_row, 'update_auth_yn')
ls_print_auth_yn = dw_rolepgm.getitemstring(ll_row, 'print_auth_yn')
ls_execute_auth_yn = dw_rolepgm.getitemstring(ll_row, 'execute_auth_yn')
ls_cancel_auth_yn = dw_rolepgm.getitemstring(ll_row, 'cancel_auth_yn')
ls_excel_auth_yn = dw_rolepgm.getitemstring(ll_row, 'excel_auth_yn')

if isnull(ls_retrieve_auth_yn) then ls_retrieve_auth_yn = ''
if isnull(ls_input_auth_yn) then ls_input_auth_yn = ''
if isnull(ls_delete_auth_yn) then ls_delete_auth_yn = ''
if isnull(ls_update_auth_yn) then ls_update_auth_yn = ''
if isnull(ls_print_auth_yn) then ls_print_auth_yn = ''
if isnull(ls_execute_auth_yn) then ls_execute_auth_yn = ''
if isnull(ls_cancel_auth_yn) then ls_cancel_auth_yn = ''
if isnull(ls_excel_auth_yn) then ls_excel_auth_yn = ''

if	ls_retrieve_auth_yn = 'Y' or &
	ls_input_auth_yn  = 'Y' or &
	ls_delete_auth_yn = 'Y' or &
	ls_update_auth_yn  = 'Y' or &
	ls_print_auth_yn  = 'Y' or &
	ls_execute_auth_yn  = 'Y' or &
	ls_cancel_auth_yn  = 'Y' or &
	ls_excel_auth_yn = 'Y' then
	ls_comm_btn_auth_yn = 'Y'
else
	ls_comm_btn_auth_yn = 'N'
end if

dw_rolepgm.setitem(ll_row, 'comm_btn_auth_yn', ls_comm_btn_auth_yn)

end subroutine

on pf_w_btn_role_ent.create
int iCurrent
call super::create
this.dw_rolemst=create dw_rolemst
this.dw_rolebtn=create dw_rolebtn
this.dw_rolepgm=create dw_rolepgm
this.p_retrieve=create p_retrieve
this.cb_btnscan=create cb_btnscan
this.p_update=create p_update
this.p_close=create p_close
this.st_1=create st_1
this.p_2=create p_2
this.st_2=create st_2
this.p_1=create p_1
this.st_3=create st_3
this.p_3=create p_3
this.st_4=create st_4
this.cb_delbtn=create cb_delbtn
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_rolemst
this.Control[iCurrent+2]=this.dw_rolebtn
this.Control[iCurrent+3]=this.dw_rolepgm
this.Control[iCurrent+4]=this.p_retrieve
this.Control[iCurrent+5]=this.cb_btnscan
this.Control[iCurrent+6]=this.p_update
this.Control[iCurrent+7]=this.p_close
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.p_2
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.p_1
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.p_3
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.cb_delbtn
end on

on pf_w_btn_role_ent.destroy
call super::destroy
destroy(this.dw_rolemst)
destroy(this.dw_rolebtn)
destroy(this.dw_rolepgm)
destroy(this.p_retrieve)
destroy(this.cb_btnscan)
destroy(this.p_update)
destroy(this.p_close)
destroy(this.st_1)
destroy(this.p_2)
destroy(this.st_2)
destroy(this.p_1)
destroy(this.st_3)
destroy(this.p_3)
destroy(this.st_4)
destroy(this.cb_delbtn)
end on

event pfe_postopen;call super::pfe_postopen;p_retrieve.event clicked()

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_btn_role_ent
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_btn_role_ent
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_btn_role_ent
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_btn_role_ent
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_btn_role_ent
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_btn_role_ent
end type

type dw_rolemst from pf_u_datawindow within pf_w_btn_role_ent
integer x = 50
integer y = 228
integer width = 1842
integer height = 1140
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_btn_role_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean datawindowaction = true
string retrievalarguments = "as_sys_id = session.sys_id"
end type

type dw_rolebtn from pf_u_datawindow within pf_w_btn_role_ent
integer x = 50
integer y = 1460
integer width = 1842
integer height = 760
integer taborder = 20
boolean bringtotop = true
string dataobject = "pf_d_role_mst_06"
boolean hscrollbar = true
boolean vscrollbar = true
boolean datawindowaction = true
string uplinkeddatawindow = "dw_rolepgm"
string retrievalarguments = "as_sys_id=session.sys_id; as_role_no=dw_rolepgm.role_no; as_menu_id=dw_rolepgm.menu_id"
boolean scaletobottom = true
end type

type dw_rolepgm from pf_u_datawindow within pf_w_btn_role_ent
integer x = 1920
integer y = 228
integer width = 2629
integer height = 1992
integer taborder = 10
boolean bringtotop = true
string dataobject = "pf_d_btn_role_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean datawindowaction = true
string uplinkeddatawindow = "dw_rolemst"
string retrievalarguments = "as_sys_id=session.sys_id; as_role_no=dw_rolemst.role_no"
boolean scaletoright = true
boolean scaletobottom = true
end type

event move;call super::move;// 타이틀 이동
p_3.x = this.x
st_4.x = p_3.x + p_3.width + pixelstounits(3, xpixelstounits!)

end event

event itemchanged;call super::itemchanged;choose case dwo.name
	case 'retrieve_auth_yn', 'input_auth_yn', 'delete_auth_yn', 'update_auth_yn', &
		'print_auth_yn', 'execute_auth_yn', 'cancel_auth_yn', 'excel_auth_yn'
	parent.post of_set_com_btn_auth_yn()
end choose

end event

type p_retrieve from pf_u_imagebutton within pf_w_btn_role_ent
integer x = 3831
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_retrieve.gif"
boolean fixedtoright = true
string referencedobject = "dw_rolemst"
string datawindowaction = "retrieve"
end type

event clicked;call super::clicked;//OpenWithParm(pf_w_role_mst_modify, '추가')
//if left(message.stringparm,2) = 'OK' then
//	string ls_retval, ls_parm[]
//	long ll_new
//	
//	ls_retval = mid(message.stringparm, 4)
//	pf_f_parsetoarray(ls_retval, '~t', ls_parm[])
//	
//	ll_new = dw_role_mst.insertrow(0)
//	dw_role_mst.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
//	dw_role_mst.setitem(ll_new, 'role_no', ls_parm[1])
//	dw_role_mst.setitem(ll_new, 'role_name', ls_parm[2])
//	dw_role_mst.setitem(ll_new, 'role_desc', ls_parm[3])
//	dw_role_mst.setitemstatus(ll_new, 0, primary!, notmodified!)
//	dw_role_mst.scrolltorow(ll_new)
//	dw_role_mst.setrow(ll_new)
//
//	//dw_role_mst.retrieve(gnv_session.is_sys_id)
//end if
end event

type cb_btnscan from pf_u_commandbutton within pf_w_btn_role_ent
integer x = 1111
integer y = 1372
integer width = 512
integer height = 88
integer taborder = 40
boolean bringtotop = true
string text = "프로그램 버튼스캔"
end type

event clicked;call super::clicked;long ll_row

ll_row = dw_rolepgm.getrow()
if ll_row = 0 then return -1

string ls_menu_id, ls_pgm_id
string ls_btn_id, ls_btn_name
string ls_role_no
windowobject lwo_button[]
integer i, li_btncnt
long ll_find, ll_new

ls_menu_id = dw_rolepgm.getitemstring(ll_row, 'menu_id')
if pf_f_isemptystring(ls_menu_id) = true then return -1

ls_pgm_id = dw_rolepgm.getitemstring(ll_row, 'pgm_id')
if pf_f_isemptystring(ls_pgm_id) = true then return -1

ls_role_no = dw_rolepgm.getitemstring(ll_row, 'role_no')
if pf_f_isemptystring(ls_role_no) = true then return -1

// 오브젝트 존재여부 확인
ClassDefinition lcd_dwo

lcd_dwo = FindClassDefinition(ls_pgm_id)

if isnull(lcd_dwo) then
	messagebox("Error", "[" + ls_pgm_id + "] 는 존재하지 않는 오브젝트 입니다.~r~n오브젝트 명을 다시 확인하시기 바랍니다.")
	return -1
end if

// 버튼리스트 확인
li_btncnt = of_getbuttonlist(ls_pgm_id, lwo_button)
for i = 1 to li_btncnt
	ls_btn_id = lwo_button[i].classname()
	
	ll_find = dw_rolebtn.find('btn_id="' + ls_btn_id + '"', 1, dw_rolebtn.rowcount())
	if ll_find = 0 then
		choose case lwo_button[i].typeof()
			case commandbutton!
				commandbutton lcb_button
				lcb_button = lwo_button[i]
				ls_btn_name = lcb_button.text
			case picturebutton!
				picturebutton lpb_button
				lpb_button = lwo_button[i]
				ls_btn_name = lpb_button.text
			case else
				ls_btn_name = ''
		end choose
		
		ll_new = dw_rolebtn.insertrow(0)
		
		dw_rolebtn.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
		dw_rolebtn.setitem(ll_new, 'role_no', ls_role_no)
		dw_rolebtn.setitem(ll_new, 'menu_id', ls_menu_id)
		dw_rolebtn.setitem(ll_new, 'btn_id', ls_btn_id)
		dw_rolebtn.setitem(ll_new, 'btn_use_yn', 'Y')
		dw_rolebtn.setitem(ll_new, 'btn_name', ls_btn_name)
	end if
next

// 개별버튼 사용여부 Y 처리
dw_rolepgm.setitem(ll_row, 'indiv_btn_auth_yn', 'Y')

end event

type p_update from pf_u_imagebutton within pf_w_btn_role_ent
integer x = 4073
integer y = 36
integer width = 233
integer height = 88
boolean bringtotop = true
string picturename = "..\img\controls\u_imagebutton\topBtn_save.gif"
boolean fixedtoright = true
string referencedobject = "dw_rolemst"
string datawindowaction = "update"
end type

event clicked;call super::clicked;//OpenWithParm(pf_w_role_mst_modify, '추가')
//if left(message.stringparm,2) = 'OK' then
//	string ls_retval, ls_parm[]
//	long ll_new
//	
//	ls_retval = mid(message.stringparm, 4)
//	pf_f_parsetoarray(ls_retval, '~t', ls_parm[])
//	
//	ll_new = dw_role_mst.insertrow(0)
//	dw_role_mst.setitem(ll_new, 'sys_id', gnv_session.is_sys_id)
//	dw_role_mst.setitem(ll_new, 'role_no', ls_parm[1])
//	dw_role_mst.setitem(ll_new, 'role_name', ls_parm[2])
//	dw_role_mst.setitem(ll_new, 'role_desc', ls_parm[3])
//	dw_role_mst.setitemstatus(ll_new, 0, primary!, notmodified!)
//	dw_role_mst.scrolltorow(ll_new)
//	dw_role_mst.setrow(ll_new)
//
//	//dw_role_mst.retrieve(gnv_session.is_sys_id)
//end if
end event

type p_close from pf_u_imagebutton within pf_w_btn_role_ent
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

type st_1 from pf_u_splitbar_vertical within pf_w_btn_role_ent
integer x = 1897
integer y = 224
integer height = 2008
boolean bringtotop = true
string leftdragobject = "dw_rolemst; dw_rolebtn; cb_delbtn; cb_btnscan"
string rightdragobject = "dw_rolepgm"
end type

type p_2 from picture within pf_w_btn_role_ent
integer x = 55
integer y = 1408
integer width = 46
integer height = 40
boolean bringtotop = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type st_2 from pf_u_statictext within pf_w_btn_role_ent
integer x = 123
integer y = 1404
integer width = 594
integer height = 48
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = hangeul!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "개별 버튼 권한"
end type

type p_1 from picture within pf_w_btn_role_ent
integer x = 55
integer y = 172
integer width = 46
integer height = 40
boolean bringtotop = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type st_3 from pf_u_statictext within pf_w_btn_role_ent
integer x = 123
integer y = 168
integer width = 553
integer height = 48
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = hangeul!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "권한 리스트"
end type

type p_3 from picture within pf_w_btn_role_ent
integer x = 1920
integer y = 172
integer width = 46
integer height = 40
boolean bringtotop = true
string picturename = "..\img\commonuse\front_title_img.gif"
boolean focusrectangle = false
end type

type st_4 from pf_u_statictext within pf_w_btn_role_ent
integer x = 1989
integer y = 168
integer width = 553
integer height = 48
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = hangeul!
string facename = "돋움"
long textcolor = 25123896
long backcolor = 16777215
string text = "공통 버튼 권한"
end type

type cb_delbtn from pf_u_commandbutton within pf_w_btn_role_ent
integer x = 1627
integer y = 1372
integer width = 265
integer height = 88
integer taborder = 50
boolean bringtotop = true
string text = "행삭제"
end type

event clicked;call super::clicked;dw_rolebtn.deleterow(0)

// 개별버튼 사용여부 N 처리
long ll_row
ll_row = dw_rolepgm.getrow()
if ll_row = 0 then return

if dw_rolebtn.rowcount() = 0 then
	dw_rolepgm.setitem(ll_row, 'indiv_btn_auth_yn', 'N')
end if

end event

