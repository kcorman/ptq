/**
 * Created by Goose on 9/2/14.
 */
package objects {
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;

public class Hero extends Unit {
    private var touchX:Number;
    private var touchY:Number;
    private var elapsedTime:Number;
    private var currentTime:Number;
    private var isJumping:Boolean = false;
    private var oldY:Number;
    private var dy:Number = 0;

    public function Hero(x:Number=0, y:Number=0) {
        super();
        this.x = x;
        this.y = y;
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage(event:Event):void{
        this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        width = 24;
        height = 24;
        this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        stage.addEventListener(TouchEvent.TOUCH, onMouseClick);
        this.addEventListener(TouchEvent.TOUCH, onMouseClick);
    }

    private function onMouseClick(event:TouchEvent) : void{
        var t:Touch = event.getTouch(stage);
        if(t){
            touchX = t.globalX;
            touchY = t.globalY;
        }
    }

    private function onEnterFrame(event:Event) : void{
        var difU:Number = 0;
        var difD:Number = 0;
        var difL:Number = 0;
        var difR:Number = 0;
        if(touchX){
            x -= (x - touchX) * 0.01;
            difR = (touchX - x);
            difL = -difR;
        }
        if(touchY){
            y -= (y - touchY) * 0.01;
            difU = (y - touchY);
            difD = -difU;
        }
        var max:Number = Math.max(difU, difD, difL, difR);
        if(max == difU) facing = FACING_UP;
        if(max == difD) facing = FACING_DOWN;
        if(max == difR) facing = FACING_RIGHT;
        if(max == difL) facing = FACING_LEFT;
        if(max < 3){
            action = "stand";
        }else{
            action = "walk";
        }
        if(isJumping){
            dy += (GameConstants.GRAVITY * elapsedTime);
            y += (dy * elapsedTime);
            if(y >= oldY){
                y = oldY;
                isJumping = false;
                dy = 0;
            }
        }
        //if(y+heroArt.height > stage.stageHeight) y = stage.stageHeight - heroArt.height;
        //if(y < 0) y = 0;
    }
}
}
