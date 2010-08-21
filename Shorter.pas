unit Shorter;

interface

uses httpsend, sysutils, synacode, classes;

function unu(const URL: string):string;

implementation

function unu(const URL: string):string;
begin
  with THTTPSend.Create do
    begin
       HTTPMethod('GET','http://u.nu/unu-api-simple?url='+EncodeURLElement(URL));
    StrStream.LoadFromStream(Document);
    Edit2.Text:=Trim(StrStream.DataString);
    Label7.Caption:=IntToStr(Length(Edit2.Text));
    end;
end;

end.
