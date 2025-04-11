//Provides fundamental classes to NewPascal programming library.
unit github.coelhole.newpascal.base;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
  ;

const
  //An alias to @nil constant.
  //See @url(https://wiki.freepascal.org/Nil).
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

  //an alias to @Bold(array of) @Italic(int8)
  Int8Array = array of int8;

  //an alias to @Bold(array of) @Italic(uint8)
  UInt8Array = array of uint8;

  //an alias to @Bold(array of) @Italic(int16)
  Int16Array = array of int16;

  //an alias to @Bold(array of) @Italic(uint16)
  UInt16Array = array of uint16;

  //an alias to @Bold(array of) @Italic(int32)
  Int32Array = array of int32;

  //an alias to @Bold(array of) @Italic(uint32)
  UInt32Array = array of uint32;

  //an alias to @Bold(array of) @Italic(int64)
  Int64Array = array of int64;

  //an alias to @Bold(array of) @Italic(uint64)
  UInt64Array = array of uint64;

  //an alias to @Bold(array of) @Italic(float)
  FloatArray = array of float;

  //an alias to @Bold(array of) @Italic(double)
  DoubleArray = array of double;

  //an alias to @Bold(array of) @Italic(currency)
  CurrencyArray = array of currency;

  //an alias to @Bold(array of) @Italic(comp)
  CompArray = array of comp;

  Objct = class;

  Cloneable = interface
    ['{98649980-45DA-459C-A6B1-0B6D6C506C93}']
    function clone : Objct;
  end;

  Objct = class(TInterfacedObject)
  protected
    function clone : Objct; virtual;
  public
    function toString : string; override;
  end;
  ObjctClass = class of Objct;

  Throwable = class(Objct)
  private
    fMessage : string;
    fHelpContext : int;
  public
    constructor create(const msg : string = ''); overload;
    constructor create(const msg : string; const args : array of const); overload;
    constructor create(resString : PString); overload;
    constructor create(resString : PString; const args : array of const); overload;
    constructor create(const msg : string; hlpContxt : int); overload;
    constructor create(const msg : string; const args : array of const; hlpContxt : int); overload;
    constructor create(resString : PString; hlpContxt : int); overload;
    constructor create(resString : PString; const args: array of const; hlpContxt : int); overload;
    property message : string read fMessage;
    property helpContext : int read fHelpContext;
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

  UnsupportedOperationException = class(RuntimeException);
  UnsupportedOperationExceptionClass = class of UnsupportedOperationException;

operator := (myObject : TObject) stringResult : string;
operator explicit(myObject : TObject) stringResult : string;
operator + (myObject : TObject; myString : string) stringResult : string;
operator + (myString : string; myObject : TObject) stringResult : string;
operator + (myInteger : long; myString : string) stringResult : string;
operator + (myString : string; myInteger : long) stringResult : string;
operator + (myUnsignedInteger : ulong; myString : string) stringResult : string;
operator + (myString : string; myUnsignedInteger : ulong) stringResult : string;

implementation

uses
  SysUtils;

operator := (myObject : TObject) stringResult : string;
begin
  stringResult := 'null';
  if assigned(myObject) then
     stringResult := myObject.toString;
end;

operator explicit (myObject : TObject) stringResult : string;
begin
  stringResult := 'null';
  if assigned(myObject) then
     stringResult := myObject.toString;
end;

operator + (myObject : TObject; myString : string) stringResult : string;
begin
  stringResult := 'null' + myString;
  if assigned(myObject) then
     stringResult := myObject.toString + myString;
end;

operator + (myString : string; myObject : TObject) stringResult : string;
begin
  stringResult := myString + 'null';
  if assigned(myObject) then
     stringResult := myString + myObject.toString;
end;

operator + (myInteger : long; myString : string) stringResult : string;
begin
  stringResult := intToStr(myInteger) + myString;
end;

operator + (myString : string; myInteger : long) stringResult : string;
begin
  stringResult := myString + intToStr(myInteger);
end;

operator + (myUnsignedInteger : ulong; myString : string) stringResult : string;
begin
  stringResult := intToStr(myUnsignedInteger) + myString;
end;

operator + (myString : string; myUnsignedInteger : ulong) stringResult : string;
begin
  stringResult := myString + intToStr(myUnsignedInteger);
end;

function Objct.toString : string;
begin
  result := format('%s@%s', [qualifiedClassName, lowerCase(hexStr(getHashCode, 8))]);
end;

function Objct.clone : Objct;
begin
  result := Objct(null);
  raise CloneNotSupportedException.create;
end;

constructor Throwable.create(const msg : string = '');
begin
  inherited create;
  fMessage := msg;
  fHelpContext :=0 ;
end;

constructor Throwable.create(const msg : string; const args : array of const);
begin
  inherited create;
  fMessage := format(msg, args);
  fHelpContext := 0;
end;

constructor Throwable.create(resString : PString);
begin
 inherited create;
 fMessage := resString^;
 fHelpContext := 0;
end;

constructor Throwable.create(resString : PString; const args : array of const);
begin
 inherited create;
 fMessage := format(resString^, args);
 fHelpContext := 0;
end;

constructor Throwable.create(const msg : string; hlpContxt : int);
begin
 inherited create;
 fMessage := msg;
 fHelpContext := hlpContxt;
end;

constructor Throwable.create(const msg : string; const args : array of const; hlpContxt : int);
begin
  inherited create;
  fMessage := format(msg, args);
  fHelpContext := hlpContxt;
end;

constructor Throwable.create(resString : PString; hlpContxt : int);
begin
  inherited create;
  fMessage := resString^;
  fHelpContext := hlpContxt;
end;

constructor Throwable.create(resString : PString; const args : array of const; hlpContxt : int);
begin
  inherited create;
  fMessage := format(resString^, args);
  fHelpContext := hlpContxt;
end;

end.

