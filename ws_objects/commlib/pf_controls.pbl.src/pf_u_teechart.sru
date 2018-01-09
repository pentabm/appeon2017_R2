$PBExportHeader$pf_u_teechart.sru
$PBExportComments$TeeChart2015 컨트롤
forward
global type pf_u_teechart from olecustomcontrol
end type
end forward

global type pf_u_teechart from olecustomcontrol
integer width = 1829
integer height = 1000
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "pf_u_teechart.udo"
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "⹏─ߴ"
boolean italic = true
long textcolor = 33554432
event onafterdraw ( )
event onbeforedrawseries ( )
event onbeforedrawaxes ( )
event onclick ( )
event onclickaxis ( long axis,  integer button,  integer shift,  long ocx_x,  long ocx_y )
event onclickbackground ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event onclicklegend ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event onclickseries ( long seriesindex,  long valueindex,  integer button,  integer shift,  long ocx_x,  long ocx_y )
event ondblclick ( )
event ondragdrop ( long ocx_x,  long ocx_y )
event ondragover ( long ocx_x,  long ocx_y,  integer state,  ref boolean accept )
event onenddrag ( long ocx_x,  long ocx_y )
event onenter ( )
event onexit ( )
event ongetaxislabel ( long axis,  long seriesindex,  long valueindex,  ref string labeltext )
event ongetlegendrect ( ref long left,  ref long top,  ref long right,  ref long bottom )
event ongetnextaxislabel ( long axis,  long labelindex,  ref double labelvalue,  ref boolean morelabels )
event onmousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event onmousemove ( integer shift,  long ocx_x,  long ocx_y )
event onmouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event onpagechange ( )
event onresize ( )
event onscroll ( )
event onstartdrag ( )
event onundozoom ( )
event onzoom ( )
event onallowscroll ( integer axis,  ref double amin,  ref double amax,  ref boolean allowscroll )
event ongetlegendpos ( long itemindex,  ref long ocx_x,  ref long ocx_y,  ref long xcolor )
event ongetlegendtext ( long legendstyle,  long valueindex,  ref string legendtext )
event ondatabaserecord ( long seriesindex,  long index,  ref boolean stopretrieve )
event ontimer ( )
event ongetseriesmark ( long seriesindex,  long valueindex,  ref string marktext )
event ongetseriespointerstyle ( long seriesindex,  long valueindex,  ref integer astyle )
event onbeforedrawchart ( )
event onseriesbeforedrawvalues ( long seriesindex )
event onseriesafterdrawvalues ( long seriesindex )
event onmarktiptoolgettext ( long tool,  ref string text )
event oncursortoolchange ( long tool,  long ocx_x,  long ocx_y,  double xval,  double yval,  long series,  long valueindex )
event ondrawlinetoollinedrag ( )
event ondrawlinetoolnewline ( )
event ondrawlinetooldraggedline ( )
event ondrawlinetoolselectline ( )
event oncalendarserieschange ( long series,  double value )
event onseriesbeforeadd ( long seriesindex,  ref boolean morevalues )
event onmouseenterseries ( long seriesindex )
event onmouseleaveseries ( long seriesindex )
event onseriescontourbeforedrawlevel ( long seriesindex,  long levelindex )
event onseriesanimationtoolstep ( long tool,  long ocx_step )
event ongantttooldragbar ( long tool,  long ganttbar )
event ongantttoolresizebar ( long tool,  long ganttbar,  integer barpart )
event onfunctioncalculate ( long seriesindex,  double ocx_x,  ref double ocx_y )
event oncompressfunctiongetdate ( long functionseriesindex,  long sourceseriesindex,  long valueindex,  ref datetime d )
event ongaugechange ( long seriesindex )
event onnearesttoolchange ( )
event onbeforeprint ( )
event onkeydown ( long keycode,  integer shift )
event onkeyup ( long keycode,  integer shift )
event onlegendscrollbartoolscrolled ( )
event onsurfacenearesttoolselectcell ( )
event ondrawaxislabel ( long axis,  long ocx_x,  long ocx_y,  ref string labeltext )
event onlegenddrawsymbol ( long series,  long valueindex,  long left,  long top,  long right,  long bottom )
event oncolorbandtoolclick ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event onrotatetoolrotate ( )
event oncolorlinetoolbegindragline ( )
event oncolorlinetooldragline ( )
event oncolorlinetoolenddragline ( )
event ondragpointtooldragpoint ( long index )
event ondrawlinetoolselecting ( long index,  boolean allowselect )
event onselectortooldragged ( )
event onselectortooldragging ( )
event onselectortoolresized ( )
event onselectortoolresizing ( )
event onselectortoolselected ( )
event onannotationtoolclick ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event onrectangletooldragging ( )
event onrectangletoolresizing ( )
event onrectangletoolclick ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event onseriesafteradd ( long seriesindex,  long valueindex )
event ongetseriesbarstyle ( long seriesindex,  long valueindex,  ref integer barstyle )
event onvideotoolnewframe ( )
event onvideotoolstart ( )
event onvideotoolstop ( )
event onvideoplayertoolframe ( )
event onopenglinit ( )
event onopenglrepaint ( )
event oncursortoolsnapchange ( long tool,  long ocx_x,  long ocx_y,  double xval,  double yval,  long series,  long valueindex )
event ondragmarkstooldraggedmark ( long index,  integer button,  integer shift,  long ocx_x,  long ocx_y )
event ondragmarkstooldraggingmark ( long index,  integer button,  integer shift,  long ocx_x,  long ocx_y )
event onrectangletooldragged ( )
event onrectangletoolresized ( )
event onmarktiptoolcancelhint ( )
event onseriesclickpointer ( long seriesindex,  long valueindex,  long ocx_x,  long ocx_y )
event onseriesclickpointer3d ( long seriesindex,  long valueindex,  long ocx_x,  long ocx_y )
event onfadertoolstop ( )
event onaxisarrowtoolclick ( long toolindex,  boolean atstart )
event oncolorbandtoolresized ( )
event onaddseries ( long seriesindex )
event onremoveseries ( long seriesindex )
event onlegendscrollbartoolchangesize ( )
event onlegendscrollbartoolsetposition ( long value )
event onimageseriesgetimage ( long seriesindex,  long valueindex,  ref oleobject picture )
event ongetseriescirclelabel ( long seriesindex,  double angle,  long index,  ref string text )
event ontagcloudseriesdrawtag ( long seriesindex,  long valueindex )
event onsurfaceseriesgetyvalue ( long seriesindex,  long ocx_x,  long z,  ref double ocx_y )
event ondatatabletoolfilterseries ( long seriesindex,  ref boolean accept )
event onsubcharttooldragged ( )
event onsubcharttooldragging ( )
event onsubcharttoolresized ( )
event onsubcharttoolresizing ( )
event ondragpointtoolstartdrag ( long index,  boolean start )
event oncolorbandtooldragging ( )
event oncolorbandtoolresizing ( )
event onanimationbegin ( long animation )
event onanimationend ( long animation,  boolean freeanimation )
event onanimationframe ( long animation,  double fraction )
event onanimateclear ( )
event onanimatecontinue ( )
event onanimateframe ( )
event onanimatepause ( )
event onanimateplay ( )
event onanimatestop ( )
event ondragpointtoolenddrag ( long index )
event onscrollpagerscroll ( long index )
event pfe_postopen ( )
event resize pbm_size
end type
global pf_u_teechart pf_u_teechart

