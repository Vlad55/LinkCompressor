unit LCExceptions;

interface

uses Classes, SysUtils,Windows;

resourcestring
  rcHTMLLink = '<a href="%s">�����_������</a>';
  rcForumAnchor = '[url=%s]�����_������[/url]';
  rcAnchor = '�����_������';
  rcError = '������';
  rcNoTwitAuth = '����������� � Twitter �� ��������. ������?';
  rcNoTwitAuthHead = '��� ������� � Twitter';
  rcWrongAuth = '������ �����������. ��������� ������� ������';
  rcServiceCompressError = '������ ������ ������ � ������� ������� %s';
  rcErrorHistory = '�� ������� ��������� ������� ������ ������';
  rcErrorHistoryLoad = '�� ������� ��������� ������� ������ ������';
  rcLengthError = '����� ��������� ������ 140 ��������!';
  rcErrorOpenGroup = '�� ������� ������� ������ ���������� �����������';
  rcErrorSaveGroup = '�� ������� ��������� ������ ���������� �����������';
  rcNewVersionFound = '���������� ����� ������ ���������. ������� �� ���� �� �����������?';
  rcNewVersion = '����� ����� ������';
  rcNoNewVersions = '����� ������ �� ����������';
  rcReady = '��������';
  rcNotReady = '�� ��������';
  rcLinkError = '������ ������ ���������� � http://, https:// ��� ftp://';
  rcFFAuthError ='�� �� ������������ � FF. �������������';
  rcFFSendError = '�� ����� �������� ��������� ��������� ������. ���������� ��������� ��������� �����';
  rcFFSubscribeError = '�� ������� ����������� �� ������ LinkCompressor';
  rcFFSendGroupErr = '�� ������� ��������� ��������� � ������ LinkCompressor';
  rcTwitter = 'Twitter';
  rcFF = 'FriendFeed';
  rcErrorProg = '����������� ��������� ���� ��������. �������������� ����������.';
  rcHeadError = '������ ��������� ������ �� URL';
const
  ErrorOk = 16;

Type
  TLCExceptions = class
  public
    class procedure Show(const aMSG,aCaption: string; lType:cardinal);
    class procedure ShowFmt(const aMSG,aCaption: string; lType:cardinal;const Args:array of const);
end;


implementation

{ TLCExceptions }

class procedure TLCExceptions.Show(const aMSG, aCaption: string;
  lType: cardinal);
begin
  MessageBox(0,PChar(aMsg),PChar(aCaption),lType);
end;

class procedure TLCExceptions.ShowFmt(const aMSG, aCaption: string;
  lType: cardinal; const Args: array of const);
begin
  MessageBox(0,PChar(Format(aMsg,Args)),PChar(aCaption),lType);
end;

end.
