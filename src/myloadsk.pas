unit myloadsk;

interface

uses
  //delphi
  System.SysUtils,
  System.Classes,
  System.UITypes,
  System.UIConsts,
  System.Skia,

  //fmx
  FMX.Types,
  FMX.Layouts,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Graphics,
  FMX.Ani,
  FMX.Forms,
  FMX.Platform,
  FMX.VirtualKeyboard,
  FMX.Controls,
  FMX.Effects,
  FMX.Skia;

type
  IMyLoadSk = interface;
  IMyLoadSkParameters = interface;
  IMyLoadSkBackground = interface;
  IMyLoadSkBox = interface;
  IMyLoadSkCircle = interface;
  IMyLoadSkProgress = interface;
  IMyLoadSkLottie = interface;
  IMyLoadSkText = interface;

  IMyLoadSk = interface
    ['{3BF52287-7177-4BEE-96BB-3616EEB9945B}']
    function Show(const AContainer: TFmxObject; const AText: String = 'Loading...'): IMyLoadSk;
    function Hide(const ADestroy: Boolean = False): IMyLoadSk;
    function SetText(const AText: String): IMyLoadSk;
    function SetValue(const AValue: Single): IMyLoadSk;
    function IsShowing: Boolean;
    function OnFinish(AProc: TProc): IMyLoadSk;
    function Parameters: IMyLoadSkParameters;
  end;

  IMyLoadSkParameters = interface
    ['{92854863-A182-47B9-A6B3-2CC6719D94A7}']
    function Background: IMyLoadSkBackground;
    function Box: IMyLoadSkBox;
    function Circle: IMyLoadSkCircle;
    function Progress: IMyLoadSkProgress;
    function Lottie: IMyLoadSkLottie;
    function Text: IMyLoadSkText;
    function EndParameters: IMyLoadSk;
  end;

  IMyLoadSkBackground = interface
    ['{7E86223B-C50A-4F3F-AEB0-D61102B3E1A9}']
    function Color(const AColor: TAlphaColor): IMyLoadSkBackground;
    function EndBackground: IMyLoadSkParameters;
  end;

  IMyLoadSkBox = interface
    ['{8155EDAC-D0EE-4C93-8A26-2B33BA68695A}']
    function Color_(const AColor: TAlphaColor): IMyLoadSkBox;
    function CornerRadius(const AValue: Single): IMyLoadSkBox;
    function Shadow(const AValue: Boolean = False): IMyLoadSkBox;
    function Visible(const AVisible: Boolean = False): IMyLoadSkBox;
    function EndBox: IMyLoadSkParameters;
  end;

  IMyLoadSkCircle = interface
    ['{6158052D-84D7-420D-845A-D4342458A8D7}']
    function ActivateBg(const Activate: Boolean = True): IMyLoadSkCircle;
    function ColorBg(const AColor: TAlphaColor): IMyLoadSkCircle;
    function ColorArc(const AColor: TAlphaColor): IMyLoadSkCircle;
    function Shadow_(const AValue: Boolean = False): IMyLoadSkCircle;
    function Size(const ASize: Single): IMyLoadSkCircle;
    function Thickness(const AThickness: Single): IMyLoadSkCircle;
    function Visible_(const AVisible: Boolean = True): IMyLoadSkCircle;
    function EndCircle: IMyLoadSkParameters;
  end;

  IMyLoadSkProgress = interface
    ['{3135C99A-5FB3-478B-B7BC-AE09AB2E73DC}']
    function ColorBg_(const AColor: TAlphaColor): IMyLoadSkProgress;
    function ColorPg_(const AColor: TAlphaColor): IMyLoadSkProgress;
    function CornerRadius_(const AValue: Single): IMyLoadSkProgress;
    function Shadow__(const AValue: Boolean = False): IMyLoadSkProgress;
    function Size__(const ASize: Single): IMyLoadSkProgress;
    function Visible___(const AVisible: Boolean = True): IMyLoadSkProgress;
    function EndProgress: IMyLoadSkParameters;
  end;

  IMyLoadSkLottie = interface
    ['{8AE84DBB-0039-41D0-92EE-DA948E3C985A}']
    function LoadFromFile(AFileName: String): IMyLoadSkLottie;
    function Size___(const ASize: Single): IMyLoadSkLottie;
    function Visible____(const AVisible: Boolean = False): IMyLoadSkLottie;
    function WrapMode(const AValue: TSkAnimatedImageWrapMode): IMyLoadSkLottie;
    function EndLottie: IMyLoadSkParameters;
  end;

  IMyLoadSkText = interface
    ['{C63F9752-2E94-457F-B192-6E07A08DDD11}']
    function AnimationEllipsis(const AEllipsis: Boolean = False): IMyLoadSkText;
    function Color__(const AFontColor: TAlphaColor): IMyLoadSkText;
    function FontFamily(const AFontFamily: TFontName): IMyLoadSkText;
    function HorzAlign(const AHorzAlign: TSkTextHorzAlign): IMyLoadSkText;
    function LetterSpacing(const ALetterSpacing: Single): IMyLoadSkText;
    function Shadow___(const AValue: Boolean = False): IMyLoadSkText;
    function Size_(const AFontSize: Single): IMyLoadSkText;
    function Slant(const ASlant: TFontSlant): IMyLoadSkText;
    function VertAlign(const AVertAlign: TTextAlign): IMyLoadSkText;
    function Visible__(const AVisible: Boolean = True): IMyLoadSkText;
    function Weight(const AWeight: TFontWeight): IMyLoadSkText;
    function EndText: IMyLoadSkParameters;
  end;

  TMyLoadSk = class(TInterfacedObject, IMyLoadSk, IMyLoadSkParameters,
                    IMyLoadSkBackground, IMyLoadSkBox, IMyLoadSkCircle,
                    IMyLoadSkProgress, IMyLoadSkLottie, IMyLoadSkText)
  private
    { private declarations }
    FGrayIn: TFloatAnimation;
    FGrayOut: TFloatAnimation;
    FBoxIn: TFloatAnimation;
    FBoxOut: TFloatAnimation;
    FArcRotation: TFloatAnimation;
    FProgressIn: TFloatAnimation;
    FTextIn: TFloatAnimation;
    FTextOut: TFloatAnimation;
    FBoxShadowEffect: TShadowEffect;
    FCircleBgShadowEffect: TShadowEffect;
    FCircleArcShadowEffect: TShadowEffect;
    FProgressShadowEffect: TShadowEffect;
    FTextShadowEffect: TShadowEffect;
    FContent: TLayout;
    FGray: TRectangle;
    FBox: TRectangle;
    FBoxContent: TLayout;
    FCircleContent: TLayout;
    FCircleBg: TArc;
    FCircleArc: TArc;
    FProgressContent: TLayout;
    FProgressBg: TRectangle;
    FProgressLine: TRectangle;
    FLottieContent: TLayout;
    FLottie: TSkAnimatedImage;
    FText: TSkLabel;
    FTimerEllipsis: TTimer;
    FCountEllipsis: Integer;
    FNewText: String;
    FOnFinish: TProc;
    FBoxShadow: Boolean;
    FCircleShadow: Boolean;
    FProgressShadow: Boolean;
    FTextShadow: Boolean;

    procedure CreateInfra;
    procedure DestroyInfra;
    
    procedure CreateContent;
    procedure CreateGray;
    procedure CreateBox;
    procedure CreateBoxContent;
    procedure CreateCircleContent;
    procedure CreateCircleBg;
    procedure CreateCircleArc;
    procedure CreateProgressContent;
    procedure CreateProgressBg;
    procedure CreateProgressLine;
    procedure CreateLottieContent;
    procedure CreateLottie;
    procedure CreateText;
    procedure CreateTimerEllipsis;

    procedure GrayIn;
    procedure GrayOut;
    procedure OnFinishGrayOut(Sender: TObject);

    procedure BoxIn;
    procedure BoxOut;
    procedure OnFinishBoxIn(Sender: TObject);
    procedure OnFinishBoxOut(Sender: TObject);

    procedure TextIn;
    procedure TextOut;
    procedure OnFinishTextIn(Sender: TObject);
    procedure OnFinishTextOut(Sender: TObject);

    procedure CircleRotation;

    procedure ProgressIn(const AValue: Single);

    procedure ResetControls;
    procedure BoxResizing;
    procedure ControlsResizing;
    procedure TextResizing;
    procedure RemoveFocus;
    procedure HideKeyboard;
    procedure BringToFront;
    procedure RunAnimationsIn;
    procedure RunAnimationsOut;

    procedure OnTimerEllipsis(Sender: TObject);

    procedure ResizingCircle;
    procedure ResizingCircleText;
    procedure ResizingCircleTextLottie;
    procedure ResizingCircleProgress;
    procedure ResizingCircleProgressLottie;
    procedure ResizingCircleLottie;
    procedure ResizingCircleProgressText;
    procedure ResizingCircleProgressTextLottie;
    procedure ResizingText;
    procedure ResizingTextProgress;
    procedure ResizingTextProgressLottie;
    procedure ResizingTextLottie;
    procedure ResizingProgress;
    procedure ResizingLottie;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;
    class function New: IMyLoadSk;

    function Show(const AContainer: TFmxObject; const AText: String = 'Loading...'): IMyLoadSk;
    function Hide(const ADestroy: Boolean = False): IMyLoadSk;
    function SetText(const AText: String): IMyLoadSk;
    function SetValue(const AValue: Single): IMyLoadSk;
    function IsShowing: Boolean;
    function OnFinish(AProc: TProc): IMyLoadSk;
    function Parameters: IMyLoadSkParameters;

    function Background: IMyLoadSkBackground;
    function Box: IMyLoadSkBox;
    function Circle: IMyLoadSkCircle;
    function Progress: IMyLoadSkProgress;
    function Lottie: IMyLoadSkLottie;
    function Text: IMyLoadSkText;
    function EndParameters: IMyLoadSk;

    function Color(const AColor: TAlphaColor): IMyLoadSkBackground;
    function EndBackground: IMyLoadSkParameters;

    function Color_(const AColor: TAlphaColor): IMyLoadSkBox;
    function CornerRadius(const AValue: Single): IMyLoadSkBox;
    function Shadow(const AValue: Boolean = False): IMyLoadSkBox;
    function Visible(const AVisible: Boolean = False): IMyLoadSkBox;
    function EndBox: IMyLoadSkParameters;

    function ActivateBg(const AActivate: Boolean = True): IMyLoadSkCircle;
    function ColorBg(const AColor: TAlphaColor): IMyLoadSkCircle;
    function ColorArc(const AColor: TAlphaColor): IMyLoadSkCircle;
    function Shadow_(const AValue: Boolean = False): IMyLoadSkCircle;
    function Size(const ASize: Single): IMyLoadSkCircle;
    function Thickness(const AThickness: Single): IMyLoadSkCircle;
    function Visible_(const AVisible: Boolean = True): IMyLoadSkCircle;
    function EndCircle: IMyLoadSkParameters;

    function ColorBg_(const AColor: TAlphaColor): IMyLoadSkProgress;
    function ColorPg_(const AColor: TAlphaColor): IMyLoadSkProgress;
    function CornerRadius_(const AValue: Single): IMyLoadSkProgress;
    function Shadow__(const AValue: Boolean = False): IMyLoadSkProgress;
    function Size__(const ASize: Single): IMyLoadSkProgress;
    function Visible___(const AVisible: Boolean = True): IMyLoadSkProgress;
    function EndProgress: IMyLoadSkParameters;

    function LoadFromFile(AFileName: String): IMyLoadSkLottie;
    function Size___(const ASize: Single): IMyLoadSkLottie;
    function Visible____(const AVisible: Boolean = False): IMyLoadSkLottie;
    function WrapMode(const AValue: TSkAnimatedImageWrapMode): IMyLoadSkLottie;
    function EndLottie: IMyLoadSkParameters;

    function AnimationEllipsis(const AEllipsis: Boolean = False): IMyLoadSkText;
    function Color__(const AFontColor: TAlphaColor): IMyLoadSkText;
    function FontFamily(const AFontFamily: TFontName): IMyLoadSkText;
    function HorzAlign(const AHorzAlign: TSkTextHorzAlign): IMyLoadSkText;
    function LetterSpacing(const ALetterSpacing: Single): IMyLoadSkText;
    function Shadow___(const AValue: Boolean = False): IMyLoadSkText;
    function Size_(const AFontSize: Single): IMyLoadSkText;
    function Slant(const ASlant: TFontSlant): IMyLoadSkText;
    function VertAlign(const AVertAlign: TTextAlign): IMyLoadSkText;
    function Visible__(const AVisible: Boolean = True): IMyLoadSkText;
    function Weight(const AWeight: TFontWeight): IMyLoadSkText;
    function EndText: IMyLoadSkParameters;
  end;

