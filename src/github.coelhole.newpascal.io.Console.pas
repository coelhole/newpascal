unit github.coelhole.newpascal.io.Console;

{$mode ObjFPC}{$H+}

interface

uses
  github.coelhole.newpascal.base
  ;

type
  Console = class sealed(Objct)
  public
    constructor create;
    destructor destroy; override;
    class function instance : Console;
  end;

implementation

uses
  CRT
  ,Video
  ,Keyboard
  ,Mouse
  ;

var weHaveConsole      : boolean = false;
    applicationConsole : Console = null;
    canDestroy         : boolean = false;
constructor Console.create;
begin
  if weHaveConsole then
     raise UnsupportedOperationException.create('The Console is instantiated. Use Console.instance to access it.');
  inherited create;
end;

destructor Console.destroy;
begin
  if not canDestroy then
     raise UnsupportedOperationException.create('You cannot destroy the Console instance.');
end;

class function Console.instance : Console;
begin
  result := applicationConsole;
end;

initialization
  if isConsole then begin
    applicationConsole := Console.create;
    weHaveConsole      := true;
  end;
finalization
  canDestroy := true;
  applicationConsole.free;
end.

