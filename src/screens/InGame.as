/**
 * Created by Goose on 8/17/14.
 */
package screens {
import managers.CollisionManager;
import managers.ProjectileManager;

import objects.Engineer;
import objects.Hero;

import objects.Player;
import objects.Tower;

import objects.Unit;
import objects.map.TileMapFactory;
import objects.map.Tilemap;

import starling.animation.Juggler;
import starling.core.Starling;
import starling.events.Event;
import starling.utils.Color;

public class InGame extends Screen {
    private var player:Player;

    private var tilemap:Tilemap;

    private var collsMgr:CollisionManager;

    private var mapFact:TileMapFactory;

    private var units:Vector.<Unit>;

    private var level:uint = 1;

    private var _juggler:Juggler;

    private var _projectileMgr:ProjectileManager;

    public function get projectileMgr():ProjectileManager {
        return _projectileMgr;
    }

    public static var instance:InGame;

    public function InGame(level:uint=1) {
        super();
        instance = this;
        _juggler = new Juggler();
        Starling.juggler.add(_juggler);
        this.level = level;
        mapFact = new TileMapFactory();
        collsMgr = new CollisionManager();
        _projectileMgr = new ProjectileManager(this);
        units = new Vector.<Unit>;
        player = new Player(1, Color.RED, new Engineer());
    }

    override public function onAddedToStage(event:Event) : void{
        super.onAddedToStage(event);
        collsMgr.setBoundingRect(stage.getBounds(this));
        drawGame();
    }

    override public function subAdvanceTime(seconds:Number) : void{
        for each(var e:Unit in units){
            e.advanceTime(seconds, collsMgr);
        }
    }

    private function drawGame() : void {
        tilemap = mapFact.generateMap(level, stage.stageWidth, stage.stageHeight);
        this.addChild(tilemap);
        collsMgr.addTilemap(tilemap);
        player.hero.x = stage.stageWidth/2;
        player.hero.y = stage.stageHeight/2;

        var unit:Tower = new Tower(40,40);
        unit.brain.faction = 1;
        addUnit(unit);
        addUnit(player.hero);
        //for(var i:int=0;i<80;i++){
        //    addUnit(new Engineer(Math.random()*320,Math.random()*480));
        //}
    }

    public function addUnit(unit:Unit) : void{
        collsMgr.addUnit(unit);
            _juggler.add(unit.brain);

        units.push(unit);
        this.addChild(unit);
    }

    public function removeUnit(unit:Unit) : void{
        // collision manager automatically culls non existent units
        units.splice(units.indexOf(unit)-1,1);
        this.removeChild(unit);
    }

    public function disposeTemporarily() : void{
        this.visible = false;
    }

    public function initialize() : void{
        this.visible = true;
    }

    /**
     * Returns units matching a specific condition
     * @param cond
     * @return
     */
    public function getUnitsMatching(cond:Function) : Vector.<Unit> {
        var result:Vector.<Unit> = new Vector.<Unit>;
        for each(var unit:Unit in units){
            if(cond(unit)){
                result.push(unit);
            }
        }
        return result;
    }

    public function get juggler():Juggler {
        return _juggler;
    }
}
}