type variables
// EAnimationClass
constant ulong tcExpand = 0 

// EAnimationTrigger
constant ulong atMouseClick = 0 
constant ulong atMouseOver = 1

// EAnnotationPosition
constant ulong ppLeftTop = 0 
constant ulong ppLeftBottom = 1
constant ulong ppRightTop = 2 
constant ulong ppRightBottom = 3
constant ulong ppCenter = 4

// EArrowHeadStyle
constant ulong ahNone = 0
constant ulong ahLine = 1
constant ulong ahSolid = 2

// EAxisArrowToolPosition
constant ulong aaStart = 0 
constant ulong aaEnd = 1 
constant ulong aaBoth = 2

// EAxisBreakStyle
constant ulong tabSmallZigZag = 0 
constant ulong tabZigZag = 1
constant ulong tabLine = 2 
constant ulong tabNone = 3

// EAxisLabelAlign
constant ulong alDefault = 0 
constant ulong alOpposite = 1

// EAxisLabelStyle
constant ulong talAuto = 0
constant ulong talNone = 1
constant ulong talValue = 2
constant ulong talMark = 3
constant ulong talText = 4
constant ulong talPointValue = 5

// EAxisTitlePosition
constant ulong tpStart = 0
constant ulong tpCenter = 1
constant ulong tpEnd = 2

// EAxisType
constant ulong atLeft = 0
constant ulong atTop = 1
constant ulong atRight = 2
constant ulong atBottom = 3
constant ulong atDepth = 4
constant ulong atCustom = 5

// EBackImageMode 
constant ulong pbmStretch = 0
constant ulong pbmTile = 1
constant ulong pbmCenter = 2
constant ulong pbmCustom = 3

// EBarRound
constant ulong brNone = 0
constant ulong brAtValue = 1
constant ulong brBothEnds = 2

// EBarStyle
constant ulong bsRectangle = 0
constant ulong bsPyramid = 1
constant ulong bsInvPyramid = 2
constant ulong bsCilinder = 3
constant ulong bsEllipse = 4
constant ulong bsArrow = 5
constant ulong bsRectGradient = 6
constant ulong bsCone = 7
constant ulong bsBevel = 8
constant ulong bsSlantCube = 9
constant ulong bsDiamond = 10
constant ulong bsInvArrow = 11
constant ulong bsInvCone = 12
constant ulong bsCustom = 13
constant ulong bsRoundRectangle = 14

// EBezierStyle
constant ulong bsWindows = 0
constant ulong bsBezier3 = 1
constant ulong bsBezier4 = 2

// EBorderStyle
constant ulong bsNone = 0
constant ulong bsSingle = 1

// EBrushStyle
constant ulong bsSolid = 0
constant ulong bsClear = 1
constant ulong bsHorizontal = 2
constant ulong bsVertical = 3
constant ulong bsFDiagonal = 4
constant ulong bsBDiagonal = 5
constant ulong bsCross = 6
constant ulong bsDiagCross = 7
constant ulong bsFill80 = 8
constant ulong bsFill60 = 9 
constant ulong bsFill40 = 10
constant ulong bsFill20 = 11
constant ulong bsFill10 = 12
constant ulong bsZigZag = 13
constant ulong bsVertSmall = 14 
constant ulong bsHorizSmall = 15
constant ulong bsDiagSmall = 16
constant ulong bsBackDiagSmall = 17
constant ulong bsCrossSmall = 18
constant ulong bsBackCrossSmall = 19

// ECandleColorStyle
constant ulong cssRelativeToOpen = 0
constant ulong cssRelativeToClose = 1

// ECandleStyle 
constant ulong csCandleStick = 0
constant ulong csCandleBar = 1
constant ulong csOpenClose = 2
constant ulong csLine = 3

// ECanvas3DPlane
constant ulong cpX = 0
constant ulong cpY = 1
constant ulong cpZ = 2

// ECanvasBackMode
constant ulong cbmNone = 0
constant ulong cbmTransparent = 1
constant ulong cbmOpaque = 2

// ECanvasTextAlign
constant ulong ctaLeft = 0
constant ulong ctaCenter = 1
constant ulong ctaRight = 2

// ECanvasZoomText
constant ulong ztManual = 0
constant ulong ztNo = 1
constant ulong ztAuto = 2

// EChartClickedPartStyle
constant ulong cpNone = 0
constant ulong cpLegend = 1
constant ulong cpAxis = 2
constant ulong cpSeries = 3
constant ulong cpTitle = 4
constant ulong cpFoot = 5
constant ulong cpChartRect = 6
constant ulong cpSeriesMarks = 7
constant ulong cpSeriesPointer = 8
constant ulong cpSubTitle = 9 
constant ulong cpSubFoot = 10
constant ulong cpAxisTitle = 11

// EChartGridShow
constant ulong cgsAuto = 0
constant ulong cgsNo = 1
constant ulong cgsYes = 2

// EChartObjectShapeStyle
constant ulong fosRectangle = 0
constant ulong fosRoundRectangle = 1

// EChartPenStyle
constant ulong psSolid = 0
constant ulong psDash = 1
constant ulong psDot = 2
constant ulong psDashDot = 3
constant ulong psDashDotDot = 4
constant ulong psClear = 5
constant ulong psInsideFrame = 6
constant ulong psSmallDots = 7

// EChartScroll
constant ulong pmNone = 0	
constant ulong pmHorizontal = 1
constant ulong pmVertical = 2
constant ulong pmBoth = 3

// EChartTheme
constant ulong ctDefault = 0
constant ulong ctExcel = 1
constant ulong ctClassic = 2
constant ulong ctBusiness = 3
constant ulong ctWeb = 4
constant ulong ctWindowsXP = 5
constant ulong ctBlueSky = 6
constant ulong ctFacts = 7
constant ulong ctRandom = 8
constant ulong ctOpera = 9
constant ulong ctBlackIsBack = 10
constant ulong ctgGrayscale = 11
constant ulong ctSpeed = 12

// ECheckBoxesStyle
constant ulong cbsCheck = 0
constant ulong cbsRadio = 1

// ECMFStyle
constant ulong cmfLine = 0 
constant ulong cmfArea = 1
constant ulong cmfVolume = 2 
constant ulong cmfHistogram = 3

// EColorLineStyle
constant ulong clCustom = 0 
constant ulong clMaximum = 1
constant ulong clCenter = 2 
constant ulong clMinimum = 3

// EColorPalette
constant ulong cpTeeChart = 0
constant ulong cpExcel = 1
constant ulong cpVictorian = 2
constant ulong cpPastel = 3
constant ulong cpSolid = 4
constant ulong cpClassic = 5
constant ulong cpWeb = 6
constant ulong cpModern = 7
constant ulong cpRainbow = 8
constant ulong cpWindowsXP = 9
constant ulong cpMacOS = 10
constant ulong cpWinVista = 11
constant ulong cpGrayScale = 12
constant ulong cpOpera = 13
constant ulong cpWarm = 14
constant ulong cpCool = 15
constant ulong cpBlackIsBack = 16

// ECompressionPeriod
constant ulong ocDay = 0
constant ulong ocWeek = 1
constant ulong ocMonth = 2
constant ulong ocBiMonth = 3
constant ulong ocQuarter = 4
constant ulong ocYear = 5

// EConstants
constant ulong clTeeColor = 536870912
constant ulong clNone = 536870911

