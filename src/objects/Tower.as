/**
 * Created by Goose on 9/2/14.
 */
package objects {
public class Tower extends Building {
    // A simple tower that shoots arrows at bad guys
    public function Tower(x:Number=0, y:Number=0) {
        super();
        this.x = x;
        this.y = y;
        width = 16;
        height = 32;
    }

    override public function createUnitArt():void {
        addDirectionalActionClips("tower", Unit.FACING_DOWN, 16,32,"stand");
        updateAnimation(action,facing);
    }
}
}
