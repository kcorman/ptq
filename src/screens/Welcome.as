/**
 * Created by Goose on 8/16/14.
 */
package screens {
import events.NavigationEvent;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;

public class Welcome extends starling.display.Sprite{
    private var bg:Image;

    private var title:Image;

    private var hero:Image;

    private var playBtn:Button;

    private var aboutBtn:Button;

    public function Welcome() {
        super();
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
    }

    public function onAddedToStage(event:Event) : void{
        drawScreen();
    }

    private function drawScreen():void{

        bg = new Image(Assets.getTexture("BgWelcome"));
        this.addChild(bg);
        title = new Image(Assets.getAtlas().getTexture("welcome_title"));
        title.x = 440;
        title.y = 20;
        this.addChild(title);
        hero = new Image(Assets.getAtlas().getTexture("welcome_hero"));
        hero.x = -hero.width;
        hero.y = 100;
        this.addChild(hero);
        playBtn = new Button(Assets.getAtlas().getTexture("welcome_playButton"));
        playBtn.x = 500;
        playBtn.y = 260;
        aboutBtn = new Button(Assets.getAtlas().getTexture("welcome_aboutButton"));
        aboutBtn.x = 410;
        aboutBtn.y = 380;
        addChild(playBtn);
        addChild(aboutBtn);
        this.addEventListener(Event.TRIGGERED, onMainMenuClick);
    }

    public function onMainMenuClick(event:Event) : void{
        if(event.target == playBtn){
            this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id:"play"}, true));
        }else if(event.target == aboutBtn){

        }
    }

    public function initialize():void{
        this.visible = true;
        hero.x = -hero.width;
        hero.y = 100;
        var tween:Tween = new Tween(hero, 2.0);
        tween.animate("x", hero.x + 50);
        Starling.juggler.add(tween);
        this.addEventListener(Event.ENTER_FRAME, heroAnimation);
    }

    public function heroAnimation(event:Event):void{
        var currentDate:Date = new Date();
        hero.y = Math.cos(currentDate.getTime() * 0.002) * 25 + 100;
        playBtn.y = Math.cos(currentDate.getTime() * 0.002) * 25 + 260;
        aboutBtn.y = Math.cos(currentDate.getTime() * 0.002) * 25 + 380;
    }

    public function disposeTemporarily() : void{
        this.visible = false;
        if(this.hasEventListener(Event.ENTER_FRAME)){
            this.removeEventListener(Event.ENTER_FRAME, heroAnimation);
        }
    }
}
}
