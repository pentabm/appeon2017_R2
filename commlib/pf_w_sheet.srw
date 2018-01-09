HA$PBExportHeader$pf_w_sheet.srw
$PBExportComments$$$HEX6$$0cd3ccc604d508b884c72000$$ENDHEX$$Sheet $$HEX20$$08c7c4b3b0c658c720005ccdc1c004c7200070c8c1c0200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$. $$HEX9$$a8bae0b420000cd3ccc604d508b884c72000$$ENDHEX$$Sheet $$HEX21$$08c7c4b3b0c6e4b440c7200074c7200024c60cbe1dc8b8d27cb92000c1c08dc120001bbcb5c2c8b2e4b2$$ENDHEX$$.
forward
global type pf_w_sheet from pf_w_window
end type
end forward

global type pf_w_sheet from pf_w_window
boolean controlmenu = false
windowstate windowstate = maximized!
end type
global pf_w_sheet pf_w_sheet

forward prototypes
public function string of_getclassname ()
end prototypes

public function string of_getclassname ();return 'pf_w_sheet'

end function

on pf_w_sheet.create
call super::create
end on

on pf_w_sheet.destroy
call super::destroy
end on

type ln_templeft from pf_w_window`ln_templeft within pf_w_sheet
end type

type ln_tempright from pf_w_window`ln_tempright within pf_w_sheet
end type

type ln_temptop from pf_w_window`ln_temptop within pf_w_sheet
end type

type ln_tempbuttom from pf_w_window`ln_tempbuttom within pf_w_sheet
end type

type ln_tempbutton from pf_w_window`ln_tempbutton within pf_w_sheet
end type

type ln_tempstart from pf_w_window`ln_tempstart within pf_w_sheet
end type

