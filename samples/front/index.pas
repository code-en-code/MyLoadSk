unit index;

interface

uses
  //delphi
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.UIConsts,
  System.Skia,

  //fmx
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Edit,
  FMX.Ani,
  FMX.TabControl,
  FMX.Skia,

  //codeencode
  myloadsk;

type
  TIndexView = class(TForm)
    Timer1: TTimer;
    lytPage1Col1: TLayout;
    lytPage1Col2: TLayout;
    lytPage1Col3: TLayout;
    lytPage1Col4: TLayout;
    lytPage1Col5: TLayout;
    lytPage1Col6: TLayout;
    vsbPage1: TVertScrollBox;
    lytPage1Line1: TLayout;
    lytPage1Line2: TLayout;
    lytPage1Line3: TLayout;
    lytPage1Col7: TLayout;
    lytPage1Col8: TLayout;
    lytPage1Col9: TLayout;
    tbcBody: TTabControl;
    tabPage1: TTabItem;
    tabPage2: TTabItem;
    lytPage1Buttons1: TLayout;
    btnPage1Load1: TButton;
    lytPage1Load1: TLayout;
    lytPage1Buttons2: TLayout;
    lytPage1Load2: TLayout;
    btnPage1Load2: TButton;
    lytPage1Buttons3: TLayout;
    lytPage1Load3: TLayout;
    btnPage1Load3: TButton;
    lytPage1Buttons4: TLayout;
    lytPage1Load4: TLayout;
    lytPage1Buttons5: TLayout;
    lytPage1Load5: TLayout;
    lytPage1Buttons6: TLayout;
    lytPage1Load6: TLayout;
    lytPage1Buttons7: TLayout;
    lytPage1Load7: TLayout;
    lytPage1Buttons8: TLayout;
    lytPage1Load8: TLayout;
    lytPage1Buttons9: TLayout;
    lytPage1Load9: TLayout;
    btnPage1Load4: TButton;
    btnPage1Load5: TButton;
    btnPage1Load6: TButton;
    btnPage1Load7: TButton;
    btnPage1Load8: TButton;
    btnPage1Load9: TButton;
    btnPage1Stop2: TButton;
    btnPage1Text2: TButton;
    btnPage1Stop3: TButton;
    btnPage1ModeA3: TButton;
    btnPage1Text4: TButton;
    btnPage1Style4: TButton;
    btnPage1Stop4: TButton;
    btnPage1Box5: TButton;
    btnPage1Stop5: TButton;
    btnPage1TextOne6: TButton;
    btnPage1TextTwo6: TButton;
    btnPage1Stop6: TButton;
    btnPage1Box7: TButton;
    btnPage1Stop7: TButton;
    btnPage1Align8: TButton;
    btnPage1Stop8: TButton;
    btnPage1TextOne9: TButton;
    btnPage1TextTwo9: TButton;
    btnPage1Stop9: TButton;
    btnPage1ModeB3: TButton;
    btnPage1Radius7: TButton;
    lytPage1Line4: TLayout;
    lytPage1Col10: TLayout;
    lytPage1Buttons10: TLayout;
    btnPage1Load10: TButton;
    btnPage1ProgressHalf10: TButton;
    btnPage1Stop10: TButton;
    btnPage1ProgressFull10: TButton;
    lytPage1Load10: TLayout;
    lytPage1Col11: TLayout;
    lytPage1Buttons11: TLayout;
    btnPage1Load11: TButton;
    btnPage1ProgressHalf11: TButton;
    btnPage1Stop11: TButton;
    btnPage1ProgressFull11: TButton;
    lytPage1Load11: TLayout;
    lytPage1Col12: TLayout;
    lytPage1Buttons12: TLayout;
    btnPage1Load12: TButton;
    btnPage1Stop12: TButton;
    lytPage1Load12: TLayout;
    Timer2: TTimer;
    lytPage1Line5: TLayout;
    lytPage1Col13: TLayout;
    lytPage1Buttons13: TLayout;
    btnPage1Load13: TButton;
    btnPage1Stop13: TButton;
    lytPage1Load13: TLayout;
    btnPage1Text13: TButton;
    btnPage1Box13: TButton;
    lytPage1Col14: TLayout;
    lytPage1Buttons14: TLayout;
    btnPage1Load14: TButton;
    btnPage1Stop14: TButton;
    btnPage1TextOne14: TButton;
    btnPage1TextTwo14: TButton;
    lytPage1Load14: TLayout;
    lytPage1Col15: TLayout;
    lytPage1Buttons15: TLayout;
    btnPage1Load15: TButton;
    btnPage1Stop15: TButton;
    btnPage1Text15: TButton;
    btnPage1Box15: TButton;
    lytPage1Load15: TLayout;
    procedure btnPage1Load1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnPage1Load2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPage1Load3Click(Sender: TObject);
    procedure btnPage1Load4Click(Sender: TObject);
    procedure btnPage1Load5Click(Sender: TObject);
    procedure btnPage1Load6Click(Sender: TObject);
    procedure btnPage1Load7Click(Sender: TObject);
    procedure btnPage1Load8Click(Sender: TObject);
    procedure btnPage1Load9Click(Sender: TObject);
    procedure btnPage1Stop2Click(Sender: TObject);
    procedure btnPage1Text2Click(Sender: TObject);
    procedure btnPage1Stop3Click(Sender: TObject);
    procedure btnPage1ModeA3Click(Sender: TObject);
    procedure btnPage1Text4Click(Sender: TObject);
    procedure btnPage1Style4Click(Sender: TObject);
    procedure btnPage1Stop4Click(Sender: TObject);
    procedure btnPage1Box5Click(Sender: TObject);
    procedure btnPage1Stop5Click(Sender: TObject);
    procedure btnPage1TextOne6Click(Sender: TObject);
    procedure btnPage1TextTwo6Click(Sender: TObject);
    procedure btnPage1Stop6Click(Sender: TObject);
    procedure btnPage1Box7Click(Sender: TObject);
    procedure btnPage1Stop7Click(Sender: TObject);
    procedure btnPage1Align8Click(Sender: TObject);
    procedure btnPage1Stop8Click(Sender: TObject);
    procedure btnPage1TextOne9Click(Sender: TObject);
    procedure btnPage1TextTwo9Click(Sender: TObject);
    procedure btnPage1Stop9Click(Sender: TObject);
    procedure btnPage1ModeB3Click(Sender: TObject);
    procedure btnPage1Radius7Click(Sender: TObject);
    procedure btnPage1Load10Click(Sender: TObject);
    procedure btnPage1ProgressHalf10Click(Sender: TObject);
    procedure btnPage1ProgressFull10Click(Sender: TObject);
    procedure btnPage1Stop10Click(Sender: TObject);
    procedure btnPage1Load11Click(Sender: TObject);
    procedure btnPage1ProgressHalf11Click(Sender: TObject);
    procedure btnPage1ProgressFull11Click(Sender: TObject);
    procedure btnPage1Stop11Click(Sender: TObject);
    procedure btnPage1Load12Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure btnPage1Stop12Click(Sender: TObject);
    procedure btnPage1Load13Click(Sender: TObject);
    procedure btnPage1Text13Click(Sender: TObject);
    procedure btnPage1Box13Click(Sender: TObject);
    procedure btnPage1Stop13Click(Sender: TObject);
    procedure btnPage1Load14Click(Sender: TObject);
    procedure btnPage1TextOne14Click(Sender: TObject);
    procedure btnPage1TextTwo14Click(Sender: TObject);
    procedure btnPage1Stop14Click(Sender: TObject);
    procedure btnPage1Load15Click(Sender: TObject);
    procedure btnPage1Text15Click(Sender: TObject);
    procedure btnPage1Box15Click(Sender: TObject);
    procedure btnPage1Stop15Click(Sender: TObject);
  private
    { Private declarations }
    FText: String;
    FValue: Double;
    FLoad1: IMyLoadSk;
    FLoad2: IMyLoadSk;
    FLoad3: IMyLoadSk;
    FLoad4: IMyLoadSk;
    FLoad5: IMyLoadSk;
    FLoad6: IMyLoadSk;
    FLoad7: IMyLoadSk;
    FLoad8: IMyLoadSk;
    FLoad9: IMyLoadSk;
    FLoad10: IMyLoadSk;
    FLoad11: IMyLoadSk;
    FLoad12: IMyLoadSk;
    FLoad13: IMyLoadSk;
    FLoad14: IMyLoadSk;
    FLoad15: IMyLoadSk;

    function AssetsPath: String;
  public
    { Public declarations }
  end;

