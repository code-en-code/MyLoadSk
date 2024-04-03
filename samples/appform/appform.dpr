program appform;
uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  index in 'index.pas' {IndexView},
  mythread in '..\..\modules\mythread\src\mythread.pas',
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
