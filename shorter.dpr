program shorter;

uses
  Forms,
  uShorter in 'uShorter.pas',
  uAbout in 'uAbout.pas' {fAbout},
  shrtOptions in 'shrtOptions.pas' {FOptions},
  uTwitter in 'uTwitter.pas' {fTwitter},
  uReport in 'uReport.pas' {ContactForm},
  BitlyAPI in 'BitlyAPI.pas',
  BitlyParser in 'BitlyParser.pas',
  OAuth_ICS in 'OAuth_ICS.pas',
  OAuthUtils in 'OAuthUtils.pas',
  TwitAuth in 'TwitAuth.pas' {AuthForm},
  common in 'common.pas',
  OldMain in 'OldMain.pas' {OldMainForm},
  LCExceptions in 'LCExceptions.pas',
  uFFAuth in 'uFFAuth.pas' {ffauthform},
  uFFSender in 'uFFSender.pas' {fFFSender},
  udeshifr in 'udeshifr.pas' {fDeshifr},
  LinkTest in 'LinkTest.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Link Compressor';
  Application.CreateForm(TOldMainForm, OldMainForm);
  Application.CreateForm(TfAbout, fAbout);
  Application.CreateForm(TFOptions, FOptions);
  Application.CreateForm(TfTwitter, fTwitter);
  Application.CreateForm(TContactForm, ContactForm);
  Application.CreateForm(TAuthForm, AuthForm);
  Application.CreateForm(Tffauthform, ffauthform);
  Application.CreateForm(TfFFSender, fFFSender);
  Application.CreateForm(TfDeshifr, fDeshifr);
  Application.Run;
end.
