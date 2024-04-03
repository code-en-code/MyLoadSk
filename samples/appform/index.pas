unit index;

interface

uses
  //delphi
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,

  //fmx
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.TabControl,

  //codeencode
  myloadsk,
  mythread;

type
  TIndexView = class(TForm)
    tbcBody: TTabControl;
    tabMain: TTabItem;
    btnWithoutFail: TButton;
    memValues: TMemo;
    tabFail: TTabItem;
    btnWithFail: TButton;
    lblFail: TLabel;
    btnBack: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnWithoutFailClick(Sender: TObject);
    procedure btnWithFailClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FLoad: IMyLoadSk;
    FShowFail: TMyThreadCustomFail;
    FWithFail: Boolean;
    procedure SetFailMethod;
    procedure Execute;
    procedure ListValues;
    procedure ShowLoading;
    procedure ShowSuccess;
    procedure FinishFail;
    procedure FinishSuccess;
  public
    { Public declarations }
  end;

var
  IndexView: TIndexView;

implementation

{$R *.fmx}

procedure TIndexView.FormDestroy(Sender: TObject);
begin
  FLoad.Hide(True);
end;

procedure TIndexView.FormShow(Sender: TObject);
begin
  tbcBody.ActiveTab := tabMain;
  FLoad := TMyLoadSk.New
            .Parameters
              .Circle
                .Visible_(False)
              .EndCircle
              .Progress
                .Size__(5)
                .Visible___(True)
              .EndProgress
            .EndParameters;
  SetFailMethod;
end;

procedure TIndexView.btnWithoutFailClick(Sender: TObject);
begin
  FWithFail := False;
  Execute;
end;

procedure TIndexView.btnWithFailClick(Sender: TObject);
begin
  FWithFail := True;
  Execute;
end;

procedure TIndexView.btnBackClick(Sender: TObject);
begin
  tbcBody.ActiveTab := tabMain;
end;

procedure TIndexView.SetFailMethod;
begin
  FShowFail := procedure(const AValue: String)
    begin
      FLoad.OnFinish(FinishFail).Hide;
      memValues.Lines.Add(AValue);
    end;
end;

procedure TIndexView.Execute;
begin
  TMyThread.Custom(
    ShowLoading,
    ListValues,
    ShowSuccess,
    FShowFail);
end;

procedure TIndexView.ListValues;
var
  LNewValue: Integer;
  LIndex: Integer;
begin
  LNewValue := 0;
  memValues.Lines.Clear;
  FLoad
    .Parameters
      .Progress
        .Visible___(True)
      .EndProgress
    .EndParameters
    .SetValue(0);
  for LIndex := 1 to 20 do
  begin
    //simulating a process...
    Sleep(1000);
    LNewValue := Random(10) + LIndex;
    TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        FLoad.SetValue((LIndex / 20) * 100);
        FLoad.SetText('Process ' + LIndex.ToString + ' of ' + '20');
        memValues.Lines.Add('Process ' + LIndex.ToString + ' - ' +
                            'Value ' + LNewValue.ToString + '.');
      end);
    //simulate fail
    if FWithFail then
      if LIndex = 10 then
        raise Exception.Create('Process ' + LIndex.ToString + ' failure.');
  end;
end;

procedure TIndexView.ShowLoading;
begin
  FLoad.Show(Self, 'Please wait a moment');
end;

procedure TIndexView.ShowSuccess;
begin
  FLoad.OnFinish(FinishSuccess).Hide;
end;

procedure TIndexView.FinishFail;
begin
  tbcBody.ActiveTab := tabFail;
end;

procedure TIndexView.FinishSuccess;
begin
  ShowMessage('Success');
  tbcBody.ActiveTab := tabMain;
end;

end.
