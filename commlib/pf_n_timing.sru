HA$PBExportHeader$pf_n_timing.sru
$PBExportComments$$$HEX5$$0cd3ccc64cbe54b32000$$ENDHEX$$Timing $$HEX7$$24c60cbe1dc8b8d285c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_timing from timing
end type
end forward

global type pf_n_timing from timing
end type
global pf_n_timing pf_n_timing

type variables
//CONSTANT DOUBLE DEFAULT_TIMING_INTERVAL = 0.2
CONSTANT DOUBLE DEFAULT_TIMING_INTERVAL = 0.1

private:
	dragobject ido_parent

end variables

forward prototypes
public subroutine of_initialize (readonly dragobject ado_parent)
public function string of_getclassname ()
public function integer of_start ()
public function integer of_start (double adbl_interval)
end prototypes

public subroutine of_initialize (readonly dragobject ado_parent);ido_parent = ado_parent

end subroutine

public function string of_getclassname ();return 'pf_n_timing'

end function

public function integer of_start ();return this.start(DEFAULT_TIMING_INTERVAL)

end function

public function integer of_start (double adbl_interval);return this.start(adbl_interval)

end function

on pf_n_timing.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pf_n_timing.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;any la_args[]
string ls_key
integer i , li_argcnt

if isvalid(gnv_session) then
	ls_key = this.of_getclassname() + '.constructor.param.'
	if gnv_session.of_containskey(ls_key + 'count') then
		li_argcnt = gnv_session.of_getint(ls_key + 'count')
		
		for i = 1 to li_argcnt
			la_args[i] = gnv_session.of_get(ls_key + string(i))
		next
		
		choose case li_argcnt
			case 0;	this.dynamic of_initialize()
			case 1;	this.dynamic of_initialize(la_args[1])
			case 2;	this.dynamic of_initialize(la_args[1], la_args[2])
			case 3;	this.dynamic of_initialize(la_args[1], la_args[2], la_args[3])
			case 4;	this.dynamic of_initialize(la_args[1], la_args[2], la_args[3], la_args[4])
			case 5;	this.dynamic of_initialize(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5])
			case 6;	this.dynamic of_initialize(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6])
			case 7;	this.dynamic of_initialize(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7])
			case 8;	this.dynamic of_initialize(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8])
			case 9;	this.dynamic of_initialize(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9])
			case 10;	this.dynamic of_initialize(la_args[1], la_args[2], la_args[3], la_args[4], la_args[5], la_args[6], la_args[7], la_args[8], la_args[9], la_args[10])
		end choose
	end if
end if

end event

event destructor;if this.running = true then
	this.stop()
end if

end event

event timer;if isvalid(ido_parent) then
	ido_parent.postevent('timer')
end if

end event

