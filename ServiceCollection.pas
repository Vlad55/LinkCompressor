unit ServiceCollection;

interface

uses Classes, SysUtils, Generics.Collections, NativeXML, TypInfo,Dialogs,
stdctrls,ComCtrls;

type
  TSendMethod = (GET, POST);
  TServiceAccount = class;
  TServiceInfo = class;
  TAccountBase = class;
  TServiceBase = class;

  TServiceInfo = class
  private
    FDomain: string; // домен сервиса - is.gd, bit.ly и т.д.
    FTemplate: string; // шаблон URL
    FMethod: TSendMethod; // метод отправки запроса
    FParams: TStringList; // параметры запроса
    FDoEncode: boolean; // кодировать ли исходный URL
    FNeedRegistry: boolean; // сервис требует регистрации для доступа к API
    FPreviewChar: Char; // символ, который необходимо вставить в URL для предпросмотра
  public
    constructor Create;
    destructor Destroy;
    property Domain: string read FDomain write FDomain;
    property Template: string read FTemplate write FTemplate;
    property Method: TSendMethod read FMethod write FMethod;
    property Params: TStringList read FParams write FParams;
    property DoEncode: boolean read FDoEncode write FDoEncode;
    property PreviewChar: Char read FPreviewChar write FPreviewChar;
    property NeedRegistry: boolean read FNeedRegistry write FNeedRegistry;
  end;

  TServiceBase = class(TList<TServiceInfo>)
  public
    constructor Create;
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);
    procedure ShowTo(Broker:TComponent);
    function  Service(i:integer):TServiceInfo;overload;
    function  Service(DomainName:string):TServiceInfo;overload;
  end;

  TServiceAccount = class
  private
    FServiceDomain:string;
    FUserName:string;
    FUserPass:string;
    FAPIKey: string;
  public
    property ServiceDomain:string read FServiceDomain write FServiceDomain;
    property UserName:string read FUserName write FUserName;
    property UserPass:string read FUserPass write FUserPass;
    property APIKey: string read FAPIKey write FAPIKey;
end;

  TAccountBase = class(TList<TServiceAccount>)
  strict private
    class var
      FListComponent: TComponent;
    class property ListComponent: TComponent read FListComponent write FListComponent;
    class procedure OnNotifyEvent (Sender: TObject; const Item: TServiceAccount;
    Action: TCollectionNotification); overload;
  public
    constructor Create(const ListObject: TComponent);
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);
    procedure AssignListComponent(aListComponent: TComponent);
    procedure Delete(i: integer);overload;
    function  Account(i:integer):TServiceAccount;overload;
    function  Account(Domain:string):TServiceAccount;overload;
end;

var
  ServiceBase: TServiceBase;
  AccountBase: TAccountBase;
  ServiceInfo: array of TServiceInfo;
  Acc: array of TServiceAccount;

implementation

constructor TServiceBase.Create;
begin
  inherited Create;
end;

procedure TServiceBase.LoadFromFile(const FileName: string);
var i:integer;
    XML:TNativeXml;
    Ch: Char;
begin
try
  XML:=TNativeXml.Create;
  XML.LoadFromFile(FileName);
  for I:=0 to XML.Root.NodeCount-1 do
    begin
      SetLength(ServiceInfo,length(ServiceInfo)+1);
      ServiceInfo[length(ServiceInfo)-1]:=TServiceInfo.Create;
      ServiceInfo[length(ServiceInfo)-1].FDomain:=XML.Root.Nodes[i].Name;
      ServiceInfo[length(ServiceInfo)-1].FTemplate:=XML.Root.Nodes[i].ReadString('Template','');
      ServiceInfo[length(ServiceInfo)-1].FMethod:=TSendMethod(GetEnumValue(TypeInfo(TSendMethod),XML.Root.Nodes[i].ReadString('Method','')));
      ServiceInfo[length(ServiceInfo)-1].FParams.Text:=XML.Root.Nodes[i].ReadString('Params','');
      ServiceInfo[length(ServiceInfo)-1].FDoEncode:=XML.Root.Nodes[i].ReadBool('DoEncode',true);
      ServiceInfo[length(ServiceInfo)-1].FNeedRegistry:=XML.Root.Nodes[i].ReadBool('NeedRegistry',false);
      Ch:=Char(XML.Root.Nodes[i].ReadString('PreviewChar','')[1]);
      ServiceInfo[length(ServiceInfo)-1].FPreviewChar:=Ch;
    end;
  ServiceBase.AddRange(ServiceInfo);
  ShowMessage(IntToStr(ServiceBase.Count));