// ECursorToolStyle
constant ulong cssHorizontal = 0
constant ulong cssVertical = 1
constant ulong cssBoth = 2
constant ulong cssScope = 3

// ECustomSeriesStack
constant ulong cssNone = 0 
constant ulong cssOverlap = 1 
constant ulong cssStack = 2 
constant ulong cssStack100 = 3

// EDatasourceType
constant ulong dstAllRecords = 0 
constant ulong dstSingleRecord = 1

// EDateTimeStep
constant ulong dtOneMicrosecond = 0
constant ulong dtOneMillisecond = 1
constant ulong dtOneSecond = 2
constant ulong dtFiveSeconds = 3
constant ulong dtTenSeconds = 4
constant ulong dtFifteenSeconds = 5
constant ulong dtThirtySeconds = 6
constant ulong dtOneMinute = 7
constant ulong dtFiveMinutes = 8
constant ulong dtTenMinutes = 9
constant ulong dtFifteenMinutes = 10
constant ulong dtThirtyMinutes = 11
constant ulong dtOneHour = 12
constant ulong dtTwoHours =13
constant ulong dtSixHours = 14
constant ulong dtTwelveHours = 15
constant ulong dtOneDay = 16
constant ulong dtTwoDays = 17
constant ulong dtThreeDays = 18
constant ulong dtOneWeek = 19
constant ulong dtHalfMonth = 20
constant ulong dtOneMonth = 21
constant ulong dtTwoMonths = 22
constant ulong dtThreeMonths =23 
constant ulong dtFourMonths = 24
constant ulong dtSixMonths = 25
constant ulong dtOneYear = 26
constant ulong dtNone = 27

// EDeltaImageStyle
constant ulong disSmiles = 0
constant ulong disHands = 1

// EDigitalFont
constant ulong dfBar = 0
constant ulong dfDot = 1
constant ulong dfCustom = 2

// EDownSampleMethod
constant ulong dsDouglas = 0
constant ulong dsMax = 1
constant ulong dsMin = 2
constant ulong dsMinMax = 3
constant ulong dsAverage = 4
constant ulong dsMinMaxFirstLast = 5
constant ulong dsMinMaxFirstLastNull = 5

// EDragMode
constant ulong dmManual = 0
constant ulong dmAutomatic = 1

// EDragPointStyle
constant ulong dsX = 0
constant ulong dsY = 1
constant ulong dsBoth = 2

// EDragState 
constant ulong dsDragEnter = 0
constant ulong dsDragLeave = 1
constant ulong dsDragMove = 2

// EDrawAllPointsStyle
constant ulong daFirst = 0
constant ulong daMinMax = 1

// EDrawLineStyle
constant ulong dlLine = 0
constant ulong dlHorizParallel = 1
constant ulong dlVertParallel = 2
constant ulong dlRectangle = 3
constant ulong dlEllipse = 4

// EEdgeStyle
constant ulong edFlat = 0
constant ulong edCurved = 1
constant ulong edNone = 2

// EErrorSeriesStyle
constant ulong essLeft = 0
constant ulong essRight = 1
constant ulong essLeftRight = 2
constant ulong essTop = 3
constant ulong essBottom = 4
constant ulong essTopBottom = 5

// EErrorWidthUnits 
constant ulong ewuPercent = 0
constant ulong ewuPixels= 1

// EFaderStyle
constant ulong fsFadeIn = 0
constant ulong fsFadeOut = 1

// EFibonacciStyle
constant ulong fsArc = 0
constant ulong fsFan = 1

// EFilterClass
constant ulong fcConvolve = 0
constant ulong fcBlur = 1
constant ulong fcResize = 2
constant ulong fcCrop = 3
constant ulong fcInvert = 4
constant ulong fcGrayScale = 5
constant ulong fcFlip = 6
constant ulong fcReverse = 7
constant ulong fcAmount = 8
constant ulong fcMosaic = 9
constant ulong fcBrightness = 10
constant ulong fcContrast = 11
constant ulong fcColor = 12
constant ulong fcHueLumSat = 13
constant ulong fcSharpen = 14
constant ulong fcEmboss = 15
constant ulong fcSoften = 16
constant ulong fcGammaCorrection = 17
constant ulong fcRotate = 18
constant ulong fcMirror = 19
constant ulong fcTile = 20
constant ulong fcBevel = 21
constant ulong fcZoom = 22
constant ulong fcLighting = 23


// EFunctionPeriodAlign
constant ulong paFirst = 0
constant ulong paCenter = 1
constant ulong paLast = 2

// EFunctionPeriodStyle
constant ulong psNumPoints = 0
constant ulong psRange = 1

// EFunctionType
constant ulong tfCopy = 0
constant ulong tfAdd = 1
constant ulong tfSubtract = 2
constant ulong tfMultiply = 3
constant ulong tfDivide = 4
constant ulong tfAverage = 5
constant ulong tfHigh = 6
constant ulong tfLow = 7
constant ulong tfMovavg = 8
constant ulong tfExpavg = 9
constant ulong tfMomentum = 10
constant ulong tfCurveFit = 11
constant ulong tfRSI = 12
constant ulong tfTrend = 13
constant ulong tfStdDeviation = 14
constant ulong tfCumulative = 15
constant ulong tfCount = 16
constant ulong tfExpTrend = 17
constant ulong tfExpMovAvg = 18
constant ulong tfMomentumDiv = 19
constant ulong tfRMS = 20
constant ulong tfMACD = 21
constant ulong tfStochastic = 22
constant ulong tfBollinger = 23
constant ulong tfADX = 24
constant ulong tfSmoothing = 25
constant ulong tfCustom = 26
constant ulong tfCompress = 27
constant ulong tfCrossPoints = 28
constant ulong tfCLV = 29
constant ulong tfOBV = 30
constant ulong tfCCI = 31
constant ulong tfPVO = 32
constant ulong tfPerformance = 33
constant ulong tfMode = 34
constant ulong tfMedian = 35
constant ulong tfCorrelation = 36
constant ulong tfVariance = 37
constant ulong tfPerimeter = 38
constant ulong tfDownSampleFun = 39
constant ulong tfSubset = 40
constant ulong tfHistogram = 41
constant ulong tfSAR = 42
constant ulong tfPercentChange = 43
constant ulong tfSlope = 44
constant ulong tfSkewness = 45
constant ulong tfKurtosis = 46
constant ulong tfSmoothedMovAvg = 47
constant ulong tfATR = 48
constant ulong tfRVI = 49
constant ulong tfAwesomeOscillator = 50
constant ulong tfAC = 51
constant ulong tfAlligator = 52
constant ulong tfGator = 53
constant ulong tfMoneyFlow = 54

// EGanttToolPartBar
constant ulong pbStart = 0
constant ulong pbAll = 1
constant ulong pbEnd = 2

// EGaugePointerStyles
constant ulong gpHand = 0
constant ulong gpCenter = 1
constant ulong gpTick = 2
constant ulong gpMinorTick = 3
constant ulong gpColorLine = 4

// EGIFColorReduction
constant ulong rmNone = 0 
constant ulong rmWindows20 = 1 
constant ulong rmWindows256 = 2 
constant ulong rmWindowsGray = 3 
constant ulong rmMonochrome = 4 
constant ulong rmGrayScale = 5 
constant ulong rmNetscape = 6 
constant ulong rmQuantize = 7 
constant ulong rmQuantize256 = 8

// EGIFCompression
constant ulong gcLZW = 0 
constant ulong gcRLE = 1