implementation

{ TMyLoad }

constructor TMyLoadSk.Create;
begin
  FContent := nil;
  FGray := nil;
  FBox := nil;
  FBoxContent := nil;
  FCircleContent := nil;
  FCircleArc := nil;
  FProgressContent := nil;
  FProgressBg := nil;
  FProgressLine := nil;
  FLottieContent := nil;
  FLottie := nil;
  FText := nil;
  FTimerEllipsis := nil;
  CreateInfra;
end;

destructor TMyLoadSk.Destroy;
begin
  DestroyInfra;
  inherited;
end;

class function TMyLoadSk.New: IMyLoadSk;
begin
  Result := Self.Create;
end;

procedure TMyLoadSk.CreateInfra;
begin
  CreateContent;
  CreateGray;
  CreateBox;
  CreateBoxContent;
  CreateCircleContent;
  CreateCircleBg;
  CreateCircleArc;
  CreateProgressContent;
  CreateProgressBg;
  CreateProgressLine;
  CreateLottieContent;
  CreateLottie;
  CreateText;
  CreateTimerEllipsis;
end;

procedure TMyLoadSk.DestroyInfra;
begin
  if Assigned(FTimerEllipsis) then
    FreeAndNil(FTimerEllipsis);
  if Assigned(FText) then
    FreeAndNil(FText);
  if Assigned(FLottie) then
    FreeAndNil(FLottie);
  if Assigned(FLottieContent) then
    FreeAndNil(FLottieContent);
  if Assigned(FProgressLine) then
    FreeAndNil(FProgressLine);
  if Assigned(FProgressBg) then
    FreeAndNil(FProgressBg);
  if Assigned(FProgressContent) then
    FreeAndNil(FProgressContent);
  if Assigned(FCircleArc) then
    FreeAndNil(FCircleArc);
  if Assigned(FCircleBg) then
    FreeAndNil(FCircleBg);
  if Assigned(FCircleContent) then
    FreeAndNil(FCircleContent);
  if Assigned(FBoxContent) then
    FreeAndNil(FBoxContent);
  if Assigned(FBox) then
    FreeAndNil(FBox);
  if Assigned(FGray) then
    FreeAndNil(FGray);
  if Assigned(FContent) then
    FreeAndNil(FContent);
