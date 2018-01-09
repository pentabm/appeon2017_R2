$PBExportHeader$powerframe.sra
$PBExportComments$프레임워크용 어플리케이션 오브젝트
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

event open;// Application Open 이벤트를 수정하면 Full Build가 수행되므로,
// pf_n_appmanager.pfe_ApplicationOpen() 이벤트를 사용합니다

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

