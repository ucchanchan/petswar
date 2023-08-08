//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.battle.fight.anims.simple {
    import flash.events.*;
    import flash.utils.*;
    import com.gaiaonline.monster.view.components.battle.fight.anims.generic.*;

    public class DelayAnim extends BasicAnim implements Anim {

        private var _timer:Timer;

        public function DelayAnim(_arg1:uint){
            this._timer = new Timer(_arg1, 1);
        }
        override public function play():void{
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this._timer.start();
        }
        private function onTimerComplete(_arg1:TimerEvent):void{
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
            this._timer = null;
            _complete.dispatch(this);
        }

    }
}//package com.gaiaonline.monster.view.components.battle.fight.anims.simple 