var
  IndexView: TIndexView;

implementation

{$R *.fmx}

procedure TIndexView.FormDestroy(Sender: TObject);
begin
  FLoad1.Hide(True);
  FLoad2.Hide(True);
  FLoad3.Hide(True);
  FLoad4.Hide(True);
  FLoad5.Hide(True);
  FLoad6.Hide(True);
  FLoad7.Hide(True);
  FLoad8.Hide(True);
  FLoad9.Hide(True);
  FLoad10.Hide(True);
  FLoad11.Hide(True);
  FLoad12.Hide(True);
  FLoad13.Hide(True);
  FLoad14.Hide(True);
  FLoad15.Hide(True);
end;

procedure TIndexView.FormShow(Sender: TObject);
begin
  FValue := 0;
  FLoad1 := TMyLoadSk.New;
  FLoad2 := TMyLoadSk.New;
  FLoad3 := TMyLoadSk.New;
  FLoad4 := TMyLoadSk.New;
  FLoad5 := TMyLoadSk.New;
  FLoad6 := TMyLoadSk.New;
  FLoad7 := TMyLoadSk.New;
  FLoad8 := TMyLoadSk.New;
  FLoad9 := TMyLoadSk.New;
  FLoad10 := TMyLoadSk.New;
  FLoad11 := TMyLoadSk.New;
  FLoad12 := TMyLoadSk.New;
  FLoad13 := TMyLoadSk.New;
  FLoad14 := TMyLoadSk.New;
  FLoad15 := TMyLoadSk.New;
