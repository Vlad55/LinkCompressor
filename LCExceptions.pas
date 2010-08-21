unit LCExceptions;

interface

uses Classes, SysUtils,Windows;

resourcestring
  rcHTMLLink = '<a href="%s">ТЕКСТ_ССЫЛКИ</a>';
  rcForumAnchor = '[url=%s]ТЕКСТ_ССЫЛКИ[/url]';
  rcAnchor = 'ТЕКСТ_ССЫЛКИ';
  rcError = 'Ошибка';
  rcNoTwitAuth = 'Авторизация в Twitter не пройдена. Пройти?';
  rcNoTwitAuthHead = 'Нет доступа к Twitter';
  rcWrongAuth = 'Ошибка авторизации. Повторите попытку заново';
  rcServiceCompressError = 'Ошибка сжатия ссылки с помощью сервиса %s';
  rcErrorHistory = 'Не удалось сохранить историю сжатия ссылок';
  rcErrorHistoryLoad = 'Не удалось загрузить историю сжатия ссылок';
  rcLengthError = 'Длина сообщения больше 140 символов!';
  rcErrorOpenGroup = 'Не удалось открыть шаблон группового копирования';
  rcErrorSaveGroup = 'Не удалось сохранить шаблон группового копирования';
  rcNewVersionFound = 'Обнаружена новая версия программы. Перейти на сайт за обновлением?';
  rcNewVersion = 'Вышла новая версия';
  rcNoNewVersions = 'Новых версий не обнаружено';
  rcReady = 'настроен';
  rcNotReady = 'не настроен';
  rcLinkError = 'Ссылка должна начинаться с http://, https:// или ftp://';
  rcFFAuthError ='Вы не авторизованы в FF. Авторизуйтесь';
  rcFFSendError = 'Во время отправки сообщения произошла ошибка. Попробуйте отправить сообщение позже';
  rcFFSubscribeError = 'Не удалось подписаться на группу LinkCompressor';
  rcFFSendGroupErr = 'Не удалось отправить сообщение в группу LinkCompressor';
  rcTwitter = 'Twitter';
  rcFF = 'FriendFeed';
  rcErrorProg = 'Целостность программы была нарушена. Переустановите приложение.';
  rcHeadError = 'Ошибка получения данных по URL';
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
