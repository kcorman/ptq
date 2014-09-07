/**
 * Created by Goose on 9/2/14.
 */
package objects {
// The most basic enemy unit
public class Blob extends Unit{
    public function Blob(x:Number, y:Number, faction:int) {
        super(x,y, faction);
        brain.attackRange = 32;
        attackDelayTime = 2;
    }

    override public function createUnitArt():void{
        addDirectionalClips("villager", 24, 24, ["walk", "stand"], 5, 0x2222AA);
        action = "walk";
    }
}
}