end;

procedure TMyLoadSk.CreateContent;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FContent := TLayout.Create(nil);
    FContent.BeginUpdate;
      FContent.Align := TAlignLayout.Contents;
      FContent.ClipChildren := True;
      FContent.HitTest := False;
      FContent.Opacity := 1;
      FContent.Parent := nil;
      FContent.TabStop := False;
      FContent.Visible := True;
    FContent.EndUpdate;
  end);
end;

procedure TMyLoadSk.CreateGray;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FGray := TRectangle.Create(FContent);
    FGray.BeginUpdate;
      FGray.Align := TAlignLayout.Contents;
      FGray.ClipChildren := True;
      FGray.Fill.Color := $64708090;
      FGray.Fill.Kind := TBrushKind.Solid;
      FGray.HitTest := True;
      FGray.Opacity := 0;
      FGray.Parent := FContent;
      FGray.Stroke.Kind := TBrushKind.None;
      FGray.TabStop := False;
      FGray.Visible := True;
    FGray.EndUpdate;
  end);
end;

procedure TMyLoadSk.CreateBox;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FBox := TRectangle.Create(FContent);
    FBox.BeginUpdate;
      FBox.Align := TAlignLayout.Center;
      FBox.ClipChildren := False;
      FBox.CornerType := TCornerType.Round;
      FBox.Fill.Color := $FF708090;
      FBox.Fill.Kind := TBrushKind.None;
      FBox.Height := 0;
      FBox.HitTest := False;
      FBox.Padding.Bottom := 20;
      FBox.Padding.Left := 10;
      FBox.Padding.Right := 10;
      FBox.Padding.Top := 20;
      FBox.Opacity := 0;
      FBox.Parent := FContent;
      FBox.Stroke.Kind := TBrushKind.None;
      FBox.TabStop := False;
      FBox.Visible := True;
      FBox.Width := 0;
      FBox.XRadius := 20;
      FBox.YRadius := 20;

      FBoxShadowEffect := TShadowEffect.Create(FBox);
      FBoxShadowEffect.Direction := 90;
      FBoxShadowEffect.Distance := 1;
      FBoxShadowEffect.Enabled := False;
      FBoxShadowEffect.Parent := FBox;
      FBoxShadowEffect.Opacity := 0.3;
      FBoxShadowEffect.ShadowColor := $FF000000;
      FBoxShadowEffect.Softness := 0.1;
    FBox.EndUpdate;
  end);
end;

procedure TMyLoadSk.CreateBoxContent;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FBoxContent := TLayout.Create(FBox);
    FBoxContent.BeginUpdate;
      FBoxContent.Align := TAlignLayout.VertCenter;
      FBoxContent.ClipChildren := False;
      FBoxContent.HitTest := False;
      FBoxContent.Opacity := 1;
      FBoxContent.Parent := FBox;
      FBoxContent.TabStop := False;
      FBoxContent.Visible := True;
    FBoxContent.EndUpdate;
  end);
end;

procedure TMyLoadSk.CreateCircleContent;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FCircleContent := TLayout.Create(FBoxContent);
    FCircleContent.BeginUpdate;
      FCircleContent.Align := TAlignLayout.MostTop;
      FCircleContent.ClipChildren := False;
      FCircleContent.HitTest := False;
      FCircleContent.Opacity := 1;
      FCircleContent.Parent := FBoxContent;
      FCircleContent.TabStop := False;
      FCircleContent.Visible := True;
    FCircleContent.EndUpdate;
  end);
end;

procedure TMyLoadSk.CreateCircleBg;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FCircleBg := TArc.Create(FCircleContent);
    FCircleBg.BeginUpdate;
      FCircleBg.Align := TAlignLayout.Center;
      FCircleBg.ClipChildren := False;
      FCircleBg.EndAngle := 360;
      FCircleBg.Height := 25;
      FCircleBg.HitTest := False;
      FCircleBg.Opacity := 1;
      FCircleBg.Parent := FCircleContent;
      FCircleBg.Stroke.Color := $FF939393;
      FCircleBg.Stroke.Kind := TBrushKind.Solid;
      FCircleBg.Stroke.Thickness := 2;
      FCircleBg.TabStop := False;
      FCircleBg.Visible := True;
      FCircleBg.Width := 25;

      FCircleBgShadowEffect := TShadowEffect.Create(FCircleBg);
      FCircleBgShadowEffect.Direction := 90;
      FCircleBgShadowEffect.Distance := 1;
      FCircleBgShadowEffect.Enabled := False;
      FCircleBgShadowEffect.Parent := FCircleBg;
      FCircleBgShadowEffect.Opacity := 0.3;
      FCircleBgShadowEffect.ShadowColor := $FF000000;
      FCircleBgShadowEffect.Softness := 0.1;
    FCircleBg.EndUpdate;
  end);
end;

procedure TMyLoadSk.CreateCircleArc;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FCircleArc := TArc.Create(FCircleContent);
    FCircleArc.BeginUpdate;
      FCircleArc.Align := TAlignLayout.Center;
      FCircleArc.EndAngle := 60;
      FCircleArc.Height := 25;
      FCircleArc.HitTest := False;
      FCircleArc.Opacity := 1;
      FCircleArc.Parent := FCircleContent;
      FCircleArc.Stroke.Color := StringToAlphaColor('White');
      FCircleArc.Stroke.Kind := TBrushKind.Solid;
      FCircleArc.Stroke.Thickness := 2;
      FCircleArc.TabStop := False;
      FCircleArc.Visible := True;
      FCircleArc.Width := 25;

      FCircleArcShadowEffect := TShadowEffect.Create(FCircleArc);
      FCircleArcShadowEffect.Direction := 90;
      FCircleArcShadowEffect.Distance := 1;
      FCircleArcShadowEffect.Enabled := False;
      FCircleArcShadowEffect.Parent := FCircleArc;
      FCircleArcShadowEffect.Opacity := 0.3;
      FCircleArcShadowEffect.ShadowColor := $FF000000;
      FCircleArcShadowEffect.Softness := 0.1;
    FCircleArc.EndUpdate;
    FCircleArc.BringToFront;
  end);
