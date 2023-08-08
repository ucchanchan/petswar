//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.recurringPrize {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import com.gaiaonline.monster.service.*;

    public class RecurringPrize extends Panel {

        private var _claimPrize:Signal;
        private var _timerComplete:Signal;
        private var _timerClick:Signal;
        private var content:MovieClip;
        private var asset:Asset;
        private var timer:Timer;
        private var timeLeft:Number;
        private var prompt:RecurringPrizePrompt;

        public function RecurringPrize(_arg1:Asset){
            this._timerComplete = new Signal();
            this._claimPrize = new Signal();
            this._timerClick = new Signal();
            this.asset = _arg1;
            addChild(this.asset.self);
            if (_arg1.complete){
                this.init();
            } else {
                _arg1.complete.add(this.init);
            };
        }
        private function init(_arg1:Asset=null):void{
            this.content = MovieClip(this.asset.content);
        }
        public function enablePrizeButton():void{
            this.disableHitState();
            this.content.timerMc.visible = false;
            this.content.claimPrize.visible = true;
            this.content.claimPrize.addEventListener(MouseEvent.CLICK, this.onClaim, false, 0, true);
        }
        public function setPrizeTimer(_arg1:Number):void{
            this.content.claimPrize.removeEventListener(MouseEvent.CLICK, this.onClaim, false);
            this.timeLeft = _arg1;
            this.content.timerMc.visible = true;
            this.content.timerMc.timerText.mouseEnabled = false;
            this.enableHitState();
            this.content.claimPrize.visible = false;
            this.timer = new Timer(1000, _arg1);
            this.timer.addEventListener(TimerEvent.TIMER, this.updatePrizeTimer, false, 0, true);
            this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onComplete, false, 0, true);
            this.timer.start();
            this.hideArrow();
        }
        private function enableHitState():void{
            var _local1:Sprite = this.content.timerMc.hit;
            _local1.mouseEnabled = true;
            _local1.buttonMode = true;
            _local1.useHandCursor = true;
            _local1.addEventListener(MouseEvent.CLICK, this.onTimerClick, false, 0, true);
        }
        private function disableHitState():void{
            var _local1:Sprite = this.content.timerMc.hit;
            _local1.mouseEnabled = false;
            _local1.buttonMode = false;
            _local1.useHandCursor = false;
            _local1.removeEventListener(MouseEvent.CLICK, this.onTimerClick, false);
        }
        private function onTimerClick(_arg1:MouseEvent):void{
            this._timerClick.dispatch(this.timeLeft);
        }
        public function addPrompt(_arg1:RecurringPrizePrompt):void{
            this.prompt = _arg1;
            addChild(_arg1);
        }
        public function removePrompt():void{
            if (((this.prompt) && (this.prompt.parent))){
                this.prompt.parent.removeChild(this.prompt);
            };
        }
        private function onComplete(_arg1:TimerEvent):void{
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER, this.updatePrizeTimer, false);
            this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onComplete, false);
            this.timer = null;
            this.enablePrizeButton();
            this.showArrow();
        }
        private function hideArrow():void{
            this.content.arrow.visible = false;
        }
        private function showArrow():void{
            this.content.arrow.visible = true;
        }
        private function updatePrizeTimer(_arg1:TimerEvent):void{
            this.timeLeft--;
            this.content.timerMc.timerText.text = Utils.formatTime(this.timeLeft);
        }
        private function onClaim(_arg1:MouseEvent):void{
            this._claimPrize.dispatch();
        }
        public function get claimPrize():Signal{
            return (this._claimPrize);
        }
        public function get timerComplete():Signal{
            return (this._timerComplete);
        }
        public function get timerClick():Signal{
            return (this._timerClick);
        }

    }
}//package com.gaiaonline.monster.view.components.recurringPrize 
