unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, BrookAction, StdWebTemplate;

type

  { TIndex }

  TIndex = class(TBrookAction)
  private
    FTemplate: TStdWebTemplate;
    function ReplaceTitle(const ATag: String; AParams: TStringList): String;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Get; override;
  end;

implementation

uses
  BrookUtils;

function TIndex.ReplaceTitle(const ATag: String; AParams: TStringList
  ): String;
begin
  Result := 'QTemplate + Brook Static File Broker Test App';
end;

constructor TIndex.Create;
begin
  inherited Create;
  FTemplate := TStdWebTemplate.Create('template.html');
  FTemplate['title'] := @ReplaceTitle;
end;

destructor TIndex.Destroy;
begin
  FTemplate.Free;
  inherited Destroy;
end;

procedure TIndex.Get;
begin
  Write(FTemplate.GetContent);
end;

initialization
  TIndex.Register('/index/', True);

end.
