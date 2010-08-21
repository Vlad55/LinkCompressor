unit common;

interface

uses OAuth_ICS, Classes, SysUtils, Forms, Dialogs,SHDocVw,
  NativeXML, Generics.Collections, OverbyteIcsWndControl, OverbyteIcsWSocket,
  OverbyteIcsHttpProt,OAuthUtils, DateUtils,uLkJSON;

const
  ConsumerKey = 'jYpw98mAWkIHT7JSBn7w';
  ConsumerSecret = 'XlidAyVXdhLv1uQnxmmk0At83NJiAE7PJTssJGPBu4';
  ProgName = 'LinkCompressor';
  CallbackURL = 'http://www.webdelphi.ru';

type
  TTwitter = class(TObject)
  private
    FAuthorized: boolean;
    FSource: string;
    FTwitterClient: string;
    FTwitterClientVersion: string;
    FTwitterClientURL: string;
    FUserName: string;
    FPassword: string;
    FConsumer: TOAuthConsumer;
    FToken: TOAuthToken;
    FRequest: TOAuthRequest;
    FHMAC: TOAuthSignatureMethod_HMAC_SHA1;
    FKey: string;
    FSecret: string;
    FOAuth_token: string;
    FOAuth_token_secret: string;
    FAuthHeader: string;
    procedure SetSource(const Value: string);
    procedure SetTwitterClient(const Value: string);
    procedure SetTwitterClientVersion(const Value: string);
    procedure SetTwitterCLientURL(const Value: string);
    function GetRequestsCount: integer;
    function GetResetLimitTime: TDateTime;
    procedure AddCustomHeader(Sender: TObject; const Method: String;
      Headers: TStrings);
    procedure CheckResponce(const Responce:string);
  public
    constructor Create;
    procedure SetAccountInfo;
    procedure GetRateLimits;
    procedure GetFollowersIds;
    function GetCurrentHashTags:TStringList;
    function POSTCommand(URL: string; Params: TStringList): string;
    function GETCommand(URL: string): string;
    function Update(const Text: string): string;
    property Source: string read FSource write SetSource;
    property TwitterClient: string read FTwitterClient write SetTwitterClient;
    property TwitterClientVersion: string read FTwitterClientVersion write
      SetTwitterClientVersion;
    property TwitterClientURL: string read FTwitterClientURL write
      SetTwitterCLientURL;
    property Consumer: TOAuthConsumer read FConsumer write FConsumer;
    property Token: TOAuthToken read FToken write FToken;
    property Request: TOAuthRequest read FRequest write FRequest;
    property HMAC: TOAuthSignatureMethod_HMAC_SHA1 read FHMAC write FHMAC;
    property Key: string read FKey write FKey;
    property Secret: string read FSecret write FSecret;
    property OAuth_token: string read FOAuth_token write FOAuth_token;
    property OAuth_token_secret
      : string read FOAuth_token_secret write FOAuth_token_secret;
    property Authorized: boolean read FAuthorized write FAuthorized;
  end;


function Authorization(const PinCode: string): string;
procedure ShowAuthorizationForm(const LoginURL: string; var WB: TWebBrowser;
  Form: TForm);
procedure StartAuthorization(var LoginURL: string);
procedure GetTweetAcc;


var Twitter: TTwitter;

implementation

uses uShorter;

procedure GetTweetAcc;
begin
  Twitter.Consumer := TOAuthConsumer.Create(Twitter.Key, Twitter.Secret);
  Twitter.HMAC := TOAuthSignatureMethod_HMAC_SHA1.Create;
end;

function Authorization(const PinCode: string): string;
var
  URL, Tok: string;
  endpos: integer;
  Response: TStringList;
  Stream: TStringStream;
  HTTP: THTTPCli;
