/**
 * Created by Anastasia on 9/5/14.
 */
package objects {
import flash.geom.Vector3D;

import screens.InGame;

import starling.animation.IAnimatable;

import util.Utility;

/**
 * A brain object encapsulates all fields specifically related to how a unit behaves, either in terms of
 * fully computer controlled AI or simply towers shooting at bad guys
 */
public class Brain implements IAnimatable {
    protected var _faction:int = 0;

    protected var _attackRange:int;

    protected var _target:Unit;

    protected var _isChasingTarget:Boolean;

    protected var _body:IControllable;

    /**
     * A function of the form function(unit:Unit, currentTarget:Unit) : Unit
     * Takes the owner of this behavior and the current target as arguments and returns the new target
     * the unit that owns this behavior
     */
    protected var targetStrategy:Function;


    public function get faction():int {
        return _faction;
    }

    public function set faction(value:int):void {
        _faction = value;
    }

    public function get attackRange():int {
        return _attackRange;
    }

    public function set attackRange(value:int):void {
        _attackRange = value;
    }

    public function get target():Unit {
        return _target;
    }

    public function set target(value:Unit):void {
        _target = value;
    }

    public function get isChasingTarget():Boolean {
        return _isChasingTarget;
    }

    public function set isChasingTarget(value:Boolean):void {
        _isChasingTarget = value;
    }

    public function acquireTarget() : void {
        this.target = targetStrategy(_body,target);
    }

    public function defaultTargetStrategy(u:IControllable, current:Unit) : Unit{
        var matchingUnits:Vector.<Unit> = InGame.instance.getUnitsMatching(function(matcher:Unit) : Boolean{
            return u.brain.faction != matcher.brain.faction &&
                    (Math.sqrt(Math.pow(u.x - matcher.x,2) + Math.pow(u.y - matcher.y, 2)) < 400);
        });
        if(matchingUnits.length < 1) return null;
        return matchingUnits[0];
    }

    public function Brain(body:IControllable) {
        targetStrategy = defaultTargetStrategy;
        _body = body;
        _attackRange = 300;
    }

    public function advanceTime(time:Number):void {
        if(_target == null || !_target.isAlive || !_target.exists){
            acquireTarget();
        }
        if(_target == null) return;
        var difX:Number = _target.x - _body.x;
        var difY:Number = _target.y - _body.y;
        var mag:Number = Utility.dist(_target, _body);
        if(Math.abs(difX) > _attackRange * (difX/mag)){
            _body.speed.x = _body.speed.maxMagnitude() * (difX/mag);
        }else{
            _body.speed.x = 0;
        }
        if(Math.abs(difY) > _attackRange * (difY/mag)){
            _body.speed.y = _body.speed.maxMagnitude() * (difY/mag);
        }else{
            _body.speed.y = 0;
        }
        if(_body.canAttack()) {
            if (Utility.dist(_body, _target) < _attackRange) {
                _body.attack(_target);
            }
        }
    }
}

}
