/**
 * Created by Goose on 9/2/14.
 */
package objects {
/**
 * A building is a special type of unit which can be built
 */
public class Building extends Unit{

    public function Building(x:Number=0, y:Number=0) {
        super();
        this.x = x;
        this.y = y;
        this.canMove = false;
        xSpeed = 0;
        ySpeed = 0;
    }


}
}