end;

function TIndexView.AssetsPath: String;
begin
  Result := Copy(ExtractFileDir(GetCurrentDir), 0, Pos('myloadsk', ExtractFileDir(GetCurrentDir)) + 'myloadsk'.Length) + 'samples\front\assets\';
end;

procedure TIndexView.btnPage1Load1Click(Sender: TObject);
begin
  FText := 'Loading';
  FLoad1.Show(lytPage1Load1, FText);
  Timer1.Enabled := True;
end;

procedure TIndexView.Timer1Timer(Sender: TObject);
begin
  if FLoad1.IsShowing then
  begin
    FText := FText + ' Loading';
    FLoad1.SetText(FText);
    if FText.Length > 200 then
    begin
      FLoad1.Hide;
      Timer1.Enabled := False;
    end;
  end;
end;

procedure TIndexView.btnPage1Load2Click(Sender: TObject);
begin
  FLoad2.Show(lytPage1Load2, 'Loading products');
end;

procedure TIndexView.btnPage1Stop2Click(Sender: TObject);
begin
  if FLoad2.IsShowing then
    FLoad2.Hide;
end;

procedure TIndexView.btnPage1Text2Click(Sender: TObject);
begin
  if FLoad2.IsShowing then
    FLoad2.SetText('Processing data');
end;

procedure TIndexView.btnPage1Load3Click(Sender: TObject);
begin
  FLoad3
    .Parameters
      .Text
        .Visible__(False)
      .EndText
    .EndParameters
    .Show(lytPage1Load3);
end;

procedure TIndexView.btnPage1Stop3Click(Sender: TObject);
begin
  if FLoad3.IsShowing then
    FLoad3.Hide;
end;

procedure TIndexView.btnPage1ModeA3Click(Sender: TObject);
begin
  FLoad3
    .Parameters
      .Circle
        .ActivateBg(True)
        .ColorBg(StringToAlphaColor('Darkslateblue'))
        .ColorArc(StringToAlphaColor('White'))
        .Shadow_(True)
        .Size(50)
        .Thickness(4)
      .EndCircle
      .Text
        .Visible__(False)
      .EndText
    .EndParameters
    .Show(lytPage1Load3);
end;

