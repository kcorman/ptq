/**
 * Created by Anastasia on 9/4/14.
 */
package managers {
import flash.external.ExternalInterface;

import objects.Unit;

import screens.InGame;

import starling.animation.IAnimatable;
import starling.animation.Tween;
import starling.display.Image;
import starling.textures.Texture;
import starling.utils.Color;

/**
 * A class that manages projectiles in-flight
 * This only handles projectiles that go to their target destination and do something. For projectiles
 * that can damage anything in their path, you must handle those seperately
 */
public class ProjectileManager implements IAnimatable{
    private var gameState:InGame;

    public function ProjectileManager(state:InGame) {
        gameState = state;
    }

    public function advanceTime(time:Number):void {
    }

    public function launchSingleTargetProjectile(img:Texture, src:Unit, target:Unit, width:int, height:int, damage:int, time:Number) : void{
        var proj:Image = new Image(img);
        proj.x=src.x
        proj.y = src.y;
        var t:Tween = new Tween(proj,time);
        t.moveTo(target.x, target.y);
        gameState.addChild(proj);
        t.repeatCount = 1;
        t.onComplete = damageAndDestroy;
        t.onCompleteArgs = [t, target, damage];
        gameState.juggler.add(t);
    }

    public function damageAndDestroy(src:Tween, target:Unit, damage:int) : void{
        Image(src.target).color = Color.RED;
        InGame.instance.removeChild(Image(src.target));
        if(target.bounds.intersects(Image(src.target).bounds)){
            target.takeDamage(damage);
        }
    }
}
}
