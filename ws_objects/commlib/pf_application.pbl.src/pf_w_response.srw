$PBExportHeader$pf_w_response.srw
$PBExportComments$파워프레임 Response 윈도우의 최상위 조상 오브젝트 입니다. 모든 파워프레임 Response 윈도우들은 이 오브젝트를 상속 받습니다.
forward
global type pf_w_response from pf_w_window
end type
end forward

global type pf_w_response from pf_w_window
integer width = 3008
integer height = 1580
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global pf_w_response pf_w_response

forward prototypes
public function string of_getclassname ()
end prototypes

public function string of_getclassname ();return 'pf_w_response'

end function

on pf_w_response.create
call super::create
end on

on pf_w_response.destroy
call super::destroy
end on

type ln_templeft from pf_w_window`ln_templeft within pf_w_response
end type

type ln_tempright from pf_w_window`ln_tempright within pf_w_response
end type

type ln_temptop from pf_w_window`ln_temptop within pf_w_response
end type

type ln_tempbuttom from pf_w_window`ln_tempbuttom within pf_w_response
end type

type ln_tempbutton from pf_w_window`ln_tempbutton within pf_w_response
end type

type ln_tempstart from pf_w_window`ln_tempstart within pf_w_response
end type