// EGIFDitherMode
constant ulong dmNearest = 0 
constant ulong dmFloydSteinberg = 1 
constant ulong dmStucki = 2 
constant ulong dmSierra = 3 
constant ulong dmJaJuNI = 4 
constant ulong dmSteveArche = 5 
constant ulong dmBurkes = 6

// EGradientDirection 
constant ulong gdTopBottom = 0
constant ulong gdBottomTop = 1
constant ulong gdLeftRight = 2
constant ulong gdRightLeft = 3
constant ulong gdFromCenter = 4
constant ulong gdFromTopLeft = 5
constant ulong gdFromBottomLeft = 6
constant ulong gdRadial = 7
constant ulong gdDiagonalUp = 8
constant ulong gdDiagonalDown = 9

// EGrayMethod
constant ulong gmSimple = 0
constant ulong gmEye = 1
constant ulong gmEye2 = 2

// EGroupFormula
constant ulong gfCount = 0
constant ulong gfSum = 1

// EHandStyle
constant ulong hsLine = 0
constant ulong hsTriangle = 1

// EHorizontalAxis
constant ulong aTopAxis = 0
constant ulong aBottomAxis = 1
constant ulong aBothHorizAxis = 2
constant ulong aCustomHorizAxis = 3

// EJPEGPerformance
constant ulong jpegBestQuality = 0
constant ulong jpegBestSpeed = 1

// ELanguage
constant ulong laEnglish = 0
constant ulong laBrazilianPortuguese = 1
constant ulong laCatalan = 2
constant ulong laChineseSimple = 3
constant ulong laChineseTraditional = 4
constant ulong laDanish = 5
constant ulong laDutch = 6
constant ulong laFrench = 7
constant ulong laGerman = 8
constant ulong laItalian = 9
constant ulong laPortuguese = 10
constant ulong laRussian = 11
constant ulong laSpanish = 12
constant ulong laSwedish = 13
constant ulong laNorwegian = 14
constant ulong laJapanese = 15
constant ulong laPolish = 16
constant ulong laSlovene = 17
constant ulong laTurkish = 18
constant ulong laHungarian = 19
constant ulong laGalician = 20
constant ulong laArabic = 21
constant ulong laHebrew = 22
constant ulong laUkrainian = 23
constant ulong laKorean = 24
constant ulong laIndonesian = 25
constant ulong laFinnish = 26
constant ulong laSlovak = 27
constant ulong laHellenic = 28
constant ulong laRomanian = 29
constant ulong laSerbian = 30
constant ulong laFarsi = 31
constant ulong laCzech = 32
constant ulong laHindi = 33
constant ulong laUrdu = 34
constant ulong laMalaysian = 35
constant ulong laCroatian = 36
constant ulong laBulgarian = 37

// ELegendAlignment
constant ulong laLeft = 0
constant ulong laRight = 1
constant ulong laTop = 2
constant ulong laBottom = 3

// ELegendPaletteAxis
constant ulong laDefault = 0
constant ulong laOther = 1
constant ulong laBoth = 2

// ELegendStyle
constant ulong lsAuto = 0
constant ulong lsSeries = 1
constant ulong lsValues = 2
constant ulong lsLastValues = 3
constant ulong lsSeriesGroups = 4

// ELegendSymbolPosition
constant ulong spLeft = 0 
constant ulong spRight = 1

// ELegendSymbolSize
constant ulong lcsPercent = 0 
constant ulong lcsPixels = 1

// ELegendTextStyle
constant ulong ltsPlain = 0
constant ulong ltsLeftValue =1
constant ulong ltsRightValue =2
constant ulong ltsLeftPercent = 3
constant ulong ltsRightPercent = 4
constant ulong ltsXValue = 5
constant ulong ltsValue = 6
constant ulong ltsPercent = 7
constant ulong ltsXAndValue = 8
constant ulong ltsXAndPercent = 9
constant ulong ltsXAndText = 10

// ELightStyle
constant ulong lsLinear = 0
constant ulong lsSpotLight = 1

// ELoadMode
constant ulong lmClear = 0
constant ulong lmAppend = 1

// EMapMarksText
constant ulong mtLabel = 0
constant ulong mtCode = 1
constant ulong mtBoth = 2

// EMapRenderMode
constant ulong rmDefault = 0
constant ulong rm2D = 1
constant ulong rm3D = 2

// EMarginsUnits
constant ulong maPercentFont = 0
constant ulong maPercentSize = 1
constant ulong maPixels = 2

// EMarginUnits
constant ulong muPercent = 0 
constant ulong muPixels = 1

// EMarksLocation
constant ulong mlStart = 0
constant ulong mlCenter = 1
constant ulong mlEnd = 2

// EMarkStyle
constant ulong smsValue = 0
constant ulong smsPercent = 1
constant ulong smsLabel = 2
constant ulong smsLabelPercent = 3
constant ulong smsLabelValue = 4
constant ulong smsLegend = 5
constant ulong smsPercentTotal = 6
constant ulong smsLabelPercentTotal = 7
constant ulong smsXValue = 8
constant ulong smsXY = 9
constant ulong smsSeriesTitle = 10
constant ulong smsPointIndex = 11
constant ulong smsPercentRelative = 12
constant ulong smsLabelPercentValue = 13
constant ulong smsLabelOrValue = 14

// EMarkToolMouseAction
constant ulong mtmMove = 0
constant ulong mtmClick = 1

// EMirrorDirection
constant ulong mdDown = 0
constant ulong mdUp = 1
constant ulong mdRight = 2
constant ulong mdLeft = 3

// EMouseButton
constant ulong mbLeft = 1
constant ulong mbRight = 2
constant ulong mbMiddle = 4

// EMultiArea
constant ulong maNone = 0
constant ulong maStacked = 1
constant ulong maStacked100 = 2

// EMultiBar
constant ulong mbNone = 0
constant ulong mbSide = 1
constant ulong mbStacked = 2
constant ulong mbStacked100 = 3
constant ulong mbSideAll = 4
constant ulong mbSelfStack = 5

// EMUltiPie
constant ulong mpAutomatic = 0
constant ulong mpDisabled = 1

// EMultiRose
constant ulong MrNone = 0
constant ulong mrStacked = 1

// ENearestToolStyle
constant ulong hsNone = 0 
constant ulong hsCircle = 1
constant ulong hsRectangle = 2
constant ulong hsDiamond = 3
constant ulong hsSeries = 4

// EOrgLineStyle
constant uint lsSquared = 0
constant uint lsDiagonal = 1

// EPaletteStyle
constant ulong psPale = 0
constant ulong psStrong = 1
constant ulong psGrayScale = 2
constant ulong psInvGray = 3
constant ulong psRainbow = 4
constant ulong psCustom = 5

// EPanelBevel
constant ulong bvNone = 0
constant ulong bvLowered = 1
constant ulong bvRaised = 2

// EPenEndStyle 
constant ulong esRound = 0
constant ulong esSquare = 1
constant ulong esFlat = 2

// EPenLineMode
constant ulong lmLine = 0
constant ulong lmCylinder = 1
constant ulong lmRectangle = 2

// EPenMode
constant ulong pmBlack = 0
constant ulong pmWhite = 1
constant ulong pmNop = 2
constant ulong pmNot = 3
constant ulong pmCopy = 4
constant ulong pmNotCopy = 5
constant ulong pmMergePenNot = 6
constant ulong pmMaskPenNot = 7
constant ulong pmMergeNotPen = 8
constant ulong pmMaskNotPen = 9
constant ulong pmMerge = 10
constant ulong pmNotMerge = 11
constant ulong pmMask = 12
constant ulong pmNotMask = 13
constant ulong pmXor = 14
constant ulong pmNotXor = 15

