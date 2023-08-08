//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.starseedBasket.view.ui {
    import flash.display.*;
    import flash.events.*;
    import alecmce.ui.*;
    import org.osflash.signals.natives.*;

    public class StarseedBasket extends AssetWrapper {

        private var _click:NativeSignal;
        private var _rollover:NativeSignal;
        private var _rollout:NativeSignal;
        private var _seedCount:uint;// = 0
        private var _basket:MovieClip;

        private static const FULL_COUNT:uint = 5;

        public function StarseedBasket(_arg1:Asset){
            super(_arg1);
            mouseChildren = false;
            mouseEnabled = true;
            useHandCursor = true;
            buttonMode = true;
            this._click = new NativeSignal(this, MouseEvent.CLICK, MouseEvent);
            this._rollover = new NativeSignal(this, MouseEvent.ROLL_OVER, MouseEvent);
            this._rollout = new NativeSignal(this, MouseEvent.ROLL_OUT, MouseEvent);
            if (_arg1.isComplete){
                this.onLoadComplete(_arg1);
            } else {
                _arg1.complete.addOnce(this.onLoadComplete);
                _arg1.init();
            };
        }
        public function set seedCount(_arg1:uint):void{
            this._seedCount = _arg1;
            if (this._basket){
                this._basket.seedCount.text = this._seedCount.toString();
                this._basket.fullSeeds.visible = (FULL_COUNT <= this._seedCount);
                this._basket.halfSeeds.visible = (((0 < this._seedCount)) && ((this._seedCount < FULL_COUNT)));
            };
        }
        public function get click():NativeSignal{
            return (this._click);
        }
        public function get rollover():NativeSignal{
            return (this._rollover);
        }
        public function get rollout():NativeSignal{
            return (this._rollout);
        }
        private function onLoadComplete(_arg1:Asset):void{
            addChild(_arg1.self);
            this._basket = _arg1.content["basket"];
            this.seedCount = this._seedCount;
        }

    }
}//package com.gaiaonline.monster.view.components.starseedBasket.view.ui 
