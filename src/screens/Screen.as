package screens {
import starling.animation.IAnimatable;
import starling.animation.Juggler;
import starling.core.Starling;
import starling.display.Sprite;
import starling.events.Event;

public class Screen extends Sprite implements IAnimatable {
    protected var mJuggler:Juggler;

    public function Screen()
    {
        this.mJuggler = new Juggler();
        addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
    }
    public function onAddedToStage(event:Event):void
    {
        Starling.current.juggler.add(this);
    }
    public function advanceTime(seconds:Number):void
    {
        mJuggler.advanceTime(seconds);
        //trace(mJuggler.getObjectCount());
        subAdvanceTime(seconds);
    }
    public function subAdvanceTime(seconds:Number):void
    {
        /* Override me! */
    }
    public function getJuggler():Juggler
    {
        return mJuggler;
    }
    public function onRemovedFromStage(event:Event):void
    {
        Starling.current.juggler.remove(this);
    }
}
}