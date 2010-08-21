unit uFFAuth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, ExtCtrls,uShorter,Common_FF;

type
  Tffauthform = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    WebBrowser1: TWebBrowser;
    Panel2: TPanel;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ffauthform: Tffauthform;

implementation

uses shrtOptions;

{$R *.dfm}

procedure Tffauthform.Button1Click(Sender: TObject);
begin
  Options.FFLogin:=Edit1.Text;
  Options.FFKey:=Edit2.Text;
  Options.Save;
  Options.Load;

  FOptions.Button5.Enabled:=(Length(Trim(Options.FFLogin))=0)or
     (Length(Trim(Options.FFKey))=0);
  FOptions.Button4.Enabled:=(Length(Trim(Options.FFLogin))>0)and
     (Length(Trim(Options.FFKey))>0);
  FriendFeed.Authorized:=FOptions.Button4.Enabled;
  ModalResult:=mrOk;
  Hide;
end;

procedure Tffauthform.FormShow(Sender: TObject);
begin
  WebBrowser1.Navigate(ffRemoteKeyURL);
end;

end.
