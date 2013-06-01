unit Brokers;

{$mode objfpc}{$H+}

interface

implementation

uses
  Classes,
  SysUtils,
  fpmimetypes,
  BrookFCLHTTPAppBroker,
  BrookHTTPConsts,
  BrookUtils,
  BrookStaticFileBroker,
  BrookApplication;

var
  PublicHTMLDir: string;

initialization
  MimeTypes.LoadFromFile('mime.types');
  PublicHTMLDir := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  BrookSettings.Charset := BROOK_HTTP_CHARSET_UTF_8;
  BrookSettings.Page404 := PublicHTMLDir + '404.html';
  BrookSettings.Page500 := PublicHTMLDir + '500.html';
  BrookSettings.RootUrl := 'http://localhost:8000';
  (BrookApp.Instance as TBrookHTTPApplication).Port := 8000;

  BrookStaticFileRegisterDirectory('/css/', PublicHTMLDir + 'css');
  BrookStaticFileRegisterDirectory('/js/', PublicHTMLDir + 'js');
  BrookStaticFileRegisterDirectory('/img/', PublicHTMLDir + 'img');

end.
