//Created by Action Script Viewer - http://www.buraks.com/asv
package com.gaiaonline.monster.view.components.whistleAlert {
    import flash.display.*;
    import flash.events.*;
    import org.osflash.signals.*;
    import alecmce.ui.*;
    import com.gaiaonline.monster.view.components.app.panel.*;

    public class WhistleAlertPrompt extends Panel {

        public var confirm:Signal;
        public var close:Signal;
        private var content:MovieClip;
        private var asset:Asset;

        public function WhistleAlertPrompt(_arg1:Asset){
            this.confirm = new Signal();
            this.close = new Signal();
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
            this.content.close.addEventListener(MouseEvent.CLICK, this.onClose);
        }
        private function onConfirm(_arg1:MouseEvent):void{
            this.confirm.dispatch();
        }
        private function onClose(_arg1:MouseEvent):void{
            this.close.dispatch();
        }

    }
}//package com.gaiaonline.monster.view.components.whistleAlert 
