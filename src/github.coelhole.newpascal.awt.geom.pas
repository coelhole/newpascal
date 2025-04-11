{
 Provides classes for defining and performing operations on objects related to two-dimensional geometry.

 See also: @url(https://docs.oracle.com/javase/7/docs/api/java/awt/geom/package-summary.html package java.awt.geom (Java API)).
}
unit github.coelhole.newpascal.awt.geom;

{$mode ObjFPC}{$H+}

interface

uses
  github.coelhole.newpascal.base
  ;

const
  (* PathIterator interface constants *)
  //The winding rule constant for specifying an even-odd rule for determining the interior of a path.
  WIND_EVEN_ODD  : int = 0;
  //The winding rule constant for specifying a non-zero rule for determining the interior of a path. The non-zero rule specifies that a point lies inside the path if a ray drawn in any direction from that point to infinity is crossed by path segments a different number of times in the counter-clockwise direction than the clockwise direction.
  WIND_NON_ZERO  : int = 1;
  //The segment type constant for a point that specifies the starting location for a new subpath.
  SEG_MOVETO     : int = 0;
  //The segment type constant for a point that specifies the end point of a line to be drawn from the most recently specified point.
  SEG_LINETO     : int = 1;
  {
   The segment type constant for the pair of points that specify a quadratic parametric curve to be drawn from the most recently specified point. The curve is interpolated by solving the parametric control equation in the range (t=[0..1]) using the most recently specified (current) point (CP), the first control point (P1), and the final interpolated control point (P2). The parametric control equation for this curve is:
             P(t) = B(2,0)*CP + B(2,1)*P1 + B(2,2)*P2
             0 <= t <= 1

           B(n,m) = mth coefficient of nth degree Bernstein polynomial
                  = C(n,m) * t^(m) * (1 - t)^(n-m)
           C(n,m) = Combinations of n things, taken m at a time
                  = n! / (m! * (n-m)!)
  }
  SEG_QUADTO     : int = 2;
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
  SEG_CUBICTO    : int = 3;
  //The segment type constant that specifies that the preceding subpath should be closed by appending a line segment back to the point corresponding to the most recent SEG_MOVETO.
  SEG_CLOSE      : int = 4;

type
  {
    The PathIterator interface provides the mechanism for objects that implement the Shape interface to return the geometry of their boundary by allowing a caller to retrieve the path of that boundary a segment at a time. This interface allows these objects to retrieve the path of their boundary a segment at a time by using 1st through 3rd order Bézier curves, which are lines and quadratic or cubic Bézier splines.
    Multiple subpaths can be expressed by using a "MOVETO" segment to create a discontinuity in the geometry to move from the end of one subpath to the beginning of the next.

    Each subpath can be closed manually by ending the last segment in the subpath on the same coordinate as the beginning "MOVETO" segment for that subpath or by using a "CLOSE" segment to append a line segment from the last point back to the first. Be aware that manually closing an outline as opposed to using a "CLOSE" segment to close the path might result in different line style decorations being used at the end points of the subpath. For example, the BasicStroke object uses a line "JOIN" decoration to connect the first and last points if a "CLOSE" segment is encountered, whereas simply ending the path on the same coordinate as the beginning coordinate results in line "CAP" decorations being used at the ends.

    See also: @url(https://docs.oracle.com/javase/7/docs/api/java/awt/geom/PathIterator.html interface java.awt.geom.PathIterator (Java API)).
  }
  PathIterator = interface
    ['{975C542B-92E0-4E8D-956B-5F77F1B99F1D}']
    //Returns the winding rule for determining the interior of the path.
    //@returns(the winding rule)
    //@seealso(WIND_EVEN_ODD)
    //@seealso(WIND_NON_ZERO)
    function windingRule : int;
    //Tests if the iteration is complete.
    //@returns(@true if all the segments have been read; @false otherwise.)
    function isDone : boolean;
    //Moves the iterator to the next segment of the path forwards along the primary direction of traversal as long as there are more points in that direction.
    procedure next;
    //Returns the coordinates and type of the current path segment in the iteration. The return value is the path-segment type: @link(SEG_MOVETO), @link(SEG_LINETO), @link(SEG_QUADTO), @link(SEG_CUBICTO), or @link(SEG_CLOSE). A double array of length 6 must be passed in and can be used to store the coordinates of the point(s). Each point is stored as a pair of double x,y coordinates. @link(SEG_MOVETO) and @link(SEG_LINETO) types returns one point, @link(SEG_QUADTO) returns two points, @link(SEG_CUBICTO) returns 3 points and @link(SEG_CLOSE) does not return any points.
    //@param(coords an array that holds the data returned from this method)
    //@returns(the path-segment type of the current path segment)
    function currentSegment(out coords : DoubleArray) : int;
  end;

  AffineTransform = class(Objct,Cloneable)
  private
    transformType : int;
    procedure stateError;
    class function new(const m00, m10,
                             m01, m11,
                             m02, m12
                             : double;
                       const state
                             : int):AffineTransform;
    function getFlatMatrix : DoubleArray;
    const
      TYPE_UNKNOWN             : int = -1;
      HI_SHIFT                 : int = 3;
      HI_IDENTITY              : int = 0;    (* APPLY_IDENTITY << HI_SHIFT; *)
      HI_TRANSLATE             : int = 8;    (* APPLY_TRANSLATE << HI_SHIFT; *)
      HI_SCALE                 : int = 16;   (* APPLY_SCALE << HI_SHIFT; *)
      HI_SHEAR                 : int = 32;   (* APPLY_SHEAR << HI_SHIFT; *)
  public
    //
    constructor create; overload;
    constructor create(Tx : AffineTransform); overload;
    constructor create(const m00, m10,
                             m01, m11,
                             m02, m12
                             : double); overload;
    constructor create(flatMatrix : DoubleArray); overload;
    function clone : Objct; override;
    property flatMatrix : DoubleArray read getFlatMatrix;
    const
      //
      TYPE_IDENTITY            : int = 0;
      //
      TYPE_TRANSLATION         : int = 1;
      //
      TYPE_UNIFORM_SCALE       : int = 2;
      //
      TYPE_GENERAL_SCALE       : int = 4;
      //
      TYPE_MASK_SCALE          : int = (2 or 4);  (* (TYPE_UNIFORM_SCALE or TYPE_GENERAL_SCALE) *)
      //
      TYPE_FLIP                : int = 64;
      //
      TYPE_QUADRANT_ROTATION   : int = 8;
      //
      TYPE_GENERAL_ROTATION    : int = 16;
      //
      TYPE_MASK_ROTATION       : int = (8 or 16); (* (TYPE_QUADRANT_ROTATION or TYPE_GENERAL_ROTATION) *)
      //
      TYPE_GENERAL_TRANSFORM   : int = 32;
  protected
    m00 : double;
    m10 : double;
    m01 : double;
    m11 : double;
    m02 : double;
    m12 : double;
    state : int;
    procedure updateState;
    const
      APPLY_IDENTITY           : int = 0;
      APPLY_TRANSLATE          : int = 1;
      APPLY_SCALE              : int = 2;
      APPLY_SHEAR              : int = 4;
  public
    property scaleX : double read m00;
    property scaleY : double read m11;
    property shearX : double read m01;
    property shearY : double read m10;
    property translateX : double read m02;
    property translateY : double read m12;
  end;

implementation

constructor AffineTransform.create;
begin
  inherited create;

  m00 := 1.0;
  m11 := 1.0;
  m01 := 0.0;
  m10 := 0.0;
  m02 := 0.0;
  m12 := 0.0;

  state := AffineTransform.APPLY_IDENTITY;

  transformType := AffineTransform.TYPE_IDENTITY;
end;

class function AffineTransform.new(const
                         m00, m10,
                         m01, m11,
                         m02, m12 : double;
                         const state : int):AffineTransform;
begin
  result := AffineTransform.create;

  result.m00 := m00;
  result.m10 := m10;
  result.m01 := m01;
  result.m11 := m11;
  result.m02 := m02;
  result.m12 := m12;

  result.state := state;

  result.transformType := AffineTransform.TYPE_UNKNOWN;
end;

constructor AffineTransform.create(Tx : AffineTransform);
begin
  inherited create;

  self.m00 := Tx.m00;
  self.m10 := Tx.m10;
  self.m01 := Tx.m01;
  self.m11 := Tx.m11;
  self.m02 := Tx.m02;
  self.m12 := Tx.m12;

  self.state := Tx.state;

  self.transformType := Tx.transformType;
end;

function AffineTransform.clone : Objct;
begin
  result := AffineTransform.create(self);
end;

procedure AffineTransform.updateState;
begin
	if (m01 = 0.0) and (m10 = 0.0) then begin
		if (m00 = 1.0) and (m11 = 1.0) then begin
			if (m02 = 0.0) and (m12 = 0.0) then begin
				state := APPLY_IDENTITY;
				transformType := TYPE_IDENTITY;
			end else begin
				state := APPLY_TRANSLATE;
				transformType := TYPE_TRANSLATION;
			end;
		end else begin
			if (m02 = 0.0) and (m12 = 0.0) then begin
				state := APPLY_SCALE;
				transformType := TYPE_UNKNOWN;
			end else begin
				state := (APPLY_SCALE or APPLY_TRANSLATE);
				transformType := TYPE_UNKNOWN;
			end;
		end;
	end else begin
		if (m00 = 0.0) and (m11 = 0.0) then begin
			if (m02 = 0.0) and (m12 = 0.0) then begin
				state := APPLY_SHEAR;
				transformType := TYPE_UNKNOWN;
			end else begin
				state := (APPLY_SHEAR or APPLY_TRANSLATE);
				transformType := TYPE_UNKNOWN;
			end;
		end else begin
			if (m02 = 0.0) and (m12 = 0.0) then begin
				state := (APPLY_SHEAR or APPLY_SCALE);
				transformType := TYPE_UNKNOWN;
			end else begin
				state := (APPLY_SHEAR or APPLY_SCALE or APPLY_TRANSLATE);
				transformType := TYPE_UNKNOWN;
			end;
		end;
	end;
end;

procedure AffineTransform.stateError;
begin
  raise Error.create('%s: transform state missing option',['stateError']);
end;

constructor AffineTransform.create(
            const m00, m10,
                  m01, m11,
                  m02, m12
: Double);
begin
  inherited create;

  self.m00 := m00;
  self.m10 := m10;
  self.m01 := m01;
  self.m11 := m11;
  self.m02 := m02;
  self.m12 := m12;

  updateState;
end;

constructor AffineTransform.create(flatMatrix : DoubleArray);
begin
  if ( length(flatMatrix) <> 4 ) and ( length(flatMatrix) <> 6 ) then
     raise IllegalArgumentException.create('%s length: %d', ['flatMatrix', length(flatMatrix)]);

  inherited create;

  m00 := flatMatrix[0];
  m10 := flatMatrix[1];
  m01 := flatMatrix[2];
  m11 := flatMatrix[3];
  m02 := 0.0;
  m12 := 0.0;

  if length(flatMatrix) > 5 then begin
  	m02 := flatMatrix[4];
  	m12 := flatMatrix[5];
  end;

  updateState;
end;

function AffineTransform.getFlatMatrix : DoubleArray;
begin
  result := null;

  setLength(result, 6);

  result[0] := m00;
  result[1] := m10;
  result[2] := m01;
  result[3] := m11;
  result[4] := m02;
  result[5] := m12;
end;

end.
