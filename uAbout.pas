unit uAbout;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, uShorter,Common,common_FF;

type
  TfAbout = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label7MouseEnter(Sender: TObject);
    procedure Label7MouseLeave(Sender: TObject);
    procedure Label9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label9MouseLeave(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAbout: TfAbout;

implementation

{$R *.dfm}

procedure TfAbout.Button1Click(Sender: TObject);
begin
ModalResult:=mrOk;
Hide;
end;

procedure TfAbout.FormShow(Sender: TObject);
begin
  label6.Caption:=GetFileVersion(Application.ExeName)
end;

procedure TfAbout.Label7Click(Sender: TObject);
begin
OpenURL(CallbackURL);
end;

procedure TfAbout.Label7MouseEnter(Sender: TObject);
begin
label7.Font.Color:=clMaroon;
end;

procedure TfAbout.Label7MouseLeave(Sender: TObject);
begin
label7.Font.Color:=clNavy;
end;

procedure TfAbout.Label9Click(Sender: TObject);
begin
OpenURL(ffGroupURL)
end;

procedure TfAbout.Label9MouseLeave(Sender: TObject);
begin
label9.Font.Color:=clNavy;
end;

procedure TfAbout.Label9MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
label9.Font.Color:=clMaroon;
end;

end.