// EPieOtherStyle 
constant ulong poNone = 0
constant ulong poBelowPercent = 1
constant ulong poBelowValue = 2

// EPieToolStyle
constant ulong ptFocus = 0
constant ulong ptExplode = 1

// EPixelFormat
constant ulong pfDevice = 0
constant ulong pf1bit = 1
constant ulong pf4bit = 2
constant ulong pf8bit = 3
constant ulong pf15bit = 4
constant ulong pf16bit = 5
constant ulong pf24bit = 6
constant ulong pf32bit = 7

// EPointerSizeUnits
constant ulong suPixels = 0
constant ulong suAxis = 1

// EPointerStyle
constant ulong psRectangle = 0
constant ulong psCircle = 1
constant ulong psTriangle = 2
constant ulong psDownTriangle = 3
constant ulong psCross = 4
constant ulong psDiagCross = 5
constant ulong psStar = 6
constant ulong psDiamond = 7
constant ulong psSmallDot = 8
constant ulong psNothing = 9
constant ulong psLeftTriangle = 10
constant ulong psRightTriangle = 11
constant ulong psHexagon = 12
constant ulong psVisual = 13
constant ulong psDonut = 14
constant ulong psArrow = 15

// EPositionUnits
constant ulong puPercent = 0
constant ulong puPixels = 1

// EPrinterOrientation
constant ulong poPortrait = 0
constant ulong poLandscape = 1

// ERotateToolStyle
constant ulong rsAll = 0
constant ulong rsRotation = 1
constant ulong rsElevation = 2

// ERSIStyle
constant ulong rsiOpenClose = 0 
constant ulong rsiClose = 1

// EScopeCursorStyle
constant ulong scsRectangle = 0
constant ulong scsCircle = 1
constant ulong scsDiamond = 2
constant ulong scsEmpty = 3
constant ulong scsCamera = 4

// EScrollBarDrawStyle
constant ulong dsAlways = 0
constant ulong dsWhenNeeded = 1

// EScrollDirection
constant ulong sdRightLeft = 0
constant ulong sdLeftRight = 1

// EScrollThumbStyle
constant ulong stsCustom = 0
constant ulong stsThumb1 = 1
constant ulong stsThumb2 = 2
constant ulong stsThumb3 = 3

// ESeriesAnimationLoop
constant ulong salNo = 0
constant ulong salOneWay = 1
constant ulong salCircular = 2

// ESeriesClass
constant ulong scLine = 0
constant ulong scBar = 1
constant ulong scHorizBar = 2
constant ulong scArea = 3
constant ulong scPoint = 4
constant ulong scPie = 5
constant ulong scFastLine = 6
constant ulong scShape = 7
constant ulong scGantt = 8
constant ulong scBubble = 9
constant ulong scArrow = 10
constant ulong scCandle = 11
constant ulong scPolar = 12
constant ulong scSurface = 13
constant ulong scVolume = 14
constant ulong scErrorBar = 15
constant ulong scBezier = 16
constant ulong scContour = 17
constant ulong scError = 18
constant ulong scPoint3D = 19
constant ulong scRadar = 20
constant ulong scClock = 21 
constant ulong scWindRose= 22  
constant ulong scBar3D = 23  
constant ulong scImageBar = 24  
constant ulong scDonut = 25 
constant ulong scTriSurface = 26 
constant ulong scBox = 27 
constant ulong scHorizBox = 28 
constant ulong scHistogram = 29 
constant ulong scColorGrid = 30 
constant ulong scBarJoin = 31 
constant ulong scHighLow = 32 
constant ulong scWaterfall = 33 
constant ulong scSmith = 34 
constant ulong scPyramid = 35 
constant ulong scMap = 36
constant ulong scHorizLine = 37
constant ulong scFunnel = 38
constant ulong scCalendar = 39
constant ulong scHorizArea = 40
constant ulong scPointFigure = 41
constant ulong scGauge = 42
constant ulong scVector3D = 43
constant ulong scTower = 44
constant ulong scPolarBar = 45
constant ulong scBubble3D = 46
constant ulong scHorizHistogram = 47
constant ulong scVolumePipe = 48
constant ulong scIsoSurface = 49
constant ulong scDarvas = 50
constant ulong scHighLowLine = 51
constant ulong scPolarGrid = 52
constant ulong scDeltaPoint = 53
constant ulong scImagePoint = 54
constant ulong scOrganizational = 55
constant ulong scWorld = 56
constant ulong scTagCloud = 57
constant ulong scKagi = 58
constant ulong scRenko = 59
constant ulong scNumericGauge = 60
constant ulong scLinearGauge = 61
constant ulong scCircularGauge = 62
constant ulong scBigCandle = 63
constant ulong scLinePoint = 64
constant ulong scKnob = 65
constant ulong scRose = 66
constant ulong scTernary = 67
constant ulong scTreeMap = 68
constant ulong scErrorPoint = 69
constant ulong scErrorPoint3D = 70
constant ulong scEquiVolume = 71
constant ulong scDoubleHorizBar = 72
constant ulong scPolarContour = 73

// ESeriesGroupActive
constant ulong gaYes = 0
constant ulong gaNo = 1
constant ulong gaSome = 2

// EShapeStyle
constant ulong chasRectangle = 0
constant ulong chasCircle = 1
constant ulong chasVertLine = 2
constant ulong chasHorizLine = 3
constant ulong chasTriangle = 4
constant ulong chasInvertTriangle = 5
constant ulong chasLine = 6
constant ulong chasDiamond = 7
constant ulong chasCube = 8
constant ulong chasCross = 9
constant ulong chasDiagCross = 10
constant ulong chasStar = 11
constant ulong chasPyramid = 12
constant ulong chasInvertPyramid = 13

// EShapeXYStyle
constant ulong xysPixels = 0
constant ulong xysAxis = 1
constant ulong xysAxisOrigin = 2

// EShiftState
constant ulong ssShift = 1
constant ulong ssAlt = 2
constant ulong ssCtrl = 4
constant ulong ssNone = 0

// ESnapStyle
constant ulong ssDefault = 0
constant ulong ssHorizontal = 1
constant ulong ssVertical = 2

// EStreamType
constant ulong stJpeg = 0
constant ulong stTeeTemplate = 1

// ETabPosition
constant ulong tpTop = 0
constant ulong tpBottom = 1
constant ulong tpLeft = 2
constant ulong tpRight = 3

// ETabStyle
constant ulong tsTabs = 0
constant ulong tsButtons = 1
constant ulong tsFlatButtons = 2

// ETagCloudOrder
constant ulong toText = 0
constant ulong toValue = 1
constant ulong toNone = 2

// ETeeCommanderControls
constant ulong tcbNormal = 0 
constant ulong tcbSeparator = 1
constant ulong tcbRotate = 2 
constant ulong tcbMove = 3 
constant ulong tcbZoom = 4 
constant ulong tcbDepth = 5 
constant ulong tcbEdit = 6 
constant ulong tcbPrintPreview = 7
constant ulong tcbCopy = 8 
constant ulong tcbSave = 9 
constant ulong tcbLabel = 10
constant ulong tcb3D = 11

