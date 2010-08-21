unit uTwitter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Common, CategoryButtons,
  ButtonGroup, LCExceptions;

type
  TfTwitter = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    GroupBox1: TGroupBox;
    ButtonGroup1: TButtonGroup;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonGroup1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fTwitter: TfTwitter;

implementation

uses TwitAuth;

{$R *.dfm}

procedure TfTwitter.Button1Click(Sender: TObject);
var i:integer;
begin
try
  Twitter.Update(Memo1.Text)
finally
  ModalResult:=mrOk;
  Hide;
end;
end;

procedure TfTwitter.ButtonGroup1Click(Sender: TObject);
begin
 Memo1.Lines.Text:=Memo1.Lines.Text+' '+ButtonGroup1.Items[ButtonGroup1.ItemIndex].Caption;
 Memo1Change(self);
end;

procedure TfTwitter.FormShow(Sender: TObject);
var s:string;
    Tags: TStringList;
    i:integer;
begin
Button1.Enabled:=Twitter.Authorized;
if not Twitter.Authorized then
 if MessageBox(fTwitter.Handle,PChar(rcNoTwitAuth),PChar(rcNoTwitAuthHead),MB_YESNO)=idYes then
   begin
     StartAuthorization(s);
     ShowAuthorizationForm(s, AuthForm.WebBrowser1, AuthForm);
   end;
Label2.Caption:=IntToStr(140-Length(Memo1.Text));
Tags:=TStringList.Create;
Tags.Assign(Twitter.GetCurrentHashTags);
for I:= 0 to Tags.Count - 1 do
  ButtonGroup1.Items[i].Caption:=Tags[i];
FreeAndNil(Tags);
end;

procedure TfTwitter.GroupBox1Click(Sender: TObject);
begin
if fTwitter.Height<160 then
  begin
    fTwitter.Height:=397;
    GroupBox1.Height:=261;
    Button1.Top:=343;
  end
else
  begin
    fTwitter.Height:=154;
    GroupBox1.Height:=17;
    Button1.Top:=97;
  end;

end;

procedure TfTwitter.Memo1Change(Sender: TObject);
begin
label2.Caption:=IntToStr(140-Length(Memo1.Text));
  Button1.Enabled:=Length(Memo1.Text)<=140;
if Length(Memo1.Text)<=140 then
  label2.Font.Color:=clBlack
else
  label2.Font.Color:=clRed
end;

end.
