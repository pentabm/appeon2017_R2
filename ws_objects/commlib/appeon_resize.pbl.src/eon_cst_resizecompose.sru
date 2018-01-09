$PBExportHeader$eon_cst_resizecompose.sru
forward
global type eon_cst_resizecompose from nonvisualobject
end type
end forward

global type eon_cst_resizecompose from nonvisualobject autoinstantiate
event type integer pfc_resize ( unsignedlong aul_sizetype,  integer ai_newwidth,  integer ai_newheight )
end type

type variables
eon_cst_resize inv_winResize
eon_cst_resize inv_userObjResize[]
window  iw_parent
long il_parentheight,il_parentwidth
long il_tabheight[],il_tabwidth[]
long il_uoheight,il_uowidth
long il_lastheight,il_lastwidth
boolean ib_restore
boolean ib_init
boolean  ib_zoom
double id_factor_window,id_factor_tab[],id_factor_uo
end variables

forward prototypes
public function integer of_register (dragobject a_obj, string as_method)
public function integer of_init (window a_obj)
public function integer of_register (userobject a_component, dragobject a_obj, string as_method)
public subroutine of_zoom (boolean ab_zoom)
end prototypes

event type integer pfc_resize(unsignedlong aul_sizetype, integer ai_newwidth, integer ai_newheight);int i, j,k, li_idx, li_width, li_height,li_count,ll_file
tab ltb_obj
userobject luo_obj
datawindow ldw_tmp
if not ib_init then return 0
inv_winResize.event pfc_resize( aul_sizeType, ai_newwidth, ai_newheight)
for i = 1 to upperBound(inv_userObjResize)
	for j = 1 to upperBound(inv_winResize.i_tabIdx)
		li_idx = inv_winResize.i_tabIdx[j]
		//<Modified AT  2016-06-27>
		choose case inv_userObjResize[i].ipo_component.getParent().typeof()
			case tab!
		if inv_winResize.inv_registered[li_idx].s_classname = inv_userObjResize[i].ipo_component.getParent().className() then
					ltb_obj = inv_userObjResize[i].ipo_component.getParent()
					luo_obj = inv_userObjResize[i].ipo_component
					if il_tabwidth[i] = 0 then
						il_tabwidth[i] = ltb_obj.width
						il_tabheight[i] = ltb_obj.height
					end if
			li_width = inv_winResize.inv_registered[li_idx].i_tabWidth
			li_height = inv_winResize.inv_registered[li_idx].i_tabHeight
			inv_userObjResize[i].event pfc_resize(aul_sizeType, li_width, li_height)
					if ib_zoom then
						id_factor_tab[i] = max(li_width/il_tabwidth[i],li_height/il_tabheight[i])
						for li_count = 1 to upperbound(luo_obj.control)
							if luo_obj.control[li_count].typeof() = datawindow! then
								ldw_tmp = luo_obj.control[li_count]
								if isvalid(ldw_tmp.object) then
									ldw_tmp.object.datawindow.zoom = string(integer(id_factor_tab[i]*100))
		end if
							end if
						next
					end if
		//			il_tabwidth[i] = li_width
		//			il_tabheight[i] = li_height
				end if
			case window!
				if inv_winResize.inv_registered[li_idx].s_classname = inv_userObjResize[i].ipo_component.className() then
					luo_obj = inv_userObjResize[i].ipo_component
					if il_tabwidth[i] = 0 then
						il_tabwidth[i] = luo_obj.width
						il_tabheight[i] = luo_obj.height
					end if
					li_width = inv_winResize.inv_registered[li_idx].i_uoWidth
					li_height = inv_winResize.inv_registered[li_idx].i_uoHeight
					inv_userObjResize[i].event pfc_resize(aul_sizeType, li_width, li_height)
					if ib_zoom then
						id_factor_tab[i] = max(li_width/il_tabwidth[i],li_height/il_tabheight[i])
						for li_count = 1 to upperbound(luo_obj.control)
							if luo_obj.control[li_count].typeof() = datawindow! then
								ldw_tmp = luo_obj.control[li_count]
								if isvalid(ldw_tmp.object) then
									ldw_tmp.object.datawindow.zoom = string(integer(id_factor_tab[i]*100))
								end if
							end if
						next
					end if
		//			il_tabwidth[i] = li_width
		//			il_tabheight[i] = li_height
				end if
		end choose
	next
next
//<Added AT 2014-06-27>
if ib_zoom then
	if ib_restore then
		ib_restore = False
		il_parentwidth = il_lastwidth
		il_parentheight = il_lastheight
	end if
	if aul_sizetype = 2 then
		ib_restore = True
		il_lastwidth = il_parentwidth
		il_lastheight = il_parentheight
	end if
	id_factor_window = max(ai_newwidth/il_parentwidth,ai_newheight/il_parentheight)
	for k = 1 to upperbound(iw_parent.control)
		if iw_parent.control[k].typeof() = datawindow! then
			ldw_tmp = iw_parent.control[k]
			if isvalid(ldw_tmp.object) then
				ldw_tmp.object.datawindow.zoom = string(integer(id_factor_window*100))
			end if
		end if
	next
end if
//il_parentwidth = ai_newwidth
//il_parentheight = ai_newheight
return 1
end event

public function integer of_register (dragobject a_obj, string as_method);
return inv_winResize.of_register( a_obj, as_method)
end function

public function integer of_init (window a_obj);
int i, j, li_idx
tab ltb_obj
userobject luo_obj
inv_winResize.of_init(a_obj)
//---init parameter-----------
il_parentwidth = a_obj.width
il_parentheight = a_obj.height
il_lastwidth = a_obj.width
il_lastheight = a_obj.height
iw_parent = a_obj
ib_restore = false
for i = 1 to upperBound(a_obj.control)
	choose case a_obj.control[i].typeOf()
		case tab!
			ltb_obj = a_obj.control[i]
			for j = 1 to upperBound(ltb_obj.control)
				li_idx = upperBound(inv_userObjResize) + 1
				inv_userObjResize[li_idx].of_init(ltb_obj.control[j]) 
			//	ltb_obj.selecttab(j)
			next
		//	ltb_obj.selecttab(1)
		//<Modified AT 2014-06-27>	
		case userobject!
			luo_obj = a_obj.control[i]
			li_idx = upperBound(inv_userObjResize) + 1
			inv_userObjResize[li_idx].of_init(luo_obj)
	end choose
next
il_tabheight[upperbound(inv_userobjresize)+1] = 0
il_tabwidth[upperbound(inv_userobjresize)+1] = 0
id_factor_tab[upperbound(inv_userobjresize)+1] = 0
ib_init = true
return 1
end function

public function integer of_register (userobject a_component, dragobject a_obj, string as_method);
int i
for i = 1 to upperBound(inv_userObjResize)
	if inv_userObjResize[i].of_getComponentName() = a_component.className() then
		inv_userObjResize[i].of_register(a_obj, as_method)
	end if
next
return 1
end function

public subroutine of_zoom (boolean ab_zoom);ib_zoom = ab_zoom
end subroutine

on eon_cst_resizecompose.create
call super::create
TriggerEvent( this, "constructor" )
end on

on eon_cst_resizecompose.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

