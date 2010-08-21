unit shrtOptions;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, uShorter, Spin, Common,
  ComCtrls,Common_FF;

type
  TFOptions = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Button3: TButton;
    Button2: TButton;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label4: TLabel;
    Edit3: TEdit;
    UpDown1: TUpDown;
    Label5: TLabel;
    Button1: TButton;
    TabSheet2: TTabSheet;
    CheckBox5: TCheckBox;
    Label6: TLabel;
    ComboBox1: TComboBox;
    Label7: TLabel;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FOptions: TFOptions;

implementation

uses TwitAuth, OldMain, LCExceptions, uFFAuth;
{$R *.dfm}

procedure TFOptions.Button1Click(Sender: TObject);
var
  F: TIniFile;
begin
  try
    F := TIniFile.Create(ResourcePath + sOptnsFile);
    F.WriteBool('Upgrade', 'AutoCheck', CheckBox1.Checked);

    Options.DoBitly :=CheckBox2.Checked;

    if Options.DoBitly then
    begin
      Options.BitlyLogin := Edit1.Text;
      Options.BitlyAPI := Edit2.Text;
    end
    else
    begin
      Options.BitlyLogin := '';
      Options.BitlyAPI := '';
      OldMainForm.CheckBox2.Checked := false;
      OldMainForm.SpeedButton8.Enabled := false;
      OldMainForm.SpeedButton9.Enabled := false;
      OldMainForm.label7.Enabled := false;
    end;
    Options.DoIntelligentSearch := CheckBox3.Checked;
    Options.SaveStory := CheckBox4.Checked;
    OldMainForm.CheckBox2.Enabled := Options.DoBitly;

    if Options.SaveStory then
      Options.StroryLength := StrToInt(Edit3.Text);
    F.WriteBool(sSectionMain, 'DoIntSearch', Options.DoIntelligentSearch);
    F.WriteBool(sSectionMain, 'SaveStory', Options.SaveStory);
    F.WriteInteger(sSectionMain, 'StroryLength', Options.StroryLength);
    F.WriteString(sSectionBitly, 'Login', Options.BitlyLogin);
    F.WriteString(sSectionBitly, 'api', Options.BitlyAPI);

    F.WriteBool(sSectionInter, 'SaveForm', CheckBox5.Checked);
    case ComboBox1.ItemIndex of
      0:F.WriteString(sSectionInter, 'Copy', 'Link');
      1:F.WriteString(sSectionInter, 'Copy', 'ForumAnchor');
      2:F.WriteString(sSectionInter, 'Copy', 'Forum');
      3:F.WriteString(sSectionInter, 'Copy', 'HTML');
    end;
    hide;
  finally
    F.Free;
    ModalResult := mrOk;
    Options.Load;
    OldMainForm.ChangeVisibles;
    OldMainForm.StatusBar1.Repaint;
  end;
end;

procedure TFOptions.Button2Click(Sender: TObject);
var
  s: string;
begin
  StartAuthorization(s);
  ShowAuthorizationForm(s, AuthForm.WebBrowser1, AuthForm);
end;

procedure TFOptions.Button3Click(Sender: TObject);
var
  F: TIniFile;
begin
  F := TIniFile.Create(ResourcePath + sOptnsFile);
  F.DeleteKey(sSectionTwitter, 'Token');
  F.DeleteKey(sSectionTwitter, 'Token_secret');
  F.Free;
  Options.TwitterToken := '';
  Options.TwitterTokenSecret := '';
  Twitter.OAuth_token := '';
  Twitter.OAuth_token_secret := '';
  Twitter.Authorized := false;
  Button2.Enabled := not Twitter.Authorized;
  Button3.Enabled := Twitter.Authorized;
end;

procedure TFOptions.Button4Click(Sender: TObject);
begin
Options.FFLogin:='';
Options.FFKey:='';
FriendFeed.Authorized:=false;
Button5.Enabled:=true;
Button4.Enabled:=false;
Options.Save;
Options.Load;
end;

procedure TFOptions.Button5Click(Sender: TObject);
begin
ffauthform.ShowModal;
end;

procedure TFOptions.CheckBox2Click(Sender: TObject);
begin
  Edit1.Enabled := CheckBox2.Checked;
  Edit2.Enabled := CheckBox2.Checked;
  Label2.Enabled := CheckBox2.Checked;
  Label3.Enabled := CheckBox2.Checked;
end;

procedure TFOptions.FormShow(Sender: TObject);
begin
  Button2.Enabled := not Twitter.Authorized;
  Button3.Enabled := Twitter.Authorized;
  CheckBox1.Checked := Options.AutoCheck;
  CheckBox2.Checked := Options.DoBitly;
  CheckBox3.Checked := Options.DoIntelligentSearch;
  CheckBox5.Checked:=Options.SaveForm;

  Button5.Enabled:=(Length(Trim(Options.FFLogin))=0)or
     (Length(Trim(Options.FFKey))=0);
  Button4.Enabled:=(Length(Trim(Options.FFLogin))>0)and
     (Length(Trim(Options.FFKey))>0);

  if Options.CopyOperation='Link' then ComboBox1.ItemIndex:=0
  else
  if Options.CopyOperation='ForumAnchor' then ComboBox1.ItemIndex:=1
  else
    if Options.CopyOperation='Forum' then ComboBox1.ItemIndex:=2
    else ComboBox1.ItemIndex:=3;

  if Options.DoBitly then
  begin
    Edit1.Text := Options.BitlyLogin;
    Edit2.Text := Options.BitlyAPI;
  end
  else
  begin
    Edit1.Text := '';
    Edit2.Text := '';
  end;
  CheckBox2Click(self);
  CheckBox4.Checked := Options.SaveStory;
  if Options.SaveStory then
  begin
    Edit3.Text := IntToStr(Options.StroryLength);
    UpDown1.Position := Options.StroryLength;
  end
  else
  begin
    Edit3.Text := '0';
    UpDown1.Position := 0;
  end;
end;

end.
