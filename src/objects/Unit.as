/**
 * Created by Goose on 8/31/14.
 */
package objects {

import managers.CollisionManager;

import starling.core.Starling;

import starling.display.MovieClip;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.TextureSmoothing;

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

    public var life:Number = 1;

    public var xSpeed:Number = 0;

    public var ySpeed:Number = 0;

    public var angularSpeed:Number = 0;

    public var canMove:Boolean = true;

    public var isCollidable:Boolean = true;

    public var exists:Boolean = true;

    public var isAlive:Boolean = true;

    public function Unit() {
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
        artClips = new Object();
    }

    private function onAddedToStage(e:Event) : void{
        this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }


    public function advanceTime(timePassed:Number, collsMgr:CollisionManager) : void {
        if(canMove) {
            collsMgr.requestMove(this, timePassed);
        }
        rotation += angularSpeed * timePassed;
    }

    public function get facing():String {
        return _facing;
    }

    public function set facing(value:String):void {
        // remove old clip, add new one
        if(value != _facing){
            if(artClips[value] == undefined){
                return; //do nothing if we don't have an animation for it
            }
            removeChild(artClips[_facing]);
            addChild(artClips[value]);
            _facing = value;
        }
    }

    protected function addAllDirectionalClips(namePrefix:String, width:uint, height:uint, speed:Number=5, x:int=0, y:int =0) : void{
        for each(var dir:String in dirs){
            var clip:MovieClip = new MovieClip(Assets.getAtlas().getTextures(namePrefix+"_"+dir), speed);
            clip.smoothing = TextureSmoothing.NONE;
            //clip.x = Math.ceil(-heroArt.width/2);
            //heroArt.y = Math.ceil(-heroArt.height/2);
            clip.width = width;
            clip.height = height;
            starling.core.Starling.juggler.add(clip);
            artClips[dir] = clip;
        }
        addChild(artClips[dirs[0]]);
    }
}
}
