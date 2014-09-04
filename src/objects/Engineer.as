/**
 * Created by Goose on 9/2/14.
 */
package objects {
public class Engineer extends Hero{

    public function Engineer(x:Number=0, y:Number=0) {
        super();
        this.x = x;
        this.y = y;
    }

    override public function createUnitArt():void{
        addDirectionalClips("villager", 24, 24, ["walk", "stand"]);
        action = "walk";
    }
}
}
