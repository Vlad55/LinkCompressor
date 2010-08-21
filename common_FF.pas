unit common_FF;

interface

uses Classes, SysUtils, Forms, Dialogs,SHDocVw, NativeXML,uLkJSON,
httpsend,synacode,TypInfo;

const
  ff_ConsumerKey = '07c551b86f1944c89123bac5c2544c94';
  ff_ConsumerSecret = 'de8ff7da283649a294f252b9ae3569591f82110bfd584c94822e4c10ddea8952';
  ProgName = 'LinkCompressor';
  CallbackURL = 'http://www.webdelphi.ru';
  FFURL = 'http://%s:%s@friendfeed-api.com/v%d/%s';
  ffAPIVer=2;
  GroupName='linkcompressor';
  ffRemoteKeyURL='http://friendfeed.com/remotekey';
  ffGroupURL='http://friendfeed.com/linkcompressor';

  type
    TffOperations = (ff_subscribe,ff_entry);

  type
    TFriendFeed = class
  private
    FAuthorized: boolean;
    FRemoteKey: string;
    FLogin: string;
    FAppID: string;
    FAPIVersion: integer;
    procedure SetAuthorized(const Value: boolean);
    procedure SetLogin(const Value: string);
    procedure SetRemoteKey(const Value: string);
    procedure SetAppID(const Value: string);
    procedure SetAPIVersion(const Value: integer);
    function POSTCommand(const Operation:TffOperations;Params:TStrings):string;
  published
    public
      constructor Create();
      function Subscribe(const ListID: string):boolean;
      function Entry(const aMsg:string; aTo: string):boolean;
      property APIVersion:integer read FAPIVersion write SetAPIVersion;
      property AppID: string read FAppID write SetAppID;
      property Authorized: boolean read FAuthorized write SetAuthorized;
      property Login: string read FLogin write SetLogin;
      property RemoteKey : string read FRemoteKey write SetRemoteKey;
  end;

var FriendFeed: TFriendFeed;

implementation


{ TFriendFeed }

constructor TFriendFeed.Create;
begin
  inherited Create;
  FAppID:=ff_ConsumerKey;
  FAPIVersion:=ffAPIVer;
end;

function TFriendFeed.Entry(const aMsg: string; aTo: string): boolean;
var Params: TStringList;
    Res:string;
begin
  Params:=TStringList.Create;
  Params.Add('body='+aMsg+'&to='+aTo);
  Res:=POSTCommand(ff_entry,Params);
  Result:=(pos('errorCode',Res)<=0)and(Length(Res)>0);
end;

function TFriendFeed.POSTCommand(const Operation:TffOperations; Params: TStrings): string;
var URL: string;
    Oper: string;
    i:integer;
begin
Result:='';
if Params<>nil then
  if Params.Count>0 then
    begin
      Oper:=GetEnumName(TypeInfo(TffOperations),ord(Operation));
      Delete(Oper,1,3);
      URL:=Format(FFURL,[FLogin,FRemoteKey,FAPIVersion,Oper])+'?';
      for I := 0 to Params.Count-1 do
        URL:=URL+Params[i]+'&';
      Delete(URL,length(URL),1);
      url := EncodeURL(AnsiToUtf8(URL));
      with THTTPSend.Create do
        begin
          Params.SaveToStream(Document);
          HTTPMethod('POST', url);
          Params.LoadFromStream(Document);
          Result:=Params.Text;
        end;
    end;
end;

procedure TFriendFeed.SetAPIVersion(const Value: integer);
begin
  FAPIVersion := Value;
end;

procedure TFriendFeed.SetAppID(const Value: string);
begin
  FAppID := Value;
end;

procedure TFriendFeed.SetAuthorized(const Value: boolean);
begin
  FAuthorized := Value;
end;

procedure TFriendFeed.SetLogin(const Value: string);
begin
  FLogin := Value;
end;

procedure TFriendFeed.SetRemoteKey(const Value: string);
begin
  FRemoteKey := Value;
end;

function TFriendFeed.Subscribe(const ListID: string): boolean;
var Params: TStringList;
begin
  Params:=TStringList.Create;
  Params.Add('feed='+ListID+'&appid='+AppID);
  Result:=pos('subscribed',POSTCommand(ff_subscribe,Params))>0
end;

end.
