/**
 * Created by Anastasia on 9/6/14.
 */
package util {
public class Utility {

    public function Utility() {

    }

    public static function dist(p1:Object, p2:Object) : Number{
        return Math.sqrt(Math.pow(p2.x - p1.x, 2) + Math.pow(p2.y - p1.y, 2));
    }
}
}
