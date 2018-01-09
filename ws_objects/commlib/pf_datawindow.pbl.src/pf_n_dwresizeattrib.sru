$PBExportHeader$pf_n_dwresizeattrib.sru
$PBExportComments$Datawindow 리사이즈 서비스 Attribute 용 오브젝트 입니다.
forward
global type pf_n_dwresizeattrib from nonvisualobject
end type
end forward

global type pf_n_dwresizeattrib from nonvisualobject autoinstantiate
end type

type variables
Public:
string		s_control
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
integer		i_movex
integer		i_movey
integer		i_scalewidth
integer		i_scaleheight
end variables

on pf_n_dwresizeattrib.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pf_n_dwresizeattrib.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