begin
  try
    URL := 'http://twitter.com/oauth/access_token';
    Twitter.Consumer := nil;
    Twitter.Consumer := TOAuthConsumer.Create
      (Twitter.Key, Twitter.Secret, CallbackURL);
    Twitter.Request.HTTPURL := URL;
    Twitter.Request := Twitter.Request.FromConsumerAndToken
      (Twitter.Consumer, Twitter.Token, URL);
    Twitter.Request.Sign_Request(Twitter.HMAC, Twitter.Consumer,
      Twitter.Token);
    URL := URL + '?' + Twitter.Request.GetString + '&oauth_verifier=' +
      PinCode;
    Response := TStringList.Create;
    Stream := TStringStream.Create;
    HTTP := THTTPCli.Create(nil);
    HTTP.RcvdStream := Stream;
    HTTP.URL := URL;
    HTTP.Get;
    Response.Text := Stream.DataString;
    Tok := Trim(Response.Text);
    endpos := AnsiPos('&oauth_token_secret=', Tok);
    Twitter.OAuth_token := '';
    Twitter.OAuth_token := Copy(Tok, 13, endpos - 13);
    Tok := Copy(Tok, endpos, Length(Tok));
    endpos := AnsiPos('&user', Tok);
    Twitter.OAuth_token_secret := '';
    Twitter.OAuth_token_secret := Copy(Tok, 21, endpos - 21);
    Result := Twitter.OAuth_token_secret;
  finally
    FreeAndNil(HTTP);
    FreeAndNil(Stream);
    FreeAndNil(Response);
    sleep(1000);
  end;
end;

procedure ShowAuthorizationForm(const LoginURL: string; var WB: TWebBrowser;
  Form: TForm);
begin
  WB.Navigate(LoginURL);
  Form.ShowModal;
end;

procedure StartAuthorization(var LoginURL: string);
var
  URL, Tok: string;
  endpos: integer;
  Response: TStringList;
  Stream: TStringStream;
  HTTP: THTTPCli;
begin
  try
    Twitter.Consumer := TOAuthConsumer.Create
      (Twitter.Key, Twitter.Secret);
    Twitter.HMAC := TOAuthSignatureMethod_HMAC_SHA1.Create;
    URL := 'http://twitter.com/oauth/request_token';
    Twitter.Request := TOAuthRequest.Create(URL);
    Twitter.Request := Twitter.Request.FromConsumerAndToken
      (Twitter.Consumer, nil, URL);
    Twitter.Request.Sign_Request(Twitter.HMAC, Twitter.Consumer,
      nil);
    URL := URL + '?' + Twitter.Request.GetString;
    Stream := TStringStream.Create;
    HTTP := THTTPCli.Create(nil);
    HTTP.RcvdStream := Stream;
    HTTP.URL := URL;
    HTTP.Get;
    Response := TStringList.Create;
    Response.Text := Stream.DataString;
    Tok := Trim(Response.Text);

    endpos := AnsiPos('&oauth_token_secret=', Tok);
    Twitter.OAuth_token := '';
    Twitter.OAuth_token_secret := '';
    Twitter.OAuth_token := Copy(Tok, 13, endpos - 13);
    Tok := Copy(Tok, endpos, Length(Tok));
    Twitter.OAuth_token_secret:= Copy(Tok, 21, Length(Tok));
    Twitter.Token := TOAuthToken.Create(Twitter.OAuth_token,
      Twitter.OAuth_token_secret);
    URL := 'http://twitter.com/oauth/authorize';
    LoginURL := URL + '?' + 'oauth_token=' + Twitter.OAuth_token + '&' +
      'oauth_token_secret=' + Twitter.OAuth_token_secret +
      '&oauth_callback=' + TOAuthUtil.urlEncodeRFC3986(CallbackURL);
//    Response.Clear;
//    Response.Add(LoginURL);
//    Response.SaveToFile('LoginURL.txt');
  finally
    FreeAndNil(Response);
    FreeAndNil(HTTP);
    FreeAndNil(Stream);
  end;
end;


{ TTwiCommander }

procedure TTwitter.AddCustomHeader(Sender: TObject; const Method: String;
  Headers: TStrings);
begin
  Headers.Add(Trim(FAuthHeader));
end;

procedure TTwitter.CheckResponce(const Responce: string);
var XML: TNativeXml;
begin
  try
    XML:=TNativeXml.Create;
    XML.ReadFromString(Responce);
    if XML.Root.Name='hash' then
      MessageDlg('Во время выполнения запроса произошла ошибка "'+XML.Root.ReadString('error')+'"',mtError,[mbOK],0);
  finally
    FreeAndNil(XMl);
  end;
end;

constructor TTwitter.Create;
begin
  inherited Create;
  FSource := ProgName;
  FKey:=ConsumerKey;
  FSecret:=ConsumerSecret;
end;

function TTwitter.GETCommand(URL: string): string;
var
  pos: integer;
  HTTP: THTTPCli;
  Stream: TStringStream;
