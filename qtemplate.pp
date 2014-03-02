unit QTemplate;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fptemplate, Utils;

type

  TTagCallback = function (const ATag: String; AParams: TStringList): String of object;

  TCallbackMap = specialize TStringHashMap<TTagCallback>;

  { TQTemplate }

  TQTemplate = class(TFPTemplate)
  private
    FTagMap: TCallbackMap;
    FCaseSensitive: Boolean;
    function GetTagName(const TagString: String): String;
    procedure ReplaceTags(Sender: TObject; const TagString: String;
      TagParams: TStringList; out ReplaceText: String);
    function GetTag(const TagString: String): TTagCallback;
    procedure SetTag(const TagString: String; AValue: TTagCallback);
  public
    constructor Create(const AFileName: String); virtual;
    destructor Destroy; override;
    property Tags[const TagString: String]: TTagCallback read GetTag write SetTag; default;
    property CaseSensitive: Boolean read FCaseSensitive write FCaseSensitive;
  end;

implementation

{ TQTemplate }

function TQTemplate.GetTagName(const TagString: String): String;
begin
  if FCaseSensitive then
    Result := TagString
  else
    Result := LowerCase(TagString);
end;

procedure TQTemplate.ReplaceTags(Sender: TObject; const TagString: String;
  TagParams: TStringList; out ReplaceText: String);
var
  TagName: String;
begin
  TagName := GetTagName(TagString);
  {$if fpc_fullversion >= 20701}
  if FTagMap.Contains(TagName) then begin
  {$else fpc_fullversion >= 20701}
  if FTagMap.IndexOf(TagName) >= 0 then begin
  {$endif fpc_fullversion >= 20701}
    ReplaceText := FTagMap[TagName](TagName,TagParams);
  end;
end;

function TQTemplate.GetTag(const TagString: String): TTagCallback;
var
  TagName: String;
begin
  TagName := GetTagName(TagString);
  Result := FTagMap[TagName];
end;

procedure TQTemplate.SetTag(const TagString: String; AValue: TTagCallback);
var
  TagName: String;
begin
  TagName := GetTagName(TagString);
  FTagMap[TagName] := AValue;
end;

constructor TQTemplate.Create(const AFileName: String);
begin
  inherited Create;
  FileName := AFileName;

  FCaseSensitive := false;
  FTagMap := TCallbackMap.Create;

  StartDelimiter := '{+';
  EndDelimiter := '+}';
  ParamStartDelimiter := '[-';
  ParamValueSeparator := '=';
  ParamEndDelimiter := '-]';

  AllowTagParams := true;
  OnReplaceTag := @ReplaceTags;
end;

destructor TQTemplate.Destroy;
begin
  FTagMap.Free;
  inherited Destroy;
end;

end.

