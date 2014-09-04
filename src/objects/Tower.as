/**
 * Created by Goose on 9/2/14.
 */
package objects {
import starling.utils.Color;

public class Tower extends Building {
    // A simple tower that shoots arrows at bad guys
    public function Tower(x:Number=0, y:Number=0) {
        super();
        this.x = x;
        this.y = y;
        width = 32;
        height = 64;
    }

    override public function createUnitArt():void {
        addDirectionalActionClips("towerflag", Unit.FACING_DOWN, 32,64,"stand", 5, 0xFFDDDD);
        updateAnimation(action,facing);
    }
}
}
