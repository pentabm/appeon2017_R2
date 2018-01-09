$PBExportHeader$pf_n_nonvisualobject.sru
$PBExportComments$파워프레임 NVO 의 최상위 조상 오브젝트 입니다. 모든 파워프레임 NVO 들은 이 오브젝트를 상속 받습니다.
forward
global type pf_n_nonvisualobject from nonvisualobject
end type
end forward

global type pf_n_nonvisualobject from nonvisualobject
end type
global pf_n_nonvisualobject pf_n_nonvisualobject

type variables
// 공통 리턴값 상수
constant integer SUCCESS = 1
constant integer FAILURE = -1
constant integer NO_ACTION = 0

// 계속/중지 리턴값 상수
constant integer CONTINUE_ACTION = 1
constant integer PREVENT_ACTION = 0

end variables

forward prototypes
public function string of_getclassname ()
end prototypes

public function string of_getclassname ();return 'pf_n_nonvisualobject'

end function

on pf_n_nonvisualobject.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pf_n_nonvisualobject.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

