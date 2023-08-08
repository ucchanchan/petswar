//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.home {
    import flash.events.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import com.gaiaonline.monster.model.*;

    public class NapTimer extends Timer {

        private var _time:uint;
        private var _napOver:Signal;
        private var _timeLeft:uint;
        private var _napUpdate:Signal;
        private var _model:MonsterModel;

        public function NapTimer(_arg1:int, _arg2:MonsterModel, _arg3:uint=1000){
            super(_arg3, _arg1);
            this._timeLeft = _arg1;
            this._napOver = new Signal();
            this._napUpdate = new Signal();
            this._model = _arg2;
            this._time = _arg3;
            this.initListener();
            start();
        }
        private function initListener():void{
            addEventListener(TimerEvent.TIMER, this.onUpdate, false, 0, true);
            addEventListener(TimerEvent.TIMER_COMPLETE, this.onComplete, false, 0, true);
        }
        private function onUpdate(_arg1:TimerEvent):void{
            this._timeLeft--;
            this._napUpdate.dispatch(this._timeLeft, this);
        }
        public function get napUpdate():Signal{
            return (this._napUpdate);
        }
        public function get timeLeft():uint{
            return (this._timeLeft);
        }
        public function get napOver():Signal{
            return (this._napOver);
        }
        private function onComplete(_arg1:TimerEvent):void{
            this._napOver.dispatch(this._model, this);
        }
        public function dispose(_arg1:Boolean=true):void{
            this._timeLeft = 0;
            removeEventListener(TimerEvent.TIMER, this.onUpdate);
            removeEventListener(TimerEvent.TIMER_COMPLETE, this.onComplete);
        }

    }
}//package com.gaiaonline.monster.view.components.home 
