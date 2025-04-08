//Provides fundamental classes to NewPascal programming library.
unit NewPascal.Base;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
  ,SysUtils
  ;

const
  //an alias to @Nil pointer constant
  Null : pointer = Nil;

type
  //an alias to @Italic(ShortInt) integer type
  SByte = ShortInt;

  //an alias to @Italic(SmallInt) integer type
  Short = SmallInt;

  //an alias to @Italic(Word) integer type
  UShort = Word;

  //an alias to @Italic(Int32) integer type
  Int = Int32;

  //an alias to @Italic(LongWord) integer type
  UInt = LongWord;

  //an alias to @Italic(Int64) integer type
  Long = Int64;

  //an alias to @Italic(QWord) integer type
  ULong = QWord;

  //an alias to @Italic(Single) floating type
  Float = Single;

  ByteArray = array of Byte;

  SByteArray = array of SByte;

  ShortArray = array of Short;

  UShortArray = array of UShort;

  IntArray = array of Int;

  UIntArray = array of UInt;

  LongArray = array of Long;

  ULongArray = array of ULong;

  DoubleArray = array of Double;

  FloatArray = array of Float;

  CurrencyArray = array of Currency;

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
  ObjctClass = class of Objct;

  Excptn = class(Objct)
  private
    fmessage : string;
  public
    constructor Create(const msg : string = ''); overload;
    constructor Create(const msg : string; const args : array of const); overload;
    property Message : string read fmessage;
  end;
  ExceptnClass = class of Excptn;

  Error = class(Excptn);
  ErrorClass = class of Error;

  CloneNotSupportedException = class(Excptn);
  CloneNotSupportedExceptionClass = class of CloneNotSupportedException;

  RuntimeException = class(Excptn);
  RuntimeExceptionClass = class of RuntimeException;

  IllegalArgumentException = class(RuntimeException);
  IllegalArgumentExceptionClass = class of IllegalArgumentException;

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
  inherited Create;
  fmessage := msg;
end;

constructor Excptn.Create(const msg : string; const args : array of const);
begin
  Create(Format(msg,args));
end;

end.

