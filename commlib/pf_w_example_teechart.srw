HA$PBExportHeader$pf_w_example_teechart.srw
forward
global type pf_w_example_teechart from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_teechart
end type
type tab_1 from tab within pf_w_example_teechart
end type
type tabpage_1 from userobject within tab_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type cbx_1 from checkbox within tabpage_1
end type
type cbx_frame from checkbox within tabpage_1
end type
type ddlb_2 from dropdownlistbox within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type ddlb_1 from dropdownlistbox within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type uo_1 from pf_u_teechart within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type cbx_bottom from checkbox within tabpage_1
end type
type cbx_left from checkbox within tabpage_1
end type
type cbx_right from checkbox within tabpage_1
end type
type cbx_top from checkbox within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type cbx_walls from checkbox within tabpage_1
end type
type htb_walls from htrackbar within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type cbx_3d from checkbox within tabpage_1
end type
type htb_3d from htrackbar within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type st_5 from statictext within tabpage_1
end type
type sle_top from singlelineedit within tabpage_1
end type
type sle_bottom from singlelineedit within tabpage_1
end type
type sle_left from singlelineedit within tabpage_1
end type
type sle_right from singlelineedit within tabpage_1
end type
type st_6 from statictext within tabpage_1
end type
type gb_5 from groupbox within tabpage_1
end type
type cbx_gradient from checkbox within tabpage_1
end type
type st_7 from statictext within tabpage_1
end type
type st_8 from statictext within tabpage_1
end type
type sle_startcolor from singlelineedit within tabpage_1
end type
type sle_endcolor from singlelineedit within tabpage_1
end type
type st_bkcolor from statictext within tabpage_1
end type
type sle_bkcolor from singlelineedit within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_2 cb_2
cbx_1 cbx_1
cbx_frame cbx_frame
ddlb_2 ddlb_2
st_2 st_2
ddlb_1 ddlb_1
st_1 st_1
uo_1 uo_1
gb_1 gb_1
cbx_bottom cbx_bottom
cbx_left cbx_left
cbx_right cbx_right
cbx_top cbx_top
gb_2 gb_2
cbx_walls cbx_walls
htb_walls htb_walls
gb_3 gb_3
cbx_3d cbx_3d
htb_3d htb_3d
gb_4 gb_4
st_3 st_3
st_4 st_4
st_5 st_5
sle_top sle_top
sle_bottom sle_bottom
sle_left sle_left
sle_right sle_right
st_6 st_6
gb_5 gb_5
cbx_gradient cbx_gradient
st_7 st_7
st_8 st_8
sle_startcolor sle_startcolor
sle_endcolor sle_endcolor
st_bkcolor st_bkcolor
sle_bkcolor sle_bkcolor
end type
type tabpage_2 from userobject within tab_1
end type
type htb_1 from htrackbar within tabpage_2
end type
type st_11 from statictext within tabpage_2
end type
type cb_1 from commandbutton within tabpage_2
end type
type ddlb_4 from dropdownlistbox within tabpage_2
end type
type st_10 from statictext within tabpage_2
end type
type st_9 from statictext within tabpage_2
end type
type ddlb_3 from dropdownlistbox within tabpage_2
end type
type uo_2 from pf_u_teechart within tabpage_2
end type
type tabpage_2 from userobject within tab_1
htb_1 htb_1
st_11 st_11
cb_1 cb_1
ddlb_4 ddlb_4
st_10 st_10
st_9 st_9
ddlb_3 ddlb_3
uo_2 uo_2
end type
type tab_1 from tab within pf_w_example_teechart
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_3 from pf_u_commandbutton within pf_w_example_teechart
end type
end forward

global type pf_w_example_teechart from pf_w_sheet
string title = "TeeChart $$HEX6$$d8c00cd5200008c7c4b3b0c6$$ENDHEX$$"
cb_close cb_close
tab_1 tab_1
cb_3 cb_3
end type
global pf_w_example_teechart pf_w_example_teechart

type variables
pf_u_teechart uo_tc, uo_tc2

ulong il_theme
ulong il_palette
ulong il_series
ulong il_function

end variables

on pf_w_example_teechart.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.tab_1=create tab_1
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.cb_3
end on

