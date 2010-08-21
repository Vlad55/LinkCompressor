unit uFFSender;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, acPNG, ExtCtrls,Common,Common_ff,LCExceptions;

type
  TfFFSender = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fFFSender: TfFFSender;

implementation

{$R *.dfm}

procedure TfFFSender.Button1Click(Sender: TObject);
begin
  if FriendFeed.Authorized then
    begin
      if not FriendFeed.Entry(Memo1.Text,'me') then
        TLCExceptions.Show(rcFFSendError,rcError,ErrorOk);
      if CheckBox1.Checked then
        begin
          if FriendFeed.Subscribe(GroupName) then
            begin
              if not FriendFeed.Entry(Memo1.Text,GroupName) then
                TLCExceptions.Show(rcFFSendGroupErr,rcError,ErrorOk);
            end
          else
            TLCExceptions.Show(rcFFSubscribeError,rcError,ErrorOk);
        end;
    end
  else
    TLCExceptions.Show(rcFFAuthError,rcError,ErrorOk);
  if CheckBox2.Checked then
    begin
      if Length(Memo1.Text)>140 then
        Twitter.Update(Copy(Memo1.Text,1,140))
      else
        Twitter.Update(Memo1.Text);
    end;
ModalResult:=mrOk;
Hide;
end;

procedure TfFFSender.FormShow(Sender: TObject);
begin
  CheckBox2.Enabled:=Twitter.Authorized;
end;

end.
