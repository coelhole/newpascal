//Provides classes for defining and performing operations on objects related to two-dimensional geometry.
unit NewPascal.GUI.Geom;

{$mode ObjFPC}{$H+}

interface

uses
  Classes
  ,SysUtils
  ,NewPascal.Base
  ;

const
  (* PathIterator interface constants *)
  //The winding rule constant for specifying an even-odd rule for determining the interior of a path.
  WIND_EVEN_ODD  : Int = 0;
  //The winding rule constant for specifying a non-zero rule for determining the interior of a path. The non-zero rule specifies that a point lies inside the path if a ray drawn in any direction from that point to infinity is crossed by path segments a different number of times in the counter-clockwise direction than the clockwise direction.
  WIND_NON_ZERO  : Int = 1;
  //The segment type constant for a point that specifies the starting location for a new subpath.
  SEG_MOVETO     : Int = 0;
  //The segment type constant for a point that specifies the end point of a line to be drawn from the most recently specified point.
  SEG_LINETO     : Int = 1;
  {
   The segment type constant for the pair of points that specify a quadratic parametric curve to be drawn from the most recently specified point. The curve is interpolated by solving the parametric control equation in the range (t=[0..1]) using the most recently specified (current) point (CP), the first control point (P1), and the final interpolated control point (P2). The parametric control equation for this curve is:
             P(t) = B(2,0)*CP + B(2,1)*P1 + B(2,2)*P2
             0 <= t <= 1

           B(n,m) = mth coefficient of nth degree Bernstein polynomial
                  = C(n,m) * t^(m) * (1 - t)^(n-m)
           C(n,m) = Combinations of n things, taken m at a time
                  = n! / (m! * (n-m)!)
  }
  SEG_QUADTO     : Int = 2;
  {
   The segment type constant for the set of 3 points that specify a cubic parametric curve to be drawn from the most recently specified point. The curve is interpolated by solving the parametric control equation in the range (t=[0..1]) using the most recently specified (current) point (CP), the first control point (P1), the second control point (P2), and the final interpolated control point (P3). The parametric control equation for this curve is:
              P(t) = B(3,0)*CP + B(3,1)*P1 + B(3,2)*P2 + B(3,3)*P3
              0 <= t <= 1

            B(n,m) = mth coefficient of nth degree Bernstein polynomial
                   = C(n,m) * t^(m) * (1 - t)^(n-m)
            C(n,m) = Combinations of n things, taken m at a time
                   = n! / (m! * (n-m)!)

    This form of curve is commonly known as a Bézier curve.
  }
  SEG_CUBICTO    : Int = 3;
  //The segment type constant that specifies that the preceding subpath should be closed by appending a line segment back to the point corresponding to the most recent SEG_MOVETO.
  SEG_CLOSE      : Int = 4;