on pf_w_example_teechart.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.tab_1)
destroy(this.cb_3)
end on

event pfe_postopen;call super::pfe_postopen;ulong ll_color

// TABPAGE_1 $$HEX2$$24c115c8$$ENDHEX$$
uo_tc = tab_1.tabpage_1.uo_1

// Series(0) $$HEX2$$ddc031c1$$ENDHEX$$
uo_tc.object.ClearChart()
uo_tc.object.AddSeries(uo_tc.scBar)
// $$HEX9$$d8c00cd5200070b374c730d12000ddc031c1$$ENDHEX$$
uo_tc.object.Series(0).FillSampleValues(10)
// $$HEX9$$18c2d9b3200070b374c730d1200085c725b8$$ENDHEX$$
//uo_tc.object.Series(0).Add(123, "ABC", rgb(255,0,0))
//uo_tc.object.Series(0).Add(456, "DEF", rgb(0,0,255))
//uo_tc.object.Series(0).Add(321, "GHI", rgb(255,255,0))
uo_tc.object.Series(0).Marks.Style = uo_tc.smsValue

// Series(1) $$HEX2$$ddc031c1$$ENDHEX$$
uo_tc.object.AddSeries(uo_tc.scLine)
uo_tc.object.Series(1).FillSampleValues(10)
uo_tc.object.Series(1).Marks.Style = uo_tc.smsValue

// $$HEX17$$08c7c4b3b0c62000e8ceb8d264b8200008cd30ae200070b374c730d1200024c115c8$$ENDHEX$$
il_theme = uo_tc.ctOpera
tab_1.tabpage_1.ddlb_1.selectitem(uo_tc.ctOpera + 1)

il_palette = uo_tc.cpOpera
tab_1.tabpage_1.ddlb_2.selectitem(uo_tc.cpOpera + 1)

tab_1.tabpage_1.cbx_3d.checked = uo_tc.object.Aspect.View3D
tab_1.tabpage_1.htb_3d.position = uo_tc.object.Aspect.Chart3DPercent

tab_1.tabpage_1.sle_top.text = string(uo_tc.object.Panel.MarginTop)
tab_1.tabpage_1.sle_bottom.text = string(uo_tc.object.Panel.MarginBottom)
tab_1.tabpage_1.sle_left.text = string(uo_tc.object.Panel.MarginLeft)
tab_1.tabpage_1.sle_right.text = string(uo_tc.object.Panel.MarginRight)

ll_color = uo_tc.object.Panel.Gradient.StartColor
tab_1.tabpage_1.sle_startcolor.text = string(ll_color)

ll_color = uo_tc.object.Panel.Gradient.EndColor
tab_1.tabpage_1.sle_endcolor.text = string(ll_color)

ll_color = uo_tc.object.Panel.Color
tab_1.tabpage_1.sle_bkcolor.text = string(ll_color)

// TABPAGE_2 $$HEX2$$24c115c8$$ENDHEX$$
uo_tc2 = tab_1.tabpage_2.uo_2

end event

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_teechart
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_teechart
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_teechart
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_teechart
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_teechart
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_teechart
end type

type cb_close from pf_u_commandbutton within pf_w_example_teechart
integer x = 5326
integer y = 84
integer width = 274
integer height = 96
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = hangeul!
string text = "$$HEX2$$ebb230ae$$ENDHEX$$"
string powertiptext = "$$HEX11$$74d5f9b2200054d674ba44c72000ebb2b5c2c8b2e4b2$$ENDHEX$$."
boolean applydesign = false
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)
end event

type tab_1 from tab within pf_w_example_teechart
integer x = 50
integer y = 164
integer width = 4498
integer height = 2060
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 116
integer width = 4462
integer height = 1928
string text = "Chart Display"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
cb_2 cb_2
cbx_1 cbx_1
cbx_frame cbx_frame
ddlb_2 ddlb_2
st_2 st_2
ddlb_1 ddlb_1
st_1 st_1
uo_1 uo_1
gb_1 gb_1
cbx_bottom cbx_bottom
cbx_left cbx_left
cbx_right cbx_right
cbx_top cbx_top
gb_2 gb_2
cbx_walls cbx_walls
htb_walls htb_walls
gb_3 gb_3
cbx_3d cbx_3d
htb_3d htb_3d
gb_4 gb_4
st_3 st_3
st_4 st_4
st_5 st_5
sle_top sle_top
sle_bottom sle_bottom
sle_left sle_left
sle_right sle_right
st_6 st_6
gb_5 gb_5
cbx_gradient cbx_gradient
st_7 st_7
st_8 st_8
sle_startcolor sle_startcolor
sle_endcolor sle_endcolor
st_bkcolor st_bkcolor
sle_bkcolor sle_bkcolor
end type

