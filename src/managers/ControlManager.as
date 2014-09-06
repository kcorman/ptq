/**
 * Created by Anastasia on 9/5/14.
 */
package managers {
import objects.Unit;

import starling.animation.IAnimatable;

/**
 * A manager that controls units behaviors, telling them to attack, etc.
 */
public class ControlManager implements IAnimatable{
    private var _units:Vector.<Unit> = new Vector.<Unit>();

    public function advanceTime(time:Number):void {
        for each(var u:Unit in _units){
            if(u.isAlive && u.exists){
                if(u.target == null){
                    u.behavior.acquireTarget(u);
                    u.issueCommand(Unit.COMMAND_ATTACK, u.behavior.target);
                }
            }
        }
    }

    public function addUnit(u:Unit) : void{
        _units.push(u);
    }

    public function removeUnit(u:Unit) : void{
        _units.splice(_units.indexOf(u)-1, 1);
    }

    public function ControlManager() {
    }
}
}
