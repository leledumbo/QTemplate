unit StdWebTemplate;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, QTemplate;

type

  { TStdWebTemplate }

  TStdWebTemplate = class(TQTemplate)
  private
    function ReplaceCSS(const ATag: String; AParams: TStringList): String;
    function ReplaceJS(const ATag: String; AParams: TStringList): String;
    function ReplaceURL(const ATag: String; AParams: TStringList): String;
  public
    constructor Create(const AFileName: String); override;
  end;

implementation

{ TStdWebTemplate }

function TStdWebTemplate.ReplaceCSS(const ATag: String; AParams: TStringList
  ): String;
begin
  Result := '<link rel="stylesheet" type="text/css" href="' +
    AParams.Values['FileName'] + '" />';
end;

function TStdWebTemplate.ReplaceJS(const ATag: String; AParams: TStringList
  ): String;
begin
  Result := '<script type="text/javascript" src="' +
    AParams.Values['FileName'] + '"></script>';
end;

function TStdWebTemplate.ReplaceURL(const ATag: String; AParams: TStringList
  ): String;
begin
  Result := '<a href="' + AParams.Values['href'] + '">' +
    AParams.Values['text'] + '</a>';
end;

constructor TStdWebTemplate.Create(const AFileName: String);
begin
  inherited Create(AFileName);
  Tags['css'] := @ReplaceCSS;
  Tags['js'] := @ReplaceJS;
  Tags['url'] := @ReplaceURL;
end;

end.

