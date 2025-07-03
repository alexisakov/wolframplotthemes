(* ::Package:: *)

BeginPackage["CorporateTheme`"]


$ThemeFont = "Bloomberg Prop Unicode N Bold";

$ThemeFontSizeSmall = 14;
$ThemeFontSizeLarge = 22;
$ThemeChartSize = {1152, 576};
$ThemeAspectRatio =  1/1.65;

Options[ThemeTextStyle]={
  FontSize -> $ThemeFontSizeLarge
  , TextRotate -> 0
  , BreakLines->False
  , FontFamily -> $ThemeFont
  , Background -> Automatic
  , TextAlignment -> Center
  , LineSpacing -> {0.4, 10}
  , FontColor -> False
  }

ThemeTextStyle[x_,OptionsPattern[]] := Module[{
  string = If[
    OptionValue@BreakLines === False,
      x, 
      StringJoin[Flatten@Riffle[Riffle[#, " "] & /@ Partition[StringSplit[x], UpTo[OptionValue@BreakLines]], "\n"]]
  ]},
  Style[
    Rotate[string,OptionValue@TextRotate Degree]
    , FontFamily -> OptionValue[FontFamily]
    , FontSize -> OptionValue[FontSize]
    , Background -> OptionValue[Background]
    , LineSpacing -> OptionValue[LineSpacing]
    , TextAlignment -> OptionValue[TextAlignment]
    , LineBreakWithin -> False
    , Evaluate@If[OptionValue[FontColor] === False
      , FontSize -> OptionValue[FontSize]
      , FontColor -> OptionValue[FontColor] 
      ]

    ]
    ]; 

Begin["DataPaclets`ColorDataDump`"]


ColorData[1];

bbgclist=RGBColor[#/255.]&/@{
	{255,255,255} (*White*)
  ,{74,176,255} (*Blue*)
  ,{253,163,21} (*Orange*)
  ,{255,0,255} (*Magenta*)
  ,{255,226,115} (*Gold*)
  ,{146,208,80} (*Green*)
  ,{255,45,45} (*Red*)
  ,{171,120,238} (*Purple*)
	,{148,148,148} (*Light Gray*)
  ,{104,104,104} (*Dark Gray*)
  ,{64,64,64} (*HL Background*)
  ,{3,123,205} (*Section Divider*)
  ,{0,0,0}
  };

new={
	{"CorpIndexed",1,{"Corporate Indexed"},"BloombergIndexed"}
	, {"Indexed","Artistic"}
	, 1
	, {1, Length@bbgclist ,1}
	, bbgclist
	, {"Indexed", "CorpIndexed"}};

AppendTo[DataPaclets`ColorDataDump`colorSchemes,new];
AppendTo[DataPaclets`ColorDataDump`colorSchemeNames,new[[1,1]]];

new={{"CorpNamed", 2, {"Corporate Named"}, "CorpNamed"}
	,{"Named"}
	,1
	,{"White","Blue","Orange","Magenta","Gold","Green","Red","Purple"
	,"Light Grey","Dark Gray","HL Background","Section Divider","Black"}
	,bbgclist
	,None(* Range@Length@bbgclist *)
	,None
	,"These colors are used to distinguish elements in illustrations and graphics, such as molecule plot. It is based on Corey, Pauling, Kultin color scheme."};

AppendTo[DataPaclets`ColorDataDump`colorSchemes,new];
AppendTo[DataPaclets`ColorDataDump`colorSchemeNames,new[[1,1]]];

new={{"CorpGradient","Corporate Gradient", {"CorpGradient"}}
	, {"Gradients"}
	, 1
	, {0, 1}
	, {RGBColor[0., 0.596078, 0.109804], RGBColor[{1., 0.9176470588235294, 0.5176470588235293}], RGBColor[0.790588, 0.201176, 0.]}
	, ""};

AppendTo[DataPaclets`ColorDataDump`colorSchemes,new];
AppendTo[DataPaclets`ColorDataDump`colorSchemeNames,new[[1,1]]];

End[]



$ThemeFontColor = ColorData["CorpNamed"]["White"];

$ThemeColorDataIndexed = ColorData["CorpIndexed"];
$ThemeColorDataGradient = ColorData["CorpGradient"];
$ThemeColorDataNamed = ColorData["CorpNamed"];

$ThemeBackgroundColor = ColorData["CorpNamed"]["Black"];

Begin["System`PlotThemeDump`"];
Themes`ThemeRules; (* preload Theme system *)


resolvePlotTheme["Corporate",def:_String]:=
  Themes`SetWeight[{
    resolvePlotTheme["CorpColor",def]
    }  
    , Themes`$DesignWeight];

resolvePlotTheme["Corporate",def:_String]:= Themes`SetWeight[
  {
    ImageSize -> $ThemeChartSize
    , AspectRatio -> 1/1.65
    , Background -> $ThemeBackgroundColor
    , ChartStyle -> ColorData["CorpIndexed"]
    , PlotStyle -> ColorData["CorpIndexed"]
    , Frame -> {{False, True}, {True, False}}
    , TicksStyle -> Directive[$ThemeFontSizeLarge, $ThemeFontColor
        , FontFamily -> $ThemeFont , Opacity[0.3], FontOpacity -> 1]
    , FrameTicks -> All
    , FrameTicksStyle -> Directive[Thickness[0.002], $ThemeFontSizeLarge, $ThemeFontColor
        , FontFamily -> $ThemeFont , Opacity[0.3], FontOpacity -> 1]
    , FrameStyle -> Directive[Thickness[0.003], $ThemeColorDataIndexed@1]
    , "DefaultThickness" -> {Thickness@0.005}
    , PlotHighlighting -> {"XYLabel", Frame -> None
      , CalloutStyle -> Opacity[1], Appearance -> "Frameless"
      , Background -> Directive[Opacity[0.]]
      , CalloutStyle -> Directive[FontColor -> ColorData["CorpNamed"]@"Red"]
      , LabelStyle -> Directive[FontColor -> ColorData["CorpNamed"]@"Red"]
      }
  
  }
    , Themes`$SizeWeight];

SetOptions[Callout, 
  Background -> Directive[Opacity[0.0]],
  Appearance -> "SlantedLabel",
  LabelStyle->{$ThemeFontSizeSmall, $ThemeFontColor, FontFamily -> $ThemeFont, Background -> Opacity[0.0]}
  ];


End[];
EndPackage[]


(*
From here
https://mathematica.stackexchange.com/questions/160504/how-can-i-change-the-default-font-used-in-all-plots-and-legends-in-mathematica
*)


SetOptions[EvaluationNotebook[],
  StyleDefinitions -> Notebook[{Cell[StyleData[StyleDefinitions -> "Default.nb"]], 
    Cell[StyleData["Graphics", All]
    , FontFamily -> $ThemeFont
    , FontSize -> $ThemeFontSizeLarge
    , FontColor -> ColorData["CorpNamed"]["White"]
    ]},
    StyleDefinitions -> "PrivateStylesheetFormatting.nb"]]



SetOptions[Graphics
    , Background -> $ThemeBackgroundColor
    , ImageSize -> $ThemeChartSize
  ];


$dataDirectory = "C:/Users/aleis/Dropbox/macro/data";
$exportDirectory ="C:/Users/aleis/Dropbox/macro/export";
$PlotTheme="Corporate"; 

Needs["JLink`"];
ReinstallJava[JVMArguments -> "-Xmx4024m"];