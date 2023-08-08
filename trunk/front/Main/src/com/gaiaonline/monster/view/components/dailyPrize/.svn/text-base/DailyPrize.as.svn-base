//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.dailyPrize {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;

    public class DailyPrize extends Panel {

        public var close:Signal;
        public var confirm:Signal;
        private var asset:Asset;
        private var content:MovieClip;

        public function DailyPrize(_arg1:Asset){
            this.close = new Signal();
            this.confirm = new Signal();
            this.asset = _arg1;
            addChild(_arg1.self);
            if (_arg1.isComplete){
                this.init();
            } else {
                _arg1.complete.addOnce(this.init);
            };
        }
        private function init(_arg1:Asset=null):void{
            this.content = MovieClip(_arg1.content).dailyPrize;
            this.content.confirm.addEventListener(MouseEvent.CLICK, this.onConfirm);
            this.content.close.addEventListener(MouseEvent.CLICK, this.onClose);
        }
        private function onConfirm(_arg1:MouseEvent):void{
            this.content.gotoAndStop("confirmation");
            this.confirm.dispatch();
            this.content.confirmClose.addEventListener(MouseEvent.CLICK, this.onClose);
        }
        private function onClose(_arg1:MouseEvent):void{
            this.close.dispatch();
        }
        public function onRemove():void{
            if (this.content.confirm){
                this.content.confirm.removeEventListener(MouseEvent.CLICK, this.onConfirm);
            };
            if (this.content.close){
                this.content.close.removeEventListener(MouseEvent.CLICK, this.onClose);
            };
        }

    }
}//package com.gaiaonline.monster.view.components.dailyPrize 
