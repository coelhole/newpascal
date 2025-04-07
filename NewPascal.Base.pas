unit NewPascal.Base;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
  ,SysUtils
  ;

const
  Null : pointer = Nil;

type
  Short = SmallInt;

  Int = Int32;

  Long = Int64;

  Float = Single;

  ShortArray = array of Short;

  IntArray = array of Int;

  LongArray = array of Long;

  DoubleArray = array of Double;

  FloatArray = array of Float;

  Objct = class;

  Cloneable = interface
    ['{98649980-45DA-459C-A6B1-0B6D6C506C93}']
    function Clone : Objct;
  end;

  Objct = class(TInterfacedObject)
  protected
    function Clone : Objct; virtual;
  public
    function ToString : AnsiString; override;
  end;

  Excptn = class(Exception)
  public
    constructor Create(const msg : string = '');
  end;

  CloneNotSupportedException = class(Excptn);

  RuntimeException = class(Excptn);

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

