HA$PBExportHeader$pf_n_appsession.sru
$PBExportComments$$$HEX50$$b4c50cd5acb900cf74c758c12000e4c289d5dcc2200038cce0ac60d5200001ac85c82000c0bc18c220000fbc200024c60cbe1dc8b8d2e4b444c72000f4bc00ad200010b694b2200088bdecb724c694b2200030aea5b244c7200018c289d569d5c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_appsession from pf_n_hashtable
end type
end forward

global type pf_n_appsession from pf_n_hashtable
end type
global pf_n_appsession pf_n_appsession

type variables
// $$HEX6$$5cb8f8ad78c7200015c8f4bc$$ENDHEX$$
public:
	string is_sys_id			// System_id
	string is_login_yn		// Login $$HEX2$$ecc580bd$$ENDHEX$$
	datetime idtm_login	// Login $$HEX2$$7cc7dcc2$$ENDHEX$$
	string is_user_id		// $$HEX4$$acc0a9c690c72000$$ENDHEX$$ID
	string is_user_name	// $$HEX5$$acc0a9c690c7200085ba$$ENDHEX$$
	string is_admin_yn		// Administrator $$HEX2$$ecc580bd$$ENDHEX$$
	string is_emp_no		// $$HEX2$$acc088bc$$ENDHEX$$
	string is_emp_name	// $$HEX3$$acc0d0c685ba$$ENDHEX$$

end variables

forward prototypes
public function string of_getclassname ()
end prototypes

public function string of_getclassname ();return "pf_n_appsession"

end function

on pf_n_appsession.create
call super::create
end on

on pf_n_appsession.destroy
call super::destroy
end on

event constructor;call super::constructor;//inv_userauth = create pf_n_userauthority

end event

event destructor;call super::destructor;//destroy inv_userauth

end event