on tabpage_1.create
this.cb_2=create cb_2
this.cbx_1=create cbx_1
this.cbx_frame=create cbx_frame
this.ddlb_2=create ddlb_2
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.uo_1=create uo_1
this.gb_1=create gb_1
this.cbx_bottom=create cbx_bottom
this.cbx_left=create cbx_left
this.cbx_right=create cbx_right
this.cbx_top=create cbx_top
this.gb_2=create gb_2
this.cbx_walls=create cbx_walls
this.htb_walls=create htb_walls
this.gb_3=create gb_3
this.cbx_3d=create cbx_3d
this.htb_3d=create htb_3d
this.gb_4=create gb_4
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.sle_top=create sle_top
this.sle_bottom=create sle_bottom
this.sle_left=create sle_left
this.sle_right=create sle_right
this.st_6=create st_6
this.gb_5=create gb_5
this.cbx_gradient=create cbx_gradient
this.st_7=create st_7
this.st_8=create st_8
this.sle_startcolor=create sle_startcolor
this.sle_endcolor=create sle_endcolor
this.st_bkcolor=create st_bkcolor
this.sle_bkcolor=create sle_bkcolor
this.Control[]={this.cb_2,&
this.cbx_1,&
this.cbx_frame,&
this.ddlb_2,&
this.st_2,&
this.ddlb_1,&
this.st_1,&
this.uo_1,&
this.gb_1,&
this.cbx_bottom,&
this.cbx_left,&
this.cbx_right,&
this.cbx_top,&
this.gb_2,&
this.cbx_walls,&
this.htb_walls,&
this.gb_3,&
this.cbx_3d,&
this.htb_3d,&
this.gb_4,&
this.st_3,&
this.st_4,&
this.st_5,&
this.sle_top,&
this.sle_bottom,&
this.sle_left,&
this.sle_right,&
this.st_6,&
this.gb_5,&
this.cbx_gradient,&
this.st_7,&
this.st_8,&
this.sle_startcolor,&
this.sle_endcolor,&
this.st_bkcolor,&
this.sle_bkcolor}
end on

on tabpage_1.destroy
destroy(this.cb_2)
destroy(this.cbx_1)
destroy(this.cbx_frame)
destroy(this.ddlb_2)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.gb_1)
destroy(this.cbx_bottom)
destroy(this.cbx_left)
destroy(this.cbx_right)
destroy(this.cbx_top)
destroy(this.gb_2)
destroy(this.cbx_walls)
destroy(this.htb_walls)
destroy(this.gb_3)
destroy(this.cbx_3d)
destroy(this.htb_3d)
destroy(this.gb_4)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.sle_top)
destroy(this.sle_bottom)
destroy(this.sle_left)
destroy(this.sle_right)
destroy(this.st_6)
destroy(this.gb_5)
destroy(this.cbx_gradient)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.sle_startcolor)
destroy(this.sle_endcolor)
destroy(this.st_bkcolor)
destroy(this.sle_bkcolor)
end on

type cb_2 from commandbutton within tabpage_1
integer x = 901
integer y = 1456
integer width = 402
integer height = 120
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "Chart Editor"
end type

event clicked;uo_tc.object.ShowEditor()

end event

type cbx_1 from checkbox within tabpage_1
integer x = 2400
integer y = 1052
integer width = 457
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Marks Visible"
boolean checked = true
end type

event clicked;uo_tc.object.Series(0).Marks.Visible = this.checked

end event

type cbx_frame from checkbox within tabpage_1
integer x = 2400
integer y = 948
integer width = 457
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Frame Border"
boolean checked = true
end type

event clicked;uo_tc.object.Frame.Visible = this.checked

end event

