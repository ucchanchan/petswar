//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.win.parts {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;
    import flash.text.*;

    public class NewSkillAnim extends BasicAnim implements Anim {

        private var name:String;
        private var timer:Timer;
        private var clip:MovieClip;

        private static const NEW_SKILL:String = "New Skill: ";
        private static const NEW_SKILL_TEXT:String = "newSkillText";
        private static const TEXT_BOX:String = "textBox";
        private static const DELAY:int = 3000;

        public function NewSkillAnim(_arg1:MovieClip, _arg2:String){
            this.clip = _arg1;
            this.name = _arg2;
        }
        override public function play():void{
            var _local1:MovieClip = MovieClip(this.clip.getChildByName(NEW_SKILL_TEXT));
            var _local2:TextField = TextField(_local1.getChildByName(TEXT_BOX));
            _local2.text = ((NEW_SKILL + this.name) + "!");
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
