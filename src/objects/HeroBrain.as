/**
 * Created by Anastasia on 9/6/14.
 */
package objects {
import flash.geom.Point;

import screens.InGame;

import starling.animation.IAnimatable;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;

import util.Utility;
import util.Vector2D;

public class HeroBrain extends Brain{
    protected var _dest:Vector2D = new Vector2D();
    static const TOLERANCE:Number = 10;

    public function HeroBrain(body:IControllable){
        super(body);
        InGame.instance.addEventListener(TouchEvent.TOUCH, onTouch);
    }

    protected function onTouch(event:TouchEvent) : void{
        var t:Touch = event.getTouch(InGame.instance.stage);
        if(t){
            _dest.x = t.globalX;
            _dest.y = t.globalY;
        }
    }

    override public function advanceTime(time:Number) : void{
        var difX:Number = _dest.x - _body.x;
        var difY:Number = _dest.y - _body.y;
        var mag:Number = Utility.dist(_dest, _body);
        if(Math.abs(difX) > TOLERANCE){
            _body.speed.x = _body.speed.maxMagnitude() * (difX/mag);
        }else{
            _body.speed.x = 0;
        }
        if(Math.abs(difY) > TOLERANCE){
            _body.speed.y = _body.speed.maxMagnitude() * (difY/mag);
        }else{
            _body.speed.y = 0;
        }
    }
}
}