type ddlb_2 from dropdownlistbox within tabpage_1
integer x = 2743
integer y = 168
integer width = 567
integer height = 424
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"cpTeeChart","cpExcel","cpVictorian","cpPastel","cpSolid","cpClassic","cpWeb","cpModern","cpRainbow","cpWindowsXP","cpMacOS","cpWinVista","cpGrayScale","cpOpera","cpWarm","cpCool","cpBlackIsBack"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if not isvalid(uo_tc) then return

il_palette = index - 1
uo_tc.object.ApplyPalette(il_palette)

end event

type st_2 from statictext within tabpage_1
integer x = 2309
integer y = 180
integer width = 402
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Color Palette"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within tabpage_1
integer x = 2743
integer y = 52
integer width = 567
integer height = 424
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"ctDefault","ctExcel","ctClassic","ctBusiness","ctWeb","ctWindowsXP","ctBlueSky","ctFacts","ctRandom","ctOpera","ctBlackIsBack","ctgGrayscale","ctSpeed"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if not isvalid(uo_tc) then return

il_theme = index - 1
uo_tc.object.SetTheme(il_theme, il_palette)

end event

type st_1 from statictext within tabpage_1
integer x = 2309
integer y = 72
integer width = 402
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Theme"
boolean focusrectangle = false
end type

type uo_1 from pf_u_teechart within tabpage_1
integer x = 9
integer y = 12
integer width = 2190
integer height = 1428
integer taborder = 30
end type

on uo_1.destroy
call pf_u_teechart::destroy
end on

type gb_1 from groupbox within tabpage_1
integer x = 2322
integer y = 360
integer width = 960
integer height = 544
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
long backcolor = 16777215
string text = "Chart Axis"
end type

type cbx_bottom from checkbox within tabpage_1
integer x = 2400
integer y = 560
integer width = 475
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Bottom Visible"
boolean checked = true
end type

event clicked;uo_tc.object.Axis.Bottom.Visible = this.checked

end event

type cbx_left from checkbox within tabpage_1
integer x = 2400
integer y = 664
integer width = 402
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Let Visible"
boolean checked = true
end type

event clicked;uo_tc.object.Axis.Left.Visible = this.checked

end event

type cbx_right from checkbox within tabpage_1
integer x = 2400
integer y = 772
integer width = 421
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Right Visible"
end type

event clicked;uo_tc.object.Axis.Right.Visible = this.checked

end event

type cbx_top from checkbox within tabpage_1
integer x = 2400
integer y = 456
integer width = 402
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Top Visible"
end type

event clicked;uo_tc.object.Axis.Top.Visible = this.checked

end event

type gb_2 from groupbox within tabpage_1
integer x = 2322
integer y = 1184
integer width = 960
integer height = 344
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
long backcolor = 16777215
string text = "Walls"
end type

type cbx_walls from checkbox within tabpage_1
integer x = 2446
integer y = 1272
integer width = 421
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Walls Visible"
boolean checked = true
end type

event clicked;uo_tc.object.Walls.Visible = this.checked

end event

type htb_walls from htrackbar within tabpage_1
integer x = 2437
integer y = 1384
integer width = 805
integer height = 88
boolean bringtotop = true
integer minposition = 1
integer maxposition = 10
integer position = 1
integer tickfrequency = 1
htickmarks tickmarks = hticksonneither!
end type

event moved;// change Walls size...
uo_tc.object.Walls.Left.Size = scrollpos
uo_tc.object.Walls.Bottom.Size = scrollpos
uo_tc.object.Walls.Back.Size = scrollpos

end event

type gb_3 from groupbox within tabpage_1
integer x = 3410
integer y = 52
integer width = 978
integer height = 348
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
long backcolor = 16777215
string text = "3D"
end type

type cbx_3d from checkbox within tabpage_1
integer x = 3529
integer y = 152
integer width = 402
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "3D Enables"
boolean checked = true
end type

event clicked;// switch 2D / 3D ...
uo_tc.object.Aspect.View3D = this.checked

end event

type htb_3d from htrackbar within tabpage_1
integer x = 3520
integer y = 252
integer width = 805
integer height = 88
boolean bringtotop = true
integer minposition = 1
integer maxposition = 100
integer position = 1
integer tickfrequency = 1
htickmarks tickmarks = hticksonneither!
end type

