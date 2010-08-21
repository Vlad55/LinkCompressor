unit compress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Label3: TLabel;
    Label4: TLabel;
    ProgressBar1: TProgressBar;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private

  public
    procedure Compress;
  end;

var
  Form1: TForm1;

implementation

uses shrt_main, uShorter, ServiceCollection;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
FMain.CanselCompress:=true;
Form1.ModalResult:=mrOk;
Form1.Hide;
end;

procedure TForm1.Compress;
var
  ShortLink: string;
  i,count: integer;
begin
count:=0;
  with FMain do
  begin
    for i := 0 to JvCheckTreeView1.Items.Count - 1 do
      begin
        if (JvCheckTreeView1.Checked[JvCheckTreeView1.Items[i]] and
            (JvCheckTreeView1.Items[i].Level = 1)) then
          inc(count)
      end;
    ProgressBar1.Max:=count;
    ProgressBar1.Position:=0;
    JvStringGrid1.RowCount:= 2;
    JvStringGrid1.Rows[1].Clear;
    for i := 0 to JvCheckTreeView1.Items.Count - 1 do
    begin
      if CanselCompress then  break;
      if (JvCheckTreeView1.Checked[JvCheckTreeView1.Items[i]] and
          (JvCheckTreeView1.Items[i].Level = 1)) then
      begin
        ShortLink:='';
        ProgressBar1.Position:=ProgressBar1.Position+1;
        Form1.label4.Caption:=JvCheckTreeView1.Items[i].Text;
        ShortLink := TShorter.ShortThis(Edit1.Text, ServiceBase.Service
            (JvCheckTreeView1.Items[i].Text));
        if TShorter.IsLink(ShortLink) then
        begin
          JvStringGrid1.Cells[0, JvStringGrid1.RowCount - 1] :=
            JvCheckTreeView1.Items[i].Text;
          JvStringGrid1.Cells[1, JvStringGrid1.RowCount - 1] := ShortLink;
          JvStringGrid1.Cells[2, JvStringGrid1.RowCount - 1] := IntToStr
            (Length(ShortLink));
          JvStringGrid1.Cells[3, JvStringGrid1.RowCount - 1] := IntToStr
            (TShorter.CompressionRate(Edit1.Text, ShortLink));
        end
        else
        begin
          JvStringGrid1.Cells[0, JvStringGrid1.RowCount - 1] :=
            JvCheckTreeView1.Items[i].Text;
          JvStringGrid1.Cells[1, JvStringGrid1.RowCount - 1] := 'Ошибка сжатия';
          JvStringGrid1.Cells[2, JvStringGrid1.RowCount - 1] := '0';
          JvStringGrid1.Cells[3, JvStringGrid1.RowCount - 1] := '0';
        end;
        JvStringGrid1.RowCount := JvStringGrid1.RowCount + 1;
        JvStringGrid1.Rows[JvStringGrid1.RowCount-1].Clear;
        Application.ProcessMessages;
      end;
    end;
  end;
Button1Click(self);
end;

procedure TForm1.FormHide(Sender: TObject);
begin
ModalResult:=mrOk;
Fmain.Enabled:=true;
end;

end.
