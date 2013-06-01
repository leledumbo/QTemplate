program test;

{$mode objfpc}{$H+}

uses
  Classes,
  SysUtils,
  StrUtils,
  QTemplate;

type

  { TQTemplateTest }

  TQTemplateTest = class(TQTemplate)
  public
    constructor Create(const AFileName: String); override;
    function ReplaceTitle(const ATag: String; AParams: TStringList): String;
    function ReplaceItemList(const ATag: String; AParams: TStringList): String;
  end;

{ TQTemplateTest }

constructor TQTemplateTest.Create(const AFileName: String);
begin
  inherited Create(AFileName);
  Tags['title'] := @ReplaceTitle;
  Tags['itemlist'] := @ReplaceItemList;
end;

function TQTemplateTest.ReplaceTitle(const ATag: String; AParams: TStringList): String;
begin
  Result := 'Title of the App';
end;

function TQTemplateTest.ReplaceItemList(const ATag: String; AParams: TStringList
  ): String;
const
  Items: array [1..5] of String = ('Item 1','Item 2','Item 3','Item 4','Item 5');
var
  Header,Row,Footer: String;
  i: Integer;
begin
  Header := AParams.Values['header'];
  Row    := AParams.Values['row'];
  Footer := AParams.Values['footer'];

  with TStringList.Create do
    try
      Add(Header);
      for i := Low(Items) to High(Items) do
        Add(StringsReplace(Row,['~no','~value'],[IntToStr(i),Items[i]],[rfReplaceAll]));
      Add(Footer);
      Result := Text;
    finally
      Free;
    end;
end;

begin
  with TQTemplateTest.Create('test.tpl') do
    try
      WriteLn(GetContent);
    finally
      Free;
    end;
end.

