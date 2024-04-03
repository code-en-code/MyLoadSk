program myloadfront;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  index in 'index.pas' {IndexView},
  myloadsk in '..\..\src\myloadsk.pas';

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TIndexView, IndexView);
  Application.Run;
  {$IFDEF DEBUG}
    ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
end.