end;

procedure TMyLoadSk.CreateProgressContent;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FProgressContent := TLayout.Create(FBoxContent);
    FProgressContent.BeginUpdate;
      FProgressContent.Align := TAlignLayout.MostTop;
      FProgressContent.ClipChildren := False;
      FProgressContent.Height := 2;
      FProgressContent.HitTest := False;
      FProgressContent.Margins.Top := 10;
      FProgressContent.Margins.Bottom := 10;
      FProgressContent.Opacity := 1;
      FProgressContent.Parent := FBoxContent;
      FProgressContent.TabStop := False;
      FProgressContent.Visible := False;
    FProgressContent.EndUpdate;
  end);
end;

procedure TMyLoadSk.CreateProgressBg;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FProgressBg := TRectangle.Create(FProgressContent);
    FProgressBg.BeginUpdate;
      FProgressBg.Align := TAlignLayout.Contents;
      FProgressBg.ClipChildren := False;
      FProgressBg.CornerType := TCornerType.Round;
      FProgressBg.Fill.Color := $FFFFFFFF;
      FProgressBg.Fill.Kind := TBrushKind.Solid;
      FProgressBg.HitTest := False;
      FProgressBg.Opacity := 1;
      FProgressBg.Parent := FProgressContent;
      FProgressBg.Stroke.Kind := TBrushKind.None;
      FProgressBg.TabStop := False;
      FProgressBg.Visible := True;

      FProgressShadowEffect := TShadowEffect.Create(FProgressBg);
      FProgressShadowEffect.Direction := 90;
      FProgressShadowEffect.Distance := 1;
      FProgressShadowEffect.Enabled := False;
      FProgressShadowEffect.Parent := FProgressBg;
      FProgressShadowEffect.Opacity := 0.3;
      FProgressShadowEffect.ShadowColor := $FF000000;
      FProgressShadowEffect.Softness := 0.1;
    FProgressBg.EndUpdate;
  end);
end;

procedure TMyLoadSk.CreateProgressLine;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FProgressLine := TRectangle.Create(FProgressContent);
    FProgressLine.BeginUpdate;
      FProgressLine.Align := TAlignLayout.Left;
      FProgressLine.ClipChildren := False;
      FProgressLine.CornerType := TCornerType.Round;
      FProgressLine.Fill.Color := $FF939393;
      FProgressLine.Fill.Kind := TBrushKind.Solid;
      FProgressLine.HitTest := False;
      FProgressLine.Opacity := 1;
      FProgressLine.Parent := FProgressContent;
      FProgressLine.Stroke.Kind := TBrushKind.None;
      FProgressLine.TabStop := False;
      FProgressLine.Visible := True;
      FProgressLine.Width := 0;
    FProgressLine.EndUpdate;
    FProgressLine.BringToFront;
  end);
end;

procedure TMyLoadSk.CreateLottieContent;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FLottieContent := TLayout.Create(FBoxContent);
    FLottieContent.BeginUpdate;
      FLottieContent.Align := TAlignLayout.MostTop;
      FLottieContent.ClipChildren := False;
      FLottieContent.HitTest := False;
      FLottieContent.Margins.Top := 10;
      FLottieContent.Margins.Bottom := 10;
      FLottieContent.Opacity := 1;
      FLottieContent.Parent := FBoxContent;
      FLottieContent.TabStop := False;
      FLottieContent.Visible := False;
    FLottieContent.EndUpdate;
  end);
end;

procedure TMyLoadSk.CreateLottie;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FLottie := TSkAnimatedImage.Create(FLottieContent);
    FLottie.BeginUpdate;
      FLottie.Align := TAlignLayout.Center;
      FLottie.ClipChildren := False;
      FLottie.Height := 25;
      FLottie.HitTest := False;
      FLottie.Opacity := 1;
      FLottie.Parent := FLottieContent;
      FLottie.TabStop := False;
      FLottie.Visible := True;
      FLottie.Width := 25;
      FLottie.WrapMode := TSkAnimatedImageWrapMode.Fit;
    FLottie.EndUpdate;
  end);
end;

procedure TMyLoadSk.CreateText;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FText := TSkLabel.Create(FBoxContent);
    FText.BeginUpdate;
      FText.Align := TAlignLayout.Top;
      FText.AutoSize := True;
      FText.HitTest := False;
      FText.Opacity := 0;
      FText.Parent := FBoxContent;
      FText.StyledSettings := [];
      FText.TabStop := False;
      FText.Words.Clear;
      FText.Words.Add('', StringToAlphaColor('White'), 12, TFontWeight.Semibold, TFontSlant.Regular);
      FText.TextSettings.HorzAlign := TSkTextHorzAlign.Center;
      FText.TextSettings.Trimming := TTextTrimming.None;
      FText.TextSettings.VertAlign := TTextAlign.Center;
      FText.Visible := True;

      FTextShadowEffect := TShadowEffect.Create(FText);
      FTextShadowEffect.Direction := 90;
      FTextShadowEffect.Distance := 1;
      FTextShadowEffect.Enabled := False;
      FTextShadowEffect.Parent := FText;
      FTextShadowEffect.Opacity := 0.3;
      FTextShadowEffect.ShadowColor := $FF000000;
      FTextShadowEffect.Softness := 0.1;
    FText.EndUpdate;
    FText.BringToFront;
  end);
end;

procedure TMyLoadSk.CreateTimerEllipsis;
begin
  FTimerEllipsis := TTimer.Create(nil);
  FTimerEllipsis.Enabled := False;
  FTimerEllipsis.OnTimer := OnTimerEllipsis;
end;

procedure TMyLoadSk.GrayIn;
begin
  FGrayIn := TFloatAnimation.Create(FGray);
  FGrayIn.AnimationType := TAnimationType.&In;
  FGrayIn.Delay := 0.1;
  FGrayIn.Duration := 0.2;
  FGrayIn.Interpolation := TInterpolationType.Linear;
  FGrayIn.Parent := FGray;
  FGrayIn.PropertyName := 'Opacity';
  FGrayIn.StartValue := 0;
  FGrayIn.StopValue := 1;
  FGrayIn.Start;
end;

