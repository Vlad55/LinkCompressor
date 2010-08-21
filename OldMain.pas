unit OldMain;

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Menus, Buttons, ComCtrls, uShorter, Clipbrd,
  Common, LCExceptions, HHCTRLLib_TLB, common_FF, pngimage, TypInfo, dialogs,
  AppEvnts;

type
 tagHH_POPUP = record
    cbStruct: integer;
    hinst:HINST;
    idString:UINT;
    pszText:LPCTStr;
    pt:TPoint;
    clrForeground:COLORREF;
    clrBackground:COLORREF;
    rcMargins:TRect;
    pszFont:LPCTStr;
end;


type
  TOldMainForm = class(TForm)
    Label1: TLabel;
    SpeedButton5: TSpeedButton;
    ComboBox1: TComboBox;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    StatusBar1: TStatusBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Label7: TLabel;
    Label8: TLabel;
    Edit4: TEdit;
    PopupMenu1: TPopupMenu;
    N6: TMenuItem;
    N7: TMenuItem;
    Label9: TLabel;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    SpeedButton10: TSpeedButton;
    Label10: TLabel;
    BB1: TMenuItem;
    HTML1: TMenuItem;
    N2: TMenuItem;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    ApplicationEvents1: TApplicationEvents;
    N8: TMenuItem;
    procedure N1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure BB1Click(Sender: TObject);
    procedure HTML1Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label10MouseEnter(Sender: TObject);
    procedure Label10MouseLeave(Sender: TObject);
    procedure Label3MouseEnter(Sender: TObject);
    procedure Label3MouseLeave(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure ApplicationEvents1ShowHint(var HintStr: string;
      var CanShow: Boolean; var HintInfo: THintInfo);
    procedure N8Click(Sender: TObject);
  private
    procedure MinimizeProc(Sender: TObject);
  public
    procedure ChangeVisibles;
    procedure BitLyCompress;
    procedure IsGdCompress;
    procedure ZiMaCompress;
    procedure ClckCompress;
    procedure CopyLink;
    procedure ShowTwitForm(const aText: string);
    procedure ShowFFForm(const aText: string);
    procedure CheckLink;
  end;

var
  OldMainForm: TOldMainForm;

implementation

uses shrtOptions, uReport, uAbout, uTwitter, uFFSender, udeshifr;
{$R *.dfm}

procedure TOldMainForm.ApplicationEvents1ShowHint
  (var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
var
  r: TRect;
  idx: integer;
begin
  if (HintInfo.HintControl = StatusBar1) AND (NOT StatusBar1.SimplePanel) then
  begin
    r := StatusBar1.ClientRect;
    r.Right := StatusBar1.Panels[0].Width;
    // на какой панели находится мышь
    for idx := 0 to -1 + StatusBar1.Panels.Count do
    begin
      if r.Right > HintInfo.CursorPos.X then
      begin
        HintInfo.CursorRect := r;
        // обеспечиваем подсказку для панели, где мышь
        case idx of
          1:
            begin
              if Twitter.Authorized then
                HintStr := rcTwitter + ' ' + rcReady
              else
                HintStr := rcTwitter + ' ' + rcNotReady
            end;
          3:
            begin
              if FriendFeed.Authorized then
                HintStr := rcFF + ' ' + rcReady
              else
                HintStr := rcFF + ' ' + rcNotReady
            end;
        end;
        Exit;
      end;
      OffsetRect(r, StatusBar1.Panels[idx].Width, 0);
    end;
  end;
end;

procedure TOldMainForm.BB1Click(Sender: TObject);
begin
  if Edit4.Focused then
    Clipboard.AsText := TShorter.GetForumLink(Edit4.Text)
  else if Edit1.Focused then
    Clipboard.AsText := TShorter.GetForumLink(Edit1.Text)
  else if Edit2.Focused then
    Clipboard.AsText := TShorter.GetForumLink(Edit2.Text)
  else if Edit3.Focused then
    Clipboard.AsText := TShorter.GetForumLink(Edit3.Text)
end;

procedure TOldMainForm.BitLyCompress;
var
  shrt: string;
begin
  shrt := bitly(ComboBox1.Text);
  if TShorter.IsLink(shrt) then
  begin
    Edit4.Text := shrt;
    Label7.Caption := Format(sRateLabalText, [Length(shrt),
      TShorter.CompressionRate(ComboBox1.Text, shrt)])
  end
  else
  begin
    Edit4.Text := '';
    TLCExceptions.ShowFmt(rcServiceCompressError, rcError, ErrorOk, ['bit.ly']);
  end;
  Application.ProcessMessages;
end;

procedure TOldMainForm.Button1Click(Sender: TObject);
begin
  // HHCtrl:=THHCtrl.Create(self);
  // HHCtrl.syncURL('D:\Google Login\Сокращатель ссылок\OldInterface\Help\Table of Contents.hhc');
  // HHCtrl.TextPopup('Текст подсказки','Times New Roman',5,5,clYellow,clBlue);
  // HHCtrl.Click;
  // HtmlHelpA(handle,PAnsiChar('D:\Google Login\Сокращатель ссылок\OldInterface\Help\help.chm'),HH_DISPLAY_TOPIC,0)
end;

procedure TOldMainForm.ChangeVisibles;
begin
  Edit4.Visible := Options.DoBitly;
  Label3.Visible := not Options.DoBitly;
  SpeedButton8.Enabled := Length(Edit4.Text) > 0;
  SpeedButton1.Enabled := Length(Edit1.Text) > 0;
  SpeedButton2.Enabled := Length(Edit2.Text) > 0;
  SpeedButton3.Enabled := Length(Edit3.Text) > 0;
  SpeedButton9.Visible := Twitter.Authorized and SpeedButton8.Enabled;
  SpeedButton4.Visible := Twitter.Authorized and SpeedButton1.Enabled;
  SpeedButton6.Visible := Twitter.Authorized and SpeedButton2.Enabled;
  SpeedButton7.Visible := Twitter.Authorized and SpeedButton3.Enabled;

  SpeedButton11.Enabled := (Length(Edit4.Text) > 0) and (Options.FFLogin <> '')
    and (Options.FFKey <> '');
  SpeedButton12.Enabled := (Length(Edit1.Text) > 0) and (Options.FFLogin <> '')
    and (Options.FFKey <> '');
  SpeedButton13.Enabled := (Length(Edit2.Text) > 0) and (Options.FFLogin <> '')
    and (Options.FFKey <> '');
  SpeedButton14.Enabled := (Length(Edit3.Text) > 0) and (Options.FFLogin <> '')
    and (Options.FFKey <> '');

  Label7.Visible := SpeedButton9.Visible;
  Label4.Visible := SpeedButton4.Visible;
  Label5.Visible := SpeedButton6.Visible;
  Label6.Visible := SpeedButton7.Visible;

  CheckBox6.Checked := Copyer.Short;
  CheckBox7.Checked := Copyer.Codes;
  Label10.Enabled := Copyer.Codes;
end;

procedure TOldMainForm.CheckBox1Click(Sender: TObject);
begin
  CheckBox2.Checked := CheckBox1.Checked and Options.DoBitly;
  CheckBox3.Checked := CheckBox1.Checked;
  CheckBox4.Checked := CheckBox1.Checked;
  CheckBox5.Checked := CheckBox1.Checked;
end;

procedure TOldMainForm.CheckBox6Click(Sender: TObject);
begin
  Copyer.Short := CheckBox6.Checked;
  SpeedButton10.Enabled := CheckBox6.Checked or CheckBox7.Checked
end;

procedure TOldMainForm.CheckBox7Click(Sender: TObject);
begin
  Copyer.Codes := CheckBox7.Checked;
  Label10.Enabled := CheckBox7.Checked;
  SpeedButton10.Enabled := CheckBox6.Checked or CheckBox7.Checked
end;

procedure TOldMainForm.CheckLink;
var
  lnk: string;
begin
  if Clipboard.HasFormat(CF_TEXT) then
  begin
    lnk := Clipboard.AsText;
    if IsLink(lnk) then
      ComboBox1.Text := lnk;
  end;
end;

procedure TOldMainForm.ClckCompress;
var
  shrt: string;
begin
  shrt := clck(ComboBox1.Text);
  if TShorter.IsLink(shrt) then
  begin
    Edit3.Text := shrt;
    Label6.Caption := Format(sRateLabalText, [Length(shrt),
      TShorter.CompressionRate(ComboBox1.Text, shrt)])
  end
  else
  begin
    Edit3.Text := '';
    TLCExceptions.ShowFmt(rcServiceCompressError, rcError, ErrorOk,
      ['clck.ru']);
  end;
  Application.ProcessMessages;
end;

procedure TOldMainForm.CopyLink;
begin
  if Options.CopyOperation = 'Link' then
    N6Click(Self)
  else if Options.CopyOperation = 'ForumAnchor' then
    N7Click(Self)
  else if Options.CopyOperation = 'Forum' then
    BB1Click(Self)
  else
    HTML1Click(Self)
end;

procedure TOldMainForm.FormActivate(Sender: TObject);
begin
  if Options.AutoCheck then
  begin
    IsNewVersion(GetFileVersion(Application.ExeName));
  end;
  Edit4.Visible := Options.DoBitly;
  Label3.Visible := not Options.DoBitly;

  CheckLink
end;

procedure TOldMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Options.FormWidth := OldMainForm.Width;
  Options.FormTop := OldMainForm.Top;
  Options.FormLeft := OldMainForm.Left;
  Options.Save;
  WriteHistory(ComboBox1.Items);
  Copyer.Destroy;
end;

procedure TOldMainForm.FormCreate(Sender: TObject);
var
  lnk: string;
begin
  Application.Name := sAppName;
  GetResourcePath;
  Twitter := TTwitter.Create;

  Options := TOptions.Create;

  FriendFeed := TFriendFeed.Create;
  FriendFeed.Login := Options.FFLogin;
  FriendFeed.RemoteKey := Options.FFKey;
  FriendFeed.Authorized := (Length(FriendFeed.Login) > 0) and
    (Length(FriendFeed.RemoteKey) > 0);

  Copyer := TGroupCopyer.Create;

  Application.OnMinimize := MinimizeProc;

  LoadHistory(ComboBox1.Items);
  if ComboBox1.Items.Count > 0 then
    ComboBox1.ItemIndex := 0
  else
    ComboBox1.Text := '';

  Edit1.Text := '';
  Edit2.Text := '';
  Edit3.Text := '';
  Edit4.Text := '';

  ChangeVisibles;

  if Twitter.Authorized then
    GetTweetAcc;
  CheckLink;
  if not Options.DoBitly then
  begin
    OldMainForm.CheckBox2.Checked := false;
    SpeedButton8.Enabled := false;
    SpeedButton9.Enabled := false;
    Label7.Enabled := false;
  end;

  if Options.SaveForm then
  begin
    OldMainForm.Width := Options.FormWidth;
    OldMainForm.Top := Options.FormTop;
    OldMainForm.Left := Options.FormLeft;
  end;

  OldMainForm.CheckBox2.Enabled := Options.DoBitly;
end;

procedure TOldMainForm.FormResize(Sender: TObject);
begin
  // изменяем размеры и положение контролов
  ComboBox1.Width := OldMainForm.Width - 73;
  SpeedButton5.Left := ComboBox1.Left + ComboBox1.Width + 2;
  SpeedButton10.Left := (OldMainForm.Width shr 1) - (SpeedButton10.Width shr 1);
  // изменяем размеры Edit'ов сервисов
  Edit4.Width := OldMainForm.Width - 196;
  Edit1.Width := Edit4.Width;
  Edit2.Width := Edit4.Width;
  Edit3.Width := Edit4.Width;
  SpeedButton8.Left := Edit4.Left + Edit4.Width + 2;
  SpeedButton1.Left := SpeedButton8.Left;
  SpeedButton2.Left := SpeedButton8.Left;
  SpeedButton3.Left := SpeedButton8.Left;
  SpeedButton9.Left := SpeedButton8.Left + SpeedButton8.Width + 2;
  SpeedButton4.Left := SpeedButton9.Left;
  SpeedButton6.Left := SpeedButton9.Left;
  SpeedButton7.Left := SpeedButton9.Left;

  SpeedButton11.Left := SpeedButton9.Left + SpeedButton9.Width + 2;
  SpeedButton12.Left := SpeedButton11.Left;
  SpeedButton13.Left := SpeedButton11.Left;
  SpeedButton14.Left := SpeedButton11.Left;

  Label7.Left := SpeedButton11.Left + SpeedButton11.Width + 2;
  Label4.Left := Label7.Left;
  Label5.Left := Label7.Left;
  Label6.Left := Label7.Left;
end;

procedure TOldMainForm.HTML1Click(Sender: TObject);
begin
  if Edit4.Focused then
    Clipboard.AsText := TShorter.GetHTMLLink(Edit4.Text)
  else if Edit1.Focused then
    Clipboard.AsText := TShorter.GetHTMLLink(Edit1.Text)
  else if Edit2.Focused then
    Clipboard.AsText := TShorter.GetHTMLLink(Edit2.Text)
  else if Edit3.Focused then
    Clipboard.AsText := TShorter.GetHTMLLink(Edit3.Text)
end;

procedure TOldMainForm.IsGdCompress;
var
  shrt: string;
begin
  shrt := isgd(ComboBox1.Text);
  if TShorter.IsLink(shrt) then
  begin
    Edit1.Text := shrt;
    Label4.Caption := Format(sRateLabalText, [Length(shrt),
      TShorter.CompressionRate(ComboBox1.Text, shrt)])
  end
  else
  begin
    Edit1.Text := '';
    TLCExceptions.ShowFmt(rcServiceCompressError, rcError, ErrorOk, ['is.gd']);
  end;
  Application.ProcessMessages;
end;

procedure TOldMainForm.Label10Click(Sender: TObject);
begin
  ContactForm.ShowModal
end;

procedure TOldMainForm.Label10MouseEnter(Sender: TObject);
begin
  Label10.Font.Color := clMaroon;
end;

procedure TOldMainForm.Label10MouseLeave(Sender: TObject);
begin
  Label10.Font.Color := clNavy;
end;

procedure TOldMainForm.Label3Click(Sender: TObject);
begin
  OpenURL('http://bit.ly');
end;

procedure TOldMainForm.Label3MouseEnter(Sender: TObject);
begin
  Label3.Font.Color := clMaroon;
end;

procedure TOldMainForm.Label3MouseLeave(Sender: TObject);
begin
  Label3.Font.Color := clNavy;
end;

procedure TOldMainForm.MinimizeProc(Sender: TObject);
begin
  CheckLink
end;

procedure TOldMainForm.N1Click(Sender: TObject);
begin
  FOptions.ShowModal;
end;

procedure TOldMainForm.N2Click(Sender: TObject);
begin
  if not IsNewVersion(GetFileVersion(Application.ExeName)) then
    MessageBox(0, PChar(rcNoNewVersions), sAppName, MB_OK + MB_ICONINFORMATION);
end;

procedure TOldMainForm.N4Click(Sender: TObject);
begin
  fAbout.ShowModal;
end;

procedure TOldMainForm.N6Click(Sender: TObject);
begin
  if Edit4.Focused then
    Clipboard.AsText := Edit4.Text
  else if Edit1.Focused then
    Clipboard.AsText := Edit1.Text
  else if Edit2.Focused then
    Clipboard.AsText := Edit2.Text
  else if Edit3.Focused then
    Clipboard.AsText := Edit3.Text
end;

procedure TOldMainForm.N7Click(Sender: TObject);
begin
  if Edit4.Focused then
    Clipboard.AsText := TShorter.GetForumAnchorLink(Edit4.Text)
  else if Edit1.Focused then
    Clipboard.AsText := TShorter.GetForumAnchorLink(Edit1.Text)
  else if Edit2.Focused then
    Clipboard.AsText := TShorter.GetForumAnchorLink(Edit2.Text)
  else if Edit3.Focused then
    Clipboard.AsText := TShorter.GetForumAnchorLink(Edit3.Text)
end;

procedure TOldMainForm.N8Click(Sender: TObject);
begin
fDeshifr.ShowModal
end;

procedure TOldMainForm.ShowFFForm(const aText: string);
begin
  fFFSender.Memo1.Clear;
  fFFSender.Memo1.Text := aText;
  fFFSender.ShowModal;
end;

procedure TOldMainForm.ShowTwitForm(const aText: string);
begin
  fTwitter.Memo1.Clear;
  fTwitter.Memo1.Text := aText;
  fTwitter.ShowModal;
end;

procedure TOldMainForm.SpeedButton10Click(Sender: TObject);
var
  ClipbStr: string;

begin
//ShowMessage();
//ExtractFilePath(Application.ExeName)+'help/help.chm'
  ClipbStr := '';
  if (CheckBox2.Checked) and (Length(Edit4.Text) > 0) then
  begin
    Copyer.ShortLink := Edit4.Text;
    ClipbStr := Copyer.GetClipboardTest;
  end;

  if (CheckBox3.Checked) and (Length(Edit1.Text) > 0) then
  begin
    Copyer.ShortLink := Edit1.Text;
    ClipbStr := ClipbStr + Copyer.GetClipboardTest;
  end;

  if (CheckBox4.Checked) and (Length(Edit2.Text) > 0) then
  begin
    Copyer.ShortLink := Edit2.Text;
    ClipbStr := ClipbStr + Copyer.GetClipboardTest;
  end;

  if (CheckBox5.Checked) and (Length(Edit3.Text) > 0) then
  begin
    Copyer.ShortLink := Edit3.Text;
    ClipbStr := ClipbStr + Copyer.GetClipboardTest;
  end;

  Clipboard.AsText := ClipbStr;
end;

procedure TOldMainForm.SpeedButton11Click(Sender: TObject);
begin
  ShowFFForm(Edit4.Text);
end;

procedure TOldMainForm.SpeedButton12Click(Sender: TObject);
begin
  ShowFFForm(Edit1.Text);
end;

procedure TOldMainForm.SpeedButton13Click(Sender: TObject);
begin
  ShowFFForm(Edit2.Text);
end;

procedure TOldMainForm.SpeedButton14Click(Sender: TObject);
begin
  ShowFFForm(Edit3.Text);
end;

procedure TOldMainForm.SpeedButton1Click(Sender: TObject);
begin
  Edit1.SetFocus;
  CopyLink
end;

procedure TOldMainForm.SpeedButton2Click(Sender: TObject);
begin
  Edit2.SetFocus;
  CopyLink
end;

procedure TOldMainForm.SpeedButton3Click(Sender: TObject);
begin
  Edit3.SetFocus;
  CopyLink
end;

procedure TOldMainForm.SpeedButton4Click(Sender: TObject);
begin
  ShowTwitForm(Edit1.Text)
end;

procedure TOldMainForm.SpeedButton5Click(Sender: TObject);
begin
  if TShorter.IsLink(ComboBox1.Text) then
  begin
    // жмем ссылки
    if CheckBox2.Checked then
      BitLyCompress;
    if CheckBox3.Checked then
      IsGdCompress;
    if CheckBox4.Checked then
      ZiMaCompress;
    if CheckBox5.Checked then
      ClckCompress;

    if Options.SaveStory then
    begin
      ComboBox1.Items.Insert(0, ComboBox1.Text);
      if ComboBox1.Items.Count > Options.StroryLength then
        ComboBox1.Items.Delete(ComboBox1.Items.Count - 1);
      ComboBox1.Text := ComboBox1.Items[0]
    end;
    ChangeVisibles;
  end
  else
    TLCExceptions.Show(rcLinkError, rcError, ErrorOk);
end;

procedure TOldMainForm.SpeedButton6Click(Sender: TObject);
begin
  ShowTwitForm(Edit2.Text)
end;

procedure TOldMainForm.SpeedButton7Click(Sender: TObject);
begin
  ShowTwitForm(Edit3.Text)
end;

procedure TOldMainForm.SpeedButton8Click(Sender: TObject);
begin
  Edit4.SetFocus;
  CopyLink
end;

procedure TOldMainForm.SpeedButton9Click(Sender: TObject);
begin
  ShowTwitForm(Edit4.Text)
end;

procedure TOldMainForm.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  Img: TPngImage;
begin
  if Panel.Index = 0 then
  begin
    try
      Img := TPngImage.Create;
      Img.LoadFromFile(ResourcePath + imgTwitterRelPath);
      Img.Transparent := true;
      Img.TransparentColor := clWhite;
      Img.Draw(StatusBar1.Canvas, Rect);
    except
      TLCExceptions.Show(rcErrorProg, rcError, ErrorOk);
    end;
  end
  else if Panel.Index = 2 then
  begin
    try
      Img := TPngImage.Create;
      Img.LoadFromFile(ResourcePath + imgFriendFeedRelPath);
      Img.Draw(StatusBar1.Canvas, Rect);
    except
      TLCExceptions.Show(rcErrorProg, rcError, ErrorOk);
    end;
  end
  else if Panel.Index = 1 then
  begin
    if not Twitter.Authorized then
    begin
      StatusBar1.Canvas.FillRect(Rect);
      try
        Img := TPngImage.Create;
        Img.LoadFromFile(ResourcePath + imgErrorRelPath);
        Img.Transparent := true;
        Img.Draw(StatusBar1.Canvas, Rect);
      except
        TLCExceptions.Show(rcErrorProg, rcError, ErrorOk);
      end;
    end
    else
    begin
      StatusBar1.Canvas.FillRect(Rect);
      try
        Img := TPngImage.Create;
        Img.LoadFromFile(ResourcePath + imgOkRelPath);
        Img.Transparent := true;
        Img.Draw(StatusBar1.Canvas, Rect);
      except
        TLCExceptions.Show(rcErrorProg, rcError, ErrorOk);
      end;
    end;
  end
  else if Panel.Index = 3 then
  begin
    if not FriendFeed.Authorized then
    begin
      StatusBar1.Canvas.FillRect(Rect);
      try
        Img := TPngImage.Create;
        Img.LoadFromFile(ResourcePath + imgErrorRelPath);
        Img.Transparent := true;
        Img.Draw(StatusBar1.Canvas, Rect);
      except
        TLCExceptions.Show(rcErrorProg, rcError, ErrorOk);
      end;
    end
    else
    begin
      StatusBar1.Canvas.FillRect(Rect);
      try
        Img := TPngImage.Create;
        Img.LoadFromFile(ResourcePath + imgOkRelPath);
        Img.Transparent := true;
        Img.Draw(StatusBar1.Canvas, Rect);
      except
        TLCExceptions.Show(rcErrorProg, rcError, ErrorOk);
      end;
    end;
  end;
  Img.Free;
end;

procedure TOldMainForm.ZiMaCompress;
var
  shrt: string;
begin
  shrt := unu(ComboBox1.Text);
  if TShorter.IsLink(shrt) then
  begin
    Edit2.Text := shrt;
    Label5.Caption := Format(sRateLabalText, [Length(shrt),
      TShorter.CompressionRate(ComboBox1.Text, shrt)])
  end
  else
  begin
    Edit2.Text := '';
    TLCExceptions.ShowFmt(rcServiceCompressError, rcError, ErrorOk, ['u.nu']);
  end;
  Application.ProcessMessages;
end;

end.
