//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.win.parts {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import flash.text.*;

    public class LevelUpAnim extends BasicAnim implements Anim {

        private var name:uint;
        private var timer:Timer;
        private var clip:MovieClip;

        private static const NEW_LEVEL:String = "New Level: ";
        private static const NEW_LEVEL_TEXT:String = "newLevelText";
        private static const TEXT_BOX:String = "textBox";
        private static const DELAY:int = 3000;

        public function LevelUpAnim(_arg1:MovieClip, _arg2:uint){
            this.clip = _arg1;
            this.name = _arg2;
        }
        override public function play():void{
            var _local1:MovieClip = MovieClip(this.clip.getChildByName(NEW_LEVEL_TEXT));
            var _local2:TextField = TextField(_local1.getChildByName(TEXT_BOX));
            _local2.text = (NEW_LEVEL + this.name);
            this.clip.visible = true;
            this.clip.gotoAndPlay(1);
            this.timer = new Timer(DELAY, 1);
            this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this.timer.start();
        }
        private function onTimerComplete(_arg1:TimerEvent):void{
            this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this.timer = null;
            this.clip.gotoAndStop(1);
            this.clip.visible = false;
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.win.parts 
