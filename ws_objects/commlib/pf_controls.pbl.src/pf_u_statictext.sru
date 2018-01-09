$PBExportHeader$pf_u_statictext.sru
$PBExportComments$파워프레임용 StaticText 컨트롤 입니다.
forward
global type pf_u_statictext from statictext
end type
end forward

global type pf_u_statictext from statictext
integer width = 457
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
boolean focusrectangle = false
event type boolean pfe_ispowerframecontrol ( )
event move pbm_move
event pfe_postopen ( )
end type
global pf_u_statictext pf_u_statictext

type prototypes
Function Long SetWindowLong(ULong hWnd, ULong offset, ULong attributes) LIBRARY 'user32.dll' Alias For "SetWindowLongA;Ansi"
Function Long GetWindowLong(ULong hWnd, int nIndex) LIBRARY 'user32.dll' Alias For "GetWindowLongA;Ansi"
Function Ulong UpdateWindow(ulong hwnd) LIBRARY "user32.dll"

end prototypes

type variables
public:
	//boolean TransparentBackground
	boolean FixedToRight
	boolean FixedToBottom
	boolean ScaleToRight
	boolean ScaleToBottom

end variables

forward prototypes
public function string of_getclassname ()
end prototypes

event type boolean pfe_ispowerframecontrol();return true

end event

event pfe_postopen();// post open event

end event

public function string of_getclassname ();return 'pf_u_statictext'

end function

on pf_u_statictext.create
end on

on pf_u_statictext.destroy
end on

event constructor;//if TransparentBackground then
//	CONSTANT ulong gl_color_transparent = 536870912  // 0x20000000
//	CONSTANT ulong WS_CLIPCHILDREN =  33554432 // 0x02000000
//	CONSTANT ulong GWL_STYLE = (-16)
//	
//	Long          hWnd, hFont, ll_WindowStyle, ll_WindowExStyle
//	String        ls_ClassName, ls_WindowName
//	
//	hWnd = Handle(Parent)
//	
//	this.backcolor = gl_color_transparent
//	
//	// Reset the WS_CLIPCHILDREN bit in the Window Style
//	ll_WindowStyle = GetWindowLong(hWnd, GWL_STYLE)
//	
//	pf_n_bitoperator lnv_bit
//	lnv_bit = create pf_n_bitoperator
//	SetWindowLong(hWnd, GWL_STYLE, lnv_bit.of_bitwiseAnd(ll_WindowStyle, lnv_bit.of_bitwiseNot(WS_CLIPCHILDREN)))
//	UpdateWindow(handle(parent))
//	
//	this.visible = false
//	this.visible = true
//end if

// call postopen event
this.event post pfe_postopen()

end event

