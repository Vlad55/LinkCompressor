unit uShorter;

interface

uses httpsend, sysutils, ShellAPI, synacode, IniFiles, dialogs,
  classes, Windows, Forms, Common, IOUtils,
  synautil, SHFolder, ComObj, BitlyAPI, BitlyParser;

const
  sAppName = 'LinkCompressor';
  sUpdFile = 'upd.ini';
  sUpdFileLink = CallbackURL+'/UpdateShrt.txt';
  sHistoryFile = 'history.lc2';
  sCopOptnsFile = 'copyer.ini';
  sOptnsFile = 'options.ini';
  sRateLabalText = '%d/%d%%';
  sForum = '[url]%s[/url]';
  sForumAnchorEx = '[url=%s]%s[/url]';
  sHTMLLinkEx = '<a href="%s">%s</a>';
  sSectionBitly ='bitly';
  sSectionTwitter ='Twitter';
  sSectionMain ='Main';
  sSectionInter ='Interface';
  sSectionCopy = 'copyer';

  shttp='http://';
  shttps='https://';
  sftp='ftp://';

  sunuLink  =shttp+'u.nu/unu-api-simple?url=%s';
  sisgdLink =shttp+'is.gd/api.php?longurl=%s';
  sclckLink =shttp+'clck.ru/--?url=%s';
  imgErrorRelPath = 'icons/err.png';
  imgOkRelPath = 'icons/ok.png';
  imgTwitterRelPath = 'icons/twt.png';
  imgFriendFeedRelPath = 'icons/ff.png';

  WordDelimitersEx: set of AnsiChar = ['<', '>', '!', ',', ';', ' ', '(', ')',
    '*', '''', '~', '`', '"'];

type
  TOptions = class
  private
    FBitlyAPI: string;
    FFormTop: integer;
    FDoTwitt: boolean;
    FFormLeft: integer;
    FAutoCheck: boolean;
    FCopyOperation: string;
    FTwitterToken: string;
    FSaveStory: boolean;
    FDoBitly: boolean;
    FFormWidth: integer;
    FSaveForm: boolean;
    FDoIntelligentSearch: boolean;
    FBitlyLogin: string;
    FStroryLength: integer;
    FTwitterTokenSecret: string;
    FFFLogin: string;
    FFFKey: string;
    procedure SetAutoCheck(const Value: boolean);
    procedure SetBitlyAPI(const Value: string);
    procedure SetBitlyLogin(const Value: string);
    procedure SetCopyOperation(const Value: string);
    procedure SetDoBitly(const Value: boolean);
    procedure SetDoIntelligentSearch(const Value: boolean);
    procedure SetDoTwitt(const Value: boolean);
    procedure SetFormLeft(const Value: integer);
    procedure SetFormTop(const Value: integer);
    procedure SetFormWidth(const Value: integer);
    procedure SetSaveForm(const Value: boolean);
    procedure SetSaveStory(const Value: boolean);
    procedure SetStroryLength(const Value: integer);
    procedure SetTwitterToken(const Value: string);
    procedure SetTwitterTokenSecret(const Value: string);
    procedure SetFFKey(const Value: string);
    procedure SetFFLogin(const Value: string);
    public
    constructor Create;
    procedure Load;
    procedure Save;
    property TwitterToken: string read FTwitterToken write SetTwitterToken;
    property TwitterTokenSecret: string read FTwitterTokenSecret write SetTwitterTokenSecret;
    property BitlyLogin: string read FBitlyLogin write SetBitlyLogin;
    property BitlyAPI: string read FBitlyAPI write SetBitlyAPI;
    property AutoCheck: boolean read FAutoCheck write SetAutoCheck;
    property DoTwitt: boolean read FDoTwitt write SetDoTwitt;
    property DoBitly: boolean read FDoBitly write SetDoBitly;
    property DoIntelligentSearch: boolean read FDoIntelligentSearch write SetDoIntelligentSearch;
    property SaveStory: boolean read FSaveStory write SetSaveStory;
    property StroryLength: integer read FStroryLength write SetStroryLength;
    property SaveForm: boolean read FSaveForm write SetSaveForm;
    property FormWidth: integer read FFormWidth write SetFormWidth;
    property FormTop:integer read FFormTop write SetFormTop;
    property FormLeft:integer read FFormLeft write SetFormLeft;
    property CopyOperation:string read FCopyOperation write SetCopyOperation;
    property FFLogin: string read FFFLogin write SetFFLogin;
    property FFKey: string read FFFKey write SetFFKey;
  end;

type
  TGroupCopyer = class
  private
    FHTMLText: string;
    FForumText: string;
    FHTML: boolean;
    FForum: boolean;
    FForumAnchor: boolean;
    FShortLink: string;
    FShort: boolean;
    FCodes: boolean;

    procedure SetForum(const Value: boolean);
    procedure SetForumAnchor(const Value: boolean);
    procedure SetForumText(const Value: string);
    procedure SetHTML(const Value: boolean);
    procedure SetHTMLText(const Value: string);
    procedure SetShortLink(const Value: string);
    procedure SetShort(const Value: boolean);
    procedure SetCodes(const Value: boolean);
  public
    constructor Create;
    destructor Destroy;
    function GetClipboardTest: string;
    property ShortLink: string read FShortLink write SetShortLink;
    property ForumAnchor: boolean read FForumAnchor write SetForumAnchor;
    property Forum: boolean read FForum write SetForum;
    property HTML: boolean read FHTML write SetHTML;
    property Short: boolean read FShort write SetShort;
    property Codes: boolean read FCodes write SetCodes;
    property ForumText: string read FForumText write SetForumText;
    property HTMLText: string read FHTMLText write SetHTMLText;
  end;

type
  TShorter = class
  public
    class function IsLink(const aText: string): boolean;
    class function CompressionRate(LongURL, ShortURL: string): integer;
    class function GetHTMLLink(const ShortLink: string): string; overload;
    class function GetHTMLLink(const ShortLink, Anchor: string): string;
      overload;
    class function GetForumAnchorLink(const ShortLink: string): string;
      overload;
    class function GetForumAnchorLink(const ShortLink, Anchor: string): string;
      overload;
    class function GetForumLink(const ShortLink: string): string;
  end;

function unu(const URL: string): string;inline;
function isgd(const URL: string): string;inline;
function bitly(const URL: string): string;inline;
function clck(const URL: string): string;inline;

function GetFileVersion(const FileName: string): string;
function GetUpdFile: boolean;inline;
function IsNewVersion(CurrentVersion: string): boolean;inline;
function IsLink(var aText: string): boolean;inline;
procedure LoadHistory(List: TStrings);inline;
procedure WriteHistory(const List: TStrings);inline;
procedure OpenURL(const URL:string);inline;
procedure GetResourcePath;inline;

var
  Options: TOptions;
  Copyer: TGroupCopyer;
  ResourcePath: string;

implementation

uses  LCExceptions;

procedure GetResourcePath;
var
  buf: array [1 .. MAX_PATH] of WideChar;
  FilePath: UnicodeString;
begin
FillChar(buf, high(buf), 0);
if Succeeded(SHGetFolderPath(Application.Handle, CSIDL_APPDATA, 0, 0, @buf)) then
  begin
    FilePath := IncludeTrailingPathDelimiter(WideCharToString(@buf))
      + Application.Name;
    if not TDirectory.Exists(FilePath) then
      TDirectory.CreateDirectory(FilePath);
    ResourcePath:=IncludeTrailingPathDelimiter(FilePath)
  end
  else
    ResourcePath:=ExtractFilePath(Application.ExeName)
end;


procedure OpenURL(const URL:string);
begin
  ShellExecute(Application.Handle,
   PChar('open'),
   PChar(URL),
   PChar(0),
   nil,
   SW_NORMAL) ;
end;

function bitly(const URL: string): string;
var
  Bily: TBitly;
begin
  Result := '';
  try
    Bily := TBitly.Create(Options.BitlyLogin, Options.BitlyAPI);
    Result := TBitlyParser.ParseShorten(Bily.Shorten(URL, tdBit)).URL;
  except
    TLCExceptions.ShowFmt(rcServiceCompressError,rcError,ErrorOk,['bit.ly']);
  end;
end;

procedure WriteHistory(const List: TStrings);
begin
try
  List.SaveToFile(ResourcePath + sHistoryFile);
except
  TLCExceptions.Show(rcErrorHistory,rcError,ErrorOk);
end;
end;

procedure LoadHistory(List: TStrings);
begin
try
  if TFile.Exists(ResourcePath + sHistoryFile) then
    List.LoadFromFile(ResourcePath + sHistoryFile);
except
  TLCExceptions.Show(rcErrorHistoryLoad,rcError,ERROROk);
end;
end;

function IsLink(var aText: string): boolean;
var
  startIndex: integer;
  ch: char;
  lnk: string;
begin
  if Options.DoIntelligentSearch then
  begin
    Result := (pos(shttp, aText) > 0) or (pos(shttps, aText) > 1) or
      (pos(sftp, aText) > 0);
    if Result then
    begin
      if pos(shttp, aText) > 0 then
      begin
        startIndex := pos(shttp, aText);
        aText := copy(aText, startIndex, length(aText) - startIndex + 1);
      end
      else if pos(shttp, aText) > 0 then
      begin
        startIndex := pos(shttps, aText);
        aText := copy(aText, startIndex, length(aText) - startIndex + 1);
      end
      else if pos(shttp, aText) > 0 then
      begin
        startIndex := pos(sftp, aText);
        aText := copy(aText, startIndex, length(aText) - startIndex + 1);
      end;
      lnk := '';
      for ch in aText do
      begin
        if not(ch in WordDelimitersEx) then
          lnk := lnk + ch
        else
          break
      end;
      aText := lnk;
    end;
  end
  else
  begin
    Result := (pos(shttp, aText) = 1) or (pos(shttps, aText) = 1) or
      (pos(sftp, aText) = 1);
    if not Result then
      aText := '';
  end;
end;

function IsNewVersion(CurrentVersion: string): boolean;
var
  F: TIniFile;
  Major_cur,Minor_cur,Release_cur,Build_cur: integer;
  Major_upd,Minor_upd,Release_upd,Build_upd: integer;
  c,u:string;
begin
  Result:=false;
  if GetUpdFile then
  begin
    F := TIniFile.Create(ResourcePath + sUpdFile);
    c:=CurrentVersion;
    u:=F.ReadString('version', 'num', '0');

    Major_cur:=StrToInt(copy(c,1,pos('.',c)-1));
    Delete(c,1,length(IntToStr(Major_cur))+1);
    Minor_cur:=StrToInt(copy(c,1,pos('.',c)-1));
    Delete(c,1,length(IntToStr(Minor_cur))+1);
    Release_cur:=StrToInt(copy(c,1,pos('.',c)-1));
    Delete(c,1,length(IntToStr(Release_cur))+1);
    Build_cur:=StrToInt(copy(c,1,length(c)));


    Major_upd:=StrToInt(copy(u,1,pos('.',u)-1));
    Delete(u,1,length(IntToStr(Major_upd))+1);
    Minor_upd:=StrToInt(copy(u,1,pos('.',u)-1));
    Delete(u,1,length(IntToStr(Minor_upd))+1);
    Release_upd:=StrToInt(copy(u,1,pos('.',u)-1));
    Delete(u,1,length(IntToStr(Release_upd))+1);
    Build_upd:=StrToInt(copy(u,1,length(u)));

    if Major_cur<Major_upd then
      Result:=true
    else
      if Minor_cur<Minor_upd then
        Result:=true
      else
        if Release_cur<Release_upd then
          Result:=true
        else
          if Build_cur<Build_upd then
            Result:=(Major_cur=Major_upd)and(Minor_cur=Minor_upd)and(Release_cur=Release_upd); {!!!!!!!!!!!!!!!!!!!!!!!!!!!!}
    if Result then
    begin
      if MessageBox(0,
        PChar(rcNewVersionFound),
        PChar(rcNewVersion), MB_YESNO + MB_ICONQUESTION) = idYes then
        OpenURL(F.ReadString('description', 'url', CallbackURL));
    end;
    F.Free;
  end;
end;

function GetUpdFile: boolean;
var
  str: TStringList;
begin
  try
    str := TStringList.Create;
    with THTTPSend.Create do
    begin
      HttpGetText(sUpdFileLink, str);
      str.SaveToFile(ResourcePath + sUpdFile);
      Result := true;
      FreeAndNil(str);
    end;
  except
    Result := false;
  end;
end;

function GetFileVersion(const FileName: string): string;
type
  PDWORD = ^DWORD;
  PLangAndCodePage = ^TLangAndCodePage;

  TLangAndCodePage = packed record
    wLanguage: WORD;
    wCodePage: WORD;
  end;

  PLangAndCodePageArray = ^TLangAndCodePageArray;
  TLangAndCodePageArray = array [0 .. 0] of TLangAndCodePage;
var
  loc_InfoBufSize: DWORD;
  loc_InfoBuf: PChar;
  loc_VerBufSize: DWORD;
  loc_VerBuf: PChar;
  cbTranslate: DWORD;
  lpTranslate: PDWORD;
  i: DWORD;
begin
  Result := '';
  if (length(FileName) = 0) or (not FileExists(FileName)) then
    Exit;
  loc_InfoBufSize := GetFileVersionInfoSize(PChar(FileName), loc_InfoBufSize);
  if loc_InfoBufSize > 0 then
  begin
    loc_VerBuf := nil;
    loc_InfoBuf := AllocMem(loc_InfoBufSize);
    try
      if not GetFileVersionInfo(PChar(FileName), 0, loc_InfoBufSize,
        loc_InfoBuf) then
        Exit;
      if not VerQueryValue(loc_InfoBuf, '\\VarFileInfo\\Translation', Pointer
          (lpTranslate), DWORD(cbTranslate)) then
        Exit;
      for i := 0 to (cbTranslate div SizeOf(TLangAndCodePage)) - 1 do
      begin
        if VerQueryValue(loc_InfoBuf, PChar(Format
              ('StringFileInfo\0%x0%x\FileVersion', [PLangAndCodePageArray
                (lpTranslate)[i].wLanguage, PLangAndCodePageArray(lpTranslate)
                [i].wCodePage])), Pointer(loc_VerBuf), DWORD(loc_VerBufSize))
          then
        begin
          Result := loc_VerBuf;
          break;
        end;
      end;
    finally
      FreeMem(loc_InfoBuf, loc_InfoBufSize);
    end;
  end;
end;

function isgd(const URL: string): string;
var
  StrStream: TStringStream;
begin
  StrStream := TStringStream.Create('');
  with THTTPSend.Create do
  begin
    HTTPMethod('GET', Format(sisgdLink,[EncodeURLElement(URL)]));
    StrStream.LoadFromStream(Document);
    if ResultCode = 200 then
      Result := Trim(StrStream.DataString)
    else
      Result := '';
  end;
  FreeAndNil(StrStream);
end;

function clck(const URL: string): string;
var
  StrStream: TStringStream;
begin
  StrStream := TStringStream.Create('');
  with THTTPSend.Create do
  begin
    HTTPMethod('GET',  Format(sclckLink,[EncodeURLElement(URL)]));
    StrStream.LoadFromStream(Document);
    if ResultCode = 200 then
      Result := Trim(StrStream.DataString)
    else
      Result := '';
  end;
  FreeAndNil(StrStream);
end;


function unu(const URL: string): string;
var
  StrStream: TStringStream;
begin
  StrStream := TStringStream.Create('');
  with THTTPSend.Create do
  begin
    HTTPMethod('GET', Format(sunuLink,[EncodeURLElement(URL)]));
    StrStream.LoadFromStream(Document);
    if (pos('<', StrStream.DataString) <= 0) then
      Result := Trim(StrStream.DataString)
    else
      Result := '';
  end;
  FreeAndNil(StrStream);
end;

{ TShorter }

class function TShorter.CompressionRate(LongURL, ShortURL: string): integer;
begin
  Result := Trunc(100 - (length(ShortURL) / length(LongURL)) * 100)
end;

class function TShorter.GetForumAnchorLink(const ShortLink: string): string;
begin
  Result := Format(rcForumAnchor, [ShortLink]);
end;

class function TShorter.GetForumAnchorLink(const ShortLink, Anchor: string)
  : string;
begin
  Result := Format(rcForumAnchor, [ShortLink, Anchor]);
end;

class function TShorter.GetForumLink(const ShortLink: string): string;
begin
  Result := Format(sForum, [ShortLink]);
end;

class function TShorter.GetHTMLLink(const ShortLink, Anchor: string): string;
begin
  Result := Format(sHTMLLinkEx, [ShortLink, Anchor]);
end;

class function TShorter.GetHTMLLink(const ShortLink: string): string;
begin
  Result := Format(rcHTMLLink, [ShortLink]);
end;

class function TShorter.IsLink(const aText: string): boolean;
begin
  Result := (pos(shttp, aText) = 1) or (pos(shttps, aText) = 1) or
    (pos(sftp, aText) = 1);
end;

{ TGroupCopyer }

constructor TGroupCopyer.Create;
var F: TIniFile;
begin
  inherited Create;
try
    F := TIniFile.Create(ResourcePath + sCopOptnsFile);
    FHTMLText := F.ReadString(sSectionCopy, 'HTMLText', rcAnchor);
    FForumText := F.ReadString(sSectionCopy, 'ForumText', rcAnchor);
    FHTML := F.ReadBool(sSectionCopy, 'html', true);
    FForum := F.ReadBool(sSectionCopy, 'forum', true);
    FShort := F.ReadBool(sSectionCopy, 'short', true);
    FForumAnchor := F.ReadBool(sSectionCopy, 'forumAnchor', true);
    FCodes := F.ReadBool(sSectionCopy, 'codes', true);
    F.Free;
except
  TLCExceptions.Show(rcErrorOpenGroup,rcError,ErrorOk);
end;
end;

destructor TGroupCopyer.Destroy;
begin
  inherited Destroy
end;

function TGroupCopyer.GetClipboardTest: string;
begin
Result:='';
  if Short then
    Result := ShortLink + #13#10;
  if Codes then
  begin
    if ForumAnchor then
      Result := Result + TShorter.GetForumAnchorLink(ShortLink, ForumText)
        + #13#10;
    if Forum then
      Result := Result + TShorter.GetForumLink(ShortLink) + #13#10;
    if HTML then
      Result := Result + TShorter.GetHTMLLink(ShortLink, ForumText) + #13#10;
  end;
end;

procedure TGroupCopyer.SetCodes(const Value: boolean);
begin
  FCodes := Value;
end;

procedure TGroupCopyer.SetForum(const Value: boolean);
begin
  FForum := Value;
end;

procedure TGroupCopyer.SetForumAnchor(const Value: boolean);
begin
  FForumAnchor := Value;
end;

procedure TGroupCopyer.SetForumText(const Value: string);
begin
  FForumText := Value;
end;

procedure TGroupCopyer.SetHTML(const Value: boolean);
begin
  FHTML := Value;
end;

procedure TGroupCopyer.SetHTMLText(const Value: string);
begin
  FHTMLText := Value;
end;

procedure TGroupCopyer.SetShort(const Value: boolean);
begin
  FShort := Value;
end;

procedure TGroupCopyer.SetShortLink(const Value: string);
begin
  FShortLink := Value;
end;

{ TOptions }

constructor TOptions.Create;
begin
  inherited Create;
  Load;
end;

procedure TOptions.Load;
var
  F: TIniFile;
begin
try
  F := TIniFile.Create(ResourcePath + sOptnsFile);
  BitlyLogin := F.ReadString(sSectionBitly, 'Login', '');
  BitlyAPI := F.ReadString(sSectionBitly, 'api', '');
  AutoCheck := F.ReadBool('Upgrade', 'AutoCheck', true);
  TwitterToken := F.ReadString(sSectionTwitter, 'Token', '');
  TwitterTokenSecret := F.ReadString(sSectionTwitter, 'Token_secret', '');
  DoIntelligentSearch := F.ReadBool(sSectionMain, 'DoIntSearch', true);
  SaveStory := F.ReadBool(sSectionMain, 'SaveStory', true);
  StroryLength := F.ReadInteger(sSectionMain, 'StroryLength', 20);
  SaveForm:=F.ReadBool(sSectionInter,'SaveForm',false);
  FormWidth:=F.ReadInteger(sSectionInter,'FormWidth',0);
  FormTop:=F.ReadInteger(sSectionInter,'FormTop',0);
  FormLeft:=F.ReadInteger(sSectionInter,'FormLeft',0);
  FFLogin:=F.ReadString(sSectionMain, 'FFLogin','');
  FFKey:=F.ReadString(sSectionMain, 'FFKey','');
  CopyOperation:=F.ReadString(sSectionInter,'Copy','Link');
  Twitter.Authorized := (length(TwitterToken) > 0) and
    (length(TwitterTokenSecret) > 0);
  if Twitter.Authorized then
  begin
    Twitter.OAuth_token := TwitterToken;
    Twitter.OAuth_token_secret := TwitterTokenSecret;
  end;
finally
  F.Free;
end;
  DoTwitt := Twitter.Authorized;
  DoBitly := (length(BitlyLogin) > 0) and (length(BitlyAPI) > 0);
end;

procedure TOptions.Save;
var
  F: TIniFile;
begin
try
  F:=TIniFile.Create(ResourcePath+sOptnsFile);
  if Options.SaveForm then
    begin
      F.WriteBool(sSectionInter,'SaveForm',Options.SaveForm);
      F.WriteInteger(sSectionInter,'FormWidth',Options.FormWidth);
      F.WriteInteger(sSectionInter,'FormTop',Options.FormTop);
      F.WriteInteger(sSectionInter,'FormLeft',Options.FormLeft);
      F.WriteBool('Upgrade', 'AutoCheck', FAutoCheck);
      F.WriteBool(sSectionMain, 'DoIntSearch', DoIntelligentSearch);
      F.WriteBool(sSectionMain, 'SaveStory', SaveStory);
      F.WriteInteger(sSectionMain, 'StroryLength', StroryLength);
      F.WriteString(sSectionMain, 'Login', BitlyLogin);
      F.WriteString(sSectionMain, 'api', BitlyAPI);

      F.WriteString(sSectionMain, 'FFLogin', FFLogin);
      F.WriteString(sSectionMain, 'FFKey',   FFKey);

      F.WriteBool(sSectionInter, 'SaveForm', SaveForm);
      F.WriteString(sSectionInter, 'Copy', CopyOperation);
      F.WriteInteger(sSectionInter,'FormWidth',FormWidth);
      F.WriteInteger(sSectionInter,'FormTop',FormTop);
      F.WriteInteger(sSectionInter,'FormLeft',FormLeft);

    end;
finally
  F.Free;
end;
end;

procedure TOptions.SetAutoCheck(const Value: boolean);
begin
  FAutoCheck := Value;
end;

procedure TOptions.SetBitlyAPI(const Value: string);
begin
  FBitlyAPI := Value;
end;

procedure TOptions.SetBitlyLogin(const Value: string);
begin
  FBitlyLogin := Value;
end;

procedure TOptions.SetCopyOperation(const Value: string);
begin
  FCopyOperation := Value;
end;

procedure TOptions.SetDoBitly(const Value: boolean);
begin
  FDoBitly := Value;
end;

procedure TOptions.SetDoIntelligentSearch(const Value: boolean);
begin
  FDoIntelligentSearch := Value;
end;

procedure TOptions.SetDoTwitt(const Value: boolean);
begin
  FDoTwitt := Value;
end;

procedure TOptions.SetFFKey(const Value: string);
begin
  FFFKey := Value;
end;

procedure TOptions.SetFFLogin(const Value: string);
begin
  FFFLogin := Value;
end;

procedure TOptions.SetFormLeft(const Value: integer);
begin
  FFormLeft := Value;
end;

procedure TOptions.SetFormTop(const Value: integer);
begin
  FFormTop := Value;
end;

procedure TOptions.SetFormWidth(const Value: integer);
begin
  FFormWidth := Value;
end;

procedure TOptions.SetSaveForm(const Value: boolean);
begin
  FSaveForm := Value;
end;

procedure TOptions.SetSaveStory(const Value: boolean);
begin
  FSaveStory := Value;
end;

procedure TOptions.SetStroryLength(const Value: integer);
begin
  FStroryLength := Value;
end;

procedure TOptions.SetTwitterToken(const Value: string);
begin
  FTwitterToken := Value;
end;

procedure TOptions.SetTwitterTokenSecret(const Value: string);
begin
  FTwitterTokenSecret := Value;
end;

end.
