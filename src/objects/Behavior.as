/**
 * Created by Anastasia on 9/5/14.
 */
package objects {
import flash.geom.Vector3D;

import screens.InGame;

/**
 * A behavior object encapsulates all fields specifically related to how a unit behaves, either in terms of
 * fully computer controlled AI or simply towers shooting at bad guys
 */
public class Behavior {
    private var _faction:int = 0;

    private var _attackRange:int;

    private var _target:Unit;

    private var _isChasingTarget:Boolean;

    /**
     * A function of the form function(unit:Unit, currentTarget:Unit) : Unit
     * Takes the owner of this behavior and the current target as arguments and returns the new target
     * the unit that owns this behavior
     */
    private var targetStrategy:Function;


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

    public function acquireTarget(parent:Unit) : void {
        this.target = targetStrategy(parent,target);
    }

    public function defaultTargetStrategy(u:Unit, current:Unit) : Unit{
        var matchingUnits:Vector.<Unit> = InGame.instance.getUnitsMatching(function(matcher:Unit) : Boolean{
            return u.behavior.faction != matcher.behavior.faction &&
                    (Math.sqrt(Math.pow(u.x - matcher.x,2) + Math.pow(u.y - matcher.y, 2)) < 400);
        });
        if(matchingUnits.length < 1) return null;
        return matchingUnits[0];
    }

    public function Behavior() {
        targetStrategy = defaultTargetStrategy;
    }
}
}