procedure TIndexView.btnPage1ModeB3Click(Sender: TObject);
begin
  FLoad3
    .Parameters
      .Circle
        .ActivateBg(False)
        .ColorArc(StringToAlphaColor('White'))
        .Shadow_(True)
        .Size(50)
        .Thickness(4)
      .EndCircle
      .Text
        .Visible__(False)
      .EndText
    .EndParameters
    .Show(lytPage1Load3);
end;

procedure TIndexView.btnPage1Load4Click(Sender: TObject);
begin
  FLoad4
    .Parameters
      .Circle
        .Visible_(False)
      .EndCircle
      .Text
        .Shadow___(True)
        .Size_(15)
        .Visible__(True)
      .EndText
    .EndParameters
    .Show(lytPage1Load4, 'Loading products');
end;

procedure TIndexView.btnPage1Text4Click(Sender: TObject);
begin
  if FLoad4.IsShowing then
    FLoad4.SetText('Processing data');
end;

procedure TIndexView.btnPage1Style4Click(Sender: TObject);
begin
  FLoad4
    .Parameters
      .Text
        .Color__($FF708090)
        .FontFamily('Comic Sans Ms')
        .LetterSpacing(10)
        .Shadow___(False)
        .Size_(30)
        .Slant(TFontSlant.Italic)
        .Weight(TFontWeight.UltraBlack)
      .EndText
    .EndParameters;
end;

procedure TIndexView.btnPage1Stop4Click(Sender: TObject);
begin
  if FLoad4.IsShowing then
    FLoad4.Hide;
end;

procedure TIndexView.btnPage1Load5Click(Sender: TObject);
begin
  FLoad5
    .Parameters
      .Box
        .Shadow(True)
        .Color_($FF708090)
        .Visible(True)
      .EndBox
    .EndParameters
    .Show(lytPage1Load5, 'Loading products');
end;

procedure TIndexView.btnPage1Box5Click(Sender: TObject);
begin
  FLoad5
    .Parameters
      .Box
        .Visible(False)
      .EndBox
    .EndParameters;
end;

procedure TIndexView.btnPage1Stop5Click(Sender: TObject);
begin
  if FLoad5.IsShowing then
    FLoad5.Hide;
end;

procedure TIndexView.btnPage1Load6Click(Sender: TObject);
begin
  FLoad6
    .Parameters
      .Box
        .Color_($FF708090)
        .Shadow(True)
        .Visible(True)
      .EndBox
      .Circle
        .Visible_(False)
      .EndCircle
    .EndParameters
    .Show(lytPage1Load6, 'Loading products');
end;

procedure TIndexView.btnPage1TextOne6Click(Sender: TObject);
begin
  if FLoad6.IsShowing then
    FLoad6.SetText('Processing data');
end;

procedure TIndexView.btnPage1TextTwo6Click(Sender: TObject);
begin
  if FLoad6.IsShowing then
    FLoad6.SetText('Just one more moment');
end;

procedure TIndexView.btnPage1Stop6Click(Sender: TObject);
begin
  if FLoad6.IsShowing then
    FLoad6.Hide;
end;

procedure TIndexView.btnPage1Load7Click(Sender: TObject);
begin
  FLoad7
    .Parameters
      .Box
        .Color_($FF708090)
        .Shadow(True)
        .Visible(True)
      .EndBox
      .Text
        .Visible__(False)
      .EndText
    .EndParameters
    .Show(lytPage1Load7);
end;

procedure TIndexView.btnPage1Box7Click(Sender: TObject);
begin
  FLoad7
    .Parameters
      .Box
        .Color_($EE555555)
      .EndBox
    .EndParameters;
end;

procedure TIndexView.btnPage1Radius7Click(Sender: TObject);
begin
  FLoad7
    .Parameters
      .Box
        .CornerRadius(0)
      .EndBox
    .EndParameters;
end;

procedure TIndexView.btnPage1Stop7Click(Sender: TObject);
begin
  if FLoad7.IsShowing then
    FLoad7.Hide;
end;

procedure TIndexView.btnPage1Load8Click(Sender: TObject);
begin
  FLoad8
    .Parameters
      .Box
        .Color_($FF708090)
        .Visible(True)
      .EndBox
      .Circle
        .Visible_(False)
      .EndCircle
      .Text
        .AnimationEllipsis(True)
        .Shadow___(True)
        .Size_(18)
        .HorzAlign(TSkTextHorzAlign.Leading)
      .EndText
    .EndParameters
    .Show(lytPage1Load8, 'Loading products');
