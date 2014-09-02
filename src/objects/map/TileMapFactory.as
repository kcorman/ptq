/**
 * Created by Goose on 8/31/14.
 */
package objects.map {
/**
 * This class is used for generating tile maps on the fly
 */
public class TileMapFactory {

    private static const TILE_SIZE:uint = 32;

    public function TileMapFactory() {

    }

    public function generateMap(level:uint, width:uint=480, height:uint=320) : Tilemap {
        var data:Vector.<Vector.<TileData>> = new Vector.<Vector.<TileData>>();
        for(var i:int = 0;i<height/TILE_SIZE;i++){
            var top:Vector.<TileData> = new Vector.<TileData>();
            for(var k:int = 0;k<width/TILE_SIZE;k++){
                var src:String = "grass1";
                if(Math.random() > 0.2){
                    src = "grass2";
                }
                var d:TileData = new TileData({"canBuild" : true, "isWalkable" : true, "src" : src});
                top.push(d);
            }
            data.push(top);
        }
        return new Tilemap(data);
    }
}
}
