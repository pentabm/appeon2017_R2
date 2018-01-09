$PBExportHeader$pf_n_menudata.sru
$PBExportComments$윈도우 오픈 시 정보 전달용으로 사용되는 파라미터 오브젝트 입니다.
forward
global type pf_n_menudata from nonvisualobject
end type
end forward

global type pf_n_menudata from nonvisualobject
end type
global pf_n_menudata pf_n_menudata

type variables
public:
	string is_menu_id
	string is_pgm_id
	string is_pgm_name

end variables

on pf_n_menudata.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pf_n_menudata.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

