/**
 * Created by Goose on 8/17/14.
 */
package screens {
import managers.CollisionManager;

import objects.Boat;
import objects.Unit;
import objects.map.TileMapFactory;
import objects.map.Tilemap;

import starling.display.BlendMode;

import starling.display.Sprite;
import starling.events.Event;

public class InGame extends Screen {
    private var hero:Boat;

    private var tilemap:Tilemap;

    private var collsMgr:CollisionManager;

    private var mapFact:TileMapFactory;

    private var units:Vector.<Unit>;

    private var level:uint = 1;

    public function InGame(level:uint=1) {
        super();
        this.level = level;
        mapFact = new TileMapFactory();
        collsMgr = new CollisionManager();
        units = new Vector.<Unit>;
    }

    override public function onAddedToStage(event:Event) : void{
        super.onAddedToStage(event);
        drawGame();
    }

    override public function subAdvanceTime(seconds:Number) : void{
        for each(var e:Unit in units){
            e.advanceTime(seconds, collsMgr);
        }
    }

    private function drawGame() : void {
        tilemap = mapFact.generateMap(level);
        this.addChild(tilemap);
        collsMgr.addTilemap(tilemap);
        hero = new Boat();
        hero.x = stage.stageWidth/2;
        hero.y = stage.stageHeight/2;
        addUnit(hero);
    }

    public function addUnit(unit:Unit) : void{
        collsMgr.addUnit(unit);
        units.push(unit);
        this.addChild(unit);
    }

    public function removeUnit(unit:Unit) : void{
        // collision manager automatically culls non existent units
        units.splice(units.indexOf(unit),1);
        this.removeChild(unit);
    }

    public function disposeTemporarily() : void{
        this.visible = false;
    }

    public function initialize() : void{
        this.visible = true;
    }
}
}
