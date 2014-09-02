/**
 * Created by Goose on 8/17/14.
 */
package events {
import starling.events.Event;

public class NavigationEvent extends Event{
    public static const CHANGE_SCREEN:String = "changeScreen";
    public var params:Object;

    public function NavigationEvent(name:String, params:Object = null, bubbles:Boolean = false) {
        super(name, bubbles);
        this.params = params;
    }
}
}
