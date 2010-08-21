unit udeshifr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls,LinkTest,ShellAPI;

type
  TfDeshifr = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Edit2: TEdit;
    Label12: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Label18Click(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label16MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label16MouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label18MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label18MouseLeave(Sender: TObject);
    procedure Label12MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label12MouseLeave(Sender: TObject);
    procedure Label13MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label13MouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDeshifr: TfDeshifr;
  LT:TLinkTester;

implementation

{$R *.dfm}

procedure TfDeshifr.Edit2Exit(Sender: TObject);
begin
  Edit2.Visible:=false;
end;

procedure TfDeshifr.FormCreate(Sender: TObject);
begin
  LT:=TLinkTester.Create;
end;

procedure TfDeshifr.Label12Click(Sender: TObject);
begin
ShellExecute(Application.Handle,
 PChar('open'),
 PChar(SafeBrowser+LT.domain),
 PChar(0),
 nil,
 SW_NORMAL) ;
end;

procedure TfDeshifr.Label12MouseLeave(Sender: TObject);
begin
  label12.Font.Color:=clNavy;
end;

procedure TfDeshifr.Label12MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  label12.Font.Color:=clMaroon;
end;

procedure TfDeshifr.Label13MouseLeave(Sender: TObject);
begin
 label13.Font.Color:=clNavy;
end;

procedure TfDeshifr.Label13MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  label13.Font.Color:=clMaroon;
end;

procedure TfDeshifr.Label16Click(Sender: TObject);
begin
Edit2Exit(self);
ShowMessage(LT.PathToDomain.DelimitedText);
end;

procedure TfDeshifr.Label16MouseLeave(Sender: TObject);
begin
  label16.Font.Color:=clNavy;
end;

procedure TfDeshifr.Label16MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  label16.Font.Color:=clMaroon;
end;

procedure TfDeshifr.Label18Click(Sender: TObject);
begin
  Edit2.Text:=label18.Caption;
  Edit2.Visible:=true;
  Edit2.SetFocus;
end;

procedure TfDeshifr.Label18MouseLeave(Sender: TObject);
begin
label18.Font.Color:=clNavy;
end;

procedure TfDeshifr.Label18MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  label18.Font.Color:=clMaroon;
end;

procedure TfDeshifr.SpeedButton1Click(Sender: TObject);
var
    Loc:string;
begin
  label5.Caption:='---';
  label7.Caption:='---';
  label9.Caption:='0';
  label18.Caption:='---';
  label3.Caption:='---';
  label13.Caption:='0';

  LT.ShortLink:=Edit1.Text;
  LT.Analyse;
  Label16.Caption:=IntToStr(LT.PathToDomain.Count-1);
  label5.Caption:=LT.domain;
  label7.Caption:=LT.MimeType;
  if LowerCase(SafeContentType)=LowerCase(Trim(LT.MimeType)) then
    label7.Font.Color:=clGreen
  else
    label7.Font.Color:=clRed;
  label9.Caption:=CurrToStr(LT.Size/1024);
  label18.Caption:=LT.LongLink;
  label18.Hint:=label18.Caption;
  label3.Caption:=LT.Title;
  label3.Hint:=label3.Caption;
  label13.Caption:=IntToStr(LT.iFrames);
  Edit2Exit(self);
end;

end.
