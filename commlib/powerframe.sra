HA$PBExportHeader$powerframe.sra
$PBExportComments$$$HEX18$$04d508b884c7ccc66cd0a9c62000b4c50cd5acb900cf74c758c1200024c60cbe1dc8b8d2$$ENDHEX$$
forward
global type powerframe from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
pf_n_appmanager gnv_appmgr
pf_n_appconfig gnv_appconf
pf_n_appsession gnv_session
pf_n_pentalibrary gnv_extfunc

end variables

global type powerframe from application
string appname = "powerframe"
end type
global powerframe powerframe

type variables

end variables

on powerframe.create
appname="powerframe"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on powerframe.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;// Application Open $$HEX10$$74c7a4bcb8d27cb9200018c215c858d574ba2000$$ENDHEX$$Full Build$$HEX7$$00ac200018c289d518b4c0bb5cb8$$ENDHEX$$,
// pf_n_appmanager.pfe_ApplicationOpen() $$HEX10$$74c7a4bcb8d27cb92000acc0a9c669d5c8b2e4b2$$ENDHEX$$

gnv_appmgr = create pf_n_appmanager
gnv_appmgr.event pfe_applicationopen(commandline)

end event

event close;gnv_appmgr.event pfe_applicationclose()
destroy gnv_appmgr

end event

event idle;gnv_appmgr.event pfe_applicationidle()

end event

event systemerror;gnv_appmgr.event pfe_systemerror()

end event