end;

procedure TIndexView.btnPage1Align8Click(Sender: TObject);
begin
  FLoad8
    .Parameters
      .Text
        .HorzAlign(TSkTextHorzAlign.Center)
      .EndText
    .EndParameters;
end;

procedure TIndexView.btnPage1Stop8Click(Sender: TObject);
begin
  if FLoad8.IsShowing then
    FLoad8.Hide;
end;

procedure TIndexView.btnPage1Load9Click(Sender: TObject);
begin
  FLoad9
    .Parameters
      .Circle
        .Visible_(False)
      .EndCircle
      .Text
        .AnimationEllipsis(True)
        .Shadow___(True)
        .Size_(18)
        .HorzAlign(TSkTextHorzAlign.Center)
      .EndText
    .EndParameters
    .Show(lytPage1Load9, 'Loading products');
end;

procedure TIndexView.btnPage1TextOne9Click(Sender: TObject);
begin
  if FLoad9.IsShowing then
    FLoad9.SetText('Processing data');
end;

procedure TIndexView.btnPage1TextTwo9Click(Sender: TObject);
begin
  if FLoad9.IsShowing then
    FLoad9.SetText('Just one more moment');
end;

procedure TIndexView.btnPage1Stop9Click(Sender: TObject);
begin
  if FLoad9.IsShowing then
    FLoad9.Hide;
end;

procedure TIndexView.btnPage1Load10Click(Sender: TObject);
begin
  FLoad10
    .Parameters
      .Circle
        .Visible_(False)
      .EndCircle
      .Progress
        .Shadow__(True)
        .Visible___(True)
      .EndProgress
      .Text
        .Shadow___(True)
      .EndText
    .EndParameters
    .Show(lytPage1Load10, 'Loading products');
end;

procedure TIndexView.btnPage1ProgressHalf10Click(Sender: TObject);
begin
  FLoad10.SetValue(50);
end;

procedure TIndexView.btnPage1ProgressFull10Click(Sender: TObject);
begin
  FLoad10.SetValue(100);
end;

procedure TIndexView.btnPage1Stop10Click(Sender: TObject);
begin
  if FLoad10.IsShowing then
    FLoad10.Hide;
end;

procedure TIndexView.btnPage1Load11Click(Sender: TObject);
begin
  FLoad11
    .Parameters
      .Circle
        .Visible_(False)
      .EndCircle
      .Progress
        .ColorBg_(StringToAlphaColor('White'))
        .ColorPg_(StringToAlphaColor('Darkslateblue'))
        .CornerRadius_(5)
        .Size__(10)
        .Visible___(True)
      .EndProgress
      .Text
        .Visible__(False)
      .EndText
    .EndParameters
    .Show(lytPage1Load11);
end;

procedure TIndexView.btnPage1ProgressHalf11Click(Sender: TObject);
begin
  FLoad11.SetValue(50);
end;

procedure TIndexView.btnPage1ProgressFull11Click(Sender: TObject);
begin
  FLoad11.SetValue(100);
end;

procedure TIndexView.btnPage1Stop11Click(Sender: TObject);
begin
  if FLoad11.IsShowing then
    FLoad11.Hide;
end;

procedure TIndexView.btnPage1Load12Click(Sender: TObject);
begin
  FValue := 0;
  FLoad12
    .Parameters
      .Circle
        .Visible_(False)
      .EndCircle
      .Progress
        .ColorBg_(StringToAlphaColor('White'))
        .ColorPg_(StringToAlphaColor('Darkslateblue'))
        .CornerRadius_(4)
        .Size__(10)
        .Visible___(True)
      .EndProgress
      .Text
        .Color__(StringToAlphaColor('Darkslateblue'))
        .Size_(16)
      .EndText
    .EndParameters
    .Show(lytPage1Load12, 'Loading products');
  Timer2.Enabled := True;
end;

