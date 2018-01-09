HA$PBExportHeader$pf_n_dwrowselect.sru
$PBExportComments$$$HEX24$$70b374c730d108c7c4b3b0c6200089d5200020c1ddd020001cc144bea4c2200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.~r~n$$HEX27$$e4b211c989d5200020c1ddd0200030aea5b220000fbc2000e8b27cc789d5200020c1ddd030aea5b244c720001cc8f5ac69d5c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_dwrowselect from pf_n_nonvisualobject
end type
end forward

global type pf_n_dwrowselect from pf_n_nonvisualobject
event type long pfe_clicked ( integer xpos,  integer ypos,  long row,  dwobject dwo )
event pfe_rowfocuschanged ( long currentrow )
end type
global pf_n_dwrowselect pf_n_dwrowselect

type variables
protected:
	pf_u_datawindow idw_target
	graphicobject igo_parent

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_multirowselect (long row)
public function integer of_singlerowselect (long row)
public subroutine of_initialize (datawindow adw_datawindow)
end prototypes

event type long pfe_clicked(integer xpos, integer ypos, long row, dwobject dwo);if idw_target.MultiRowSelection = true then
	this.of_multirowselect(row)
end if

if idw_target.SingleRowSelection = true then
	this.of_singlerowselect(row)
end if

return 0

end event

event pfe_rowfocuschanged(long currentrow);// MultiRowSelection
if idw_target.MultiRowSelection = true then
	if KeyDown(KeyShift!) AND (KeyDown(KeyDownArrow!) OR KeyDown(KeyUpArrow!)) Then
		idw_target.SelectRow(currentrow,TRUE)
		return
	end if
end if

// SingleRowSelection
if idw_target.SingleRowSelection = true then
	idw_target.selectrow(0, false)
	idw_target.selectrow(currentrow, true)
	return
end if

end event

public function string of_getclassname ();return 'pf_n_dwselectrow'
end function

public function integer of_multirowselect (long row);// MultiRowSelection
if row = 0 then return 0

long ll_selectedrow, ll_rc
ll_selectedrow = idw_target.getselectedrow(0)

// select range
IF KeyDown(keyShift!) THEN
	IF ll_selectedrow = 0 THEN
		idw_target.SelectRow(row, True)
	ELSE
		idw_target.SelectRow(0, False)
		IF row > ll_selectedrow THEN
			FOR ll_rc = ll_selectedrow TO row
				idw_target.SelectRow(ll_rc, True)
			NEXT
		ELSE
			FOR ll_rc = row TO ll_selectedrow
				idw_target.SelectRow(ll_rc, True)
			NEXT
	END IF
END IF

// multi select
ELSEIF KeyDown(keyControl!) THEN
	IF idw_target.IsSelected(row) THEN
		idw_target.SelectRow(row, False)
	ELSE
		idw_target.SelectRow(row, True)
	END IF

// single select
ELSE
	IF idw_target.IsSelected(row) THEN
		idw_target.SelectRow(0, False)
		idw_target.SelectRow(row, True)
	ELSE
		idw_target.SelectRow(0, False)
		idw_target.SelectRow(row, True)
	END IF
END IF

return 1

end function

public function integer of_singlerowselect (long row);// SingleRowSelection
if row = 0 then return 0

IF idw_target.IsSelected(row) THEN
	idw_target.SelectRow(0, False)
	idw_target.SelectRow(row, True)
ELSE
	idw_target.SelectRow(0, False)
	idw_target.SelectRow(row, True)
END IF

return 1

end function

public subroutine of_initialize (datawindow adw_datawindow);// parent datawindow $$HEX2$$f1b45db8$$ENDHEX$$
idw_target = adw_datawindow
igo_parent = idw_target.getparent()

end subroutine

on pf_n_dwrowselect.create
call super::create
end on

on pf_n_dwrowselect.destroy
call super::destroy
end on

