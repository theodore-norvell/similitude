package model.drawingInterface ;

import model.drawingInterface.Rectangle;
import type.Coordinate;

/**
* Represent an affine transformation between two coordinate systems
*  and its inverse transformation.
* Generally the forward transform (convert) tranforms a world point to a view point,
* while the inverse transform (invert) transforms a view point to a world point.
**/
class Transform {
    /** The two arrays are each 9 long and represent inverse matrices
    * Each matrix is represented by a 1 d array thus
    *    [ 0 1 2 ]        [m(0,0), m(0,1), m(0,2), m(1,0), m(1,1), m(1,2), m(1,0), m(2,1), m(1,2)]
    *    [ 3 4 5 ]
    *    [ 6 7 8 ]
    */
    var convertMatrix:Array<Float> ;
    var invertMatrix: Array<Float> ;

    /**
    * Precondition: The two arrays are each 9 long and represent inverse matrices
    **/
    function new(m : Array<Float> , im : Array<Float>) {
        convertMatrix = m ;
        invertMatrix = im ;
    }

    static public function identity():Transform{
        return new Transform( [1,0,0,0,1,0,0,0,1], [1,0,0,0,1,0,0,0,1] ) ;
    }

    /** Convert a point to another point using this transform */
    /**
    *   [1 0 0]   [c.x]
        [0 1 0] * [c.y]
        [0 0 1]   [1  ]
    **/
    public function pointConvert ( c : Coordinate ) : Coordinate {
        return new Coordinate(convertMatrix[0]*c.get_xPosition() + convertMatrix[1]*c.get_yPosition() + convertMatrix[2],
                                convertMatrix[3]*c.get_xPosition() + convertMatrix[4]*c.get_yPosition() + convertMatrix[5]);
    }

    /** Convert a point to another point using the inverse of this transform.
      If c' = this.convert( c ), then this.invert( c' ) = c .
     */
    public function pointInvert ( c : Coordinate ) : Coordinate {
        return new Coordinate(invertMatrix[0]*c.get_xPosition() + invertMatrix[1]*c.get_yPosition() + invertMatrix[2],
                                invertMatrix[3]*c.get_xPosition() + invertMatrix[4]*c.get_yPosition() + invertMatrix[5]);
    }

    /** Convert a Rectangle to another Rectangle using this transform */
    public function rectConvert ( c : Rectangle ) : Rectangle {
        var maxCoordinate:Coordinate =  pointConvert (c.max()) ; // {"xPosition":c.max().xPosition, "yPosition":c.max().yPosition};
        var minCoordinate:Coordinate =  pointConvert (c.min()) ; //{"xPosition":c.min().xPosition, "yPosition":c.min().yPosition};

        return new Rectangle( maxCoordinate, minCoordinate );
    }

    /** Convert a Rectangle to another Rectangle using the inverse of this transform */
    public function rectInvert ( c : Rectangle ) : Rectangle {
        var maxCoordinate:Coordinate = pointInvert( c.max() );
        var minCoordinate:Coordinate = pointInvert( c.min() );

        return new Rectangle( maxCoordinate, minCoordinate );
    }

    /** Produce another transform that is like this one, but scaled by xRatio in the x direction and yRation in the y direction.
     * So if  c' = this.convert( c ) and c'' = this.scale( xR, yR ).convert( c ), then
     * c''.x = c'.x * xR and c''.y = c'.y * yR
     *
     * 3 by 3 Matrix
     *
     * [1 0 0]   [xRatio 0      0]
     * [0 1 0] * [0      yRatio 0]
     * [0 0 1]   [0      0      1]
     */
    public function scale( xRatio : Float, yRatio : Float ) : Transform {
        var scaleArray:Array<Float> = [xRatio,0,0,0,yRatio,0,0,0,1];
        var invScaleArray:Array<Float> = [1/xRatio,0,0,0,1/yRatio,0,0,0,1];
        return new Transform(  multiply(scaleArray, convertMatrix), multiply( invertMatrix, invScaleArray ));
    }

    /** Produce another transform that is like this one, but shifted  by xDelta in the x direction and yDelta in the y direction.
     * So if  c' = this.convert( c ) and c'' = this.translate( xDelta, yDelta ).convert( c ), then
     * c''.x = c'.x + xDelta and c''.y = c'.y + yDelta
     * Precondition: xRatio and yRatio are both finite and not 0.
     *
     *  [1      0      xDelta]
        [0      1      yDelta]
        [0      0      1]
     */
    public function translate( xDelta : Float, yDelta : Float ) : Transform {
        var translateArray:Array<Float> = [1,0,xDelta,0,1,yDelta,0,0,1];
        var invTranslateArray:Array<Float> = [1,0,-xDelta,0,1,-yDelta,0,0,1];
        return new Transform(  multiply(translateArray, convertMatrix), multiply( invertMatrix, invTranslateArray ) ) ;
    }

    /** Produce another transform that is like this one, but rotated by n * pi/2 radians clockwise.
     * So if  c' = this.convert( c ) and c'' = this.quadrantRotate( xDelta, yDelta ).convert( c ),
     * then c''.x = c'.x cos theta - c'.y sin theta and c''.y = c'.x sin theta + c'.y cos theta
     * where theta = n * pi / 2.
     * Precondition 0 <= n < 4.
     *
     * this function will be implemented later
     */
    public function quadrantRotate( n : Int ) : Transform {
        return null; // TODO
    }

    /** Produce another transform that is the composition of another transform with this one.
     * If c' = this.convert( c ) and c'' = this.compose( other ).convert( c ),
     * then c'' = other.convert( c' )
     */
    public function compose( other : Transform ) : Transform {

        return new Transform( multiply( other.convertMatrix, convertMatrix ), multiply( invertMatrix, other.invertMatrix ) ) ;
    }

    /**
    * only support (n*n matrix) * (n*n matrix)
    **/
    public function multiply(matrix1 : Array<Float>, matrix2:Array<Float>):Array<Float>{
        var n:Int = 3 ;
        var tempArray:Array<Float> = new Array<Float>();
        //initialize the matrix
        for(i in 0...n){
            for(j in 0...n){
                tempArray[n*i + j] = 0;
            }
        }
        //end

        for(i in 0...n){
            for(j in 0...n){
                for(k in 0...n){
                    tempArray[n * i +j] += matrix1[n * i + k] * matrix2[n * k + j];
                }
            }
        }
        return tempArray;
    }
}
