/**
 * Created by Anastasia on 9/5/14.
 */
package util {
public class Vector2D {
    private var _x:Number;
    private var _y:Number;

    public var maxX:Number;
    public var maxY:Number;

    public function get x():Number {
        return _x;
    }

    public function set x(value:Number):void {
        _x = value;
    }

    public function get y():Number {
        return _y;
    }

    public function set y(value:Number):void {
        _y = value;
    }

    public function Vector2D(x:Number = 0, y:Number = 0) {
        _x = x;
        _y = y;
    }

    public function get magnitude() : Number{
        return Math.sqrt(x*x + y*y);
    }

    public function maxMagnitude() : Number{
        return Math.sqrt(maxX * maxX + maxY * maxY);
    }
}
}