type
  {
    The PathIterator interface provides the mechanism for objects that implement the Shape interface to return the geometry of their boundary by allowing a caller to retrieve the path of that boundary a segment at a time. This interface allows these objects to retrieve the path of their boundary a segment at a time by using 1st through 3rd order Bézier curves, which are lines and quadratic or cubic Bézier splines.
    Multiple subpaths can be expressed by using a "MOVETO" segment to create a discontinuity in the geometry to move from the end of one subpath to the beginning of the next.

    Each subpath can be closed manually by ending the last segment in the subpath on the same coordinate as the beginning "MOVETO" segment for that subpath or by using a "CLOSE" segment to append a line segment from the last point back to the first. Be aware that manually closing an outline as opposed to using a "CLOSE" segment to close the path might result in different line style decorations being used at the end points of the subpath. For example, the BasicStroke object uses a line "JOIN" decoration to connect the first and last points if a "CLOSE" segment is encountered, whereas simply ending the path on the same coordinate as the beginning coordinate results in line "CAP" decorations being used at the ends.
  }
  PathIterator = interface
    ['{975C542B-92E0-4E8D-956B-5F77F1B99F1D}']
    //Returns the winding rule for determining the interior of the path.
    //@returns(the winding rule)
    //@seealso(WIND_EVEN_ODD)
    //@seealso(WIND_NON_ZERO)
    function GetWindingRule : Int;
    //Tests if the iteration is complete.
    //@returns(@true if all the segments have been read; @false otherwise.)
    function IsDone : Boolean;
    //Moves the iterator to the next segment of the path forwards along the primary direction of traversal as long as there are more points in that direction.
    procedure Next;
    function CurrentSegment(Coords : DoubleArray) : Int;
  end;

  AffineTransform = class(Objct,Cloneable)
  private
    TransformType : Int;
    procedure StateError;
    class function New(const m00, m10,
                             m01, m11,
                             m02, m12
                             : Double;
                       const state
                             : Int):AffineTransform;
    function GetMatrix : DoubleArray;
    const
      TYPE_UNKNOWN             : Int = -1;
      HI_SHIFT                 : Int = 3;
      HI_IDENTITY              : Int = 0;    (* APPLY_IDENTITY << HI_SHIFT; *)
      HI_TRANSLATE             : Int = 8;    (* APPLY_TRANSLATE << HI_SHIFT; *)
      HI_SCALE                 : Int = 16;   (* APPLY_SCALE << HI_SHIFT; *)
      HI_SHEAR                 : Int = 32;   (* APPLY_SHEAR << HI_SHIFT; *)
  public
    //
    constructor Create; overload;
    constructor Create(Tx : AffineTransform); overload;
    constructor Create(const m00, m10,
                             m01, m11,
                             m02, m12
                             : Double); overload;
    constructor Create(FlatMatrix : DoubleArray); overload;
    function Clone : Objct; override;
    property FlatMatrix : DoubleArray read GetMatrix;
    const
      //
      TYPE_IDENTITY            : Int = 0;
      //
      TYPE_TRANSLATION         : Int = 1;
      //
      TYPE_UNIFORM_SCALE       : Int = 2;
      //
      TYPE_GENERAL_SCALE       : Int = 4;
      //
      TYPE_MASK_SCALE          : Int = (2 or 4);  (* (TYPE_UNIFORM_SCALE or TYPE_GENERAL_SCALE) *)
      //
      TYPE_FLIP                : Int = 64;
      //
      TYPE_QUADRANT_ROTATION   : Int = 8;
      //
      TYPE_GENERAL_ROTATION    : Int = 16;
      //
      TYPE_MASK_ROTATION       : Int = (8 or 16); (* (TYPE_QUADRANT_ROTATION or TYPE_GENERAL_ROTATION) *)
      //
      TYPE_GENERAL_TRANSFORM   : Int = 32;
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
    property ScaleX : Double read M00;
    property ScaleY : Double read M11;
    property ShearX : Double read M01;
    property ShearY : Double read M10;
    property TranslateX : Double read M02;
    property TranslateY : Double read M12;
  end;

implementation

constructor AffineTransform.Create;
begin
  inherited Create;

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
  inherited Create;

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

procedure AffineTransform.StateError;
begin
  raise Error.Create('%s: transform state missing option',['StateError']);
end;

constructor AffineTransform.Create(
            const m00, m10,
                  m01, m11,
                  m02, m12
: Double);
begin
  inherited Create;

  Self.M00 := m00;
  Self.M10 := m10;
  Self.M01 := m01;
  Self.M11 := m11;
  Self.M02 := m02;
  Self.M12 := m12;

  UpdateState;
end;

constructor AffineTransform.Create(FlatMatrix : DoubleArray);
begin
  if ( Length(FlatMatrix) <> 4 ) and ( Length(FlatMatrix) <> 6 ) then
     raise IllegalArgumentException.Create;

  inherited Create;

  M00 := FlatMatrix[0];
  M10 := FlatMatrix[1];
  M01 := FlatMatrix[2];
  M11 := FlatMatrix[3];
  M02 := 0.0;
  M12 := 0.0;

  if Length(FlatMatrix) > 5 then begin
  	M02 := FlatMatrix[4];
  	M12 := FlatMatrix[5];
  end;

  UpdateState;
end;

function AffineTransform.GetMatrix : DoubleArray;
begin
  Result := NIL;
  SetLength(Result,6);
  Result[0] := M00;
  Result[1] := M10;
  Result[2] := M01;
  Result[3] := M11;
  Result[4] := M02;
  Result[5] := M12;
end;

end.

