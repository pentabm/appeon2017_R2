HA$PBExportHeader$pf_n_nonvisualobject.sru
$PBExportComments$$$HEX6$$0cd3ccc604d508b884c72000$$ENDHEX$$NVO $$HEX17$$58c720005ccdc1c004c7200070c8c1c0200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$. $$HEX9$$a8bae0b420000cd3ccc604d508b884c72000$$ENDHEX$$NVO $$HEX18$$e4b440c7200074c7200024c60cbe1dc8b8d27cb92000c1c08dc120001bbcb5c2c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_nonvisualobject from nonvisualobject
end type
end forward

global type pf_n_nonvisualobject from nonvisualobject
end type
global pf_n_nonvisualobject pf_n_nonvisualobject

type variables
// $$HEX9$$f5acb5d12000acb934d112ac2000c1c018c2$$ENDHEX$$
constant integer SUCCESS = 1
constant integer FAILURE = -1
constant integer NO_ACTION = 0

// $$HEX2$$c4ac8dc1$$ENDHEX$$/$$HEX9$$11c9c0c92000acb934d112ac2000c1c018c2$$ENDHEX$$
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