// ETeeEditorPage
constant ulong epMain = 0
constant ulong epGeneral = 1
constant ulong epAxis = 2
constant ulong epTitles = 3
constant ulong epLegend = 4
constant ulong epPanel = 5
constant ulong epPaging = 6
constant ulong epWalls = 7
constant ulong epAspect = 8
constant ulong epSeriesGeneral = 9
constant ulong epSeriesMarks = 10 
constant ulong epAllSeries = 11 
constant ulong epSeriesData = 12 
constant ulong epExport = 13 
constant ulong epTools = 14 
constant ulong epPrintPreview = 15
constant ulong epOpenGL = 16

// ETeePreviewPanelOrientation
constant ulong ppoDefault = 0
constant ulong ppoPortrait = 1
constant ulong ppoLandscape = 2

// ETeeVertAlign
constant ulong vaTop = 0 
constant ulong vaCenter = 1 
constant ulong vaBottom = 2

// ETeeZoomDirection
constant ulong tzdHorizontal = 0
constant ulong tzdVertical = 1
constant ulong tzdBoth = 2

// ETernaryStyle
constant ulong tsPoint = 0
constant ulong tsBubble = 1

// ETernaryAxisScale
constant ulong tlasUnit = 0
constant ulong tlasPercent = 1

// ETernaryFormat
constant ulong tlfTernary = 0
constant ulong tlfPiper = 1

// ETernaryLegendStyle
constant ulong tlsValues = 0
constant ulong tlsValuesBubble = 1
constant ulong tlsValuesBubbleWeight = 2
constant ulong tlsBubble = 3
constant ulong tlsBubbleWeight = 4
constant ulong tlsWeight = 5

// ETernaryMarkStyle
constant ulong tmsShort = 0
constant ulong tmsLong = 1
constant ulong tmsLongLabelled = 2

// ETextAlignment
constant ulong aLeft = 0
constant ulong aRight = 1
constant ulong aCenter = 2

// ETextFormat
constant ulong ttfNormal = 0
constant ulong ttfHtml = 1

// ETitleAlignment
constant ulong taLeftJustify = 0
constant ulong taRightJustify = 1
constant ulong taCenter = 2

// EToolClass
constant ulong tcCursor = 0 
constant ulong tcDragMarks = 1 
constant ulong tcAxisArrow = 2 
constant ulong tcDrawLine = 3 
constant ulong tcNearest = 4 
constant ulong tcColorband = 5 
constant ulong tcColorLine = 6 
constant ulong tcRotate = 7
constant ulong tcMarksTip = 8
constant ulong tcChartImage = 9
constant ulong tcAnnotate = 10
constant ulong tcPageNumber = 11
constant ulong tcGridTranspose = 12
constant ulong tcExtraLegend = 13
constant ulong tcSeriesAnimation = 14
constant ulong tcGantt = 15
constant ulong tcGridBand = 16
constant ulong tcPie = 17
constant ulong tcDragPoint = 18
constant ulong tcLegendScrollBar = 19
constant ulong tcLight = 20
constant ulong tcSurfaceNearest = 21
constant ulong tcAxisScroll = 22
constant ulong tcSeriesBand = 23
constant ulong tcSelector = 24
constant ulong tcRectangle = 25
constant ulong tcDataTable = 26
constant ulong tcClipSeries = 27
constant ulong tcSeriesStats = 28
constant ulong tcVideo = 29
constant ulong tcVideoPlayer = 30
constant ulong tcTransposeSeries = 31
constant ulong tcSeriesRegion = 32
constant ulong tcAntiAlias = 33
constant ulong tcFader = 34
constant ulong tcFrame = 35
constant ulong tcMagnify = 36
constant ulong tcLegendPalette = 37
constant ulong tcBanner = 38
constant ulong tcText3D = 39
constant ulong tcSubChart = 40
constant ulong tcLink = 41
constant ulong tcFibonacci = 42
constant ulong tcFullScreen = 43
constant ulong tcAxisBreaks = 44
constant ulong tcClustering = 45
constant ulong tcRepaintMonitor = 46
constant ulong tcArrow = 47
constant ulong tcScrollPager = 48
constant ulong tcAxisScrollBar = 49

// ETowerStacked
constant ulong tsNone = 0
constant ulong tsStacked = 1
constant ulong tsStacked100 = 2

// ETowerStyle
constant ulong tsCube = 0
constant ulong tsRectangle = 1
constant ulong tsCover = 2
constant ulong tsCylinder = 3
constant ulong tsArrow = 4
constant ulong tsCone = 5
constant ulong tsPyramid = 6
constant ulong tsSlantCube = 7

// ETreatNullsStyle
constant ulong tnDontPaint = 0 
constant ulong tnSkip = 1
constant ulong tnIgnore = 2

// ETreeMapTiling
constant ulong tmSlice = 0 
constant ulong tmStrip = 1

// ETypeFitting
constant ulong cfPolynomial = 0
constant ulong cfLogarithmic = 1
constant ulong cfExponential = 2

// EValueListOrder
constant ulong loNone = 0
constant ulong loAscending = 1
constant ulong loDescending = 2

// EVerticalAxis
constant ulong aLeftAxis = 0
constant ulong aRightAxis = 1
constant ulong aBothVertAxis = 2
constant ulong aCustomVertAxis = 3

// EWorldMap
constant ulong wmWorld = 0
constant ulong wmAfrica = 1
constant ulong wmAsia = 2
constant ulong wmAustralia = 3
constant ulong wmCentralAmerica = 4
constant ulong wmEurope = 5
constant ulong wmEurope15 = 6
constant ulong wmEurope27 = 7
constant ulong wmSpain = 8
constant ulong wmMiddleEast = 9
constant ulong wmNorthAmerica = 10
constant ulong wmSouthAmerica = 11
constant ulong wmUSA = 12
constant ulong wmUSAHawaiiAlaska = 13
constant ulong wmEurasia = 14
constant ulong wmUK = 15
constant ulong wmGermany = 16
constant ulong wmUSACounties = 17
constant ulong wmUSAAlaskaCounties = 18
constant ulong wmJapan = 19
constant ulong wmChina = 20
constant ulong wmFrance = 21

// EPanMouseWheel
constant ulong pmwNormal = 0
constant ulong pmwInverted = 1
constant ulong pmwNone = 2

// TeeChart Color Palette
long il_teechart_color[26]

private:
	window iw_parent
	
public:
	boolean FixedToRight
	boolean FixedToBottom
	boolean ScaleToRight
	boolean ScaleToBottom


// Primary function list of TeeChart
//OLEControl.object.ApplyPalette(int paletteIndex)
//OLEControl.object.ClearChart()
//OLEControl.object.CloneSeries(long SourceSeriesIndex)
//OLEControl.object.GetFreeSeriesColor(boolean CheckBackgroundColor)
//OLEControl.object.IsFreeSeriesColor(unsigned long AColor, boolean CheckBackgroundColor)
//OLEControl.object.RefreshData()
//OLEControl.object.RemoveAllSeries()
//OLEControl.object.Repaint()
//OLEControl.object.Series(long SeriesIndex)
//OLEControl.object.SetTheme(int aTheme, int aPalette)
//OLEControl.object.ShowEditor(long SeriesIndex)
//OLEControl.object.ShowHint(boolean ShowHint)
//OLEControl.object.ShowSeriesEditor(long SeriesIndex)
//OLEControl.object.ShowThemesEditor()
//OLEControl.object.StopMouse()
//OLEControl.object.TimerEnabled(boolean TimerEnabled)
//OLEControl.object.TimerInterval(long TimerInterval)
//OLEControl.object.ZoomWheel(int ZoomWheel)

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_setstyle (string as_style)
end prototypes

