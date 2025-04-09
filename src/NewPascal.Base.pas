//Provides fundamental classes to NewPascal programming library.
unit NewPascal.Base;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
  ,SysUtils
  ;

const
  //an alias to @Nil constant
  Null = Nil;

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

  //an alias to @Bold(array of) @Italic(Byte)
  ByteArray = array of Byte;

  //an alias to @Bold(array of) @Italic(SByte)
  SByteArray = array of SByte;

  //an alias to @Bold(array of) @Italic(Short)
  ShortArray = array of Short;

  //an alias to @Bold(array of) @Italic(UShort)
  UShortArray = array of UShort;

  //an alias to @Bold(array of) @Italic(Int)
  IntArray = array of Int;

  //an alias to @Bold(array of) @Italic(UInt)
  UIntArray = array of UInt;

  //an alias to @Bold(array of) @Italic(Long)
  LongArray = array of Long;

  //an alias to @Bold(array of) @Italic(ULong)
  ULongArray = array of ULong;

  //an alias to @Bold(array of) @Italic(Double)
  DoubleArray = array of Double;

  //an alias to @Bold(array of) @Italic(Float)
  FloatArray = array of Float;

  //an alias to @Bold(array of) @Italic(Currency)
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

  Throwable = class(Objct)
  private
    fmessage : string;
    fhelpcontext : Int;
  public
    constructor Create(const msg : string = ''); overload;
    constructor Create(const msg : string; const args : array of const); overload;
    constructor Create(ResString : PString); overload;
    constructor Create(ResString : PString; const Args : array of const); overload;
    constructor Create(const msg : string; AHelpContext : Int); overload;
    constructor Create(const msg : string; const Args : array of const; AHelpContext : Int); overload;
    constructor Create(ResString: PString; AHelpContext : Int); overload;
    constructor Create(ResString : PString; const Args: array of const; AHelpContext : Int); overload;
    property Message : string read fmessage;
  end;
  ThrowableClass = class of Throwable;

  Exceptn = class(Throwable);
  ExceptnClass = class of Exceptn;

  Error = class(Throwable);
  ErrorClass = class of Error;

  CloneNotSupportedException = class(Exceptn);
  CloneNotSupportedExceptionClass = class of CloneNotSupportedException;

  RuntimeException = class(Exceptn);
  RuntimeExceptionClass = class of RuntimeException;

  IllegalArgumentException = class(RuntimeException);
  IllegalArgumentExceptionClass = class of IllegalArgumentException;

  ReflectiveOperationException = class(Exceptn);
  ReflectiveOperationExceptionClass = class of ReflectiveOperationException;

  ClassNotFoundException = class(ReflectiveOperationException);
  ClassNotFoundExceptionClass = class of ClassNotFoundException;

  IllegalAccessException = class(ReflectiveOperationException);
  IllegalAccessExceptionClass = class of IllegalAccessException;

  InstantiationException = class(ReflectiveOperationException);
  InstantiationExceptionClass = class of InstantiationException;

  InvocationTargetException = class(ReflectiveOperationException);
  InvocationTargetExceptionClass = class of InvocationTargetException;

  NoSuchFieldException = class(ReflectiveOperationException);
  NoSuchFieldExceptionClass = class of NoSuchFieldException;

  NoSuchMethodException = class(ReflectiveOperationException);
  NoSuchMethodExceptionClass = class of NoSuchMethodException;

operator := (obj : Objct) str : String;
operator Explicit(obj : Objct) str : String;
operator + (obj : Objct; mystr : String) str : String;
operator + (mystr : String; obj : Objct) str : String;
operator + (myint : Long; mystr : String) str : String;
operator + (mystr : String; myint : Long) str : String;
operator + (myuint : ULong; mystr : String) str : String;
operator + (mystr : String; myuint : ULong) str : String;

implementation

operator := (obj : Objct) str : String;
begin
  str := 'null';
  if Assigned(obj) then
     str := obj.ToString;
end;

operator Explicit (obj : Objct) str : String;
begin
  str := 'null';
  if Assigned(obj) then
     str := obj.ToString;
end;

operator + (obj : Objct; mystr : ansistring) str : AnsiString;
begin
  str := 'null' + mystr;
  if Assigned(obj) then
     str := obj.ToString + mystr;
end;

operator + (mystr : String; obj : Objct) str : String;
begin
  str := mystr + 'null';
  if Assigned(obj) then
     str := mystr + obj.ToString;
end;

operator + (myint : Long; mystr : String) str : String;
begin
  str := IntToStr(myint) + mystr;
end;

operator + (mystr : String; myint : Long) str : String;
begin
  str := mystr + IntToStr(myint);
end;

operator + (myuint : ULong; mystr : String) str : String;
begin
  str := IntToStr(myuint) + mystr;
end;

operator + (mystr : String; myuint : ULong) str : String;
begin
  str := mystr + IntToStr(myuint);
end;

function Objct.ToString:AnsiString;
begin
  Result := Format('%s@%s',[QualifiedClassName,LowerCase(HexStr(GetHashCode,8))]);
end;

function Objct.Clone:Objct;
begin
  Result := Objct(Null);
  raise CloneNotSupportedException.Create;
end;

constructor Throwable.Create(const msg : string = '');
begin
  inherited Create;
  fmessage := msg;
end;

constructor Throwable.Create(const msg : string; const args : array of const);
begin
  inherited Create;
  fmessage := Format(msg,args);
end;

constructor Throwable.Create(ResString: PString);
begin
 inherited Create;
 fmessage := ResString^;
end;

constructor Throwable.Create(ResString : PString; const Args : array of const);
begin
 inherited Create;
 fmessage := Format(ResString^,args);
end;

constructor Throwable.Create(const msg : string; AHelpContext : Int);
begin
 inherited Create;
 fmessage := msg;
 fhelpcontext := AHelpContext;
end;

constructor Throwable.Create(const msg : string; const Args : array of const; AHelpContext : Int);
begin
  inherited Create;
  fmessage := Format(msg,args);
  fhelpcontext := AHelpContext;
end;

constructor Throwable.Create(ResString : PString; AHelpContext : Int);
begin
  inherited Create;
  fmessage := ResString^;
  fhelpcontext := AHelpContext;
end;

constructor Throwable.Create(ResString : PString; const Args : array of const; AHelpContext : Int);
begin
  inherited Create;
  fmessage := Format(ResString^,args);
  fhelpcontext := AHelpContext;
end;

end.