procedure TMyLoadSk.GrayOut;
begin
  FGrayOut := TFloatAnimation.Create(FGray);
  FGrayOut.AnimationType := TAnimationType.Out;
  FGrayOut.Delay := 0.1;
  FGrayOut.Duration := 0.2;
  FGrayOut.Interpolation := TInterpolationType.Linear;
  FGrayOut.Parent := FGray;
  FGrayOut.PropertyName := 'Opacity';
  FGrayOut.StartValue := 1;
  FGrayOut.StopValue := 0;
  FGrayOut.OnFinish := OnFinishGrayOut;
  FGrayOut.Start;
end;

procedure TMyLoadSk.OnFinishGrayOut(Sender: TObject);
begin
  FContent.Parent := nil;
  ResetControls;
  if Assigned(FOnFinish) then
    FOnFinish;
end;

procedure TMyLoadSk.BoxIn;
begin
  FBoxIn := TFloatAnimation.Create(FBox);
  FBoxIn.AnimationType := TAnimationType.&In;
  FBoxIn.Delay := 0.1;
  FBoxIn.Duration := 0.2;
  FBoxIn.Interpolation := TInterpolationType.Linear;
  FBoxIn.Parent := FBox;
  FBoxIn.PropertyName := 'Opacity';
  FBoxIn.StartValue := 0;
  FBoxIn.StopValue := 1;
  FBoxIn.OnFinish := OnFinishBoxIn;
  FBoxIn.Start;
end;

procedure TMyLoadSk.BoxOut;
begin
  FBoxOut := TFloatAnimation.Create(FBox);
  FBoxOut.AnimationType := TAnimationType.Out;
  FBoxOut.Delay := 0.1;
  FBoxOut.Duration := 0.2;
  FBoxOut.Interpolation := TInterpolationType.Linear;
  FBoxOut.Parent := FBox;
  FBoxOut.PropertyName := 'Opacity';
  FBoxOut.StartValue := 1;
  FBoxOut.StopValue := 0;
  FBoxOut.OnFinish := OnFinishBoxOut;
  FBoxOut.Start;
end;

procedure TMyLoadSk.OnFinishBoxIn(Sender: TObject);
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FBoxShadowEffect.Enabled := FBoxShadow;
    if FCircleShadow then
    begin
      FCircleBgShadowEffect.Enabled := FCircleArc.EndAngle = 60;
      FCircleArcShadowEffect.Enabled := FCircleArc.EndAngle = 280;
    end;
    FProgressShadowEffect.Enabled := FProgressShadow;
  end);
end;

procedure TMyLoadSk.OnFinishBoxOut(Sender: TObject);
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FBoxShadowEffect.Enabled := False;
    FCircleBgShadowEffect.Enabled := False;
    FCircleArcShadowEffect.Enabled := False;
    FProgressShadowEffect.Enabled := False;
  end);
end;

procedure TMyLoadSk.TextIn;
begin
  FTextIn := TFloatAnimation.Create(FText);
  FTextIn.AnimationType := TAnimationType.&In;
  FTextIn.Delay := 0.1;
  FTextIn.Duration := 0.2;
  FTextIn.Interpolation := TInterpolationType.Linear;
  FTextIn.Parent := FText;
  FTextIn.PropertyName := 'Opacity';
  FTextIn.StartValue := 0;
  FTextIn.StopValue := 1;
  FTextIn.OnFinish := OnFinishTextIn;
  FTextIn.Start;
end;

procedure TMyLoadSk.TextOut;
begin
  FTextOut := TFloatAnimation.Create(FText);
  FTextOut.AnimationType := TAnimationType.&In;
  FTextOut.Delay := 0.1;
  FTextOut.Duration := 0.2;
  FTextOut.Interpolation := TInterpolationType.Linear;
  FTextOut.Parent := FText;
  FTextOut.PropertyName := 'Opacity';
  FTextOut.StartValue := 1;
  FTextOut.StopValue := 0;
  FTextOut.OnFinish := OnFinishTextOut;
  FTextOut.Start;
end;

procedure TMyLoadSk.OnFinishTextIn(Sender: TObject);
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FTextShadowEffect.Enabled := FTextShadow;
  end);
end;

procedure TMyLoadSk.OnFinishTextOut(Sender: TObject);
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FTextShadowEffect.Enabled := False;
    TextResizing;
  end);
  TextIn;
end;

procedure TMyLoadSk.CircleRotation;
begin
  FArcRotation := TFloatAnimation.Create(FCircleArc);
  FArcRotation.AnimationType := TAnimationType.InOut;
  FArcRotation.Duration := 0.8;
  FArcRotation.Interpolation := TInterpolationType.Linear;
  FArcRotation.Loop := True;
  FArcRotation.Parent := FCircleArc;
  FArcRotation.PropertyName := 'RotationAngle';
  FArcRotation.StartValue := 0;
  FArcRotation.StopValue := 360;
  FArcRotation.Start;
end;

procedure TMyLoadSk.ProgressIn(const AValue: Single);
begin
  FProgressIn := TFloatAnimation.Create(FProgressLine);
  FProgressIn.AnimationType := TAnimationType.InOut;
  FProgressIn.Delay := 0.1;
  FProgressIn.Duration := 0.2;
  FProgressIn.Interpolation := TInterpolationType.Linear;
  FProgressIn.Parent := FProgressLine;
  FProgressIn.PropertyName := 'Width';
  FProgressIn.StartValue := FProgressLine.Width;
  FProgressIn.StopValue := AValue;
  FProgressIn.Start;
end;

procedure TMyLoadSk.ResetControls;
begin
  FNewText := '';
  FText.Text := '';
  FText.Opacity := 0;
  TextResizing;
end;

procedure TMyLoadSk.BoxResizing;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FBox.BeginUpdate;
      if FContent.Parent.ClassType = TCustomForm then
      begin
        if TCustomForm(FContent.Parent).Width < 480 then
          FBox.Width := FGray.Width - (FGray.Width * 0.1)
        else if TCustomForm(FContent.Parent).Width < 767 then
          FBox.Width := FGray.Width - (FGray.Width * 0.3)
        else if TCustomForm(FContent.Parent).Width < 979 then
          FBox.Width := FGray.Width - (FGray.Width * 0.5)
        else if TCustomForm(FContent.Parent).Width < 1200 then
          FBox.Width := FGray.Width - (FGray.Width * 0.6)
        else
          FBox.Width := FGray.Width - (FGray.Width * 0.7);

        FBox.EndUpdate;
        Exit;
      end;

      if TControl(FContent.Parent).Width < 480 then
        FBox.Width := FGray.Width - (FGray.Width * 0.1)
      else if TControl(FContent.Parent).Width < 767 then
        FBox.Width := FGray.Width - (FGray.Width * 0.3)
      else if TControl(FContent.Parent).Width < 979 then
        FBox.Width := FGray.Width - (FGray.Width * 0.5)
      else if TControl(FContent.Parent).Width < 1200 then
        FBox.Width := FGray.Width - (FGray.Width * 0.6)
      else
        FBox.Width := FGray.Width - (FGray.Width * 0.7);
    FBox.EndUpdate;
  end);
end;

