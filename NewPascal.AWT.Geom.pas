unit NewPascal.AWT.Geom;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
  ,SysUtils
  ,NewPascal.Base
  ;

const
  {PathIterator interface}
  WIND_EVEN_ODD  : Int = 0;
  WIND_NON_ZERO  : Int = 1;
  SEG_MOVETO     : Int = 0;
  SEG_LINETO     : Int = 1;
  SEG_QUADTO     : Int = 2;
  SEG_CUBICTO    : Int = 3;
  SEG_CLOSE      : Int = 4;

type
  PathIterator = interface
    ['{975C542B-92E0-4E8D-956B-5F77F1B99F1D}']
    function GetWindingRule : Int;
    function IsDone : Boolean;
    procedure Next;
    function CurrentSegment(Coords : FloatArray)  : Int; overload;
    function CurrentSegment(Coords : DoubleArray) : Int; overload;
  end;

implementation

end.

