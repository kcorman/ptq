/**
 * Created by Goose on 9/2/14.
 */
package objects {
import screens.InGame;

import starling.animation.DelayedCall;
import starling.display.Sprite;
import starling.textures.Texture;

import starling.utils.Color;

public class Tower extends Building {

    private static var _arrow:Texture;;
    // A simple tower that shoots arrows at bad guys
    public function Tower(x:Number=0, y:Number=0) {
        super();
        this.x = x;
        this.y = y;
        width = 32;
        height = 64;
        if(null == _arrow){
            _arrow = Assets.getAtlas().getTexture("tower_stand_D_1");
        }
        /*var call:DelayedCall = new DelayedCall(function() : void {
            shoot(InGame.instance.getUnitsMatching(function(u:Unit) : Boolean{
                return (u is Hero);
            })[0]);
        }, 3);
        InGame.instance.juggler.add(call);*/
    }

    override public function attack() : void{
        super.attack();
        shoot(behavior.target);
    }

    override public function createUnitArt():void {
        addDirectionalActionClips("towerflag", Unit.FACING_DOWN, 32,64,"stand", 5, 0xFFDDDD);
        updateAnimation(action,facing);
    }

    public function shoot(target:Unit) : void{
        InGame.instance.projectileMgr.launchSingleTargetProjectile(_arrow, this, target, 8, 8, 5, 1.5);
    }
}
}
