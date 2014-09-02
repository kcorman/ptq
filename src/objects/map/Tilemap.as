/**
 * Created by Goose on 8/31/14.
 */
package objects.map {
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.TextureSmoothing;

/**
 * A collection of tiles wrapped up into a single Sprite
 */
public class Tilemap extends starling.display.Sprite{
    //2D array of tiles for tilemap
    private var data:Vector.<Vector.<TileData>>;

    private var tilesize:uint;

    public function Tilemap(data:Vector.<Vector.<TileData>>, tilesize:uint = 32) {
        this.data = data;
        this.tilesize = tilesize;
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Event) : void{
        this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        drawMap();
    }

    private function drawMap() : void{
        var i:uint = 0, k:uint = 0;
        for each (var vec:Vector.<TileData> in data){
            k = 0;
            for each(var tile:TileData in vec){
                var img:Image = new Image(Assets.getAtlas().getTexture(tile.src));
                img.smoothing = TextureSmoothing.NONE;
                img.x = k * tilesize;
                img.y = i * tilesize;
                img.width = tilesize;
                img.height = tilesize;
                addChild(img);
                k++;
            }
            i++;
        }
    }
}
}
