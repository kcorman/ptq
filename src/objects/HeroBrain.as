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
        if(_dest.x > _body.x + TOLERANCE){
            _body.speed.x = _body.speed.maxX;
        }else if(_dest.x < _body.x - TOLERANCE){
            _body.speed.x = -_body.speed.maxX;
        }else{
            _body.speed.x = 0;
        }
        if(_dest.y > _body.y + TOLERANCE){
            _body.speed.y = _body.speed.maxY;
        }else if(_dest.y < _body.y - TOLERANCE){
            _body.speed.y = -_body.speed.maxY;
        }else{
            _body.speed.y = 0;
        }
        /*if(_target == null || !_target.isAlive || !_target.exists){

        }
        if(_target == null) return;
        if(_target.x < _body.x - _attackRange){
            _body.speed.x = -_body.speed.maxX;
        }else if(_target.x > _body.x + _attackRange){
            _body.speed.x = _body.speed.maxX;
        }else{
            _body.speed.x = 0;
        }
        if(_target.y < _body.y - _attackRange){
            _body.speed.y = -_body.speed.maxY;
        }else if(_target.y > _body.y + _attackRange){
            _body.speed.y = -_body.speed.maxY;
        }else{
            _body.speed.y = 0;
        }
        if(_body.canAttack()) {
            if (Utility.dist(_body, _target) < _attackRange) {
                _body.attack(_target);
            }
        }*/
    }
}
}
