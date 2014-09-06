/**
 * Created by Goose on 8/31/14.
 */
package objects {

import flash.geom.Point;

import managers.CollisionManager;

import screens.InGame;

import starling.animation.Tween;

import starling.core.Starling;

import starling.display.MovieClip;

import starling.display.Sprite;
import starling.events.Event;
import starling.filters.ColorMatrixFilter;
import starling.textures.TextureSmoothing;
import starling.utils.Color;

import util.Vector2D;

/**
 * A parent class for all game units that can move, attack, die, etc.
 */
public class Unit extends Sprite{


    public static const dirs:Array = ["L", "D", "R", "U"];
    public static const FACING_LEFT:String = "L";
    public static const FACING_DOWN:String = "D";
    public static const FACING_RIGHT:String = "R";
    public static const FACING_UP:String = "U";
    public static const COMMAND_MOVE:String = "move";
    public static const COMMAND_PASSIVE:String = "passive";
    public static const COMMAND_ATTACK:String = "attack";

    //Should be of the form { "L" : MovieClip, "R" : MovieClip, etc. }
    protected var artClips:Object;

    private var _facing:String = FACING_DOWN;

    private var _target:Unit;

    private var _dest:Point;

    private var _attackRange:Number = 100;

    private var _action:String = "stand";

    private var invulnerable:Boolean = false;

    private var _behavior:Behavior;

    private var _attackDelayTime:Number = 1;

    protected var _timeSinceLastAttack:Number = 0;

    public var cost:int = 0;

    public var buildTime:Number = 0;

    public var isBeingBuilt:Boolean = false;

    private var _life:Number = 1;

    public var angularSpeed:Number = 0;

    public var speed:Vector2D;

    public var canMove:Boolean = true;

    public var isCollidable:Boolean = true;

    public var exists:Boolean = true;

    public var isAlive:Boolean = true;

    public function get currentCommand():String {
        return _currentCommand;
    }

    public function set currentCommand(value:String):void {
        _currentCommand = value;
    }

    private var _currentCommand:String;

    public function get behavior():Behavior {
        return _behavior;
    }

    public function set behavior(value:Behavior):void {
        _behavior = value;
    }

    public function Unit(x:Number=0, y:Number=0) {
        this.x = x;
        this.y = y;
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
        artClips = new Object();
        _behavior = new Behavior();
        _currentCommand = COMMAND_PASSIVE;
        speed = new Vector2D();
        speed.maxX = 10;
        speed.maxY = 10;
    }
    public function get target():Unit {
        return _target;
    }

    public function set target(value:Unit):void {
        _target = value;
    }

    public function get dest():Point {
        return _dest;
    }

    public function set dest(value:Point):void {
        _dest = value;
    }

    public function get attackRange():Number {
        return _attackRange;
    }

    public function set attackRange(value:Number):void {
        _attackRange = value;
    }

    public function get attackDelayTime():Number {
        return _attackDelayTime;
    }

    public function set attackDelayTime(value:Number):void {
        _attackDelayTime = value;
    }

    public function attack() : void{

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
        _timeSinceLastAttack += timePassed;
        rotation += angularSpeed * timePassed;
        if(currentCommand == COMMAND_ATTACK){
            if(_target.x < x - _attackRange){
                speed.x = -speed.maxX;
            }else if(_target.x > x + _attackRange){
                speed.x = speed.maxX;
            }else{
                speed.x = 0;
            }
            if(_target.y < y - _attackRange){
                speed.y = -speed.maxY;
            }else if(_target.y > y + _attackRange){
                speed.y = -speed.maxY;
            }else{
                speed.y = 0;
            }
            if(_timeSinceLastAttack > _attackDelayTime && target != null) {
                if (Math.abs(_target.x) - x < _attackRange && Math.abs(_target.y - y) < _attackRange) {
                    attack();
                    _timeSinceLastAttack = 0;
                }
            }
        }else if(currentCommand == COMMAND_MOVE){
            if(x < _dest.x){
                speed.x = -speed.maxX;
            }else if(x > _dest.x){
                speed.x = speed.maxX;
            }else{
                speed.x = 0;
            }
            if(y < _dest.y){
                speed.y = -speed.maxY;
            }else if(y > _dest.y){
                speed.y = speed.maxY;
            }else{
                speed.y = 0;
            }
        }

    }

    public function issueCommand(cmd:String, ...args){
        currentCommand = cmd;
        if(cmd == COMMAND_ATTACK){
            _target = args[0];
        }else if(cmd == COMMAND_MOVE){
            _dest = args[0];
        }
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

    public function get life():Number {
        return _life;
    }

    public function die() : void{
        if(invulnerable) return;
        var tw:Tween = new Tween(this, 1);
        canMove = false;
        invulnerable = true;
        tw.animate("alpha", 0);
        tw.onComplete=destroy;
        InGame.instance.juggler.add(tw);
    }

    /**
     * Immedietly destroys this object, removing it from its parent and disposing it
     */
    public function destroy() : void{
        parent.removeChild(this, true);
    }

    public function set life(value:Number):void {
        _life = value;
    }

    public function takeDamage(amount:Number) : void {
        if (!invulnerable) {
            life = life - amount;
            if (life <= 0) {
                this.die();
            }
        }
    }
}
}