finally
  FreeAndNil(XML);
end;
end;

procedure TServiceBase.SaveToFile(const FileName: string);
var
  i: integer;
  XML: TNativeXml;
  Node: TXmlNode;
begin
try
  XML := TNativeXml.Create;
  XML.CreateName('Services');
  for i := 0 to Self.Count - 1 do
  begin
    Node := XML.Root.NodeNew(Self[i].FDomain);
    Node.WriteString('Template', Self[i].FTemplate);
    Node.WriteString('Method', GetEnumName(TypeInfo(TSendMethod), ord
          ((Self[i].FMethod))));
    Node.WriteString('Params', Self[i].FParams.Text);
    Node.WriteBool('DoEncode', Self[i].FDoEncode);
    Node.WriteBool('NeedRegistry', Self[i].FNeedRegistry);
    Node.WriteString('PreviewChar', Self[i].FPreviewChar);
    Node := nil;
  end;
  XML.SaveToFile(FileName);
finally
  XML.Free;
end;
end;

function TServiceBase.Service(i: integer): TServiceInfo;
begin
  if i<=Self.Count-1 then
    begin
      Result:=TServiceInfo.Create;
      Result:=Self.Items[i];
    end;
end;

function TServiceBase.Service(DomainName: string): TServiceInfo;
var i:integer;
begin
  for I := 0 to Self.Count - 1 do
    begin
      if lowercase(Trim(DomainName))=lowercase(self.Items[i].Domain) then
        begin
          Result:=TServiceInfo.Create;
          Result:=Service(i);
          break;
        end;
    end;
end;

procedure TServiceBase.ShowTo(Broker: TComponent);
var i:integer;
    TN,R,N:TTreeNode;
begin
  if (Broker is TListBox) then
    begin
      (Broker as TListBox).Items.Clear;
      for I := 0 to self.Count-1 do
        (Broker as TListBox).Items.Add(Self.Items[i].Domain)
    end
  else
   if (Broker is TTreeView) then
     begin
       (Broker as TTreeView).Items.BeginUpdate;
       R:=TTreeNode.Create((Broker as TTreeView).Items);
       N:=TTreeNode.Create((Broker as TTreeView).Items);
       (Broker as TTreeView).Items.Clear;
       R:=(Broker as TTreeView).Items.AddFirst(R,'С регистрацией');
       N:=(Broker as TTreeView).Items.AddFirst(N,'Без регистрации');
       for I := 0 to self.Count-1 do
         begin
           if Self.Items[i].NeedRegistry then
             (Broker as TTreeView).Items.AddChildFirst(R,Self.Items[i].Domain)
           else
             (Broker as TTreeView).Items.AddChild(N,Self.Items[i].Domain)
         end;
       (Broker as TTreeView).Items.EndUpdate;
     end
   else
     raise Exception.Create('Недопустимый объект');
end;

{ TServiceInfo }

constructor TServiceInfo.Create;
begin
  inherited Create;
  FParams := TStringList.Create;
end;

destructor TServiceInfo.Destroy;
begin
  FreeAndNil(FParams);
  inherited Free;
end;

{ TAccountBase }

function TAccountBase.Account(i: integer): TServiceAccount;
begin
  if i<=Self.Count-1 then
    begin
      Result:=TServiceAccount.Create;
      Result:=Self.Items[i];
    end;
end;

function TAccountBase.Account(Domain: string): TServiceAccount;
var i:integer;
begin
  for I := 0 to Self.Count - 1 do
    begin
      if LowerCase(Trim(Domain))=LowerCase(Self.Items[i].ServiceDomain) then
        begin
          Result:=Account(i);
          break;
        end;
    end;
