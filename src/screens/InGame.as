/**
 * Created by Goose on 8/17/14.
 */
package screens {
import managers.CollisionManager;

import objects.Engineer;

import objects.Player;
import objects.Tower;

import objects.Unit;
import objects.map.TileMapFactory;
import objects.map.Tilemap;
import starling.events.Event;
import starling.utils.Color;

public class InGame extends Screen {
    private var player:Player;

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
        player = new Player(1, Color.RED, new Engineer());
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
        tilemap = mapFact.generateMap(level, stage.stageWidth, stage.stageHeight);
        this.addChild(tilemap);
        collsMgr.addTilemap(tilemap);
        player.hero.x = stage.stageWidth/2;
        player.hero.y = stage.stageHeight/2;

        var unit:Tower = new Tower(40,40);
        addUnit(unit);
        addUnit(player.hero);
        for(var i:int=0;i<80;i++){
            addUnit(new Engineer(Math.random()*320,Math.random()*480));
        }
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
