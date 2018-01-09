$PBExportHeader$eon_cst_resizeattrib.sru
$PBExportComments$PFC Resize attributes
forward
global type eon_cst_resizeattrib from nonvisualobject
end type
end forward

global type eon_cst_resizeattrib from nonvisualobject autoinstantiate
end type

type variables
Public:
graphicobject		wo_control
string		s_classname
string		s_typeof
boolean		b_scale
boolean		b_movex
boolean		b_movey
boolean		b_scalewidth
boolean		b_scaleheight
real		r_x
real		r_y
real		r_width
real		r_height
integer		i_widthmin
integer		i_heightmin
integer		i_movex
integer		i_movey
integer		i_scalewidth
integer		i_scaleheight
integer i_origX
integer i_origY
integer i_origWidth
integer i_origHeight
boolean b_sizable
integer i_prevX
integer i_prevY
integer i_prevWidth
integer i_prevHeight
integer i_tabWidth
integer i_tabHeight
integer i_uowidth
integer i_uoheight
end variables

on eon_cst_resizeattrib.create
call super::create
TriggerEvent( this, "constructor" )
end on

on eon_cst_resizeattrib.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