procedure TMyLoadSk.ControlsResizing;
begin
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    if (FCircleArc.Visible) and (not FProgressContent.Visible) and (FText.Visible) and (not FLottieContent.Visible) then
    begin
      ResizingCircleText;
    end
    else if (FCircleArc.Visible) and (FProgressContent.Visible) and (FText.Visible) and (not FLottieContent.Visible) then
    begin
      ResizingCircleProgressText;
    end
    else if (FCircleArc.Visible) and (not FProgressContent.Visible) and (not FText.Visible) and (not FLottieContent.Visible) then
    begin
      ResizingCircle;
    end
    else if (FCircleArc.Visible) and (FProgressContent.Visible) and (not FText.Visible) and (not FLottieContent.Visible) then
    begin
      ResizingCircleProgress;
    end
    else if (not FCircleArc.Visible) and (not FProgressContent.Visible) and (FText.Visible) and (not FLottieContent.Visible) then
    begin
      ResizingText;
    end
    else if (not FCircleArc.Visible) and (FProgressContent.Visible) and (FText.Visible) and (not FLottieContent.Visible) then
    begin
      ResizingTextProgress;
    end
    else if (not FCircleArc.Visible) and (FProgressContent.Visible) and (not FText.Visible) and (not FLottieContent.Visible) then
    begin
      ResizingProgress;
    end
    else if (FCircleArc.Visible) and (not FProgressContent.Visible) and (FText.Visible) and (FLottieContent.Visible) then
    begin
      ResizingCircleTextLottie;
    end
    else if (FCircleArc.Visible) and (FProgressContent.Visible) and (FText.Visible) and (FLottieContent.Visible) then
    begin
      ResizingCircleProgressTextLottie;
    end
    else if (FCircleArc.Visible) and (not FProgressContent.Visible) and (not FText.Visible) and (FLottieContent.Visible) then
    begin
      ResizingCircleLottie;
    end
    else if (FCircleArc.Visible) and (FProgressContent.Visible) and (not FText.Visible) and (FLottieContent.Visible) then
    begin
      ResizingCircleProgressLottie;
    end
    else if (not FCircleArc.Visible) and (not FProgressContent.Visible) and (FText.Visible) and (FLottieContent.Visible) then
    begin
      ResizingTextLottie;
    end
    else if (not FCircleArc.Visible) and (FProgressContent.Visible) and (FText.Visible) and (FLottieContent.Visible) then
    begin
      ResizingTextProgressLottie;
    end
    else if (not FCircleArc.Visible) and (not FProgressContent.Visible) and (not FText.Visible) and (FLottieContent.Visible) then
    begin
      ResizingLottie;
    end;
  end);
end;

procedure TMyLoadSk.TextResizing;
begin
  FText.BeginUpdate;
    FText.Text := FNewText;
    FText.AutoSize := True;
  FText.EndUpdate;
  FText.RecalcSize;
end;

procedure TMyLoadSk.RemoveFocus;
begin
  if Assigned(Application.MainForm) then
    Application.MainForm.Focused := nil;
end;

procedure TMyLoadSk.HideKeyboard;
var
  LKeyboard: IFMXVirtualKeyboardService;
begin
  if TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, LKeyboard) then
  begin
    if TVirtualKeyBoardState.Visible in LKeyboard.GetVirtualKeyBoardState then
      LKeyboard.HideVirtualKeyboard;
  end;
  LKeyboard := nil;
end;

procedure TMyLoadSk.BringToFront;
begin
  FContent.BringToFront;
end;

procedure TMyLoadSk.RunAnimationsIn;
begin
  GrayIn;
  BoxIn;
  CircleRotation;
end;

procedure TMyLoadSk.RunAnimationsOut;
begin
  BoxOut;
  GrayOut;
end;

procedure TMyLoadSk.OnTimerEllipsis(Sender: TObject);
begin
  FText.BeginUpdate;
    FCountEllipsis := FCountEllipsis + 1;
    if FCountEllipsis = 1 then
      FText.Text := FNewText + '.'
    else if FCountEllipsis = 2 then
      FText.Text := FNewText + '..'
    else if FCountEllipsis = 3 then
      FText.Text := FNewText + '...'
    else
    begin
      FText.Text := FNewText;
      FCountEllipsis := 0;
    end;
  FText.EndUpdate;
end;

procedure TMyLoadSk.ResizingCircle;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := FCircleArc.Height;
  FCircleContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;

procedure TMyLoadSk.ResizingCircleText;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := FCircleArc.Height;
  FCircleContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height + FText.Height;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;

procedure TMyLoadSk.ResizingCircleTextLottie;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := FCircleArc.Height;
  FCircleContent.EndUpdate;

  FLottieContent.BeginUpdate;
    FLottieContent.Height := FLottie.Height;
  FLottieContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height +
                          FText.Height + +
                          FLottieContent.Height + FLottieContent.Margins.Top + FLottieContent.Margins.Bottom;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;

procedure TMyLoadSk.ResizingCircleProgress;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := FCircleArc.Height;
  FCircleContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height + FProgressContent.Height + FProgressContent.Margins.Top + FProgressContent.Margins.Bottom;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;

procedure TMyLoadSk.ResizingCircleProgressLottie;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := FCircleArc.Height;
  FCircleContent.EndUpdate;

  FLottieContent.BeginUpdate;
    FLottieContent.Height := FLottie.Height;
  FLottieContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height +
                          FProgressContent.Height + FProgressContent.Margins.Top + FProgressContent.Margins.Bottom +
                          FLottieContent.Height + FLottieContent.Margins.Top + FLottieContent.Margins.Bottom;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;

procedure TMyLoadSk.ResizingCircleLottie;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := FCircleArc.Height;
  FCircleContent.EndUpdate;

  FLottieContent.BeginUpdate;
    FLottieContent.Height := FLottie.Height;
  FLottieContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height + FLottieContent.Height + FLottieContent.Margins.Top + FLottieContent.Margins.Bottom;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;

procedure TMyLoadSk.ResizingCircleProgressText;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := FCircleArc.Height;
  FCircleContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height + FProgressContent.Height + FProgressContent.Margins.Top + FProgressContent.Margins.Bottom + FText.Height;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;

procedure TMyLoadSk.ResizingCircleProgressTextLottie;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := FCircleArc.Height;
  FCircleContent.EndUpdate;

  FLottieContent.BeginUpdate;
    FLottieContent.Height := FLottie.Height;
  FLottieContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height +
                          FProgressContent.Height + FProgressContent.Margins.Top + FProgressContent.Margins.Bottom +
                          FText.Height + +
                          FLottieContent.Height + FLottieContent.Margins.Top + FLottieContent.Margins.Bottom;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;

procedure TMyLoadSk.ResizingText;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := 0;
  FCircleContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height + FText.Height;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;

procedure TMyLoadSk.ResizingTextProgress;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := 0;
  FCircleContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height + FProgressContent.Height + FProgressContent.Margins.Top + FProgressContent.Margins.Bottom + FText.Height;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;

