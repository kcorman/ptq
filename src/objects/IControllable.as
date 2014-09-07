/**
 * Created by Anastasia on 9/6/14.
 */
package objects {
import util.Vector2D;

public interface IControllable {
    function get x() : Number;

    function get y() : Number;

    function get speed() : Vector2D;

    function get canMove() : Boolean;

    function get brain() : Brain;

    function attack(target:Unit) : void;

    function canAttack() : Boolean;

    // placeholder
    function useAbility() : void;
}
}