end;

procedure TAccountBase.AssignListComponent(aListComponent: TComponent);
begin
  FListComponent:=aListComponent;
end;

constructor TAccountBase.Create(const ListObject: TComponent);
begin
  inherited Create;
  FListComponent:=ListObject;
  Self.OnNotify:=OnNotifyEvent;
end;

procedure TAccountBase.Delete(i: integer);
begin
  inherited DeleteRange(i,1);
  if ListComponent<>nil then
    begin
      if (ListComponent is TListBox) then
        (ListComponent as TListBox).Items.Delete(i);
    end;
end;

procedure TAccountBase.LoadFromFile(const FileName: string);
var i:integer;
    XML: TNativeXml;
begin
try
  XML:=TNativeXml.Create;
  XML.LoadFromFile(FileName);
  for I:=0 to XML.Root.NodeCount-1 do
    begin
      SetLength(Acc,length(Acc)+1);
      Acc[length(Acc)-1]:=TServiceAccount.Create;
      Acc[length(Acc)-1].FServiceDomain:=XML.Root.Nodes[i].Name;
      Acc[length(Acc)-1].FUserName:=XML.Root.Nodes[i].ReadString('UserName','');
      Acc[length(Acc)-1].FUserPass:=XML.Root.Nodes[i].ReadString('UserPass','');
      Acc[length(Acc)-1].FAPIKey:=XML.Root.Nodes[i].ReadString('APIKey','');
    end;
  AccountBase.AddRange(Acc);
  ShowMessage(IntToStr(AccountBase.Count));
finally
  FreeAndNil(XML);
end;
end;

class procedure TAccountBase.OnNotifyEvent(Sender: TObject;
  const Item: TServiceAccount; Action: TCollectionNotification);
begin
if ListComponent<>nil then
  begin
    if Action=cnAdded then
      begin
        if (ListComponent is TListBox) then
         (ListComponent as TListBox).Items.Add(Item.FServiceDomain);
      end
  end;
end;

procedure TAccountBase.SaveToFile(const FileName: string);
var
  i: integer;
  XML: TNativeXml;
  Node: TXmlNode;
begin
try
  XML := TNativeXml.Create;
  XML.CreateName('Accounts');
  for i := 0 to Self.Count - 1 do
  begin
    Node := XML.Root.NodeNew(Self[i].ServiceDomain);
    Node.WriteString('UserName', Self[i].UserName);
    Node.WriteString('UserPass', Self[i].UserPass);
    Node.WriteString('APIKey', Self[i].APIKey);
    Node := nil;
  end;

  XML.SaveToFile(FileName);
finally
  XML.Free;
end;
end;

initialization

