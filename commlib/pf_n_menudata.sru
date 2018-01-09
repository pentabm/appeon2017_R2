HA$PBExportHeader$pf_n_menudata.sru
$PBExportComments$$$HEX36$$08c7c4b3b0c6200024c608d52000dcc2200015c8f4bc200004c8ecb2a9c63cc75cb82000acc0a9c618b494b220000cd37cb7f8bb30d1200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
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

