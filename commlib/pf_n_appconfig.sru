HA$PBExportHeader$pf_n_appconfig.sru
$PBExportComments$$$HEX31$$04d508b884c7ccc66cd0a9c62000b4c50cd5acb900cf74c758c1200058d6bdac24c115c8200000adacb9a9c62000acc0a9c690c7200024c60cbe1dc8b8d2$$ENDHEX$$
forward
global type pf_n_appconfig from pf_n_nonvisualobject
end type
end forward

global type pf_n_appconfig from pf_n_nonvisualobject
end type
global pf_n_appconfig pf_n_appconfig

type variables
constant string PF_PROFILE = ".\pf_profile.ini"

//// ***** Login Section:
//// login_type={normal|sso}
//// login_rememberid ={Y|N}
//string login_type = 'normal'
//string login_object = 'pf_n_login'
//string login_lastloginuser = ''
//string login_rememberid = 'Y'
//
//// ***** Mainframe Section:
//// mainframe_topmenu_type={iconmenu|textmenu}
//// mainframe_leftmenu_type = {treemenu|xpmenu}
//long mainframe_resolution_width = 1024
//long mainframe_resolution_height = 768
//long mainframe_backcolor = 14606046
//long mainframe_midclient_backcolor = 16777215
//string mainframe_use_submenu = 'N'
//
//string mainframe_logo_image_file = '..\img\top\top_logo.gif'
//string mainframe_topmenu_type = 'textmenu'
//string mainframe_leftmenu_type = 'xpmenu'
//long mainframe_leftmenu_backcolor = 14606046
//long mainframe_wintab_backcolor = 12763842
//long mainframe_wintab_normal_font_color = 6643037
//long mainframe_wintab_selected_font_color = 5720472

end variables

forward prototypes
public function string of_getprofile (string as_key, string as_default)
public function string of_getsection (string as_key)
public function integer of_setprofile (string as_key, string as_value)
end prototypes

public function string of_getprofile (string as_key, string as_default);// $$HEX19$$0cd3ccc604d508b884c7200058d6bdac24c115c8200012ac44c7200000ac38c835c6c8b2e4b2$$ENDHEX$$
// as_key=$$HEX11$$24c115c812ac44c7200000ac38c82cc62000a4d012ac$$ENDHEX$$
// as_default=$$HEX14$$a4d012ac74c72000c6c544c72000bdacb0c6200030aef8bc200012ac$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$=$$HEX6$$58d6bdac24c115c8200012ac$$ENDHEX$$

string ls_section
string ls_retval

ls_section = this.of_getsection(as_key)
ls_retval  = profilestring(PF_PROFILE, ls_section, as_key, as_default)

return ls_retval

end function

public function string of_getsection (string as_key);// $$HEX10$$18b170ac1bbc40c72000a4d012ac3cc75cb82000$$ENDHEX$$ini$$HEX14$$0cd37cc758c7200039c158c112ac44c720006cad69d5c8b2e4b22000$$ENDHEX$$
// $$HEX13$$80acc9c01cb4200039c158c112ac74c72000c6c53cc774ba2000$$ENDHEX$$'.'$$HEX19$$5cb820006cad84bd18b4b4c5c4c920008cc821ce200012ac44c72000acc0a9c669d5c8b2e4b2$$ENDHEX$$($$HEX1$$08c6$$ENDHEX$$:mdi.backcolor = mdi $$HEX2$$39c158c1$$ENDHEX$$)
// as_key=$$HEX10$$39c158c112ac44c720006cad60d52000a4d012ac$$ENDHEX$$
// $$HEX2$$acb934d1$$ENDHEX$$=$$HEX6$$80acc9c01cb42000a4d012ac$$ENDHEX$$

long ll_pos
string ls_section

ll_pos = pos(as_key, '.')
if ll_pos > 0 then
	ls_section = left(as_key, ll_pos - 1)
	choose case ls_section
		case 'pf', 'powerframe'
			ls_section = 'PowerFrame'
		case 'mdi'
			ls_section = 'MDIWindow'
		case 'pip'
			ls_section = 'PIPLogging'
		case 'log'
			ls_section = 'Logger'
		case 'user'
			ls_section = 'UserSettings'
	end choose
else
	ls_section = 'PowerFrame'
end if

return ls_section

end function

public function integer of_setprofile (string as_key, string as_value);// $$HEX19$$0cd3ccc604d508b884c7200058d6bdac24c115c8200012ac44c7200000c8a5c769d5c8b2e4b2$$ENDHEX$$
// as_key=ini $$HEX10$$0cd37cc7d0c5200000c8a5c760d52000a4d012ac$$ENDHEX$$
// as_default=ini $$HEX9$$0cd37cc7d0c5200000c8a5c760d5200012ac$$ENDHEX$$
// $$HEX3$$acb934d112ac$$ENDHEX$$=$$HEX2$$31c1f5ac$$ENDHEX$$:1, $$HEX2$$e4c228d3$$ENDHEX$$:-1

string ls_section
integer li_retcd

ls_section = this.of_getsection(as_key)
li_retcd  = setprofilestring(PF_PROFILE, ls_section, as_key, as_value)

return li_retcd

end function

on pf_n_appconfig.create
call super::create
end on

on pf_n_appconfig.destroy
call super::destroy
end on

