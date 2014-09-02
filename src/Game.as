/**
 * Created by Goose on 8/16/14.
 */
package {
import events.NavigationEvent;

import screens.InGame;

import screens.Welcome;

import starling.display.Sprite;
import starling.events.Event;

public class Game extends Sprite{

    private var screenWelcome:Welcome;
    private var screenInGame:InGame;
    public function Game() {
        super();
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
    }

    public function onAddedToStage(event:Event) : void{
        trace("starling framework initialized");
        screenInGame = new InGame();
        //screenInGame.disposeTemporarily();
        //screenWelcome = new Welcome();
        //addChild(screenWelcome);
        this.addChild(screenInGame);
        //screenWelcome.initialize();
        screenInGame.initialize();
        addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
    }

    public function onChangeScreen(event:Event) : void{
        var action:String = NavigationEvent(event).params["id"];
        if(action == "play"){
            screenWelcome.disposeTemporarily();
            screenInGame.initialize();
        }
    }
}
}
