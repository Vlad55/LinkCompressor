unit LinkTest;

interface

uses SysUtils, Classes, Windows, Dialogs, httpsend,mshtml,LCExceptions,
synautil,ActiveX,Variants;

const
  DefCharset = 'windows-1251';
  SafeBrowser='http://www.google.com/safebrowsing/diagnostic?site=';
  SafeContentType = 'text/html';

type
  TLinkTester = class
  private
    FLongLink: string;
    Fdomain: string;
    FScripts: integer;
    FscriptList: TStringList;
    FMimeType: string;
    FSize: integer;
    FiFrames: integer;
    FShortLink: string;
    FiframeList: TStringList;
    FPathToDomain: TStringList;
    FContent: TStringStream;
    FContentLength: integer;
    FResponseCode: integer;
    FTitle: string;
    FCharset: string;
    procedure SetLongLink(const Value: string);
    procedure SetShortLink(const Value: string);
    procedure SetPathToDomain(const Value: TStringList);
    function GetHeaders(const aURL:string):TStringList;
    function FindLocation(const aHeaders:TStringList; var aLocation:string):boolean;
    function GetDomain(const aURL:string):string;
    function GetTargetURL(const aHeaders: TStringList): string;
    procedure GetInfo(const aHeaders:TStringList);
    procedure GetContent(const aURL:string);
    procedure SetContentLength(const Value: integer);
    procedure SetResponseCode(const Value: integer);
    procedure ParseContent;
    procedure SetTitle(const Value: string);
  published
   procedure Analyse;
   property ShortLink: string read FShortLink write SetShortLink;
   property LongLink:string read FLongLink write SetLongLink;
   property domain: string read Fdomain;
   property MimeType: string read FMimeType;
   property Size: integer read FSize;
   property iFrames: integer read FiFrames;
   property Scripts: integer read FScripts;
   property iframeList: TStringList read FiframeList;
   property scriptList: TStringList read FscriptList;
   property PathToDomain: TStringList read FPathToDomain write SetPathToDomain;
   property ContentLength:integer read FContentLength write SetContentLength;
   property ResponseCode:integer read FResponseCode write SetResponseCode;
   property Title:string read FTitle write SetTitle;
 public
  constructor Create;
end;

implementation

{ TLinkTester }

function TLinkTester.GetTargetURL(const aHeaders: TStringList): string;
var i:integer;
begin
  Result:='';
  if aHeaders=nil then Exit;
  for i:=0 to aHeaders.Count - 1 do
    begin
      if pos('location:',LowerCase(aHeaders[i]))>0 then
       begin
         Result:=copy(aHeaders[i],11,length(aHeaders[i])-pos('location:',LowerCase(aHeaders[i])));
         break;
       end;
    end;
end;


procedure TLinkTester.ParseContent;
var Doc: IHTMLDocument2;
    V:OLEVariant;
    DocA: IHTMLElementCollection;
    DocElement: IHtmlElement;
    i:integer;
begin
if LowerCase(Trim(FMimeType))='text/html' then
  begin
    Doc:=CoHTMLDocument.Create as IHTMLDocument2;
    V:=VarArrayCreate([0,0], varVariant);
    V[0]:=FContent.DataString;
    Doc.Write(PSafeArray(TVarData(v).VArray));
    FTitle:=Doc.title;
    DocA:=Doc.all.tags('iframe') as IHTMLElementCollection;
    FiFrames:=DocA.length;
    for I := 0 to DocA.length - 1 do
      begin
        DocElement:=DocA.item(i,0)as IHTMLElement;
        FiframeList.Add(DocElement.innerText) //читаем текст внутри тега
      end;
  end;
end;

procedure TLinkTester.Analyse;
var i:integer;
    Prot, User, Pass, host,Port, Path, Para, URI: string;
    RedirectURL:string;
begin
FiframeList.Clear;
FPathToDomain.Clear;
FContent.Clear;


