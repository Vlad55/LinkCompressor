unit BitlyParser;

interface

uses SysUtils, Classes, NativeXML,BitlyAPI, Generics.Collections;

resourcestring
  rcErrorResponse='Ответ сервера bit.ly: %s';

type
  Tag_ShortURL = Record
    URL: string;
    Hash:string;
    GlobaCash:string;
    NewHash: boolean;
end;


type
  Tag_Click = record
    short_url: string;
    global_hash:string;
    user_clicks:integer;
    user_hash: string;
    global_clicks: integer;
end;

type
  TClicks = class (TLIst<Tag_Click>);

type
  TBitlyParser = class
  public
    class function ParseShorten(const Responce:string):Tag_ShortURL;
    class function ParseClicks(const Responce:string):TClicks;
end;

implementation

{ TBitlyParser }



{ TBitlyParser }

class function TBitlyParser.ParseClicks(const Responce:string): TClicks;
var XMLdoc: TNativeXml;
    i:integer;
    List:TXmlNodeList;
    Click: Tag_Click;
begin
  XMLdoc:=TNativeXml.Create;
  XMLdoc.ReadFromString(Responce);
  if XMLdoc.Root.ReadInteger('status_code')=200 then
    begin
      List:=TXmlNodeList.Create;
      Result:=TClicks.Create;
      XMLdoc.Root.FindNodes('clicks',List);
      for i:=0 to List.Count - 1 do
        begin
          Click.short_url:=List.Items[i].ReadString('short_url');
          Click.global_hash:=List.Items[i].ReadString('global_hash');
          Click.user_clicks:=List.Items[i].ReadInteger('user_clicks');
          Click.user_hash:=List.Items[i].ReadString('user_hash');
          Click.global_clicks:=List.Items[i].ReadInteger('global_clicks');
          Result.Add(Click);
        end;
    end
  else
    raise Exception.Create(Format(rcErrorResponse,[XMLdoc.Root.ReadInteger('status_txt')]));
end;

class function TBitlyParser.ParseShorten(
  const Responce: string): Tag_ShortURL;
var XMLdoc: TNativeXml;
begin
  XMLdoc:=TNativeXml.Create;
  XMLdoc.ReadFromString(Responce);
  if XMLdoc.Root.ReadInteger('status_code')=200 then
    begin
      Result.URL:=XMLdoc.Root.FindNode('data').ReadString('url');
      Result.Hash:=XMLdoc.Root.FindNode('data').ReadString('hash');
      Result.GlobaCash:=XMLdoc.Root.FindNode('data').ReadString('global_hash');
      Result.NewHash:=XMLdoc.Root.FindNode('data').ReadBool('new_hash');
    end
  else
    raise Exception.Create(Format(rcErrorResponse,[XMLdoc.Root.ReadInteger('status_txt')]));
end;

end.
