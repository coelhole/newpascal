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

  AffineTransform = class(Objct,Cloneable)
  private
    TransformType : Int;
    class function New(const m00, m10,
                             m01, m11,
                             m02, m12
                             : Double;
                       const state
                             : Int):AffineTransform;
    const
      TYPE_UNKNOWN             : Int = -1;
      HI_SHIFT                 : Int = 3;
      HI_IDENTITY              : Int = 0;   //APPLY_IDENTITY <<  HI_SHIFT;
      HI_TRANSLATE             : Int = 8;   //APPLY_TRANSLATE << HI_SHIFT;
      HI_SCALE                 : Int = 16;  //APPLY_SCALE << HI_SHIFT;
      HI_SHEAR                 : Int = 32;  //APPLY_SHEAR << HI_SHIFT;
  protected
    M00 : Double;
    M10 : Double;
    M01 : Double;
    M11 : Double;
    M02 : Double;
    M12 : Double;
    State : Int;
    procedure UpdateState;
    const
      APPLY_IDENTITY           : Int = 0;
      APPLY_TRANSLATE          : Int = 1;
      APPLY_SCALE              : Int = 2;
      APPLY_SHEAR              : Int = 4;
  public
    constructor Create; overload;
    constructor Create(Tx : AffineTransform); overload;
    function Clone : Objct; override;
    const
      TYPE_IDENTITY            : Int = 0;
      TYPE_TRANSLATION         : Int = 1;
      TYPE_UNIFORM_SCALE       : Int = 2;
      TYPE_GENERAL_SCALE       : Int = 4;
      TYPE_MASK_SCALE          : Int = (2 or 4);    //(TYPE_UNIFORM_SCALE or TYPE_GENERAL_SCALE)
      TYPE_FLIP                : Int = 64;
      TYPE_QUADRANT_ROTATION   : Int = 8;
      TYPE_GENERAL_ROTATION    : Int = 16;
      TYPE_MASK_ROTATION       : Int = (8 or 16);   //(TYPE_QUADRANT_ROTATION or TYPE_GENERAL_ROTATION)
      TYPE_GENERAL_TRANSFORM   : Int = 32;
  end;

implementation

constructor AffineTransform.Create;
begin
  M00 := 1.0;
  M11 := 1.0;
  M01 := 0.0;
  M10 := 0.0;
  M02 := 0.0;
  M12 := 0.0;
  State := AffineTransform.APPLY_IDENTITY;
  TransformType := AffineTransform.TYPE_IDENTITY;
end;

class function AffineTransform.New(const
                         m00, m10,
                         m01, m11,
                         m02, m12 : Double;
                         const state : Int):AffineTransform;
begin
  Result := AffineTransform.Create;
  Result.M00 := m00;
  Result.M10 := m10;
  Result.M01 := m01;
  Result.M11 := m11;
  Result.M02 := m02;
  Result.M12 := m12;
  Result.State := state;
  Result.TransformType := AffineTransform.TYPE_UNKNOWN;
end;

constructor AffineTransform.Create(Tx : AffineTransform);
begin
  Self.M00 := Tx.M00;
  Self.M10 := Tx.M10;
  Self.M01 := Tx.M01;
  Self.M11 := Tx.M11;
  Self.M02 := Tx.M02;
  Self.M12 := Tx.M12;
  Self.State := Tx.State;
  Self.TransformType := Tx.TransformType;
end;

function AffineTransform.Clone : Objct;
begin
  Result := AffineTransform.Create(Self);
end;

procedure AffineTransform.UpdateState;
begin
	if (M01 = 0.0) and (M10 = 0.0) then begin
		if (M00 = 1.0) and (M11 = 1.0) then begin
			if (M02 = 0.0) and (M12 = 0.0) then begin
				State := APPLY_IDENTITY;
				TransformType := TYPE_IDENTITY;
			end else begin
				State := APPLY_TRANSLATE;
				TransformType := TYPE_TRANSLATION;
			end;
		end else begin
			if (M02 = 0.0) and (M12 = 0.0) then begin
				State := APPLY_SCALE;
				TransformType := TYPE_UNKNOWN;
			end else begin
				State := (APPLY_SCALE or APPLY_TRANSLATE);
				TransformType := TYPE_UNKNOWN;
			end;
		end;
	end else begin
		if (M00 = 0.0) and (M11 = 0.0) then begin
			if (M02 = 0.0) and (M12 = 0.0) then begin
				State := APPLY_SHEAR;
				TransformType := TYPE_UNKNOWN;
			end else begin
				State := (APPLY_SHEAR or APPLY_TRANSLATE);
				TransformType := TYPE_UNKNOWN;
			end;
		end else begin
			if (M02 = 0.0) and (M12 = 0.0) then begin
				State := (APPLY_SHEAR or APPLY_SCALE);
				TransformType := TYPE_UNKNOWN;
			end else begin
				State := (APPLY_SHEAR or APPLY_SCALE or APPLY_TRANSLATE);
				TransformType := TYPE_UNKNOWN;
			end;
		end;
	end;
end;

end.

