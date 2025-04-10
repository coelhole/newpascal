//Provides fundamental classes to NewPascal programming library.
unit NewPascal.Base;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
  ,SysUtils
  ;

const
  //an alias to @nil constant
  null = nil;

type
  //Signed 8-bit integer. @br
  //An alias to @Italic(shortint) integer type. @br
  //See @url(https://www.freepascal.org/docs-html/current/ref/refsu4.html) and @url(https://wiki.freepascal.org/Integer).
  sbyte = shortint;

  //Signed 16-bit integer. @br
  //An alias to @Italic(smallint) integer type. @br
  //See @url(https://www.freepascal.org/docs-html/current/ref/refsu4.html) and @url(https://wiki.freepascal.org/Integer).
  short = smallint;

  //Unsigned 16-bit integer. @br
  //An alias to @Italic(word) integer type. @br
  //See @url(https://www.freepascal.org/docs-html/current/ref/refsu4.html) and @url(https://wiki.freepascal.org/Integer).
  ushort = word;

  //Signed 32-bit integer. @br
  //An alias to @Italic(int32) integer type. @br
  //See @url(https://www.freepascal.org/docs-html/current/ref/refsu4.html) and @url(https://wiki.freepascal.org/Integer).
  int = int32;

  //Unsigned 32-bit integer. @br
  //An alias to @Italic(longword) integer type. @br
  //See @url(https://www.freepascal.org/docs-html/current/ref/refsu4.html) and @url(https://wiki.freepascal.org/Integer).
  uint = longword;

  //Signed 64-bit integer. @br
  //An alias to @Italic(int64) integer type. @br
  //See @url(https://www.freepascal.org/docs-html/current/ref/refsu4.html) and @url(https://wiki.freepascal.org/Integer).
  long = int64;

  //Unsigned 64-bit integer. @br
  //An alias to @Italic(qword) integer type. @br
  //See @url(https://www.freepascal.org/docs-html/current/ref/refsu4.html) and @url(https://wiki.freepascal.org/Integer).
  ulong = qword;

  //Single-precision floating-point number. @br
  //An alias to @Italic(single) floating type. @br
  //See @url(https://www.freepascal.org/docs-html/current/ref/refsu5.html) and @url(https://wiki.freepascal.org/IEEE_754_formats).
  float = single;

  //an alias to @Bold(array of) @Italic(byte)
  ByteArray = array of byte;

  //an alias to @Bold(array of) @Italic(sbyte)
  SByteArray = array of sbyte;

  //an alias to @Bold(array of) @Italic(short)
  ShortArray = array of short;

  //an alias to @Bold(array of) @Italic(ushort)
  UShortArray = array of ushort;

  //an alias to @Bold(array of) @Italic(int)
  IntArray = array of int;

  //an alias to @Bold(array of) @Italic(uint)
  UIntArray = array of uint;

  //an alias to @Bold(array of) @Italic(long)
  LongArray = array of long;

  //an alias to @Bold(array of) @Italic(ulong)
  ULongArray = array of ulong;

  //an alias to @Bold(array of) @Italic(double)
  DoubleArray = array of double;

  //an alias to @Bold(array of) @Italic(float)
  FloatArray = array of float;

  //an alias to @Bold(array of) @Italic(currency)
  CurrencyArray = array of currency;

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
    constructor Create(ResString : PString; AHelpContext : Int); overload;
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

constructor Throwable.Create(ResString : PString);
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