event moved;// change 3D percent effect...
uo_tc.object.Aspect.Chart3DPercent = scrollpos

end event

type gb_4 from groupbox within tabpage_1
integer x = 3415
integer y = 456
integer width = 978
integer height = 624
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
long backcolor = 16777215
string text = "Margins"
end type

type st_3 from statictext within tabpage_1
integer x = 3529
integer y = 580
integer width = 210
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Top"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_1
integer x = 3529
integer y = 700
integer width = 210
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Bottom"
boolean focusrectangle = false
end type

type st_5 from statictext within tabpage_1
integer x = 3529
integer y = 820
integer width = 210
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Left"
boolean focusrectangle = false
end type

type sle_top from singlelineedit within tabpage_1
integer x = 3867
integer y = 564
integer width = 338
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;if isnumber(this.text) then
	uo_tc.object.Panel.MarginTop = long(this.text)
end if

end event

type sle_bottom from singlelineedit within tabpage_1
integer x = 3867
integer y = 684
integer width = 338
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;if isnumber(this.text) then
	uo_tc.object.Panel.MarginBottom = long(this.text)
end if

end event

type sle_left from singlelineedit within tabpage_1
integer x = 3867
integer y = 804
integer width = 338
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;if isnumber(this.text) then
	uo_tc.object.Panel.MarginLeft = long(this.text)
end if

end event

type sle_right from singlelineedit within tabpage_1
integer x = 3867
integer y = 924
integer width = 338
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;if isnumber(this.text) then
	uo_tc.object.Panel.MarginRight = long(this.text)
end if

end event

type st_6 from statictext within tabpage_1
integer x = 3529
integer y = 940
integer width = 210
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Right"
boolean focusrectangle = false
end type

type gb_5 from groupbox within tabpage_1
integer x = 3415
integer y = 1124
integer width = 978
integer height = 624
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
long backcolor = 16777215
string text = "Panel"
end type

type cbx_gradient from checkbox within tabpage_1
integer x = 3520
integer y = 1232
integer width = 402
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Gradient"
boolean checked = true
end type

event clicked;// switch 2D / 3D ...
uo_tc.object.Panel.Gradient.Visible = this.checked

end event

type st_7 from statictext within tabpage_1
integer x = 3525
integer y = 1360
integer width = 338
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Start Color"
boolean focusrectangle = false
end type

type st_8 from statictext within tabpage_1
integer x = 3525
integer y = 1488
integer width = 338
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "End Color"
boolean focusrectangle = false
end type

type sle_startcolor from singlelineedit within tabpage_1
integer x = 3863
integer y = 1344
integer width = 402
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;if isnumber(this.text) then
	uo_tc.object.Panel.Gradient.StartColor = long(this.text)
end if

end event

type sle_endcolor from singlelineedit within tabpage_1
integer x = 3863
integer y = 1468
integer width = 402
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;if isnumber(this.text) then
	uo_tc.object.Panel.Gradient.EndColor = long(this.text)
end if

end event

type st_bkcolor from statictext within tabpage_1
integer x = 3525
integer y = 1612
integer width = 338
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Back Color"
boolean focusrectangle = false
end type

type sle_bkcolor from singlelineedit within tabpage_1
integer x = 3863
integer y = 1592
integer width = 402
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;if isnumber(this.text) then
	uo_tc.object.Panel.Color = long(this.text)
end if

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 116
integer width = 4462
integer height = 1928
string text = "Chart Series"
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 536870912
htb_1 htb_1
st_11 st_11
cb_1 cb_1
ddlb_4 ddlb_4
st_10 st_10
st_9 st_9
ddlb_3 ddlb_3
uo_2 uo_2
end type

on tabpage_2.create
this.htb_1=create htb_1
this.st_11=create st_11
this.cb_1=create cb_1
this.ddlb_4=create ddlb_4
this.st_10=create st_10
this.st_9=create st_9
this.ddlb_3=create ddlb_3
this.uo_2=create uo_2
this.Control[]={this.htb_1,&
this.st_11,&
this.cb_1,&
this.ddlb_4,&
this.st_10,&
this.st_9,&
this.ddlb_3,&
this.uo_2}
end on