procedure TIndexView.Timer2Timer(Sender: TObject);
begin
  if FLoad12.IsShowing then
  begin
    FValue := FValue + 1;
    FLoad12.SetText(FValue.ToString + '%');
    FLoad12.SetValue(FValue);
    if FValue = 100 then
    begin
      FValue := 0;
      FLoad12.Hide;
      Timer2.Enabled := False;
    end;
  end;
end;

procedure TIndexView.btnPage1Stop12Click(Sender: TObject);
begin
  if FLoad12.IsShowing then
    FLoad12.Hide;
end;

procedure TIndexView.btnPage1Load13Click(Sender: TObject);
begin
  FLoad13
    .Parameters
      .Circle
        .Visible_(False)
      .EndCircle
      .Lottie
        .LoadFromFile(AssetsPath + '\loading\loading1.json')
        .Size___(100)
        .Visible____(True)
      .EndLottie
      .Text
        .Visible__(False)
      .EndText
    .EndParameters
    .Show(lytPage1Load13);
end;

procedure TIndexView.btnPage1Text13Click(Sender: TObject);
begin
  FLoad13
    .Parameters
      .Text
        .Color__($FF6D26FF)
        .Size_(14)
        .Visible__(True)
        .Weight(TFontWeight.Bold)
      .EndText
    .EndParameters
    .Show(lytPage1Load13, 'Loading');
end;

procedure TIndexView.btnPage1Box13Click(Sender: TObject);
begin
  FLoad13
    .Parameters
      .Box
        .Color_(StringToAlphaColor('White'))
        .Visible(True)
      .EndBox
      .Text
        .Visible__(True)
      .EndText
    .EndParameters
    .Show(lytPage1Load13);
end;

procedure TIndexView.btnPage1Stop13Click(Sender: TObject);
begin
  if FLoad13.IsShowing then
    FLoad13.Hide;
end;

procedure TIndexView.btnPage1Load14Click(Sender: TObject);
begin
  FLoad14
    .Parameters
      .Circle
        .Visible_(False)
      .EndCircle
      .Lottie
        .LoadFromFile(AssetsPath + '\loading\loading2.json')
        .Size___(80)
        .Visible____(True)
      .EndLottie
      .Text
        .Visible__(False)
      .EndText
    .EndParameters
    .Show(lytPage1Load14);
end;

procedure TIndexView.btnPage1TextOne14Click(Sender: TObject);
begin
  FLoad14
    .Parameters
      .Text
        .Color__($FF012D59)
        .LetterSpacing(5)
        .Size_(12)
        .Visible__(True)
        .Weight(TFontWeight.Bold)
      .EndText
    .EndParameters
    .Show(lytPage1Load14, 'Loading');
end;

procedure TIndexView.btnPage1TextTwo14Click(Sender: TObject);
begin
  if FLoad14.IsShowing then
    FLoad14.SetText('Just one more moment');
end;

procedure TIndexView.btnPage1Stop14Click(Sender: TObject);
begin
  if FLoad14.IsShowing then
    FLoad14.Hide;
end;

procedure TIndexView.btnPage1Load15Click(Sender: TObject);
begin
  FLoad15
    .Parameters
      .Circle
        .Visible_(False)
      .EndCircle
      .Lottie
        .LoadFromFile(AssetsPath + '\loading\loading6.json')
        .Size___(80)
        .Visible____(True)
      .EndLottie
      .Text
        .Visible__(False)
      .EndText
    .EndParameters
    .Show(lytPage1Load15);
end;

procedure TIndexView.btnPage1Text15Click(Sender: TObject);
begin
  FLoad15
    .Parameters
      .Text
        .Color__($FFE6005A)
        .Size_(15)
        .Visible__(True)
        .Weight(TFontWeight.Bold)
      .EndText
    .EndParameters
    .Show(lytPage1Load15, 'loading');
end;

procedure TIndexView.btnPage1Box15Click(Sender: TObject);
begin
  FLoad15
    .Parameters
      .Box
        .Color_(StringToAlphaColor('White'))
        .Visible(True)
      .EndBox
      .Text
        .Visible__(False)
      .EndText
    .EndParameters
    .Show(lytPage1Load15);
end;

procedure TIndexView.btnPage1Stop15Click(Sender: TObject);
begin
  if FLoad15.IsShowing then
    FLoad15.Hide;
end;

end.
