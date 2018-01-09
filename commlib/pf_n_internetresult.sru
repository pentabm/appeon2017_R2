HA$PBExportHeader$pf_n_internetresult.sru
$PBExportComments$PostURL, GetURL $$HEX13$$68d518c258c72000b0acfcac200012ac44c720001bbc94b22000$$ENDHEX$$IneternetResult $$HEX8$$24c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_internetresult from internetresult
end type
end forward

global type pf_n_internetresult from internetresult
end type
global pf_n_internetresult pf_n_internetresult

type variables
blob iblb_data

end variables

forward prototypes
public function integer internetdata (blob data)
public function string of_getclassname ()
end prototypes

public function integer internetdata (blob data);iblb_data = data
return 1

end function

public function string of_getclassname ();return 'pf_n_internetresult'

end function

on pf_n_internetresult.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pf_n_internetresult.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

