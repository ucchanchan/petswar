//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.whistleAlert {
    import flash.display.*;
    import flash.events.*;
    import com.gskinner.motion.*;
    import flash.utils.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;

    public class WhistleAlert extends Panel {

        private const DELAY:uint = 4000;
        private const Y_POS:uint = 130;

        private var asset:Asset;
        private var content:MovieClip;
        public var confirm:Signal;
        public var close:Signal;
        public var ready:Signal;
        private var timer:Timer;
        private var force:Boolean;

        public function WhistleAlert(_arg1:Asset, _arg2:Boolean){
            this.confirm = new Signal();
            this.close = new Signal();
            this.ready = new Signal();
            this.force = _arg2;
            this.asset = _arg1;
            addChild(this.asset.self);
            if (_arg1.isComplete){
                this.init();
            } else {
                _arg1.complete.add(this.init);
            };
        }
        private function init(_arg1:Asset=null):void{
            this.content = MovieClip(this.asset.content);
            this.content.confirm.addEventListener(MouseEvent.CLICK, this.onConfirm);
            this.content.bg.addEventListener(MouseEvent.CLICK, this.onRollOut);
            this.ready.dispatch();
            if (!this.force){
                this.timer = new Timer(this.DELAY, 1);
                this.timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onAnimate);
                this.timer.start();
            } else {
                this.onForce();
            };
        }
        private function onForce():void{
            y = this.Y_POS;
        }
        private function onAnimate(_arg1:TimerEvent):void{
            var _local2:GTween = new GTween(this.content, 1, {y:this.Y_POS});
        }
        public function removeAlert():void{
            if (this.parent.contains(this)){
                this.parent.removeChild(this);
            };
        }
        public function stopTimer():void{
            if (this.timer){
                this.timer.stop();
                this.timer = null;
            };
        }
        public function updateText(_arg1:uint):void{
            this.content.whistleCount.text = _arg1;
        }
        private function onConfirm(_arg1:MouseEvent):void{
            this.confirm.dispatch();
        }
        private function onRollOut(_arg1:MouseEvent):void{
            this.close.dispatch();
        }

    }
}//package com.gaiaonline.monster.view.components.whistleAlert 
