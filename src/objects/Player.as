/**
 * Created by Anastasia on 9/1/14.
 */
package objects {
/**
 * This is not an object that will show up visibly in a game. Rather, a player
 * keeps track of what is owned by a player (ie resources and units)
 */
public class Player {

    // The number of this player
    private var number:uint;

    // The color of this player
    private var color:uint;

    public function get name():String {
        return _name;
    }

    // The name of this player
    private var _name:String;

    // The ID of this player
    private var id:String;

    // The unit controlled by this player
    private var _hero:Unit;
    
    public function Player(number:uint, color:uint, hero:Unit = null, name:String="Anonymous", id:String=null) {
        this.number = number;
        this.color = color;
        this._hero = hero;
        this._name = name;
        this.id = id;
    }

    public function get hero():Unit {
        return _hero;
    }

    public function set hero(value:Unit):void {
        _hero = value;
    }
}
}