begin
  ServiceBase := TServiceBase.Create;
  if not FileExists('ServBase.xml') then
  begin
    SetLength(ServiceInfo, length(ServiceInfo) + 1);
    ServiceInfo[length(ServiceInfo) - 1] := TServiceInfo.Create;
    ServiceInfo[length(ServiceInfo) - 1].Domain := 'is.gd';
    ServiceInfo[length(ServiceInfo) - 1].FTemplate :=
      'http://is.gd/api.php?longurl=[long_url]';
    ServiceInfo[length(ServiceInfo) - 1].FMethod := GET;
    ServiceInfo[length(ServiceInfo) - 1].FDoEncode := true;
    ServiceInfo[length(ServiceInfo) - 1].FNeedRegistry := false;
    ServiceInfo[length(ServiceInfo) - 1].FPreviewChar := '=';

    SetLength(ServiceInfo, length(ServiceInfo) + 1);
    ServiceInfo[length(ServiceInfo) - 1] := TServiceInfo.Create;
    ServiceInfo[length(ServiceInfo) - 1].Domain := 'sokrati.ru';
    ServiceInfo[length(ServiceInfo) - 1].FTemplate := 'http://sokrati.ru/do/[long_url]';
    ServiceInfo[length(ServiceInfo) - 1].FMethod := GET;
    ServiceInfo[length(ServiceInfo) - 1].FDoEncode := false;
    ServiceInfo[length(ServiceInfo) - 1].FNeedRegistry := false;
    ServiceInfo[length(ServiceInfo) - 1].FPreviewChar := '1';

    SetLength(ServiceInfo, length(ServiceInfo) + 1);
    ServiceInfo[length(ServiceInfo) - 1] := TServiceInfo.Create;
    ServiceInfo[length(ServiceInfo) - 1].Domain := 'clck.ru';
    ServiceInfo[length(ServiceInfo) - 1].FTemplate :=
      'http://clck.ru/--?url=[long_url]';
    ServiceInfo[length(ServiceInfo) - 1].FMethod := GET;
    ServiceInfo[length(ServiceInfo) - 1].FDoEncode := true;
    ServiceInfo[length(ServiceInfo) - 1].FNeedRegistry := false;
    ServiceInfo[length(ServiceInfo) - 1].FPreviewChar := '1';

    SetLength(ServiceInfo, length(ServiceInfo) + 1);
    ServiceInfo[length(ServiceInfo) - 1] := TServiceInfo.Create;
    ServiceInfo[length(ServiceInfo) - 1].Domain := 'zi.ma';
    ServiceInfo[length(ServiceInfo) - 1].FTemplate :=
      'http://zi.ma/?module=ShortURL&file=Add&mode=API&url=[long_url]';
    ServiceInfo[length(ServiceInfo) - 1].FMethod := GET;
    ServiceInfo[length(ServiceInfo) - 1].FDoEncode := true;
    ServiceInfo[length(ServiceInfo) - 1].FNeedRegistry := false;
    ServiceInfo[length(ServiceInfo) - 1].FPreviewChar := '1';

    SetLength(ServiceInfo, length(ServiceInfo) + 1);
    ServiceInfo[length(ServiceInfo) - 1] := TServiceInfo.Create;
    ServiceInfo[length(ServiceInfo) - 1].Domain := 'u.nu';
    ServiceInfo[length(ServiceInfo) - 1].FTemplate :=
      'http://u.nu/unu-api-simple?url=[long_url]';
    ServiceInfo[length(ServiceInfo) - 1].FMethod := GET;
    ServiceInfo[length(ServiceInfo) - 1].FDoEncode := true;
    ServiceInfo[length(ServiceInfo) - 1].FNeedRegistry := false;
    ServiceInfo[length(ServiceInfo) - 1].FPreviewChar := '?';

    SetLength(ServiceInfo, length(ServiceInfo) + 1);
    ServiceInfo[length(ServiceInfo) - 1] := TServiceInfo.Create;
    ServiceInfo[length(ServiceInfo) - 1].Domain := 'nn.nf';
    ServiceInfo[length(ServiceInfo) - 1].FTemplate := 'http://nn.nf/api.php';
    ServiceInfo[length(ServiceInfo) - 1].FMethod := POST;
    ServiceInfo[length(ServiceInfo) - 1].FDoEncode := true;
    ServiceInfo[length(ServiceInfo) - 1].FParams.Add('url=[long_url]');
    ServiceInfo[length(ServiceInfo) - 1].FNeedRegistry := false;
    ServiceInfo[length(ServiceInfo) - 1].FPreviewChar := '=';

    SetLength(ServiceInfo, length(ServiceInfo) + 1);
    ServiceInfo[length(ServiceInfo) - 1] := TServiceInfo.Create;
    ServiceInfo[length(ServiceInfo) - 1].Domain := 'wc.ru';
    ServiceInfo[length(ServiceInfo) - 1].FTemplate := 'http://0wc.ru/text/[long_url]';
    ServiceInfo[length(ServiceInfo) - 1].FMethod := GET;
    ServiceInfo[length(ServiceInfo) - 1].FDoEncode := false;
    ServiceInfo[length(ServiceInfo) - 1].FNeedRegistry := false;
    ServiceInfo[length(ServiceInfo) - 1].FPreviewChar := '1';
    ServiceBase.AddRange(ServiceInfo);
    ServiceBase.SaveToFile('ServBase.xml');
  end
else
  begin
    ServiceInfo:=nil;
    ServiceBase.LoadFromFile('ServBase.xml');
  end;
end;

end.
