/**
 * Created by Goose on 8/31/14.
 */
package objects {

import managers.CollisionManager;

import starling.core.Starling;

import starling.display.MovieClip;

import starling.display.Sprite;
import starling.events.Event;
import starling.filters.ColorMatrixFilter;
import starling.textures.TextureSmoothing;
import starling.utils.Color;

/**
 * A parent class for all game units that can move, attack, die, etc.
 */
public class Unit extends Sprite{
    public static const dirs:Array = ["L", "D", "R", "U"];
    public static const FACING_LEFT:String = "L";
    public static const FACING_DOWN:String = "D";
    public static const FACING_RIGHT:String = "R";
    public static const FACING_UP:String = "U";

    //Should be of the form { "L" : MovieClip, "R" : MovieClip, etc. }
    protected var artClips:Object;

    private var _facing:String = FACING_DOWN;

    private var _action:String = "stand";

    public var cost:int = 0;

    public var buildTime:Number = 0;

    public var isBeingBuilt:Boolean = false;

    public var life:Number = 1;

    public var xSpeed:Number = 0;

    public var ySpeed:Number = 0;

    public var angularSpeed:Number = 0;

    public var canMove:Boolean = true;

    public var isCollidable:Boolean = true;

    public var exists:Boolean = true;

    public var isAlive:Boolean = true;


    public function Unit(x:Number=0, y:Number=0) {
        this.x = x;
        this.y = y;
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
        artClips = new Object();
    }

    private function onAddedToStage(e:Event) : void{
        this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        createUnitArt();
        facing = FACING_DOWN;
    }


    public function advanceTime(timePassed:Number, collsMgr:CollisionManager) : void {
        if(canMove) {
            collsMgr.requestMove(this, timePassed);
        }
        rotation += angularSpeed * timePassed;
    }

    public function get action():String {
        return _action;
    }

    public function set action(value:String):void {
        if(value != _action){
            if(updateAnimation(value, _facing)){
                _action = value;
            }
        }
    }

    public function get facing():String {
        return _facing;
    }

    public function set facing(value:String):void {
        // remove old clip, add new one
        if(value != _facing){
            if(updateAnimation(_action, value)){
                _facing = value;
            }
        }
    }

    protected function updateAnimation(newAction:String, newFacing:String) : Boolean {
        if(artClips[newAction] != undefined){
            if(artClips[newAction][newFacing] != undefined){
                if(artClips[_action] != undefined && artClips[_action][_facing] != undefined){
                    removeChild(artClips[_action][_facing]);
                }
                addChild(artClips[newAction][newFacing]);
                return true;
            }
        }
        return false;
    }

    public function createUnitArt() : void{

    }


    // Add clips for each direction and action, given a list of actions
    protected function addDirectionalClips(namePrefix:String, width:uint, height:uint, actions:Array, speed:Number=5, color:uint=0, x:int=0, y:int =0) : void{
        for each(var action:String in actions){
            addAllDirectionalClipsForAction(namePrefix, width, height, action, speed, color, x, y);
        }
    }

    // Add clips for each direction, given a specific action
    protected function addAllDirectionalClipsForAction(namePrefix:String, width:uint, height:uint, action:String, speed:Number=5, color:uint=0, x:int=0, y:int =0) : void{
        artClips[action] = new Object();
        for each(var dir:String in dirs){
            addDirectionalActionClips(namePrefix, dir, width, height, action, speed, color, x, y);
        }
    }

    protected function addDirectionalActionClips(namePrefix:String, dir:String, width:uint, height:uint, action:String, speed:Number=5, color:uint=0, x:int=0, y:int =0) : void{
        if(artClips[action] == undefined){
            artClips[action] = new Object();
        }
        var clip:MovieClip = new MovieClip(Assets.getAtlas().getTextures(namePrefix+"_"+action+"_"+dir), speed);
        //var filter:ColorMatrixFilter = new ColorMatrixFilter();
        //filter.adjustHue(-.3);
        //clip.filter = filter;
        clip.smoothing = TextureSmoothing.NONE;
        //clip.x = Math.ceil(-heroArt.width/2);
        //heroArt.y = Math.ceil(-heroArt.height/2);
        clip.width = width;
        clip.height = height;
        starling.core.Starling.juggler.add(clip);
        artClips[action][dir] = clip;
    }

}
}
