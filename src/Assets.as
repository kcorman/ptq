/**
 * Created by Goose on 8/16/14.
 */
package {
import flash.display.Bitmap;
import flash.utils.Dictionary;

import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class Assets {

    private static var gameTextures:Dictionary = new Dictionary();

    [Embed(source="../media/graphics/ptqSpriteSheet.png")]
    public static const AtlasTextureGame:Class;

    [Embed(source="../media/graphics/ptqSpriteSheet.xml", mimeType="application/octet-stream")]
    public static const AtlasXmlGame:Class;
    ////
//
    private static var gameTextureAtlas:TextureAtlas;

    public static function getAtlas():TextureAtlas{
        if(gameTextureAtlas == null){
            var texture:Texture = getTexture("AtlasTextureGame");
            var xml:XML = XML(new AtlasXmlGame());
            gameTextureAtlas = new TextureAtlas(texture, xml);
        }
        return gameTextureAtlas;
    }

    public static function getTexture(name:String):Texture{
        if(gameTextures[name] == undefined){
            var bitmap:Bitmap = new Assets[name];
            gameTextures[name] = Texture.fromBitmap(bitmap);
        }
        return gameTextures[name];
    }
    public function Assets() {
    }
}
}
