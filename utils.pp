unit Utils;

{$mode objfpc}{$H+}

interface

uses
  //ghashmap
  fgl,
  Classes, SysUtils;

type

  { TStringHash }

  TStringHash = class
    class function hash(s: String; n: Integer): Integer;
  end;

  //generic TStringHashMap<T> = class(specialize THashMap<String,T,TStringHash>) end;
  generic TStringHashMap<T> = class(specialize TFPGMap<String,T>) end;

implementation

class function TStringHash.hash(s: String; n: Integer): Integer;
var
  c: Char;
begin
  Result := 0;
  for c in s do
    Inc(Result,Ord(c));
  Result := Result mod n;
end;

end.

