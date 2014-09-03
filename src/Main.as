/**
 * Created by Goose on 8/16/14.
 */
package {
import flash.geom.Rectangle;


import flash.display.Sprite;

import screens.InGame;

import starling.core.Starling;

[SWF(frameRate="60", backgroundColor="0x333333")]
public class Main extends Sprite{
    public static var instance:Main;
    private var mStarling:Starling;
    public function Main() {
        super();
        instance = this;
        var screenWidth:int = stage.fullScreenWidth;
        var screenHeight:int = stage.fullScreenHeight;
        Starling.handleLostContext = true;

        var stageWidthToUse:int = 320;
        var stageHeightToUse:int = 480;
        //if(screenHeight === 1136) stageHeightToUse = 568;
        mStarling = new Starling(Game, stage, new Rectangle(0, 0, stageWidthToUse, stageHeightToUse));
        mStarling.showStats = true;
        mStarling.stage.stageWidth = stageWidthToUse;
        mStarling.stage.stageHeight = stageHeightToUse;
        mStarling.antiAliasing = 1;
        mStarling.start();
    }
}
}
