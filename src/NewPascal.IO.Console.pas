unit NewPascal.IO.Console;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
  ,SysUtils
  ,NewPascal.Base
  ;

type
  Console = class sealed(Objct)
  public
    constructor Create;
    class function Instance : Console;
  end;

function ConsoleIsInstantiated : boolean;
function ThisConsole : Console;

implementation

uses
  CRT
  ,Video
  ,Keyboard
  ,Mouse
  ;

var WeHaveConsole      : boolean = false;
    ApplicationConsole : Console = null;
constructor Console.Create;
begin
  if WeHaveConsole then
     raise InstantiationException.Create('The Console is instantiated. Use Console.Instance or ThisConsole to access it.');
  inherited Create;
  ApplicationConsole := Self;
  WeHaveConsole      := true;
end;

class function Console.Instance : Console;
begin
  Result := ApplicationConsole;
end;

function ConsoleIsInstantiated : boolean;
begin
  Result := WeHaveConsole;
end;

function ThisConsole:Console;
begin
  Result := ApplicationConsole;
end;

initialization
  if isConsole then
    ApplicationConsole := Console.Create;
end.