begin
  try
    FConsumer := nil;
    FConsumer := TOAuthConsumer.Create(FKey, FSecret, CallbackURL);
    FRequest := TOAuthRequest.Create(URL);
    FRequest := Request.FromConsumerAndToken(FConsumer, nil, URL);
    FRequest.HTTPURL := URL;
    FToken := TOAuthToken.Create(FOAuth_token, FOAuth_token_secret);
    FRequest := Request.FromConsumerAndToken(FConsumer, FToken, URL);
    FRequest.Sign_Request(HMAC, Consumer, Token);
    pos := AnsiPos('?', URL);
    if pos = 0 then
      URL := URL + '?' + Request.GetString
    else
      URL := URL + '&' + Request.GetString;
    Stream := TStringStream.Create;
    HTTP := THTTPCli.Create(nil);
    HTTP.URL := URL;
    HTTP.RcvdStream := Stream;
    HTTP.Get;
    try
     // CheckResponce(Stream.DataString);
    except
    end;
    Result := Stream.DataString;

  finally
    FreeAndNil(HTTP);
    FreeAndNil(Stream);
    Sleep(1000);
  end;
end;

function TTwitter.GetCurrentHashTags: TStringList;
var Responce: string;
    js: TlkJSONobject;
    jb: TlkJSONobject;
    jl: TlkJSONlist;
    i:integer;
begin
try
  Responce:=GETCommand('http://api.twitter.com/1/trends/current.json');
  js:=TlkJSON.ParseText(Responce) as TlkJSONobject;
  Result:=TStringList.Create;
  jb:=js.Field['trends']as TlkJSONobject;
  jl:=jb.FieldByIndex[0] as TlkJSONlist;
  for i:=0 to jl.Count - 1 do
    Result.Add((jl.Child[i] as TlkJSONobject).getString('query'));
finally
  jl.Free;
end;
end;

procedure TTwitter.GetFollowersIds;
begin

end;

procedure TTwitter.GetRateLimits;
begin

end;

function TTwitter.GetRequestsCount: integer;
begin

end;

function TTwitter.GetResetLimitTime: TDateTime;
begin

end;

function TTwitter.POSTCommand(URL: string; Params: TStringList): string;
var
  pos: integer;
  ah, Key: string;
  aa: TStringList;
  HTTP: THTTPCli;
  Send, Rcv: TStringStream;
begin
  try
    FRequest := TOAuthRequest.Create(URL);
    FToken := TOAuthToken.Create(FOAuth_token, FOAuth_token_secret);
    FRequest := Request.FromConsumerAndToken(FConsumer, FToken, URL);
    FRequest.HTTPURL := URL;
    ah := FRequest.genAuthHeader(Consumer, Token, Params, URL);
    aa := TStringList.Create;
    aa.Clear;
    aa.Add(FRequest.encodeParams(Params, '&', false, true));
    HTTP := THTTPCli.Create(nil);
    HTTP.Options := [];
    Send := TStringStream.Create;
    Rcv := TStringStream.Create;
    Send.WriteString(Trim(aa.Text));
    Send.Position := 0;
    HTTP.Accept := 'text/html';
    HTTP.SendStream := Send;
    HTTP.RcvdStream := Rcv;
    HTTP.RequestVer := '1.1';
    HTTP.OnBeforeHeaderSend := AddCustomHeader;
    FAuthHeader := 'Authorization: ' + ah;
    HTTP.URL := URL;
    HTTP.Post;
    CheckResponce(Rcv.DataString);
//    ShowMessage(Rcv.DataString);
    Result:=Rcv.DataString;
  finally
    FreeAndNil(aa);
    FreeAndNil(Send);
    FreeAndNil(Rcv);
    FreeAndNil(HTTP);
    Sleep(1000);
  end;
end;

procedure TTwitter.SetAccountInfo;
begin

end;

procedure TTwitter.SetSource(const Value: string);
begin

end;

procedure TTwitter.SetTwitterClient(const Value: string);
begin

end;

procedure TTwitter.SetTwitterCLientURL(const Value: string);
begin

end;

procedure TTwitter.SetTwitterClientVersion(const Value: string);
begin

end;

function TTwitter.Update(const Text: string): string;
var
  TextPost, URL: string;
  Data: TStringList;
begin
  URL := 'http://api.twitter.com/1/statuses/update.xml';
  Data := TStringList.Create;
  TextPost := Format('status=%s', [Text]);
  Data.Add(TextPost);
  Result := POSTCommand(URL, Data);
  Data.Free;
end;

end.