public function string of_getclassname ();return 'pf_u_teechart'

end function

public function integer of_setstyle (string as_style);// 사용자 정의 TeeChart 차트 스타일을 지정 합니다. 현재 'simple' 스타일 한 가지입니다.
// 이 함수를 호출 후 TeeChart 로직을 추가해 주시기 바랍니다.
// 각종 TeeChart 속성 및 함수는 샘플 프로그램을 참고하세요.

choose case as_style
	case 'simple'
		//Bar chart Design
		this.object.Border = false
		
		//3D effect
		this.object.Aspect.View3D = false
		
		//Walls
		this.object.Walls.Visible = false
		
		//Panel
		this.object.Panel.Color = RGB(255, 255, 255)
		this.object.Panel.BevelInner = 0
		this.object.Panel.BevelOuter = 0
		
		this.object.Panel.Border.Visible = true
		this.object.Panel.Border.Width = 1
		this.object.Panel.Border.Color = RGB(229, 229, 229)
		
		//Legend Transparent
		this.object.Legend.Transparent = true
		this.object.Legend.Font.Name = "맑은 고딕"
		this.object.Legend.Font.Size = 8
		this.object.Legend.Font.Color = RGB(162, 162, 164)
		
		//Bottom Axis Ticks Visible
		this.object.Axis.Bottom.Ticks.Visible = false
		this.object.Axis.Bottom.TicksInner.Visible = false
		this.object.Axis.Bottom.MinorTicks.Visible = false
		
		//Bottom Axis Ticks Color, Width
		this.object.Axis.Bottom.AxisPen.Color = RGB(208, 208, 211)
		this.object.Axis.Bottom.AxisPen.Width = 2
		
		//Bottom Axis Labels Font Color, Size
		this.object.Axis.Bottom.Labels.Font.Name = "맑은 고딕"
		this.object.Axis.Bottom.Labels.Font.Size = 8
		this.object.Axis.Bottom.Labels.Font.Color = RGB(162, 162, 164)
		
		//Bottom Axis Grid Visible
		this.object.Axis.Bottom.GridPen.Visible = false
		
		//Left Axis Ticks Visible
		this.object.Axis.Left.Ticks.Visible = false
		this.object.Axis.Left.TicksInner.Visible = false
		this.object.Axis.Left.MinorTicks.Visible = false
		
		//Left Axis Ticks Color, Width
		this.object.Axis.Left.AxisPen.Color = RGB(208, 208, 211)
		this.object.Axis.Left.AxisPen.Width = 2
		
		//Left Axis Labels Font Color, Size
		this.object.Axis.Left.Labels.Font.Name = "맑은 고딕"
		this.object.Axis.Left.Labels.Font.Size = 8
		this.object.Axis.Left.Labels.Font.Color = RGB(162, 162, 164)
		
		//Left Axis Grid Visible
		this.object.Axis.Left.GridPen.Visible = false
		
		//Header
		this.object.header.Font.Color = RGB(39,39,39)
		this.object.header.Font.Name = "맑은 고딕"
		this.object.header.Font.Size = 10
		this.object.header.Font.Bold = true
end choose

Return 0

end function

on pf_u_teechart.create
end on

on pf_u_teechart.destroy
end on

event constructor;// Define TeeChart Color Palette
il_teechart_color[1] = RGB(70, 111, 133)
il_teechart_color[2] = RGB(232, 112, 49)
il_teechart_color[3] = RGB(212, 180, 72)
il_teechart_color[4] = RGB(126, 117, 58)
il_teechart_color[5] = RGB(79, 129, 188)
il_teechart_color[6] = RGB(192, 80, 78)
il_teechart_color[7] = RGB(155, 187, 88)
il_teechart_color[8] = RGB(255, 169, 20)
il_teechart_color[9] = RGB(62, 70, 46)
il_teechart_color[10] = RGB(146, 98, 0)
il_teechart_color[11] = RGB(31, 72, 124)
il_teechart_color[12] = RGB(98, 118, 58)
il_teechart_color[13] = RGB(96, 74, 123)
il_teechart_color[14] = RGB(74, 90, 105)
il_teechart_color[15] = RGB(47, 170, 201)
il_teechart_color[16] = RGB(124, 172, 172)
il_teechart_color[17] = RGB(159, 33, 33)
il_teechart_color[18] = RGB(124, 120, 117)
il_teechart_color[19] = RGB(0, 98, 41)
il_teechart_color[20] = RGB(38, 53, 138)
il_teechart_color[21] = RGB(171, 119, 72)
il_teechart_color[22] = RGB(141, 121, 148)
il_teechart_color[23] = RGB(245, 134, 45)
il_teechart_color[24] = RGB(194, 82, 60)
il_teechart_color[25] = RGB(137, 28, 72)
il_teechart_color[26] = RGB(96, 74, 123)

// Get Parent Window
iw_parent = pf_f_getparentwindow(this)

// PostOpen 이벤트 호출
this.post event pfe_postopen()

//// Teechart Properties
//// 범례(Legend) 속성
//this.object.Legend.Visible = true
//this.object.Legend.DividingLines.Visible = true
//this.object.Legend.ResizeChart = true
//this.object.Legend.Font.Bold = True
//
//// Aspect 속성
//// change 3D percent effect...
//this.object.Aspect.View3D = True
//this.object.Aspect.Chart3DPercent = 80
//this.object.Aspect.Perspective = 50
//
//// change OpenGL effect
//this.object.Aspect.OpenGL.Active = True
//this.object.Aspect.ZoomText = True
//
//// Light for OpenGL
//this.object.Aspect.OpenGL.LightPosition.X = -90
//this.object.Aspect.OpenGL.LightPosition.Y = -110
//this.object.Aspect.OpenGL.LightPosition.Z = -120
//
//this.object.Aspect.Zoom = 100 // 0 ~ 500
//this.object.Aspect.Rotation = 360 - 30
//this.object.Aspect.Elevation = 360 - 30
//
//this.object.Aspect.HorizOffset = 0 // -1500 ~ 1500
//this.object.Aspect.VertOffset = 0 // -1500 ~ 1500
//
//// TeeChart 속성
//this.object.ShowEditor()
//this.object.StopMouse()
//this.object.Repaint()
//
//// Chart Frame 속성
//this.object.Frame.Visible = True
//// Walls 속성
//this.object.Walls.Visible = True
//// Timer Interval
//this.object.TimerInterval = 100
//
//// Axis 속성
//this.object.Axis.Right.Visible = True
//this.object.Axis.Top.Visible = True
//this.object.Axis.Left.Visible = True
//this.object.Axis.Bottom.Visible = True
//this.object.Axis.Left.SetMinMax(-100, 1000)
//
//// Canvas 속성
//this.object.Canvas.Font.Bold = True
//this.object.Canvas.TextOut(this.object.Axis.Right.Position + 20, this.object.Axis.Bottom.Position - 50, "Y Data range:")
//this.object.Canvas.TextOut(this.object.Axis.Right.Position + 20, this.object.Axis.Bottom.Position - 50 + this.object.Canvas.TextHeight("D") + 5, string(this.object.Series(0).YValues.Maximum - this.object.Series(0).YValues.Minimum))
//
//// Panel 속성
//this.object.Panel.Gradient.Visible = True
//this.object.Panel.Color = RGB(128, 128, 200)
//
//// Left and Right Margin
//this.object.Panel.MarginLeft = 3
//this.object.Panel.MarginRight = 38 - 35
//this.object.Panel.MarginTop = 3 
//this.object.Panel.MarginBottom = 38 - 35
//
//this.object.Panel.Gradient.Direction = gdLeftRight
//this.object.Panel.BackImageMode = pbmStretch
//this.object.Panel.BevelInner = bvNone
//
//this.object.Panel.BevelOffset = 1 // 1 to 100
//this.object.Panel.BevelWidth = 0 // 0 to 10
//
//// Walls 속성
//this.object.Walls.Back.Transparent = False
//this.object.Walls.Back.Brush.Color = RGB(0, 255, 0)	// vbGreen
//this.object.Walls.Left.Size = 4
//this.object.Walls.Bottom.Size = 4
//this.object.Walls.Back.Size = 4
//
//// Fill Sample Values
//this.object.Series(0).FillSampleValues(10)
//this.object.Series(1).FillSampleValues(10)
//
//// Export 속성
//this.object.Export.asPNG.SaveToFile(Filepath, Filename)
//this.object.Export.asPNG.SaveToStream()
//this.object.Export.asNative.SaveToStream(True)