on tabpage_2.destroy
destroy(this.htb_1)
destroy(this.st_11)
destroy(this.cb_1)
destroy(this.ddlb_4)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.ddlb_3)
destroy(this.uo_2)
end on

type htb_1 from htrackbar within tabpage_2
integer x = 2743
integer y = 432
integer width = 622
integer height = 100
integer maxposition = 10
integer position = 1
integer tickfrequency = 1
htickmarks tickmarks = hticksonneither!
end type

event moved;// Change the Function "Period" property...
if long(uo_tc2.object.SeriesCount) > 1 then
	uo_tc2.object.Series(1).FunctionType.Period = scrollpos
end if

end event

type st_11 from statictext within tabpage_2
integer x = 2286
integer y = 440
integer width = 430
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Function Period"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within tabpage_2
integer x = 901
integer y = 1456
integer width = 402
integer height = 120
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
string text = "Chart Editor"
end type

event clicked;uo_tc2.object.ShowEditor()

end event

type ddlb_4 from dropdownlistbox within tabpage_2
integer x = 2743
integer y = 296
integer width = 480
integer height = 424
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Copy","Add","Subtract","Multiply","Divide","Average","High","Low"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;// the function will create a second Series on the
// Chart. So, remove the second Series each time
// we click this button...
if long(uo_tc2.object.SeriesCount) > 1 then
	uo_tc2.object.RemoveSeries(1)
end if

// add a new Line Series to show the Function...
uo_tc2.object.AddSeries(uo_tc2.scline)

// set the Function type (Add, Subtract, etc... )
il_function = index - 1
uo_tc2.object.Series(1).SetFunction(il_function)

// set the Function Source (the first Series)...
uo_tc2.object.Series(1).DataSource = uo_tc2.object.Series(0).Name
    
// change the Series title to be the Function name...
uo_tc2.object.Series(1).Title = this.text + " Function"

end event

type st_10 from statictext within tabpage_2
integer x = 2286
integer y = 304
integer width = 430
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Add a function"
boolean focusrectangle = false
end type

type st_9 from statictext within tabpage_2
integer x = 2286
integer y = 124
integer width = 430
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
string text = "Series Type"
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within tabpage_2
integer x = 2743
integer y = 116
integer width = 654
integer height = 424
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"scLine","scBar","scHorizBar","scArea","scPoint","scPie","scFastLine","scShape","scGantt","scBubble","scArrow","scCandle","scPolar","scSurface","scVolume","scErrorBar","scBezier","scContour","scError","scPoint3D","scRadar","scClock","scWindRose","scBar3D","scImageBar","scDonut","scTriSurface","scBox","scHorizBox","scHistogram","scColorGrid","scBarJoin","scHighLow","scWaterfall","scSmith","scPyramid","scMap","scHorizLine","scFunnel","scCalendar","scHorizArea","scPointFigure","scGauge","scVector3D","scTower","scPolarBar","scBubble3D","scHorizHistogram","scVolumePipe","scIsoSurface","scDarvas","scHighLowLine","scPolarGrid","scDeltaPoint","scImagePoint","scOrganizational","scWorld","scTagCloud","scKagi","scRenko","scNumericGauge","scLinearGauge","scCircularGauge","scBigCandle","scLinePoint","scKnob","scRose","scTernary","scTreeMap","scErrorPoint","scErrorPoint3D","scEquiVolume","scDoubleHorizBar","scPolarContour"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;il_series = index - 1

uo_tc2.object.ClearChart()
uo_tc2.object.AddSeries(il_series)
uo_tc2.object.Series(0).FillSampleValues(15)
uo_tc2.object.Series(0).Title = This.Text

end event

type uo_2 from pf_u_teechart within tabpage_2
integer x = 9
integer y = 12
integer width = 2190
integer height = 1428
integer taborder = 40
end type

on uo_2.destroy
call pf_u_teechart::destroy
end on

type cb_3 from pf_u_commandbutton within pf_w_example_teechart
integer x = 4279
integer y = 32
integer width = 274
integer height = 96
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = hangeul!
string text = "$$HEX2$$ebb230ae$$ENDHEX$$"
string powertiptext = "$$HEX11$$74d5f9b2200054d674ba44c72000ebb2b5c2c8b2e4b2$$ENDHEX$$."
boolean applydesign = false
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)
end event