procedure TMyLoadSk.ResizingTextProgressLottie;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := 0;
  FCircleContent.EndUpdate;

  FLottieContent.BeginUpdate;
    FLottieContent.Height := FLottie.Height;
  FLottieContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height +
                          FProgressContent.Height + FProgressContent.Margins.Top + FProgressContent.Margins.Bottom +
                          FText.Height + +
                          FLottieContent.Height + FLottieContent.Margins.Top + FLottieContent.Margins.Bottom;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;

procedure TMyLoadSk.ResizingTextLottie;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := 0;
  FCircleContent.EndUpdate;

  FLottieContent.BeginUpdate;
    FLottieContent.Height := FLottie.Height;
  FLottieContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height + FLottieContent.Height + FLottieContent.Margins.Top + FLottieContent.Margins.Bottom + FText.Height;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;

procedure TMyLoadSk.ResizingProgress;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := 0;
  FCircleContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height + FProgressContent.Height + FProgressContent.Margins.Top + FProgressContent.Margins.Bottom;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;

procedure TMyLoadSk.ResizingLottie;
begin
  FCircleContent.BeginUpdate;
    FCircleContent.Height := 0;
  FCircleContent.EndUpdate;

  FLottieContent.BeginUpdate;
    FLottieContent.Height := FLottie.Height;
  FLottieContent.EndUpdate;

  FBoxContent.BeginUpdate;
    FBoxContent.Height := FCircleContent.Height + FLottieContent.Height + FLottieContent.Margins.Top + FLottieContent.Margins.Bottom;
  FBoxContent.EndUpdate;

  FBox.BeginUpdate;
    FBox.Height := FBoxContent.Height + FBox.Padding.Top + FBox.Padding.Bottom;
  FBox.EndUpdate;
end;








function TMyLoadSk.Show(const AContainer: TFmxObject; const AText: String = 'Loading...'): IMyLoadSk;
begin
  Result := Self;
  if not Assigned(FContent) then
    CreateInfra;
  FContent.Parent := AContainer;
  ResetControls;
  BoxResizing;
  SetText(AText);
  ControlsResizing;
  RemoveFocus;
  HideKeyboard;
  BringToFront;
  RunAnimationsIn;
end;

function TMyLoadSk.Hide(const ADestroy: Boolean = False): IMyLoadSk;
begin
  Result := Self;
  if ADestroy then
  begin
    DestroyInfra;
    Exit;
  end;
  RunAnimationsOut;
end;

function TMyLoadSk.SetText(const AText: String): IMyLoadSk;
begin
  Result := Self;
  if not Assigned(FContent) then
    Exit;

  FNewText := AText;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    if FText.Opacity = 1 then
    begin
      TextOut;
      Exit;
    end;

    TextResizing;
    TextIn;
  end);
end;

function TMyLoadSk.SetValue(const AValue: Single): IMyLoadSk;
begin
  Result := Self;
  if not FProgressContent.Visible then
    Exit;

  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    if (AValue >= 0) and (AValue <= 100) then
      ProgressIn(FProgressContent.Width * (AValue / 100));
  end);
end;

function TMyLoadSk.IsShowing: Boolean;
begin
  Result := FGray.Opacity = 1;
end;

function TMyLoadSk.OnFinish(AProc: TProc): IMyLoadSk;
begin
  Result := Self;
  FOnFinish := AProc;
end;

function TMyLoadSk.Parameters: IMyLoadSkParameters;
begin
  Result := Self;
end;

function TMyLoadSk.EndParameters: IMyLoadSk;
begin
  Result := Self;
end;

function TMyLoadSk.Background: IMyLoadSkBackground;
begin
  Result := Self;
end;

function TMyLoadSk.Color(const AColor: TAlphaColor): IMyLoadSkBackground;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FGray.BeginUpdate;
      FGray.Fill.Color := AColor;
    FGray.EndUpdate;
  end);
end;

function TMyLoadSk.EndBackground: IMyLoadSkParameters;
begin
  Result := Self;
end;

function TMyLoadSk.Box: IMyLoadSkBox;
begin
  Result := Self;
end;

function TMyLoadSk.Color_(const AColor: TAlphaColor): IMyLoadSkBox;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FBox.BeginUpdate;
      FBox.Fill.Color := AColor;
    FBox.EndUpdate;
  end);
end;

function TMyLoadSk.CornerRadius(const AValue: Single): IMyLoadSkBox;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FBox.BeginUpdate;
      FBox.XRadius := AValue;
      FBox.YRadius := AValue;
    FBox.EndUpdate;
  end);
end;

function TMyLoadSk.Shadow(const AValue: Boolean = False): IMyLoadSkBox;
begin
  Result := Self;
  FBoxShadow := AValue;
end;

function TMyLoadSk.Visible(const AVisible: Boolean): IMyLoadSkBox;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FBox.BeginUpdate;
      if not AVisible then
      begin
        FBox.ClipChildren := False;
        FBox.Fill.Kind := TBrushKind.None;
        FBox.Fill.Color := $FF708090;
        FBox.EndUpdate;
        Exit;
      end;

      FBox.ClipChildren := True;
      FBox.Fill.Kind := TBrushKind.Solid;
    FBox.EndUpdate;
  end);
end;

function TMyLoadSk.EndBox: IMyLoadSkParameters;
begin
  Result := Self;
end;

function TMyLoadSk.Circle: IMyLoadSkCircle;
begin
  Result := Self;
end;

function TMyLoadSk.ActivateBg(const AActivate: Boolean = True): IMyLoadSkCircle;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FCircleBg.BeginUpdate;
      FCircleBg.Visible := AActivate;
    FCircleBg.EndUpdate;

    if AActivate then
    begin
      FCircleArc.BeginUpdate;
        FCircleArc.EndAngle := 60;
      FCircleArc.EndUpdate;
    end
    else
    begin
      FCircleArc.BeginUpdate;
        FCircleArc.EndAngle := 280;
      FCircleArc.EndUpdate;
    end;
  end);
end;

function TMyLoadSk.ColorBg(const AColor: TAlphaColor): IMyLoadSkCircle;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FCircleBg.BeginUpdate;
      FCircleBg.Stroke.Color := AColor;
    FCircleBg.EndUpdate;
  end);
end;

function TMyLoadSk.ColorArc(const AColor: TAlphaColor): IMyLoadSkCircle;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FCircleArc.BeginUpdate;
      FCircleArc.Stroke.Color := AColor;
    FCircleArc.EndUpdate;
  end);
end;

function TMyLoadSk.Shadow_(const AValue: Boolean = False): IMyLoadSkCircle;
begin
  Result := Self;
  FCircleShadow := AValue;
end;