end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
00pf_u_teechart.bin 
2900001200e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004000000050000000600000007fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000e822f4a001d255cc00000003000008800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000042700000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003cc0427c747702124eff94788c2cd504c00000000e822315001d255cce822f4a001d255cc000000000000000000000000004f00430054004e004f00520053004c005600410053004500520054004100450000004d0000000000000000000000000000000000000000000000000000000001020024ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000001100000427000000000000000100000002000000030000000400000005000000060000000700000008000000090000000a0000000b0000000c0000000d0000000e0000000f00000010fffffffe00000012000000130000001400000015000000160000001700000018000000190000001a0000001b0000001c0000001d0000001e0000001f0000002000000021fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
25ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff304650546843540b4374726174726168654c040000027466706f540357050002687464690601900367696548fa0374686142210061576b63422e6c6c687375726172472e6e65696469442e7474636572076e6f694264670b6f74746f706f546d636142206c61576b72422e6c2e68737564617247746e6569646e452e6f6c6f43630707726968576c42226574576b63612e6c6c617375724272472e6865696461532e746e747261746f6c6f43eaea0472421f00ea576b63612e6c6c617375724272472e6865696461562e746e626973691409656c6b6361426c6c61576172542e6170736e746e65726f460f08462e746f2e746e6f6f6c6f4363060772756c426c7247126565696461442e746e636572696e6f697464670b0774746f426f546d6f7247117065696461452e746e6f43646e07726f6c576c630765746968617247116e656964694d2e746c6f4364ea04726f1300eaea64617247746e65696174532e6f43747204726f6c00eaeaea66654c0e6c6157746f432e6c04726f6c00e0ffff6769520f61577468432e6c6c726f6c6fe0ffff04695412002e656c74747865547274532e73676e69540806016843656500747261746f4215416d6f742e736978736978416c6f432e4004726f1500404074746f4278416d6f472e73692e6469726f6c6f43a9a90472421b00a96f74746f6978416d69542e7349736b6372656e6e6c6f432ea904726f1400a9a9747065446978416878412e73432e7369726f6c6f4040400465441400416874702e736978646972476c6f432ea904726f1a00a9a9747065446978416869542e7349736b6372656e6e6c6f432ea904726f1700a9a974706544706f5468736978416978412e6f432e7304726f6c00404040706544176f5468746978417072472e73432e6469726f6c6fa9a9a90465441d00546874707841706f542e7369736b6369656e6e496f432e7204726f6c00a9a9a966654c136978417478412e73432e7369726f6c6f40404004654c130078417466472e73692e6469726f6c6f43a9a904724c1900a9417466652e7369786b6369546e6e4973432e7265726f6c6fa9a9a904654c1a00646e65676168532e2e776f646e6172547261707379636e654c1600026e65676569542e642e656c74746e6f466d614e2e410506656c6169726769521478417468412e73692e7369786f6c6f43404004725214004074686769736978416972472e6f432e6404726f6c00a9a9a96769521a78417468542e7369736b6369656e6e496f432e7204726f6c00a9a9a9706f5412736978416978412e6f432e7304726f6c00404040706f5412736978416972472e6f432e6404726f6c00a9a9a9706f5418736978416369542e6e49736b2e72656e6f6c6f43a9a90472440d00a9756166656143746c7361766e47540e066c504944614373757361766e6c6f43116150726f7474656c646e49650d02786500000000ff02000000ffffff000000000000000000000000000000000000000000000000304650546843540b4374726174726168654c040000027466706f540357050002687464690601900367696548fa0374686142210061576b63422e6c6c687375726172472e6e65696469442e7474636572076e6f694264670b6f74746f706f546d636142206c61576b72422e6c2e68737564617247746e6569646e452e6f6c6f43630707726968576c42226574576b63612e6c6c617375724272472e6865696461532e746e747261746f6c6f43eaea0472421f00ea576b63612e6c6c617375724272472e6865696461562e746e626973691409656c6b6361426c6c61576172542e6170736e746e65726f460f08462e746f2e746e6f6f6c6f4363060772756c426c7247126565696461442e746e636572696e6f697464670b0774746f426f546d6f7247117065696461452e746e6f43646e07726f6c576c630765746968617247116e656964694d2e746c6f4364ea04726f1300eaea64617247746e65696174532e6f43747204726f6c00eaeaea66654c0e6c6157746f432e6c04726f6c00e0ffff6769520f61577468432e6c6c726f6c6fe0ffff04695412002e656c74747865547274532e73676e69540806016843656500747261746f4215416d6f742e736978736978416c6f432e4004726f1500404074746f4278416d6f472e73692e6469726f6c6f43a9a90472421b00a96f74746f6978416d69542e7349736b6372656e6e6c6f432ea904726f1400a9a9747065446978416878412e73432e7369726f6c6f4040400465441400416874702e736978646972476c6f432ea904726f1a00a9a9747065446978416869542e7349736b6372656e6e6c6f432ea904726f1700a9a974706544706f5468736978416978412e6f432e7304726f6c00404040706544176f5468746978417072472e73432e6469726f6c6fa9a9a90465441d00546874707841706f542e7369736b6369656e6e496f432e7204726f6c00a9a9a966654c136978417478412e73432e7369726f6c6f40404004654c130078417466472e73692e6469726f6c6f43a9a904724c1900a9417466652e7369786b6369546e6e4973432e7265726f6c6fa9a9a904654c1a00646e65676168532e2e776f646e6172547261707379636e654c1600026e65676569542e642e656c74746e6f466d614e2e410506656c6169726769521478417468412e7369
2B2e7369786f6c6f43404004725214004074686769736978416972472e6f432e6404726f6c00a9a9a96769521a78417468542e7369736b6369656e6e496f432e7204726f6c00a9a9a9706f5412736978416978412e6f432e7304726f6c00404040706f5412736978416972472e6f432e6404726f6c00a9a9a9706f5418736978416369542e6e49736b2e72656e6f6c6f43a9a90472440d00a9756166656143746c7361766e47540e066c504944614373757361766e6c6f43116150726f7474656c646e49650d02786500000000ff02000000ffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10pf_u_teechart.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
