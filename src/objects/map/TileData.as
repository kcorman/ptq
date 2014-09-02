/**
 * Created by Goose on 8/31/14.
 */
package objects.map {
public class TileData {
    public var canBuild:Boolean = false;

    public var isWater:Boolean = false;

    public var isWalkable:Boolean = false;

    public var isLava:Boolean = false;

    public var isSpawner:Boolean = false;

    public var src:String = null;

    private var objectData:Object = null;

    public function TileData(data:Object) {
        objectData = data;
        for(var id:String in data){
            if(this.hasOwnProperty(id)){
                this[id] = data[id];
            }else{
                throw new Error("this did not contain property: "+id);
            }
        }
    }
}
}
