unit uReport;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  StdCtrls, ExtCtrls, uShorter;

type
  TContactForm = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ContactForm: TContactForm;

implementation

uses OldMain;

{$R *.dfm}

procedure TContactForm.Button1Click(Sender: TObject);
begin
  Copyer.Forum:=CheckBox1.Checked;
  Copyer.ForumAnchor:=CheckBox2.Checked;
  Copyer.ForumText:=Edit1.Text;
  Copyer.HTML:=CheckBox3.Checked;
  Copyer.HTMLText:=Edit2.Text;
  ModalResult:=mrOk;
  hide;
end;

procedure TContactForm.CheckBox2Click(Sender: TObject);
begin
  label1.Enabled:=CheckBox2.Checked;
  Edit1.Enabled:=CheckBox2.Checked;
end;

procedure TContactForm.CheckBox3Click(Sender: TObject);
begin
label2.Enabled:=CheckBox3.Checked;
  Edit2.Enabled:=CheckBox3.Checked;
end;

procedure TContactForm.FormCreate(Sender: TObject);
begin
  CheckBox1.Checked:=Copyer.Forum;
  CheckBox2.Checked:=Copyer.ForumAnchor;
  Edit1.Text:=Copyer.ForumText;
  CheckBox3.Checked:=Copyer.HTML;
  Edit2.Text:=Copyer.HTMLText;

  label1.Enabled:=CheckBox2.Checked;
  Edit1.Enabled:=CheckBox2.Checked;
  label2.Enabled:=CheckBox3.Checked;
  Edit2.Enabled:=CheckBox3.Checked;
end;

end.
