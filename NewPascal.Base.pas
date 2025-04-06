unit NewPascal.Base;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  Objct = class(TInterfacedObject)
  protected
    function Clone:Objct; virtual;
  public
    function ToString:AnsiString; override;
  end;

  Excptn = class(Exception)
  public
    constructor Create(const msg : string = '');
  end;

  CloneNotSupportedException = class(Excptn);

implementation

function Objct.ToString:AnsiString;
begin
  Result := Format('%s@%s',[QualifiedClassName,LowerCase(HexStr(GetHashCode,8))]);
end;

function Objct.Clone:Objct;
begin
  Result := Nil;
  raise CloneNotSupportedException.Create;
end;

constructor Excptn.Create(const msg : string = '');
begin
  inherited Create(msg);
end;

end.

