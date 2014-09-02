/**
 * Created by Goose on 8/31/14.
 */
package managers {
import flash.geom.Rectangle;

import objects.Unit;
import objects.map.Tilemap;

import starling.utils.RectangleUtil;

/**
 * Class that handles all collision calculation logic inside of PTQ
 */
public class CollisionManager {
    private var bounds:Rectangle = null;

    private var tilemap:Tilemap;

    public function CollisionManager() {

    }

    public function addUnit(u:Unit) : void{

    }

    public function addTilemap(t:Tilemap) : void{
        tilemap = t;
    }

    public function setBoundingRect(rect:Rectangle) : void{

    }

    /**
     *
     * @param u the unit to move
     * @param time the time since last move
     * @param collisionCallback optional callback function if the unit collides
     */
    public function requestMove(u:Unit, time:Number, collisionCallback:Function=null) : void{

    }


}
}
