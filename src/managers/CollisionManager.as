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
        bounds = new Rectangle(0, 0, 1200, 1200);
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
        if(!u.canMove) return;
        //TODO implement actual collision detection
        u.x += u.speed.x * time;
        u.y += u.speed.y * time;
        if(u.x > bounds.right - u.width){
            u.x = bounds.right - u.width;
        }else if(u.x < bounds.left){
            u.x = bounds.left;
        }
        if(u.y+u.height > bounds.bottom){
            u.y = bounds.bottom - u.height;
        }else if(u.y < bounds.top){
            u.y = bounds.top;
        }
    }


}
}