RedirectURL:=ShortLink;
  with THTTPSend.Create do
    begin
      repeat
        ParseURL(RedirectURL, Prot, User, Pass, Host, Port, Path, Para);
        FPathToDomain.Add(Host);
        FLongLink:=RedirectURL;
        if HTTPMethod('HEAD',RedirectURL) then
          begin
            RedirectURL:=GetTargetURL(Headers);
            headers.Clear;
            Document.Clear;
            if Length(Trim(RedirectURL))=0 then
              break;
          end
        else
          break;
      until (ResultCode=200)or(ResultCode>=404);
    end;
Fdomain:=FPathToDomain[FPathToDomain.Count-1];
GetInfo(GetHeaders(FLongLink));
GetContent(FLongLink);
ParseContent;
if FSize=0 then
  FSize:=FContent.Size;
end;

constructor TLinkTester.Create;
begin
  inherited Create;
  FiframeList:=TStringList.Create;
  FscriptList:=TStringList.Create;
  FPathToDomain:=TStringList.Create;
  FContent:=TStringStream.Create;
  FPathToDomain.Delimiter:=#13;
end;

function TLinkTester.FindLocation(const aHeaders: TStringList;
  var aLocation: string): boolean;
var str: string;
begin
  for str in aHeaders do
    begin
      Result:=Pos('location',LowerCase(str))>0;
      if Result then
        begin
          aLocation:=copy(str,11,Length(str)-11);
          break;
        end;
    end;
end;

procedure TLinkTester.GetContent(const aURL: string);
var B:TBytes;
    Data: string;
begin
//Content-Type: text/html; charset=iso-8859-1
if LowerCase(Trim(FMimeType))= SafeContentType then
  with THTTPSend.Create do
    begin
      if HTTPMethod('GET',aURL) then
        begin
          Document.SaveToStream(FContent);
          if LowerCase(FCharset)='utf-8' then
            begin
              B:=BytesOf(FContent.DataString);
              B:=TEncoding.Convert(TEncoding.UTF8,TEncoding.GetEncoding(1251),B);
              Data:=StringOf(B);
            end
          else
            Data:=FContent.DataString;
          FContent.Clear;
          FContent.WriteString(Data);
        end;
    end;
end;

function TLinkTester.GetDomain(const aURL: string): string;
var Prot, User, Pass, Host, Port, Path, Para: string;
begin
 ParseURL(aURL, Prot, User, Pass, Host, Port, Path, Para);
 Result:=Host;
end;

function TLinkTester.GetHeaders(const aURL: string): TStringList;
begin
Result:=TStringList.Create;
  with THTTPSend.Create do
    begin
      if HTTPMethod('HEAD',aURL) then
         Result.Assign(Headers)
      else
        TLCExceptions.Show(rcHeadError,rcError,ErrorOk);
    end;
end;

procedure TLinkTester.GetInfo(const aHeaders: TStringList);
var str: string;
begin
  for str in aHeaders do
    begin
      if pos('content-type:',LowerCase(str))>0 then
        begin
          if pos('=',LowerCase(str))>0 then
            FCharset:=LowerCase(Copy(str,pos('=',str)+1,Length(str)-pos('=',str)))
          else
            FCharset:=DefCharset;
          FMimeType:=copy(str,15,length(str)-14);
          if pos(';',FMimeType)>0 then
            FMimeType:=Copy(FMimeType,1,pos(';',FMimeType)-1);
        end
      else
        if pos('content-length',LowerCase(str))>0 then
          FSize:=StrToInt(copy(str,16,length(str)-15));
    end;
end;

procedure TLinkTester.SetContentLength(const Value: integer);
begin
  FContentLength := Value;
end;

procedure TLinkTester.SetLongLink(const Value: string);
begin
  FLongLink := Value;
end;

procedure TLinkTester.SetPathToDomain(const Value: TStringList);
begin
  FPathToDomain := Value;
end;

procedure TLinkTester.SetResponseCode(const Value: integer);
begin
  FResponseCode := Value;
end;

procedure TLinkTester.SetShortLink(const Value: string);
begin
  FShortLink := Value;
end;

procedure TLinkTester.SetTitle(const Value: string);
begin
  FTitle := Value;
end;

end.
