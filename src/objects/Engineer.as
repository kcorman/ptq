/**
 * Created by Goose on 9/2/14.
 */
package objects {
public class Engineer extends Hero{

    public function Engineer(x:Number=0, y:Number=0, faction:int=0) {
        super(x,y,faction);
        this.x = x;
        this.y = y;
        width = 24;
        height = 24;
    }

    override public function createUnitArt():void{
        addDirectionalClips("villager", 24, 24, ["walk", "stand"]);
        action = "walk";
    }
}
}
