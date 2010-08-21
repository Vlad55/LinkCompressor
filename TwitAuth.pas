unit TwitAuth;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  StdCtrls, ExtCtrls, OleCtrls, SHDocVw,Common,IniFiles,uShorter,
  LCExceptions;

type
  TAuthForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    Edit1: TEdit;
    CheckBox1: TCheckBox;
    WebBrowser1: TWebBrowser;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AuthForm: TAuthForm;

implementation

uses uTwitter, shrtOptions;

{$R *.dfm}

procedure TAuthForm.Button1Click(Sender: TObject);
var F:TINIFile;
begin
Authorization(Edit1.Text);
try
  Twitter.Authorized:=(Length(Twitter.OAuth_token)>0)and(Length(Twitter.OAuth_token_secret)>0);
  FOptions.Button2.Enabled := not Twitter.Authorized;
  FOptions.Button3.Enabled := Twitter.Authorized;
  if Twitter.Authorized then
    begin
      if CheckBox1.Checked then
        begin
          F:=TIniFile.Create(ResourcePath+sOptnsFile);
          F.WriteString(sSectionTwitter,'Token',Twitter.OAuth_token);
          F.WriteString(sSectionTwitter,'Token_secret',Twitter.OAuth_token_secret);
          F.Free;

        end;
    end
  else
    TLCExceptions.Show(rcWrongAuth,rcError,ErrorOk);
except
  TLCExceptions.Show(rcWrongAuth,rcError,ErrorOk);
  Twitter.Authorized:=false;
end;
if fTwitter.Showing then
   fTwitter.Button1.Enabled:=Twitter.Authorized;
 Hide;
 ModalResult:=mrOk;
end;

procedure TAuthForm.Edit1Change(Sender: TObject);
begin
Button1.Enabled:=Length(Edit1.Text)>0;
end;

end.