function TMyLoadSk.Size(const ASize: Single): IMyLoadSkCircle;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FCircleBg.BeginUpdate;
      FCircleBg.Height := ASize;
      FCircleBg.Width := ASize;
    FCircleBg.EndUpdate;
    FCircleArc.BeginUpdate;
      FCircleArc.Height := ASize;
      FCircleArc.Width := ASize;
    FCircleArc.EndUpdate;
  end);
end;

function TMyLoadSk.Thickness(const AThickness: Single): IMyLoadSkCircle;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FCircleBg.BeginUpdate;
      FCircleBg.Stroke.Thickness := AThickness;
    FCircleBg.EndUpdate;
    FCircleArc.BeginUpdate;
      FCircleArc.Stroke.Thickness := AThickness;
    FCircleArc.EndUpdate;
  end);
end;

function TMyLoadSk.Visible_(const AVisible: Boolean): IMyLoadSkCircle;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FCircleArc.BeginUpdate;
      FCircleArc.Visible := AVisible;
    FCircleArc.EndUpdate;
  end);
end;

function TMyLoadSk.EndCircle: IMyLoadSkParameters;
begin
  Result := Self;
end;

function TMyLoadSk.Progress: IMyLoadSkProgress;
begin
  Result := Self;
end;

function TMyLoadSk.ColorBg_(const AColor: TAlphaColor): IMyLoadSkProgress;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FProgressBg.BeginUpdate;
      FProgressBg.Fill.Color := AColor;
    FProgressBg.EndUpdate;
  end);
end;

function TMyLoadSk.ColorPg_(const AColor: TAlphaColor): IMyLoadSkProgress;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FProgressLine.BeginUpdate;
      FProgressLine.Fill.Color := AColor;
    FProgressLine.EndUpdate;
  end);
end;

function TMyLoadSk.CornerRadius_(const AValue: Single): IMyLoadSkProgress;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FProgressBg.BeginUpdate;
      FProgressBg.XRadius := AValue;
      FProgressBg.YRadius := AValue;
    FProgressBg.EndUpdate;
    FProgressLine.BeginUpdate;
      FProgressLine.XRadius := AValue;
      FProgressLine.YRadius := AValue;
    FProgressLine.EndUpdate;
  end);
end;

function TMyLoadSk.Shadow__(const AValue: Boolean = False): IMyLoadSkProgress;
begin
  Result := Self;
  FProgressShadow := AValue;
end;

function TMyLoadSk.Size__(const ASize: Single): IMyLoadSkProgress;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FProgressContent.BeginUpdate;
      FProgressContent.Height := ASize;
    FProgressContent.EndUpdate;
  end);
end;

function TMyLoadSk.Visible___(const AVisible: Boolean): IMyLoadSkProgress;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FProgressContent.BeginUpdate;
      FProgressLine.Width := 0;
      FProgressContent.Visible := AVisible;
    FProgressContent.EndUpdate;
  end);
end;

function TMyLoadSk.EndProgress: IMyLoadSkParameters;
begin
  Result := Self;
end;

function TMyLoadSk.Lottie: IMyLoadSkLottie;
begin
  Result := Self;
end;

function TMyLoadSk.LoadFromFile(AFileName: String): IMyLoadSkLottie;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FLottie.BeginUpdate;
      FLottie.LoadFromFile(AFileName);
    FLottie.EndUpdate;
  end);
end;

function TMyLoadSk.Size___(const ASize: Single): IMyLoadSkLottie;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FLottie.BeginUpdate;
      FLottie.Height := ASize;
      FLottie.Width := ASize;
    FLottie.EndUpdate;
  end);
end;

function TMyLoadSk.Visible____(const AVisible: Boolean = False): IMyLoadSkLottie;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FLottieContent.BeginUpdate;
      FLottieContent.Visible := AVisible;
    FLottieContent.EndUpdate;
  end);
end;

function TMyLoadSk.WrapMode(const AValue: TSkAnimatedImageWrapMode): IMyLoadSkLottie;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FLottie.BeginUpdate;
      FLottie.WrapMode := AValue;
    FLottie.EndUpdate;
  end);
end;

function TMyLoadSk.EndLottie: IMyLoadSkParameters;
begin
  Result := Self;
end;

function TMyLoadSk.Text: IMyLoadSkText;
begin
  Result := Self;
end;

function TMyLoadSk.AnimationEllipsis(const AEllipsis: Boolean = False): IMyLoadSkText;
begin
  Result := Self;
  if FText.Visible and AEllipsis then
  begin
    FTimerEllipsis.Enabled := True;
    FCountEllipsis := 1;
  end
  else
    FTimerEllipsis.Enabled := False;
end;

function TMyLoadSk.Color__(const AFontColor: TAlphaColor): IMyLoadSkText;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FText.BeginUpdate;
      FText.Words[0].FontColor := AFontColor;
    FText.EndUpdate;
  end);
end;

function TMyLoadSk.FontFamily(const AFontFamily: TFontName): IMyLoadSkText;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FText.BeginUpdate;
      FText.Words[0].Font.Families := AFontFamily;
    FText.EndUpdate;
  end);
end;

function TMyLoadSk.HorzAlign(const AHorzAlign: TSkTextHorzAlign): IMyLoadSkText;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FText.BeginUpdate;
      FText.TextSettings.HorzAlign := AHorzAlign;
    FText.EndUpdate;
  end);
end;

function TMyLoadSk.LetterSpacing(const ALetterSpacing: Single): IMyLoadSkText;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FText.BeginUpdate;
      FText.Words[0].LetterSpacing := ALetterSpacing;
    FText.EndUpdate;
  end);
end;

function TMyLoadSk.Shadow___(const AValue: Boolean = False): IMyLoadSkText;
begin
  Result := Self;
  FTextShadow := AValue;
end;

function TMyLoadSk.Size_(const AFontSize: Single): IMyLoadSkText;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FText.BeginUpdate;
      FText.Words[0].Font.Size := AFontSize;
    FText.EndUpdate;
  end);
end;

function TMyLoadSk.Slant(const ASlant: TFontSlant): IMyLoadSkText;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FText.BeginUpdate;
      FText.Words[0].Font.Slant := ASlant;
    FText.EndUpdate;
  end);
end;

function TMyLoadSk.VertAlign(const AVertAlign: TTextAlign): IMyLoadSkText;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FText.BeginUpdate;
      FText.TextSettings.VertAlign := AVertAlign;
    FText.EndUpdate;
  end);
end;

function TMyLoadSk.Visible__(const AVisible: Boolean = True): IMyLoadSkText;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FText.BeginUpdate;
      FText.Visible := AVisible;
    FText.EndUpdate;
  end);
end;

function TMyLoadSk.Weight(const AWeight: TFontWeight): IMyLoadSkText;
begin
  Result := Self;
  TThread.Synchronize(TThread.CurrentThread,
  procedure
  begin
    FText.BeginUpdate;
      FText.Words[0].Font.Weight := AWeight;
    FText.EndUpdate;
  end);
end;

function TMyLoadSk.EndText: IMyLoadSkParameters;
begin
  Result := Self;
end;

end.
