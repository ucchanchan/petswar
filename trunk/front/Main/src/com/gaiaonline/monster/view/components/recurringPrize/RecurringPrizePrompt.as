//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.recurringPrize {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;
    import com.gaiaonline.monster.service.*;

    public class RecurringPrizePrompt extends Panel {

        private var asset:Asset;
        private var timeLeft:int;
        public var openShop:Signal;
        public var close:Signal;
        public var askForStarseeds:Signal;
        private var content:MovieClip;
        private var timer:Timer;

        public function RecurringPrizePrompt(_arg1:Asset, _arg2:int){
            this.asset = _arg1;
            this.addChild(this.asset.self);
            this.openShop = new Signal();
            this.askForStarseeds = new Signal();
            this.close = new Signal();
            if (_arg1.isComplete){
                this.init();
            } else {
                _arg1.complete.addOnce(this.init);
            };
            this.timeLeft = _arg2;
        }
        private function init(_arg1:Asset=null):void{
            this.content = MovieClip(this.asset.content);
            this.content.prompt.close.addEventListener(MouseEvent.CLICK, this.onClose, false, 0, true);
            this.content.prompt.shop.addEventListener(MouseEvent.CLICK, this.onShop, false, 0, true);
            this.content.prompt.askForStarseedsButton.addEventListener(MouseEvent.CLICK, this.onAskForStarseedClick, false, 0, true);
            this.timer = new Timer(1000, this.timeLeft);
            this.timer.addEventListener(TimerEvent.TIMER, this.updatePrizeTimer, false, 0, true);
            this.timer.start();
        }
        override public function dispose(_arg1:Boolean=true):void{
            this.content = MovieClip(this.asset.content);
            this.content.prompt.close.removeEventListener(MouseEvent.CLICK, this.onClose, false);
            this.content.prompt.shop.removeEventListener(MouseEvent.CLICK, this.onShop, false);
            this.content.prompt.askForStarseedsButton.removeEventListener(MouseEvent.CLICK, this.onAskForStarseedClick, false);
            if (this.timer){
                this.stopTimer();
            };
        }
        private function stopTimer():void{
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER, this.updatePrizeTimer, false);
            this.timer = null;
        }
        private function updatePrizeTimer(_arg1:TimerEvent):void{
            this.timeLeft--;
            this.content.prompt.time.text = Utils.formatTime(this.timeLeft);
        }
        private function onAskForStarseedClick(_arg1:MouseEvent):void{
            this.askForStarseeds.dispatch();
        }
        public function closePrompt():void{
            this.stopTimer();
        }
        private function onClose(_arg1:MouseEvent):void{
            this.close.dispatch();
        }
        private function onShop(_arg1:MouseEvent):void{
            this.openShop.dispatch();
        }

    }
}//package com.gaiaonline.monster.view.components.recurringPrize 
